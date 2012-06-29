<!DOCTYPE html PUBLIC "-//W4C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html leng="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Pyramid BS</title>
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
        <meta name="keywords" content="pyramid_bs" />
        <meta name="description" content="pyramid_bs" />
        <link rel="shortcut icon" href="${request.static_url('pyramid_bs:static/favicon.ico')}" />
        <link rel="stylesheet" href="${request.static_url('pyramid_bs:static/bootstrap/css/bootstrap.min.css')}" type="text/css" charset="utf-8" />
        <link rel="stylesheet" href="${request.static_url('pyramid_bs:static/js/jquery/ui/css/ui-lightness/jquery-ui-1.8.21.custom.css')}" type="text/css" charset="utf-8" />
        <link rel="stylesheet" href="${request.static_url('pyramid_bs:static/js/jquery/timepicker/jquery-ui-timepicker-addon.css')}" type="text/css" charset="utf-8" />
        <link rel="stylesheet" href="${request.static_url('pyramid_bs:static/js/jquery/qtip2/jquery.qtip.min.css')}" type="text/css" charset="utf-8" />
        <link rel="stylesheet" href="${request.static_url('pyramid_bs:static/style.css')}" type="text/css" charset="utf-8" />

        <!-- try: load googleapis jquery -->
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

        <!-- fallback: load local jquery -->
        <script type="text/javascript">
            if (typeof jQuery == 'undefined'){
                document.write(unescape("%3Cscript type='text/javascript' src='${request.static_url('pyramid_bs:static/js/jquery-1.7.2.min.js')}' %3E%3C/script%3E"));
            }
        </script>

        <!-- jquery-ui -->
        <script type="text/javascript" src="${request.static_url('pyramid_bs:static/js/jquery/ui/js/jquery-ui-1.8.21.custom.min.js')}"></script>

        <!-- load bootstrap js library -->
        <script type="text/javascript" src="${request.static_url('pyramid_bs:static/bootstrap/js/bootstrap.min.js')}"></script>

        <!-- load qtip2 js library -->
        <script type="text/javascript" src="${request.static_url('pyramid_bs:static/js/jquery/qtip2/jquery.qtip.min.js')}"></script>

        <!-- load timepicker js library -->
        <script type="text/javascript" src="${request.static_url('pyramid_bs:static/js/jquery/timepicker/jquery-ui-timepicker-addon.js')}"></script>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>
    <body style="margin-top:10px;">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div class="row">
                        <div class="span6">
                            <br />
                            ${self.flash_messages()}
                        </div>
                        <div class="span6">
                            <div style="margin-bottom:15px;" class="pull-right btn-toolbar">
                                %if request.userid:
                                    <div class="btn-group">
                                        %if request.route_url('user_list') in request.url:
                                            <a class="btn btn-success" href="${request.route_url('user_list')}"><i class="icon-star icon-white"></i> Users</a>
                                        %else:
                                            <a class="btn" href="${request.route_url('user_list')}"><i class="icon-star"></i> Users</a>
                                        %endif
                                    </div>

                                    <div class="btn-group">
                                        <a class="btn btn-danger" href="${request.route_url('logout')}"><i class="icon-remove"></i> Logout</a>
                                    </div
                                %else:
                                    <div class="btn-group">
                                        <a class="btn btn-success pull-right" href="#loginModal" data-toggle="modal">Sign in <b class="caret"></b></a>
                                    </div>
                                %endif
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            ${next.body()}
        </div>

        <div class="container">
            <div class="row">
                <div class="span12">
                    <hr />
                    <p>&copy; 2012</p>
                </div>
            </div>
        </div>
    </body>
</html>

<%def name="flash_messages()">
    %if request.error_messages:
        <div class="alert alert-error" data-alert="alert">
            <a class="close" data-dismiss="alert" href="#">&times;</a>
            %if len(request.error_messages) > 1:
                <ul>
                    %for msg in request.error_messages:
                        <li>${msg | n}</li>
                    %endfor
                </ul>
            %else:
                <h8 class="alert-heading">${request.error_messages[0] | n}</h8>
            %endif
        </div>
    %else:
        %if request.flash_messages:
            <div class="alert alert-success" data-alert="alert">
                <a class="close" data-dismiss="alert" href="#">&times;</a>
                %if len(request.flash_messages) > 1:
                    <ul>
                        %for msg in request.flash_messages:
                            <li>${msg | n}</li>
                        %endfor
                    </ul>
                %else:
                    <h8 class="alert-heading">${request.flash_messages[0] | n}</h8>
                %endif
            </div>
        %endif
    %endif
</%def>

<%def name="confrim_delete(question)">
    <div id="confirm-modal" class="modal hide fade">
        <div class="modal-header">
            <a href="#" class="close">&times;</a>
            <h3>Confirm Delete</h3>
        </div>

        <div class="modal-body">
            <p>${question | n}</p>
        </div>

        <div class="modal-footer">
            <a id="delete" href="" class="btn btn-danger"><i class="icon-remove"></i> Delete</a>
            <a href="javascript:;" class="btn"
                onclick="$('#confirm-modal').modal('hide')"><i class="icon-ban-circle"></i> Cancel</a>
        </div>
    </div>
</%def>
