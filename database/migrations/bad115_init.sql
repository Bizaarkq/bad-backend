/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     19/05/2023 10:40:54 p. m.                    */
/*==============================================================*/


drop index BODEGA_PK;

drop table BODEGA;

drop index ALMACENA_FK;

drop index ALMACENA2_FK;

drop index ALMACENA_PK;

drop table BODEGAPRODUCTOS;

drop index CATERGORIA_PK;

drop table CATERGORIA;

drop index CLIENTE_PK;

drop table CLIENTE;

drop index PROGRAMA_FK;

drop index ENVIO_PK;

drop table ENVIO;

drop index EMITE_FK;

drop index FACTURA_PK;

drop table FACTURA;

drop index TIENE_FK;

drop index PAGOS_PK;

drop table PAGO;

drop index REALIZA_FK;

drop index PEDIDO_PK;

drop table PEDIDO;

drop index PEDIDOPRODUCTO_FK;

drop index PEDIDOPRODUCTO4_FK;

drop index PEDIDOPRODUCTO3_FK;

drop index PEDIDOPRODUCTO2_FK;

drop index PEDIDOPRODUCTO_PK;

drop table PEDIDOPRODUCTO;

drop index PRODUCTO_PK;

drop table PRODUCTO;

drop index PROVEEDOR_PK;

drop table PROVEEDOR;

drop index PROVEE_FK;

drop index PROVEE2_FK;

drop index PROVEE_PK;

drop table PROVEEDORPRODUCTOS;

drop index EJECUTA_FK;

drop index SEGUIMIENTO_PK;

drop table SEGUIMIENTO;

drop index POSEE_FK;

drop index SUBCATEGORIAS_PK;

drop table SUBCATEGORIAS;

drop index CATEGORIZA_FK;

drop index CATEGORIZA2_FK;

drop index CATEGORIZA_PK;

drop table SUBCATEGORIASPRODUCTOS;

/*==============================================================*/
/* Table: BODEGA                                                */
/*==============================================================*/
create table BODEGA (
   ID_BODEGA            INT4                 not null,
   NOMBRE               VARCHAR(50)          not null,
   DIRECCION            VARCHAR(200)         null,
   LATITUDE             DECIMAL(15,12)       not null,
   LONGITUD             DECIMAL(15,12)       not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_BODEGA primary key (ID_BODEGA)
);

/*==============================================================*/
/* Index: BODEGA_PK                                             */
/*==============================================================*/
create unique index BODEGA_PK on BODEGA (
ID_BODEGA
);

/*==============================================================*/
/* Table: BODEGAPRODUCTOS                                       */
/*==============================================================*/
create table BODEGAPRODUCTOS (
   ID_PROD              INT4                 not null,
   ID_BODEGA            INT4                 not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_BODEGAPRODUCTOS primary key (ID_PROD, ID_BODEGA)
);

/*==============================================================*/
/* Index: ALMACENA_PK                                           */
/*==============================================================*/
create unique index ALMACENA_PK on BODEGAPRODUCTOS (
ID_PROD,
ID_BODEGA
);

/*==============================================================*/
/* Index: ALMACENA2_FK                                          */
/*==============================================================*/
create  index ALMACENA2_FK on BODEGAPRODUCTOS (
ID_BODEGA
);

/*==============================================================*/
/* Index: ALMACENA_FK                                           */
/*==============================================================*/
create  index ALMACENA_FK on BODEGAPRODUCTOS (
ID_PROD
);

/*==============================================================*/
/* Table: CATERGORIA                                            */
/*==============================================================*/
create table CATERGORIA (
   ID_CAT               INT4                 not null,
   NOMBRE               VARCHAR(50)          not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_CATERGORIA primary key (ID_CAT)
);

/*==============================================================*/
/* Index: CATERGORIA_PK                                         */
/*==============================================================*/
create unique index CATERGORIA_PK on CATERGORIA (
ID_CAT
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_CLI               INT4                 not null,
   NOMBRES              VARCHAR(50)          not null,
   APELLIDOS            VARCHAR(50)          not null,
   DIRECCION            VARCHAR(200)         null,
   CORREO               VARCHAR(50)          not null,
   FECHA_NACIMIENTO     DATE                 null,
   SEXO                 VARCHAR(1)           null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_CLIENTE primary key (ID_CLI)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique index CLIENTE_PK on CLIENTE (
ID_CLI
);

/*==============================================================*/
/* Table: ENVIO                                                 */
/*==============================================================*/
create table ENVIO (
   ID_ENV               INT4                 not null,
   ID_PED               INT4                 not null,
   CODIGO               VARCHAR(10)          not null,
   FECHA                DATE                 not null,
   DIRECCION_ORIGEN     VARCHAR(150)         not null,
   DIRECCION_DESTINO    VARCHAR(150)         not null,
   METODO_ENVIO         VARCHAR(50)          not null,
   ESTADO_ACTUAL        VARCHAR(20)          not null,
   FECHA_ENTREGA_ESTIMADA DATE                 null,
   COSTO_ENVIO          DECIMAL(6,2)         not null,
   NOTAS                VARCHAR(250)         null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_ENVIO primary key (ID_ENV)
);

/*==============================================================*/
/* Index: ENVIO_PK                                              */
/*==============================================================*/
create unique index ENVIO_PK on ENVIO (
ID_ENV
);

/*==============================================================*/
/* Index: PROGRAMA_FK                                           */
/*==============================================================*/
create  index PROGRAMA_FK on ENVIO (
ID_PED
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   ID_FAC               INT4                 not null,
   ID_PED               INT4                 not null,
   CODIGO               VARCHAR(10)          not null,
   FECHA_EMISION        DATE                 not null,
   DIRECCION_FACTURACION VARCHAR(150)         null,
   SUBTOTAL             DECIMAL(10,2)        not null,
   IMPUESTOS            DECIMAL(10,2)        not null,
   DESCUENTOS           DECIMAL(10,2)        not null,
   TOTAL                DECIMAL(10,2)        not null,
   METODO_PAGO          VARCHAR(20)          not null,
   ESTADO_PAGO          VARCHAR(10)          null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_FACTURA primary key (ID_FAC)
);

/*==============================================================*/
/* Index: FACTURA_PK                                            */
/*==============================================================*/
create unique index FACTURA_PK on FACTURA (
ID_FAC
);

/*==============================================================*/
/* Index: EMITE_FK                                              */
/*==============================================================*/
create  index EMITE_FK on FACTURA (
ID_PED
);

/*==============================================================*/
/* Table: PAGO                                                  */
/*==============================================================*/
create table PAGO (
   ID_PAG               INT4                 not null,
   ID_FAC               INT4                 not null,
   FECHA_PAGO           DATE                 not null,
   MONTO                DECIMAL(10,2)        not null,
   DESCRIPCION          VARCHAR(200)         null,
   ESTADO_ACTUAL        VARCHAR(20)          not null,
   NUM_REFERENCIA       VARCHAR(20)          not null,
   NOTAS                VARCHAR(250)         null,
   COLECTOR             VARCHAR(50)          not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_PAGO primary key (ID_PAG)
);

/*==============================================================*/
/* Index: PAGOS_PK                                              */
/*==============================================================*/
create unique index PAGOS_PK on PAGO (
ID_PAG
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create  index TIENE_FK on PAGO (
ID_FAC
);

/*==============================================================*/
/* Table: PEDIDO                                                */
/*==============================================================*/
create table PEDIDO (
   ID_PED               INT4                 not null,
   ID_CLI               INT4                 not null,
   CODIGO               VARCHAR(10)          not null,
   FECHA                DATE                 not null,
   ESTADO_ACTUAL        VARCHAR(20)          not null,
   TOTAL                DECIMAL(10,2)        null,
   NOTAS                VARCHAR(250)         null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_PEDIDO primary key (ID_PED)
);

/*==============================================================*/
/* Index: PEDIDO_PK                                             */
/*==============================================================*/
create unique index PEDIDO_PK on PEDIDO (
ID_PED
);

/*==============================================================*/
/* Index: REALIZA_FK                                            */
/*==============================================================*/
create  index REALIZA_FK on PEDIDO (
ID_CLI
);

/*==============================================================*/
/* Table: PEDIDOPRODUCTO                                        */
/*==============================================================*/
create table PEDIDOPRODUCTO (
   ID_PROD              INT4                 not null,
   ID_PED               INT4                 not null,
   ID_ENV               INT4                 not null,
   ID_BODEGA            INT4                 not null,
   DESCUENTO            DECIMAL(10,2)        null,
   NOTAS                VARCHAR(250)         null,
   CANTIDAD             INT4                 not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_PEDIDOPRODUCTO primary key (ID_PROD, ID_PED, ID_ENV, ID_BODEGA)
);

/*==============================================================*/
/* Index: PEDIDOPRODUCTO_PK                                     */
/*==============================================================*/
create unique index PEDIDOPRODUCTO_PK on PEDIDOPRODUCTO (
ID_PROD,
ID_PED,
ID_ENV,
ID_BODEGA
);

/*==============================================================*/
/* Index: PEDIDOPRODUCTO2_FK                                    */
/*==============================================================*/
create  index PEDIDOPRODUCTO2_FK on PEDIDOPRODUCTO (
ID_PROD
);

/*==============================================================*/
/* Index: PEDIDOPRODUCTO3_FK                                    */
/*==============================================================*/
create  index PEDIDOPRODUCTO3_FK on PEDIDOPRODUCTO (
ID_PED
);

/*==============================================================*/
/* Index: PEDIDOPRODUCTO4_FK                                    */
/*==============================================================*/
create  index PEDIDOPRODUCTO4_FK on PEDIDOPRODUCTO (
ID_ENV
);

/*==============================================================*/
/* Index: PEDIDOPRODUCTO_FK                                     */
/*==============================================================*/
create  index PEDIDOPRODUCTO_FK on PEDIDOPRODUCTO (
ID_BODEGA
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_PROD              INT4                 not null,
   NOMBRE               VARCHAR(50)          not null,
   PRECIO               DECIMAL(10,2)        not null,
   MARCA                VARCHAR(50)          null,
   DESCRIPCION          VARCHAR(200)         null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_PRODUCTO primary key (ID_PROD)
);

/*==============================================================*/
/* Index: PRODUCTO_PK                                           */
/*==============================================================*/
create unique index PRODUCTO_PK on PRODUCTO (
ID_PROD
);

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table PROVEEDOR (
   ID_PROV              INT4                 not null,
   NOMBRE               VARCHAR(50)          not null,
   DIRECCION            VARCHAR(200)         null,
   CONTACTO             VARCHAR(50)          null,
   TELEFONO             VARCHAR(20)          null,
   CORREO               VARCHAR(50)          null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_PROVEEDOR primary key (ID_PROV)
);

/*==============================================================*/
/* Index: PROVEEDOR_PK                                          */
/*==============================================================*/
create unique index PROVEEDOR_PK on PROVEEDOR (
ID_PROV
);

/*==============================================================*/
/* Table: PROVEEDORPRODUCTOS                                    */
/*==============================================================*/
create table PROVEEDORPRODUCTOS (
   ID_PROD              INT4                 not null,
   ID_PROV              INT4                 not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_PROVEEDORPRODUCTOS primary key (ID_PROD, ID_PROV)
);

/*==============================================================*/
/* Index: PROVEE_PK                                             */
/*==============================================================*/
create unique index PROVEE_PK on PROVEEDORPRODUCTOS (
ID_PROD,
ID_PROV
);

/*==============================================================*/
/* Index: PROVEE2_FK                                            */
/*==============================================================*/
create  index PROVEE2_FK on PROVEEDORPRODUCTOS (
ID_PROV
);

/*==============================================================*/
/* Index: PROVEE_FK                                             */
/*==============================================================*/
create  index PROVEE_FK on PROVEEDORPRODUCTOS (
ID_PROD
);

/*==============================================================*/
/* Table: SEGUIMIENTO                                           */
/*==============================================================*/
create table SEGUIMIENTO (
   ID_SEG               INT4                 not null,
   ID_ENV               INT4                 not null,
   ESTADO_ACTUAL        VARCHAR(20)          not null,
   FECHA_HORA_UPDATE    DATE                 not null,
   UBICACION_ACTUAL     VARCHAR(150)         not null,
   DESCRIPCION          VARCHAR(200)         null,
   NOTAS                VARCHAR(250)         null,
   RESPONSABLE          VARCHAR(50)          not null,
   NIVEL_URGENCIA       VARCHAR(20)          null,
   ESTADO_PREVIO        VARCHAR(20)          null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_SEGUIMIENTO primary key (ID_SEG)
);

/*==============================================================*/
/* Index: SEGUIMIENTO_PK                                        */
/*==============================================================*/
create unique index SEGUIMIENTO_PK on SEGUIMIENTO (
ID_SEG
);

/*==============================================================*/
/* Index: EJECUTA_FK                                            */
/*==============================================================*/
create  index EJECUTA_FK on SEGUIMIENTO (
ID_ENV
);

/*==============================================================*/
/* Table: SUBCATEGORIAS                                         */
/*==============================================================*/
create table SUBCATEGORIAS (
   ID_SUB               INT4                 not null,
   ID_CAT               INT4                 not null,
   NOMBRE               VARCHAR(50)          not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_SUBCATEGORIAS primary key (ID_SUB)
);

/*==============================================================*/
/* Index: SUBCATEGORIAS_PK                                      */
/*==============================================================*/
create unique index SUBCATEGORIAS_PK on SUBCATEGORIAS (
ID_SUB
);

/*==============================================================*/
/* Index: POSEE_FK                                              */
/*==============================================================*/
create  index POSEE_FK on SUBCATEGORIAS (
ID_CAT
);

/*==============================================================*/
/* Table: SUBCATEGORIASPRODUCTOS                                */
/*==============================================================*/
create table SUBCATEGORIASPRODUCTOS (
   ID_SUB               INT4                 not null,
   ID_PROD              INT4                 not null,
   DELETED_AT           TIMESTAMP            null,
   constraint PK_SUBCATEGORIASPRODUCTOS primary key (ID_SUB, ID_PROD)
);

/*==============================================================*/
/* Index: CATEGORIZA_PK                                         */
/*==============================================================*/
create unique index CATEGORIZA_PK on SUBCATEGORIASPRODUCTOS (
ID_SUB,
ID_PROD
);

/*==============================================================*/
/* Index: CATEGORIZA2_FK                                        */
/*==============================================================*/
create  index CATEGORIZA2_FK on SUBCATEGORIASPRODUCTOS (
ID_PROD
);

/*==============================================================*/
/* Index: CATEGORIZA_FK                                         */
/*==============================================================*/
create  index CATEGORIZA_FK on SUBCATEGORIASPRODUCTOS (
ID_SUB
);

alter table BODEGAPRODUCTOS
   add constraint FK_BODEGAPR_ALMACENA_PRODUCTO foreign key (ID_PROD)
      references PRODUCTO (ID_PROD)
      on delete restrict on update restrict;

alter table BODEGAPRODUCTOS
   add constraint FK_BODEGAPR_ALMACENA2_BODEGA foreign key (ID_BODEGA)
      references BODEGA (ID_BODEGA)
      on delete restrict on update restrict;

alter table ENVIO
   add constraint FK_ENVIO_PROGRAMA_PEDIDO foreign key (ID_PED)
      references PEDIDO (ID_PED)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_EMITE_PEDIDO foreign key (ID_PED)
      references PEDIDO (ID_PED)
      on delete restrict on update restrict;

alter table PAGO
   add constraint FK_PAGO_TIENE_FACTURA foreign key (ID_FAC)
      references FACTURA (ID_FAC)
      on delete restrict on update restrict;

alter table PEDIDO
   add constraint FK_PEDIDO_REALIZA_CLIENTE foreign key (ID_CLI)
      references CLIENTE (ID_CLI)
      on delete restrict on update restrict;

alter table PEDIDOPRODUCTO
   add constraint FK_PEDIDOPR_PEDIDOPRO_BODEGA foreign key (ID_BODEGA)
      references BODEGA (ID_BODEGA)
      on delete restrict on update restrict;

alter table PEDIDOPRODUCTO
   add constraint FK_PEDIDOPR_PEDIDOPRO_PRODUCTO foreign key (ID_PROD)
      references PRODUCTO (ID_PROD)
      on delete restrict on update restrict;

alter table PEDIDOPRODUCTO
   add constraint FK_PEDIDOPR_PEDIDOPRO_PEDIDO foreign key (ID_PED)
      references PEDIDO (ID_PED)
      on delete restrict on update restrict;

alter table PEDIDOPRODUCTO
   add constraint FK_PEDIDOPR_PEDIDOPRO_ENVIO foreign key (ID_ENV)
      references ENVIO (ID_ENV)
      on delete restrict on update restrict;

alter table PROVEEDORPRODUCTOS
   add constraint FK_PROVEEDO_PROVEE_PRODUCTO foreign key (ID_PROD)
      references PRODUCTO (ID_PROD)
      on delete restrict on update restrict;

alter table PROVEEDORPRODUCTOS
   add constraint FK_PROVEEDO_PROVEE2_PROVEEDO foreign key (ID_PROV)
      references PROVEEDOR (ID_PROV)
      on delete restrict on update restrict;

alter table SEGUIMIENTO
   add constraint FK_SEGUIMIE_EJECUTA_ENVIO foreign key (ID_ENV)
      references ENVIO (ID_ENV)
      on delete restrict on update restrict;

alter table SUBCATEGORIAS
   add constraint FK_SUBCATEG_POSEE_CATERGOR foreign key (ID_CAT)
      references CATERGORIA (ID_CAT)
      on delete restrict on update restrict;

alter table SUBCATEGORIASPRODUCTOS
   add constraint FK_SUBCATEG_CATEGORIZ_SUBCATEG foreign key (ID_SUB)
      references SUBCATEGORIAS (ID_SUB)
      on delete restrict on update restrict;

alter table SUBCATEGORIASPRODUCTOS
   add constraint FK_SUBCATEG_CATEGORIZ_PRODUCTO foreign key (ID_PROD)
      references PRODUCTO (ID_PROD)
      on delete restrict on update restrict;

