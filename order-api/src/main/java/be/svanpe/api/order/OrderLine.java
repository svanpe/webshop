package be.svanpe.api.order;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "order_line_tb")
public class OrderLine {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @Column(name = "productReference")
    private String productReference;
    @Column(name = "quantity")
    private Long quantity;
    @Column(name = "taxPercentage")
    private BigDecimal taxPercentage;
    @Column(name = "unitPrice")
    private BigDecimal unitPrice;
    @Column(name = "unitPriceAndTax")
    private BigDecimal unitPriceAndTax;
    @Column(name = "totalPriceAndTax")
    private BigDecimal totalPriceAndTax;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getProductReference() {
        return productReference;
    }

    public void setProductReference(String productReference) {
        this.productReference = productReference;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getTaxPercentage() {
        return taxPercentage;
    }

    public void setTaxPercentage(BigDecimal taxPercentage) {
        this.taxPercentage = taxPercentage;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getUnitPriceAndTax() {
        return unitPriceAndTax;
    }

    public void setUnitPriceAndTax(BigDecimal unitPriceAndTax) {
        this.unitPriceAndTax = unitPriceAndTax;
    }

    public BigDecimal getTotalPriceAndTax() {
        return totalPriceAndTax;
    }

    public void setTotalPriceAndTax(BigDecimal totalPriceAndTax) {
        this.totalPriceAndTax = totalPriceAndTax;
    }
}
