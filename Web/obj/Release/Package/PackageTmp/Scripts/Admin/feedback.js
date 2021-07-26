let feedback = {
    init: function () {
        feedback.registerEvent();
        feedback.loadData();
        feedback.loadFilter();
    },

    registerEvent: function () {
        // Check all
        $('#ckbCheckAll').off('click').on('click', function () {
            feedback.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            feedback.checkItem();
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            feedback.search();
        });
        $('#btnReset').off('click').on('click', function () {
            feedback.reset();
        });

        // Add, update
        $('.btnViewContent').off('click').on('click', function () {
            let id  = $(this).data('id');
            let modal = '#modalViewContent';
            let title = 'Nội Dung Phản Hồi';

            feedback.showModal(modal, title, feedback.modalSize.extraLarge);
            feedback.viewContent(id);
        });
        $('.btnUpdateStatus').off('click').on('click', function (e) {
            e.preventDefault();
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Cập Nhật Trạng Thái Phản Hồi",
                message: "Cập nhật trạng thái hiển thị của phản hồi này này?",
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
                        feedback.updateStatus(id);
                    }
                }
            });
        });
       
        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Phản Hồi",
                message: "Xóa phản hồi này khỏi hệ thống?",
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
                        feedback.delete(id);
                    }
                }
            });
        });
        $('#btnDelete').off('click').on('click', function () {
            bootbox.confirm({
                title: "Xóa Phản Hồi",
                message: "Xóa những phản hồi đã chọn khỏi hệ thống?",
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
                        feedback.delete(0);
                    }
                }
            });
        });
    },


    // Get link
    getLink: function (page) {
        let link = '';

        link += '/Admin/Feedback/Index';
        link += (config.status != 2 ? ('?status=' + config.status) : '');
        link += (config.page > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('Index&', 'Index?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        feedback.checkItem();
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
        feedback.loadData();
    },
    reset: function () {
        config.status = 2;
        config.page.index = 1;
        config.page.total = 1;

        feedback.loadFilter();
        feedback.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Feedback/Gets',
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
                            Name: item.Name,
                            Phone: item.Phone,
                            Email: item.Email,
                            Status: (item.Status == 1 ? 'checked' : ''),
                            StatusName: (item.Status == 1 ? 'Đã xem' : 'Chưa xem')
                        });
                    });

                    feedback.showData(html, totalPages);
                    return;
                }

                feedback.showData();
            },
            error: function () {
                feedback.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        feedback.showDelete(false);
        feedback.paging(totalPages ? totalPages : 0);
        feedback.registerEvent();
        feedback.getLink();
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
                            feedback.loadData();
                        }
                    }
                });
            } else {
                $('#lblPagination').hide();
            }
        }
    },

    // View feedback content
    viewContent: function (id) {
        $.ajax({
            url: '/API/Feedback/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    $('#feedbackContent').html(data.Content);

                    if (data.Status == 0) {
                        $.ajax({
                            url: '/API/Feedback/UpdateStatus',
                            data: { id: id },
                            type: 'PUT',
                            dataType: 'JSON',
                            success: function (response) {
                                let status = response.status;

                                if (status) {
                                    feedback.loadData();
                                }
                            }
                        });
                    }
                }
            }
        });
    },

    // Update status
    updateStatus: function (id) {
        $.ajax({
            url: '/API/Feedback/UpdateStatus',
            data: { id: id },
            type: 'PUT',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status) {
                    bootbox.alert({ message: 'Cập nhật trạng thái phản hồi thành công!' });
                    feedback.loadData();
                } else {
                    bootbox.alert({ message: 'Cập nhật trạng thái phản hồi không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Lỗi hệ thống! Cập nhật trạng thái phản hồi không thành công!' });
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
            url: '/API/Feedback/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công phản hồi #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công phản hồi #' + id[i] + '<br/>';
                        }
                    }

                    feedback.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá phản hồi không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá phản hồi không thành công!');
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : feedback.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        feedback.registerEvent();
    }
};

feedback.init();