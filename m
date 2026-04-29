Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE8396565
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498956; cv=none; b=GRt6gsRmQFeXsyHxeXXwqW+mGA8JwdEzxQ0/DPL6EJ5MpuKEPaAePdSWXIT08k/Nn1ApwUxZQlI7zlM5mvkLWg9NgCwa7qdg/xkAOSFCn97elobDlp9/ezqmudarLvOyFUZzohlCUw8WxZQzOpDt4FaFNqsAUc41njq17rYAWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498956; c=relaxed/simple;
	bh=K+DDL5mgYLAZVaDSE8xOJ52qLCLoz+ein+lG6PdaXzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hz/QfautfUW25zHexZBmBN8CTQUFyNZv214KkvM4mIEK+huFl0EPo55KZGRf4eJLrSpUTDMii+MwqkJ71HKpXtHXoARV6xRsp7FUXLbAWZusVuzGlG2YPtOFf1TTE1V3ajts67D/uEy2HlX8kCGQXGwcWlMfoQ8AzMHOvZqQVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvJPqMSR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvJPqMSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC9C19425;
	Wed, 29 Apr 2026 21:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498956;
	bh=K+DDL5mgYLAZVaDSE8xOJ52qLCLoz+ein+lG6PdaXzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MvJPqMSRdXmXYxjNQN27wLMWuIgN9ExpBENdDOvpZXBHCGD89UVdxgZsbjL04tcfr
	 u+2CAZPOOCQi2br0BrLahz+IrSOsJdRr+9hnf8adtpQFNrLkefnCADNvOhtqngYYET
	 1u5k7txkE1QqvOzOdlMYSgdtbUWHazYOelBBbJJuva8yMCaAEH2x66DMnmJJ1Dj7tO
	 yUxFeGA+seatgcnf+MFpZ9jp4hGHug/7rIj7hEWnGPQYCL4QTa8Hiz/tZKgw8MO+JL
	 /qkjm+cL7VIRbtmWDtnmBfij0W9NQJUm8wh/JMxy+QqCkmke9UEMTb62SJdQ7u/Jz9
	 bRTb6ZkHvQ16w==
From: sashiko-bot@kernel.org
Subject: Re: [v6 02/10] crypto: pkcs7: add ability to extract signed
 attributes by OID
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-3-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-3-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:42:35 +0000
Message-Id: <20260429214236.05BC9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Premature loop termination skips valid signers when a prior signer=
 lacks authenticated attributes or contains malformed data.
- [Medium] Parser differential risk due to blindly overwriting multiple att=
ribute values in `pkcs7_aa_note_attr`.
--

commit 06f8e69e2d93f6dbe1e1035741251e357d0c5e30
Author: James Bottomley <James.Bottomley@HansenPartnership.com>
crypto: pkcs7: add ability to extract signed attributes by OID

This commit adds an API to extract authenticated attributes from a PKCS#7
message by OID. It introduces a new ASN.1 grammar and a set of callbacks to
parse the attributes for verified signers.

> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_ke=
ys/pkcs7_parser.c
> index 6e3ffdac83ac..d467866f7d93 100644
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

Does this create a parser differential risk?

The ASN.1 definition uses a set of ANY for authenticated attributes. If a
single attribute contains multiple values, this callback will be triggered
for each element.

Since the callback overwrites ctx->data without checking if a value was alr=
eady
found, it will silently return only the last value in the set. Could an
attacker craft a signature with multiple conflicting values, causing Linux
to extract and enforce a policy based on a different payload than what other
tools verify?

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

Can this loop exit prematurely when a prior signer lacks authenticated
attributes or contains malformed data?

If a verified PKCS#7 signer has no authenticated attributes, sinfo->authatt=
rs
is NULL and sinfo->authattrs_len is 0. Calling asn1_ber_decoder() with a
0-length buffer triggers a data overrun check and returns a negative error =
code:

lib/asn1_decoder.c:asn1_ber_decoder() {
    ...
    if (unlikely(datalen - dp < 2))
        goto data_overrun_error;
    ...
}

Because of the break statement on a negative return value, this aborts the
search entirely and returns -ENODATA.

Does this prevent the parser from checking any subsequent verified signers =
that
might actually contain the requested attribute? Should this skip empty
attributes and use continue instead of break?

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
> +EXPORT_SYMBOL_GPL(pkcs7_get_authattr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D2
