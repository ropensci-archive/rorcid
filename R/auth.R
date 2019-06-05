#' ORCID authorization
#'
#' @export
#' @aliases rorcid-auth
#' @param scope (character) one or more scopes. default: `"/authenticate"`
#' @param reauth (logical) Force re-authorization?
#' @param redirect_uri (character) a redirect URI. optional
#'
#' @return a character string with the access token prefixed with "Bearer "
#'
#' @details
#' There are two ways to authorise with \pkg{rorcid}:
#'
#' - Use a token as a result of a OAuth authentication process. The token
#' is a alphanumeric UUID, e.g. `dc0a6b6b-b4d4-4276-bc89-78c1e9ede56e`. You
#' can get this token by running `orcid_auth()`, then storing that key
#' (the uuid alone, not the "Bearer " part) either as en environment
#' variable in your `.Renviron` file in your home directory (with the name
#' `ORCID_TOKEN`), or as an R option in your `.Rprofile` file (with the name
#' `orcid_token`). See [Startup] for more information.
#' Either an environment variable or R option work. If we don't find
#' either we do the next option.
#' - Interactively login with OAuth. This doesn't require any input on
#' your part. We use a client id and client secret key to ping ORCID.org;
#' at which point you log in with your username/password; then we get back
#' a token (same as the above option). We don't know your username or
#' password, only the token that we get back. We cache that token locally
#' in a hidden file in whatever working directory you're in. If you delete
#' that file, or run the code from a new working directory, then we
#' re-authorize.
#'
#' We recommend the former option. That is, get a token and store it as an
#' environment variable.
#'
#' If both options above fail, we proceed without using authentication.
#' ORCID does not require authentication at this point, but may in the future -
#' this prepares you for when that happens :)
#'
#' @section ORCID OAuth Scopes:
#' See <https://members.orcid.org/api/orcid-scopes> for more
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
#' #orcid_auth(scope = "/read-public", reauth = TRUE)
#' }
orcid_auth <- function(scope = "/authenticate", reauth = FALSE,
  redirect_uri = getOption("rorcid.redirect_uri")) {

  if (exists("auth_config", envir = cache) && !reauth) {
    return(cache$auth_config)
  }
  key <- check_key()
  if (!is.null(key)) {
    auth_config <- paste0("Bearer ", key)
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
