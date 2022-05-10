let searchController = {
    init: function () {
        searchController.loadFilter();
        searchController.loadData();
    },

    registerEvent: function () {
        // Search
        $('#btnSearch').off('click').on('click', function () {
            searchController.search();
        });
        $('#btnReset').off('click').on('click', function () {
            searchController.reset();
        });

        // RegisBorrow
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
                        searchController.regisBorrow(id);
                    }
                }
            });
        })
    },

    // Get link
    getLink: function () {
        let link = '';

        link += '/tim-kiem';
        link += (config.key != '') ? ('&key=' + config.key) : '';
        link += (config.category.id != 0) ? ('&category=' + config.category.id) : '';
        link += (config.publisher.id != 0) ? ('&publisher=' + config.publisher.id) : '';
        link += (config.publishYear != 0) ? ('&publishYear=' + config.publishYear) : '';
        link += (config.page.index > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('tim-kiem&', 'tim-kiem?');

        window.history.pushState({}, '', link);
    },

    // Filter, search
    loadFilter: function () {
        let content = $('#filterContent').html();
        let filter = $('#filter');

        filter.html(content);
        selectpicker.loadAll();
        
        $('#txtKeySearch').val(config.key);
        searchController.loadSelectpickerData('slCategorySearch', 'Category', config.category.id, config.category.name);
        searchController.loadSelectpickerData('slPublisherSearch', 'Publisher', config.publisher.id, config.publisher.name);
        selectpicker.setSelected('slPublishYearSearch', config.publishYear, true);
        selectpicker.setSelected('slStatusSearch', config.status, true);
    },
    search: function () {
        if ($('#txtKeySearch').val()) {
            config.key = $('#txtKeySearch').val();

            config.category.id = $('#slCategorySearch option:selected').val();
            config.category.name = $('#slCategorySearch option:selected').text();

            config.publisher.id = $('#slPublisherSearch option:selected').val();
            config.publisher.name = $('#slPublisherSearch option:selected').text();

            config.publishYear = $('#slPublishYearSearch option:selected').val();
            config.page.index = 1;

            searchController.loadData();
        } else {
            bootbox.alert({message: 'Vui lòng nhập từ khóa tìm kiếm!'})
        }
    },
    reset: function () {
        config.category = {
            id: '',
            name: 'Tất cả thể loại sách'
        };
        config.publisher = {
            id: '',
            name: 'Tất cả nhà xuất bản'
        };
        config.publishYear = 0;
        config.page.index = 1;
        config.page.total = 1;

        searchController.loadFilter();
        searchController.loadData();
    },

    // Load
    loadData: function () {
        $.ajax({
            url: '/API/Book/Gets',
            data: {
                key: config.key,
                category: config.category.id,
                publisher: config.publisher.id,
                publishYear: config.publishYear,
                status: 1,
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

                    let template = $('#bookItem').html();
                    let html = '';

                    $.each(data, function (i, item) {

                        html += Mustache.render(template, {
                            Id: item.Id,
                            Title: item.Title,
                            MetaTitle: item.MetaTitle,
                            CategoryMetaTitle: item.CategoryMetaTitle,
                            Image: item.Image
                        });
                    });

                    searchController.showData(html, totalPages);
                    return;
                }

                searchController.showData();
            },
            error: function () {
                searchController.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        $('#books').html(html ? html : '<div class="alert alert-danger mx-2">Không tìm thấy sách!</div>');
        searchController.paging(totalPages ? totalPages : 0);
        searchController.registerEvent();
        searchController.getLink();
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
                            searchController.loadData();
                        }
                    }
                });
            } else {
                $('#lblPagination').hide();
            }
        }
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : searchController.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        searchController.registerEvent();
    },

    // Load Categoy, publisher
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
                        html += `<option value="${item.MetaTitle}" ${(value.toString().trim() == item.Id.toString().trim()) ? ' selected' : ''}>
                                    ${item.Name}                                
                                </option>`;
                    });
                }

                $('#' + selectorId).html(html);
                selectpicker.load(selectorId);
            }
        });
    }
};

searchController.init();