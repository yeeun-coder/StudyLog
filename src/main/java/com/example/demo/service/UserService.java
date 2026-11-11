package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.UserRepository;
import com.example.demo.entity.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	private final UserRepository userRepository;
	
	public void save(User user) {
		userRepository.save(user);
    }

    public User findByUsername(String username) {
    	return userRepository.findByUsername(username).orElse(null);
    }
}
