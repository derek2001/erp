<?php
include_once("config.php");
$loc = $_SESSION["user"]->getLocationProfile();
$id_worker = $_SESSION["user"]->getWorkerID();


if($_GET['type']==0){
    $id_order = $_GET["id_order"];
    $status = $_GET["status"];
	$sql="select cstatus from dbo.[contest] WHERE id_order=$id_order";
	$_SESSION["user"]->db->select($sql);
	$i=0;
	while ( $row = $_SESSION["user"]->db->fetchArray() ){
		$i++;
	}

	if($i>0){
		$sql0="UPDATE dbo.[order] set contest_status='".$status."' WHERE id=$id_order";
		if ($_SESSION["user"]->db->select($sql0))
			$data = 0;
		else{
			$sql1="UPDATE dbo.[contest] set cstatus='".$status."' WHERE id_order=$id_order";
			if ($_SESSION["user"]->db->select($sql1))
				$data = 0;
			else
				$data = $id_order;
		}
		
	}
	else{
		$sql="INSERT INTO dbo.[contest](id_order, cstatus)VALUES($id_order,'".$status."')";
       	if ($_SESSION["user"]->db->select($sql))
       		 $data = 0;
		 else
			 $data = $id_order;
	}
 }

if($_GET['type']==1){
    $sql_status = "select value as valor, description from dbo.contest_status order by id";
    $_SESSION["user"]->db->select($sql_status);
    $html ='<select name="cbx_status_'.$_GET['control_id'].'" id="cbx_status_'.$_GET['control_id'].'" style="width: 120px;">
                <option value="-1">Select Status</option>';
                while ( $row = $_SESSION["user"]->db->fetchArray() ){
                    $html .='<option value="'.$row['valor'].'">'.$row['description'].'</option>';
                }
    $html .='</select>';
    $data = $html."&".$_GET['control_id'];
}

if($_GET['type']==2){
    $id_order = $_GET["id_order"];
	$text = $_GET["text"];
    $sql="UPDATE dbo.contest set reason_cancel='".$text."' WHERE id_order=$id_order";
    if ($_SESSION["user"]->db->select($sql))
        $data = 0;
    else
        $data = 1;
 }
 
 if($_GET['type']==3){
	$id_order = $_GET["id_order"];
    $sql = "select reason_cancel from dbo.contest where id_order=$id_order";
    $_SESSION["user"]->db->select($sql);
	while ( $row = $_SESSION["user"]->db->fetchArray() ){
		$text = $row['reason_cancel'];
	}
    $data = $text;
}


 
 if($_GET['type']==4){
	$id_order = $_GET["id_order"];
    $sql = "select notes from dbo.contest where id_order=$id_order";
    $_SESSION["user"]->db->select($sql);
	while ( $row = $_SESSION["user"]->db->fetchArray() ){
		$text = $row['notes'];
	}
    $data = $text;
}

if($_GET['type']==5){
    $id_order = $_GET["id_order"];
	$text = $_GET["text"];
    $sql="UPDATE dbo.contest set notes='".$text."' WHERE id_order=$id_order";
    if ($_SESSION["user"]->db->select($sql))
        $data = 0;
    else
        $data = 1;
 }

if($_GET['type']==6){
        $id_order = $_GET["id_order"];
        $templator = $_GET["templator"];
        $installer = $_GET["installer"];
        $sql="select id_order from dbo.templator_log WHERE id_order=$id_order";
        $_SESSION["user"]->db->select($sql);
        $i=0;
		$user = $_SESSION['user']->getUserName();
		$sql="INSERT INTO dbo.[templator_log](id_order, templator,installer,default_date,created_by)VALUES($id_order,'".$templator."','".$installer."',GETDATE(),'".$user['name']."')";
		if ($_SESSION["user"]->db->select($sql))
			$data = 0;
		else
			$data = $id_order;

}

if($_GET['type']==7){
    $id_order = $_GET["id_order"];
    $sql = "select id, id_order, templator, installer, CONVERT(VARCHAR(10),default_date ,101)+' '+CONVERT(VARCHAR(8),default_date, 108)+' '+RIGHT(CONVERT(VARCHAR(50),default_date, 109), 2) as default_date,created_by from dbo.templator_log where id_order=$id_order order by default_date desc";
    $_SESSION["user"]->db->select($sql);
    $html='<table width="818" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td class="cell_table_lefttophard_01"><img src="gfx/spacer.gif" width="3" height="3"></td>
                  <td width="333" class="cell_table_top"><img src="gfx/spacer.gif" width="333" height="3"></td>
                  <td class="cell_table_righttophard_01"><img src="gfx/spacer.gif" width="3" height="3"></td>
                </tr>
                <tr>
                  <td class="cell_table_left"><img src="gfx/spacer.gif" width="3" height="3"></td>
                  <td width="818" class="cell_tablecenter"><table width="818" border="0" cellpadding="0" cellspacing="1">
<tr><td width="100%" align="left">
<table width="100%" border="0">
<tr class="cell_reccolor_neutral_01" align="center">
                    <td width="150">Templator</td>
                    <td width="150">Installer</td>
					<td width="150">Created By</td>
                    <td width="30">Date</td>
                    <td width="20">&nbsp;</td>
                </tr>';
	$i=0;
   while ( $row = $_SESSION["user"]->db->fetchArray() ){
      $html.='<tr class="cell_reccolor_neutral_01">
                <td align="left">'.$row['templator'].'</td>
                <td align="left">'.$row['installer'].'</td>
				<td align="left">'.$row['created_by'].'</td>
                <td align="left">'.$row['default_date'].'</td>
                <td align="left">
				<img src="gfx/trash1.gif" onClick="DeleteTemplator('.$row['id'].','.$row['id_order'].');" border="0" >
				</td>
              </tr>';
			  $i++;
    }
    $html .="</table>";
    
	
	$html2='<table width="818" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td class="cell_table_lefttophard_01"><img src="gfx/spacer.gif" width="3" height="3"></td>
                  <td width="333" class="cell_table_top"><img src="gfx/spacer.gif" width="333" height="3"></td>
                  <td class="cell_table_righttophard_01"><img src="gfx/spacer.gif" width="3" height="3"></td>
                </tr>
                <tr>
                  <td class="cell_table_left"><img src="gfx/spacer.gif" width="3" height="3"></td>
                  <td width="818" class="cell_tablecenter"><table width="818" border="0" cellpadding="0" cellspacing="1">
<tr><td width="100%" align="left">
<table width="100%" border="0">
<tr class="cell_reccolor_neutral_01" align="center">
                    <td width="100" colspan="5"><font color="#FF0000"><b>No Logs Found.</b></font></td>
                </tr>
				</table>';
	
	
	if($i>0)
		$data = $html;
	else
		$data = $html2;
}


if($_GET['type']==8){
    $id_order = $_GET["id_order"];
	$id = $_GET["id"];
    $sql = "delete from dbo.templator_log where id=$id";
    $_SESSION["user"]->db->select($sql);
	if ($_SESSION["user"]->db->select($sql))
		 $data = 0;
	 else
		 $data = $id_order;

}

if($_GET['type']==9){
    $sql = "delete from dbo.ord_unit where id = ".$_GET['id']."";
	if ($_SESSION["user"]->db->select($sql))
		 $data = 0;
	 else
		 $data = 1;

}


echo $data;
