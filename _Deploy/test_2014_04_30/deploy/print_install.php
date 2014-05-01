<?
include_once("config.php");
global $date_format;

if (!isset($_GET['oid'])) die('<font color="red" ><span style="font-family: Arial, Helvetica, sans-serif">Installation is not specified.</span></font>');

//load disclaimers
//if (isset($_GET['disc']) && $_GET['disc']=='1')
{
  $_SESSION['user']->db->select('select name,content from disclaimer where name=\'order\'');
  $discl = $_SESSION['user']->db->fetchAllArrays();
  if (is_array($discl)) foreach($discl as $v) { $disclaimer[$v['name']] = $v['content']; }
}

include_once('objects/print_order_object.php');
$print = new PrintOrder($_SESSION['user'],6);
if (isset($_GET['uid'])) $print->PrintOnlyOneUnit($_GET['uid']);
if (isset($_GET['iid'])) $print->PrintForOneInstallation($_GET['iid']);
$pictures = true; $only_templates = false;
$data = $print->GetData($_GET['oid'],$only_templates,$pictures,true /*force_pictures*/);

$sqll = "select templator as temp, installer as inst from dbo.templator_log where id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sqll);
$rs = $_SESSION["user"]->db->fetchAllArrays();


$sqll = "select count(*) as temp_cant from dbo.templator_log where templator <> '' and id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sqll);
$rscount = $_SESSION["user"]->db->fetchAllArrays();

$sql2 = "select count(*) as inst_cant from dbo.templator_log where installer <> '' and id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sql2);
$rscount1 = $_SESSION["user"]->db->fetchAllArrays();

//print_r($data);
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
$smarty->assign('pictures',$_GET['pictures']);
$smarty->assign('no_address',$_GET['no_address']);
$smarty->assign('disclaimer',$disclaimer);
$smarty->assign('date',date($date_format,time()));

$smarty->assign('templator',$rs);
$smarty->assign('templator_count',$rscount);
$smarty->assign('installer_count',$rscount1);

$loc = $_SESSION['user']->getLocationProfile();
$_SESSION['user']->db->select('select * from location where id='.$loc['id']);
$loc = $_SESSION['user']->db->fetchArray();
$smarty->assign('loc',$loc);
$smarty->assign('print_release',$_GET['print_release']);
//Directions
/*
$addr = array();
if (isset($data['unit'][0]) && isset($data['unit'][0]['temp'][0]['order']) && $data['unit'][0]['temp'][0]['order']>0)
{
    $_SESSION['user']->db->select('select id_worker,[order],o_address,o_town,o_state,o_zip from task_select(\''.$data['unit'][0]['temp'][0]['temp_date'].'\',\''.$data['unit'][0]['temp'][0]['temp_date'].'\')
    where (id_worker IN (select distinct id_worker from pl_worker where id='.$data['unit'][0]['temp'][0]['id_templater'].') and type=3) or (id_worker='.$data['unit'][0]['temp'][0]['id_templater'].' and type!=3) and [order]='.($data['unit'][0]['temp'][0]['order']-1));
    $tsk = $_SESSION['user']->db->fetchArray();
    if (is_array($tsk)) {
    $addr['address'] = $tsk['o_address']; $addr['town'] = $tsk['o_town']; $addr['state'] = $tsk['o_state'];  $addr['zip'] = $tsk['o_zip'];}
}
if (count($addr)==0)
{
    $_SESSION['user']->db->select('select address,town,state,zip from location where id='.$data['location']['id']);
    $tsk = $_SESSION['user']->db->fetchArray();
    if (is_array($tsk)) {
    $addr['address'] = $tsk['address']; $addr['town'] = $tsk['town']; $addr['state'] = $tsk['state'];  $addr['zip'] = $tsk['zip'];}
}
if (count($addr)>0)
{       
    $way = array(
                   array($addr['address'],$addr['town'],$addr['state'],$addr['zip']),
                   array($order['address'],$order['town'],$order['state'],$order['zip'])
                );
    
    //print_r($way);
    include_once('objects/object.direction.php');
    $direction = new cDirection($way,0);
    $smarty->assign('direction',array('way'=>$direction->dirWay(),'map'=>$direction->showMapImage()));
}
*/
$smarty->display('print/print_install.tpl');
?>
