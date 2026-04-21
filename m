Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83517A303
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737204; cv=none; b=kJ73xislgwjf1ukmT4egugA0VKHd3DWl6q4ZU3JM7CIuJDLYmHEFme1OXi63PrJavOGlViC+6v5XuYIrkOVVmOwVBGNKAsqQH93bYpaqvaC0RXKI/3HdYvUYpZ2QLCreeWuoRqL3Bnig2CnJFdS2F+gsNTaGminS4hYOi9KB7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737204; c=relaxed/simple;
	bh=SO6Acy+moXbJ1e/Hwcu+no9TFw9zKfnwo7gfA8nTdw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zbs/t++wIq7hUNm4RiWsnEWXp9qejxKqb8RxJgtocUNidZnHv6i5Kc3I76+9mhD31CSQY2ctAwl1Xfo0vS7STcLVvpsQt0QxeotyjkoAVc1/rbYT0Zi3E3sBsz22lC8OFnnjM0HZrtD9y3StyHVyuXwllShMvz0c9DZRw2ExPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcXMRJCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcXMRJCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E39BC19425;
	Tue, 21 Apr 2026 02:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776737203;
	bh=SO6Acy+moXbJ1e/Hwcu+no9TFw9zKfnwo7gfA8nTdw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IcXMRJCP/PTbehW34P+ZhCu/ekfocW9xLknepEemkw+9ayAGAilcZu70UdPD/9jBC
	 rWmZ0g3p0EbUwtWOZC2yLZvzaDakBmY7z4cQCh0e+S/kt/PWnMcgsXvVl1Hmi+2ReC
	 10T9LnFEbai1ATsv1oAFc3tLgJXBVSsFRCO1Q1Sm8K5+oylqUTaV0N0X2D9+E5A2lf
	 IganXhDCW+ctKe5V/ayn0xOnnBHzD9bjNOrUr5tAXiqQsIZ2p1H1iTX3Op02IZvDWB
	 n2TFkMVOOgO64jht8bs09F8PEnMBWhGApfdQ6Vb1bN7mGWudSKrZeA7o/XSvaOvIAH
	 juLZ5ghxsqukg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] crypto: pkcs7: add tests for
 pkcs7_get_authattr
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-4-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-4-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 02:06:42 +0000
Message-Id: <20260421020643.5E39BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Test failures are silently masked by unconditionally returning 0.
--

commit 11447b57d9861b91fcbcb5b89dcfd93489f5f252
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add tests for pkcs7_get_authattr

This commit adds example code to the pkcs7_key_type test module to verify
a message and extract a known authenticated attribute.

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

Should a negative error code be assigned to ret here before jumping to out?

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

Does this return 0 unconditionally mask the test failures?

If any of the checks above fail and jump to the out label, the function
returns 0, effectively discarding the error state. As a result, the key
instantiation will always succeed from the perspective of user space, and
test frameworks might incorrectly assume the test passed.

Should this return ret instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D3
