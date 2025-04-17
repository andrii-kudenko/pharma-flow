using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PharmaFlowBackend.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("Npgsql:Enum:order_status.order_status", "pending,confirmed,shipped,delivered,cancelled,completed");

            migrationBuilder.CreateTable(
                name: "client",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    f_name = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    l_name = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    phone = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    email = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    company_name = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    billing_address = table.Column<string>(type: "text", nullable: true),
                    delivery_address = table.Column<string>(type: "text", nullable: true),
                    orders_count = table.Column<int>(type: "integer", nullable: true, defaultValue: 0),
                    last_order_date = table.Column<DateOnly>(type: "date", nullable: true),
                    password_hash = table.Column<string>(type: "text", nullable: false),
                    created_at = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP"),
                    updated_at = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP")
                },
                constraints: table =>
                {
                    table.PrimaryKey("Client_pkey", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "item",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    code_name = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    ref_number = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    gtin = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    manufacturer = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    description = table.Column<string>(type: "text", nullable: true),
                    official_url = table.Column<string>(type: "text", nullable: true),
                    created_at = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP"),
                    can_be_ordered = table.Column<bool>(type: "boolean", nullable: true, defaultValue: true),
                    price_usd = table.Column<decimal>(type: "numeric(10,2)", precision: 10, scale: 2, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("Product_pkey", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "order",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    order_number = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    client_id = table.Column<Guid>(type: "uuid", nullable: true),
                    status = table.Column<string>(type: "order_status", nullable: false),
                    total_items = table.Column<int>(type: "integer", nullable: false),
                    created_at = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP"),
                    last_updated = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP"),
                    total_price = table.Column<decimal>(type: "numeric", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("Order_pkey", x => x.id);
                    table.ForeignKey(
                        name: "Order_client_id_fkey",
                        column: x => x.client_id,
                        principalTable: "client",
                        principalColumn: "id",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateTable(
                name: "lot",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    item_id = table.Column<Guid>(type: "uuid", nullable: false),
                    lot_number = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    expiration_date = table.Column<DateOnly>(type: "date", nullable: false),
                    manufacture_date = table.Column<DateOnly>(type: "date", nullable: true),
                    quantity_available = table.Column<int>(type: "integer", nullable: false, defaultValue: 0),
                    certificate_url = table.Column<string>(type: "text", nullable: true),
                    received_at = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP")
                },
                constraints: table =>
                {
                    table.PrimaryKey("Lot_pkey", x => x.id);
                    table.ForeignKey(
                        name: "Lot_item_id_fkey",
                        column: x => x.item_id,
                        principalTable: "item",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "order_lot",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    order_id = table.Column<Guid>(type: "uuid", nullable: true),
                    lot_id = table.Column<Guid>(type: "uuid", nullable: false),
                    quantity = table.Column<int>(type: "integer", nullable: false),
                    created_at = table.Column<DateTime>(type: "timestamp without time zone", nullable: true, defaultValueSql: "CURRENT_TIMESTAMP")
                },
                constraints: table =>
                {
                    table.PrimaryKey("order_lot_pkey", x => x.id);
                    table.ForeignKey(
                        name: "order_lot_order_id_fkey",
                        column: x => x.order_id,
                        principalTable: "order",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "order_lot_ot_id_fkey",
                        column: x => x.lot_id,
                        principalTable: "lot",
                        principalColumn: "id",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateIndex(
                name: "Client_email_key",
                table: "client",
                column: "email",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "Product_gtin_key",
                table: "item",
                column: "gtin",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "unique_lot_per_item",
                table: "lot",
                columns: new[] { "item_id", "lot_number" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_order_client_id",
                table: "order",
                column: "client_id");

            migrationBuilder.CreateIndex(
                name: "Order_order_number_key",
                table: "order",
                column: "order_number",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_order_lot_lot_id",
                table: "order_lot",
                column: "lot_id");

            migrationBuilder.CreateIndex(
                name: "IX_order_lot_order_id",
                table: "order_lot",
                column: "order_id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "order_lot");

            migrationBuilder.DropTable(
                name: "order");

            migrationBuilder.DropTable(
                name: "lot");

            migrationBuilder.DropTable(
                name: "client");

            migrationBuilder.DropTable(
                name: "item");
        }
    }
}
