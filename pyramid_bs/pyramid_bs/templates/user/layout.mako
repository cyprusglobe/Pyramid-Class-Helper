<%inherit file="/layout.mako"/>

<div class="row">
    <div class="span12">
        %if request.route_url('user_list') in request.url:
            %if request.route_url('user_add') in request.url:
                <h2>New User</h2>
            %elif request.route_url('user_list') + '/edit' in request.url:
                <h2>Edit User</h2>
            %else:
                <h2>Users</h2>
            %endif
        %endif
        <hr />
    </div>
</div>

${next.body()}
