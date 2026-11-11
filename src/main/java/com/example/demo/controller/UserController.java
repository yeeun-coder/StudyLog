package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    // 처음 페이지
    @GetMapping("/")
    public String root() {
        return "index";
    }

    // 로그인
    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }
    @PostMapping("/login")
    public String login(@RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpSession session,
                        Model model) {

        User user = userService.findByUsername(username);

        if(user != null && password.equals(user.getPassword())) {
            session.setAttribute("loginUser", user);
            return "redirect:/home?success=1";
        }

        model.addAttribute("error", "아이디 또는 비밀번호가 틀렸습니다.");
        model.addAttribute("username", username); // 에러 발생 시 입력 값을 Model에 저장
        return "login";
    }

    // 회원가입
    @GetMapping("/register")
    public String registerForm() {
        return "register";
    }
    @PostMapping("/register")
    public String register(@RequestParam("username") String username,
                           @RequestParam("email") String email,
                           @RequestParam("password") String password,
                           @RequestParam("passwordCheck") String passwordCheck,
                           Model model) {
    	// 에러 발생 시 입력 값을 Model에 저장
        model.addAttribute("username", username);
        model.addAttribute("email", email);
        // 비밀번호는 보안상 X
    	
        // 빈값 체크
        if(username.isEmpty() || email.isEmpty() || password.isEmpty() || passwordCheck.isEmpty()) {
            model.addAttribute("error", "모든 필드를 입력해주세요.");
            return "register";
        }

        // 비밀번호 확인
        if(!password.equals(passwordCheck)) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "register";
        }

        // DB 저장
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        userService.save(user);

        return "redirect:/?success=1";
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "logout";
    }
}
