const rulettPanel = new Vue({
    el: "#rulettPanel",
    data: {
        opened: false,

        currentChips: 0,
        betAmount: 0,
        gameInfo: {
            header: null,
            szoveg: null
        }
    },
    methods: {
        formatMoney: function (n, c, d, t) {
            var c = isNaN((c = Math.abs(c))) ? 2 : c,
                d = d == undefined ? "." : d,
                t = t == undefined ? "," : t,
                s = n < 0 ? "-" : "",
                i = String(parseInt((n = Math.abs(Number(n) || 0).toFixed(c)))),
                j = (j = i.length) > 3 ? j % 3 : 0;
            return (
                s +
                (j ? i.substr(0, j) + t : "") +
                i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) +
                (c ?
                    d +
                    Math.abs(n - i)
                        .toFixed(c)
                        .slice(2) :
                    "")
            );
        }
    }
});

const self = rulettPanel;

window.addEventListener('message', (event) => {
    if (event.data.action == 'showRulettNui') {
        self.opened = event.data.state;
    }
    else if (event.data.action == 'setCurrentChips') {
        self.currentChips = event.data.amount;
    }
    else if(event.data.action == 'setBetAmount') {
        self.betAmount = event.data.amount;
    }
    else if(event.data.action == 'setGameInfo') {
        self.gameInfo.header = event.data.header;
        self.gameInfo.szoveg = event.data.szoveg;
    }
});