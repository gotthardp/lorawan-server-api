%
% Copyright (c) 2016-2017 Petr Gotthard <petr.gotthard@centrum.cz>
% All rights reserved.
% Distributed under the terms of the MIT License. See the LICENSE file.
%

-record(user, {name, pass}).
-record(gateway, {mac, tx_rfch, netid, gpspos, gpsalt}).
-record(device, {deveui, region, app, appid, appeui, appkey, link, can_join, last_join,
    fcnt_check, adr_flag_set, adr_set}).
-record(link, {devaddr, region, app, appid, nwkskey, appskey, fcntup, fcntdown, last_rx,
    fcnt_check, adr_flag_use, adr_flag_set, adr_use, adr_set, devstat_time, devstat_fcnt, devstat}).
-record(pending, {devaddr, phypayload}).
-record(txframe, {frid, datetime, devaddr, txdata}).
-record(rxframe, {frid, mac, rssi, lsnr, freq, datr, codr, devaddr, region, fcnt, devstat}).

-record(rxdata, {port, data, last_lost=false, shall_reply=false}).
-record(txdata, {confirmed=false, port, data, pending=false}).

% end of file
