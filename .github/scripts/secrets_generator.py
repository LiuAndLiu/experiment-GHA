from base64 import b64encode
from nacl import encoding, public
import requests
import sys


def encrypt(public_key: str, secret_value: str) -> str:
    """
    Encrypt a Unicode string using the public key.
    """
    public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
    sealed_box = public.SealedBox(public_key)
    encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
    return b64encode(encrypted).decode("utf-8")


def get_key(pat: str, repository: str, environment: str) -> str:
    # Get repo id first
    repo_id = requests.get(
        f"https://api.github.com/repos/liuandliu/{repository}",
        headers={"Authorization": f"token {pat}"},
    )

    if repo_id.status_code == 400:
        raise ValueError(f"The return status code is {repo_id.status_code}")
    repo_id = repo_id.json()["id"]

    # Get key
    key = requests.get(
        f"https://api.github.com/repositories/{repo_id}/environments/{environment}/secrets/public-key",
        headers={"Authorization": f"token {pat}"},
    )

    if key.status_code == 404:
        raise ValueError(f"The return status code is {repo_id.status_code}")

    key = key.json()["key"]

    return key


if __name__ == "__main__":
    print(encrypt(get_key(sys.argv[1], sys.argv[2], sys.argv[3]), sys.argv[4]))
