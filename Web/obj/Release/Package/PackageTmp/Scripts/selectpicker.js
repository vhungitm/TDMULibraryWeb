var selectpicker = {
    registerEvent: function () {
        $('.dropdown.selectpicker .dropdown-menu input.selectpicker-search').off('keyup').on('keyup', function () {
            let id = $(this).parents('.dropdown').attr('for');

            selectpicker.search(id);
        });

        $('.dropdown.selectpicker .dropdown-menu .dropdown-items .dropdown-item').off('click').on('click', function () {
            selectpicker.selectItem($(this));
        });
    },

    loadAll: function () {
        let selects = $('select.selectpicker');

        $.each(selects, function (i, select) {
            let id = select.getAttribute('id');

            selectpicker.load(id);
        });

        selectpicker.registerEvent();
    },

    search: function (id) {
        selectpicker.loadItems(id);
    },

    selectItem: function (item) {
        let id = item.parents('.dropdown.selectpicker').attr('for');
        let value = item.data('id');
        let options = `select#${id}.selectpicker option`;
        let option = `${options}[value="${value}"]`;
        let selected = $(option).prop('selected');
        
        let selectedQuantity = $(`${options}:selected`).length;

        $(option).prop('selected', !selected ? true : ( selectedQuantity > 1 ? !selected : true ));
        $(`.dropdown.selectpicker[for="${id}"] input.selectpicker-search`).val('');

        $(`select#${id}.selectpicker`).change();
        selectpicker.valid(id);
        selectpicker.load(id);
    },

    setSelected: function (id, value, selected) {
        $(`select#${id} option[value="${value}"]`).prop('selected', selected);
        selectpicker.load(id);
    },

    load: function (id) {
        let select = $(`select#${id}.selectpicker`);
        let count = $(`.dropdown.selectpicker[for="${id}"]`).length;

        if (count == 0) {
            let selectClass = select.attr('class');

            let html = '';
            html += `<div class="dropdown selectpicker" for="${id}">`;
            html += `<button class="${selectClass} form-select" data-bs-toggle="dropdown"></button>`;
            html += '<div class="dropdown-menu" style="width: 100%">';

            // Search
            let search = select.data('search');
            let searchPlaceholder = select.data('search-placeholder');
            searchPlaceholder = searchPlaceholder ? searchPlaceholder : 'Từ khóa';

            if (search) {
                html += `
                    <div class="dropdown-search">
                        <input class="selectpicker-search form-control" type="text" placeholder="${searchPlaceholder}"/>
                    </div>`;
            }

            html += '<div class="dropdown-items">';
            html += '</div>';
            html += '</div>';
            html += '</div>';

            $(select).before(html);
            selectpicker.loadItems(id);
        } else {
            selectpicker.loadItems(id);
        }
    },

    loadItems: function (id) {
        let selectedOptions = $('#' + id + ' option:selected');
        let options = $('#' + id + ' option:not(:selected)');
        let html = '';

        html += selectpicker.loadItem(id, selectedOptions);
        html += selectpicker.loadItem(id, options);
        
        $('.dropdown[for="' + id + '"] .dropdown-items').html(html);

        selectpicker.registerEvent();
    },

    loadItem: function (id, options) {
        let html = '';
        let selectedText = '';
        let search = $(`.dropdown[for="${id}"].selectpicker .dropdown-menu input.selectpicker-search`);
        let key = search.length > 0 ? search.val() : '';

        $.each(options, function (i, option) {
            let selected = option.selected;
            let optionClass = option.getAttribute('class') ? ' ' + option.getAttribute('class') : '';
            let newClass = 'dropdown-item' + (selected ? ' active' : '') + optionClass;
            let value = option.value;
            let text = option.text;

            let textValidate = (text.toLowerCase().search(key.toLowerCase()) >= 0) ? true : false;
            let valueValidate = value.toLowerCase().search(key.toLowerCase()) >= 0 ? true : false;

            if (textValidate || valueValidate) {
                html += '<button type="button" class="' + newClass + '" data-id="' + value + '">' + text + '</button>';
            }
            selectedText += selected ? (', ' + text) : '';
        });

        let button = $(`.dropdown[for="${id}"] button.selectpicker`);
        button.text(selectedText ? selectedText.substring(2) : button.text());

        return html;
    },

    valid: function (id) {
        try {
            $(`#${id}`).valid();

            if ($(`label#${id}-error.error:not([style="display: none;"])`).length > 0) {
                $(`.dropdown.selectpicker[for="${id}"] button.form-control`).addClass('error');
            } else {
                $(`.dropdown.selectpicker[for="${id}"] button.form-control`).removeClass('error');
            }
        } catch (error) {}
    }
}

var validation = {
    valid: function (id) {
        try {
            selects = $(`${id} select.selectpicker`);

            $.each(selects, function (i, item) {
                selectpicker.valid(item.getAttribute('id'));
            });

            return $(id).valid();
        } catch (error) {
            return false;
        }
    }
}

selectpicker.loadAll();