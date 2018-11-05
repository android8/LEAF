<!--{strip}-->
    <!--{if !isset($depth)}-->
    <!--{assign var='depth' value=0}-->
    <!--{/if}-->

    <!--{if $depth == 0}-->
    <!--{assign var='color' value='#e0e0e0'}-->
    <!--{else}-->
    <!--{assign var='color' value='white'}-->
    <!--{/if}-->

    <!--{if $form}-->
    <div class="printformblock">
    <!--{foreach from=$form item=indicator}-->
                <!--{if $indicator.format == null || $indicator.format == 'textarea'}-->
                <!--{assign var='colspan' value=2}-->
                <!--{else}-->
                <!--{assign var='colspan' value=1}-->
                <!--{/if}-->
        <!--{if $depth == 0}-->
      <div class="printmainblock">
        <div class="printmainlabel">
            <div class="printcounter" style="cursor: pointer"><span tabindex="0" aria-label="<!--{$indicator.indicatorID}-->"><!--{counter}--></span></div>
            <!--{if $indicator.required == 1 && $indicator.isEmpty == true}-->
                <div id="PHindicator_<!--{$indicator.indicatorID}-->_<!--{$indicator.series}-->" class="printheading_missing">
            <!--{else}-->
                <div id="PHindicator_<!--{$indicator.indicatorID}-->_<!--{$indicator.series}-->" class="printheading">
            <!--{/if}-->
            <div style="float: right">

            <span onkeydown="onKeyPressClick(event)" class="buttonNorm" tabindex="0" onclick="newQuestion(<!--{$indicator.indicatorID}-->);"><img src="../../libs/dynicons/?img=list-add.svg&amp;w=16" alt="Add Sub-question" title="Add Sub-question"/> Add Sub-question</span>

            </div>
            <span class="printsubheading" style="cursor: pointer" title="indicatorID: <!--{$indicator.indicatorID}-->" >
                <span onkeypress="keyPressGetForm(event, <!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)" tabindex="0" onclick="getForm(<!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)">
            <!--{if trim($indicator.name) != ''}-->
                <!--{$indicator.name|sanitizeRichtext|strip_tags}-->
            <!--{else}-->
                [ blank ]
            <!--{/if}-->
                </span>
            &nbsp;<img src="../../libs/dynicons/?img=accessories-text-editor.svg&amp;w=16" tabindex="0" onkeypress="keyPressGetForm(event, <!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)" onclick="getForm(<!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)" alt="Edit this field" title="Edit this field" style="cursor: pointer" />&nbsp;
            &nbsp;<img src="../../libs/dynicons/?img=emblem-readonly.svg&amp;w=16" tabindex="0" onkeypress="keyPressEditIndicatorPrivileges(event, <!--{$indicator.indicatorID}-->)" onclick="editIndicatorPrivileges(<!--{$indicator.indicatorID}-->);" alt="Edit indicator privileges" title="Edit indicator privileges" style="cursor: pointer" />&nbsp;
            </span>
        <!--{else}-->
      <div class="printsubblock" id="subIndicator_<!--{$indicator.indicatorID}-->_<!--{$indicator.series}-->">
        <div class="printsublabel">
            <!--{if $indicator.required == 1 && $indicator.isEmpty == true}-->
                <div class="printsubheading_missing">
            <!--{else}-->
                <div class="printsubheading">
            <!--{/if}-->
                <span class="printsubheading" style="cursor: pointer" title="indicatorID: <!--{$indicator.indicatorID}-->">
                    <span onkeypress="keyPressGetForm(event, <!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)" tabindex="0" onclick="getForm(<!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)">
                    <!--{if trim($indicator.name) != ''}-->
                        <!--{$indicator.name|sanitizeRichtext|strip_tags|indent:$depth:""}-->
                    <!--{else}-->
                        [ blank ]
                    <!--{/if}-->
                    </span>
                    &nbsp;<img src="../../libs/dynicons/?img=accessories-text-editor.svg&amp;w=16" tabindex="0" onkeypress="keyPressGetForm(event, <!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)" onclick="getForm(<!--{$indicator.indicatorID}-->, <!--{$indicator.series}-->)" alt="Edit this field" title="Edit this field" style="cursor: pointer" />&nbsp;
                    &nbsp;<img src="../../libs/dynicons/?img=emblem-readonly.svg&amp;w=16" tabindex="0" onkeypress="keyPressEditIndicatorPrivileges(event, <!--{$indicator.indicatorID}-->)" onclick="editIndicatorPrivileges(<!--{$indicator.indicatorID}-->);" alt="Edit indicator privileges" title="Edit indicator privileges" style="cursor: pointer" />&nbsp;
                <br /><br /><span tabindex="0" class="buttonNorm" onkeypress="onKeyPressClick(event)" onclick="newQuestion(<!--{$indicator.indicatorID}-->);"><img src="../../libs/dynicons/?img=list-add.svg&amp;w=16" alt="Add Sub-question" title="Add Sub-question"/> Add Sub-question</span>
                </span>
        <!--{/if}-->
            </div>
            <div tabindex="0" class="printResponse" id="xhrIndicator_<!--{$indicator.indicatorID}-->_<!--{$indicator.series}-->">

<!--{if $indicator.format == 'grid'}-->
    <!--{$indicator.format}-->
    </br></br>
    <table id="grid<!--{$indicator.indicatorID}-->_<!--{$indicator.series}-->" style="table-layout: fixed; width: 100%; max-width: 100%;border: 1px black;">
        <tbody style="display: flex; flex-wrap: wrap;">
        </tbody>
    </table>
    <script>
        printTablePreview(<!--{$indicator.options[0]}-->);

        function printTablePreview(gridParameters){
            var previewElement = '#grid<!--{$indicator.indicatorID}-->_<!--{$indicator.series}--> > tbody';

            for(var i = 0; i < gridParameters.length; i++){
                $(previewElement).append('<td style="flex: 1; order: '+ (i + 1) + '"><b>Column #' + (i + 1) + '</b></br>Title:' + gridParameters[i].name + '</br>Type:' + gridParameters[i].type + '</br></td>');
                if(gridParameters[i].type === 'dropdown'){
                    $(previewElement + '> td:eq(' + i + ')').append('Options:</br><li>' + gridParameters[i].options.toString().replace(/,/g, "</li><li>") + '</li></br>');
                }
            }
        }
    </script>
<!--{else}-->
    <!--{$indicator.format}-->
    <!--{if $indicator.options != ''}-->
    <ul>
        <!--{assign var="numOptions" value=0}-->
        <!--{foreach from=$indicator.options item=option}-->
        <li><!--{$option}--></li>

        <!--{if $numOptions > 5}-->
        <li>...</li>
        <!--{break}-->
        <!--{/if}-->
        <!--{assign var="numOptions" value=$numOptions+1}-->
        <!--{/foreach}-->
    </ul>
    <!--{/if}-->
<!--{/if}-->

                <!--{include file="print_subindicators_ajax.tpl"}-->

            </div><!-- end print reponse -->
        </div><!-- end print sublabel -->
        </div><!-- end print block -->
        <!--{if $depth == 0}-->
        <br style="clear: both" />
        <!--{/if}-->
    <!--{/foreach}-->
    </div>
    <br />
    <!--{/if}-->
<!--{/strip}-->
<script>
function keyPressGetForm(evt, indicatorID, series) {
    if(evt.keyCode == 13) {
        getForm(indicatorID, series);
    }
}

function onKeyPressClick(e){
    if((e.keyCode ? e.keyCode : e.which) === 13){
        $(e.target).trigger('click');
    }
}

function keyPressEditIndicatorPrivileges(evt, indicatorID) {
    if(evt.keyCode == 13) {
        editIndicatorPrivileges(<!--{$indicator.indicatorID}-->);
    }
}
</script>
