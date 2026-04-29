Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE11ADFE4
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500217; cv=none; b=N63eC+rEZ+jYwyq8IstdkZJ0m/epC5HKRELjk/ncLyPPqWXuUgE3Cxq88lLWIF5dfvkaD7PvihsGK6toaecFnIStk/B/B8YOKrohC26gn7p3RyybajbjSVU6238QmHEzNBoFpcNHjsXw+moJoZD8b/vzY7H+gpra134flJsm5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500217; c=relaxed/simple;
	bh=zs2rEYLMYjgBYs2ExTs3i6/rPhWUFTu8+qfzLYyy1XU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UAurbKqhb4CPQEffK4Qsdwn39CGpEtys8GoqeQ7D44wjagEVse0fOT8A4p5eVkx3EQ+iOafybiNwCebOtWfV2sMi0nTow5QRaB/H2jYXkzfEq8vv9YhUtADssJh7MKPZyYOJO0pvZYo3Ihdlb+xSuaTWJ06FK9mK45kshS5wEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g77sshK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g77sshK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACFFC19425;
	Wed, 29 Apr 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777500217;
	bh=zs2rEYLMYjgBYs2ExTs3i6/rPhWUFTu8+qfzLYyy1XU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=g77sshK/ew2F79YB55PJYV4Om2GEigtnJfT3NfG/68vsRcyV4CGUYdnUWFdAmfJHp
	 wl/Lg6XFRYvtLBeUidJ9O0hLkLSVAkNprsXYZW1Q9+Mdgdk5m4UF7U8xOy8T29yDqQ
	 aK+YOapJ4oXppBFV8oH/DAqkwS60Ovmjq5pJDPd4/ZpcAogan2AqQOqYrw/YIB8W0A
	 sIYDmvsH/WGAzW7WjnShUpi7truzzZDBc5clzhs9DIOm/KCLopjL3VRz5k1dK9KiZJ
	 BoX4338lsMWvO3VRD0FmwaDJArvUheEkmROby+hs0KSBkq0tlq/ygp0gyNQy6ECLED
	 K4QSIsKhqxQ3Q==
From: sashiko-bot@kernel.org
Subject: Re: [v6 03/10] crypto: pkcs7: add tests for pkcs7_get_authattr
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-4-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-4-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:03:36 +0000
Message-Id: <20260429220337.0ACFFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test failures are silently masked because `pkcs7_preparse` uncon=
ditionally returns success on failure paths.
--

commit e5c9359ab8a0636cf9b8d7481caa515ada8b2819
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add tests for pkcs7_get_authattr

This commit adds example code to the pkcs7_key_type test module to verify a
message and extract a known authenticated attribute.

> diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_=
keys/pkcs7_key_type.c
> index b930d3bbf1af..e0b1ce0202f6 100644
> --- a/crypto/asymmetric_keys/pkcs7_key_type.c
> +++ b/crypto/asymmetric_keys/pkcs7_key_type.c

[ ... ]

> @@ -51,16 +52,57 @@ static int pkcs7_view_content(void *ctx, const void *=
data, size_t len,
>  static int pkcs7_preparse(struct key_preparsed_payload *prep)
>  {
>  	enum key_being_used_for usage =3D pkcs7_usage;

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

If this condition triggers, ret is 0. Would this result in the test
reporting success even if the function were updated to return ret at the
end instead of 0? Should this set a negative error code before the goto?

[ ... ]

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

Since all failure paths jump to the out label which unconditionally
returns 0, does this silently mask test failures from the caller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D3
