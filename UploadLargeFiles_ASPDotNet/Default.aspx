<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UploadLargeFiles_ASPDotNet.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>Upload Large File in ASP .NET Framework</h2>
                    <div class="row" style="margin-top:30px;">
                        <div class="col-md-4">
                            <input type="file" name="postedFile" />
                        </div>
                        <div class="col-md-8">
                            <input type="button" id="btnUpload" value="Upload" />
                        </div>
                    </div>
                    <div class="row mt-3">
                        <progress id="fileProgress" style="display: none"></progress>
                        <span id="lblMessage" style="color: Green"></span>
                    </div>

                </div>
            </div>
        </div>
        <script type="text/javascript">
            $("body").on("click", "#btnUpload", function () {
                $.ajax({
                    url: 'Handler.ashx',
                    type: 'POST',
                    data: new FormData($('form')[0]),
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (file) {
                        $("#fileProgress").hide();
                        $("#lblMessage").html("<b>" + file.name + "</b> has been uploaded.");
                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        if (fileXhr.upload) {
                            $("progress").show();
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    $("#fileProgress").attr({
                                        value: e.loaded,
                                        max: e.total
                                    });
                                }
                            }, false);
                        }
                        return fileXhr;
                    }
                });
            });
        </script>
    </form>
</body>
</html>
