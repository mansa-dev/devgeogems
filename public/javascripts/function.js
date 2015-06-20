var previous_state= Array();


function init_search_map(markers){



    var single_marker = markers.shift(),
         marker = Array(),
        i=0;
    for(i=0;i<30;i++)
    {
        if(markers.length > 0)
        {
            marker.push(single_marker);
            single_marker = markers.shift()
        }
        else
        {
            marker.push(single_marker);
            i=31;
        }

    }

    $("#map_canvas").gmap3({
        map:{
            options:{center: true,zoom:6,  maxZoom: 13},

            events:{
                dragend: function(map){
                    load_all_current_state_markers(map)
                },
                zoom_changed:function(map){
                    load_all_current_state_markers(map)
                }
            },
            callback:function(map)
            {
                $("#loader").show();
            }
        },
        marker:{
            values:marker,
            callback:function(results){
                $("#loader").hide();
                add_dynamic_marker(markers);

            },
            options:{draggable: false},
            events:{
                mouseover: function(marker, event, context){
                    hover_event_handler(jQuery(this),marker, context)
                },
                click:function(marker, event, context){
                    click_event_handler(context)
                }

            }

        }

    },"autofit");
}

function hover_event_handler($this,marker, context)
{
    var map =$this.gmap3("get"),
        infowindow = $this.gmap3({get:{name:"infowindow"}});
    if (infowindow){
        infowindow.open(map, marker);
        infowindow.setContent(context.data.city);
    } else {
        $this.gmap3({
            infowindow:{anchor:marker,options:{content: context.data.city}}
        });
    }
}

function load_all_current_state_markers(map)
{
    var bounds=$('#map_canvas').gmap3('get').getBounds(),
        pos = bounds.getCenter();

    if(map.getZoom()>=6)
    {
        $(this).gmap3({
            getaddress: {
                latLng: pos,
                callback: function (results) {
                    if(results[0]){
                        var ary = results[0].formatted_address.split(','),
                            state = ary[ary.length-2].split(' ')[1];

                        if($.inArray( state, previous_state )== -1)
                        {
                            previous_state.push(state);

                            $.post("/ajaxsearch",{city:false,state:state},function(data){
                                var mkrs = $.parseJSON(data);
                                add_dynamic_marker(mkrs);

                            });
                        }

                    }
                    return false;
                }
            }
        });
    }
}


function click_event_handler(context)
{
    var ele = $("#trivia").find('.trivia_content');
    ele.html("Loading...")
    $.post("/ajaxsearch",{city:context.data.city,state:context.data.state},function(d){
        ele.html(d)
    });
}

var add_dynamic_marker = function (mkrs) {

    var single_marker = mkrs.shift(),
        length = mkrs.length;

    if(length>0) {

        var marker = Array();
        marker.push(single_marker);

        $("#map_canvas").gmap3({
            marker:{
                //latLng:results[0].geometry.location,
                values: marker,
                callback:function(results){
                    $("#loader").hide();
                    add_dynamic_marker(mkrs);
                },
                options: {draggable: false},
                events:{
                    mouseover: function(marker, event, context){
                        hover_event_handler($(this),marker, context)
                    },
                    click:function(marker, event, context){
                        click_event_handler(context)
                    }

                }
            }
        });
    }
}

$(document).mouseup(function (e)
{
    var container = $("#city_result");

    if (!container.is(e.target) // if the target of the click isn't the container...
        && container.has(e.target).length === 0) // ... nor a descendant of the container
    {
        container.hide();
    }
});


var delay = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();


$(document).on('keyup','#city',function(){
    var city = $(this).val(),
        ele = $("#city_result");

    delay(function(){
        city_text_search(city,ele);
    }, 500 );

});

function city_text_search(city,ele)
{
    if( city!='')
    {
        ele.html("Searching...");
        ele.show();
        $.post('/citysearch',{city:city},function(d){
            requested = true;
            ele.html(d);
            ele.show();
        });
    }
}

$(document).on('click','#city_result li',function(){
    var city = $(this).text(),
        state = $(this).data('value'),
        city_box = $("#city"),
        state_box = $("#state"),
        ele = $("#city_result");;

    city = city.split(',')[0];

    city_box.val(city);
    state_box.val(state);

    ele.hide();

});