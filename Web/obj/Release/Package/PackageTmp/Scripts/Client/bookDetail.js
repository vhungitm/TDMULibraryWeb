var bookDetailController = {
    init: function () {
        bookDetailController.registerEvent();
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
                        bookDetailController.regisBorrow(id);
                    }
                }
            });
        })
    },

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

bookDetailController.init();