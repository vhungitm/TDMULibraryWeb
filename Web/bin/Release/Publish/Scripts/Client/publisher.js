var publisherController = {
    init: function () {
        publisherController.loadData();
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
                        publisherController.regisBorrow(id);
                    }
                }
            });
        })
    },

    // Get link
    getLink: function () {
        let link = `/nha-xuat-ban/${config.publisher.id}`;
        link += config.page.index > 1 ? `?page=${config.page.index}` : '';

        history.pushState({}, '', link);
    },

    // Load data
    loadData: function () {
        $.ajax({
            url: '/API/Book/Gets',
            data: {
                status: 1,
                publisher: config.publisher.id,
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

                    publisherController.showData(html, totalPages);
                    return;
                }

                publisherController.showData();
            },
            error: function () {
                publisherController.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let newBook = $('#books');

        newBook.html(html ? html : '<div class="alert alert-danger">Không có sách!</div>');
        publisherController.paging(totalPages ? totalPages : 1);
        publisherController.registerEvent();
        publisherController.getLink();
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
                            publisherController.loadData();
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
                    } else if (status == -2) {
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
    }
};

publisherController.init();