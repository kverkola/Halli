package fi.softala.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import fi.softala.bean.Henkilo;

public class HenkiloRowMapper implements RowMapper<Henkilo>{

	public Henkilo mapRow(ResultSet rs, int rowNum) throws SQLException {
		Henkilo k = new Henkilo();
		k.setEtunimi(rs.getString("h.etunimi"));
		k.setSukunimi(rs.getString("h.sukunimi"));
		
		return k;
	}

}
