package com.example.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Data
@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "identification_document", nullable = false, unique = true)
    private String identificationDocument;

    @Column(name = "nationality", nullable = false)
    private String nationality;

    @Column(name = "registration_date", nullable = false)
    private String registrationDate;

    @Column(name = "account_expiration_date", nullable = false)
    private String accountExpirationDate;
}
