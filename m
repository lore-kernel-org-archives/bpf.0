Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776013EDAC3
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369382; cv=none; b=K08TQBPyP7gpiddpWbTtUjr6vQFd/rzkI14LXPxteAvpkRR9D+yt9viOOB3M9HwOkBS8mySl0y6EbV3BdvwhMJAx/euX+ygGXpMWltyhSVjohf5MVwL1UwNEy0W0u3bOMY8XjXMgMg2G5/mZGiEIpvkwmyawOiWF1/LN4MRrWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369382; c=relaxed/simple;
	bh=O/sbFjUtgqcHVkPobj0IRkhSqE6sGf3c8ikZSu5v0Is=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RaOD6qmGshT98yoin+BIStsbjgpn6UssX84VKTyqEHUrrytwW6a5B/58Jo2qGwnzKkag88ikL1zc22+Vn6d84enplAtHmf82Z4hSJaSVia2yMF5VcyrdJycDeMhTxrzQvjWycsMWcEmfDxC0QhsSJGaZrQTp1ssURXzM0dseoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXJ3gY5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXJ3gY5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E76C2BCAF;
	Thu, 16 Apr 2026 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776369381;
	bh=O/sbFjUtgqcHVkPobj0IRkhSqE6sGf3c8ikZSu5v0Is=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fXJ3gY5Pvgnn7dHEz79B4Miewb0xHiYOVUIahrxMTngq4pjQpOn4QFt55G0A1OTGL
	 B+9qB9t2YTA2A2Rf7BcVSycqU8EuMZ2khUz/ptYaqUo8sw/N0I8xF56AIqZJm9bwYb
	 K24wWQMUsQtM7H/qSrkBMfHmvgwLW5n4N5e39iDWIq1vgNHkDtAvX3BbPhmhFmcgmd
	 4T78IY3lAJueZxPZF4jmMsGL2D3nRF9VE0MwR0dJ2bh9+/l4+PSbDRCnrQjvXGVjpn
	 yg4KxoenOLUU18vn6tWezO2XcV7jQN8l/g5bARpJUSrlHgg5IyLEp39greaf7zsP9Z
	 EsG2WXAUAADpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] crypto: pkcs7: add ability to extract signed
 attributes by OID
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416173500.176716-3-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-3-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 19:56:20 +0000
Message-Id: <20260416195621.44E76C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Premature termination of signer iteration loop on missing or malfo=
rmed attributes.
- [Medium] Multi-valued attributes and repeated OIDs silently overwrite eac=
h other, returning the last match.
--

commit ee97b7abf11653ef22c6a659603d361105f1df57
Author: James Bottomley <James.Bottomley@HansenPartnership.com>

crypto: pkcs7: add ability to extract signed attributes by OID

Signers may add any information they like in signed attributes and sometimes
this information turns out to be relevant to specific signing cases. This a=
dds
an api pkcs7_get_authattr() to extract the value of an authenticated attrib=
ute
by specific OID.

> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_ke=
ys/pkcs7_parser.c
> index 6e3ffdac83ace..d467866f7d930 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
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

Does this callback return the last matching value instead of the first?

If an attribute contains multiple values (as allowed by the SET OF ANY sche=
ma),
or if there are multiple attributes with the same OID, this callback will be
invoked repeatedly, unconditionally overwriting ctx->data.

This seems to result in the last parsed value being returned, which contrad=
icts
the kernel-doc stating it will return the first one in parse order.

[ ... ]
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
> +		if (ret < 0 || ctx.data !=3D NULL)
> +			break;

Can this loop terminate prematurely if a signer has missing or malformed
attributes?

If a verified signer lacks authenticated attributes (sinfo->authattrs =3D=
=3D NULL),
asn1_ber_decoder() might return a negative error code. Because the condition
breaks on ret < 0, this will immediately abort the search across all remain=
ing
signers instead of skipping the current one.

This could cause operations like Hornet LSM BPF program verification to fai=
l if
a valid signature is shadowed by an earlier one lacking attributes.

> +	}
> +
> +	if (!ctx.data)
> +		return -ENODATA;
> +
> +	*_data =3D ctx.data;
> +	*_len =3D ctx.len;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416173500.1767=
16-1-bboscaccy@linux.microsoft.com?part=3D2
