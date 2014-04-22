/**
 * Created with JetBrains WebStorm.
 * User: leejustin
 * Date: 14-4-22
 * Time: 下午4:12
 * To change this template use File | Settings | File Templates.
 */

var fs = require('fs');
var formidable=require('formidable');

exports.upload = function(req, res){
    var myIP = req.host; //这里可能改成专用图片地址

    var fullHost =  req.get('Host');
    var port = null;
    if(fullHost != null && fullHost != undefined)
    {
        port = fullHost.split(':')[1];
    }
    if(port == null || port == undefined)
    {
        port = 80;
    }

    var uploadFolder = "uploads/";
    var baseUploadPath="./public/"+uploadFolder;

    var form=new formidable.IncomingForm();
    form.uploadDir='./public/tmp';

    if(!fs.existsSync(baseUploadPath))
    {
        fs.mkdirSync(baseUploadPath);
    }
    if(!fs.existsSync(form.uploadDir))
    {
        fs.mkdirSync(form.uploadDir);
    }

    form.parse(req,function(error,fields,files){
        if(!error){
            //console.log(fields);

            var urls = [];

            res.writeHead(200,{'Content-Type':'text/html'});//值得注意的是这里的response.writeHead()函数内容要写在form.parse()的callback中要不不会显示


            for(var key in files)
            {
                var tmp_name = (Date.parse(new Date())/1000);
                tmp_name = tmp_name+''+(Math.round(Math.random()*9999));
                var desUploadName=baseUploadPath+tmp_name;
                var file = files[key];
                fs.renameSync(file.path, desUploadName);
                var url = "";
                if(port.toString() == "80")
                {
                    url = "http://"+myIP+"/"+uploadFolder+tmp_name;
                }
                else
                {
                    url = "http://"+myIP+":"+port+"/"+uploadFolder+tmp_name;
                }

                urls[urls.length]=url;
                //res.write('received image:</br>');
                //res.write('<img src="/showuploadimage?name='+tmp_name+'" />');
                //os.rm(file.path);
            }

            res.write(urls.toString());

            res.end();

            res.send();
        }
    });
};