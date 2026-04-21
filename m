Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC825392A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736155; cv=none; b=Wuh61MbcGZgdqmCS4mYU2npRPqBimaD0fkBawUJnBV9mpZgs04iLHJHCxK/mFUebUCdadmvH7vAZU5aDx+inE6Gx5I35c9zE/QfoutOisYIYBd21yqnck8Ze9x9uWCRQKUBi2O0dqPt07jVZoYCm6XubJb2kF4HpqyVAtaY3dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736155; c=relaxed/simple;
	bh=3wWH2fcsEd/rWtq3nuo82dZsW2bLVbNdOVi25eIZ43w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SDlsyv1nOs/Mt8/yj1KZpbnNlsf3A51RW7RwsBDCj0deQr4Epd7DECbSP+oInIqrWDNYKw/jIbKxUotkxpuTAPvfEXtd1zuSfd4TXhWpDZRF5SCmYSpX5bdqBG5dU5Y1ZGxsGlXnnVUC5q5yvd9M4MMVOxptdIlLzZ7U+tte0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZbYygq3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZbYygq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56C0C19425;
	Tue, 21 Apr 2026 01:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776736155;
	bh=3wWH2fcsEd/rWtq3nuo82dZsW2bLVbNdOVi25eIZ43w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hZbYygq3Qqu+TvuFojXNIQaPl+wDU0+4QMzw3B55hYPJFT8TlJsIYkgkK+2udjJav
	 W8grCD6i+9SnGwEOHdI2Y/BTnrCIBN/BHSP9w+ECTXFYeM/nuVh4x8f4FjyFU3CMw8
	 kGtXddwoha+1ohqoxxd/SB+wFsl8c8JkGHsLsc8bmhb/JST0gE/WM5uXgtTYCZjXnf
	 W2pUtKc+GJpzdwUCnUXosfJEUj9aENHCG24lwx5F1qmy5HAXgLX1MxDJhbk06WVink
	 CkO5niI3KpCSf4852V4KiGlVq2ont8zlMxMBRo0OXCEc8p1VtJfiRZGZUNbiLEYRbq
	 V+f87nh+5SclQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] crypto: pkcs7: add ability to extract signed
 attributes by OID
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420212653.438685-3-bboscaccy@linux.microsoft.com>
References: <20260420212653.438685-3-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 01:49:14 +0000
Message-Id: <20260421014914.D56C0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] API Flaw / Data Corruption with Constructed Types (`SET OF ANY` be=
havior)
- [High] Early Loop Termination on Missing Authenticated Attributes
- [High] Multi-value Overwrite / Parser Differential
- [Medium] Genuine ASN.1 Decoding Errors are Masked
--

commit 1ec29c2985cc84f3d3e1912ff4626eaa51d31e0c
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add ability to extract signed attributes by OID

This patch adds an API to extract the value of an authenticated attribute
by a specific OID. It introduces a new ASN.1 grammar and decoder to parse
the PKCS#7 signed attributes.

> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_ke=
ys/pkcs7_parser.c
> index 6e3ffdac83ace..d467866f7d930 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c

[ ... ]

> @@ -211,6 +212,86 @@ int pkcs7_get_content_data(const struct pkcs7_messag=
e *pkcs7,
>  }
>  EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
> =20
> +struct pkcs7_aa_context {
> +	bool found;
> +	enum OID oid_to_find;
> +	const void *data;
> +	size_t len;
> +};
> +
> +int pkcs7_aa_note_OID(void *context, size_t hdrlen,
> +		      unsigned char tag,
> +		      const void *value, size_t vlen)
> +{
> +	struct pkcs7_aa_context *ctx =3D context;
> +	enum OID oid =3D look_up_OID(value, vlen);
> +
> +	ctx->found =3D (oid =3D=3D ctx->oid_to_find);
> +
> +	return 0;
> +}
> +
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

Since the ASN.1 SET OF ANY grammar allows constructed types, does
asn1_ber_decoder() descend into the constructed type and repeatedly call th=
is
action for each nested primitive? If so, this would overwrite ctx->data with
the last inner leaf element rather than capturing the outer bounds.

Also, if multiple attributes with the same OID exist, wouldn't this overwri=
te
ctx->data with the last matching attribute instead of returning the first o=
ne
as the documentation states?

> +
> +	return 0;
> +}
> +
> +/**
> + * pkcs7_get_authattr - get authenticated attribute by OID
> + * @pkcs7: The preparsed PKCS#7 message
> + * @oid: the enum value of the OID to find
> + * @_data: Place to return a pointer to the attribute value
> + * @_len: length of the attribute value
> + *
> + * Searches the authenticated attributes until one is found with a
> + * matching OID.  Note that because the attributes are per signer
> + * there could be multiple signers with different values, but this
> + * routine will simply return the first one in parse order.
> + *
> + * Returns -ENODATA if the attribute can't be found
> + */
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

If a verified signer omits authenticated attributes, sinfo->authattrs is
NULL and sinfo->authattrs_len is 0. Does passing a 0-length buffer to
asn1_ber_decoder() cause it to return an error?

If so, the loop will break immediately below, meaning we could miss attribu=
tes
from subsequent valid signers in the message. Should there be an explicit
continue if !sinfo->authattrs?

> +		if (ret < 0 || ctx.data !=3D NULL)
> +			break;

If asn1_ber_decoder() returns an error due to the constructed type
misalignment, does checking ctx.data !=3D NULL here mask that error and
allow the function to successfully return a corrupted inner pointer?

> +	}
> +
> +	if (!ctx.data)
> +		return -ENODATA;

If asn1_ber_decoder() fails with a genuine structural error like -EBADMSG,
the loop breaks but we unconditionally return -ENODATA here. Does this
incorrectly mask malformed data errors from the caller?

> +
> +	*_data =3D ctx.data;
> +	*_len =3D ctx.len;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pkcs7_get_authattr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420212653.4386=
85-1-bboscaccy@linux.microsoft.com?part=3D2
