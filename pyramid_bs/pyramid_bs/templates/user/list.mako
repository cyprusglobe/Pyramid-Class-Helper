<%inherit file="layout.mako"/>
${self.confrim_delete("Are you sure you want to delete this user?")}

<div class="row">
    <div class="span12">
        ${len(users)} results
        <a href="${request.route_url('user_add')}" class="btn btn-mini pull-right" style="margin-bottom:2px;"><i class="icon-user"></i> Add user</a>
        <table class="table table-striped table-bordered table-condensed">
            <thead>
                <th>Login</th>
                <th>First_Name</th>
                <th>Last Name</th>
                <th>Phone</th>
                <th>Email</th>
            </thead>
            %for user in users:
                <tbody>
                    <tr>
                        <td>
                            <a href="${request.route_url('user_edit', user_id=user.id)}">${user.login}</a>
                            <a class="pull-right" data-target="#confirm-modal" data-toggle="modal" href="javascript:;"
                                onclick="$('#confirm-modal #delete').attr('href', '/user/delete/' + ${user.id});"><i class="icon-remove"></i></a>
                        </td>
                        <td>${user.first_name}</td>
                        <td>${user.last_name}</td>
                        <td>${user.phone}</td>
                        <td>${user.email}</td>
                    </tr>
                </tbody>
            %endfor
        </table>
    </div>
</div>
