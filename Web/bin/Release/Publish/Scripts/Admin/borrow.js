let borrow = {
    init: function () {
        borrow.registerEvent();
        borrow.loadFilter();
        borrow.loadData();
    },

    registerEvent: function () {
        // Check all
        $('#ckbCheckAll').off('click').on('click', function () {
            borrow.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            borrow.checkItem();
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            borrow.search();
        });
        $('#btnReset').off('click').on('click', function () {
            borrow.reset();
        });

        // Add, update
        $('#btnAdd').off('click').on('click', function () {
            let modal = '#modalUpdate';
            let title = 'Thêm Mới Phiếu Mượn';

            borrow.showModal(modal, title);
            selectpicker.loadAll();

            borrow.loadStudents('slStudent', '', 'Chọn sinh viên');
            borrow.loadStaffs('slStaff', '', 'Chọn nhân viên');
            borrow.loadBooks('slBook', '', 'Chọn sách');

            $('#dtBorrowDate').parent().hide();
        });
        $('.btnUpdate').off('click').on('click', function () {
            let id  = $(this).data('id');
            let modal = '#modalUpdate';
            let title = 'Cập Nhật Thông Tin Phiếu Mượn';

            borrow.showModal(modal, title);
            borrow.loadDataItem(id);
        });
        $('.btnChangeStatus').off('click').on('click', function (e) {
            e.preventDefault();

            let id = $(this).data('id');
            let status = $(this).data('status');

            bootbox.confirm({
                title: "Cập Nhật Trạng Thái Mượn Sách",
                message: "Cập nhật trạng thái của phiếu mượn này?",
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
                        borrow.updateStatus(id, status);
                    }
                }
            });
        });
        $('#slStatus').off('change').on('change', function () {
            let status = $('#slStatus option:selected').val();

            if (status == 1) $('#dtReturnDate').parent().show();
            else $('#dtReturnDate').parent().hide();
        });
        $('#frmUpdate').validate({
            rules: {
                slStudent: {
                    required: true
                },
                slStaff: {
                    required: true
                },
                slBook: {
                    min: 1
                }
            },
            messages: {
                slStudent: {
                    required: 'Vui lòng chọn sinh viên!'
                },
                slStaff: {
                    required: 'Vui lòng chọn nhân viên!'
                },
                slBook: {
                    min: 'Vui lòng chọn sách!'
                }
            }
        });
        $('#btnSave').off('click').on('click', function () {
            borrow.save();
        });

        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Thể Sách",
                message: "Xóa sách này khỏi hệ thống?",
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
                        borrow.delete(id);
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
                        borrow.delete(0);
                    }
                }
            });
        });
    },

    // Get link
    getLink: function () {
        let link = '';

        link += '/Admin/Borrow/Index';
        link += (config.id != '') ? ('&id=' + config.id) : '';
        link += (config.student.id != '') ? ('&student=' + config.student.id.trim()) : '';
        link += (config.staff.id != '') ? ('&staff=' + config.staff.id.trim()) : '';
        link += (config.book.id != '') ? ('&book=' + config.book.id) : '';
        link += (config.borrowDate != '') ? ('&borrowDate=' + config.borrowDate) : '';
        link += (config.returnDate != '') ? ('&returnDate=' + config.returnDate) : '';
        link += (config.status != 2) ? ('&status=' + config.status) : '';
        link += (config.page.index > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('x&', 'x?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        borrow.checkItem();
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

        $('#nbrIdSearch').val(config.id != 0 ? config.id : '');

        borrow.loadStudents('slStudentSearch', config.student.id, config.student.name);
        borrow.loadStaffs('slStaffSearch', config.staff.id, config.staff.name);
        borrow.loadBooks('slBookSearch', config.book.id, config.book.title, 'search');

        $('#txtBorrowDate').val(config.borrowDate);
        $('#txtReturnDate').val(config.returnDate);
        selectpicker.setSelected('slStatusSearch', config.status, true);
    },
    search: function () {
        config.id = $('#nbrIdSearch').val();

        config.student.id = $('#slStudentSearch option:selected').val();
        config.student.name = $('#slStudentSearch option:selected').text();


        config.staff.id = $('#slStaffSearch option:selected').val();
        config.staff.name = $('#slStaffSearch option:selected').text();

        config.book.id = $('#slBookSearch option:selected').val();
        config.book.title = $('#slBookSearch option:selected').text();

        config.borrowDate = $('#txtBorrowDate').val();
        config.returnDate = $('#txtReturnDate').val();
        config.status = $('#slStatusSearch option:selected').val();

        config.page.index = 1;
        borrow.loadData();
    },
    reset: function () {
        config.id = '';
        config.student = {
            id: '',
            name: 'Tất cả sinh viên'
        };
        config.staff = {
            id: '',
            name: 'Tất cả nhân viên'
        };
        config.book = {
            id: '',
            title: 'Tất cả sách'
        };
        config.borrowDate = '';
        config.returnDate = '';
        config.status = 2;
        config.page.index = 1;
        config.page.total = 1;

        borrow.loadFilter();
        borrow.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Borrow/Gets',
            data: {
                id: config.id,
                student: config.student.id,
                staff: config.staff.id,
                book: config.book.id,
                borrowDate: config.borrowDate,
                returnDate: config.returnDate,
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
                            StudentId: item.StudentId,
                            StudentName: item.StudentName,
                            StaffId: item.StaffId,
                            StaffName: item.StaffName,
                            BookId: item.BookId,
                            BookTitle: item.BookTitle,
                            BorrowDate: (item.Status < 0 ? 'Ngày đăng ký: ' : 'Ngày mượn: ') + item.BorrowDate + '<br/>',
                            ReturnDeadline: (item.Status < 0 ? 'Ngày hẹn mượn: ' : 'Hạn trả: ') + item.ReturnDeadline + '<br/>',
                            ReturnDate: (item.Status == 1) ? ('Ngày trả: ' + item.ReturnDate + '') : '',
                            Status: `
                                <div class="dropdown">
                                    <button id="slBorrowStatus-${item.Id}" data-id="${item.Id}" data-status="${item.Status}" class="btnChangeStatus btn btn-${item.Status == -1 ? 'secondary' : (item.Status == 1 ? 'primary' : 'danger')} btn-icon-split" data-bs-toggle="dropdown">
                                        <span class="icon text-white-50">
                                            <i class="fas ${item.Status < 0 ? 'fa-edit' : (item.Status == 0 ? 'fa-times' : 'fa-check')}"></i>
                                        </span>
                                        <span class="text">
                                            ${item.Status < 0 ? 'Đăng ký mượn' : (item.Status == 0 ? 'Chưa trả' : 'Đã trả')}
                                        </span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="#" data-id="${item.Id}" data-status="-1" class="btnChangeStatus dropdown-item${item.Status < 0 ? ' active' : ''}">${item.Status < 0 ? '<i class="fas fa-check"></i> ' : ''}Đăng ký mượn</a>
                                        </li>
                                        <li>
                                            <a href="#" data-id="${item.Id}" data-status="1" class="btnChangeStatus dropdown-item${item.Status > 0 ? ' active' : ''}">${item.Status > 0 ? '<i class="fas fa-check"></i> ' : ''}Đã trả</a>
                                        </li>
                                        <li>
                                            <a href="#" data-id="${item.Id}" data-status="0" class="btnChangeStatus dropdown-item${item.Status == 0 ? ' active' : ''}">${item.Status == 0 ? '<i class="fas fa-check"></i> ' : ''}Chưa trả</a>
                                        </li>
                                    </ul>
                                </div>
                            `
                        });
                    });

                    borrow.showData(html, totalPages);
                } else {
                    borrow.showData();
                }
            },
            error: function () {
                borrow.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        borrow.showDelete(false);
        borrow.paging(totalPages ? totalPages : 0);
        borrow.registerEvent();
        borrow.getLink();
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
                            borrow.loadData();
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
            url: '/API/Borrow/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    // Borrow Date
                    let arrBorrowDate = data.BorrowDate.split('/');
                    let borrowDate = arrBorrowDate[2] + '-' + arrBorrowDate[1] + '-' + arrBorrowDate[0];

                    $('#dtBorrowDate').val(borrowDate);

                    // Return Date
                    if (data.ReturnDate != null && data.Status == 1) {
                        let arrReturnDate = data.ReturnDate.split('/');
                        let returnDate = arrReturnDate[2] + '-' + arrReturnDate[1] + '-' + arrReturnDate[0];

                        $('#dtReturnDate').val(returnDate)
                    } else {
                        $('#dtReturnDate').parent().hide();
                    }
                    $('#nbrId').val(data.Id);

                    borrow.loadStudents('slStudent', data.StudentId, data.StudentName);
                    borrow.loadStaffs('slStaff', data.StaffId, data.StaffName);
                    borrow.loadBooks('slBook', data.BookId, data.BookTitle);
                    selectpicker.setSelected('slStatus', data.Status, true);
                }
            }
        })
    },
    save: function () {
        if (validation.valid('#frmUpdate')) {
            let id = $('#nbrId').val();
            let studentId = $('#slStudent option:selected').val();
            let staffId = $('#slStaff option:selected').val();
            let bookId = $('#slBook option:selected').val();
            let borrowDate = $('#dtBorrowDate').val();
            let returnDate = $('#dtReturnDate').val();
            let status = $('#slStatus option:selected').val();

            let model = {
                Id: id,
                StudentId: studentId,
                StaffId: staffId,
                BookId: bookId,
                BorrowDate: borrowDate,
                ReturnDate: returnDate,
                Status: status
            };

            let linkAPI = (id == 0) ? '/API/Borrow/Insert' : '/API/Borrow/Update';
            let typeAPI = (id == 0) ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    let status = response.status;

                    if (status == 1) {
                        borrow.loadData();
                        $('#modalUpdate').modal('hide');

                        bootbox.alert({ message: (id == 0) ? 'Thêm mới phiếu mượn thành công!' : 'Cập nhật phiếu mượn thành công!' });
                    } else if (status == -1) {
                        bootbox.alert({
                            message: (id == 0) ?
                                'Thêm mới phiếu mượn không thành công! Sinh viên đang mượn hoặc đã đăng ký mượn cuốn sách này!' :
                                'Cập nhật phiếu mượn không thành công! Sinh viên đang mượn hoặc đã đăng ký mượn cuốn sách này!'
                        });
                    } else if (status == -2) {
                        bootbox.alert({
                            message: (id == 0) ?
                                'Thêm mới phiếu mượn không thành công! Số lượng trong kho không đủ!' :
                                'Cập nhật phiếu mượn không thành công! Số lượng trong kho không đủ!'
                        });
                    } else {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (id == 0) ? 'Thêm mới phiếu mượn không thành công!' : 'Cập nhật phiếu mượn không thành công!',
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
                        message: (id == 0) ? 'Thêm mới phiếu mượn không thành công!' : 'Cập nhật phiếu mượn không thành công!',
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
    updateStatus: function (id, status) {
        let model = { Id: id, Status: status };

        $.ajax({
            url: '/API/Borrow/UpdateStatus',
            data: model,
            type: 'PUT',
            dataType: 'JSON',
            success: function (response) {
                if (response.status) {
                    borrow.loadData();

                    bootbox.alert({ message: 'Cập nhật trạng thái phiếu mượn thành công!'});
                } else {
                    bootbox.alert({ message: 'Cập nhật trạng thái phiếu mượn không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Cập nhật trạng thái phiếu mượn không thành công!' });
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
            url: '/API/Borrow/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công phiếu mượn #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công phiếu mượn #' + id[i] + '<br/>';
                        }
                    }

                    borrow.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá phiếu mượn không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá phiếu mượn không thành công!');
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : borrow.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        borrow.registerEvent();
    },

    // Load staffs
    loadStaffs: function (id, value, text) {
        let html = $(`#${id}`).html();

        $(`#${id}`).html(`<option value="${value}">${text}</option>`);
        selectpicker.load(`${id}`);
        
        $.ajax({
            url: '/API/Staff/Gets',
            data: { page: 0 },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data) {
                    $.each(data, function (i, item) {
                        let ipValue = item.Id.trim();
                        let ipSelected = item.Id.trim() == value.trim() ? 'selected' : '';
                        let ipText = item.FullName;

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

    // Load Students
    loadStudents: function (id, value, text) {
        let html = $(`#${id}`).html();

        $(`#${id}`).html(`<option value="${value}">${text}</option>`);
        selectpicker.load(`${id}`);

        $.ajax({
            url: '/API/Student/Gets',
            data: { page: 0 },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data) {
                    $.each(data, function (i, item) {
                        let ipValue = item.Id.trim();
                        let ipSelected = item.Id.trim() == value.trim() ? 'selected' : '';
                        let ipText = item.FullName;

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

    loadBooks: function (id, value, text, type) {
        let html = $(`#${id}`).html();

        $(`#${id}`).html(`<option value="${value}">${text}</option>`);
        selectpicker.load(`${id}`);

        $.ajax({
            url: '/API/Book/Gets',
            data: { page: 0 },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data) {
                    $.each(data, function (i, item) {
                        let ipValue = type == 'search' ? item.MetaTitle : item.Id.toString().trim();
                        let ipSelected = (type == 'search' ? item.MetaTitle : item.Id) == value ? 'selected' : '';
                        let ipText = item.Title;

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

borrow.init();