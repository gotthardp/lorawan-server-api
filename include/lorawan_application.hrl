%
% Copyright (c) 2016-2017 Petr Gotthard <petr.gotthard@centrum.cz>
% All rights reserved.
% Distributed under the terms of the MIT License. See the LICENSE file.
%

-type eui() :: <<_:64>>.
-type seckey() :: <<_:128>>.
-type devaddr() :: <<_:32>>.
-type frid() :: <<_:64>>.
-type intervals() :: [{integer(), integer()}].
-type adr_config() :: {integer(), integer(), intervals()}.
-type rxwin_config() :: {
    'undefined' | integer(),
    'undefined' | integer(),
    'undefined' | number()}.

-record(rxq, {
    freq :: number(),
    datr :: binary(),
    codr :: binary(),
    time :: calendar:datetime(),
    tmst :: integer(),
    srvtmst :: integer(), % when received by the server
    rssi :: number(),
    lsnr :: number()}).

-record(txq, {
    region :: binary(),
    freq :: number(),
    datr :: binary(),
    codr :: binary(),
    tmst :: 'undefined' | integer(),
    time :: 'undefined' | 'immediately' | calendar:datetime(),
    powe :: 'undefined' | integer()}).

-record(user, {
    name :: nonempty_string(),
    pass :: string(),
    roles :: [string()]}).

-record(gateway, {
    mac :: binary(),
    netid :: binary(), % network id
    subid :: 'undefined' | bitstring(), % sub-network id
    tx_rfch :: integer(), % rf chain for downlinks
    tx_powe :: 'undefined' | integer(),
    ant_gain :: 'undefined' | integer(),
    group :: any(),
    desc :: 'undefined' | string(),
    gpspos :: {number(), number()}, % {latitude, longitude}
    gpsalt :: 'undefined' | number(), % altitude
    last_rx :: 'undefined' | calendar:datetime(),
    dwell :: [{calendar:datetime(), {number(), number(), number()}}], % {frequency, duration, hoursum}
    delays :: [{calendar:datetime(), integer()}]}).

-record(multicast_group, {
    devaddr :: devaddr(), % multicast address
    region :: binary(),
    app :: binary(),
    appid :: any(), % application route
    nwkskey :: seckey(),
    appskey :: seckey(),
    mac :: binary(),
    fcntdown :: integer()}). % last downlink fcnt

-record(device, {
    deveui :: eui(),
    region :: binary(),
    app :: binary(),
    appid :: any(), % application route
    appargs :: any(), % application arguments
    appeui :: eui(),
    appkey :: seckey(),
    link :: devaddr(),
    can_join :: boolean(),
    last_join :: calendar:datetime(),
    fcnt_check :: integer(),
    txwin :: integer(),
    adr_flag_set :: 0..2, % server requests (off, on, manual)
    adr_set :: adr_config(), % requested after join
    rxwin_set :: rxwin_config(), % requested
    request_devstat :: boolean()}).

-record(link, {
    devaddr :: devaddr(),
    region :: binary(),
    app :: binary(),
    appid :: any(), % application route
    appargs :: any(), % application arguments
    nwkskey :: seckey(),
    appskey :: seckey(),
    fcntup :: integer(), % last uplink fcnt
    fcntdown :: integer(), % last downlink fcnt
    fcnt_check :: integer(),
    txwin :: integer(),
    first_reset :: calendar:datetime(),
    last_reset :: calendar:datetime(),
    reset_count :: integer(), % number of resets/joins
    last_rx :: 'undefined' | calendar:datetime(),
    last_mac :: binary(), % gateway used
    last_rxq :: #rxq{},
    adr_flag_use :: 0..1, % device supports (off, on)
    adr_flag_set :: 0..2, % server requests (off, on, manual)
    adr_use :: adr_config(), % used
    adr_set :: adr_config(), % requested
    rxwin_use :: rxwin_config(), % used
    rxwin_set :: rxwin_config(), % requested
    last_qs :: [{integer(), integer()}], % list of {RSSI, SNR} tuples
    request_devstat :: boolean(),
    devstat_time :: 'undefined' | calendar:datetime(),
    devstat_fcnt :: 'undefined' | integer(),
    devstat :: [{calendar:datetime(), integer(), integer()}]}). % {time, battery, margin}

-record(rxdata, {
    fcnt :: integer(),
    port :: integer(),
    data :: binary(),
    last_lost=false :: boolean(),
    shall_reply=false :: boolean()}).

-record(txdata, {
    confirmed=false :: boolean(),
    port :: 'undefined' | integer(),
    data :: 'undefined' | binary(),
    pending :: 'undefined' | boolean()}).

-record(pending, {
    devaddr :: devaddr(),
    confirmed :: boolean(),
    phypayload :: binary()}).

-record(txframe, {
    frid :: frid(), % unique identifier
    datetime :: calendar:datetime(),
    devaddr :: devaddr(),
    txdata :: #txdata{}}).

-record(rxframe, {
    frid :: frid(), % unique identifier
    mac :: binary(), % gateway used
    rxq :: #rxq{},
    average_qs :: 'undefined' | {number(), number()}, % average RSSI and SNR
    app :: binary(),
    appid :: any(), % application route
    region :: binary(),
    devaddr :: devaddr(),
    powe:: integer(),
    fcnt :: integer(),
    confirm :: boolean(),
    port :: integer(),
    data :: binary(),
    datetime :: calendar:datetime()}).

-record(event, {
    evid :: binary(),
    severity :: atom(),
    first_rx :: calendar:datetime(),
    last_rx :: calendar:datetime(),
    count :: integer(),
    entity :: atom(),
    eid :: binary(),
    text :: any()}).

% end of file
