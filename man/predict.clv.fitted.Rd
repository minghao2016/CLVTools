% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clv_template_controlflow_predict.R
\name{predict.clv.fitted}
\alias{predict.clv.fitted}
\alias{predict,clv.fitted-method}
\title{Predict CLV from a fitted model}
\usage{
\method{predict}{clv.fitted}(
  object,
  newdata = NULL,
  prediction.end = NULL,
  predict.spending = clv.data.has.spending(object@clv.data),
  continuous.discount.factor = 0.1,
  verbose = TRUE,
  ...
)

\S4method{predict}{clv.fitted}(
  object,
  newdata = NULL,
  prediction.end = NULL,
  predict.spending = clv.data.has.spending(object@clv.data),
  continuous.discount.factor = 0.1,
  verbose = TRUE,
  ...
)
}
\arguments{
\item{object}{A fitted clv model for which prediction is desired.}

\item{newdata}{A clv data object for which predictions should be made with the fitted model. If none or NULL is given, predictions are made for the data on which the model was fit.}

\item{prediction.end}{Until what point in time to predict. This can be the number of periods (numeric) or a form of date/time object. See details.}

\item{predict.spending}{Whether the spending and CLV should be calculated and reported additionally. Only possible if the transaction data contains spending information.}

\item{continuous.discount.factor}{continuous discount factor to use}

\item{verbose}{Show details about the running of the function.}

\item{...}{Ignored}
}
\value{
An object of class \code{data.table} with each columns containing the predictions:
\item{Id}{The respective customer identifier}
\item{period.first}{First timepoint of prediction period}
\item{period.last}{Last timepoint of prediction period}
\item{period.length}{Number of time units covered by the period indicated by \code{period.first} and \code{period.last} (including both ends).}
\item{PAlive}{Probability to be alive at the end of the estimation period}
\item{CET}{The Conditional Expected Transactions}
\item{DERT or DECT}{Discounted Expected Residual Transactions or Discounted Expected Conditional Transactions for dynamic covariates models}
\item{actual.x}{Actual number of transactions until prediction.end. Only if there is a holdout period and the prediction ends in it.}
\item{actual.Spending}{Actual spending until prediction.end. Only if there is a holdout period and the prediction ends in it, 0 otherwise.}
\item{predicted.Spending}{The spending as predicted by the Gamma-Gamma model.}
\item{predicted.CLV}{Customer Lifetime Value based on DERT and predicted spending.}
}
\description{
Probabilistic customer attrition models predict in general three expected characteristics for every customer:
\itemize{
\item "conditional expected transactions" (\code{CET}), which is the number of transactions to expect form a customer
during the prediction period,
\item "probability of a customer being alive" (\code{PAlive}) at the end of the estimation period and
\item "discounted expected residual transactions" (\code{DERT}) for every customer, which is the total number of
transactions for the residual lifetime of a customer discounted to the end of the estimation period.
In the case of time-varying covariates, instead of \code{DERT}, "discounted expected conditional transactions" (\code{DECT})
is predicted. \code{DECT} does only cover a finite time horizon in contrast to \code{DERT}. For \code{continuous.discount.factor=0}, \code{DECT} corresponds to \code{CET}.
}
If spending information was provided in the \code{clvdata} object, by default a Gamma/Gamma model is fitted
to predict spending and calculate the predicted CLV. In this case, the prediction additionally contains the following two columns:
\itemize{
\item predicted spending estimated by a Gamma/Gamma model
\item the customer lifetime value (CLV).
}
}
\details{
The \code{newdata} argument has to be a clv data object of the exact same class as the data object
on which the model was fit. In case the model was fit with covariates, \code{newdata} needs to contain identically
named covariate data.

The use case for \code{newdata} is mainly two-fold: First, to estimate model parameters only on a
sample of the data and then use the fitted model object to predict or plot for the full data set provided through \code{newdata}.
Second, for models with dynamic covariates, to provide a clv data object with longer covariates than contained in the data
on which the model was estimated what allows to predict or plot further. When providing \code{newdata}, some models
might require additional steps that can significantly increase runtime.

\code{prediction.end} indicates until when to predict or plot and can be given as either
a point in time (of class \code{Date}, \code{POSIXct}, or \code{character}) or the number of periods.
If \code{prediction.end} is of class character, the date/time format set when creating the data object is used for parsing.
If \code{prediction.end} is the number of periods, the end of the fitting period serves as the reference point
from which periods are counted. Only full periods may be specified.
If \code{prediction.end} is omitted or NULL, it defaults to the end of the holdout period if present and to the
end of the estimation period otherwise.

The first prediction period is defined to start right after the end of the estimation period.
If for example weekly time units are used and the estimation period ends on Sunday 2019-01-01, then the first day
of the first prediction period is Monday 2019-01-02. Each prediction period includes a total of 7 days and
the first prediction period therefore will end on, and include, Sunday 2019-01-08. Subsequent prediction periods
again start on Mondays and end on Sundays.
If \code{prediction.end} indicates a timepoint on which to end, this timepoint is included in the prediction period.

\code{predict.spending} uses a Gamma/Gamma model to predict customer spending. This option is only available
if customer spending information was provided when the data object was created.

\code{continuous.discount.factor} allows to adjust the discount rate used to estimated the discounted expected
transactions (\code{DERT}).
The default value is \code{0.1} (=10\%). Note that a continuous rate needs to be provided.


\subsection{The Gamma-Gamma model to Predict Spending}{
Most probabilistic latent customer attrition model capture future customer
behavior as a combination of the customer's purchase and attrition process.
However, in order to derive a monetary value such as CLV, customer spending
also has to be considered. To model customer spending the Gamma/Gamma is a
popular choice.
}
}
\examples{

\donttest{

data("apparelTrans")
# Fit pnbd standard model on data, WITH holdout
pnc <- pnbd(clvdata(apparelTrans, time.unit="w",
                    estimation.split=37, date.format="ymd"))

# Predict until the end of the holdout period
predict(pnc)

# Predict until 10 periods (weeks in this case) after
#   the end of the 37 weeks fitting period
predict(pnc, prediction.end = 10) # ends on 2010-11-28

# Predict until 31th Dec 2016 with the timepoint as a character
predict(pnc, prediction.end = "2016-12-31")

# Predict until 31th Dec 2016 with the timepoint as a Date
predict(pnc, prediction.end = lubridate::ymd("2016-12-31"))


# Fit pnbd standard model WITHOUT holdout
pnc <- pnbd(clvdata(apparelTrans, time.unit="w", date.format="ymd"))

# This fails, because without holdout, a prediction.end is required
\dontrun{
predict(pnc)
}

# Now, predict 10 periods from the end of the last transaction
#   (end of estimation period)
predict(pnc, prediction.end = 10) # ends on 2016-12-17

}

}
\references{
Schmittlein DC, Morrison DG, Colombo R (1987). \dQuote{Counting Your Customers:
Who-Are They and What Will They Do Next?} Management Science, 33(1), 1–24.

Fader PS, Hardie BGS (2005). \dQuote{A Note on Deriving the Pareto/NBD Model and
Related Expressions.}
URL \url{http://www.brucehardie.com/notes/009/pareto_nbd_derivations_2005-11-05.pdf}.

Fader PS, Hardie BG (2007). "Incorporating time-invariant covariates into the
Pareto/NBD and BG/NBD models."
URL \url{http://www.brucehardie.com/notes/019/time_invariant_covariates.pdf}.

Colombo R, Jiang W (1999). "A stochastic RFM model."
Journal of Interactive Marketing, 13(3), 2–12.

Fader PS, Hardie BG, Lee K (2005). "RFM and CLV: Using Iso-Value Curves for Customer Base Analysis."
Journal of Marketing Research, 42(4), 415–430.

Fader PS, Hardie BG (2013). "The Gamma-Gamma Model of Monetary Value."
URL \url{http://www.brucehardie.com/notes/025/gamma_gamma.pdf}.
}
