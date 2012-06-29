<%def name="ajax_form(form_id)">
    <script type="text/javascript" charset="utf-8">
        function validationTip(field, data) {
            if (!data || !data.message) {
                return;
            }

            field.qtip({
                content: data.message,
                position: {
                    my: 'center left',
                    at: 'center right'
                },
                style: {
                    classes: data.error === false ? 'ui-tooltip-green' : 'ui-tooltip-red small',
                    def:false,
                    width: 220
                },
                show: true,
                hide: 'blur'
            });
            field.qtip('show');
        }

        function validateForm() {
            var form = $(this)
            $.ajax(
            {
                type: "GET",
                url: form.attr("action"),
                cache: false,
                dataType: "json",
                data: form.serialize(),
                form: form,
                success: function(data) {
                    if (data.validated === true) {
                        form.unbind("submit", validateForm);
                        form.submit();
                    } else {
                        for (var name in data.fields) {
                            validationTip($('#' + name), data.fields[name]);
                        }
                    }
                },
                error: function(xhr, status, error) {
                    this.set('content.text', '(' + status + ', ' + error + ')');
                },
                beforeSend: function() {
                    $('.qtip').qtip('hide').qtip('disable');
                    return true;
                }
            });
            return false;
        }

        $(document).ready(function()
        {
            var form = $("#${form_id}");
            form.bind("submit", validateForm);
        });
    </script>
</%def>

<%def name="field(form, field, bottom=7, **kwargs)">
    %if form.__getattribute__(field).errors:
        <div class="control-group error" style="margin-bottom:${bottom}px;">
    %else:
        <div class="control-group" style="margin-bottom:${bottom}px;">
    %endif

        %if 'label' in kwargs:
            <label class="control-label" style="margin-bottom:${bottom}px;" for="${field}">${kwargs.pop('label')}:</label>
        %else:
            <label class="control-label" style="margin-bottom:${bottom}px;" for="${field}">${form.__getattribute__(field).label}</label>
        %endif
        <div class="controls">
            ${form.__getattribute__(field)(**kwargs)}
            %if form.__getattribute__(field).errors:
                <span class="help-inline">${'<br/>'.join(form.__getattribute__(field).errors)}</span>
            %endif
        </div>
    </div>
</%def>

<%def name="check_field(form, check, field, bottom=5, **kwargs)">
    %if form.__getattribute__(field).errors:
        <div class="control-group error" style="margin-bottom:${bottom}px;">
    %else:
        <div class="control-group" style="margin-bottom:${bottom}px;">
    %endif

        <label class="control-label" style="margin-bottom:${bottom}px;" for="${check}">${form.__getattribute__(check).label}</label>
        <div class="controls">
            <label class="checkbox" style="margin-bottom:${bottom}px;">
                ${form.__getattribute__(field)(class_="span1", **kwargs)}
                ${form.__getattribute__(check)(**kwargs)}
            </label>
            <span class="help-inline">${'<br/>'.join(form.__getattribute__(field).errors)}</span>
        </div>
    </div>
</%def>
