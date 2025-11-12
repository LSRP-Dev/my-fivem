return {
    dealers = {
        {
            name = 'tuner',
            label = 'Tuner Alley Plug',
            coords = vec4(154.56, -3014.47, 7.04, 269.87),
            blip = {
                enabled = true,
                sprite = 514,
                colour = 25,
                scale = 0.85,
                label = 'Illicit Supplier'
            },
            ped = {
                model = `g_m_m_cartelguards_01`,
                scenario = 'WORLD_HUMAN_SMOKING'
            },
            hours = { start = 20, stop = 5 },
            products = 'default'
        }
    },
    deliveryItems = {
        {
            item = 'weed_brick',
            minrep = 0,
            payout = 1250
        },
        {
            item = 'coke_brick',
            minrep = 50,
            payout = 2000
        },
        {
            item = 'meth_brick',
            minrep = 150,
            payout = 2750
        },
    }
}