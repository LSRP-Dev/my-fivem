function setupEventListeners() {
    window.addEventListener('message', handleWindowMessage);
}

function toggleUIElement(selector, displayStatus) {
    const element = document.querySelector(selector);
    if (element) {
        element.style.display = displayStatus ? 'block' : 'none';
    }
}

function togglePrisonUI(displayStatus) {
    toggleUIElement('.prison-time-container', displayStatus);
}

function toggleTutorialUI(displayStatus) {
    const tutorialContainer = document.querySelector('.tutorial-container');
    // Set default opacity to 0
    tutorialContainer.style.opacity = 0;

    // Assuming the element is considered visible when its opacity is greater than 0
    const isCurrentlyVisible = tutorialContainer.style.opacity > 0;

    if (displayStatus && !isCurrentlyVisible) {
        fadeElementInOut('.tutorial-container', 500, 1);
    } else if (!displayStatus && isCurrentlyVisible) {
        fadeElementInOut('.tutorial-container', 500, 0);
    }
    // Do nothing if the current visibility matches the desired status
}

function ToggleSecurityType(time, secType, scheduleType) {
    if (secType == "min") {
        document.querySelectorAll('.prison-time-image').forEach(element => element.style.display = 'none');
        document.querySelectorAll('.prison-time-background').forEach(element => element.style.border = '2px solid #2A95E4');
        document.querySelectorAll('.prison-time-divider').forEach(element => element.style.backgroundColor = '#2A95E4');
        document.querySelectorAll('.prison-time-text').forEach(element => element.textContent = time);
        document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = scheduleType);
    } else if (secType == "med") {
        document.querySelectorAll('.prison-time-image').forEach(element => element.style.display = 'none');
        document.querySelectorAll('.prison-time-background').forEach(element => element.style.border = '2px solid #FF8A00');
        document.querySelectorAll('.prison-time-divider').forEach(element => element.style.backgroundColor = '#FF8A00');
        document.querySelectorAll('.prison-time-text').forEach(element => element.textContent = time);
        document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = 'Free Time');
        document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = scheduleType);
    } else if (secType == "max") {
        document.querySelectorAll('.prison-time-image').forEach(element => element.style.display = 'none');
        document.querySelectorAll('.prison-time-background').forEach(element => element.style.border = '2px solid #5C0000');
        document.querySelectorAll('.prison-time-divider').forEach(element => element.style.backgroundColor = '#5C0000');
        document.querySelectorAll('.prison-time-text').forEach(element => element.textContent = time);
        document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = scheduleType);
    }
}

let currentState = ''; // Tracks the current state of the UI

function handleTutorialState(text) {
    document.querySelector('.tutorial-text').textContent = text;
}

function handleWindowMessage(event) {
    const { type, ...data } = event.data;
    switch (type) {
        case 'lockdown':
            document.querySelectorAll('.prison-time-background').forEach(element => element.style.border = '2px solid red');
            document.querySelectorAll('.prison-time-divider').forEach(element => element.style.backgroundColor = 'red');
            document.querySelectorAll('.prison-time-image').forEach(element => element.src = 'images/bars.png');
            document.querySelectorAll('.prison-time-text').forEach(element => element.textContent = data.time);
            document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = data.scheduleType);
            document.querySelectorAll('.prison-time-image').forEach(element => element.style.display = 'block');
            togglePrisonUI(true)
            break;
        case 'recovery':
            document.querySelectorAll('.prison-time-background').forEach(element => element.style.border = '2px solid #96FB47');
            document.querySelectorAll('.prison-time-divider').forEach(element => element.style.backgroundColor = '#96FB47');
            document.querySelectorAll('.prison-time-image').forEach(element => element.src = 'images/heal.png');
            document.querySelectorAll('.prison-time-text').forEach(element => element.textContent = data.time);
            document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = data.scheduleType);
            document.querySelectorAll('.prison-time-image').forEach(element => element.style.display = 'block');
            togglePrisonUI(true)
            break;
        case 'normal':
            if (data.secType !== 'none') {
                ToggleSecurityType(data.time, data.secType, data.scheduleType)
                togglePrisonUI(true)
            }
            break;
        case "release":
            document.querySelectorAll('.prison-time-background').forEach(element => element.style.border = '2px solid #FBF447');
            document.querySelectorAll('.prison-time-divider').forEach(element => element.style.backgroundColor = '#FBF447');
            document.querySelectorAll('.prison-time-image').forEach(element => element.src = 'images/release.png');
            document.querySelectorAll('.prison-time-text').forEach(element => element.textContent = data.time);
            document.querySelectorAll('.prison-schedule-type').forEach(element => element.textContent = data.scheduleType);
            document.querySelectorAll('.prison-time-image').forEach(element => element.style.display = 'block');
            togglePrisonUI(true)
            break;
        case "freedom":
            togglePrisonUI(false)
            break;
        case "showTutorial":
            toggleTutorialUI(true)
            document.querySelector('.tutorial-text').textContent = data.stateText;
            break;
        case "hideTutorial":
            toggleTutorialUI(false)
            break;
    }
}

function adjustFontSizeToFit(containerSelector, textSelector) {
    const container = document.querySelector(containerSelector);
    const text = document.querySelector(textSelector);
    let fontSize = parseFloat(window.getComputedStyle(text, null).getPropertyValue('font-size'));

    // Reduce font size until the text fits the container or reaches a minimum size
    while (text.scrollHeight > container.offsetHeight && fontSize > 8) { // Minimum font size of 10px
        fontSize--;
        text.style.fontSize = `${fontSize}px`;
    }
}

function fadeElementInOut(elementSelector, duration = 500, finalOpacity = 1) {
    const element = document.querySelector(elementSelector);
    if (!element) return;

    // Ensure the element is displayed so it can fade in, but don't immediately hide it if fading out
    element.style.display = 'block';

    // Start the fade out or reset opacity for fade in as soon as possible
    requestAnimationFrame(() => {
        element.style.transition = `opacity ${duration}ms`;
        element.style.opacity = 0;

        // Wait for the next animation frame to start the fade in
        requestAnimationFrame(() => {
            // Wait for fade out to complete or start fade in immediately after reset
            setTimeout(() => {
                element.style.opacity = finalOpacity;
                // After the transition, set display to none if faded out
                if (finalOpacity === 0) {
                    setTimeout(() => {
                        element.style.display = 'none';
                    }, duration);
                }
            }, 10); // A short delay to ensure the opacity change is detected as a transition
        });
    });
}


// Call the function with the appropriate selectors
adjustFontSizeToFit('.tutorial-container', '.tutorial-text');





togglePrisonUI(false)
toggleTutorialUI(false)
// Initialize Event Listeners
setupEventListeners();

