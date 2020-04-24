import 'package:datafusion/kalman/IKalmanFilter.dart';
import 'package:linalg/linalg.dart';
import 'KalmanFilter.dart';

class DiscreteKalmanFilter implements IKalmanFilter {
  /// The covariance of the current state of the filter. Higher covariances
  /// indicate a lower confidence in the state estimate.
  Matrix get cov => _p;

  /// The best estimate of the current state of the system.
  Matrix get state => _x;

  /// The current state of the system.
  Matrix _x;

  /// The current covariance of the estimated state of the system.
  Matrix _p;

  /// Creates a new Discrete Time Kalman Filter with the given values for
  /// the initial state and the covariance of that state.
  /// <param name="x0">The best estimate of the initial state of the estimate.</param>
  /// <param name="P0">The covariance of the initial state estimate. If unsure
  /// about initial state, set to a large value</param>
  DiscreteKalmanFilter(Matrix x0, Matrix P0) {
    KalmanFilter.CheckInitialParameters(x0, P0);

    _x = x0;
    _p = P0;
  }

  /// <summary>
  /// Perform a discrete time prediction of the system state.
  /// </summary>
  /// <param name="F">State transition matrix.</param>
  /// <exception cref="System.ArgumentException">Thrown when the given state
  /// transition matrix does not have the same number of row/columns as there
  /// are variables in the state vector.</exception>
  void predictState(Matrix F) {
    KalmanFilter.checkPredictParameters(F, this);

    _x = F * _x;
    _p = F * _p * F.transpose();
  }

  /// <summary>
  /// Preform a discrete time prediction of the system state.
  /// </summary>
  /// <param name="F">State transition matrix.</param>
  /// <param name="Q">A plant noise covariance matrix.</param>
  /// <exception cref="System.ArgumentException">Thrown when F and Q are not
  /// square matrices with the same number of rows and columns as there are
  /// rows in the state matrix.</exception>
  /// <remarks>Performs a prediction of the next state of the Kalman Filter,
  /// where there is plant noise. The covariance matrix of the plant noise, in
  /// this case, is a square matrix corresponding to the state transition and
  /// the state of the system.</remarks>
  void predictWithCovarianceNoise(Matrix F, Matrix Q) {
    KalmanFilter.checkPredictParametersWithNoise(F, Q, this);

    // Predict the state
    _x = F * _x;
    _p = (F * _p * F.transpose()) + Q;
  }

  /// <summary>
  /// Perform a discrete time prediction of the system state.
  /// </summary>
  /// <param name="F">State transition matrix.</param>
  /// <param name="G">Noise coupling matrix.</param>
  /// <param name="Q">Plant noise covariance.</param>
  /// <exception cref="System.ArgumentException">Thrown when the column and row
  /// counts for the given matrices are incorrect.</exception>
  /// <remarks>
  /// Performs a prediction of the next state of the Kalman Filter, given
  /// a description of the dynamic equations of the system, the covariance of
  /// the plant noise affecting the system and the equations that describe
  /// the effect on the system of that plant noise.
  /// </remarks>
  void predict(Matrix F, Matrix G, Matrix Q) {
    KalmanFilter.checkPredictParametersWithNoises(F, G, Q, this);

    // State prediction
    _x = F * _x;

    // Covariance update
    _p = (F * _p * F.transpose()) + (G * Q * G.transpose());
  }

  /// <summary>
  /// Updates the state of the system based on the given noisy measurements,
  /// a description of how those measurements relate to the system, and a
  /// covariance <c>Matrix</c> to describe the noise of the system.
  /// </summary>
  /// <param name="z">The measurements of the system.</param>
  /// <param name="H">Measurement model.</param>
  /// <param name="R">Covariance of measurements.</param>
  /// <exception cref="System.ArgumentException">Thrown when given matrices
  /// are of the incorrect size.</exception>
  void update(Matrix z, Matrix H, Matrix R) {
    KalmanFilter.CheckUpdateParameters(z, H, R, this);

    // We need to use transpose of H a couple of times.
    Matrix Ht = H.transpose();
    Matrix I = Matrix.eye(_x.m);

    Matrix S = (H * _p * Ht) + R; // Measurement covariance
    Matrix K = _p * Ht * S.inverse(); // Kalman Gain
    _p = (I - (K * H)) * _p; // Covariance update
    _x = _x + (K * (z - (H * _x))); // State update
  }
}
