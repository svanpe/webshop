    create table if not exists order_line_tb (
        id int8 not null,
        productReference varchar(255),
        quantity int8,
        taxPercentage numeric(19, 2),
        totalPriceAndTax numeric(19, 2),
        unitPrice numeric(19, 2),
        unitPriceAndTax numeric(19, 2),
        primary key (id)
    );

    create table if not exists order_tb (
        id int8 not null,
        customerReference varchar(255),
        orderDate bytea,
        status int4,
        primary key (id)
    );

    create table if not exists order_tb_order_line (
        order_tb_id int8 not null,
        orderLines_id int8 not null,
        unique (orderLines_id)
    );



    alter table order_tb_order_line
        add constraint FK74BDF7683F84CE59
        foreign key (orderLines_id)
        references order_line_tb;

    alter table order_tb_order_line
        add constraint FK74BDF768BFAA0CF7
        foreign key (order_tb_id)
        references order_tb;

    create sequence if not exists hibernate_sequence;
