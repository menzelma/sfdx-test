/**
 * Created by mmenzel on 21.10.2019.
 */

public with sharing class AuthenticationHelper {

    public static void doCallout() {
        Http httpObject = new Http();
        HttpResponse tokenResponse = makeSessionTokenRequest(httpObject);
        String tokenResponseBody = tokenResponse.getBody();

        System.debug(tokenResponseBody);
        TokenResponseWrapper tokenResponseWrapper = (TokenResponseWrapper) JSON.deserialize(tokenResponseBody,TokenResponseWrapper.class);
        HttpResponse restResponse = callRestApi(tokenResponseWrapper,httpObject);
        System.debug(restResponse.getBody());
    }

    private static HttpResponse getAccountsWithOpportunities(TokenResponseWrapper tokenResponseWrapper, Http httpObject) {
        HttpRequest restRequest = new HttpRequest();
        restRequest.setHeader('Authorization','Bearer ' + tokenResponseWrapper.access_token);
        restRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        restRequest.setEndpoint(tokenResponseWrapper.instance_url+'/services/data/v47.0/query/?q=SELECT+name+from+Account');
        restRequest.setMethod('GET');
        return httpObject.send(restRequest);

    }

    private static HttpResponse callRestApi(TokenResponseWrapper tokenResponseWrapper, Http httpObject) {
        HttpRequest restRequest = new HttpRequest();

        restRequest.setHeader('Authorization','Bearer ' + tokenResponseWrapper.access_token);
        restRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        restRequest.setEndpoint(tokenResponseWrapper.instance_url+'/services/apexrest/Account');
        restRequest.setMethod('GET');
        return httpObject.send(restRequest);
    }

    public static HttpResponse makeSessionTokenRequest(Http httpObject) {
        HttpRequest tokenRequest = new HttpRequest();
        //tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9Ve.2wqUVx_YSsCX_DolHQHzBQYnfZrKvWHAfZGy_7PrKwMJUeT3g632sdLAet7S0YoMj8iMy48S8Rwhh&client_secret=CBB7AA4FB55824ABA643C7E7D896ECD7883EA256FC83EB51C81EE22A10DAE43D&username=menzel@mindsquare.de.dev&password=iNz2^i69Xez2QHNIb5JIn7MHwd9BN7CgcHEmw');
        tokenRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        tokenRequest.setMethod('POST');

        TokenRequestWrapper tokenRequestWrapper = new TokenRequestWrapper();
        tokenRequestWrapper.grant_type = 'password';
        tokenRequestWrapper.client_id = '3MVG9Ve.2wqUVx_YSsCX_DolHQHzBQYnfZrKvWHAfZGy_7PrKwMJUeT3g632sdLAet7S0YoMj8iMy48S8Rwhh';
        tokenRequestWrapper.client_secret = 'CBB7AA4FB55824ABA643C7E7D896ECD7883EA256FC83EB51C81EE22A10DAE43D';
        tokenRequestWrapper.username = 'menzel@mindsquare.de.lwc';
        tokenRequestWrapper.password = 'LmWyPH&%930M*vpdqRdeHX9Ru5bVqWD1aUmtVxVwA';


        System.debug(JSON.serialize(tokenRequestWrapper));
        //tokenRequest.setBody(JSON.serialize(tokenRequestWrapper));
        tokenRequest.setBody('grant_type=password&client_id=3MVG9Ve.2wqUVx_YSsCX_DolHQHzBQYnfZrKvWHAfZGy_7PrKwMJUeT3g632sdLAet7S0YoMj8iMy48S8Rwhh&client_secret=CBB7AA4FB55824ABA643C7E7D896ECD7883EA256FC83EB51C81EE22A10DAE43D&username=menzel@mindsquare.de.dev&password=iNz2^i69Xez2QHNIb5JIn7MHwd9BN7CgcHEmw');
        tokenRequest.setHeader('Content-Type','application/x-www-form-urlencoded');
        System.debug(httpObject.send(tokenRequest).getBody());
        return httpObject.send(tokenRequest);
    }

    private class TokenResponseWrapper {
        String access_token;
        String instance_url;
        String id;
        String token_type;
        String issued_at;
        String signature;
        String requestBody;

        public TokenResponseWrapper() {

        }
    }

    private class TokenRequestWrapper {
        String grant_type;
        String client_id;
        String client_secret;
        String username;
        String password;
    }
}