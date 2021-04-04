{ lib
, python3Packages
, fetchFromGitHub
}:

let
  crossrefAPI = python3Packages.buildPythonPackage {
    pname = "crossrefapi";
    version = "1.5.0";
    buildInputs = with python3Packages; [ requests ];
    src = fetchFromGitHub {
      owner = "fabiobatalha";
      repo = "crossrefapi";
      rev = "3ca1b3df98e33a73393b82f9f0e461a1b60f46ba";
      sha256 = "u4U0RJoiorXcRgV/kT1/+wLKRyJIUmI58XOY3twzr1g=";
    };
    doCheck = false;
  };
in
python3Packages.buildPythonApplication rec {
  pname = "papers-cli";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "perrette";
    repo = "papers";
    rev = "0140bca836d96659c0fdca7319b4cdc736628176";
    sha256 = "t/y0vrMRvXWmMXzriRrj1RiJE9pJRplvc98A7K6rK3g=";
  };
  buildInputs = with python3Packages; [
    bibtexparser
    crossrefAPI
    rapidfuzz
    requests
    six
    unidecode
  ];
  propogatedBuildInputs = with python3Packages; [
    bibtexparser
    crossrefAPI
    rapidfuzz
    requests
    six
    unidecode
  ];
  pythonImportsCheck = [ "papers" "six" ];
  doCheck = false;

  meta = with lib; {
    description = "Command-line program for bibliographic management";
    homepage = "https://github.com/perrette/papers";
    license = licenses.mit;
    maintainers = with maintainers; [ jonathanreeve ];
    platforms = platforms.unix;
  };
}
