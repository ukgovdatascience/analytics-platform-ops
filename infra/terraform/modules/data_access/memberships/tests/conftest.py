import json
import mock

import boto3
import pytest


TEST_IAM_ARN_BASE = "arn:aws:iam::1234"
TEST_STAGE = "test"
TEST_TEAM_SLUG = "__Justice_____League?!"
TEST_USERNAME = "Alice"

TEST_BUCKET_NAME = "{}-justice-league".format(TEST_STAGE)
TEST_ROLE_NAME = "{}_user_{}".format(TEST_STAGE, TEST_USERNAME.lower())
TEST_POLICY_ARN_PREFIX = "{iam_arn_base}:policy/{bucket_name}".format(
    iam_arn_base=TEST_IAM_ARN_BASE,
    bucket_name=TEST_BUCKET_NAME,
)
TEST_READ_ONLY_POLICY_ARN = "{}-readonly".format(TEST_POLICY_ARN_PREFIX)
TEST_READ_WRITE_POLICY_ARN = "{}-readwrite".format(TEST_POLICY_ARN_PREFIX)


@pytest.yield_fixture
def given_the_env_is_set():
    with mock.patch.dict("os.environ", {
        "STAGE": TEST_STAGE,
        "IAM_ARN_BASE": TEST_IAM_ARN_BASE,
    }):
        yield


@pytest.fixture
def iam_client_mock():
    return mock.create_autospec(boto3.client("iam"))


@pytest.yield_fixture
def given_iam_is_available(iam_client_mock):
    with mock.patch.object(boto3, "client", return_value=iam_client_mock):
        yield