let banner = {
    init: function () {
        banner.registerEvent();
        banner.loadData();
        banner.loadFilter();
    },

    registerEvent: function () {
        // Check all
        $('#ckbCheckAll').off('click').on('click', function () {
            banner.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            banner.checkItem();
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            banner.search();
        });
        $('#btnReset').off('click').on('click', function () {
            banner.reset();
        });

        // Add, update
        $('#btnAdd').off('click').on('click', function () {
            let modal = '#modalUpdate';
            let title = 'Thêm Mới Bìa Quảng Cáo';

            banner.showModal(modal, title);
        });
        $('.btnUpdate').off('click').on('click', function () {
            let id  = $(this).data('id');
            let modal = '#modalUpdate';
            let title = 'Cập Nhật Bìa Quảng Cáo';

            banner.showModal(modal, title);
            banner.loadDataItem(id);
        });
        $('.btnUpdateStatus').off('click').on('click', function (e) {
            e.preventDefault();
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Cập Nhật Trạng Thái Bìa Quảng Cáo",
                message: "Cập nhật trạng thái hiển thị của bìa quảng cáo này này?",
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
                        banner.updateStatus(id);
                    }
                }
            });
        });
        $('#btnSelectImage').off('click').on('click', function (e) {
            e.preventDefault();
            let input = '#image';

            banner.showCKFinder(input);
        });
        $('#ckbStatus').off('click').on('click', function () {
            let status = $(this).prop('checked');
            $('label[for="ckbStatus"]').text(status ? 'Hiển thị' : 'Ẩn');
        });
        $('#frmUpdate').validate({
            rules: {
                nbrOrder: {
                    number: true,
                    required: true,
                    min: 1
                }
            },
            messages: {
                nbrOrder: {
                    number: 'Sai định dạng. Thứ tự hiển thị phải là 1 số!',
                    required: 'Vui lòng nhập thứ tự hiển thị!',
                    min: 'Thứ tự hiển thị phải lớn hơn hoặc bằng 1!'
                }
            }
        });
        $('#btnSave').off('click').on('click', function () {
            banner.save();
        });

        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Bìa Quảng Cáo",
                message: "Xóa bìa quảng cáo này khỏi hệ thống?",
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
                        banner.delete(id);
                    }
                }
            });
        });
        $('#btnDelete').off('click').on('click', function () {
            bootbox.confirm({
                title: "Xóa Bìa Quảng Cáo",
                message: "Xóa những bìa quảng cáo đã chọn khỏi hệ thống?",
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
                        banner.delete(0);
                    }
                }
            });
        });
    },


    // Get link
    getLink: function (page) {
        let link = '';

        link += '/Admin/Banner/Index';
        link += (config.status != 2 ? ('?status=' + config.status) : '');
        link += (config.page > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('Index&', 'Index?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        banner.checkItem();
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
        selectpicker.setSelected('slStatusSearch', config.status, true);
    },
    search: function () {
        config.status = $('#slStatusSearch option:selected').val();

        config.page.index = 1;
        banner.loadData();
    },
    reset: function () {
        config.status = 2;
        config.page.index = 1;
        config.page.total = 1;

        banner.loadFilter();
        banner.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Banner/Gets',
            data: {
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
                            Image: item.Image,
                            Order: item.Order,
                            Status: (item.Status == 1 ? 'checked' : ''),
                            StatusName: (item.Status == 1 ? 'Hiển thị' : 'Ẩn')
                        });
                    });

                    banner.showData(html, totalPages);
                    return;
                }

                banner.showData();
            },
            error: function () {
                banner.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        banner.showDelete(false);
        banner.paging(totalPages ? totalPages : 0);
        banner.registerEvent();
        banner.getLink();
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
                            banner.loadData();
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
            url: '/API/Banner/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    $('#nbrId').val(data.Id);
                    $('#image').prop('src', data.Image);
                    $('#nbrOrder').val(data.Order);
                    $('#ckbStatus').prop('checked', data.Status);
                    $('[for="ckbStatus"]').text(data.Status == 1 ? 'Hiển thị' : 'Ẩn');
                }
            }
        })
    },
    save: function () {
        if ($('#frmUpdate').valid()) {
            let id = $('#nbrId').val();
            let image = $('#image').attr('src');
            let order = $('#nbrOrder').val();
            let status = $('#ckbStatus').prop('checked') ? 1 : 0;

            let model = {
                Id: id,
                Image: image,
                Order: order,
                Status: status
            };

            let linkAPI = (id == 0) ? '/API/Banner/Insert' : '/API/Banner/Update';
            let typeAPI = (id == 0) ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    if (response.status) {
                        banner.loadData();
                        $('#modalUpdate').modal('hide');

                        bootbox.alert({ message: (id == 0) ? 'Thêm mới  thành công!' : 'Cập nhật bìa quảng cáo thành công!' });
                    } else {
                        bootbox.confirm({
                            message: (id == 0) ? 'Thêm mới bìa quảng cáo không thành công!' : 'Cập nhật bìa quảng cáo không thành công!',
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
                        message: (id == 0) ? 'Thêm mới bìa quảng cáo không thành công!' : 'Cập nhật sách không thành công!',
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
    updateStatus: function (id) {
        $.ajax({
            url: '/API/Banner/UpdateStatus',
            data: { id: id },
            type: 'PUT',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status) {
                    bootbox.alert({ message: 'Cập nhật trạng thái bìa quảng cáo thành công!' });
                    banner.loadData();
                } else {
                    bootbox.alert({ message: 'Cập nhật trạng thái bìa quảng cáo không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Lỗi hệ thống! Cập nhật trạng thái bìa quảng cáo không thành công!' });
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
            url: '/API/Banner/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công bìa quảng cáo #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công bìa quảng cáo #' + id[i] + '<br/>';
                        }
                    }

                    banner.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá bìa quảng cáo không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá bìa quảng cáo không thành công!');
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : banner.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        banner.registerEvent();
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

banner.init();