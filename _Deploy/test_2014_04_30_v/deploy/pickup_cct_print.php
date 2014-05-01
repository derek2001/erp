<?php
include_once("config.php");
$wos = explode(",",$_GET['wos']);
if ($_SESSION["user"]->hasRestriction('unit_print')) $wo_unit_print=true;

if($_GET['unitprice'] == 1 && $wo_unit_print) {
	for($x=0;$x<count($wos);$x++) {
		$_SESSION["user"]->db->select("SELECT id FROM ord_unit where id_order=".$wos[$x]);
		$tab = $_SESSION["user"]->db->fetchAllArrays();
		//print_r($tab);
		for ($y = 0; $y < count($tab); $y++) {
			$_GET['oid']=$wos[$x]; $_GET['uid'] = $tab[$y]['id']; $_GET['pict']=0; $_GET['disc']=$_GET['disc'];
			include('print_wounit.php');
                        //include('print_order.php');
			if ($y+1 != count($tab)) 
			echo '<div style="page-break-before:always;font-size:1;margin:0;border:0;"><span style="visibility: hidden;">-</span></div>';
		}
	}
}
else {
	for($x=0;$x<count($wos);$x++) {
		$_SESSION["user"]->db->select("SELECT id FROM ord_unit where id_order=".$wos[$x]);
		$tab = $_SESSION["user"]->db->fetchAllArrays();
		$_GET['oid']=$wos[$x];
			for ($y = 0; $y < count($tab); $y++) {
		        $_GET['uid'] = $tab[$y]['id'];		
			include('print_production.php');
			


		
	 	}
		
	}
}


?>