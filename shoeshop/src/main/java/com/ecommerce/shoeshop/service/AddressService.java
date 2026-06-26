package com.ecommerce.shoeshop.service;

import com.ecommerce.shoeshop.dao.AddressRepository;
import com.ecommerce.shoeshop.dao.UserRepository;
import com.ecommerce.shoeshop.dto.AddressDTO;
import com.ecommerce.shoeshop.entity.Address;
import com.ecommerce.shoeshop.mapper.AddressMapper;
import com.ecommerce.shoeshop.requestmodel.CreateAddressRequest;
import com.ecommerce.shoeshop.requestmodel.UpdateAddressRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AddressService {

    private final AddressRepository addressRepository;
    private final UserRepository userRepository;
    private final AddressMapper addressMapper;

    public AddressService(AddressRepository addressRepository, UserRepository userRepository, AddressMapper addressMapper) {
        this.addressRepository = addressRepository;
        this.userRepository = userRepository;
        this.addressMapper = addressMapper;
    }

    public List<AddressDTO> getAllAddress() {
        List<Address> addressList = addressRepository.findAll();
        return addressMapper.toDto(addressList);
    }

    public AddressDTO getAddressById(int id) {
        Address address = addressRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Address not found"));
        return addressMapper.toDto(address);
    }

    public List<AddressDTO> getAddressesByUserId(int userId) {
        List<Address> addresses = addressRepository.findByUserIdOrderByCreatedAtDesc(userId);
        return addressMapper.toDto(addresses);
    }

    @Transactional
    public AddressDTO createAddress(int userId, CreateAddressRequest req) {
        Address address = new Address();
        address.setFullName(req.getFullName());
        address.setPhone(req.getPhone());
        address.setStreet(req.getStreet());
        address.setWard(req.getWard());
        address.setDistrict(req.getDistrict());
        address.setProvince(req.getProvince());
        address.setUser(userRepository.getReferenceById(userId));
        address.setCreatedAt(LocalDateTime.now());
        address.setUpdatedAt(LocalDateTime.now());

        boolean shouldBeDefault = Boolean.TRUE.equals(req.getIsDefault())
            || addressRepository.findByUserId(userId).isEmpty();
        address.setDefault(shouldBeDefault);

        if (shouldBeDefault) {
            unsetDefaultForUser(userId);
        }

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

    @Transactional
    public AddressDTO updateAddress(int addressId, int userId, UpdateAddressRequest req) {
        Address address = getEntityByIdAndUserId(addressId, userId);

        if (req.getFullName() != null) {
            address.setFullName(req.getFullName());
        }
        if (req.getPhone() != null) {
            address.setPhone(req.getPhone());
        }
        if (req.getStreet() != null) {
            address.setStreet(req.getStreet());
        }
        if (req.getWard() != null) {
            address.setWard(req.getWard());
        }
        if (req.getDistrict() != null) {
            address.setDistrict(req.getDistrict());
        }
        if (req.getProvince() != null) {
            address.setProvince(req.getProvince());
        }

        if (req.getIsDefault() != null) {
            if (req.getIsDefault()) {
                unsetDefaultForUser(userId);
                address.setDefault(true);
            } else {
                boolean hasOtherDefault = addressRepository.findByUserIdAndDefaultTrue(userId)
                    .map(defaultAddress -> defaultAddress.getId() != addressId)
                    .orElse(false);
                if (hasOtherDefault || !address.isDefault()) {
                    address.setDefault(false);
                }
            }
        }

        address.setUpdatedAt(LocalDateTime.now());
        return addressMapper.toDto(addressRepository.save(address));
    }

    @Transactional
    public void deleteAddress(int addressId, int userId) {
        Address address = getEntityByIdAndUserId(addressId, userId);
        boolean deletedWasDefault = address.isDefault();
        addressRepository.delete(address);

        if (deletedWasDefault) {
            List<Address> remaining = addressRepository.findByUserIdOrderByCreatedAtAsc(userId);
            if (!remaining.isEmpty()) {
                Address first = remaining.getFirst();
                first.setDefault(true);
                first.setUpdatedAt(LocalDateTime.now());
                addressRepository.save(first);
            }
        }
    }

    @Transactional
    public AddressDTO setDefaultAddress(int addressId, int userId) {
        Address address = getEntityByIdAndUserId(addressId, userId);
        unsetDefaultForUser(userId);
        address.setDefault(true);
        address.setUpdatedAt(LocalDateTime.now());
        return addressMapper.toDto(addressRepository.save(address));
    }

    private void unsetDefaultForUser(int userId) {
        addressRepository.findByUserIdAndDefaultTrue(userId)
            .ifPresent(defaultAddress -> {
                defaultAddress.setDefault(false);
                defaultAddress.setUpdatedAt(LocalDateTime.now());
                addressRepository.save(defaultAddress);
            });
    }
}
