var statistic = {
    init: function () {
        statistic.loadFilter();
        statistic.loadData();
    },
    registerEvent: function () {
        // Filter
        $('#slType').off('change').on('change', function () {
            let type = $(this).find('option:selected').val();

            $(`.dropdown[for="slMonth"]`).parent('div.col-lg-2').attr('style', type == 1 ? '' : 'display: none ;');
        });
        $('#btnStatistic').off('click').on('click', function () {
            statistic.filter();
        });
        $('#btnReset').off('click').on('click', function () {
            statistic.reset();
        });
    },

    // LoadStatistic
    loadFilter: function () {
        $('#filter').html($('#filterContent').html())

        let startDate = config.startDate.split('-');

        selectpicker.setSelected('slType', config.type, true);
        selectpicker.setSelected('slMonth', startDate[1], true);
        selectpicker.setSelected('slYear', startDate[0], true);

        $('.dropdown.selectpicker[for="slMonth"]').parent('div.col-lg-2').hide();
    },
    filter: function () {
        let type = $('#slType option:selected').val();
        let year = $('#slYear option:selected').val();
        let month = $('#slMonth option:selected').val();
        let startDate = year + '-' + month + '-1';

        config.type = type;
        config.startDate = startDate;
        statistic.loadData();
    },
    reset: function () {
        let now = new Date();
        let strNow = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate();

        config.startDate = strNow;
        config.endDate = strNow;
        config.type = 2;

        statistic.loadFilter();
        statistic.loadData();
    },

    // Load data
    loadData: function () {
        statistic.loadChart();
    },

    // Load chart
    getChartLabels: function (data) {
        let labels = [];

        for (let i = 0; i < data.length; i++) {
            let date = config.startDate.split('-');

            let label = (config.type == 2 ? ((i + 1) + '/' + date[0]) : ((i + 1) + '/' + date[1] + date[0]));
            labels.push(label);
        }

        return labels;
    },
    getMaxBorrowQuantity: function (data) {
        let max = 0;

        for (let i = 0; i < data.length; i++) {
            if (data[i] > max) {
                max = data[i];
            }
        }

        return max;
    },
    loadChartData: function (data) {
        let labels = statistic.getChartLabels(data);
        let maxQuantity = statistic.getMaxBorrowQuantity(data);

        Chart.defaults.global.defaultFontColor = '#111';

        function number_format(number, decimals, dec_point, thousands_sep) {

            number = (number + '').replace(',', '').replace(' ', '');
            var n = !isFinite(+number) ? 0 : +number,
                prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
                sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
                dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
                s = '',
                toFixedFix = function (n, prec) {
                    var k = Math.pow(10, prec);
                    return '' + Math.round(n * k) / k;
                };

            s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
            if (s[0].length > 3) {
                s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
            }
            if ((s[1] || '').length < prec) {
                s[1] = s[1] || '';
                s[1] += new Array(prec - s[1].length + 1).join('0');
            }
            return s.join(dec);
        }

        var ctx = document.getElementById("dataChart");
        var myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: "Số Lượng",
                    lineTension: 0.3,
                    backgroundColor: "rgba(78, 115, 223, 0.05)",
                    borderColor: "rgba(78, 115, 223, 1)",
                    pointRadius: 3,
                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointBorderColor: "rgba(78, 115, 223, 1)",
                    pointHoverRadius: 3,
                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                    pointHitRadius: 10,
                    pointBorderWidth: 2,
                    data: data
                }],
            },
            options: {
                maintainAspectRatio: false,
                layout: {
                    padding: {
                        left: 10,
                        right: 25,
                        top: 25,
                        bottom: 0
                    }
                },
                scales: {
                    xAxes: [{
                        time: {
                            unit: 'date'
                        },
                        gridLines: {
                            display: false,
                            drawBorder: false
                        },
                        ticks: {
                            maxTicksLimit: 12
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            maxTicksLimit: (maxQuantity > 5 ? 5 : maxQuantity),
                            padding: 10,

                            callback: function (value, index, values) {
                                return number_format(value) + " Cuốn";
                            }
                        },
                        gridLines: {
                            color: "rgb(234, 236, 244)",
                            zeroLineColor: "rgb(234, 236, 244)",
                            drawBorder: false,
                            borderDash: [2],
                            zeroLineBorderDash: [2]
                        }
                    }],
                },
                legend: {
                    display: false
                },
                tooltips: {
                    backgroundColor: "rgb(255,255,255)",
                    bodyFontColor: "#858796",
                    titleMarginBottom: 10,
                    titleFontColor: '#6e707e',
                    titleFontSize: 16,
                    borderColor: '#dddfeb',
                    borderWidth: 1,
                    xPadding: 15,
                    yPadding: 15,
                    displayColors: false,
                    intersect: false,
                    mode: 'index',
                    caretPadding: 10,
                    callbacks: {
                        label: function (tooltipItem, chart) {
                            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
                            return datasetLabel + ': ' + number_format(tooltipItem.yLabel) + " Cuốn";
                        }
                    }
                }
            }
        });
    },
    loadChart: function () {
        $.ajax({
            url: '/API/Borrow/GetQuantity',
            data: {
                startDate: config.startDate,
                endDate: config.endDate,
                type: config.type
            },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    let maxQuantity = statistic.getMaxBorrowQuantity(data);

                    if (maxQuantity > 0) {
                        $('#statistic').html($('#statisticContent').html());
                        $('#chart').html($('#chartContent').html());

                        statistic.loadChartData(data);
                        statistic.loadTopBook();
                        statistic.loadTopStudent();
                        statistic.registerEvent();
                    } else {
                        $('#statistic').html('<div class="alert alert-danger">Không có cuốn sách nào được mượn trong khoảng thời gian này!</div>');
                    }
                } else {
                    $('#statistic').html('<div class="alert alert-danger">Không có cuốn sách nào được mượn trong khoảng thời gian này!</div>');
                }
            }
        });
    },

    // Load top book
    loadTopBook: function () {
        $.ajax({
            url: '/API/Borrow/GetTopBook',
            data: {
                startDate: config.startDate,
                endDate: config.endDate,
                type: config.type
            },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    let html = '';
                    let template = $('#topBookItem').html();

                    $.each(data, function (i, item) {
                        html += Mustache.render(template, {
                            Top: i + 1,
                            Id: item.Id,
                            Image: item.Image,
                            Title: item.Title,
                            Quantity: item.Quantity
                        });
                    });

                    $('#topBookTable').html(html);
                }
            },
            error: function () {

            }
        });
    },

    // Load top student
    loadTopStudent: function () {
        $.ajax({
            url: '/API/Borrow/GetTopStudent',
            data: {
                startDate: config.startDate,
                endDate: config.endDate,
                type: config.type
            },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    let html = '';
                    let template = $('#topStudentItem').html();

                    $.each(data, function (i, item) {
                        html += Mustache.render(template, {
                            Top: i + 1,
                            Id: item.Id,
                            Avatar: item.Avatar,
                            FullName: item.FullName,
                            ClassName: item.ClassName,
                            Quantity: item.Quantity
                        });
                    });

                    $('#topStudentTable').html(html);
                }
            },
            error: function () {

            }
        });
    }
}

statistic.init();