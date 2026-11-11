package com.example.demo.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.entity.Note;
import com.example.demo.entity.User;

public interface NoteRepository extends JpaRepository<Note, Long> {
	List<Note> findByUser(User user);
    List<Note> findByUserAndNoteDate(User user, String noteDate);
    List<Note> findByUserOrderByNoteDateDesc(User user);
    List<Note> findByUserAndTitleContainingOrSubjectContainingOrderByNoteDateDesc(
            User user, String title, String subject);
    List<Note> findByUserAndNoteDateOrderByNoteDateDesc(User user, String noteDate);
	
    Note findBySubject(String subject);
    List<Note> findByTitleOrSubject(String title, String subject);
    List<Note> findByNoteDate(String noteDate);
    List<Note> findByTitleOrSubjectOrNoteDate(String title, String subject, String noteDate);
    List<Note> findAllByOrderByNoteDateDesc();
    List<Note> findByTitleOrSubjectOrderByNoteDateDesc(String title, String subject);
    List<Note> findByNoteDateOrderByNoteDateDesc(String noteDate);
    List<Note> findByTitleContainingOrSubjectContainingOrNoteDateOrderByNoteDateDesc(
            String title, String subject, String noteDate);

	
    int countByUserAndNoteDate(User user, String noteDate);

    int countByUserAndNoteDateStartingWith(User user, String noteMonth);

    long countByUserAndNoteDateTimeBetween(
            User user, LocalDateTime start, LocalDateTime end);
    
	
    @Query("SELECT n.subject, COUNT(n) FROM Note n " +
            "WHERE n.user = :user GROUP BY n.subject ORDER BY COUNT(n) DESC")
     List<Object[]> countGroupBySubjectAndUser(@Param("user") User user);

    
     @Query("SELECT n.noteDate FROM Note n WHERE n.user = :user AND n.noteDate LIKE :month%")
     List<String> findRecordedDatesByUser(@Param("user") User user, @Param("month") String month);
    
    @Query("SELECT n.noteDate, COUNT(n) FROM Note n " +
            "WHERE n.user = :user AND n.noteDate LIKE :yearMonth% " +
            "GROUP BY n.noteDate")
     List<Object[]> countByUserAndDate(@Param("user") User user,
                                       @Param("yearMonth") String yearMonth);
    
     @Query("SELECT n FROM Note n " +
             "WHERE n.user = :user " +
             "AND (n.title LIKE %:keyword% OR n.subject LIKE %:keyword% " +
             "OR n.noteDate = :date) " +
             "ORDER BY n.noteDate DESC")
      List<Note> searchUserNotes(@Param("user") User user,
                                 @Param("keyword") String keyword,
                                 @Param("date") String date);
}
