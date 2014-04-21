{include file="header.tpl"}
<script type="text/javascript" src="js/design.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

{literal}
    <script>
        function clearSendEmailData()
        {
            $(document).ready(function(){
                $('#id_e_woId').val('');
                $('#id_e_location').val('');
            });
        }
    </script>
    <script>

        $(document).ready(function() {

            // set db click and click operation
            var alreadyClicked = false;
            var newWind = null;

            $('.test div').bind('click', function(e) {
                var el = $(this);

                if (alreadyClicked) {
                    alreadyClicked=false; // reset
                    clearTimeout(alreadyClickedTimeout); // prevent this from happening
                    // do what needs to happen on double click.
                    addPictureIdToSend(el);

                } else {
                    alreadyClicked = true;
                    alreadyClickedTimeout = setTimeout(function(){
                        alreadyClicked = false; // reset when it happens
                        // do what needs to happen on single click.
                        // use el instead of $(this) because $(this) is no longer the element
                        openPicturesPopup(el);
                    },300); // <-- dblclick tolerance here
                }
                return false;
            });

            function openPicturesPopup(el)
            {
                var arr_ids = el.attr('id').split('_');
                if (arr_ids[0] > 0 || arr_ids[1] > 0 || arr_ids[2] > 0 || arr_ids[3] > 0 )
                    if(newWind==null || newWind.closed)
                        newWind=window.open('editframepictures.php?slab_frame_id='+arr_ids[0]+'&slab_id='+arr_ids[1]+'&frame_id='+arr_ids[2]+'&stone_id='+arr_ids[3],
                                'editframepictures','width=820,height=540,left=100,top=30,location=no,menubar=no,resizable=no,scrollbars=no,toolbar=no');
            }

            function addPictureIdToSend(el)
            {
                var arr_ids = el.attr('id').split('_');
                if (arr_ids[0] > 0 || arr_ids[1] > 0 || arr_ids[2] > 0 || arr_ids[3] > 0 )
                {
                    var stoneId = this.id;
                    // cache id in hidden field
                    var arrIds = $("#id_e_hidStonesSelected").val().split(';');
                    arrIds.push(stoneId);
                    // display
                    // var stoneText = this.innerHTML;
                    var stoneText = el.find("span.sign").text();
                    // get list and add stone
                    var delLink =  "<a href='#'><img src='gfx/delete.png' border=0 align='middle'></a>";
                    $('#id_e_stonesSelected').append('<li>'+stoneText+'&nbsp;'+delLink+'</li>');
                }
            }
        });

    </script>
    <script>
        /*
        var newWind = null;
        $(document).ready(function(){

            $(".test div").click(function(e) {
                var arr_ids = this.id.split('_');
                if (arr_ids[0] > 0 || arr_ids[1] > 0 || arr_ids[2] > 0 || arr_ids[3] > 0 )
                    if(newWind==null || newWind.closed)
                        newWind=window.open('editframepictures.php?slab_frame_id='+arr_ids[0]+'&slab_id='+arr_ids[1]+'&frame_id='+arr_ids[2]+'&stone_id='+arr_ids[3],
                                'editframepictures','width=820,height=540,left=100,top=30,location=no,menubar=no,resizable=no,scrollbars=no,toolbar=no');
            });

            $(".test div").dblclick(function() {
                var arr_ids = this.id.split('_');
                if (arr_ids[0] > 0 || arr_ids[1] > 0 || arr_ids[2] > 0 || arr_ids[3] > 0 )
                {
                    var stoneId = this.id;
                    // cache id in hidden field
                    var arrIds = $("#id_e_hidStonesSelected").val().split(';');
                    arrIds.push(stoneId);
                    // display
                    // var stoneText = this.innerHTML;
                    var stoneText = $(this).find("span.sign").text();
                    // get list and add stone
                    var delLink =  "<a href='#'><img src='gfx/delete.png' border=0 align='middle'></a>";
                    $('#id_e_stonesSelected').append('<li>'+stoneText+'&nbsp;'+delLink+'</li>');
                }
            });

            // location email box
            $('#id_e_location').change(function() {
                var emailVal = $(this).val();
                // set email text
                $('#id_e_email').val(emailVal);
                // reset source type select
                $('#id_e_sourceType').val("0");

                $("#id_e_source_val").val("");
                $('#id_e_source_div').hide();
            });

            $('#id_e_sourceType').change(function() {
                var sourceTypeVal = $(this).val();
                // set source input visibility

                $('#id_e_location').val("0");
                $("#id_e_source_val").val("");
                $("#id_e_email").val("");

                if (sourceTypeVal == 0)
                {
                    $('#id_e_source_div').hide();

                } else
                {
                    $('#id_e_source_div').show();
                }
            });

            $('#id_e_woGo').click(function(e) {
                // check order id using webservice
                var val = $('#id_e_source_val').val();
                var type= $('#id_e_sourceType').val();

                if (type != "0") {
                    $.ajax({
                        type: "GET",
                        url: "picture_board_search.php",
                        data: "val="+val+"&type="+type,
                        dataType: "json",
                        beforeSend: function(xhr) {
                            xhr.setRequestHeader("Ajax-Request", "true");
                        },
                        success: function(data) {
                            // from json array
                            $("#id_e_email").val(data);
                        }
                    });
                }
            });

            // by default source is hidden
            $('#id_e_source_div').hide();
        });
*/
    </script>
{/literal}
{literal}
    <style>
        em {
            width: 250px;
            height: 50px;
            position: absolute;
            text-align: left;
            font-size: 11px;
            padding: 10px;
            font-style: normal;
            z-index: 20;
            display: none;
            background-color:#FFFFFF;
            border:1px solid red;
        }

        .selectedStonesList
        {
            list-style-type: none;
            margin: 0;
            padding: 0.5em 0 0.5em;
        }

        .selectedStonesList li
        {
            margin: 0 2px 2px 2px;
            padding: 2px;
            width: 140px;
            display: inline;
        }
    </style>
{/literal}
{assign var="module_name" value="Picture Board"}
{include file="module_header.tpl"}

<div style="float: left; padding-right: 15px; padding-left: 15px;">
    {assign var="table_width" value="400"}
    {assign var="table_headertitle" value="Send email"}
    {include file="table_header.tpl"}
    <tr class="cell_reccolor_blue_01a">
        <td nowrap>Email:</td>
        <td><input type="text" name="e_email" id="id_e_email"  size="25" value=""></td>
    </tr>

    <tr class="cell_reccolor_blue_01b">
        <td nowrap>Source:</td>
        <td>
            <select name="e_sourceType" id="id_e_sourceType">
                <option value="0">--Select--</option>
                <option value="1">Estimate ID</option>
                <option value="2">Account ID</option>
                <option value="3">Phone number</option>
                <option value="4">W/O</option>
            </select>
            <div id="id_e_source_div">
                <input type="text" name="e_source_val" id="id_e_source_val" size="15" value="">
                &nbsp;<input type="button" name="e_woGo" id="id_e_woGo" value="go" class="BUTTON_OK">
            </div>
        </td>
    </tr>
    <tr class="cell_reccolor_blue_01a">
        <td nowrap>Other location:</td>
        <td>
            <select name="e_location" id="id_e_location">
                <option value="0">--Any--</option>
                <option value="SPsales@marble.com">SP</option>
                <option value="PAsales@marble.com">PA</option>
                <option value="CTsales@marble.com">CT</option>
                <option value="LIsales@marble.com">LI</option>
                <option value="VLsales@marble.com">VL</option>
            </select>
        </td>
    </tr>
    <tr class="cell_reccolor_blue_01b">
        <td nowrap>Stones selected:</td>
        <td>
            <input type="hidden" name="e_hidStonesSelected" id="id_e_hidStonesSelected" value="" />
            <ul class="selectedStonesList" id="id_e_stonesSelected">
            </ul>
        </td>
    </tr>
    <tr class="cell_reccolor_blue_01a">
        <td nowrap>Notes</td>
        <td>
            <textarea name="e_notes" id="id_e_notes" cols="20" rows="4"></textarea>
        </td>
    </tr>
    <tr class="cell_reccolor_blue_01b">
        <td>&nbsp;</td>
        <td>
            <input type="button" value="clear" class="BUTTON_CANCEL" onclick="clearSendEmailData()">&nbsp;
            <input type="submit" name="submit" value="send" class="BUTTON_OK">

        </td>
    </tr>
    {include file="table_footer.tpl"}
</div>
<div style="float: left;">
    {assign var="table_width" value="1222"}
    {assign var="table_headertitle" value=""}
    {include file="table_header.tpl"}

    <tr>
        <td align="right" width="55%">
            <div style="float:right;"> &nbsp;&nbsp;&nbsp;&nbsp; </div>
            <div style="width:70px; background-color: #c2f19f; border: 1px solid black; float:right; font-size:11px">DONE?</div>
            <div style="float:right; padding:0 5px 0 5px"> | </div>
            <div style="width:70px; background-color: #c2f19f; border: 1px solid black; float:right; font-size:11px">DONE</div>
            <div style="float:right; padding:0 5px 0 5px"> | </div>
            <div style="width:70px; background-color: #c2f19f; color:white; border: 1px solid black; float:right; font-size:11px">WWW DONE</div>
            <div style="float:right; padding:0 5px 0 5px"> | </div>
            <div style="width:70px; background-color: orange; border: 1px solid black; float:right; font-size:11px">ERP DONE</div>
            <div style="float:right; padding:0 5px 0 5px"> | </div>
            <div style="width:70px; background-color: orange; color:white; border: 1px solid black; float:right; font-size:11px">JPEG DONE</div>
            <div style="float:right; padding:0 5px 0 5px"> | </div>
            <div style="width:70px; background-color: #ffa399; color:white; border: 1px solid black; float:right; font-size:11px">RAW OK</div>
            <div style="float:right; padding:0 5px 0 5px"> | </div>
            <div style="width:70px; background-color: #ffa399; border: 1px solid black; float:right; font-size:11px">NOT DONE</div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <br>
            {counter start=0 print=false assign="cnt" }
            <span class="test">
                {section name=f loop=$data}
                    <span>

                    {if $data[f.index_prev].id_frame == $data[f].id_frame
                    && $data[f.index_prev].id_slab == $data[f].id_slab
                    && ($data[f].slab_board == null || $data[f].slab_board == 0)
                    && (!is_array($data[f].history)
                    && !is_array($data[f].history[0].id_frame)
                    && $data[f].history[0].id_frame.old_sign == '')}
                    {else}
                        {counter}
                        <div class="test" id="{$data[f].id}_{$data[f].id_slab}_{$data[f].id_frame}_{$data[f].id_stone}"
                             style="font-size: 11px; float:left; width:40px; margin: 3px;
                                     padding: 1px; border: 1px solid black;
                             {if $data[f].www_pic.pict1 != '' && $data[f].www_pic.pict2 != '' && $data[f].www_pic.pict3 != ''}
                                     background-color: #c2f19f;
                             {elseif $data[f].pic_count.cnt_www > 2}
                                     background-color: #c2f19f; color: #ffffff;
                             {elseif $data[f].pic_count.cnt_erp > 0}
                                     background-color: orange;
                             {elseif $data[f].pic_count.cnt_jpg > 0}
                                     background-color: orange; color: #ffffff;
                             {elseif $data[f].pic_count.cnt_raw > 0}
                                     background-color: #ffa399; color: #ffffff;
                             {else}
                                     background-color: #ffa399;
                             {/if};
                                     text-align:center">

                            <span class='sign'>
                                {$data[f].sign}{if $data[f].pic_count.status ==1 && $data[f].www_pic.pict1 != '' && $data[f].www_pic.pict2 != '' && $data[f].www_pic.pict3 != ''}?{/if}
                            </span>

                        </div>
                        </span>
                    {/if}
                    {if $cnt % 104 == 0 }<div style="clear:both; display:block"><br /></div>{/if}
                {/section}
            </span>
        </td>
    </tr>

    {include file="table_footer.tpl"}
</div>
<br style="clear: both;" /><br />
{include file="foot.tpl"}