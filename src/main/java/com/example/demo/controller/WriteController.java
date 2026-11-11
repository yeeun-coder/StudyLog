package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.User;
import com.example.demo.service.NoteService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class WriteController{
	private final NoteService noteService;
	
	// 기록 작성
	@GetMapping("/writeForm")
    public String writeForm(HttpSession session) {
        if(session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        return "write";
    }
	@PostMapping("/write")
    public String write(
            @RequestParam("noteDate") String noteDate,
            @RequestParam("subject") String subject,
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("code") String code,
            HttpSession session, Model model
    ) {
		
		User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/login";
	    }
	    
	    if (noteDate == null || noteDate.isEmpty() ||
            subject == null || subject.isEmpty() ||
            title == null || title.isEmpty()) {

            model.addAttribute("errorMessage", "날짜, 과목, 제목은 필수 입력 항목입니다!");
            model.addAttribute("noteDate", noteDate);
            model.addAttribute("subject", subject);
            model.addAttribute("title", title);
            model.addAttribute("content", content);
            model.addAttribute("code", code);

            model.addAttribute("loginUser", loginUser);
            return "write";
	    }
		
		noteService.save(noteDate, subject, title, content, code, loginUser);
        return "redirect:/list";
    }
}
