$(document).ready(function() {
    $.ajax({
        url: "/api/orders?customerReference=ABX777"
    }).then(function(data) {

        data.forEach(function (order) {

            $('#orderTable')
                .append("<tr> <td>" + order.id + "</td><td>" +order.customerReference + "</td></tr>");

        });


    });
});