let importBook = {
    init: function () {
        importBook.registerEvent();
        importBook.loadFilter();
        importBook.loadData();
    },

    registerEvent: function () {
        // Check item
        $('#ckbCheckAll').off('click').on('click', function () {
            importBook.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            importBook.checkItem();
        });

        // Filter staff
        $('#txtStaffSearch').off('keyup').on('keyup', function () {
            importBook.filterStaff();
        });
        $('#txtStaff').off('keyup').on('keyup', function () {
            importBook.filterStaff(1);
        });
        $('.itemStaffSearch').off('click').on('click', function () {
            let id = $(this).data('id');

            importBook.loadStaffs(id);
        });
        $('.itemStaff').off('click').on('click', function () {
            let id = $(this).data('id');

            importBook.loadStaffs(id, 1);
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            importBook.search();
        });
        $('#btnReset').off('click').on('click', function () {
            importBook.reset();
        });

        // Add
        $('#btnAdd').off('click').on('click', function () {
            importBook.save();
        });

        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Phiếu Nhập",
                message: "Xóa phiếu nhập này khỏi hệ thống?",
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
                        importBook.delete(id);
                    }
                }
            });
        });
        $('#btnDelete').off('click').on('click', function () {
            bootbox.confirm({
                title: "Xóa Thể Loại Sách",
                message: "Xóa những sách đã chọn khỏi hệ thống?",
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
                        importBook.delete(0);
                    }
                }
            });
        });

        // Detail
        // View Detail
        $('.btnView').off('click').on('click', function () {
            detailConfig.importId = $(this).data('id');

            importBook.viewDetail();            
        });
        $('#modalView').off('hidden.bs.modal').on('hidden.bs.modal', function () {
            importBook.closeDetail();
        })

        // Check detail item
        $('#ckbCheckAllDetailItem').off('click').on('click', function () {
            importBook.checkAllDetailItem();
        });
        $('.ckbDetailItem').off('click').on('click', function () {
            importBook.checkDetailItem();
        })

        // Search detail item
        $('#btnSearchDetailItem').off('click').on('click', function () {
            importBook.searchDetailItem();
        });
        $('#btnResetDetail').off('click').on('click', function () {
            importBook.resetDetail();
        });

        // Add / Update detail
        $('#btnAddDetailItem').off('click').on('click', function () {
            let modal = '#modalUpdateDetailItem';
            let title = 'Thêm Mới Chi Tiết Phiếu Nhập';

            importBook.showModal(modal, title);

            importBook.loadSelectpickerData('slBook', 'Book', 0, 'Chọn sách');
            $('#btnSaveDetailItem').data('type', 0);
        });
        $('.btnUpdateDetailItem').off('click').on('click', function () {
            let id = $(this).data('id');
            let modal = '#modalUpdateDetailItem';
            let title = 'Cập Nhật Thông Tin Chi Tiết Phiếu Nhập';

            importBook.showModal(modal, title);
            importBook.loadDetailItem(id);
        });
        $('#nbrQuantity').off('keyup').on('keyup', function () {
            importBook.loadTotalPrice();
        });
        $('#nbrPrice').off('keyup').on('keyup', function () {
            importBook.loadTotalPrice();
        });
        $('#frmUpdateDetailItem').validate({
            rules: {
                slBook: {
                    min: 1
                },
                nbrQuantity: {
                    number: true,
                    required: true,
                    min: 1
                },
                nbrPrice: {
                    number: true,
                    required: true,
                    min: 0
                },
            },
            messages: {
                slBook: {
                    min: 'Vui lòng chọn sách!'
                },
                nbrQuantity: {
                    number: 'Sai định dạng!',
                    required: 'Vui lòng nhập số lượng!',
                    min: 'Số lượng tối thiểu là 1'
                },
                nbrPrice: {
                    number: 'Sai định dạng!',
                    required: 'Vui lòng nhập đơn giá!',
                    min: 'Đơn giá tối thiểu là 0 VNĐ!'
                },
            }
        });
        $('#btnSaveDetailItem').off('click').on('click', function () {
            let type = $(this).data('type');
            importBook.saveDetailItem(type);
        });
        
        // Delete detail
        $('#btnDeleteDetailItem').off('click').on('click', function () {
            bootbox.confirm({
                title: 'Xoá Chi Tiết Phiếu Nhập',
                message: "Xóa những cuốn sách đã chọn khỏi phiếu nhập?",
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
                        importBook.deleteDetailItem();
                    }
                }
            });
        });
        $('.btnDeleteDetailItem').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: 'Xoá Chi Tiết Phiếu Nhập',
                message: "Xóa cuốn sách này khỏi phiếu nhập?",
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
                        importBook.deleteDetailItem(id);
                    }
                }
            });
        });
    },

    // Get link
    getLink: function () {
        let link = '';

        link += '/Admin/Import/Index';
        link += (config.id != '') ? ('&id=' + config.id) : '';
        link += (config.staff.id != '') ? ('&staff=' + config.staff.id.trim()) : '';
        link += (config.createdDate != 0) ? ('&createdDate=' + config.createdDate) : '';
        link += (config.page.index > 1) ? ('&page=' + config.page.index) : '';

        // Detail
        link += detailConfig.importId > 0 ? `&importId=${detailConfig.importId}` : '';
        link += detailConfig.book.id != '' ? `&book=${detailConfig.book.id}` : '';
        link += detailConfig.page.index > 1 ? `&pageDetail=${detailConfig.page.index}` : '';

        link = link.replace('x&', 'x?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        importBook.checkItem();
    },
    checkItem: function () {
        let selectedItemQuantity = $('.ckbItem:checked').length;

        $('#btnDelete').attr('style', selectedItemQuantity > 0 ? '' : 'display: none');
    },

    // Search
    loadFilter: function () {
        let content = $('#filterContent').html();
        let filter = $('#filter');

        filter.html(content);

        $('#nbrIdSearch').val(config.id != 0 ? config.id : '');
        importBook.loadSelectpickerData('slStaffSearch', 'Staff', config.staff.id, config.staff.name, 'search');
        $('#txtCreatedDateSearch').val(config.createdDate);
    },  
    search: function () {
        config.id = $('#nbrIdSearch').val();

        config.staff.id = $('#slStaffSearch option:selected').val();
        config.staff.name = $('#slStaffSearch option:selected').text();

        config.createdDate = $('#txtCreatedDateSearch').val();
        config.page.index = 1;

        importBook.loadData();
    },
    reset: function () {
        config.id = 0;
        config.staff = {
            id: '',
            name: 'Tất cả nhân viên'
        };
        config.createdDate = '';
        config.page.index = 1;
        config.page.total = 1;

        importBook.loadFilter();
        importBook.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Import/Gets',
            data: {
                id: config.id,
                staffId: config.staff.id,
                createdDate: config.createdDate,
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
                            StaffId: item.StaffId,
                            StaffName: item.StaffName,
                            CreatedDate: item.CreatedDate,
                            Quantity: importBook.formatValue('#,###', item.Quantity),
                            TotalPrice: importBook.formatValue('#,###', item.TotalPrice),
                        });
                    });

                    importBook.showData(html, totalPages);
                    if (detailConfig.importId > 0) {
                        importBook.viewDetail();
                    }
                } else {
                    importBook.showData();
                }
            },
            error: function () {
                importBook.showData();
            }
        });
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        $('#btnDelete').hide();
        importBook.paging(totalPages ? totalPages : 0);
        importBook.registerEvent();
        importBook.getLink();
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
                            importBook.loadData();
                        }
                    }
                });
            } else {
                $('#lblPagination').hide();
            }
        }
    },

    // Add
    save: function () {
        let model = {
            StaffId: config.user.username
        };

        let linkAPI = '/API/Import/Insert';

        $.ajax({
            url: linkAPI,
            data: model,
            type: 'POST',
            dataType: 'JSON',
            success: function (response) {
                if (response.status) {
                    importBook.loadData();
                    
                    bootbox.confirm({
                        message: "Thêm mới phiếu nhập thành công. Xem chi tiết phiếu nhập?",
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
                                detailConfig.importId = response.status;
                                setTimeout(function () {
                                    importBook.showModal('#modalView', 'Chi Tiết Phiếu Nhập', importBook.modalSize.extraLarge);
                                    importBook.loadDetail(response.status);
                                }, 250);
                            }
                        }
                    });
                } else {
                    bootbox.alert({ message: 'Thêm mới phiếu nhập không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Thêm mới phiếu nhập không thành công!' });
            }
        });
    },

    // Delete
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
            url: '/API/Import/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công phiếu nhập #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công phiếu nhập #' + id[i] + '<br/>';
                        }
                    }

                    importBook.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá phiếu nhập không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá phiếu nhập không thành công!');
            }
        });
    },

    // Detail
    // Check item
    checkAllDetailItem: function () {
        let status = $('#ckbCheckAllDetailItem').prop('checked');

        $('.ckbDetailItem').prop('checked', status);
        importBook.checkDetailItem();
    },
    checkDetailItem: function () {
        let selectedItemQuantity = $('.ckbDetailItem:checked').length;

        $('#btnDeleteDetailItem').attr('style', selectedItemQuantity > 0 ? '' : 'display: none');
    },

    // Search
    loadDetailFilter: function () {
        let content = $('#detailFilterContent').html();
        let filter = $('#detailFilter');

        filter.html(content);
        importBook.loadSelectpickerData('slBookSearch', 'Book', detailConfig.book.id, detailConfig.book.title, 'search');
    },
    searchDetailItem: function () {
        let book = $('#slBookSearch option:selected');
        detailConfig.book = {
            id: book.val(),
            title: book.text()
        };

        detailConfig.page.index = 1;
        importBook.loadDetail();
    },
    resetDetail: function () {
        detailConfig.book = {
            id: '',
            title: 'Tất cả sách'
        };
        detailConfig.page.index = 1;
        detailConfig.page.total = 1;

        importBook.loadDetailFilter();
        importBook.loadDetail();
    },

    // View detail
    viewDetail: function () {
        let modal = '#modalView';
        let title = 'Chi Tiết Phiếu Nhập';
        importBook.showModal(modal, title, importBook.modalSize.extraLarge);

        importBook.loadDetailFilter();
        importBook.loadDetail();
    },
    closeDetail: function () {
        detailConfig.importId = 0;
        detailConfig.book = {
            id: '',
            title: 'Tất cả sách'
        };
        detailConfig.page.index = 1;
        detailConfig.page.total = 1;

        importBook.getLink();
    },

    // Load detail
    loadDetail: function () {
        $.ajax({
            url: '/API/ImportDetail/Gets',
            data: {
                importId: detailConfig.importId,
                book: detailConfig.book.id,
                page: detailConfig.page.index,
                pageSize: detailConfig.page.size
            },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data.length > 0) {
                    let totalRow = response.totalRow;
                    let totalPages = Math.ceil(totalRow / detailConfig.page.size);

                    let template = $('#detailItem').html();
                    let tableHeader = $('#detailTableHeader').html();
                    let html = '';

                    html += tableHeader;

                    $.each(data, function (i, item) {

                        html += Mustache.render(template, {
                            ImportId: item.ImportId,
                            BookId: item.BookId,
                            BookTitle: item.BookTitle,
                            Quantity: importBook.formatValue('#,###', item.Quantity),
                            Price: importBook.formatValue('#,###', item.Price),
                            TotalPrice: importBook.formatValue('#,###', item.TotalPrice)
                        });
                    });

                    importBook.showDetail(html, totalPages);
                } else {
                    importBook.showDetail();
                }
            },
            error: function () {
                importBook.showDetail();
            }
        });
    },
    showDetail: function (html, totalPages) {
        let dataTable = $('#detailTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        importBook.detailPaging(totalPages ? totalPages : 0);
        importBook.registerEvent();
        importBook.getLink();
    },
    detailPaging: function (totalPages) {
        if (detailConfig.page.total != totalPages) {
            detailConfig.page.total = totalPages;
            detailConfig.page.index = detailConfig.page.index > totalPages ? totalPages : detailConfig.page.index;

            $('#detailPagination').removeData('twbs-pagination');
            $('#detailPagination').html('');

            if (totalPages > 1) {
                $('#detailPagination').twbsPagination({
                    totalPages: detailConfig.page.total,
                    first: 'Đầu',
                    last: 'Cuối',
                    prev: 'Trước',
                    next: 'Tiếp',
                    startPage: detailConfig.page.index,

                    onPageClick: function (event, page) {
                        $('#lblDetailPagination').text(`Trang ${page}/${detailConfig.page.total}`).show();

                        if (page != detailConfig.page.index) {
                            let id = $('#detailTable').data('id');
                            detailConfig.page.index = page;

                            importBook.loadDetail();
                        }
                    }
                });
            } else {
                $('#lblDetailPagination').hide();
            }
        }
    },

    // Add, update detail
    loadDetailItem: function (bookId) {
        $('#btnSaveDetailItem').data('type', 1);

        $.ajax({
            url: '/API/ImportDetail/Get',
            data: {
                importId: detailConfig.importId,
                book: bookId
            },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;
                
                if (data != null) {               
                    $('#nbrImportId').attr('value', data.ImportId);
                    importBook.loadSelectpickerData('slBook', 'Book', data.BookId, data.BookTitle);
                    $('#slBook').parents('.mb-3').hide();
                    $('#lblQuantity').text(importBook.formatValue('#,###', data.Quantity));
                    $('#nbrQuantity').val(data.Quantity);
                    
                    $('#lblPrice').text(importBook.formatValue('#,###', data.Price));
                    $('#nbrPrice').val(data.Price);

                    $('#lblTotalPrice').text(importBook.formatValue('#,###', data.TotalPrice));
                    $('#nbrTotalPrice').val(data.TotalPrice);
                }
            },
        });
    },
    loadTotalPrice: function () {
        let quantity = $('#nbrQuantity').val();
        let price = $('#nbrPrice').val();
        let totalPrice = (quantity == null ? 0 : quantity) * (price == null ? 0 : price);

        $('#lblQuantity').text(importBook.formatValue('#,###', quantity));
        $('#lblPrice').text(importBook.formatValue('#,###', price));
        $('#lblTotalPrice').text(importBook.formatValue('#,###', totalPrice));
        $('#nbrTotalPrice').val(totalPrice);
    },
    saveDetailItem: function (type) {
        if (validation.valid('#frmUpdateDetailItem')) {
            let bookId = $('#slBook option:selected').val();
            let quantity = $('#nbrQuantity').val();
            let price = $('#nbrPrice').val();

            let model = {
                ImportId: detailConfig.importId,
                BookId: bookId,
                Quantity: quantity,
                Price: price
            };

            let linkAPI = type == 0 ? '/API/ImportDetail/Insert' : '/API/ImportDetail/Update';
            let typeAPI = type == 0 ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    if (response.status) {
                        $('#modalUpdateDetailItem').modal('hide');
                        importBook.loadData();
                        importBook.loadDetail();
                        bootbox.alert({ message: (type == 0 ? 'Thêm mới chi tiết phiếu nhập thành công!' : 'Cập nhật thông tin chi tiết phiếu nhập thành công!') });
                    } else {
                        $('#modalUpdateDetailItem').modal('hide');
                        bootbox.confirm({
                            title: (type == 0 ? 'Thêm Mới Chi Tiết Phiếu Nhập' : 'Cập Nhật Thông Tin Chi Tiết Phiếu Nhập'),
                            message: (type == 0 ? 'Thêm mới chi tiết phiếu nhập không thành công!' : 'Cập nhật thông tin chi tiết phiếu nhập không thành công!'),
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
                                    setTimeout(function () {
                                        $('#modalUpdateDetailItem').modal('show');
                                    }, 250);
                                }
                            }
                        });
                    }
                },
                error: function () {
                    $('#modalUpdateDetailItem').modal('hide');
                    bootbox.confirm({
                        title: (type == 0 ? 'Thêm Mới Chi Tiết Phiếu Nhập' : 'Cập Nhật Thông Tin Chi Tiết Phiếu Nhập'),
                        message: (type == 0 ? 'Thêm mới chi tiết phiếu nhập không thành công!' : 'Cập nhật thông tin chi tiết phiếu nhập không thành công!'),
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
                                setTimeout(function () {
                                    $('#modalUpdateDetailItem').modal('show');
                                }, 250);
                            }
                        }
                    });
                }
            });
        }
    },

    // Delete detail
    deleteDetailItem: function (bookId) {
        let id = [];

        if (bookId) {
            id = [bookId];
        } else {
            $('.ckbDetailItem:checked').each(function (i) {
                id[i] = $(this).val();
            });
        }

        $.ajax({
            url: '/API/ImportDetail/Delete',
            data: {
                importId: detailConfig.importId,
                bookId: id
            },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;
                let message = '';

                for (let i = 0; i < status.length; i++) {
                    if (status[i] > 0) {
                        message += 'Xoá thành công sách #' + id[i] + ' khỏi phiếu nhập<br/>';
                    } else {
                        message += 'Xoá không thành công sách #' + id[i] + ' khỏi phiếu nhập<br/>';
                    }
                }

                importBook.loadData();
                importBook.loadDetail();
                bootbox.alert({ message: message });
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá chi tiết phiếu nhập không thành công!');
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : importBook.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        importBook.registerEvent();
    },

    // FormatValue
    formatValue: function (format, value) {
        switch (format) {
            case 'dd/MM/yyyy': {
                let day = value.getDate();
                let month = value.getMonth() + 1;
                let year = value.getFullYear();

                let result = '';
                result += (day < 10 ? '0' + day : day) + '/';
                result += (month < 10 ? '0' + month : month) + '/';
                result += year;

                return result;
            }
            case 'dd/MM/yyyy hh:mm:ss': {
                let day = value.getDate();
                let month = value.getMonth() + 1;
                let year = value.getFullYear();

                let hour = value.getHours();
                let minute = value.getMinutes();
                let second = value.getSeconds();

                let result = '';
                result += (day < 10 ? '0' + day : day) + '/';
                result += (month < 10 ? '0' + month : month) + '/';
                result += year + ' ';
                result += (hour < 10 ? '0' + hour : hour) + ':';
                result += (minute < 10 ? '0' + minute : minute) + ':';
                result += (second < 10 ? '0' + second : second);

                return result;
            }
            case '#,###': {
                let result = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')

                return result;
            }
        }

        return null;
    },

    // Load staffs
    loadSelectpickerData: function (selectorId, API, value, text, type) {
        let html = $('#' + selectorId).html();

        $('#' + selectorId).html('<option value="' + value + '">' + text + '</option>');
        selectpicker.load(selectorId);

        let linkAPI = `/API/${API}/Gets`;
        $.ajax({
            url: linkAPI,
            data: { page: 0 },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data.length > 0) {
                    let a = '';

                    $.each(data, function (i, item) {
                        let selected = (
                            value.toString().trim() == (type == 'search' ? (API == 'Staff' ? item.Id.trim() : item.MetaTitle) : item.Id.toString().trim())
                        ) ? ' selected' : '';

                        html += `<option value="${type == 'search' ? (API == 'Staff' ? item.Id : item.MetaTitle) : item.Id}" ${selected} >
                                    ${ (API == 'Staff') ? item.FullName : item.Title }                                
                                </option>`;
                    });
                }

                $('#' + selectorId).html(html);
                selectpicker.load(selectorId);
            }
        });
    }

};

importBook.init();