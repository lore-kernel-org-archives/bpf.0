Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3A483809;
	Tue,  1 Sep 2026 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282398; cv=none; b=By7O0NsmQKQicG6/8oexaoXm/1QzXca4FQvCxVt1bntKwQbgGBoPGpO+KMF8N81QdQ3Lc4tLmnLgykRuDDqb1y8kA+yNaN4Ji0ZQNZR1H+KN1Qpn0hsjpdhb20m4pdAqFvOqv4rZuNbgohsRVEAk4gMVgFkP7m3TYXh2iNNcE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282398; c=relaxed/simple;
	bh=ur994vFRmSEa53oibR6S91gBo4qd+Hb1ZNiOXk2B9LM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZPkzCp+lrE1oVYfZezy6p53BI95WhyzydC1uwLmQ/Y+7Q+JvfH/b+EI7Xn2ubvD4JiP/CfCjjCLC4/vtqRoTmQpnvnjRtnFT2LsZ3hfD4znHLyEDFL02OCwyDcM6Qselp45bl8XUT6zS4TXhXnDvE8H3fKGvq/TKhD8PgzBxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzgEqIGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzgEqIGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6151F000E9;
	Tue,  1 Sep 2026 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282396;
	bh=Hlgkv0a/qESlNEL589Z/SOQUanjyypYoQUmoGklm0mA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lzgEqIGSAuAx+3j8eziYJvV0/lI54NPsJ9kVCpQs4HJIjfLTAEEQx83fxHDCChUjQ
	 5vzu3vniSAAv9Dq0pdO/OCqeqaNhf+oipcbxpbcHf+U7BCk//0bwunFkotkOKgNA/V
	 UMaARE2N6SnYeLfT5D5QIk2bR90e78FFGRRo90pSCCO+QdepmlZU+rXX6W5Dn9KRJq
	 ZzOm8KJPU8OfCNeLrBxABbUiBNzXnpK+qt+hn4rs5jSC0+KJ8YLWA5Y8l9KYkWi/sT
	 o/ZhXBOKbxJszgsf0hTF8Dcn6xQicDiBcGT8PMWaR5biDEjIraY1sg5hvzVs6vcGct
	 Dg2TI1jnxK4lA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 04/18] selftests/bpf: Test helper support
 for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260901165757.801449-5-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:06:35 +0000
Message-Id: <20260901170636.7A6151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect format specifiers `%d` used for unsigned `__u32` variable=
s when formatting BTF_KIND_LOC_PARAM and BTF_KIND_LOCSEC.
--

commit 775b46a26f73799ae68ad5737114128e343d1d80
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]

Add support to dump, encode and validate new location-related kinds.

> diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/se=
lftests/bpf/btf_helpers.c
> index 1c1c2c26690a7..6065ee4ba00a6 100644
> --- a/tools/testing/selftests/bpf/btf_helpers.c
> +++ b/tools/testing/selftests/bpf/btf_helpers.c

[ ... ]

> @@ -203,6 +206,37 @@ int fprintf_btf_type_raw(FILE *out, const struct btf=
 *btf, __u32 id)
>  		fprintf(out, " type_id=3D%u component_idx=3D%d",
>  			t->type, btf_decl_tag(t)->component_idx);
>  		break;
> +	case BTF_KIND_LOC_PARAM: {
> +		struct btf_loc_param *p =3D btf_loc_param(t);
> +		__u32 *v =3D (__u32 *)(p + 1);
> +
> +		fprintf(out, " size=3D%d flags=3D0x%x vlen=3D%u", t->size, p->flags, v=
len);

[Severity: Low]
Does this format string interpret the unsigned __u32 t->size as a signed
integer? If t->size exceeds 2^31-1, it could be printed as a negative number
here, which differs from how other BTF kinds format their sizes using %u.

> +		for (i =3D 0; i < vlen; i++, v++) {
> +			if (p->flags & BTF_LOC_PARAM_SIGNED)
> +				fprintf(out, "\n\tvalue=3D%d", (__s32)*v);
> +			else
> +				fprintf(out, "\n\tvalue=3D%u", *v);
> +		}
> +		break;
> +	}

[ ... ]

> +	case BTF_KIND_LOCSEC: {
> +		const struct btf_loc *l =3D btf_locsec_locs(t);
> +
> +		fprintf(out, " vlen=3D%u", vlen);
> +		for (i =3D 0; i < vlen; i++, l++) {
> +			fprintf(out, "\n\tfunc_type_id=3D%u loc_proto_type_id=3D%u offset=3D%=
d",
> +				l->func, l->loc_proto, l->offset);

[Severity: Low]
Similarly, l->offset is defined as __u32 in struct btf_loc but is formatted
with %d. Should this use %u as well to prevent large offsets from appearing
negative in the output?

> +		}
> +		break;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D4
