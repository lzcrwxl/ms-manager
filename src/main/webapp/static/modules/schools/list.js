var grid_selector = "#grid-table";
var pager_selector = "#grid-pager";
var obj={
	query:function(){
		$(grid_selector).jqGrid({
			url: config.schoolsQueryUrl,
			datatype: "json",
			height:'auto',
			colNames:['学校名称','学校地址','联系人','联系电话','报考课程','操作'],
			colModel:[
				{name:'schoolName',index:'schoolName',width:150,sortable:false},
				{name:'schoolAddress',index:'schoolAddress', width:200,sortable:false},
				{name:'contacts',index:'contacts', width:70,sortable:false},
				{name:'contactPhone',index:'contactPhone', width:150,sortable:false},
				{name:'applyCoursesName',index:'applyCoursesName', width:160,sortable:false},
				{name:'',index:'', width:100, fixed:true, sortable:false, resize:false,
					formatter:actFormatter
				}
			],
			rownumbers: true,
			hidegrid: false,
			viewrecords : true,
			rowNum:10,
			pager : pager_selector,
	        loadComplete : function() {
				var table = this;
				setTimeout(function(){
					updatePagerIcons(table);
				}, 0);
			},
			autowidth: true
		});
	}
	,
	modifyObj:function(id){
		window.location.href=config.schoolsFormUrl+"?id="+id;
	}
	,
	init:function(){
		obj.query();
		//初始化绑定事件
		$("#queryBtn").bind("click",function(){
			obj.refreshTable();
		});
	}
	,
	refreshTable:function(){
		var params={
			schoolName:encodeURIComponent($("#schoolName").val())
		};
		$(grid_selector).setGridParam({url:config.schoolsQueryUrl,postData:params}).trigger('reloadGrid');
	}
};

function actFormatter(cellvalue, options, rawObject) {
	var div='<div style="margin-left:8px;">';
	var edit ='<div style="float:left;cursor:pointer;" class="ui-pg-div ui-inline-edit"'
				+'onclick="obj.modifyObj('+ rawObject.id+')"><span class="ui-icon ui-icon-pencil"></span></div>';
	return div+ edit;
};

jQuery(function($) {
	$(window).on('resize.jqGrid', function () {
		$(grid_selector).jqGrid( 'setGridWidth', $(".page-content").width());
    });
	//初始化面包屑
	initBreadcrumb();
	obj.init();
	$("#jqgh_grid-table_rn span.s-ico").before("<span>序号</span>");
});
