package com.ecommerce.shoeshop.dao;


import com.ecommerce.shoeshop.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);


    @Query("SELECT u FROM User u WHERE " +
        "(:keyword IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
        "OR LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
        "OR u.phone LIKE CONCAT('%', :keyword, '%')) " +
        "AND (:status IS NULL OR u.status = :status) " +
        "AND (:roleId IS NULL OR u.role.id = :roleId)")
    Page<User> findAllUsersWithFilters(@Param("keyword") String keyword,
        @Param("status") Boolean status,
        @Param("roleId") Integer roleId,
        Pageable pageable);
}

