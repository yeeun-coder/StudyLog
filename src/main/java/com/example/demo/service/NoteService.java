package com.example.demo.service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.dao.NoteRepository;
import com.example.demo.entity.Note;
import com.example.demo.entity.User;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoteService {
	private final NoteRepository noteRepository;
	
	public void save(String noteDate, String subject, String title, 
            String content, String code, User user) {
		if (subject != null) {
		   subject = subject.toUpperCase().replaceAll("\\s+", "");
		}
		
		Note note = new Note();
		note.setNoteDate(noteDate);
		
		LocalDateTime parsedDate = LocalDate.parse(noteDate).atStartOfDay();
		note.setNoteDateTime(parsedDate);
		
		note.setSubject(subject);
		note.setTitle(title);
		note.setContent(content);
		note.setCode(code);
		note.setUser(user);
		
		noteRepository.save(note);
	}
    
	public List<Note> getUserNotes(User user) {
	    return noteRepository.findByUserOrderByNoteDateDesc(user);
	}
    
    public List<Note> findAll() {
        return noteRepository.findAllByOrderByNoteDateDesc();
    }

    public Note findById(Long id) {
        return noteRepository.findById(id).orElse(null);
    }
    
    public Note findBySubject(String subject) {
        return noteRepository.findBySubject(subject);
    }
    
    public void update(Note note) {
        noteRepository.save(note);
    }
    
    public void delete(Long id) {
        noteRepository.deleteById(id);
    }
    
    public List<Note> search(String keyword, String date) {

        if ((keyword != null && !keyword.isEmpty()) &&
            (date != null && !date.isEmpty())) {
            return noteRepository.findByTitleContainingOrSubjectContainingOrNoteDateOrderByNoteDateDesc(
                    keyword, keyword, date);
        }

        if (keyword != null && !keyword.isEmpty()) {
            return noteRepository.findByTitleOrSubjectOrderByNoteDateDesc(keyword, keyword);
        }

        if (date != null && !date.isEmpty()) {
            return noteRepository.findByNoteDateOrderByNoteDateDesc(date);
        }

        return noteRepository.findAllByOrderByNoteDateDesc();
    }
    public List<Note> searchByUser(User user, String keyword, String date) {
        if ((keyword == null || keyword.isEmpty()) &&
            (date == null || date.isEmpty())) {
            return getUserNotes(user);
        }

        return noteRepository.searchUserNotes(user, keyword, date);
    }
    
    public int getTodayCount(User user) {
    	String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return noteRepository.countByUserAndNoteDate(user, today);
    }
    public int getMonthCount(User user) {
        String thisMonth = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM"));
        return noteRepository.countByUserAndNoteDateStartingWith(user, thisMonth);
    }
    public long getThisWeekCount(User user) {
        LocalDate today = LocalDate.now();
        LocalDate weekStart = today.with(DayOfWeek.MONDAY);
        LocalDate weekEnd = weekStart.plusDays(6);

        return noteRepository.countByUserAndNoteDateTimeBetween(user,
                weekStart.atStartOfDay(), weekEnd.atTime(23, 59, 59)
        );
    }
    public List<Object[]> getSubjectStats(User user) {
    	return noteRepository.countGroupBySubjectAndUser(user);
    }
    public List<String> getRecordedDates(User user, String yearMonth) {
        return noteRepository.findRecordedDatesByUser(user, yearMonth);
    }
    
    public Map<String, Integer> getRecordCountByDate(User user, String yearMonth) {
    	List<Object[]> results = noteRepository.countByUserAndDate(user, yearMonth);
        Map<String, Integer> map = new HashMap<>();

        for (Object[] row : results) {
            String date = (String) row[0];
            Long count = (Long) row[1];
            map.put(date, count.intValue());
        }
        return map;
    }
}
