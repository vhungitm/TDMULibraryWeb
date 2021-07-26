let book = {
    init: function () {
        book.registerEvent();
        book.loadFilter();
        book.loadData();
    },

    registerEvent: function () {
        // Check all
        $('#ckbCheckAll').off('click').on('click', function () {
            book.checkAll();
        });
        $('.ckbItem').off('click').on('click', function () {
            book.checkItem();
        });

        // Search
        $('#btnSearch').off('click').on('click', function () {
            book.search();
        });
        $('#btnReset').off('click').on('click', function () {
            book.reset();
        });
        // Add, update
        $('#btnAdd').off('click').on('click', function () {
            let modal = '#modalUpdate';
            let title = 'Thêm Mới Sách';

            book.showModal(modal, title, book.modalSize.extraLarge);

            book.loadSelectpickerData('slCategory', 'Category', '', 'Chọn thể loại sách');
            book.loadSelectpickerData('slPublisher', 'Publisher', '', 'Chọn nhà xuất bản');
            selectpicker.load('slPublishYear');
            book.showCKEditor('txtDescription');
        });
        $('.btnUpdate').off('click').on('click', function () {
            let id  = $(this).data('id');
            let modal = '#modalUpdate';
            let title = 'Cập Nhật Sách';

            book.showModal(modal, title, book.modalSize.extraLarge);
            book.loadDataItem(id);
        });
        $('.btnUpdateStatus').off('click').on('click', function (e) {
            e.preventDefault();
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Cập Nhật Trạng Thái Sách",
                message: "Cập nhật trạng thái hiển thị của cuốn sách này?",
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
                        book.updateStatus(id);
                    }
                }
            });
        });
        $('#btnSelectImage').off('click').on('click', function (e) {
            e.preventDefault();
            let input = '#image';

            book.showCKFinder(input);
        });
        $('#ckbStatus').off('click').on('click', function () {
            let status = $(this).prop('checked');
            $('label[for="ckbStatus"]').text(status ? 'Hiển thị' : 'Ẩn');
        });
        $('#frmUpdate').validate({
            rules: {
                txtTitle: { required: true },
                txtAuthors: { required: true },
                slCategory: { required: true },
                slPublisher: { required: true },
                nbrQuantity: { required: true },
                nbrPageNumber: { required: true },
                txtSize: { required: true },
                nbrWeight: { required: true },
                slPublishYear: {
                    min: 1990,
                    max: new Date().getFullYear()
                }
            },
            messages: {
                txtTitle: { required: 'Vui lòng nhập tên sách!' },
                txtAuthors: { required: 'Vui lòng nhập tác giả!' },
                slCategory: { required: 'Vui lòng chọn thể loại!' },
                slPublisher: { required: 'Vui lòng chọn nhà xuất bản!' },
                nbrQuantity: { required: 'Vui lòng nhập số lượng bản sao!' },
                nbrPageNumber: { required: 'Vui lòng nhập số trang!' },
                txtSize: { required: 'Vui lòng nhập kích thước!' },
                nbrWeight: { required: 'Vui lòng nhập trọng lượng!' },
                slPublishYear: {
                    min: 'Vui lòng chọn năm xuất bản!',
                    max: 'Vui lòng chọn năm xuất bản!'
                }
            }
        });
        $('#btnSave').off('click').on('click', function () {
            book.save();
        });

        // Delete
        $('.btnDelete').off('click').on('click', function () {
            let id = $(this).data('id');

            bootbox.confirm({
                title: "Xóa Sách",
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
                        book.delete(id);
                    }
                }
            });
        });
        $('#btnDelete').off('click').on('click', function () {
            bootbox.confirm({
                title: "Xóa Sách",
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
                        book.delete(0);
                    }
                }
            });
        });
    },

    // Get link
    getLink: function () {
        let link = '';

        link += '/Admin/Book/Index';
        link += (config.key != '') ? ('&key=' + config.key) : '';
        link += (config.category.id != '') ? ('&category=' + config.category.id) : '';
        link += (config.publisher.id != '') ? ('&publisher=' + config.publisher.id) : '';
        link += (config.publishYear != 0) ? ('&publishYear=' + config.publishYear) : '';
        link += (config.status != 2) ? ('&status=' + config.status) : '';
        link += (config.page.index > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('x&', 'x?');

        window.history.pushState({}, '', link);
    },

    // Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        book.checkItem();
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
        selectpicker.loadAll();
        
        $('#txtKeySearch').val(config.key);
        book.loadSelectpickerData('slCategorySearch', 'Category', config.category.id, config.category.name, 'search');
        book.loadSelectpickerData('slPublisherSearch', 'Publisher', config.publisher.id, config.publisher.name, 'search');
        selectpicker.setSelected('slPublishYearSearch', config.publishYear, true);
        selectpicker.setSelected('slStatusSearch', config.status, true);
    },
    search: function () {
        config.key = $('#txtKeySearch').val();
        config.category.id = $('#slCategorySearch option:selected').val();
        config.category.name = $('#slCategorySearch option:selected').text();

        config.publisher.id = $('#slPublisherSearch option:selected').val();
        config.publisher.name = $('#slPublisherSearch option:selected').text();

        config.publishYear = $('#slPublishYearSearch option:selected').val();
        config.status = $('#slStatusSearch option:selected').val();

        config.page.index = 1;

        book.loadData();
    },
    reset: function () {
        config = {
            key: '',
            category: {
                id: '',
                name: 'Tất cả thể loại sách'
            },
            publisher: {
                id: '',
                name: 'Tất cả nhà xuất bản'
            },
            publishYear: 0,
            status: 2,
            page: {
                index: 1,
                size: 5,
                total: 1
            }
        }

        book.loadFilter();
        book.loadData();
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
                            Title: item.Title,
                            Image: item.Image,
                            Authors: item.Authors,
                            CategoryName: item.CategoryName,
                            PublisherName: item.PublisherName,
                            Quantity: item.Quantity,
                            PageNumber: item.PageNumber,
                            Size: item.Size,
                            Weight: item.Weight,
                            PublishYear: item.PublishYear,
                            Status: (item.Status == 1 ? 'checked' : ''),
                            StatusName: (item.Status == 1 ? 'Hiển thị' : 'Ẩn')
                        });
                    });

                    book.showData(html, totalPages);
                    return;
                }

                book.showData();
            },
            error: function () {
                book.showData();
            }
        })
    },
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        book.showDelete(false);
        book.paging(totalPages ? totalPages : 0);
        book.registerEvent();
        book.getLink();
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
                            book.loadData();
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
            url: '/API/Book/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    $('#nbrId').val(data.Id);
                    $('#txtTitle').val(data.Title);
                    $('#image').prop('src', data.Image);
                    $('#txtAuthors').val(data.Authors);
                    book.loadSelectpickerData('slCategory', 'Category', data.CategoryId, data.CategoryName);
                    book.loadSelectpickerData('slPublisher', 'Publisher', data.PublisherId, data.PublisherName);
                    $('#nbrQuantity').val(data.Quantity);
                    $('#nbrPageNumber').val(data.PageNumber);
                    $('#txtSize').val(data.Size);
                    $('#nbrWeight').val(data.Weight);
                    selectpicker.setSelected('slPublishYear', data.PublishYear, true);
                    $('#txtDescription').val(data.Description);
                    $('#ckbStatus').prop('checked', data.Status);
                    $('label[for="ckbStatus"]').text(data.Status ? 'Hiển thị' : 'Ẩn');
                    book.showCKEditor('txtDescription');
                }
            }
        })
    },
    save: function () {
        if (validation.valid('#frmUpdate')) {
            let id = $('#nbrId').val();
            let image = $('#image').attr('src');
            let title = $('#txtTitle').val();
            let categoryId = $('#slCategory option:selected').val();
            let publisherId = $('#slPublisher option:selected').val();
            let publishYear = $('#slPublishYear option:selected').val();
            let quantity = $('#nbrQuantity').val();
            let pageNumber = $('#nbrPageNumber').val();
            let size = $('#txtSize').val();
            let weight = $('#nbrWeight').val();
            let description = CKEDITOR.instances['txtDescription'].getData();
            let status = $('#ckbStatus').prop('checked') ? 1 : 0;
            let authors = $('#txtAuthors').val();


            let model = {
                Id: id,
                Title: title,
                Authors: authors,
                Image: image,
                CategoryId: categoryId,
                PublisherId: publisherId,
                Quantity: quantity,
                PageNumber: pageNumber,
                Size: size,
                Weight: weight,
                PublishYear: publishYear,
                Description: description,
                Status: status
            };

            let linkAPI = (id == 0) ? '/API/Book/Insert' : '/API/Book/Update';
            let typeAPI = (id == 0) ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    if (response.status) {
                        book.loadData();
                        $('#modalUpdate').modal('hide');

                        bootbox.alert({ message: (id == 0) ? 'Thêm mới sách thành công!' : 'Cập nhật sách thành công!' });
                    } else {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (id == 0) ? 'Thêm mới sách không thành công!' : 'Cập nhật sách không thành công!',
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
                        message: (id == 0) ? 'Thêm mới sách không thành công!' : 'Cập nhật sách không thành công!',
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
            url: '/API/Book/UpdateStatus',
            data: { id: id },
            type: 'PUT',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status) {
                    bootbox.alert({ message: 'Cập nhật trạng thái sách thành công!' });
                    book.loadData();
                } else {
                    bootbox.alert({ message: 'Cập nhật trạng thái sách không thành công!' });
                }
            },
            error: function () {
                bootbox.alert({ message: 'Lỗi hệ thống! Cập nhật trạng thái sách không thành công!' });
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
            url: '/API/Book/Delete',
            data: { id: id },
            type: 'DELETE',
            dataType: 'JSON',
            success: function (response) {
                let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công sách #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công sách #' + id[i] + '<br/>';
                        }
                    }

                    book.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert('Lỗi hệ thống! Xoá sách không thành công!');
                }
            },
            error: function () {
                bootbox.alert('Lỗi hệ thống! Xoá sách không thành công!');
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : book.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        book.registerEvent();
    },

    // CKFinder, CKEditor
    showCKEditor: function (input) {
        CKEDITOR.replace(input);
    },
    showCKFinder: function (input) {
        let ckFinder = new CKFinder();

        ckFinder.selectActionFunction = function (url) {
            $(input).attr('src', url);
        };
        ckFinder.popup();
    },

    // Load Categoy, publisher
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
                        html += `<option value="${type == 'search' ? item.MetaTitle : item.Id}" ${value.toString().trim() == (type == 'search' ? item.MetaTitle : item.Id.toString().trim()) ? ' selected' : ''
                }>
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

book.init();