<%inherit file="layout.mako"/>
<%namespace name="form_utils" file="/form_utils.mako"/>

<form id="user_form" action="" method="POST" class="form-horizontal">
    <div class="row">
        <input type="hidden" name="_csrf" value="${request.csrf_token}">
        <div class="span6">
            ${form_utils.field(form, 'login', class_="span4")}
            ${form_utils.field(form, 'password', class_="span4", autocomplete="off")}
            ${form_utils.field(form, 'confirm', class_="span4", autocomplete="off")}

            <br />

            ${form_utils.field(form, 'first_name', class_="span4")}
            ${form_utils.field(form, 'last_name', class_="span4")}
            ${form_utils.field(form, 'phone', class_="span4")}
            ${form_utils.field(form, 'email', class_="span4")}
        </div>
        <div class="span6">
            <button type="submit" class="btn">Submit</button>
        </div>
    </div>
</form>

${form_utils.ajax_form('user_form')}
