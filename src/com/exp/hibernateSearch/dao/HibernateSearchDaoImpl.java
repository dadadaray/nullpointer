package com.exp.hibernateSearch.dao;

import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.cn.ChineseAnalyzer;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.hibernate.search.SearchFactory;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.ReflectionUtils;

import com.exp.entity.Bug;
import com.exp.entity.Question;
import com.framework.BaseDao;

@Repository
public class HibernateSearchDaoImpl extends BaseDao<Bug, String> {
	/**
	 * @author Ray_1 
	 * @功能：用hibernateSearch 获取不分页的4条bug，并用高亮显示。
	 * @param search
	 * @return
	 */

	public List<Bug> searchBug(String search) {

		Session session = super.getSession();
		FullTextSession fullTextSession = Search.getFullTextSession(session);
		try {
			fullTextSession.createIndexer().startAndWait();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SearchFactory sf = fullTextSession.getSearchFactory();
		QueryBuilder qb = sf.buildQueryBuilder().forEntity(Bug.class).get();
		List<Bug> list = null;
		try {
			// 模糊查询
			org.apache.lucene.search.Query luceneQuery = qb.keyword().fuzzy().withThreshold(0.5f)
					.onFields("bugTitle", "bugDescribe", "bugReason").matching(search).createQuery();
			Query hibQuery = fullTextSession.createFullTextQuery(luceneQuery);
			list = hibQuery.list();
			// 集关键字高亮的实现代码
			SimpleHTMLFormatter formatter = new SimpleHTMLFormatter("<font style='font-weight:bold;'>", "</font>");
			QueryScorer queryScorer = new QueryScorer(luceneQuery);
			Highlighter highlighter = new Highlighter(formatter, queryScorer);
			Analyzer analyzer = new ChineseAnalyzer();
			String[] fieldNames = { "bugTitle", "bugDescribe", "bugReason" };
			for (Bug q : list) {
				for (String fieldName : fieldNames) {
					// 运用反射得到具体的标题内容
					Object fieldValue = ReflectionUtils
							.invokeMethod(BeanUtils.getPropertyDescriptor(Bug.class, fieldName).getReadMethod(), q);
					String hightLightFieldValue = null;
					if (fieldValue instanceof String) {
						// 获得高亮关键字
						hightLightFieldValue = highlighter.getBestFragment(analyzer, fieldName,
								ObjectUtils.toString(fieldValue, null));
					}
					// 这个判断很关键，否则如果标题或内容中没有关键字的话，就会出现不显示的问题。
					if (hightLightFieldValue != null) {
						// 运用反射设置结果集中的关键字高亮
						ReflectionUtils.invokeMethod(
								BeanUtils.getPropertyDescriptor(Bug.class, fieldName).getWriteMethod(), q,
								hightLightFieldValue);
					}
				}
			}
		} catch (Exception e) {
			//
		}
		return list;
	}
	
	/**
	 * @author Ray_1
	 * @功能：不分页用hibernateSearch查询4条 question，并用高亮显示。
	 * @param search
	 * @return
	 */
	
	public List<Question> searchQuestion(String search) {

		Session session = super.getSession();
		FullTextSession fullTextSession = Search.getFullTextSession(session);
		try {
			fullTextSession.createIndexer().startAndWait();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SearchFactory sf = fullTextSession.getSearchFactory();
		QueryBuilder qb = sf.buildQueryBuilder().forEntity(Question.class).get();
		List<Question> list = null;
		try {
			// 模糊查询
			org.apache.lucene.search.Query luceneQuery = qb.keyword().fuzzy().withThreshold(0.5f)
					.onFields("questionTitle", "questionDescribe").matching(search).createQuery();
			Query hibQuery = fullTextSession.createFullTextQuery(luceneQuery);
			list = hibQuery.list();
			// 集关键字高亮的实现代码
			SimpleHTMLFormatter formatter = new SimpleHTMLFormatter("<font style='font-weight:bold;'>", "</font>");
			QueryScorer queryScorer = new QueryScorer(luceneQuery);
			Highlighter highlighter = new Highlighter(formatter, queryScorer);
			Analyzer analyzer = new ChineseAnalyzer();
			String[] fieldNames = {"questionTitle", "questionDescribe"};
			for (Question q : list) {
				for (String fieldName : fieldNames) {
					// 运用反射得到具体的标题内容
					Object fieldValue = ReflectionUtils
							.invokeMethod(BeanUtils.getPropertyDescriptor(Question.class, fieldName).getReadMethod(), q);
					String hightLightFieldValue = null;
					if (fieldValue instanceof String) {
						// 获得高亮关键字
						hightLightFieldValue = highlighter.getBestFragment(analyzer, fieldName,
								ObjectUtils.toString(fieldValue, null));
					}
					// 这个判断很关键，否则如果标题或内容中没有关键字的话，就会出现不显示的问题。
					if (hightLightFieldValue != null) {
						// 运用反射设置结果集中的关键字高亮
						ReflectionUtils.invokeMethod(
								BeanUtils.getPropertyDescriptor(Question.class, fieldName).getWriteMethod(), q,
								hightLightFieldValue);
					}
				}
			}
		} catch (Exception e) {
			//e.printStackTrace();
		}
		return list;
	}

}