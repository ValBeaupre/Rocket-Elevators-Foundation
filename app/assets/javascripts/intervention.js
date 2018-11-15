function change_client() {
    //console.log($("#client").val());
    $.get("get_buildings_for_client?client_id=" + $("#client").val(), function (list_buildings) {
        console.log('clnt');
        console.log(list_buildings);
        html = "";
        for (var i = 0; i < list_buildings.length; i++) {
            html = html + "<option value='" + list_buildings[i].id + "'>" + list_buildings[i].building_name + "</option>";
        }
        console.log(html);
        //console.log($('#select_building'));
        $('#select_building').append(html);
    });
}

function change_building() {
    console.log('bldg');
    //console.log($("#select_building").val());
    $.get("get_batteries_for_building?building_id=" + $("#select_building").val(), function (list_batteries) {
        console.log("battery");
        console.log(list_batteries);
        html = "";
        for (var i = 0; i < list_batteries.length; i++) {
            html = html + "<option value='" + list_batteries[i].id + "'>" + list_batteries[i].id + "</option>";
        }
        console.log(html);
        //console.log($('#select_battery'));
        $('#select_battery').append(html);
    });
}

function change_battery() {
    console.log("bttr");
    //console.log($("#select_battery").val());
    $.get("get_columns_for_battery?battery_id=" + $("#select_battery").val(), function (list_columns) {
        console.log("column");
        console.log(list_columns);
        html = "";
        for (var i = 0; i < list_columns.length; i++) {
            html = html + "<option value='" + list_columns[i].id + "'>" + list_columns[i].id + "</option>";
        }
        console.log(html);
        //console.log($('#select_column'));
        $('#select_column').append(html);
    })
}

function change_column() {
    console.log("clmn");
    //console.log($("#select_column").val());
    $.get("get_elevators_for_column?column_id=" + $("#select_column").val(), function (list_elevators) {
        console.log("elevator");
        console.log(list_elevators);
        html = "";
        for (var i = 0; i < list_elevators.length; i++) {
            //console.log("for elevator", list_elevators[i].id)
            html = html + "<option value='" + list_elevators[i].id + "'>" + list_elevators[i].id + "</option>";
        }
        //console.log($('#select_elevator'));
        $('#elevator').append(html);
    })
} 