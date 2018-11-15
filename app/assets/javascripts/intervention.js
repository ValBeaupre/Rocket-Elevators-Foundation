function change_client() {
    $.get("get_buildings_for_client?client_id=" + $("#client").val(), function (list_buildings) {
        html = "";
        for (var i = 0; i < list_buildings.length; i++) {
            html = html + "<option value='" + list_buildings[i].id + "'>" + list_buildings[i].building_name + "</option>";
        }
        $('#select_building').append(html);
    });
}

function change_building() {
    $.get("get_batteries_for_building?building_id=" + $("#select_building").val(), function (list_batteries) {
        html = "";
        for (var i = 0; i < list_batteries.length; i++) {
            html = html + "<option value='" + list_batteries[i].id + "'>" + list_batteries[i].id + "</option>";
        }
        $('#select_battery').append(html);
    });
}

function change_battery() {
    $.get("get_columns_for_battery?battery_id=" + $("#select_battery").val(), function (list_columns) {
        html = "";
        for (var i = 0; i < list_columns.length; i++) {
            html = html + "<option value='" + list_columns[i].id + "'>" + list_columns[i].id + "</option>";
        }
        $('#select_column').append(html);
    })
}

function change_column() {
    $.get("get_elevators_for_column?column_id=" + $("#select_column").val(), function (list_elevators) {
        html = "";
        for (var i = 0; i < list_elevators.length; i++) {
            html = html + "<option value='" + list_elevators[i].id + "'>" + list_elevators[i].id + "</option>";
        }
        $('#elevator').append(html);
    })
} 