package com.exp.answer.service;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.exp.answer.dao.AnswerDaoImpl;
import com.exp.entity.Answer;
import com.exp.entity.Comment;
import com.framework.Page;

@Service
@Transactional(readOnly = true)
public class AnswerServiceImpl {

	@Resource
	private AnswerDaoImpl answerDaoImpl;//answerdaoimpl改成answerDaoImpl

	/**
	 * @author Ray_1 功能 按时间将用户的所有问题查询出来
	 * @param pageNum
	 *            页码数
	 * @param pageSize
	 *            一页几条
	 * @param params
	 *            hql参数
	 * @return 用户的问题列表，放到page对象中
	 */
	@Transactional(readOnly = true)
	public Page<Answer> findAnswerByTime(int pageNum, int pageSize, Object[] params) {
		return this.answerDaoImpl.findAnswerByTime(pageNum, pageSize, params);
	}
	/**
	 * @function 根据answerId删除单个answer
	 * @author tangwenru
	 * @param answerId
	 */
	@Transactional(readOnly=false)
	public void deleteAnswer(Integer answerId){
		this.answerDaoImpl.deleteAnswer(answerId);
	}
	/**
	 * @function 保存答案
	 * @author tangwenru
	 * @param answer
	 */
	@Transactional(readOnly = false)
	public void saveAnswer(Answer answer){
		try {
			this.answerDaoImpl.save(answer);
		} catch (Exception e) {
			// TODO Auto-generated catch block1
	         e.printStackTrace();
		}
	}
	@Transactional(readOnly = true)
	public Answer getAnswer(int answerId){
		return this.answerDaoImpl.getAnser(answerId);
		
	}
	
}
