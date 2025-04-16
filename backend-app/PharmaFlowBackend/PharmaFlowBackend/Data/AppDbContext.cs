using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using PharmaFlowBackend.Models;

namespace PharmaFlowBackend.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<client> clients { get; set; }

    public virtual DbSet<item> items { get; set; }

    public virtual DbSet<lot> lots { get; set; }

    public virtual DbSet<order> orders { get; set; }

    public virtual DbSet<order_lot> order_lots { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .HasPostgresEnum("order_status", new[] { "pending", "confirmed", "shipped", "delivered", "cancelled" })
            .HasPostgresExtension("pgcrypto");

        modelBuilder.Entity<client>(entity =>
        {
            entity.HasKey(e => e.id).HasName("Client_pkey");

            entity.ToTable("client");

            entity.HasIndex(e => e.email, "Client_email_key").IsUnique();

            entity.Property(e => e.id).ValueGeneratedNever();
            entity.Property(e => e.company_name).HasMaxLength(100);
            entity.Property(e => e.created_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
            entity.Property(e => e.email).HasMaxLength(100);
            entity.Property(e => e.f_name).HasMaxLength(50);
            entity.Property(e => e.l_name).HasMaxLength(50);
            entity.Property(e => e.orders_count).HasDefaultValue(0);
            entity.Property(e => e.phone).HasMaxLength(50);
            entity.Property(e => e.updated_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
        });

        modelBuilder.Entity<item>(entity =>
        {
            entity.HasKey(e => e.id).HasName("Product_pkey");

            entity.ToTable("item");

            entity.HasIndex(e => e.gtin, "Product_gtin_key").IsUnique();

            entity.Property(e => e.id).ValueGeneratedNever();
            entity.Property(e => e.can_be_ordered).HasDefaultValue(true);
            entity.Property(e => e.code_name).HasMaxLength(50);
            entity.Property(e => e.created_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
            entity.Property(e => e.gtin).HasMaxLength(20);
            entity.Property(e => e.manufacturer).HasMaxLength(100);
            entity.Property(e => e.price_usd).HasPrecision(10, 2);
            entity.Property(e => e.ref_number).HasMaxLength(20);
        });

        modelBuilder.Entity<lot>(entity =>
        {
            entity.HasKey(e => e.id).HasName("Lot_pkey");

            entity.ToTable("lot");

            entity.HasIndex(e => new { e.item_id, e.lot_number }, "unique_lot_per_item").IsUnique();

            entity.Property(e => e.id).ValueGeneratedNever();
            entity.Property(e => e.lot_number).HasMaxLength(50);
            entity.Property(e => e.quantity_available).HasDefaultValue(0);
            entity.Property(e => e.received_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");

            entity.HasOne(d => d.item).WithMany(p => p.lots)
                .HasForeignKey(d => d.item_id)
                .HasConstraintName("Lot_item_id_fkey");
        });

        modelBuilder.Entity<order>(entity =>
        {
            entity.HasKey(e => e.id).HasName("Order_pkey");

            entity.ToTable("order");

            entity.HasIndex(e => e.order_number, "Order_order_number_key").IsUnique();

            entity.Property(e => e.id).ValueGeneratedNever();
            entity.Property(e => e.created_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
            entity.Property(e => e.last_updated)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");
            entity.Property(e => e.order_number).HasMaxLength(30);

            entity.HasOne(d => d.client).WithMany(p => p.orders)
                .HasForeignKey(d => d.client_id)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("Order_client_id_fkey");
            entity.Property(o => o.status)
                .HasConversion(
                    v => v.ToString().ToLower(),
                    v => Enum.Parse<OrderStatus>(v, true))
                .HasColumnName("status");
        });

        modelBuilder.Entity<order_lot>(entity =>
        {
            entity.HasKey(e => e.id).HasName("order_lot_pkey");

            entity.ToTable("order_lot");

            entity.Property(e => e.id).ValueGeneratedNever();
            entity.Property(e => e.created_at)
                .HasDefaultValueSql("CURRENT_TIMESTAMP")
                .HasColumnType("timestamp without time zone");

            entity.HasOne(d => d.lot).WithMany(p => p.order_lots)
                .HasForeignKey(d => d.lot_id)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("order_lot_ot_id_fkey");

            entity.HasOne(d => d.order).WithMany(p => p.order_lots)
                .HasForeignKey(d => d.order_id)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("order_lot_order_id_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
