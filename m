Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB62F8E8C
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200514; cv=none; b=seFQOH4VVpEgWwfBU8e1bmVDKGVp7TyxCV7vaJjzngth4VH1H9CZfKvZ0CcRvbEsOwEZQOf5Wdi80JeA5cnN+/8Md631jr/IEoMLoVubaSvnyIDR3+/MTTZvy5+ZYMrM0vUgwDr3744KX6uqI1zzFpCPzHRikXrmGVTlFu8ns5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200514; c=relaxed/simple;
	bh=B+gZ/Je76IHNHgfCXvLg2qpH14qkoyavbJ02vTDedRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l+oNNSnR0jLXf/FAOclXVH+bDsBf53C7gJSiexnWDltz579jR+zoPTVy2K+2dTB0AvbFRfPt82YBzgbYnxrvbvWvD5Gt5mtngOZ80Kr3wBKKWOHGtezQtqSNGC9eCNrRzDE6chdKfnTKB8JVZ6AdTZFuGBVNaspWpNK5+s8anGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYVx/+Ms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYVx/+Ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A36C2BCB2;
	Fri,  8 May 2026 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778200514;
	bh=B+gZ/Je76IHNHgfCXvLg2qpH14qkoyavbJ02vTDedRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JYVx/+MsVN/LOVs/Q0h4ejfkCg/45g6TpDMT/39lZE7so3ah0ft2UO+GihiwcOcwI
	 qxKMQ7nhQT5fs8BhBQxBI6JFzROdgdv47qFc3YVTu1cCk9RfkJhDexW7duVejA8+f/
	 speD2U99s+DQ0sPLcYhuSYPuraB6DHxM3GfnQNh8y9ktqAGLoE1BU11rYSJzclLKHE
	 pyFDUrabbrRMnrBxn0T39pNPsCmD0fWa0qqS9LG1S81XjRSz0hEueMepoT1dc6Suri
	 arfUgmI9okW6WUSEHWUMPd6Tfb9cLDE6QC9vobsHyNwUoUrcYA0SNelUOWynmelQHB
	 dokVWFCeH8L/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] crypto: pkcs7: add tests for
 pkcs7_get_authattr
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-4-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:35:13 +0000
Message-Id: <20260508003514.02A36C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test failures in `pkcs7_preparse` are silently masked because th=
e function unconditionally returns 0 instead of propagating the error code.
--

commit 49875871a24595817e686cb5ad55b01eebf05536
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add tests for pkcs7_get_authattr

Add example code to the test module pkcs7_key_type.c that verifies a message
and then pulls out a known authenticated attribute.

> diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_=
keys/pkcs7_key_type.c
> index b930d3bbf1af5..e0b1ce0202f6d 100644
> --- a/crypto/asymmetric_keys/pkcs7_key_type.c
> +++ b/crypto/asymmetric_keys/pkcs7_key_type.c

[ ... ]

> @@ -51,16 +52,57 @@ static int pkcs7_view_content(void *ctx, const void *=
data, size_t len,
>  static int pkcs7_preparse(struct key_preparsed_payload *prep)
>  {

[ ... ]

> +	/*
> +	 * the parsed message has no trusted signer, so nothing should
> +	 * be returned here
> +	 */
> +	ret =3D pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
> +	if (ret =3D=3D 0) {
> +		pr_err("OID returned when no trust in signer\n");
> +		goto out;

If the test fails here, does this need to set ret to a negative error code
like -EINVAL before jumping to the out label? Since ret is 0 here, returning
ret at the end would still signal success.

> +	}
> +	/* add trust and check again */
> +	ret =3D verify_pkcs7_message_sig(NULL, 0, pkcs7,
> +				       VERIFY_USE_SECONDARY_KEYRING, usage,
> +				       NULL, NULL);
> +	if (ret) {
> +		pr_err("verify_pkcs7_message_sig failed!!\n");
> +		goto out;
> +	}
> +	/* now we should find the OID */
> +	ret =3D pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
> +	if (ret) {
> +		pr_err("Failed to get message digest\n");
> +		goto out;
> +	}
> +	pr_info("Correctly Got message hash, size=3D%zu\n", len);
> +
> + out:
> +	pkcs7_free_message(pkcs7);
> +	return 0;

Should this return ret instead of 0? If any of the earlier assertions fail
and jump to the out label, returning 0 unconditionally discards the error
state and signals a successful key instantiation to the keys subsystem.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D3
