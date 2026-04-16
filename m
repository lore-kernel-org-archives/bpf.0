Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE483A382A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370667; cv=none; b=Sa1+CWKGeuLBt5lSUUJmf4ZtkhMqvIf1OJEeTeAB/rbr9ZbhePMHg35VeoFID8L7R7UmNR9+ieY6R/dPSFKEIlseMVHCmDtk6E2xY8qw8tWKu1RbOFuhRI6CzjvctE41hbM27uF8AjVf8rCyUHfOjUVGnRD3QnXvQ8CqP8BoCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370667; c=relaxed/simple;
	bh=h/fE8r2oWl73bNXzDBG/MrDL5lT/BWv8t9GvMBXS+JA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WqY9888hphHC+Nu/UZkZmYOD4L8Ei7pWIlo+elrfQOP9bb3otG9gOhCF0W+3VEJEv8Scz3MWxv4DYQv5SBHIA+WSOGcGuAiu9CLZwRRRnW0FHfkD0wLIDYWJDREXrDBAalfon5FqOWcMUrkV4DqXHqWbcfM6Oo+SjXMlAhthEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwrgDc2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwrgDc2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50505C2BCAF;
	Thu, 16 Apr 2026 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776370666;
	bh=h/fE8r2oWl73bNXzDBG/MrDL5lT/BWv8t9GvMBXS+JA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fwrgDc2+iqG4haoHGAUB6muPfu55+m6+qr052tbwYGZHhn+GpGB9Zwq84IgGZ/9vy
	 yUO+3RdeR1GWXdXM2rC4dPYdIj/DaTkTo1TbH1IEXAXQWUw4CdhFREF7uAbqZErpC6
	 bA+RiCgJwl4mnpk/GJ7wU9DmW/hCseG1/b9Q1qnhK7Qzly3GxVB9vWikWTsOS306DH
	 em7C4q690zdh3U6x58BzS1ydh51i0HJiAvb16NS/pfmPtygnwOGhG1FBHFCZGl8w8J
	 9KHKtKbNxkjRN5s6Sd5E6mMbMzmhzYLOMWE8u2hh11TETKgh4++PJWny9/gNjOxU8i
	 vV3zypph0jjeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] crypto: pkcs7: add tests for
 pkcs7_get_authattr
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-4-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-4-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:17:45 +0000
Message-Id: <20260416201746.50505C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Test failures are silently ignored, causing key preparsing to al=
ways succeed instead of propagating error codes.
--

commit c10dc39561379c012380a3ebdc109e9849c1a856
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add tests for pkcs7_get_authattr

This commit adds example code to the pkcs7_key_type test module. It verifies
a PKCS#7 message and extracts a known authenticated attribute. This helps
validate the pkcs7_get_authattr functionality.

> diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_=
keys/pkcs7_key_type.c
> --- a/crypto/asymmetric_keys/pkcs7_key_type.c
> +++ b/crypto/asymmetric_keys/pkcs7_key_type.c

[ ... ]

> @@ -51,16 +52,57 @@ static int pkcs7_view_content(void *ctx, const void *=
data, size_t len,
>  static int pkcs7_preparse(struct key_preparsed_payload *prep)
>  {
>  	enum key_being_used_for usage =3D pkcs7_usage;
> +	int ret;
> +	struct pkcs7_message *pkcs7;

[ ... ]

> +	/*
> +	 * the parsed message has no trusted signer, so nothing should
> +	 * be returned here
> +	 */
> +	ret =3D pkcs7_get_authattr(pkcs7, OID_messageDigest, &data, &len);
> +	if (ret =3D=3D 0) {
> +		pr_err("OID returned when no trust in signer\n");
> +		goto out;
> +	}

If the OID is incorrectly returned without trust, ret is 0 when jumping to
the out label. Would this still result in a success code even if the functi=
on
were updated to return ret instead of 0?

Could ret be set to an error code like -EINVAL before the goto?

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
>  }

Does this unconditionally return success?=20

If a test fails and jumps to the out label, the error code in ret seems to =
be
discarded. Should this return ret instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D3
