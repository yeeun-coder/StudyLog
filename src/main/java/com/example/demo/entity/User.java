package com.example.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
@Table(name = "app_user")
public class User {
	@Id 
	@GeneratedValue
    private Long id;
    private String username;
    private String email;
    private String password;
    @Transient // 비교하기 위한거여서 제외
    private String passwordCheck;
}
