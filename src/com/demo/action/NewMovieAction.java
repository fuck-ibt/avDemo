package com.demo.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.DemoException;
import com.demo.ErrorCode;
import com.demo.util.json.JSONException;
import com.demo.util.json.JSONObject;

public class NewMovieAction extends AbstractAction {

	@Override
	protected int _doAction(HttpServletRequest req, HttpServletResponse res)
			throws DemoException {
		if(getSessionContainer(req).getUser()!=null){
			//TO-DO 查询需要的表单信息。
			res.setStatus(200);
			this.reqParams.put("page", "newMovie.jsp");
			_forward(req, res);
		}else{
		    res.setStatus(403);
			this.reqParams.put("page", "403.jsp");
			_forward(req, res);
		}
		return 0;
	}
	
}
