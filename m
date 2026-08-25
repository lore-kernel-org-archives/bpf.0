Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC9481FCB
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668592; cv=none; b=J8PyuWRGFFFABsyuY7lRVQOEE3fDMBNtmP8whe36a5D4/wKcaQMlkDRtz22imjq3y05w7uPk+L9ncSLaRM4RgK95yJ6l2b6WHQhZzU3QGQ6NHmkkhE0nFlPt00JJ5Qzlpv+iz7EPuosDQtlY36ibBD//Tyi1hq6lQPnxFQQsgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668592; c=relaxed/simple;
	bh=IcKXHF6vrhGtj7ZYQqyw2jK4hY1CLJGJqtmegwEfgOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YirCbFOXnTAUjcOjxoViJBGjVzPh+nlxmX+x5OmW1Cs2ERzKzSO5k/a2o2w68PqhVyu1Z754JUMN0URYnbz4ETZtkIMBVpdcUIOxUR4qULtce+OXDLBzBR/4954BmVaAovD45tmuP2galNWpdA77ZywuX+pvtIH+XMPjDPG0JAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in9y7MZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in9y7MZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BF41F00A3A;
	Tue, 25 Aug 2026 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787668590;
	bh=fMAgfibvv7YHIJBBKYi7FquwWhdFZlyG/ZfAQvwpQiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=in9y7MZjc1bRlAn/TSbZxcLbWxKFmVawpjaV8gU8JtWxC6ZjVA4knyuGBfutzBZNL
	 6fd/vHaQs5p6qA79saa1j6FIj6TSuXz5ADamHSWPg+h3AyhaEYfedQbsMFL53jG1Mp
	 LAJ03VuPLEdF2hvT8BDwm8AHjKzeC+0CczKp024dlRMCQ+5qES+5QL1Cs9CxEiMZaJ
	 rSaIOiMhxNN2Olzk/9ICkUt3WL5oHXB6W+EoGTNzIdg4qNPYb+yRRjjmAe4eTKrBKF
	 fwFus4IL4VaJue7epUBspxQX1PH0ELZLhmb4azrZC2ZvwZ8NGQwFhWi90RmPEWVCoE
	 ju6EBBCkspS6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 04/11] bpftool: Support ML-DSA program
 signing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825142530.1329706-5-daniel@iogearbox.net>
References: <20260825142530.1329706-1-daniel@iogearbox.net>
 <20260825142530.1329706-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 14:36:30 +0000
Message-Id: <20260825143630.86BF41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dropping `CMS_NOATTR` for ML-DSA without adding `CMS_NO_SIGNING_=
TIME` causes non-deterministic signatures, breaking reproducible builds for=
 BPF skeletons.
--

--- Patch [4]: [PATCH bpf-next v2 04/11] bpftool: Support ML-DSA program si=
gning ---
commit 1bfca914da9c400a3a2dbb7eb82099d6c8b92c8f
Author: Daniel Borkmann <daniel@iogearbox.net>

bpftool: Support ML-DSA program signing

This commit adds support for ML-DSA program signing in bpftool. It handles
OpenSSL versions that require signedAttrs by dropping the CMS_NOATTR flag
and bumps the maximum signature size to 16 KiB to accommodate larger ML-DSA
signatures.

> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> index 88726a6db6d0e..1b5502f48add0 100644
> --- a/tools/bpf/bpftool/sign.c
> +++ b/tools/bpf/bpftool/sign.c
[ ... ]
> @@ -167,6 +170,21 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *=
opts)
>  		goto cleanup;
>  	}
> =20
> +#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L && OPENSSL_VERSION_NUMBER < =
0x40000000L
> +	if (EVP_PKEY_is_a(private_key, "ML-DSA-44") ||
> +	    EVP_PKEY_is_a(private_key, "ML-DSA-65") ||
> +	    EVP_PKEY_is_a(private_key, "ML-DSA-87")) {
> +		/*
> +		 * ML-DSA + CMS_NOATTR is not supported before openssl-4.0, so
> +		 * fall back to signedAttrs. ML-DSA does its own hashing and
> +		 * ignores the CMS digest, except when signedAttrs are used,
> +		 * where only SHA-512 is permitted.
> +		 */
> +		signer_flags &=3D ~CMS_NOATTR;

[Severity: Medium]
When CMS_NOATTR is cleared here, doesn't OpenSSL automatically include the
signingTime attribute by default?

If signingTime is included, this would cause the generated BPF signature to
change on every invocation. Could this break reproducible builds for projec=
ts
compiling signed BPF skeletons? Should CMS_NO_SIGNING_TIME be added to
signer_flags when CMS_NOATTR is cleared, similar to how scripts/sign-file.c
handles it?

> +		cms_digest =3D EVP_sha512();
> +	}
> +#endif
> +
>  	cms =3D CMS_sign(NULL, NULL, NULL, NULL,
>  		       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY | CMS_DETACHED |
>  			       CMS_STREAM);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825142530.1329=
706-1-daniel@iogearbox.net?part=3D4
