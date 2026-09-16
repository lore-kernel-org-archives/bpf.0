Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A5466B70
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545337; cv=none; b=uUFzgtMejisH1oJUNn2qiLi/X38WVjj6j5kOS+eHP7Y/3VKO3p8vSn13ji6An94Q3Qnxi7OVR/nEhCfcuPJKwTOT5pXECiDaoneFmphF9doYoUDmoUex3bY6vEhKX5UVqAX6P9ShT4CujDg7pTEPiKYCXekrhQB3qHonJKyNOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545337; c=relaxed/simple;
	bh=b+4qutoyUWadAIe9O2B1AaBOCBDTcf8gVSh/kTjP44s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePxVYHHmZfWyqJBVnfF6BfD/AKKmpWI+IG8KAA2NDiY7UGLN4IBlNCruoIzD9em+ZpppxZ6u+kvgovj/eccid8m+ce9av/NrvrieM7Hxu29SNpKX9uHK5Ai+rna1BtK9B/btaEv0Q+izX0+iJ/1Lvlz+lwwf2XlMIPbpVLfQwuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3reVa4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3reVa4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FCF1F00898;
	Wed, 16 Sep 2026 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545312;
	bh=f+m2A4XgzjfHmKNsW0ZiA4bZj81O2V+JFMejabEbgiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3reVa4eyoAKNXkuN2NBFTT5Hr6UAJ7eLSu+TgXl36znXsRkbBJtwuG8hf0AJJ+Hv
	 U1hVWFbq308FmO+i4DYpn5TIk/DGVM5rRBYP1boT5Go8tt8/iARWGNZu8l2/uUTlPu
	 SVByLhhUoeM9OJUaH2VwXDYXwQCulTrMU6VPJqTSiY9cDpD4NalPL3xxP9Ba7C5EEx
	 QByrSNK8/bG+QCLZPA5YR2uzRvU3/6anW8bhgndsL3GixgR0TiyRkawIrX7FVXN1V6
	 2mFYNuwsStfvVMe+Wpu1B3NGE+sxEEVN+l3HHG2rNBQUO9hDTew2g9vlt+tWxQAxEC
	 yFT5D6+EIe/4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 02/11] libbpf: Add support for BTF kinds
 LOC[_PARAM|_PROTO|SEC]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916074118.1007116-3-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:55:12 +0000
Message-Id: <20260916075512.C0FCF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: Missing string representations for new BTF kinds
--

commit 98be00a89bec3663ddafbd1e828f7723cfe159cc
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]

This commit adds libbpf support for the new BTF_KIND_LOC_PARAM,
BTF_KIND_LOC_PROTO, and BTF_KIND_LOCSEC kinds. It implements data
accessors, validation checks, and handles their deduplication during
the primary and reference dedup phases.

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 587172c0de089..57f12630c5d15 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
[ ... ]
> @@ -431,6 +445,12 @@ btf_dump__dump_type_data(struct btf_dump *d, __u32 i=
d,
>  #define BTF_KIND_DECL_TAG	17	/* Decl Tag */
>  #define BTF_KIND_TYPE_TAG	18	/* Type Tag */
>  #define BTF_KIND_ENUM64		19	/* Enum for up-to 64bit values */
> +#define BTF_KIND_LOC_PARAM	20	/* Parameter at location */
> +#define BTF_KIND_LOC_PROTO	21	/* Parameter set at location */
> +#define BTF_KIND_LOCSEC		22	/* Section containing location info */
> +
> +struct btf_loc_param;
> +struct btf_loc;

[Severity: Low]
Should these new BTF kinds also be added to the __btf_kind_str() string
mapping function in tools/lib/bpf/libbpf.c?

When libbpf encounters errors or needs to log information about these new
types, it relies on __btf_kind_str(). Because they are missing from the
switch statement in that function, any debug or error logs formatting these
types will print "unknown" instead of their actual string names.

> =20
>  static inline __u16 btf_kind(const struct btf_type *t)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916074118.1007=
116-1-alan.maguire@oracle.com?part=3D2
