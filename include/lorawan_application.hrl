%
% Copyright (c) 2016 Petr Gotthard <petr.gotthard@centrum.cz>
% All rights reserved.
% Distributed under the terms of the MIT License. See the LICENSE file.
%

-record(user, {name, pass}).
-record(gateway, {mac, netid, gpspos, gpsalt}).
-record(device, {deveui, app, appid, appeui, appkey, link, adr_flag_set, adr_set}).
-record(link, {devaddr, app, appid, nwkskey, appskey, fcntup, fcntdown,
    adr_flag_use, adr_flag_set, adr_use, adr_set}).
-record(pending, {devaddr, phypayload}).
-record(txframe, {frid, datetime, devaddr, txdata}).
-record(rxframe, {frid, mac, rssi, lsnr, freq, datr, codr, devaddr, fcnt}).

-record(rxdata, {port, data, last_lost=false, shall_reply=false}).
-record(txdata, {confirmed=false, port, data, pending=false}).

% end of file
