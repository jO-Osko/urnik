<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/css/materialize.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Urnik OM FMF {{ '- ' if defined('naslov') else '' }}{{get('naslov', '')}} – poletni semester 2016/17</title>
    <style>
        body {
            /*background: #ddd;*/
        }
        .container, .navbar {
            min-width: 1024px;
        }
        #urnik.cel {
            position: absolute;
            left: 2.5%;
            top: 2.5%;
            width: 95%;
            height: 95%;
            background: white;
            min-width: 1024px;
            min-height: 600px;
        }
        #urnik {
            position: absolute;
            left: 0%;
            top: 0%;
            width: 80%;
            height: 100%;
            background: white;
        }
        #informacije {
            position: absolute;
            left: 82%;
            top: 0%;
            width: 18%;
            height: 100%;
            background: #fff;  
            overflow-y: scroll;
        }
        #dnevi {
            position: absolute;
            left: 3%;
            top: 0%;
            width: 97%;
            height: 100%;
            color: #333;
        }
        #ure {
            position: absolute;
            left: 0%;
            top: 5%;
            width: 100%;
            height: 95%;
            color: #333;
        }
        #srecanja {
            position: absolute;
            left: 3%;
            top: 5%;
            width: 97%;
            height: 95%;
        }
        .ura {
            position: absolute;
            border-bottom: solid 1px #eee;
            width: 100%;
        }
        .ura span {
            width: 3%;
            text-align: right;
            position: relative;
            display: block;
            bottom: -1.5em;
            padding-right: 0.25em;
        }
        .dan {
            position: absolute;
            text-align: center;
            top: 0;
            bottom: 0;
            border-left: solid 1px #eee;
            width: 20%;
        }
        .srecanje {
            background: #eee;
            border: solid 1pt white;
            position: absolute;
            padding: 2pt;
        }
        #informacije .srecanje {
            position: relative;
            height: 4em;
            margin-right: 1em;
        }
        .ucitelj, .ucilnica, .tip {
            color: #777;
            font-weight: normal;
        }
        .ucitelj, .ucilnica {
            font-size: 0.8em;
            position: absolute;
            bottom: 4pt;
            z-index: 10;
        }
        .ucilnica {
            right: 4pt;
        }
        .termin {
            position: absolute;
            /*opacity: 0.6;*/
        }
        .termin:hover {
            /*opacity: 0.8;*/
        }
        .termin button {
            border-style: none;
            width: 100%;
            height: 100%;
        }
        .predmet {
            font-size: 0.9em;
            font-weight: bold;
        }
        .termin.zaseden {
            background: rgba(255, 0, 0, 0.5);
        }
        .termin.prosto {
            background: rgba(0, 128, 0, 0.5);
        }
        .termin.proste_alternative {
            background: rgba(255, 165, 0, 0.5);
        }
        .termin.deloma {
            background: repeating-linear-gradient(
              -45deg,
              rgba(0, 128, 0, 0.5),
              rgba(0, 128, 0, 0.5) 5px,
              rgba(255, 0, 0, 0.5) 5px,
              rgba(255, 0, 0, 0.5) 10px
            );
        }
        .termin.proste_le_alternative {
            background: repeating-linear-gradient(
              -45deg,
              rgba(255, 165, 0, 0.5),
              rgba(255, 165, 0, 0.5) 5px,
              rgba(0, 128, 0, 0.5) 5px,
              rgba(0, 128, 0, 0.5) 10px
            );
        }
        .termin.deloma_proste_alternative {
            background: repeating-linear-gradient(
              -45deg,
              rgba(255, 165, 0, 0.5),
              rgba(255, 165, 0, 0.5) 5px,
              rgba(255, 0, 0, 0.5) 5px,
              rgba(255, 0, 0, 0.5) 10px
            );
        }
        .termin.vse_mogoce {
            background: repeating-linear-gradient(
              -45deg,
              rgba(255, 165, 0, 0.5),
              rgba(255, 165, 0, 0.5) 5px,
              rgba(255, 0, 0, 0.5) 5px,
              rgba(255, 0, 0, 0.5) 10px,
              rgba(0, 128, 0, 0.5) 15px,
              rgba(0, 128, 0, 0.5) 20px
            );
        }
        .urejanje {
            position: absolute;
            visibility: hidden;
            /*top: 100%;*/
            left: 100%;
            width: 100px;
            top: 0;
            background: white;
            /*height: 100%;*/
            z-index: 100;
        }
        .srecanje:hover {
/*            width: 20% !important;
            z-index: 100;
            background: #ddd;
*/        }
        .srecanje:hover .urejanje {
            visibility: visible;
        }
        .urejanje form {
            /*display: inline;*/
        }
        .urejanje button {
            border-style: none;
            display: inline;
            background: none;
            padding: 0;
            color: rgb(3, 155, 229);
        }
        .termin:hover .izbira_ucilnice {
            position: relative;
            visibility: visible;
            z-index: 1000000 !important;
        }
        .izbira_ucilnice {
            position: absolute;
            visibility: hidden;
        }
        .izbrana_ucilnica {
            float: left;
            width: 25%;
        }
        .izbrana_ucilnica.ustrezna.deloma_prosta button {
            background: repeating-linear-gradient(
              -45deg,
              rgba(0, 128, 0, 1),
              rgba(0, 128, 0, 1) 5px,
              rgba(255, 0, 0, 1) 5px,
              rgba(255, 0, 0, 1) 10px
            );
        }
        .izbrana_ucilnica.ustrezna.zasedena button {
            background: red;
        }
        .izbrana_ucilnica.ustrezna.prosta button {
            background: green;
        }
        .izbrana_ucilnica.morebiti.deloma_prosta button {
            background: repeating-linear-gradient(
              -45deg,
              orange,
              orange 5px,
              rgba(255, 0, 0, 1) 5px,
              rgba(255, 0, 0, 1) 10px
            );
        }
        .izbrana_ucilnica.morebiti.zasedena button {
            background: red;
        }
        .izbrana_ucilnica.morebiti.prosta button {
            background: orange;
        }
        nav {
            background-color: #85be4e;
        }
        @media print {
            a {
                color: black;
            }
            #domov {
                display: none;
            }
            .srecanje {
                background: #eee;
                border: solid 1.5px white;
            }
            .brand-logo {
                color: black !important;
            }
            .brand-logo i {
                display: none !important;
            }
            nav {
                background: white;
            }
        }
    </style>
</head>

<body>
    <div class="navbar-fixed">
  <nav>
    <div class="nav-wrapper">
      <span class="brand-logo center">
        <i class="large material-icons">schedule</i>
        {{get('naslov', 'Urnik')}}
      </span>
      <ul>
        <li id="domov"><a href="{{get('domov', '/')}}"><i class="material-icons left">home</i>Urnik OM FMF – poletni semester 2016/17</a></li>
      </ul>
    </div>
  </nav>

    </div>
    <div class="container" style="position: absolute; width: 100%; bottom: 0; top: 64px">
        {{!base}}
    </div>

    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.8/js/materialize.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('select').material_select();
        });
    </script>
</body>
</html>
