package com.railer.rt.mypage;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.railer.rt.common.MyUtil;
import com.railer.rt.info.Station;
import com.railer.rt.member.SessionInfo;
import com.railer.rt.plan.FriendPlanService;
import com.railer.rt.plan.Plan;
import com.railer.rt.tour.Tour;
import com.railer.rt.tour.TourService;

@Controller("mypage.mypageController")
public class MypageController {

	@Autowired
	private MyUtil myUtil;

	@Autowired
	private TourService tourService;

	@Autowired
	private StampService stampSerivce;

	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private CommuService commuService;
	
	@Autowired
	private FriendPlanService planService;

	// 관광 정보 북마크
	@RequestMapping(value = "/bookmark/tour")
	public String bookmarkTour(Model model, HttpServletRequest req,
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page, HttpSession session)
			throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			return "redirect:/member/login";
		}
		String userId = info.getUserId();

		// 지도에 마크 찍을 리스트
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();

		map.put("userId", userId);
		dataCount = tourService.myBookMarkCount(map);

		map.put("name", "mybookmark");
		map.put("cateNum", 0);
		map.put("offset", 0);
		map.put("items", dataCount);

		List<Tour> myBookMarkList = tourService.myBookMark(map);

		model.addAttribute("list", myBookMarkList);
		model.addAttribute("pageNo", current_page);

		model.addAttribute("subMenu", "2");
		model.addAttribute("subItems", "0");

		return ".four.mypage.bookmark.tour";
	}

	@RequestMapping(value = "/bookmark/tourlist")
	public String tourlist(HttpServletRequest req, @RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpSession session, Model model) throws Exception {

		String cp = req.getContextPath();

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		if (userId == null) {
			return "redirect:/member/login";
		}

		int items = 3;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		Map<String, Object> map = new HashMap<>();

		map.put("userId", userId);
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = tourService.myBookMarkCount(map);

		if (dataCount != 0)
			total_page = myUtil.pageCount(items, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int offset = (current_page - 1) * items;
		if (offset < 0)
			offset = 0;

		map.put("name", "mybookmark");
		map.put("cateNum", 0);
		map.put("offset", offset);
		map.put("items", items);

		List<Tour> myBookMarkList = tourService.myBookMark(map);

		String detailInfoUrl = cp + "/tour/detail?page=" + current_page;

		String paging = myUtil.pagingMethod(current_page, total_page, "tourlistPage");

		model.addAttribute("paging", paging);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		model.addAttribute("list", myBookMarkList);
		model.addAttribute("detailInfoUrl", detailInfoUrl);
		model.addAttribute("dataCount", dataCount);

		return "mypage/bookmark/tourlist";
	}

	@RequestMapping(value = "/bookmark/deleteBookmark", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteBookmark(@RequestParam int tourNum, HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		String state = "true";

		Map<String, Object> map = new HashMap<>();
		map.put("tourNum", tourNum);
		map.put("userId", userId);

		try {
			tourService.disLikeTour(map);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);

		return model;
	}

	@RequestMapping(value = "/bookmark/address")
	@ResponseBody
	public Map<String, Object> readAddress(@RequestParam int tourNum) {

		Tour dto = new Tour();

		Map<String, Object> map = new HashMap<>();
		map.put("tourNum", tourNum);

		try {
			dto = tourService.readAddress(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Object> model = new HashMap<>();
		model.put("dto", dto);

		return model;
	}

	// 여행 코스 북마크
	@RequestMapping(value = "/bookmark/recommend")
	public String bookmarkRecommend(Model model) {

		
		model.addAttribute("subMenu", "3");
		model.addAttribute("subItems", "1");
		
		return ".four.mypage.bookmark.recommend";
	}
	
	@RequestMapping(value = "/bookmark/recList")
	public String bookmarkList(	
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "condition", defaultValue = "all") String condition,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		int rows = 8;
		int total_page = 0;
		int dataCount = 0;
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = planService.bookmarkCount(map);
		
		
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Plan> list = planService.listBookmark(map);
				
		String query = "";
		String articleUrl = cp +"/friendPlan/detail?";
		
		if(keyword.length()!=0) {
			query = "condition="+condition+"&keyword="+keyword+"&";
		}
		
		if(query.length()!=0) {
			articleUrl += query;
		}
		
		// AJAX 용 페이징
		String paging = myUtil.pagingMethod(current_page, total_page, "listPlanBookmarkPage");
		
		model.addAttribute("list",list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("page",current_page);
		model.addAttribute("query",query);
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		
		model.addAttribute("subMenu", "3");
		model.addAttribute("subItems", "1");
		
		return "/mypage/bookmark/recList";
		
	}

	
	// 커뮤니티 북마크
	@RequestMapping(value = "/bookmark/commu")
	public String bookmarkCommu(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "condition", defaultValue = "all") String condition,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(defaultValue="1") int commuNum,
			HttpSession session,
			HttpServletRequest req, 
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		String commuName ="";
		
		if(commuNum == 1) {
			commuName = "qna";
		} else if(commuNum == 2) {
			commuName = "board";
		} else {
			commuName = "friend";
		}
		
		int dataCount = 0;
		int rows = 10;
		int total_page = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("commuName", commuName);		
		
		
		dataCount = commuService.commuDataCount(map);

		
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;

		map.put("offset", offset);
		map.put("rows", rows);

		List<Commu> list = commuService.commuList(map);

		int listNum, n = 0;
		for (Commu dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/bookmark/commu?commuNum="+commuNum;
		String articleUrl = "";
		
		if(commuNum == 1) {
			articleUrl = cp +"/qna/article?page="+current_page+"&qnaNum=";
		} else if(commuNum == 2) {
			articleUrl = cp +"/board/article?page="+current_page+"&boardNum=";
		} else {
			articleUrl = cp +"/friend/article?page="+current_page+"&friendNum=";
		}
		

		if(keyword.length()!=0) {
			query = "&condition="+condition+"&keyword="+keyword;
			model.addAttribute("search", "search");
		}
		
		if(query.length()!=0) {
			if(commuNum == 1) {
				articleUrl = cp +"/qna/article?page="+current_page+"&"+query+"&qnaNum=";
			} else if(commuNum == 2) {
				articleUrl = cp +"/board/article?page="+current_page+"&"+query+"&boardNum=";
			} else {
				articleUrl = cp +"/friend/article?page="+current_page+"&"+query+"&friendNum=";
			}
			listUrl += query;
		}


		String paging = myUtil.paging(current_page, total_page,listUrl);
		
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("page",current_page);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("list",list);
		model.addAttribute("query",query);
		model.addAttribute("commuNum",commuNum);
		model.addAttribute("articleUrl",articleUrl);

		model.addAttribute("subMenu", "4");
		model.addAttribute("subItems", "2");

		return ".four.mypage.bookmark.commu";
	}
	
	

	// 나의 티켓
	@RequestMapping(value = "/ticket/ticket")
	public String myTicket(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "keyword", defaultValue = "all") String keyword, 
			HttpSession session,
			HttpServletRequest req, 
			Model model) throws Exception {

		String cp = req.getContextPath();

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("keyword", keyword);
		dataCount = ticketService.dataCount(map);
		
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;

		map.put("offset", offset);
		map.put("rows", rows);

		List<Ticket> list = ticketService.listTicket(map);

		int listNum, n = 0;
		for (Ticket dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/ticket/ticket";
		if (keyword.length() != 0) {
			query = "?keyword=" + keyword;
		}

		if (query.length() != 0) {
			listUrl += query;
		}

		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("page", current_page);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		model.addAttribute("query", query);
		model.addAttribute("keyword", keyword);
        model.addAttribute("page", current_page);
        model.addAttribute("dataCount", dataCount);
        model.addAttribute("total_page", total_page);

		model.addAttribute("subMenu", "5");

		return ".four.mypage.ticket.ticket";
	}
	
	//티켓 별 스탬프 목록 모달
	@RequestMapping(value="/ticket/stamp")
	public String tStamp(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "keyword", defaultValue = "all") String keyword, 
			@RequestParam int saleNum,
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("saleNum", saleNum);
		
		dataCount = ticketService.stampDataCount(map);
		
		List<Ticket> listStamp = ticketService.listStamp(map);
		
		
		model.addAttribute("listStamp", listStamp);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("keyword", keyword);
		
		return "/mypage/ticket/stamp";
		
	}

	// 스탬프
	@RequestMapping(value = "/stamp/stamp")
	public String stamp(
			Model model, 
			HttpServletRequest req, 
			HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		// 지도에 마크 찍을 스탬프 리스트
		Map<String, Object> map = new HashMap<>();
		map.put("again", 0);
		map.put("userId", userId);

		List<Stamp> stampList = stampSerivce.listStamp(map);

		model.addAttribute("stampList", stampList);

		model.addAttribute("subMenu", "6");

		return ".four.mypage.stamp.stamp";
	}

	@RequestMapping(value = "/stamp/modal")
	public String stampList(@RequestParam(value = "pageNo", defaultValue = "1") int current_page, Model model,
			HttpServletRequest req, HttpSession session) throws Exception {

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		int dataCount = stampSerivce.dataCount(map);
		int total_page = 0;
		int items = 10;

		if (dataCount != 0)
			total_page = myUtil.pageCount(items, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		String paging = myUtil.pagingMethod(current_page, total_page, "stampListPage");

		// 지도에 마크 찍을 스탬프 리스트
		Map<String, Object> map2 = new HashMap<>();
		map2.put("again", 0);
		map2.put("userId", userId);
		List<Stamp> stampList = stampSerivce.listStamp(map2);

		model.addAttribute("stampList", stampList);
		model.addAttribute("paging", paging);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);

		model.addAttribute("subMenu", "6");

		return "/mypage/stamp/modal";

	}

	@RequestMapping(value = "/stamp/calDistance")
	public String calDistance(Model model, HttpSession session, @RequestParam String locLogitude,
			@RequestParam String locLatitude) {

		List<Station> matchList = new ArrayList<Station>();
		List<Stamp> saleList = new ArrayList<>();
		Station dto = null;
		int result = 0;

		SessionInfo info = (SessionInfo) session.getAttribute("member");
		String userId = info.getUserId();

		try {
			// 티켓 목록 리스트
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);

			saleList = stampSerivce.listSale(map);

			// 현재 위치 비교를 위한 역 목록 리스트
			List<Station> stationList = stampSerivce.listStation();

			for (int i = 0; i < stationList.size(); i++) {
				String longitude = stationList.get(i).getLongitude();// stalng
				String latitude = stationList.get(i).getLatitude();// stalat

				double distance;
				double radius = 6371; // 지구 반지름(km)
				double toRadian = Math.PI / 180;

				double dLat = (Double.parseDouble(latitude) - Double.parseDouble(locLatitude)) * toRadian;
				double dLon = (Double.parseDouble(longitude) - Double.parseDouble(locLogitude)) * toRadian;

				double squareRoot = Math.sqrt(
						Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(Double.parseDouble(latitude) * toRadian)
								* Math.cos(Double.parseDouble(locLatitude) * toRadian) * Math.sin(dLon / 2)
								* Math.sin(dLon / 2));
				distance = 2 * radius * Math.asin(squareRoot);

				if (distance < 5) {
					dto = stationList.get(i);
					matchList.add(dto);
				}

			}

			if (matchList != null) {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("matchList", matchList);
		model.addAttribute("saleList", saleList);
		model.addAttribute("result", result);

		model.addAttribute("subMenu", "6");

		return "/mypage/stamp/match";
	}

	@RequestMapping(value = "/stamp/insert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertStamp(@RequestParam int staNum, @RequestParam int saleNum) {

		String state = "true";
		Map<String, Object> map = new HashMap<>();
		map.put("staNum", staNum);
		map.put("saleNum", saleNum);

		Map<String, Object> map2 = new HashMap<>();
		map2.put("staNum", staNum);
		map2.put("saleNum", saleNum);
		Stamp dto = null;

		try {

			dto = stampSerivce.readStamp(map2);
			if (dto != null) {
				state = "again";
			} else {

				stampSerivce.insertStamp(map);

			}

		} catch (Exception e) {
			e.printStackTrace();
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);

		return model;
	}

	
	// 나의 여행 계획
	@RequestMapping(value = "/plan/plan")
	public String myPlan(Model model) {

		model.addAttribute("subMenu", "7");

		return ".four.mypage.plan.plan";
	}

	@RequestMapping(value = "/plan/myPlanList")
	public String myPlanList(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "condition", defaultValue = "all") String condition,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		int rows = 8;
		int total_page = 0;
		int dataCount = 0;
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = planService.myPlanCount(map);
		
		
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		
		
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Plan> list = planService.listMyPlan(map);
				
		String query = "";
		String articleUrl = cp +"/friendPlan/detail?";
		
		if(keyword.length()!=0) {
			query = "condition="+condition+"&keyword="+keyword+"&";
		}
		
		if(query.length()!=0) {
			articleUrl += query;
		}
		
		// AJAX 용 페이징
		String paging = myUtil.pagingMethod(current_page, total_page, "listMyPlanPage");
		
		model.addAttribute("list",list);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("page",current_page);
		model.addAttribute("query",query);
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("articleUrl",articleUrl);
		model.addAttribute("paging",paging);
		
		
		model.addAttribute("subMenu", "7");

		return "/mypage/plan/myPlanList";
	}
	
	
	
	// 내가 쓴 게시물
	@RequestMapping(value="/bbs/mybbs")
	public String myBbs(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(value = "condition", defaultValue = "all") String condition,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(defaultValue="1") int commuNum,
			HttpSession session,
			HttpServletRequest req, 
			Model model) throws Exception {
		
		String cp = req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		String commuName ="";
		
		if(commuNum == 1) {
			commuName = "qna";
		} else if(commuNum == 2) {
			commuName = "board";
		} else {
			commuName = "friend";
		}
		
		int dataCount = 0;
		int rows = 10;
		int total_page = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("commuName", commuName);		
		
		
		dataCount = commuService.myCommuDataCount(map);

		
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}

		if (total_page < current_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;

		map.put("offset", offset);
		map.put("rows", rows);

		List<Commu> list = commuService.myCommuList(map);

		int listNum, n = 0;
		for (Commu dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}

		String query = "";
		String listUrl = cp + "/bookmark/commu?commuNum="+commuNum;
		String articleUrl = "";
		
		if(commuNum == 1) {
			articleUrl = cp +"/qna/article?page="+current_page+"&qnaNum=";
		} else if(commuNum == 2) {
			articleUrl = cp +"/board/article?page="+current_page+"&boardNum=";
		} else {
			articleUrl = cp +"/friend/article?page="+current_page+"&friendNum=";
		}
		

		if(keyword.length()!=0) {
			query = "&condition="+condition+"&keyword="+keyword;
			model.addAttribute("search", "search");
		}
		
		if(query.length()!=0) {
			if(commuNum == 1) {
				articleUrl = cp +"/qna/article?page="+current_page+"&"+query+"&qnaNum=";
			} else if(commuNum == 2) {
				articleUrl = cp +"/board/article?page="+current_page+"&"+query+"&boardNum=";
			} else {
				articleUrl = cp +"/friend/article?page="+current_page+"&"+query+"&friendNum=";
			}
			listUrl += query;
		}


		String paging = myUtil.paging(current_page, total_page,listUrl);
		
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("page",current_page);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		model.addAttribute("dataCount",dataCount);
		model.addAttribute("list",list);
		model.addAttribute("query",query);
		model.addAttribute("commuNum",commuNum);
		model.addAttribute("articleUrl",articleUrl);
		
		model.addAttribute("subMenu", "8");
		
		return ".four.mypage.bbs.mybbs";
	}
	
	

}
