<?
include_once("config.php");
global $date_format;

if (!isset($_GET['oid'])) die('<font color="red" ><span style="font-family: Arial, Helvetica, sans-serif">Installation is not specified.</span></font>');

include_once('objects/print_order_object.php');
$print = new PrintOrder($_SESSION['user'],7);
if (isset($_GET['uid'])) $print->PrintOnlyOneUnit($_GET['uid']);
$data = $print->GetData($_GET['oid'],false,true,true);
echo $print->GetError();
//----------------------------------------- informacje o edgach dodal PAWEL na potrzeby wydruku

$sql = 'select  * from ord_rectangle where id_ord_unit='.$_GET['uid'];
  $_SESSION["user"]->db->select($sql);
  $edge = $_SESSION["user"]->db->fetchAllArrays();
  
//print_r($edge[1]);
$kol[1] = array('id_edge1','id_edge2','id_edge3','id_edge4','id_b1_et','id_b2_et','id_b4_et','id_b1_es','id_b2_es','id_b4_es');
$kol[2] = array('e1_length','e2_length','e3_length','e4_length','b1_et_length','b2_et_length','b4_et_length','b1_es_length','b2_es_length','b4_es_length' );
foreach($edge as $k=>$v)
   {
	
	foreach($v as $kl=>$vr) 
	  foreach($kol[1] as $key=>$var) 
		    if (!is_numeric($kl))
		   if (($kl==$var) and ($v[$var]!=0))
	        {
			$pab[$v[$var]]['len']+=$v[$kol[2][$key]];
	          if ($key>3)
			  $pab[$v[$var]]['bck']+=$v[$kol[2][$key]]; 
		 
		 }
	}

foreach($data['unit'][0]['edge'] as $kk=>$vv)
    foreach($pab as $k=>$v)
	{
      if ($vv['id_edge']==$k) 
	    {
		  if ( !is_null($v['bck']))
			  if ($v['len']-$v['bck']>0)
				 {$data['unit'][0]['edgec'][]=$vv;
				 $data['unit'][0]['edgeb'][]=$vv;
				  }
			  else	 
				 $data['unit'][0]['edgeb'][]=$vv;
            else
				$data['unit'][0]['edgec'][]=$vv;	
	}}

$data['unit'][0]['edge']['co_count']=count($data['unit'][0]['edgec']);
//print_r($data['unit'][0]['edge']);

//print_r($data['unit'][0]);



$sqll = "select templator as temp, installer as inst from dbo.templator_log where id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sqll);
$rs = $_SESSION["user"]->db->fetchAllArrays();

$sqll = "select count(*) as cantidad from dbo.templator_log where id_order =".$_GET['oid']."";
$_SESSION["user"]->db->select($sqll);
$rscount = $_SESSION["user"]->db->fetchAllArrays();


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
$smarty->assign('date',date($date_format,time()));
$smarty->assign('disclaimer',$disclaimer);


$smarty->assign('templator',$rs);
$smarty->assign('templator_count',$rscount);



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
    include_once('objects/object.direction.php');
    $direction = new cDirection($way,2);
    $smarty->assign('direction',array('way'=>$direction->dirWay(),'map'=>$direction->showMapImage()));
}
*/

$smarty->display('print/print_production.tpl');
?>