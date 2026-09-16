Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5244AB81
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545340; cv=none; b=n74ADLtBr4BgoopvY4pr72TcGVViYNApFxeo1H6IgPFaXRjXh2RmHpAM5VwwfgCYCTRq/6prV7qNDFDnt2HHgKQsbOOO3F7kYNSS84+CCPYi3BH26VLVdlQOciC8vw7jwYzbKiRoU/3drR00j9hFhdMVKpn1UonjpXuqCyvleQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545340; c=relaxed/simple;
	bh=7dKjYROh0WySS030hCJTXVd9/GWHQopmYnzm4NLnaIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uueyRilKpGKUQlv+BPy8q/Eg9j8fQw0GltNCtcuuw43z3NxXZVA0eHJqe2QFb3w4G7N3eLMaW8aSSufUvhnOGl5U1m365xUfXAHOBiLSDkqzk7WIJ86Kac22dSm9J+ky7XIEyglAm1AMsgu2B2jJxx0kGN+XrL3pa6BiqmfQ/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc/D8iF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc/D8iF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E31F000FF;
	Wed, 16 Sep 2026 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545323;
	bh=11YIQ5/TheqzzHMa33hmU4SGcST0XFZ/C5jaQGx3jIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cc/D8iF3I6g30ylGG+eYF2OoYw/3BAFxqGddfyr8Sej/qrSKzgKchRO7odt4AeFpu
	 aV3FaPHxnEadu+Dk48/EwRjjhhEMdtE8Ka6RDGehFn6zc6gqWYI+G22eoSiKpCs+3V
	 4511YoyI7jDKU1MpfMi82xzDvS9jkCw/WyW4tHc/e2RSGivQoJtFiTbwydNDrfv4WB
	 1Pwg2u+IkEIZYNQPdsSMujf9B2taqaAhh65UmndQgSRUMFRQJXEkP5m7Suyp7KmL8C
	 htTqlVkpu6iCoH2f83XAi4RHfsoStjkvt999DD/B6ZfrswgezX4bssoOghB79TciXu
	 dLL9tb86rFkZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916074118.1007116-10-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:55:23 +0000
Message-Id: <20260916075523.6F2E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpftool: truncation of 24-bit BTF vlen to 16-bit in BTF_KIND_LOC_PR=
OTO
--

commit 2e08d4509f6018d2621350930f039568aa3418e3
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC

This commit adds support to bpftool for dumping new BTF kinds (LOC_PARAM,
LOC_PROTO, and LOCSEC) in both normal and JSON formats. It provides string
rendering for LOC_PARAM parameters, associated values for LOC_PROTOs, and
function names for LOCSEC sites.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bbe8f9ea144fa..5e0cb58628117 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
[ ... ]
> @@ -415,6 +495,95 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
[ ... ]
> +	case BTF_KIND_LOC_PROTO: {
> +		__u32 *params =3D btf_loc_proto_params(t);
> +		__u16 vlen =3D btf_vlen(t);

[Severity: Low]
Does this code unintentionally truncate the 24-bit variable length count
returned by btf_vlen() into a 16-bit unsigned integer?

While a function's parameter count is unlikely to exceed 65535 in practice,
a maliciously crafted BTF file could potentially trigger this truncation
when parsing a BTF_KIND_LOC_PROTO entry. Other BTF kinds like
BTF_KIND_LOC_PARAM in this patch appear to use __u32 for vlen.

> +		int i;
> +
> +		if (json_output) {
> +			jsonw_uint_field(w, "vlen", vlen);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916074118.1007=
116-1-alan.maguire@oracle.com?part=3D9
