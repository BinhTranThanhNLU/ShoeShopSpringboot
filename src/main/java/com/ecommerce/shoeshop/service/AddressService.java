package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.AddressRepository;
import com.ecommerce.shoeshop.dto.AddressDTO;
import com.ecommerce.shoeshop.entity.Address;
import com.ecommerce.shoeshop.mapper.AddressMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AddressService {

    private final AddressRepository addressRepository;
    private final AddressMapper addressMapper;

    public AddressService(AddressRepository addressRepository, AddressMapper addressMapper) {
        this.addressRepository = addressRepository;
        this.addressMapper = addressMapper;
    }

    public List<AddressDTO> getAllAddress() {
        List<Address> addressList = addressRepository.findAll();
        return addressMapper.toDto(addressList);
    }

    public AddressDTO getAddressById(int id) {
        Address address = addressRepository.getById(id);
        return addressMapper.toDto(address);
    }

    public AddressDTO createAddress(AddressDTO addressDTO) {
        Address address = addressMapper.toEntity(addressDTO);
        Address saved = addressRepository.save(address);
        return addressMapper.toDto(saved);
    }

    public Address createEntity(Address address) {
        address.setCreatedAt(LocalDateTime.now());
        address.setUpdatedAt(LocalDateTime.now());
        return addressRepository.save(address);
    }

    public List<AddressDTO> getAddressByUserId(int userId) {
        List<Address> addresses = addressRepository.findByUserId(userId);
        return addressMapper.toDto(addresses);
    }

    public Address getEntityByIdAndUserId(Integer idAddress, Integer authenticatedUserId) {
        return addressRepository.findByUserIdAndId(authenticatedUserId, idAddress)
                .orElseThrow(() -> new RuntimeException("Address not found"));
    }
}
