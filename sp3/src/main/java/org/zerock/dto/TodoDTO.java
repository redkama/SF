package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*CREATE TABLE simple_todo (
  id        INT AUTO_INCREMENT PRIMARY KEY,
  title 	VARCHAR(200) NOT NULL,
  description      VARCHAR(500),
  done	 	boolean default false,
  created_at 	TIMESTAMP DEFAULT current_timestamp()
);*/

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TodoDTO {
	private int id;
	private String title;
	private String description;
	private Boolean done;
	private LocalDateTime created_at;

	public String getCreatedDate() {
		return created_at.format(DateTimeFormatter.ISO_DATE);
	}

	public void setDone(boolean done) {
	    this.done = done;
	}
	
	
}


