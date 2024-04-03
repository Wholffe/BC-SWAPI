namespace SWAPI.SWAPI;

codeunit 50101 "SWAPI Mng"
{
    procedure PingAPIConnection()
    var
        l_SWAPISetup: Record SWAPISetup;
        l_Client: HttpClient;
        l_Response: HttpResponseMessage;
    begin
        if not l_Client.Get(l_SWAPISetup.Endpoint, l_Response) then
            Error('Connection failed, %1', l_Response.HttpStatusCode);

        if not l_Response.IsSuccessStatusCode then
            Error('Status code result %1', l_Response.IsSuccessStatusCode);

        Message('Pong');
    end;
}
