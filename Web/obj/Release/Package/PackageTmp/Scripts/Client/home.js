var homeController = {
    init: function () {
        homeController.loadFilter();
        homeController.loadData();
    },

    registerEvent: function () {
        $('.btnRegisBorrow').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Đăng Ký Mượn",
                message: "Đăng ký mượn cuốn sách này?",
                buttons: {
                    cancel: {
                        className: 'btn btn-secondary btn-icon-split',
                        label: '<span class="icon text-white-50"><i class="fa fa-times"></i></span><span class="text">Hủy</span>'
                    },
                    confirm: {
                        className: 'btn btn-primary btn-icon-split',
                        label: '<span class="icon text-white-50"><i class="fa fa-check"></i></span><span class="text">Đồng ý</span>'
                    }
                },
                callback: function (result) {
                    if (result) {
                        homeController.regisBorrow(id);
                    }
                }
            });
        });

        $('#frmFilter').off('submit').on('submit', function (e) {
            e.preventDefault();
            homeController.filter();
        });
        $('#btnResetFilter').off('click').on('click', function () {
            homeController.reset();
        });
        $('#slPageSize').off('change').on('change', function () {
            $('#lblPageSize').text($(this).val())
        });
    },

    // Get link
    getLink: function () {
        let link = '/Index';
        link += config.category.id != '' ? `&category=${config.category.id}` : '';
        link += config.publisher.id != '' ? `&publisher=${config.publisher.id}` : '';
        link += config.publishYear > 0 ? `&publishYear=${config.publishYear}` : '';
        link += config.page.index > 1 ? `&page=${config.page.index}` : '';
        link += config.page.size > 6 ? `&pageSize=${config.page.size}` : '';

        link = link.replace('Index&', 'Index?');

        history.pushState({}, '', link);
    },

    // filter
    loadFilter: function () {
        let html = $('#filterContent').html();

        $('#filter').html(html);

        homeController.loadCategories('slCategory', config.category.id, config.category.name);
        homeController.loadPublisher('slPublisher', config.publisher.id, config.publisher.name);
        selectpicker.setSelected('slPublishYear', config.publishYear, config.publishYear); 
    },
    reset: function () {
        config.category = {
            id: '',
            name: 'Tất cả thể loại'
        };

        config.publisher = {
            id: '',
            name: 'Tất cả nhà xuất bản'
        };

        config.publishYear = 0;
        config.page.index = 1;
        config.page.size = 6;
        config.page.total = 1;

        homeController.loadFilter();
        homeController.loadData();
    },
    filter: function () {
        config.category.id = $('#slCategory option:selected').val();
        config.category.name = $('#slCategory option:selected').text();

        config.publisher.id = $('#slPublisher option:selected').val();
        config.publisher.name = $('#slPublisher option:selected').text();

        config.publishYear = $('#slPublishYear option:selected').val();

        config.page.index = 1;
        config.page.size = $('#slPageSize').val();


        homeController.loadData();
    },

    // Load data
    loadData: function () {
        $.ajax({
            url: '/API/Book/Gets',
            data: {
                category: config.category.id,
                publisher: config.publisher.id,
                publishYear: config.publishYear,
                status: 1,
                page: config.page.index,
                pageSize: config.page.size
            },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data.length > 0) {
                    let totalRow = response.totalRow;
                    let totalPages = Math.ceil(totalRow / config.page.size);

                    let template = $('#bookItem').html();
                    let html = '';

                    $.each(data, function (i, item) {

                        html += Mustache.render(template, {
                            Id: item.Id,
                            Title: item.Title,
                            MetaTitle: item.MetaTitle,
                            CategoryMetaTitle: item.CategoryMetaTitle,
                            Image: item.Image
                        });
                    });

                    homeController.showData(html, totalPages);
                    return;
                }

                homeController.showData();
            },
            error: function () {
                homeController.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let newBook = $('#books');

        newBook.html(html ? html : '<div class="alert alert-danger">Không có sách!</div>');
        homeController.paging(totalPages ? totalPages : 1);
        homeController.registerEvent();
        homeController.getLink();
    },
    paging: function (totalPages) {
        if (totalPages != config.page.total) {
            config.page.total = totalPages;
            config.page.index = config.page.index > totalPages ? totalPages : config.page.index;

            $('#pagination').removeData('twbs-pagination');
            $('#pagination').html('');

            if (totalPages > 1) {
                $('#pagination').twbsPagination({
                    totalPages: config.page.total,
                    first: 'Đầu',
                    last: 'Cuối',
                    prev: 'Trước',
                    next: 'Tiếp',
                    startPage: config.page.index,

                    onPageClick: function (event, page) {
                        $('#lblPagination').text(`Trang ${page}/${config.page.total}`).show();

                        if (page != config.page.index) {
                            config.page.index = page;
                            homeController.loadData();
                        }
                    }
                });
            } else {
                $('#lblPagination').hide();
            }
        }
    },

    // Regis borrow
    regisBorrow: function (id) {
        if (config.user.username != '') {
            let today = new Date();
            let day = today.getDate();
            let month = today.getMonth() + 1;
            let year = today.getFullYear();
            let borrowDate = `${year}-${month}-${day}`;

            let model = {
                studentId: config.user.username,
                staffId: 'NV001',
                bookId: id,
                borrowDate: borrowDate,
                status: -1
            };

            $.ajax({
                url: '/API/Borrow/Insert',
                data: model,
                type: 'POST',
                dataType: 'JSON',
                success: function (response) {
                    let status = response.status;

                    if (status == 1) {
                        bootbox.alert({ message: 'Đăng ký mượn thành công!' });
                    } else if (status == -1) {
                        bootbox.alert({ message: 'Đăng ký mượn không thành công! Sinh viên đang mượn hoặc đã đăng ký mượn cuốn sách này!' });
                    } else if ( status == -2) {
                        bootbox.alert({ message: 'Đăng ký mượn không thành công! Số lượng trong kho không đủ!' });
                    } else {
                        bootbox.alert({ message: 'Đăng ký mượn không thành công!' });
                    }
                },
                error: function () {
                    bootbox.alert({ message: 'Đăng ký mượn không thành công!' });
                }
            })
        } else {
            bootbox.confirm({
                message: 'Vui lòng đăng nhập để đăng ký mượn sách!<br/>Chuyển ngay đến trang đăng nhập',
                buttons: {
                    cancel: {
                        className: 'btn btn-secondary btn-icon-split',
                        label: '<span class="icon"><i class="fas fa-times"></i></span><span class="text">Hủy</span>'
                    },
                    confirm: {
                        className: 'btn btn-primary btn-icon-split',
                        label: '<span class="icon"><i class="fas fa-check"></i></span><span class="text">Đồng ý</span>'
                    }
                },
                callback: function (result) {
                    if (result) {
                        localStorage.setItem("bookId", id);
                        location = '/dang-nhap';
                    }
                }
            });
        }
    },

    loadCategories: function (id, value, text) {
        let html = $(`#${id}`).html();

        $(`#${id}`).html(`<option value="${value}">${text}</option>`);
        selectpicker.load(`${id}`);

        $.ajax({
            url: '/API/Category/Gets',
            data: { page: 0 },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data) {
                    $.each(data, function (i, item) {
                        let ipValue = item.MetaTitle;
                        let ipSelected = item.MetaTitle == value ? 'selected' : '';
                        let ipText = item.Name;

                        html += `
                            <option value="${ipValue}" ${ipSelected}>
                                ${ipText}
                            </option>`
                    });

                    $(`#${id}`).html(html);
                    selectpicker.load(`${id}`);
                }
            }
        });
    },

    loadPublisher: function (id, value, text) {
        let html = $(`#${id}`).html();

        $(`#${id}`).html(`<option value="${value}">${text}</option>`);
        selectpicker.load(`${id}`);

        $.ajax({
            url: '/API/Publisher/Gets',
            data: { page: 0 },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data) {
                    $.each(data, function (i, item) {
                        let ipValue = item.MetaTitle;
                        let ipSelected = item.MetaTitle == value ? 'selected' : '';
                        let ipText = item.Name;

                        html += `
                            <option value="${ipValue}" ${ipSelected}>
                                ${ipText}
                            </option>`
                    });

                    $(`#${id}`).html(html);
                    selectpicker.load(`${id}`);
                }
            }
        });
    }
};

homeController.init();