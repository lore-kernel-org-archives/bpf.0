Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443914749F1
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658103; cv=none; b=E+yUs/j0dIDPrMspWFiFziUnEbyzZJF7MhB47nyOEKjpIE+EU1iqG8AgyWj9D4D85Tn+TEpZi5OKiQEGgfrgukkPN0QxIe5SGP2chc3pWxYbjQXGjwRlUmTbmopgyfsXzIJjDfCNMFYOGt1IZT+FQl60wxDab26NbAYAcLP7hg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658103; c=relaxed/simple;
	bh=gsDCxAufhBKK09zaWnoGoZkJcs2pc38kt8Rjf80HGuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K44VgWVwjTgyEZjnB7kLc5D59tpwUsi2PSys062zuInpPh7miZFT+BKxIFwbK5DBedN3cAxsa11mGHg4OB5ePNayFzoxa835OAOBKTqY/TAs6RfOaD7YR/dIvbdfCfU6FbVAd9+y5ELmqOOcMWwWQili96xzZRn6BgNaSwly+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmxDGMNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmxDGMNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548B21F000E9;
	Thu, 13 Aug 2026 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786658101;
	bh=tI7iaCdyUQT88Di5/m4Z7DXr/xGdKM4KEvOzkhwCh/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QmxDGMNgG7/+NqXbcTgu4GIswEL1v6tifRevX71s/DdT4sn+Rts35xyEcy5D3WJ1w
	 4nFbqxeThf9OBWKPtv0xnf5I5MmyzouEJChm6jLQhRGSAJVzOEehobEoZwwo0xaGGZ
	 HFIc2fOOCNFPF4gSVnfeynrmz7epEZhuAruCzTUyttBHrZCHQ1F18N1D8Mt9iHKn1Z
	 8m657UPkx8X45xTckvL4dtzbyqw1QWlpciVn4d6SQ2kWx+dVlQLITzm9/G887+zJNT
	 MotPvDG4FmdtQxOUStXKj6hU3nKVVGLLobuknphM6tLc7kijkMMpFZPc2+0ydTEym7
	 /Au9VjIHKzwcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 bpf-next 06/10] libbpf: Support sanitization of BTF
 layout for older kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260318132927.1142388-7-alan.maguire@oracle.com>
References: <20260318132927.1142388-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 21:54:57 +0000
Message-Id: <20260813215501.548B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Sanitization produces invalid or truncated BTF if `type_off` is =
non-zero due to an incorrect size calculation.
--

--- Patch [6]: [PATCH v14 bpf-next 06/10] libbpf: Support sanitization of B=
TF layout for older kernels ---
commit fb06581dbb776e3aedd4935e88818d62fe25f19f
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Support sanitization of BTF layout for older kernels

This patch introduces a FEAT_BTF_LAYOUT feature check to see if the kernel
supports BTF layout information. It also adds a BTF sanitization step
to remove the layout section for older kernels that don't support it.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad207..5d392fff76bdd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -3153,9 +3155,55 @@ static int bpf_object__sanitize_btf(struct bpf_obj=
ect *obj, struct btf *btf)
>  	bool has_type_tag =3D kernel_supports(obj, FEAT_BTF_TYPE_TAG);
>  	bool has_enum64 =3D kernel_supports(obj, FEAT_BTF_ENUM64);
>  	bool has_qmark_datasec =3D kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
> +	bool has_layout =3D kernel_supports(obj, FEAT_BTF_LAYOUT);
>  	int enum64_placeholder_id =3D 0;
> +	const struct btf_header *hdr;
> +	struct btf *btf =3D NULL;
> +	const void *raw_data;
>  	struct btf_type *t;
>  	int i, j, vlen;
> +	__u32 sz;
> +	int err;
> +
> +	/* clone BTF to sanitize a copy and leave the original intact */
> +	raw_data =3D btf__raw_data(orig_btf, &sz);
> +	hdr =3D raw_data;
> +
> +	if (!has_layout && hdr->hdr_len >=3D sizeof(struct btf_header) &&
> +	    (hdr->layout_len !=3D 0 || hdr->layout_off !=3D 0)) {
> +		struct btf_header *new_hdr;
> +		void *new_raw_data;
> +
> +		/*
> +		 * Need to rewrite BTF to exclude layout information and
> +		 * move string section to immediately after types.
> +		 */
> +		new_raw_data =3D malloc(sz);
> +		if (!new_raw_data)
> +			return ERR_PTR(-ENOMEM);
> +
> +		memcpy(new_raw_data, raw_data, sz);
> +		new_hdr =3D new_raw_data;
> +		new_hdr->layout_off =3D 0;
> +		new_hdr->layout_len =3D 0;
> +		new_hdr->str_off =3D hdr->type_off + hdr->type_len;
> +
> +		memmove(new_raw_data + hdr->hdr_len + new_hdr->str_off,
> +			new_raw_data + hdr->hdr_len + hdr->str_off,
> +			hdr->str_len);
> +		sz =3D hdr->hdr_len + hdr->type_len + hdr->str_len;

[Severity: Medium]
Since new_hdr->str_off correctly includes hdr->type_off, should the size
calculation for sz also include hdr->type_off?

If hdr->type_off is non-zero, this sz calculation would be smaller than the
required space (hdr->hdr_len + new_hdr->str_off + hdr->str_len). Could this
result in a truncated string section when loading valid BTF on older kernel=
s?

> +
> +		btf =3D btf__new(new_raw_data, sz);
> +		free(new_raw_data);
> +	} else {
> +		btf =3D btf__new(raw_data, sz);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260318132927.1142=
388-1-alan.maguire@oracle.com?part=3D6
