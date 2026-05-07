Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE4314B72
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197881; cv=none; b=NJPHp4rogBafK0EjVi0PgVBPKiH3hKDEW/dRN5/SIS/dDzJoOuSO84HvId+ZYsROWanjtdaOsUv4d/YHgpXyV9fbILI1k/c/60rp+shHwTxNPE4yWpnoBpXBWjMHDeWckYUEGIU7hHKM1DVg5nYtHprbMuS/k1bRKHFBhRVGSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197881; c=relaxed/simple;
	bh=mWUZ1toYaNcaqfSAh7exeaJU44TKQxGxGtjNk7DXxXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=os/COMYoc8+tAzDc2BJHAbZ2E7gPNr3++Y590hHB9zDKqIUZGItgkl55BT/2zXZQWKNKE6pKEnr24c6A0wOOGC/BuLdIH3ls0aQuhfcFnJcBI0OYl3LY6ClCQ6dATTl0f5rLz/Mues1xMT/vajDQUsoV1cPJZwQuj36O0c/hdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4fX/eYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4fX/eYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FA9C2BCF5;
	Thu,  7 May 2026 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197880;
	bh=mWUZ1toYaNcaqfSAh7exeaJU44TKQxGxGtjNk7DXxXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J4fX/eYPQ0YkApqyE3bDKQaDlco5SOwVsuESfpSESe/N4amUN/EiLzGFL0/xcop5O
	 Ndk7SgBOd1U0dozylsc7NF/1FmDaNpkYOW0arnzof1NuNAmxtDhwkotNWwJGbEH1Kl
	 FGmw5vOTpMPyZ9Yroz8YkeMOG9CfwBckhMirTSGfxGbo8+doNgSZvlAmoCEcJySi8i
	 hPdq2/UmvxJGeliTMphORurncdRAbluJZeMT9bnhU579crPmb7tM1ytwZGEs/jNbhW
	 JCQ86MgzBZjUdu54QdNQpTM09FCVe/YmYnyJ7xBlVMII52+XcWYVKEdcseGTC+jYYJ
	 eJhYhJoGzTvSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] crypto: pkcs7: add flag for validated trust on
 a signed info block
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-2-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:51:20 +0000
Message-Id: <20260507235120.D0FA9C2BCF5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Exporting `verify_pkcs7_message_sig` as `EXPORT_SYMBOL` creates a =
non-GPL wrapper around strictly GPL-only PKCS7 APIs.
- [High] The `verified` flags on `x509_certificate` and `pkcs7_signed_info`=
 are not cleared between validations, causing severe state leakage and API =
breakage on subsequent validations.
- [Medium] The `sinfo->verified` flag is set to `true` for blacklisted sign=
atures, creating a dangerous API hazard.
- [Medium] Concurrency data race on internal flags in `pkcs7_message` when =
`verify_pkcs7_message_sig` is called.
--

commit 4629d1adf43a0253ba7082b6c379d2bf57a8c8ce
Author: James Bottomley <James.Bottomley@HansenPartnership.com>
crypto: pkcs7: add flag for validated trust on a signed info block

This commit adds a flag to struct pkcs7_message to indicate if any sinfo
fields have passed trust validation. It sets the verified flag during
trust validation and exports verify_pkcs7_message_sig for module use.

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index e0761436ec7f4..9bda49295bd02 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -380,6 +380,7 @@ int verify_pkcs7_message_sig(const void *data, size_t=
 len,
>  	pr_devel("<=3D=3D%s() =3D %d\n", __func__, ret);
>  	return ret;
>  }
> +EXPORT_SYMBOL(verify_pkcs7_message_sig);

Since the underlying subsystem functions like pkcs7_verify and
pkcs7_validate_trust, as well as the alternative wrapper
verify_pkcs7_signature, are all explicitly exported as EXPORT_SYMBOL_GPL,
does exporting verify_pkcs7_message_sig as EXPORT_SYMBOL allow proprietary
modules to bypass the GPL requirement and access internal cryptographic
evaluations?

Should this use EXPORT_SYMBOL_GPL to match the rest of the subsystem?

> diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_key=
s/pkcs7_trust.c
> index 9a87c34ed1733..78ebfb6373b61 100644
> --- a/crypto/asymmetric_keys/pkcs7_trust.c
> +++ b/crypto/asymmetric_keys/pkcs7_trust.c

[ ... ]

> @@ -127,6 +127,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_mess=
age *pkcs7,
>  		for (p =3D sinfo->signer; p !=3D x509; p =3D p->signer)
>  			p->verified =3D true;
>  	}
> +	sinfo->verified =3D true;

If a consumer validates a message successfully against a keyring, the verif=
ied
flags are permanently set to true since they are not cleared between
validations.

If the same object is subsequently verified again, verify_pkcs7_message_sig
first runs is_key_on_revocation_list using the blacklist_keyring. During th=
is
blacklist check, if the message has multiple sinfo blocks signed by the same
key, the first block fails but sets seen to true.

The second block observes seen as true and the stale verified flag as true
from the previous run. Will this falsely evaluate to success, causing
is_key_on_revocation_list to return -EKEYREJECTED and making a previously
validated message fail subsequent verifications?

Additionally, when verify_pkcs7_message_sig checks the blacklist, it calls
pkcs7_validate_trust with the blacklist_keyring. If a signature matches a
revoked key, pkcs7_validate_trust returns success and sets sinfo->verified
to true.

Even though the outer function correctly returns -EKEYREJECTED, does this
leave the parsed pkcs7 object with verified set to true for a revoked key?
Could this confuse consumers inspecting the verified state after a failed
call?

Finally, if multiple threads concurrently call verify_pkcs7_message_sig on
the same pkcs7_message object, will the unprotected modifications to intern=
al
flags like p->seen, x509->verified, and sinfo->verified cause data races?

Could this lack of synchronization lead to random validation failures or
incorrect trust bypasses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D1
