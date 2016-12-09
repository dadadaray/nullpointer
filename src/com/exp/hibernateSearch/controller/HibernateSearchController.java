package com.exp.hibernateSearch.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exp.entity.Bug;
import com.exp.entity.Question;
import com.exp.hibernateSearch.service.HibernateSearchServiceImpl;
import com.framework.EncodingTool;

@Controller
@RequestMapping("hibernateSearch")
public class HibernateSearchController {
	@Resource
	private HibernateSearchServiceImpl hibernateSearchServiceImpl;

	/**
	 * @author Ray_1
	 * @功能 搜索下拉框，查询bug或者question，显示4条，不分页。
	 * @param search
	 * @param request
	 * @param model
	 * @param response
	 * @param session
	 */
	@RequestMapping(value = "/findBugAndQuestionByValue", method = RequestMethod.POST)
	public void searchAll(@RequestParam(name = "title", defaultValue = "") String search, HttpServletRequest request,
			Model model, HttpServletResponse response, HttpSession session) {
		System.out.println("searchParam为" + search);
		//search = EncodingTool.encodeStr(search);
		if (search == "" || search.length() == 0) {
			return;
		}
		System.out.println("查询内容" + search);
		try {
			// 这里不设置编码会有乱码
			response.setContentType("text/html;charset=utf-8");
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e2) {
			e2.printStackTrace();
		}
		List<Bug> bugs = null;
		bugs = hibernateSearchServiceImpl.searchBug(search);
		List<Question> questions = null;
		questions = hibernateSearchServiceImpl.searchQuestion(search);

		// 打印
		if (bugs != null)
			System.out.println("BUG" + bugs);
		if (questions != null)
			System.out.println("Question" + questions);
		// System.out.println("list长度为" + bugs.size());

		if (bugs == null && questions == null) {
			return;
		}
		try {
			StringBuilder sb = new StringBuilder();
			System.out.println("这是用hibernateSearch实现的");

			// 如果bug和quesion不为空时，分两种情况
			// 1 question+bug数小于4， 都显示出来
			// 2 quesiont+bug 数大于4时， 若bug<4, 显示全部bug，再用question补充；
			// 若bug数大于4，直接显示4条bug。

			// 如果 有为空的，则显示不为空的也分两种情况
			// 1 question为空，bug不为空 显示小于等于4条bug
			// 2 bug为空，question不为空，显示小于等于4条question

			if (bugs != null && questions != null) {

				if (bugs.size() + questions.size() <= 4) {
					for (Bug bug : bugs) {
						String bugtitle = bug.getBugTitle();
						System.out.println(bugtitle);
						if (bugtitle.length() > 120) {
							sb.append("<li><a>" + bugtitle.substring(0, 120) + "</a></li>");
						} else {
							sb.append("<li><a>" + bugtitle + "</a></li>");
						}
					}
					for (Question question : questions) {
						String questiontitle = question.getQuestionTitle();
						System.out.println(questiontitle);
						if (questiontitle.length() > 120) {
							sb.append("<li><a>" + questiontitle.substring(0, 120) + "</a></li>");
						} else {
							sb.append("<li><a>" + questiontitle + "</a></li>");
						}
					}
				} else {
					if (bugs.size() > 0 && bugs.size() <= 4) {
						for (int i = 0; i < bugs.size(); i++) {
							if (bugs.get(i).getBugTitle().length() >= 120) {
								sb.append("<li><a>" + bugs.get(i).getBugTitle().substring(0, 120) + "</a></li>");
							} else {
								sb.append("<li><a>" + bugs.get(i).getBugTitle() + "</a></li>");
							}
						}
						for (int i = 0; i < 4 - bugs.size(); i++) {
							if (questions.get(i).getQuestionTitle().length() >= 120) {
								sb.append("<li><a>" + questions.get(i).getQuestionTitle().substring(0, 120)
										+ "</a></li>");
							} else {
								sb.append("<li><a>" + questions.get(i).getQuestionTitle() + "</a></li>");
							}
						}
					}
					if (bugs.size() > 4) {
						for (int i = 0; i < 4; i++) {
							if (bugs.get(i).getBugTitle().length() >= 120) {
								sb.append("<li><a>" + bugs.get(i).getBugTitle().substring(0, 120) + "</a></li>");
							} else {
								sb.append("<li><a>" + bugs.get(i).getBugTitle() + "</a></li>");
							}
						}
					}

				}
			} else {
				if (bugs != null && questions == null) {
					if (bugs.size() > 4) {
						for (int i = 0; i < 4; i++) {
							if (bugs.get(i).getBugTitle().length() >= 120) {
								sb.append("<li><a>" + bugs.get(i).getBugTitle().substring(0, 120) + "</a></li>");
							} else {
								sb.append("<li><a>" + bugs.get(i).getBugTitle() + "</a></li>");
							}
						}
					} else {
						for (int i = 0; i < bugs.size(); i++) {
							if (bugs.get(i).getBugTitle().length() >= 120) {
								sb.append("<li><a>" + bugs.get(i).getBugTitle().substring(0, 120) + "</a></li>");
							} else {
								sb.append("<li><a>" + bugs.get(i).getBugTitle() + "</a></li>");
							}
						}
					}
				}
				if (questions != null && bugs == null) {
					if (questions.size() > 4) {
						for (int i = 0; i < 4; i++) {
							if (questions.get(i).getQuestionTitle().length() >= 120) {
								sb.append("<li><a>" + questions.get(i).getQuestionTitle().substring(0, 120)
										+ "</a></li>");
							} else {
								sb.append("<li><a>" + questions.get(i).getQuestionTitle() + "</a></li>");
							}
						}
					} else {
						for (int i = 0; i < questions.size(); i++) {
							if (questions.get(i).getQuestionTitle().length() >= 120) {
								sb.append("<li><a>" + questions.get(i).getQuestionTitle().substring(0, 120)
										+ "</a></li>");
							} else {
								sb.append("<li><a>" + questions.get(i).getQuestionTitle() + "</a></li>");
							}
						}
					}

				}
			}
			// System.out.println(sb.toString());
			if (sb != null)
				response.getWriter().write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}