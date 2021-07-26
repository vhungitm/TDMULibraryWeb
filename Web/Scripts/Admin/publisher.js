let publisher = {
	init: function () {
		publisher.registerEvent();
		publisher.loadData();
		publisher.loadFilter();
	},

	registerEvent: function () {
		// Check all
		$('#ckbCheckAll').off('click').on('click', function () {
			publisher.checkAll();
		});
		$('.ckbItem').off('click').on('click', function () {
            publisher.checkItem();
		});

		// Search
		$('#btnSearch').off('click').on('click', function () {
			publisher.search();
		});
		$('#btnReset').off('click').on('click', function () {
			publisher.reset();
		});

		// Add, update
		$('#btnAdd').off('click').on('click', function () {
			let modal = '#modalUpdate';
			let title = 'Thêm Mới Nhà Xuất Bản';

			publisher.showModal(modal, title);
		});
		$('.btnUpdate').off('click').on('click', function () {
			let id  = $(this).data('id');
			let modal = '#modalUpdate';
			let title = 'Cập Nhật Nhà Xuất Bản';

            publisher.showModal(modal, title);
            publisher.loadDataItem(id);
        });
        $('#frmUpdate').validate({
            rules: {
                txtName: { required: true }
            },
            messages: {
                txtName: { required: 'Vui lòng nhập tên nhà xuất bản!' }
            }
        })
		$('#btnSave').off('click').on('click', function () {
			publisher.save();
		});

		// Delete
		$('.btnDelete').off('click').on('click', function () {
			let id = $(this).data('id');

			bootbox.confirm({
				title: "Xóa Nhà Xuất Bản",
				message: "Xóa nhà xuất bản này khỏi hệ thống?",
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
						publisher.delete(id);
					}
				}
			});
		});
		$('#btnDelete').off('click').on('click', function () {
			bootbox.confirm({
				title: "Xóa Nhà Xuất Bản",
				message: "Xóa những nhà xuất bản đã chọn khỏi hệ thống?",
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
						publisher.delete(0);
					}
				}
			});
		});
	},

    // Get link
    getLink: function () {
        let link = '';

        link += '/Admin/Publisher/Index';
        link += (config.key != '' ? ('?key=' + config.key) : '');
        link += (config.page > 1) ? ('&page=' + config.page.index) : '';

        link = link.replace('x&', 'x?');

        window.history.pushState({}, '', link);
    },

	// Check item
    checkAll: function () {
        let status = $('#ckbCheckAll').prop('checked');

        $('.ckbItem').prop('checked', status);
        publisher.checkItem();
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
        $('#txtKeySearch').val(config.key)
    },
	search: function () {
		config.key = $('#txtKeySearch').val();

		config.page.index = 1;
		publisher.loadData();
	},
	reset: function () {
		config.key = '';
		config.page.index = 1;
		config.page.total = 1;

		publisher.loadFilter();
		publisher.loadData();
	},

	// Load
	loadData: function () {
		$.ajax({
			url: '/API/Publisher/Gets',
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
							Address: item.Address,
							Phone: item.Phone,
							Email: item.Email
						});
					});

					publisher.showData(html, totalPages);
					return;
				}

				publisher.showData();
            },
            error: function () {
                publisher.showData();
			}
		})
	},
    showData: function (html, totalPages) {
        let dataTable = $('#dataTable');

        dataTable.html(html ? html : '<div class="alert alert-danger">Không có dữ liệu!</div>');
        publisher.showDelete(false);
        publisher.paging(totalPages ? totalPages : 0);
        publisher.registerEvent();
        publisher.getLink();
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
                            publisher.loadData();
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
            url: '/API/Publisher/Get',
            data: { id: id },
            type: 'GET',
            dataType: 'JSON',
            success: function (response) {
                let data = response.data;

                if (data != null) {
                    $('#nbrId').val(data.Id);
                    $('#txtName').val(data.Name);
                    $('#txtAddress').val(data.Address);
                    $('#txtPhone').val(data.Phone);
                    $('#txtEmail').val(data.Email);
                }
            }
        })
    },
	save: function () {
        if ($('#frmUpdate').valid()) {
            let id = $('#nbrId').val();
            let name = $('#txtName').val();
            let address = $('#txtAddress').val();
            let phone = $('#txtPhone').val();
            let email = $('#txtEmail').val();

            let model = {
                Id: id,
                Name: name,
                Address: address,
                Phone: phone,
                Email: email
            };

            let linkAPI = (id == 0) ? '/API/Publisher/Insert' : '/API/Publisher/Update';
            let typeAPI = (id == 0) ? 'POST' : 'PUT';

            $.ajax({
                url: linkAPI,
                data: model,
                type: typeAPI,
                dataType: 'JSON',
                success: function (response) {
                    if (response.status) {
                        publisher.loadData();
                        $('#modalUpdate').modal('hide');

                        bootbox.alert({ message: (id == 0) ? 'Thêm mới nhà xuất bản thành công!' : 'Cập nhật nhà xuất bản thành công!' });
                    } else {
                        $('#modalUpdate').modal('hide');
                        bootbox.confirm({
                            message: (id == 0) ? 'Thêm mới nhà xuất bản không thành công!' : 'Cập nhật nhà xuất bản không thành công!',
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
                        message: (id == 0) ? 'Thêm mới nhà xuất bản không thành công!' : 'Cập nhật nhà xuất bản không thành công!',
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
			url: '/API/Publisher/Delete',
			data: { id: id },
			type: 'DELETE',
			dataType: 'JSON',
			success: function (response) {
				let status = response.status;

                if (status != 0) {
                    let message = '';

                    for (let i = 0; i < status.length; i++) {
                        if (status[i] > 0) {
                            message += 'Xoá thành công nhà xuất bản #' + id[i] + '<br/>';
                        } else {
                            mesage += 'Xoá không thành công nhà xuất bản #' + id[i] + '<br/>';
                        }
                    }

                    publisher.loadData();
                    bootbox.alert({ message: message });
                } else {
                    bootbox.alert({ message: 'Lỗi hệ thống! Xoá nhà xuất bản không thành công!' });
                }
			},
			error: function () {
				bootbox.alert('Lỗi hệ thống! Xoá nhà xuất bản không thành công!');
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
        $(modal).find('div').eq(0).attr('class', size != null ? size : publisher.modalSize.default);
        $(modal).find('.modal-title').text(title);
        $(modal).find('.modal-body').html($(body).html());
        $(modal).modal('show');

        publisher.registerEvent();
    },
};

publisher.init();