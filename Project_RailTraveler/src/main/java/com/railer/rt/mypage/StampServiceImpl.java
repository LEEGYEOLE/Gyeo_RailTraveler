package com.railer.rt.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.railer.rt.common.dao.CommonDAO;
import com.railer.rt.info.Station;

@Service("stamp.stampService")
public class StampServiceImpl implements StampService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Stamp> listStamp(Map<String, Object> map) throws Exception {
		List<Stamp> list = null;
		try {
			list = dao.selectList("stamp.listStamp",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Stamp readStamp(Map<String, Object> map) throws Exception {
		Stamp dto = null;
		try {
			dto = dao.selectOne("stamp.readStamp",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int dataCount = 0;
		try {
			dataCount = dao.selectOne("stamp.stampDataCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}

	@Override
	public List<Station> listStation() throws Exception {
		List<Station> list = null;
		try {
			list = dao.selectList("stamp.stationlist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Stamp> listSale(Map<String, Object> map) throws Exception {
		List<Stamp> saleList = null;
		try {
			saleList = dao.selectList("stamp.saleList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saleList;
	}

	@Override
	public void insertStamp(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("stamp.insertStamp",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
