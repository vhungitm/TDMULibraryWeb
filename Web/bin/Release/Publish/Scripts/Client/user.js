var userController = {
    init: function () {
        userController.registerEvent();
        userController.loadData();
    },

    registerEvent: function () {
        $('#btnLogin').off('click').on('click', function () {
            userController.login();
        });
        $('#frmLogin').validate({
            rules: {
                txtUsername: { required: true },
                txtPassword: { required: true }
            },
            messages: {
                txtUsername: { required: 'Vui lòng nhập tài khoản' },
                txtPassword: { required: 'Vui lòng nhập mật khẩu' }
            }
        });
        $('#btnLogout').off('click').on('click', function (e) {
            e.preventDefault();

            bootbox.confirm({
                message: "Đăng xuất khỏi hệ thống?",
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
                        userController.logout();
                    }
                }
            });
        });
    },
    loadData: function () {
        let data = JSON.parse(localStorage.getItem('User'));

        if (data != null) {
            $('#txtUsername').val(data.username);
            $('#txtPassword').val(data.password);
            $('#ckbRemember').prop('checked', true);
        }
    },
    /* Login */
    login: function () {
        if ($('#frmLogin').valid()) {
            var username = $('#txtUsername').val();
            var password = $('#txtPassword').val();
            var remember = $('#ckbRemember').prop('checked');

            $.ajax({
                url: '/API/User/Login',
                data: {
                    username: username,
                    password: password,
                },
                type: 'POST',
                dataType: 'JSON',
                success: function (response) {
                    if (response.status == 1) {
                        if (remember) {
                            let data = {
                                username: username,
                                password: password
                            };

                            localStorage.setItem("User", JSON.stringify(data));
                            console.log(localStorage.getItem('User'))
                        } else {
                            if (localStorage.getItem("User"))
                                localStorage.removeItem("User");
                        }

                        bootbox.dialog({
                            message: 'Đăng nhập thành công!',
                            closeButton: false,
                            buttons: {
                                ok: {
                                    className: 'btn btn-primary btn-icon-split',
                                    label: '<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">Đồng ý</span>',
                                    callback: function () {
                                        let bookId = localStorage.getItem("bookId");
                                        if (bookId) {
                                            localStorage.removeItem("bookId");
                                            location = `/sach/${bookId}`;
                                        } else {
                                            location = '/';
                                        }
                                    }
                                }
                            }
                        });
                    } else if (response.status == 0) {
                        bootbox.alert({ message: 'Tài khoản này đã bị khoá! Vui lòng liên hệ với quản trị viên để được mở lại!' });
                    } else {
                        bootbox.alert({ message: 'Đăng nhập không thành công! Sai tên tài khoản hoặc mật khẩu!' });
                    }
                },
                error: function () {
                    bootbox.alert({ message: 'Lỗi hệ thống! Đăng nhập không thành công!' })
                }                

            })
        }
    },
    logout: function () {
        $.ajax({
            url: '/API/User/Logout',
            type: 'POST',
            dataType: 'JSON',
            success: function (res) {
                if (res.status) {
                    bootbox.dialog({
                        message: 'Đăng xuất thành công!',
                        buttons: {
                            ok: {
                                className: 'btn btn-primary btn-icon-split',
                                label: '<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">Đồng ý</span>',
                                callback: function () {
                                    location.reload();
                                }
                            }
                        }
                    });
                } else if (res.status == 1) {
                    bootbox.alert({ message: 'Bạn chưa đăng nhập!' });
                } else {
                    bootbox.alert({ message: 'Đăng xuất không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Đăng xuất không thành công!' });
            }
        })
    }
};

userController.init();