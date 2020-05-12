fct.testthat.runability.common.out.of.the.box.no.hold <- function(method, clv.data.noholdout, clv.newdata.withhold, clv.newdata.nohold, param.names) {
  test_that("Works out-of-the box, without additional params (no holdout)", {
    l.args.no.hold <- list(clv.data = clv.data.noholdout, verbose=FALSE)

    expect_silent(p.no.hold <- do.call(what = method, args = l.args.no.hold))

    fct.helper.fitted.all.s3(clv.fitted = p.no.hold,  full.names = param.names,
                             clv.newdata.nohold = clv.newdata.nohold, clv.newdata.withhold = clv.newdata.withhold)
  })
}

fct.testthat.runability.common.out.of.the.box.with.hold <- function(method, clv.data.withholdout, clv.newdata.withhold, clv.newdata.nohold, param.names) {
  test_that("Works out-of-the box, without additional params (with holdout)", {
    skip_on_cran()
    l.args.hold <- list(clv.data = clv.data.withholdout, verbose=FALSE)

    expect_silent(p.hold    <- do.call(what = method, args = l.args.hold))

    fct.helper.fitted.all.s3(clv.fitted = p.hold,  full.names = param.names,
                             clv.newdata.nohold = clv.newdata.nohold, clv.newdata.withhold = clv.newdata.withhold)
  })
}

fct.testthat.runability.common.custom.model.start.params <- function(method, start.params.model, clv.data.noholdout, clv.data.withholdout){
  test_that("Works with custom model.start.params", {
    skip_on_cran()
    l.args.no.hold <- list(clv.data = clv.data.noholdout,   start.params.model = start.params.model, verbose=FALSE)
    l.args.hold <- list(clv.data = clv.data.withholdout, start.params.model = start.params.model, verbose=FALSE)

    expect_silent(do.call(what = method, args = l.args.no.hold))
    expect_silent(do.call(what = method, args = l.args.hold))
  })
}

fct.testthat.runability.common.all.optimization.methods <- function(method, clv.data.noholdout, expected.message){
  test_that("Works for all optimx optimization methods", {
    skip_on_cran()
    l.args <- list(clv.data = clv.data.noholdout, optimx.args = list(control=list(all.methods=TRUE)), verbose=FALSE)
    expect_warning(do.call(what = method, args = l.args),
                   regexp = expected.message, all=TRUE)
  })
}

fct.testthat.runability.common.multiple.optimization.methods <- function(method, clv.data.noholdout, clv.newdata.nohold, clv.newdata.withhold, param.names){
  test_that("Works fully with multiple optimization methods", {
    skip_on_cran()
    l.args <- list(clv.data = clv.data.noholdout, optimx.args = list(method = c("BFGS", "L-BFGS-B", "Nelder-Mead")), verbose=FALSE)

    expect_silent(p.no.hold <- do.call(what = method, args = l.args))
    fct.helper.fitted.all.s3(clv.fitted = p.no.hold,  full.names = param.names,
                             clv.newdata.nohold = clv.newdata.nohold, clv.newdata.withhold = clv.newdata.withhold)
  })
}


fct.testthat.runability.common.works.with.cor <- function(method, clv.data.holdout, clv.newdata.nohold, clv.newdata.withhold, names.params.model){
  test_that("Works with use.cor=T", {
    skip_on_cran()

    l.args <- list(clv.data = clv.data.holdout, use.cor=TRUE, verbose=FALSE)
    expect_silent(p.cor <- do.call(what = method, args = l.args))

    full.names <- c(names.params.model, p.cor@name.correlation.cor)
    if(is(clv.data.holdout, "clv.data.static.covariates"))
      full.names <- c(full.names, p.cor@names.prefixed.params.free.life, p.cor@names.prefixed.params.free.trans)

    fct.helper.fitted.all.s3(p.cor, full.names = full.names,
                             clv.newdata.nohold = clv.newdata.nohold, clv.newdata.withhold = clv.newdata.withhold)
  })
}

fct.testthat.runability.common.works.with.cor.start.params <- function(method, clv.data.holdout, clv.newdata.nohold, clv.newdata.withhold, names.params.model){
  test_that("Works with use.cor=T and start.params", {
    skip_on_cran()
    skip_on_covr()
    skip_on_ci()

    l.args <- list(clv.data = clv.data.holdout, use.cor=TRUE, start.param.cor = 0.0, verbose=FALSE)
    expect_silent(p.cor <- do.call(what = method, args = l.args))

    full.names <- c(names.params.model, p.cor@name.correlation.cor)
    if(is(clv.data.holdout, "clv.data.static.covariates"))
      full.names <- c(full.names, p.cor@names.prefixed.params.free.life, p.cor@names.prefixed.params.free.trans)

    fct.helper.fitted.all.s3(p.cor, full.names = full.names,
                             clv.newdata.nohold = clv.newdata.nohold, clv.newdata.withhold = clv.newdata.withhold)
  })
}