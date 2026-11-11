package com.example.demo.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.entity.Note;
import com.example.demo.entity.User;
import com.example.demo.service.NoteService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ListController {
	private final NoteService noteService;
	
    // 메인 페이지
	@GetMapping("/home")
	public String home(@RequestParam(value = "month", required = false) String month, 
	                   Model model, HttpSession session) {

	    if(session.getAttribute("loginUser") == null) {
	        return "redirect:/login";
	    }

	    if (month == null) {
	        month = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
	    }

	    LocalDate current = LocalDate.parse(month + "-01");
	    String prevMonth = current.minusMonths(1).format(DateTimeFormatter.ofPattern("yyyy-MM"));
	    String nextMonth = current.plusMonths(1).format(DateTimeFormatter.ofPattern("yyyy-MM"));

	    LocalDate firstDay = current.withDayOfMonth(1);

	    int firstDayOfWeek = firstDay.getDayOfWeek().getValue();
	    int lastDayOfMonth = current.lengthOfMonth();
	    String currentMonthLabel = current.format(DateTimeFormatter.ofPattern("yyyy-MM"));

	    model.addAttribute("firstDayOfWeek", firstDayOfWeek);
	    model.addAttribute("lastDayOfMonth", lastDayOfMonth);
	    model.addAttribute("currentMonthLabel", currentMonthLabel);
	    
	    String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	    model.addAttribute("today", today);

	    User loginUser = (User) session.getAttribute("loginUser");
	    int todayCount = noteService.getTodayCount(loginUser);
	    int monthCount = noteService.getMonthCount(loginUser);
	    long thisWeekCount = noteService.getThisWeekCount(loginUser);
	    List<Object[]> subjectStats = noteService.getSubjectStats(loginUser);
	    Map<String, Integer> recordCountMap = noteService.getRecordCountByDate(loginUser, currentMonthLabel);
	    model.addAttribute("recordCountMap", recordCountMap);

	    model.addAttribute("todayCount", todayCount);
	    model.addAttribute("monthCount", monthCount);
	    model.addAttribute("thisWeekCount", thisWeekCount);
	    model.addAttribute("subjectStats", subjectStats);
	    model.addAttribute("loginUser", session.getAttribute("loginUser"));

	    model.addAttribute("recordedDates", noteService.getRecordedDates(loginUser, month));
	    model.addAttribute("currentMonth", month);
	    model.addAttribute("prevMonth", prevMonth);
	    model.addAttribute("nextMonth", nextMonth);

	    return "home";
	}
	
	@GetMapping("/list")
    public String list(@RequestParam(value = "keyword", required = false) String keyword,
            			@RequestParam(value = "date", required = false) String date,
    					HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        return "redirect:/login";
	    }
	    List<Note> notes = noteService.getUserNotes(loginUser);
        if ((keyword != null && !keyword.isEmpty()) || (date != null && !date.isEmpty())) {
        	notes = noteService.searchByUser(loginUser, keyword, date);
        }
        else {
        	notes = noteService.getUserNotes(loginUser);
        }
        
        model.addAttribute("notes", notes);
        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("date", date);
        return "list";
    }
	
	@GetMapping("/detail")
	public String detail(@RequestParam("id") Long id, HttpSession session, Model model) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) return "redirect:/login";

	    Note note = noteService.findById(id);
	    if (note == null) {
	        return "redirect:/list";
	    }
	    if (note.getUser() == null) {
	        // 시스템적으로는 잘못된 데이터라 로그 남김
	        System.out.println("⚠ 경고: note id=" + id + " 의 user_id 가 null 입니다!");
	        return "redirect:/list";
	    }
	    if (!note.getUser().getId().equals(loginUser.getId())) {
	        return "redirect:/list";
	    }

	    model.addAttribute("note", note);
	    model.addAttribute("loginUser", session.getAttribute("loginUser"));
	    return "detail";
	}

	
	@GetMapping("/update")
	public String updateForm(@RequestParam("id") Long id, HttpSession session, Model model) {
	    if(session.getAttribute("loginUser") == null) {
	        return "redirect:/login";
	    }

	    Note note = noteService.findById(id);
	    model.addAttribute("note", note);
	    model.addAttribute("loginUser", session.getAttribute("loginUser"));
	    return "update";
	}

	@PostMapping("/update")
	public String update(Note note, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
	        return "redirect:/login";
	    }
		
	    Note oldNote = noteService.findById(note.getId());
	    if (oldNote == null) {
	        return "redirect:/list";
	    }
	    
	    oldNote.setNoteDate(note.getNoteDate());
	    oldNote.setSubject(note.getSubject());
	    oldNote.setTitle(note.getTitle());
	    oldNote.setContent(note.getContent());
	    oldNote.setCode(note.getCode());

	    oldNote.setUser(loginUser);
	    noteService.update(oldNote);
	    return "redirect:/detail?id=" + note.getId();
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("id") Long id, HttpSession session) {
	    if(session.getAttribute("loginUser") == null) {
	        return "redirect:/login";
	    }
	    noteService.delete(id);
	    return "redirect:/list";
	}
}
