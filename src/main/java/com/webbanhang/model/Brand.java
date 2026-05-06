package com.webbanhang.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "BRANDS")
public class Brand {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "brand_id")
    private Integer brandId;
	
	@Column(name = "brand_name", nullable = false, unique = true, length = 100)
    private String brandName;
 
    @Column(name = "description", columnDefinition = "NVARCHAR(MAX)")
    private String description;
 
    @Column(name = "is_active")
    private Boolean isActive = true;
 
    @OneToMany(mappedBy = "brand", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product> products;
    
    public Brand() {}

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
    
    
}
