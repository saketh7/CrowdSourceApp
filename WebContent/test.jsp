<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
      <!-- This is to import all the required CSS files -->
      <meta charset="utf-8" content="utf-8"></meta>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
      <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
      <meta name="msapplication-TileColor" content="#2b5797"></meta>
      <meta name="msapplication-TileImage" content="/mstile-144x144.png"></meta>
      <title>Johann</title>
      <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"
            rel="stylesheet" type="text/css" media="screen"></link>
      <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
            rel="stylesheet"></link>
      <link href="./css/prettify-1.0.css" rel="stylesheet"></link>
      <link href="./css/base.css" rel="stylesheet"></link>
      <link href="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/build/css/bootstrap-datetimepicker.css"
            rel="stylesheet"></link>
            
      <script src="//www.google-analytics.com/analytics.js" async=""></script>
      <script src="//code.jquery.com/jquery-2.1.1.min.js"
              type="text/javascript"></script>
      <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"
              type="text/javascript"></script>
      <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
      <script src="//cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/e8bddc60e73c1ec2475f827be36e1957af72e2ea/src/js/bootstrap-datetimepicker.js"></script>
      
      <!-- This is the code for the DateTimePicker from BootStrap -->
      <div class="container">
        <div class="col-md-5">
          <div class="form-group">
            <label>first date</label><div class="input-group date" id="datetimepicker6">
              <input type="text" class="form-control"/>
               
              <span class="input-group-addon"> </span>
            </div>
          </div>
        </div>
        <div class="col-md-5">
          <div class="form-group">
            <div class="input-group date" id="datetimepicker7">
              <input type="text" class="form-control"/>
               
              <span class="input-group-addon"> </span>
            </div>
          </div>
        </div>
      </div>
      <script type="text/javascript">
        $(function () {
            $('#datetimepicker6').datetimepicker();
            $('#datetimepicker7').datetimepicker( {
                useCurrent : false//Important! See issue #1075
            });
            $("#datetimepicker6").on("dp.change", function (e) {
                $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
            });
            $("#datetimepicker7").on("dp.change", function (e) {
                $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
            });
        });
      </script>
    