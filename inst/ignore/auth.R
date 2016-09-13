# library(httr)
# 
# endpts <- oauth_endpoint(authorize = "https://orcid.org/oauth/authorize", 
#                          access = "https://pub.orcid.org/oauth/token")
# 
# myapp <- oauth_app("rorcid",
#                    key = "APP-7E02XXWNQBFNMG1B",
#                    secret = "152526b1-c2e8-47d0-9cb0-4f7849310c8b")
# 
# tok <- oauth2.0_token(endpts, myapp, scope = "/authenticate")
# 
# # 4. Use API
# ortoken <- config(token = tok)
# req <- GET("https://pub.orcid.org/v1.2/0000-0003-1444-9135/orcid-bio", 
#            add_headers(Authorization = paste0('Bearer ', tok$credentials$access_token)), 
#            accept('application/orcid+json'),
#            verbose())
# stop_for_status(req)
# content(req)
# 
# # OR:
# req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
# stop_for_status(req)
# content(req)
