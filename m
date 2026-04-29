Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA13AE6FB
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497608; cv=none; b=QeAB4gPcWgFa0vecll3xU8y8f+jjFdlSmDvr5KCK1Rtew2X6r58iPY7llqEhdVsD980q8Ci7JOz6dh7NmC5osqF9B9J+y6XFx7Ii/77PvXIoB9Na1mZc5g5rpIdyg7mOYNppadv+CGQUEIl1vNDffEm8xThcx2fX78YR0nQkhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497608; c=relaxed/simple;
	bh=dRVvlwBv0Z/uiR/DKQmb26v+265b+bL105u+3LZ6Xxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAX0Sl4lMRi43RPZWblJ2BavDwLho4C85Mu1N4mk4mEYkTKRYOcmOpYCbPXT6UJqJKAUIPg7mB1DAsYLLMxaFnrQq061Nz59yZ6Ec+jMmH8QtMwHR8w7ud42EeIMSQya0MwFlMfTy2vQm+Eb2E+BZiXxIuQcail4WZNerT9byMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4M0uYYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4M0uYYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024BAC19425;
	Wed, 29 Apr 2026 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497608;
	bh=dRVvlwBv0Z/uiR/DKQmb26v+265b+bL105u+3LZ6Xxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=F4M0uYYLG5nh2SVs5pf6a9Ut6mxlIyU4fzXg3R1esOQADjH8Yf9fjiFXQhP6kzf9G
	 WRjavXlJoiClnq5hXHj9y2CJDrphZl2hEgVU/Knfxsk5v+GtGT7hMvGRaEKqGAmcPI
	 HEpgED8qEE7VwVoMFG5OxR6obJ7G90vkJZiznKuU217na8hpSPadIgOeGrhZPGkHaY
	 oQh/hl3W8+Cy/iJIxA+Q8+UaKfG+nefrZCiml88mlY4qEcTFatGb9WDKuoYKQgSJRw
	 mlEU93y7fPsIFaJrxwVpUw58QvX1rDI3SMwowiVhLNrmp0ZkDg575wg3tzSsWaz95W
	 lwdgrx19xjDqA==
From: sashiko-bot@kernel.org
Subject: Re: [v6 01/10] crypto: pkcs7: add flag for validated trust on a
 signed info block
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-2-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-2-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:20:06 +0000
Message-Id: <20260429212008.024BAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] State persistence across validations causes false blacklist reject=
ions and API breakage if a pkcs7_message is evaluated multiple times.
- [Medium] verify_pkcs7_message_sig is exported using EXPORT_SYMBOL, creati=
ng a licensing mismatch with its prerequisite GPL functions.
- [Low] The commit message references a nonexistent function.
--

commit f9218a5ea80d770fbf301c4067d4e4b1febdf4ab
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add flag for validated trust on a signed info block

This commit adds a verified flag to the pkcs7_signed_info struct to track
if a signer has passed trust validation. It also exports
verify_pkcs7_message_sig so consumers can retrieve trusted pkcs7 objects.

> Allow consumers of struct pkcs7_message to tell if any of the sinfo
> fields has passed a trust validation.  Note that this does not happen
> in parsing, pkcs7_validate_trust() must be explicitly called or called
> via validate_pkcs7_trust().  Since the way to get this trusted pkcs7

This isn't a bug, but does validate_pkcs7_trust() exist in the tree?
It looks like this might be a typo for verify_pkcs7_signature() or
verify_pkcs7_message_sig().

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index e0761436ec7f..9bda49295bd0 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -380,6 +380,7 @@ int verify_pkcs7_message_sig(const void *data, size_t=
 len,
>  	pr_devel("<=3D=3D%s() =3D %d\n", __func__, ret);
>  	return ret;
>  }
> +EXPORT_SYMBOL(verify_pkcs7_message_sig);

Could this cause an API licensing mismatch?

To legitimately use verify_pkcs7_message_sig(), a consumer must parse the
raw payload into a pkcs7_message and eventually free it using
pkcs7_parse_message() and pkcs7_free_message().

Since those prerequisite functions are restricted to EXPORT_SYMBOL_GPL,
non-GPL modules wouldn't be able to legally acquire or manage the required
structures to use this new export. Should this be EXPORT_SYMBOL_GPL instead?

> diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_key=
s/pkcs7_trust.c
> index 9a87c34ed173..78ebfb6373b6 100644
> --- a/crypto/asymmetric_keys/pkcs7_trust.c
> +++ b/crypto/asymmetric_keys/pkcs7_trust.c

[ ... ]

> @@ -127,6 +127,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_mess=
age *pkcs7,
>  		for (p =3D sinfo->signer; p !=3D x509; p =3D p->signer)
>  			p->verified =3D true;
>  	}
> +	sinfo->verified =3D true;
>  	kleave(" =3D 0");
>  	return 0;
>  }

Will these verified flags cause issues if a parsed pkcs7_message is evaluat=
ed
multiple times?

Exporting verify_pkcs7_message_sig() allows a caller to evaluate a parsed
PKCS#7 message against multiple keyrings sequentially. If a message is
validated successfully against the first keyring, the certificates and
sinfo are marked verified =3D true.

When the same message is then validated against a second keyring, the inter=
nal
blacklist check is_key_on_revocation_list() invokes pkcs7_validate_trust()
against the blacklist keyring.

In pkcs7_validate_trust_one(), the code checks:

	for (x509 =3D sinfo->signer; x509; x509 =3D x509->signer) {
		if (x509->seen) {
			if (x509->verified)
				goto verified;

Because the certificate's verified flag is still true from the first keyring
check, won't the blacklist check hit this goto and falsely conclude the
certificate is blacklisted?

This seems like it would cause the second validation to unconditionally ret=
urn
-EKEYREJECTED for a valid message.

Additionally, if detached data is provided, pkcs7_supply_detached_data()
unconditionally returns -EINVAL on a second call. Does the state need to
be cleared before a subsequent validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D1
