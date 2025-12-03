%{ if redirects != "[]" }
function redirect(fromHostnamePattern, fromPathPattern, toHostname, toPath, reqHostname, reqPath, reqQueryString) {
  toPath = toPath.replace(/\$${path}/g, reqPath.replace(/^\/|\/$/g, ''));
  fromHostnamePattern = fromHostnamePattern.replace(/\./g, '\\.');
  fromHostnamePattern = fromHostnamePattern.replace(/\-/g, '\\-');
  fromPathPattern = fromPathPattern.replace(/\./g, '\\.');
  fromPathPattern = fromPathPattern.replace(/\-/g, '\\-');
  var pathRegex = new RegExp("^" + fromPathPattern.replace(/\*/g, '.*') + "$",'g');
  var hostnameRegex = new RegExp("^" + fromHostnamePattern.replace(/\*/g, '.*') + "$",'g');
  var queryString = "";
  if (Object.keys(reqQueryString).length > 0) {
    queryString += "?" + Object.keys(reqQueryString).map(key => {
      return `$${key}=$${encodeURIComponent(reqQueryString[key]["value"])}`;
    }).join('&');
  }
  if (reqPath.match(pathRegex).length > 0) {
    var redirectUrl = "https://" + toHostname + toPath + queryString;
    var resp = {
      statusCode: 301,
      statusDescription: 'Moved Permanently',
      headers: {
        "location": {
          "value": redirectUrl
        }
      }
    }
    if (reqHostname.match(hostnameRegex).length > 0) {
      return resp;
    }
  }
}
%{ endif }
function handler(event) {
  // default variables
  var req = event.request;
  var clientIp = event.viewer.ip;
  %{ if redirects != "[]" }
  // redirects
  var redirects = ${redirects};
  for (var i = 0; i < redirects.length; i++) {
    var resp = redirect(redirects[i].from_hostname_pattern, redirects[i].from_path_pattern, redirects[i].to_hostname, redirects[i].to_path, req.headers['host']['value'], req.uri, req.querystring);
    if (resp) {
      return resp;
    }
  }
  %{ endif }
  // return request
  return req;
}
