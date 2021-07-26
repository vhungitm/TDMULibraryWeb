let student = {
    init: function () {
        student.registerEvent();
        student.loadFilter();
        student.loadData();
    },

    registerEvent: function () {
        // Check all
        $('#ckbCheckAll').off('click').on('click', function () {
            student.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            student.checkItem();
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            student.search();
        });
        $('#btnReset').off('click').on('click', function () {
            student.reset();
        });

        // Add, update
        $('#btnAdd').off('click').on('click', function () {
            let modal = '#modalUpdate';
            let title = 'Thêm Mới Sinh Viên';

            student.showModal(modal, title, student.modalSize.large);
            selectpicker.setSelected('slGender', 'Nam', true);
            $('#btnSave').data('type', 0);
        });
        $('.btnUpdate').off('click').on('click', function () {
            let id  = $(this).data('id');
            let modal = '#modalUpdate';
            let title = 'Cập Nhật Sinh Viên';

            student.showModal(modal, title, student.modalSize.large);
            student.loadDataItem(id);
        });
        $('.btnUpdateStatus').off('click').on('click', function (e) {
            e.preventDefault();
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Cập Nhật Trạng Thái Tài Khoản",
                message: "Cập nhật trạng thái tài khoản của sinh viên này?",
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
                        student.updateStatus(id);
                    }
                }
            });
        });
        $('#btnSelectAvatar').off('click').on('click', function (e) {
            e.preventDefault();
            let input = '#avatar';

            student.showCKFinder(input);
        });
        $('#ckbStatus').off('click').on('click', function () {
            let status = $(this).prop('checked');
            $('label[for="ckbStatus"]').text(status ? 'Kích hoạt' : 'Khoá');
        });
        $('#frmUpdate').validate({
            rules: {
                txtId: {
                    required: true,
                    maxlength: 13
                },
                txtPassword: {
                    maxlength: 50
                },
                txtFullName: {
                    required: true,
                    maxlength: 50
                },
                slGender: { required: true },
                dtBirthday: {
                    required: true,
                    date: true
                },
                txtAddress: {
                    required: true,
                    maxlength: 200
                },
                txtPhone: {
                    required: true,
                    maxlength: 15
                },
                txtEmail: {
                    required: true,
                    maxlength: 50,
                    email: true
                },
                txtClass: {
                    required: true
                }
            },
            messages: {
                txtId: {
                    required: 'Vui lòng nhập mã sinh viên!',
                    maxlength: 'Mã sinh viên không được vượt quá 13 ký tự!'
                },
                txtPassword: {
                    maxlength: 'Mật khẩu không được vượt quá 50 ký tự!'
                },
                txtFullName: {
                    required: 'Vui lòng nhập họ tên!',
                    maxlength: 'Tên sinh viên không được vượt quá 50 ký tự!'
                },
                slGender: { required: 'Vui chọn giới tính!' },
                dtBirthday: {
                    required: 'Vui lòng nhập ngày sinh!',
                    date: 'Sai định dạng ngày!'
                },
                txtAddress: {
                    required: 'Vui lòng nhập địa chỉ!',
                    maxlength: 'Địa chỉ không được vượt quá 200 ký tự!'
                },
                txtPhone: {
                    required: 'Vui lòng nhập số điện thoại!',
                    maxlength: 'Số điện thoại không được vượt quá 15 ký tự!'
                },
                txtEmail: {
                    required: 'Vui lòng nhập email!',
                    maxlength: 'Email không được vượt quá 50 ký tự!',
                    email: 'Sai định dạng email!'
                },
                txtClass: {
                    required: 'Vui lòng nhập tên lớp!'
                }
            }
        });
        $('#btnSave').off('click').on('click', function () {
            student.save();
        });

        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Sinh Viên",
                message: "Xóa sinh viên này khỏi hệ thống?",
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
                        student.delete(id);
                    }
                }
            });
        });
        $('#btnDelete').off('click').on('click', function () {
            bootbox.confirm({
                title: "Xóa Sinh Viên",
                message: "Xóa những sinh viên đã chọn khỏi hệ thống?",
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
                        student.delete(0);
                    }
                }
            });
        });
    },

    // Get link
    getLink: function (page) {
        let link = '';

        link += '/Admin/Student/Index';
        link += (config.key != '') ? ('&key=' + config.key) : '';
        link += (config.status != 2) ? ('&status=' + config.status) : '';
        link += (config.page > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('x&', 'x?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        student.checkItem();
    },
    checkItem: function () {
        let selectedItemQuantity = $('.ckbItem:checked').length;

        $('#btnDelete').attr('style', selectedItemQuantity > 0 ? '' : 'display: none');
    },

    // Filter, search
    loadFilter: function () {
        let content = $('#filterContent').html();
        let filter = $('#filter');

        filter.html(content);
        $('#txtKeySearch').val(config.key);
        selectpicker.setSelected('slStatusSearch', config.status, true);
    },
    search: function () {
        config.key = $('#txtKeySearch').val();
        config.status = $('#slStatusSearch option:selected').val();

        config.page.index = 1;
        student.loadData();
    },

    reset: function () {
        config.key = '';
        config.status = 2,
        config.page.index = 1;
        config.page.total = 1;

        student.loadFilter();
        student.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Student/Gets',
            data: {
                key: config.key,
                status: config.status,
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

                    let template = $('#dataItem').html();
                    let tableHeader = $('#dataTableHeader').html();
                    let html = '';

                    html += tableHeader;

                    $.each(data, function (i, item) {

                        html += Mustache.render(template, {
                            Id: item.Id,
                            Avatar: item.Avatar,
                            FullName: item.FullName,
                            Gender: item.Gender,
                            Birthday: item.Birthday,
                            Address: item.Address,
                            Phone: item.Phone,
                            Email: item.Email,
                            Class: item.Class,
                            Status: (item.Status == 1 ? 'checked' : ''),
                            StatusName: (item.Status == 1 ? 'Kích hoạt' : 'Khoá')
                        });
                    });

                    student.showData(html, totalPages);
                    return;
                }

                student.showData();
            },
            error: function () {
                student.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        student.showDelete(false);
        student.paging(totalPages ? totalPages : 0);
        student.registerEvent();
        student.getLink();
    },
    paging: function (totalPages) {
        if (config.page.total != totalPages) {
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
                            student.loadData();
                        }
                    }
                });
            } else {
                $('#lblPagination').hide();
            }
        }
    },

    // Add, update
    loadDataItem: function (id) {
        $.ajax({
            url: '/API/Student/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    let dtBirthday = data.Birthday.split('/');
                    let birthday = dtBirthday[2] + '-' + dtBirthday[1] + '-' + dtBirthday[0];

                    $('#txtId').val(data.Id);
                    $('#avatar').prop('src', data.Avatar);
                    $('#txtFullName').val(data.FullName);
                    selectpicker.setSelected('slGender', data.Gender, true);
                    $('#dtBirthday').val(birthday);
                    $('#txtAddress').val(data.Address);
                    $('#txtPhone').val(data.Phone);
                    $('#txtEmail').val(data.Email);
                    $('#txtClass').val(data.Class);
                    $('#ckbStatus').prop('checked', data.Status);
                    $('label[for="ckbStatus"]').text(data.Status ? 'Kích hoạt' : 'Khoá');

                    $('#txtId').attr('readonly', 'readonly');
                    $('#btnSave').attr('data-type', 1);
                }
            }
        })
    },
    save: function () {
        if ($('#frmUpdate').valid()) {
            let id = $('#txtId').val();
            let password = $('#txtPassword').val();
            let avatar = $('#avatar').attr('src');
            let fullName = $('#txtFullName').val();
            let gender = $('#slGender option:selected').val();
            let birthday = $('#dtBirthday').val();
            let address = $('#txtAddress').val();
            let phone = $('#txtPhone').val();
            let email = $('#txtEmail').val();
            let className = $('#txtClass').val();
            let status = $('#ckbStatus').prop('checked') ? 1 : 0;

            let type = $('#btnSave').attr('data-type');

            let model = {
                Id: id,
                Password: password,
                Avatar: avatar,
                FullName: fullName,
                Gender: gender,
                Birthday: birthday,
                Address: address,
                Phone: phone,
                Email: email,
                Class: className,
                Status: status
            };

            let linkAPI = (type == 0) ? '/API/Student/Insert' : '/API/Student/Update';
            let typeAPI = (type == 0) ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    let status = response.status;

                    if (status == 1) {
                        student.loadData();
                        $('#modalUpdate').modal('hide');

                        bootbox.alert({ message: (type == 0) ? 'Thêm mới sinh viên thành công!' : 'Cập nhật thông tin sinh viên thành công!' });
                    } else if (status == -1) {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (type == 0) ? 'Thêm mới sinh viên không thành công! Mã sinh viên đã tồn tại!' : 'Cập nhật thông tin sinh viên không thành công! Mã sinh viên đã tồn tại!',
                            buttons: {
                                cancel: {
                                    label: '<i class="fa fa-times"></i> Hủy'
                                },
                                confirm: {
                                    label: '<i class="fa fa-check"></i> Thử lại'
                                }
                            },
                            callback: function (result) {
                                if (result) {
                                    setTimeout(function () { $('#modalUpdate').modal('show') }, 400)
                                }
                            }
                        });
                    } else if (status == -2) {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (type == 0) ? 'Thêm mới sinh viên không thành công! Số điện thoại này đã được sử dụng!' : 'Cập nhật thông tin sinh viên không thành công! Số điện thoại này đã được sử dụng!',
                            buttons: {
                                cancel: {
                                    label: '<i class="fa fa-times"></i> Hủy'
                                },
                                confirm: {
                                    label: '<i class="fa fa-check"></i> Thử lại'
                                }
                            },
                            callback: function (result) {
                                if (result) {
                                    setTimeout(function () { $('#modalUpdate').modal('show') }, 400)
                                }
                            }
                        });
                    } else if (status == -3) {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (type == 0) ? 'Thêm mới sinh viên không thành công! Email này đã được sử dụng!' : 'Cập nhật thông tin sinh viên không thành công! Email này đã được sử dụng!',
                            buttons: {
                                cancel: {
                                    label: '<i class="fa fa-times"></i> Hủy'
                                },
                                confirm: {
                                    label: '<i class="fa fa-check"></i> Thử lại'
                                }
                            },
                            callback: function (result) {
                                if (result) {
                                    setTimeout(function () { $('#modalUpdate').modal('show') }, 400)
                                }
                            }
                        });
                    } else {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (type == 0) ? 'Thêm mới sinh viên không thành công!' : 'Cập nhật thông tin sinh viên không thành công!',
                            buttons: {
                                cancel: {
                                    label: '<i class="fa fa-times"></i> Hủy'
                                },
                                confirm: {
                                    label: '<i class="fa fa-check"></i> Thử lại'
                                }
                            },
                            callback: function (result) {
                                if (result) {
                                    setTimeout(function () { $('#modalUpdate').modal('show') }, 400)
                                }
                            }
                        });
                    }
                },
                error: function () {
                    bootbox.confirm({
                        message: (type == 0) ? 'Thêm mới sinh viên không thành công!' : 'Cập nhật thông tin sinh viên không thành công!',
                        buttons: {
                            cancel: {
                                label: '<i class="fa fa-times"></i> Hủy'
                            },
                            confirm: {
                                label: '<i class="fa fa-check"></i> Thử lại'
                            }
                        },
                        callback: function (result) {
                            if (result) {
                                setTimeout(function () { $('#modalUpdate').modal('show') }, 400)
                            }
                        }
                    });
                }
            });
        }
    },
    updateStatus: function (id) {
        $.ajax({
            url: '/API/Student/UpdateStatus',
            data: { id: id },
            type: 'PUT',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status) {
                    bootbox.alert({ message: 'Cập nhật trạng thái tài khoản thành công!' });
                    student.loadData();
                } else {
                    bootbox.alert({ message: 'Cập nhật trạng thái tài khoản không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Lỗi hệ thống! Cập nhật trạng thái tài khoản không thành công!' });
            }
        });
    },

    // Delete
    showDelete: function (status) {
        let btn = $('#btnDelete');

        if (status) btn.show();
        else btn.hide();
    },
    delete: function (type) {
        let id = [];

        if (type == 0) {
            $('.ckbItem:checked').each(function (i) {
                id[i] = $(this).val();
            });
        } else {
            id[0] = type;
        }

        $.ajax({
            url: '/API/Student/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công sinh viên #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công sinh viên #' + id[i] + '<br/>';
                        }
                    }

                    student.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá sinh viên không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá sinh viên không thành công!');
            }
        });
    },

    // Load components
    // Show modal
    modalSize: {
        default: 'modal-dialog',
        small: 'modal-dialog modal-sm',
        large: 'modal-dialog modal-lg',
        extraLarge: 'modal-dialog modal-xl'
    },
    showModal: function (modal, title, size) {
        let body = modal + "Body";

        // Set modal
        $(modal).find('div').eq(0).attr('class', size != null ? size : student.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        student.registerEvent();
    },

    // CKFinder
    showCKFinder: function (input) {
        let ckFinder = new CKFinder();

        ckFinder.selectActionFunction = function (url) {
            $(input).attr('src', url);
        };
        ckFinder.popup();
    },
};

student.init();