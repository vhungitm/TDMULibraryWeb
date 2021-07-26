var borrowHistoryController = {
    init: function () {
        borrowHistoryController.loadData();
        borrowHistoryController.loadFilter();
    },

    registerEvent: function () {
        $('#btnSearch').off('click').on('click', function () {
            borrowHistoryController.search();
        });
        $('#btnReset').off('click').on('click', function () {
            borrowHistoryController.reset();
        });
    },

    // Get link
    getLink: function () {
        let link = '';

        link += '/lich-su-muon';
        link += (config.id != '') ? ('&id=' + config.id) : '';
        link += (config.staff.id != 0) ? ('&staff=' + config.staff.id.trim()) : '';
        link += (config.book.id != 0) ? ('&book=' + config.book.id) : '';
        link += (config.borrowDate != 0) ? ('&borrowDate=' + config.borrowDate) : '';
        link += (config.returnDate != 0) ? ('&returnDate=' + config.returnDate) : '';
        link += (config.status != 2) ? ('&status=' + config.status) : '';
        link += (config.page.index > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('lich-su-muon&', 'lich-su-muon?');

        window.history.pushState({}, '', link);
    },
    search: function () {
        config.id = $('#nbrIdSearch').val();

        config.staff.id = $('#slStaffSearch option:selected').val();
        config.staff.name = $('#slStaffSearch option:selected').text();

        config.book.id = $('#slBookSearch option:selected').val();
        config.book.title = $('#slBookSearch option:selected').text();

        config.borrowDate = $('#txtBorrowDate').val();
        config.returnDate = $('#txtReturnDate').val();
        config.status = $('#slStatusSearch option:selected').val();

        config.page.index = 1;
        borrowHistoryController.loadData();
    },
    reset: function () {
        config.id = '';
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

        borrowHistoryController.loadFilter();
        borrowHistoryController.loadData();
    },

    // Filter
    loadFilter: function () {
        let html = $('#filterContent').html();

        $('#filter').html(html);

        $('#nbrIdSearch').val(config.id != 0 ? config.id : '');
        borrowHistoryController.loadSelectpickerData('slStaffSearch', 'Staff', config.staff.id, config.staff.name);
        borrowHistoryController.loadSelectpickerData('slBookSearch', 'Book', config.book.id, config.book.title);
        $('#txtBorrowDate').val(config.borrowDate);
        $('#txtReturnDate').val(config.returnDate);
        selectpicker.setSelected('slStatusSearch', config.status, true);
    },

    // Load data
    loadData: function () {
        $.ajax({
            url: '/API/Borrow/Gets',
            data: {
                id: config.id,
                student: config.user.username,
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
                    let html = '';

                    $.each(data, function (i, item) {

                        html += Mustache.render(template, {
                            Id: item.Id,
                            StaffName: item.StaffName,
                            BookId: item.BookId,
                            BookTitle: item.BookTitle,
                            BookMetaTitle: item.BookMetaTitle,
                            BookImage: item.BookImage,
                            BookCategoryMetaTitle: item.BookCategoryMetaTitle,
                            BorrowDate: (item.Status == -1 ? 'Ngày đăng ký: ' : 'Ngày mượn: ') + item.BorrowDate + '<br/>',
                            ReturnDeadline: (item.Status == -1 ? 'Hạn mượn: ' : 'Hạn trả: ') + item.ReturnDeadline + '<br/>',
                            ReturnDate: (item.Status == 1) ? ('Ngày trả: ' + item.ReturnDate + '') : '',
                            Status: `
                                <span class="badge btn-icon-split ${item.Status < 0 ? 'bg-secondary' : (item.Status == 0 ? 'bg-danger' : 'bg-primary')}">
                                   <span class="icon text-white-50">
                                        <i class="fas ${item.Status < 0 ? 'fa-edit' : (item.Status == 0 ? 'fa-times' : 'fa-check')}"></i>
                                    </span>
                                    <span class="text">${item.Status < 0 ? 'Đăng ký mượn' : (item.Status == 0 ? 'Chưa trả' : 'Đã trả')}</span>
                                </span><br/>`
                        });
                    });

                    borrowHistoryController.showData(html, totalPages);
                } else {
                    borrowHistoryController.showData();
                }
            },
            error: function () {
                borrowHistoryController.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let data = $('#data');

        data.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        borrowHistoryController.paging(totalPages ? totalPages : 1);
        borrowHistoryController.registerEvent();
        borrowHistoryController.getLink();
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
                            borrowHistoryController.loadData();
                        }
                    }
                });
            } else {
                $('#lblPagination').hide();
            }
        }
    },

    loadSelectpickerData: function (selectorId, API, value, text) {
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
                        html += `<option value="${ API == 'Staff' ? item.Id : item.MetaTitle}" ${(value.toString().trim() == item.Id.toString().trim()) ? ' selected' : ''}>
                                    ${ (API == 'Staff') ? item.FullName : item.Title}                                
                                </option>`;
                    });
                }

                $('#' + selectorId).html(html);
                selectpicker.load(selectorId);
            }
        });
    }
}

borrowHistoryController.init();