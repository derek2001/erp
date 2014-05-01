<?
include_once("config.php");
global $date_format;

if (!isset($_GET['oid'])) die('<font color="red" ><span style="font-family: Arial, Helvetica, sans-serif">Installation is not specified.</span></font>');
{
  $_SESSION['user']->db->select('select name,content from disclaimer where name=\'order\'');
  $discl = $_SESSION['user']->db->fetchAllArrays();
  if (is_array($discl)) foreach($discl as $v) { $disclaimer[$v['name']] = $v['content']; }
}

include_once('objects/print_order_object.php');
$print = new PrintOrder($_SESSION['user'],5);
if (isset($_GET['uid'])) $print->PrintOnlyOneUnit($_GET['uid']);
$data = $print->GetData($_GET['oid'],false,true,true);


$sqll = "select templator as temp, installer as inst from dbo.templator_log where id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sqll);
$rs = $_SESSION["user"]->db->fetchAllArrays();


$sqll = "select count(*) as temp_cant from dbo.templator_log where templator <> '' and id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sqll);
$rscount = $_SESSION["user"]->db->fetchAllArrays();

$sql2 = "select count(*) as inst_cant from dbo.templator_log where installer <> '' and id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sql2);
$rscount1 = $_SESSION["user"]->db->fetchAllArrays();

include_once('Smarty.class.php');
$smarty = new Smarty;
//H E A D E R - MENU  --------------------------------------------------
$smarty->assign('user_profile',$_SESSION['user']->getUserName());
global $css_color;
$smarty->assign('css_color',$css_color);
$smarty->assign('time',date($date_format,time()));
$smarty->assign('menulink',$_SESSION['user']->getMenuLink());
//----------------------------------------------------------------------
$smarty->assign('data',$data);
$smarty->assign('nsg',$_GET['nsg']);


$smarty->assign('templator',$rs);
$smarty->assign('templator_count',$rscount);
$smarty->assign('installer_count',$rscount1);

$smarty->display('print/print_template.tpl');
?>