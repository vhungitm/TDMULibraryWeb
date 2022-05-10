let category = {
    init: function () {
        category.registerEvent();
        category.loadData();
        category.loadFilter();
    },

    registerEvent: function () {
        // Check all
        $('#ckbCheckAll').off('click').on('click', function () {
            category.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            category.checkItem();
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            category.search();
        });
        $('#btnReset').off('click').on('click', function () {
            category.reset();
        });

        // Add, update
        $('#btnAdd').off('click').on('click', function () {
            let modal = '#modalUpdate';
            let title = 'Thêm Mới Thể Loại Sách';

            category.showModal(modal, title);
        });
        $('.btnUpdate').off('click').on('click', function () {
            let id  = $(this).data('id');
            let modal = '#modalUpdate';
            let title = 'Cập Nhật Thể Loại Sách';

            category.showModal(modal, title);
            category.loadDataItem(id);
        });
        $('#btnSelectImage').off('click').on('click', function (e) {
            e.preventDefault();
            let input = '#image';

            category.showCKFinder(input);
        });
        $('#frmUpdate').validate({
            rules: {
                txtName: { required: true },
                txtDescription: { required: true }
            },
            messages: {
                txtName: { required: 'Vui lòng nhập tên!' },
                txtDescription: { required: 'Vui lòng nhập mô tả!' }
            }
        });
        $('#btnSave').off('click').on('click', function () {
            category.save();
        });

        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Thể Loại Sách",
                message: "Xóa thể loại sách này khỏi hệ thống?",
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
                        category.delete(id);
                    }
                }
            });
        });
        $('#btnDelete').off('click').on('click', function () {
            bootbox.confirm({
                title: "Xóa Thể Loại Sách",
                message: "Xóa những thể loại sách đã chọn khỏi hệ thống?",
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
                        category.delete(0);
                    }
                }
            });
        });
    },


    // Get link
    getLink: function (page) {
        let link = '';

        link += '/Admin/Category/Index';
        link += (config.key != '' ? ('?key=' + config.key) : '');
        link += (config.page > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('x&', 'x?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        category.checkItem();
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
        $('#txtKeySearch').val(config.key)
    },
    search: function () {
        config.key = $('#txtKeySearch').val();
        config.page.index = 1;

        category.loadData();
    },
    reset: function () {
        config.key = '';
        config.page.index = 1;
        config.page.total = 1;

        category.loadFilter();
        category.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Category/Gets',
            data: {
                key: config.key,
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
                            Name: item.Name,
                            Image: item.Image,
                            Description: item.Description
                        });
                    });

                    category.showData(html, totalPages);
                    return;
                }

                category.showData();
            },
            error: function () {
                category.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        category.showDelete(false);
        category.paging(totalPages ? totalPages : 0);
        category.registerEvent();
        category.getLink();
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
                            category.loadData();
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
            url: '/API/Category/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    $('#nbrId').val(data.Id);
                    $('#txtName').val(data.Name);
                    $('#image').prop('src', data.Image);
                }
            }
        })
    },
    save: function () {
        if ($('#frmUpdate').valid()) {
            let id = $('#nbrId').val();
            let name = $('#txtName').val();
            let image = $('#image').attr('src');

            let model = {
                Id: id,
                Name: name,
                Image: image
            };

            let linkAPI = (id == 0) ? '/API/Category/Insert' : '/API/Category/Update';
            let typeAPI = (id == 0) ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    if (response.status) {
                        category.loadData();
                        $('#modalUpdate').modal('hide');

                        bootbox.alert({ message: (id == 0) ? 'Thêm mới thể loại sách thành công!' : 'Cập nhật thể loại sách thành công!' });
                    } else {
                        bootbox.confirm({
                            message: (id == 0) ? 'Thêm mới thể loại sách không thành công!' : 'Cập nhật thể loại sách không thành công!',
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
                        message: (id == 0) ? 'Thêm mới thể loại sách không thành công!' : 'Cập nhật sách không thành công!',
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
            })
        }
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
            url: '/API/Category/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công thể loại sách #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công thể loại sách #' + id[i] + '<br/>';
                        }
                    }

                    category.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá thể loại sách không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá thể loại sách không thành công!');
            }
        });
    },

    // Load Components
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : category.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        category.registerEvent();
    },

    // Show CKFinder
    showCKFinder: function (input) {
        let ckFinder = new CKFinder();

        ckFinder.selectActionFunction = function (url) {
            $(input).attr('src', url);
        };
        ckFinder.popup();
    },
};

category.init();