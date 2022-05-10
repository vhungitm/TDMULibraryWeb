var feedbackController = {
    int: function () {
        feedbackController.registerEvent();
    },

    registerEvent: function () {
        $('#frmFeedback').validate({
            rules: {
                txtName: {
                    required: true,
                    maxlength: 50
                },
                txtPhone: {
                    number: true,
                    required: true,
                    maxlength: 15
                },
                txtEmail: {
                    email: true,
                    required: true,
                    maxlength: 50
                },
                txtContent: {
                    required: true
                }
            },
            messages: {
                txtName: {
                    required: 'Vui lòng nhập họ tên!',
                    maxlength: 'Độ dài họ tên không được vượt quá 50 ký tự!'
                },
                txtPhone: {
                    number: 'Sai định dạng số điện thoại!',
                    required: 'Vui lòng nhập số điện thoại!',
                    maxlength: 'Đồ dài số điện thoại không được vượt quá 15 ký tự!'
                },
                txtEmail: {
                    email: 'Sai định dạng email!',
                    required: 'Vui lòng nhập email!',
                    maxlength: 'Email không được vượt quá 50 ký tự!'
                },
                txtContent: {
                    required: 'Vui lòng nhập nội dung!'
                }
            }
        });

        $('#frmFeedback').off('submit').on('submit', function (e) {
            e.preventDefault();

            feedbackController.save();
        });
    },

    save: function () {
        if ($('#frmFeedback').valid()) {
            let name = $('#txtName').val();
            let phone = $('#txtPhone').val();
            let email = $('#txtEmail').val();
            let content = $('#txtContent').val();

            let model = {
                Name: name,
                Phone: phone,
                Email: email,
                Content: content
            };

            $.ajax({
                url: '/API/Feedback/Insert',
                data: model,
                type: 'POST',
                dataType: 'JSON',
                success: function (response) {
                    let status = response.status;

                    if (status) {
                        bootbox.dialog({
                            message: 'Gửi phản hồi thành công! Cảm ơn bạn đã đóng góp ý kiến!',
                            buttons: {
                                ok: {
                                    className: 'btn btn-primary btn-sm btn-icon-split',
                                    label: '<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">Đồng ý</span>'
                                }
                            }
                        });
                    } else {
                        bootbox.dialog({
                            message: 'Gửi phản hồi không thành công!',
                            buttons: {
                                ok: {
                                    className: 'btn btn-primary btn-sm btn-icon-split',
                                    label: '<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">Đồng ý</span>'
                                }
                            }
                        });
                    }
                },
                error: function () {
                    bootbox.dialog({
                        message: 'Gửi phản hồi không thành công!',
                        buttons: {
                            ok: {
                                className: 'btn btn-primary btn-sm btn-icon-split',
                                label: '<span class="icon text-white-50"><i class="fas fa-check"></i></span><span class="text">Đồng ý</span>'
                            }
                        }
                    });
                }
            })
        }
    }
}

feedbackController.int();