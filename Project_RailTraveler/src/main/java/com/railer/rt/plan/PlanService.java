package com.railer.rt.plan;

import java.util.List;
import java.util.Map;

public interface PlanService {
	public List<Station> listStation(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}