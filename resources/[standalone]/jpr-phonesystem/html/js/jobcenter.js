(() => {
    const root = document.querySelector('.app-emprego');
    if (!root) {
        return;
    }

    const state = {
        jobs: [],
        currentJob: null,
        loading: false,
        visible: false,
        pendingJobId: null,
    };

    const selectors = {
        list: () => document.getElementById('jobcenter-list'),
        loading: () => document.getElementById('jobcenter-loading'),
        empty: () => document.getElementById('jobcenter-empty'),
        toast: () => document.getElementById('jobcenter-toast'),
        current: () => document.getElementById('jobcenter-current-job'),
    };

    const iconFallback = 'fa-solid fa-location-dot';

    const setToast = (message, status) => {
        const toast = selectors.toast();
        if (!toast) {
            return;
        }

        if (!message || message === '') {
            toast.style.display = 'none';
            toast.textContent = '';
            toast.className = 'jobcenter-toast';
            return;
        }

        toast.textContent = message;
        toast.style.display = 'block';

        toast.className = 'jobcenter-toast';
        if (status === 'error') {
            toast.classList.add('error');
        } else if (status === 'job') {
            toast.classList.add('success');
        } else {
            toast.classList.add('info');
        }
    };

    const setLoading = (flag) => {
        state.loading = flag;
        const loadingEl = selectors.loading();
        const list = selectors.list();
        const empty = selectors.empty();

        if (loadingEl) {
            loadingEl.style.display = flag ? 'block' : 'none';
        }

        if (flag) {
            if (list) list.innerHTML = '';
            if (empty) empty.style.display = 'none';
        }
    };

    const updateCurrentJobLabel = () => {
        const currentEl = selectors.current();
        if (!currentEl) return;

        const label = state.currentJob && (state.currentJob.label || state.currentJob.name);
        currentEl.textContent = label ? `Currently: ${label}` : 'Currently: Civilian';
    };

    const applyJob = (jobId) => {
        if (!jobId) return;

        state.pendingJobId = jobId;
        renderJobs();

        $.post('https://jpr-phonesystem/jobcenter:apply', JSON.stringify({ jobId }));
    };

    const createCard = (job) => {
        const card = document.createElement('div');
        card.className = 'jobcenter-card';
        card.dataset.jobId = job.id;

        const iconWrapper = document.createElement('div');
        iconWrapper.className = 'jobcenter-card-icon';

        const icon = document.createElement('i');
        icon.className = job.icon || iconFallback;
        iconWrapper.appendChild(icon);
        card.appendChild(iconWrapper);

        const body = document.createElement('div');
        body.className = 'jobcenter-card-body';

        const header = document.createElement('div');
        header.className = 'jobcenter-card-header';

        const title = document.createElement('h2');
        title.textContent = job.label;
        header.appendChild(title);

        if (job.type === 'activity') {
            const badge = document.createElement('span');
            badge.className = 'jobcenter-tag activity';
            badge.textContent = 'Activity';
            header.appendChild(badge);
        } else {
            const badge = document.createElement('span');
            badge.className = 'jobcenter-tag job';
            badge.textContent = job.isCurrent ? 'Current Job' : 'Career';
            header.appendChild(badge);
        }

        body.appendChild(header);

        if (job.description) {
            const description = document.createElement('p');
            description.textContent = job.description;
            body.appendChild(description);
        }

        const footer = document.createElement('div');
        footer.className = 'jobcenter-card-footer';

        const button = document.createElement('button');
        button.className = 'jobcenter-action';

        const isPending = state.pendingJobId === job.id;
        if (job.type === 'activity') {
            button.textContent = isPending ? 'Setting GPS...' : 'Set GPS';
        } else if (job.isCurrent) {
            button.textContent = 'Already Assigned';
            button.disabled = true;
        } else {
            button.textContent = isPending ? 'Assigning...' : 'Apply';
        }

        if (isPending) {
            button.disabled = true;
        }

        button.addEventListener('click', () => applyJob(job.id));
        footer.appendChild(button);

        if (job.coords && typeof job.coords.x === 'number' && typeof job.coords.y === 'number') {
            const location = document.createElement('span');
            location.className = 'jobcenter-location';
            location.textContent = `GPS: ${job.coords.x.toFixed(1)}, ${job.coords.y.toFixed(1)}`;
            footer.appendChild(location);
        }

        body.appendChild(footer);
        card.appendChild(body);

        return card;
    };

    const renderJobs = () => {
        const list = selectors.list();
        const empty = selectors.empty();
        if (!list || !empty) return;

        list.innerHTML = '';

        if (!state.jobs.length) {
            empty.style.display = state.loading ? 'none' : 'block';
            return;
        }

        empty.style.display = 'none';
        state.jobs.forEach((job) => {
            list.appendChild(createCard(job));
        });
    };

    const markCurrentJob = (jobName) => {
        if (!jobName) return;
        state.jobs = state.jobs.map((job) =>
            Object.assign({}, job, {
                isCurrent: job.job && job.job === jobName,
            })
        );
    };

    const syncAndRender = (data) => {
        state.jobs = Array.isArray(data.jobs) ? data.jobs : [];
        state.currentJob = data.currentJob || state.currentJob;
        updateCurrentJobLabel();
        renderJobs();
    };

    const fetchJobs = () => {
        setToast('');
        setLoading(true);

        $.post('https://jpr-phonesystem/jobcenter:fetch', JSON.stringify({}), function (response) {
            setLoading(false);
            syncAndRender(response || {});
        });
    };

    const observer = new MutationObserver(() => {
        const isVisible = window.getComputedStyle(root).display !== 'none';
        if (isVisible && !state.visible) {
            state.visible = true;
            fetchJobs();
        } else if (!isVisible && state.visible) {
            state.visible = false;
            state.pendingJobId = null;
            setToast('');
        }
    });

    observer.observe(root, { attributes: true, attributeFilter: ['style', 'class'] });

    window.addEventListener('message', (event) => {
        const data = event.data || {};

        if (data.action === 'jobcenter:result') {
            state.pendingJobId = null;

            if (data.payload) {
                if (data.payload.job && data.payload.job.name) {
                    state.currentJob = {
                        name: data.payload.job.name,
                        label: data.payload.job.label,
                    };
                    markCurrentJob(data.payload.job.name);
                    updateCurrentJobLabel();
                }

                setToast(data.payload.message, data.payload.status);
            }

            renderJobs();
        }

        if (data.action === 'jobcenter:updateJob' && data.payload && data.payload.job) {
            state.currentJob = {
                name: data.payload.job.name,
                label: data.payload.job.label,
            };
            markCurrentJob(data.payload.job.name);
            updateCurrentJobLabel();
            renderJobs();
        }
    });
})();

