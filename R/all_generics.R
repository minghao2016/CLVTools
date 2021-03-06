# Predict Generics -------------------------------------------------------
# The S4 generic is defined explicitely for clarity, instead of relying on it as a side-effect of
#    only defining the method with setMethod
# As explained in ?Methods_for_S3 and per Martin Morgan's answer (https://stackoverflow.com/questions/32512785/properly-specify-s4-generics)
# Needs:
#   setClass
#   S3 implementation fun.class
#   S4 method setMethod that dispatches to S3 implementation
#   S3method(fun, class)
#   exportMethods(fun)
setGeneric(name = "predict")


# Controlflows -------------------------------------------------------------------------------------------------
# Steps performed by all models but different between base (no cov) and covariate models

# . Estimate ---------------------------------------------------------------------------------------------------
setGeneric("clv.controlflow.estimate.check.inputs", def=function(clv.fitted,  start.params.model, use.cor, start.param.cor, optimx.args, verbose,...)
  standardGeneric("clv.controlflow.estimate.check.inputs"))

setGeneric("clv.controlflow.estimate.put.inputs", def=function(clv.fitted, cl, use.cor, ...)
  standardGeneric("clv.controlflow.estimate.put.inputs"))

setGeneric("clv.controlflow.estimate.generate.start.params", def=function(clv.fitted, start.params.model,start.param.cor,verbose,...)
  standardGeneric("clv.controlflow.estimate.generate.start.params"))

setGeneric("clv.controlflow.estimate.prepare.optimx.args", def=function(clv.fitted, start.params.all)
  standardGeneric("clv.controlflow.estimate.prepare.optimx.args"))

setGeneric("clv.controlflow.estimate.process.post.estimation", def=function(clv.fitted, res.optimx)
  standardGeneric("clv.controlflow.estimate.process.post.estimation"))


# . Predict -----------------------------------------------------------------------------------------------
setGeneric("clv.controlflow.predict.check.inputs", def = function(clv.fitted, prediction.end, continuous.discount.factor, predict.spending, verbose)
  standardGeneric("clv.controlflow.predict.check.inputs"))

setGeneric("clv.controlflow.predict.set.prediction.params", def = function(clv.fitted)
  standardGeneric("clv.controlflow.predict.set.prediction.params"))

# .. Newdata: replace data in existing model -----------------------------------------------------------------
# For plot and predict
setGeneric("clv.controlflow.check.newdata", def = function(clv.fitted, user.newdata, prediction.end)
  standardGeneric("clv.controlflow.check.newdata"))


# . Plot ----------------------------------------------------------------------------------------------------
#function(clv.fitted, prediction.end, data.dyn.cov.life, data.dyn.cov.trans,...)
setGeneric("clv.controlflow.plot.check.inputs", def = function(obj, prediction.end, cumulative, plot, label.line, verbose)
  standardGeneric("clv.controlflow.plot.check.inputs"))

setGeneric("clv.controlflow.plot.get.data", def = function(obj, dt.expectation.seq, cumulative, label.line, verbose)
  standardGeneric("clv.controlflow.plot.get.data"))





# Model specific steps ------------------------------------------------------------------------------------------------------------

# . For all (base) models -----------------------------------------------------------------------------------------------------------

# .. Estimate ----------------------------------------------------------------------------------------------------------------------
# Perform model specific checks on user inputs to estimate
setGeneric("clv.model.check.input.args", def = function(clv.model, clv.fitted, start.params.model, use.cor, start.param.cor, optimx.args, verbose, ...)
  standardGeneric("clv.model.check.input.args"))

# Store additional arguments potentially given in estimate
setGeneric("clv.model.put.estimation.input", def = function(clv.model, clv.fitted, verbose, ...)
  standardGeneric("clv.model.put.estimation.input"))

# Finish the arguments to optimx with model specific arguments (mostly LL)
setGeneric(name="clv.model.prepare.optimx.args", def=function(clv.model, clv.fitted, prepared.optimx.args,...)
  standardGeneric("clv.model.prepare.optimx.args"))

# Transform standard or user given start params to optimizer (prefixed) scale
setGeneric(name="clv.model.transform.start.params.model", def=function(clv.model, original.start.params.model)
  standardGeneric("clv.model.transform.start.params.model"))

# Transform prefixed params to original scale
setGeneric(name="clv.model.backtransform.estimated.params.model", def=function(clv.model, prefixed.params.model)
  standardGeneric("clv.model.backtransform.estimated.params.model"))

# ie post.estimation.steps
setGeneric(name="clv.model.process.post.estimation", def=function(clv.model, clv.fitted, res.optimx)
  standardGeneric("clv.model.process.post.estimation"))

setGeneric(name="clv.model.m.to.cor", def = function(clv.model, prefixed.params.model, param.m)
  standardGeneric("clv.model.m.to.cor"))

setGeneric(name="clv.model.cor.to.m", def = function(clv.model, prefixed.params.model, param.cor)
  standardGeneric("clv.model.cor.to.m"))

# .. Predict ----------------------------------------------------------------------------------------------------------------------
# Predict clv per model

setGeneric(name = "clv.model.predict.clv", def = function(clv.model, clv.fitted, dt.prediction, continuous.discount.factor, verbose)
  standardGeneric("clv.model.predict.clv"))

setGeneric(name = "clv.model.expectation", def = function(clv.model, clv.fitted, dt.expectation.seq, verbose)
  standardGeneric("clv.model.expectation"))

# .. Generics --------------------------------------------------------------------------------------------------------------------
# return diag matrix to correct for transformations because inv(hessian) != vcov for transformed params
setGeneric(name="clv.model.vcov.jacobi.diag", def=function(clv.model, clv.fitted, prefixed.params)
  standardGeneric("clv.model.vcov.jacobi.diag"))

# .. Newdata ---------------------------------------------------------------------------------------------------------------
# Do the steps necessary to integrate user newdata in the fitted model (ie do cbs etc)
setGeneric(name="clv.model.put.newdata", def=function(clv.model, clv.fitted, user.newdata, verbose)
  standardGeneric("clv.model.put.newdata"))



# . For covariate models -----------------------------------------------------------------------------------------------------------

# .. Estimate -----------------------------------------------------------------------------------------------------------
# for a single process, because could be that start params for one process were different
setGeneric("clv.model.transform.start.params.cov", def = function(clv.model, start.params.cov)
  standardGeneric("clv.model.transform.start.params.cov"))

# Transform prefixed params to original scale
setGeneric(name="clv.model.backtransform.estimated.params.cov", def=function(clv.model, prefixed.params.cov)
  standardGeneric("clv.model.backtransform.estimated.params.cov"))


# clv.time ----------------------------------------------------------------------------------------------------

setGeneric("clv.time.epsilon", function(clv.time)
  standardGeneric("clv.time.epsilon"))

# convert user given date/datetimes
setGeneric("clv.time.convert.user.input.to.timepoint", function(clv.time, user.timepoint)
  standardGeneric("clv.time.convert.user.input.to.timepoint"))

setGeneric("clv.time.interval.in.number.tu", def = function(clv.time, interv)
  standardGeneric("clv.time.interval.in.number.tu"))

setGeneric("clv.time.number.timeunits.to.timeperiod", function(clv.time, user.number.periods)
  standardGeneric("clv.time.number.timeunits.to.timeperiod"))

setGeneric("clv.time.tu.to.ly", function(clv.time)
  standardGeneric("clv.time.tu.to.ly"))

setGeneric("clv.time.floor.date", function(clv.time, timepoint)
  standardGeneric("clv.time.floor.date"))

# only for pnbd dyncov createwalks
setGeneric("clv.time.ceiling.date", function(clv.time, timepoint)
  standardGeneric("clv.time.ceiling.date"))

setGeneric("clv.time.format.timepoint", function(clv.time, timepoint)
  standardGeneric("clv.time.format.timepoint"))

