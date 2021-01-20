two_legged_oauth <- function(client_id, client_secret) {
  headers <- list(Accept = "application/json",
    `Content-Type` = "application/x-www-form-urlencoded")
  body <- list(grant_type = "client_credentials", scope = "/read-public",
    client_id = client_id, client_secret = client_secret)
  con <- crul::HttpClient$new("https://orcid.org", headers = headers)
  res <- con$post(path="oauth/token", body = body, encode = "form")
  res$raise_for_status()
  tok <- jsonlite::fromJSON(res$parse("UTF-8"))$access_token
  paste0("Bearer ", tok)
}

#' ORCID authorization
#'
#' @export
#' @aliases rorcid-auth
#' @param scope (character) one or more scopes. default: `"/authenticate"`.
#' see "ORCID OAuth Scopes" section below for other scope options
#' @param reauth (logical) Force re-authorization? default: `FALSE`
#' @param redirect_uri (character) a redirect URI. optional. set by passing
#' to this parameter or using the R option `rorcid.redirect_uri`
#' @param client_id (character) a client id. optional
#' @param client_secret (character) a client secret. optional
#'
#' @return a character string with the access token prefixed with "Bearer "
#' 
#' @note This function is used within \pkg{rorcid} to get/do authentication.
#'
#' @details
#' There are three ways to authorise with \pkg{rorcid}:
#'
#' - Interactively login with OAuth. This doesn't require any input on
#' your part. We use a client id and client secret key to ping ORCID.org;
#' at which point you log in with your username/password; then we get back
#' a token (same as the above option). We don't know your username or
#' password, only the token that we get back. We cache that token locally
#' in a hidden file in whatever working directory you're in. If you delete
#' that file, or run the code from a new working directory, then we
#' re-authorize.
#' - Use a `client_id` and `client_secret` to do 2-legged OAuth. 
#' ORCID docs at https://members.orcid.org/api/oauth/2legged-oauth and
#' https://members.orcid.org/api/post-oauthtoken-reading-public-data
#' This requires you to register a "client application". See 
#' https://orcid.org/content/register-client-application-2 for instructions
#' - Use a token as a result of either of the two above approaches. The token
#' is a alphanumeric UUID, e.g. `dc0a6b6b-b4d4-4276-bc89-78c1e9ede56e`. You
#' can get this token by running `orcid_auth()`, then storing that key
#' (the uuid alone, not the "Bearer " part) either as en environment
#' variable in your `.Renviron` file in your home directory (with the name
#' `ORCID_TOKEN`), or as an R option in your `.Rprofile` file (with the name
#' `orcid_token`). See [Startup] for more information.
#' Either an environment variable or R option work. If we don't find
#' either we do the next option.
#'
#' We recommend the 3rd option if possible, specifically, storing the token
#' as an environment variable permanently.
#'
#' If authentication fails, you can still use \pkg{rorcid}. ORCID does not require
#' authentication at this point, but may in the future - this prepares you
#' for when that happens :)
#'
#' @section ORCID OAuth Scopes:
#' https://info.orcid.org/faq/what-is-an-oauth-scope-and-which-scopes-does-orcid-support/
#'
#' @section Computing environments without browsers:
#' One pitfall is when you are using rorcid on a server, and you're ssh'ed
#' in, so that there's no way to open a browser to do the OAuth browser
#' flow. Similarly for any other situation in which a browser can not be
#' opened. In this case, run `orcid_auth()` on another machine in which you do
#' have the ability to open a browser, then collect the info that's ouptput
#' from `orcid_auth()` and store it as an environment variable (see above).
#'
#' @examples \dontrun{
#' x <- orcid_auth()
#' orcid_auth(reauth = TRUE)
#' # orcid_auth(scope = "/read-public", reauth = TRUE)
#' 
#' # supply client_id AND client_secret to avoid 3 legged, interactive OAuth
#' # orcid_auth(client_id = "---", client_secret = "---")
#' }
orcid_auth <- function(scope = "/authenticate", reauth = FALSE,
  redirect_uri = getOption("rorcid.redirect_uri"),
  client_id = NULL, client_secret = NULL) {

  if (exists("auth_config", envir = cache) && !reauth) {
    return(cache$auth_config)
  }
  key <- check_key()
  if (!is.null(key)) {
    auth_config <- paste0("Bearer ", key)
  } else if (!is.null(client_id) && !is.null(client_secret)) {
    auth_config <- two_legged_oauth(client_id, client_secret)
  } else if (!interactive()) {
    stop("In non-interactive environments, please set ORCID_TOKEN env to a ORCID",
         " access token, see ?orcid_auth for details",
         call. = FALSE)
  } else  {
    message("no ORCID token found; attempting OAuth authentication\n")
    # httpuv required to do oauth out of bounds (OOB) flow
    chkpkg("httpuv")

    # use user supplied redirect_uri if supplied
    if (!is.null(redirect_uri)) rorcid_app$redirect_uri <- redirect_uri

    # do oauth dance
    endpt <- oauth_endpoint(
      authorize = "https://orcid.org/oauth/authorize",
      access = "https://orcid.org/oauth/token")
    tok <- oauth2.0_token(
      endpt,
      rorcid_app,
      scope = scope,
      cache = !reauth)

    # put token into a string with Bearer prefix
    auth_config <- paste0("Bearer ",
      tok$credentials$access_token)
  }

  cache$auth_config <- auth_config
  auth_config
}

cache <- new.env(parent = emptyenv())

rorcid_app <- httr::oauth_app(
  appname = "rorcid",
  key = "APP-7E02XXWNQBFNMG1B",
  secret = "152526b1-c2e8-47d0-9cb0-4f7849310c8b"
)
