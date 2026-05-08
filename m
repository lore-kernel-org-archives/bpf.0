Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772B2F8EA7
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199276; cv=none; b=shhsMMSHhp3MzxFJn8EV5UBGyrXuTuaQvtLL0nEibyJpyysvRHs5bpSGPDsiYyMLpPcoRywpXqKxR6+LgDCR1JCJiOL5dk9PK4k7pTBLvxFy8HzPfilSCMzmzSqWy57eEtAAdZSx5KFTY/TNyNMzFFr9asGV/giqWnz3cNuSOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199276; c=relaxed/simple;
	bh=nfEu2DOyQ09PVfhkfMQIEZfXjk71TMpYN7o+YRgYcR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sBKEd8ik0vkj1LPO9NVMw4zXZz1Ur9gsqtGAL2mEKJXWNlKGYyOFeHd8kxjZK/6SHa/lNKz+nYfm3Lo5QS0V9+82b5uB0fcC7dnqWsD/UMeAwHSmnuaIVNGTHpeAkxYVBmIMSMdzRp0JyLEp/ZCr/MGlAIul6JWEsQUg3VkPRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXreIGhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXreIGhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F11BC2BCB2;
	Fri,  8 May 2026 00:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199275;
	bh=nfEu2DOyQ09PVfhkfMQIEZfXjk71TMpYN7o+YRgYcR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bXreIGhEe2Vit5+wvwQR4Ra0edMDNFItGnzIVy7lI7qBJHzd03GYXGOPyundRTNLh
	 yqbAMlQ3vBvbet3sY1XKbc0iHHvmuMekVWF/fiFg0PsZIEMEOwlhNKiOSDSbpBHyJ1
	 5bPeUL47SBKnZr7pqMTk72VcgnFMAktmBqj1AXVNSQhw1KFsSSZ4c5nIQ2IHxmDAZx
	 kCR09kQ9FkSMsanzBzZPlzn4JFUelCKqlcxqKWDxG8JDMVKPqDWqubA3dN2QAkYJre
	 MvjmzUJu0lK+8SSdcKrkEkbt5/r8W3xwFcSjbHnIuyHGRVcweYgoGUlSNx8uEGt+AP
	 yPvDrwWzHgQ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] crypto: pkcs7: add ability to extract signed
 attributes by OID
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507191416.2984054-3-bboscaccy@linux.microsoft.com>
References: <20260507191416.2984054-3-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:14:34 +0000
Message-Id: <20260508001435.8F11BC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Premature loop termination if a verified signer lacks authenticate=
d attributes (`sinfo->authattrs =3D=3D NULL`).
- [Medium] The function returns the last matching attribute value rather th=
an the first one, contradicting its API documentation.
--

commit 8f64855e85aaa27bba380d666827191e50cceb99
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add ability to extract signed attributes by OID

This commit adds an API, pkcs7_get_authattr(), to extract the value of an
authenticated attribute by a specific OID. It parses the signed attributes
and is intended to return the first matching value.

> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_ke=
ys/pkcs7_parser.c
> index 6e3ffdac83ace..d467866f7d930 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
[ ... ]
> @@ -211,6 +212,86 @@ int pkcs7_get_content_data(const struct pkcs7_messag=
e *pkcs7,
[ ... ]
> +int pkcs7_aa_note_attr(void *context, size_t hdrlen,
> +		       unsigned char tag,
> +		       const void *value, size_t vlen)
> +{
> +	struct pkcs7_aa_context *ctx =3D context;
> +
> +	if (ctx->found) {
> +		ctx->data =3D value;
> +		ctx->len =3D vlen;
> +	}
> +
> +	return 0;
> +}

The documentation for pkcs7_get_authattr() mentions it returns the first ma=
tch
in parse order.

If an authenticated attribute contains multiple values within its SET OF AN=
Y,
or if multiple attributes share the same OID, won't this callback continuou=
sly
overwrite ctx->data and return the last matching value instead of the first
one?

Could we enforce capturing only the first value by checking if ctx->data is
already set before assigning it?

[ ... ]
> +int pkcs7_get_authattr(const struct pkcs7_message *pkcs7,
> +		       enum OID oid,
> +		       const void **_data, size_t *_len)
> +{
> +	struct pkcs7_signed_info *sinfo =3D pkcs7->signed_infos;
> +	struct pkcs7_aa_context ctx;
> +
> +	ctx.data =3D NULL;
> +	ctx.oid_to_find =3D oid;
> +
> +	for (; sinfo; sinfo =3D sinfo->next) {
> +		int ret;
> +
> +		/* only extract OIDs from validated signers */
> +		if (!sinfo->verified)
> +			continue;
> +
> +		ret =3D asn1_ber_decoder(&pkcs7_aa_decoder, &ctx,
> +				       sinfo->authattrs, sinfo->authattrs_len);
> +		if (ret < 0 || ctx.data !=3D NULL)
> +			break;
> +	}

PKCS#7 allows authenticated attributes to be optional, meaning sinfo->autha=
ttrs
could legitimately be NULL with a length of 0.

If a verified signer has no authenticated attributes, asn1_ber_decoder() wi=
ll
be called with datalen =3D=3D 0 and fail with a data overrun error, returni=
ng a
negative value.

Because the loop breaks on ret < 0, won't this permanently abort the search
across all subsequent signers instead of skipping to the next one?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507191416.2984=
054-1-bboscaccy@linux.microsoft.com?part=3D2
