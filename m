Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902619;
	b=zPGtMlOQkyVkGtiAyHDwL7CcSNCQ2YKAM6IsT9AD/hnCIaBR8kzNhQGM5CcCzdOiMGq3
	 6LtZmCLevnF5RIB+seu4eC0QsjarnqYg6DmMi/90N9BmBkpvtQX2dDwOY9KO3vGrPrn99
	 z1CMDYV3xxbbgRkq420MSFSy84nrBNZgraljYiFHQOLAvAEl7WklfKjp9veEURDPBNJ7c
	 HEg66OijbmgFTDCy0gTvDhNW6TgYjPRVFRdkhKForrFgqIuGKSz1HmFqs3/87AfHmNnTG
	 Vq/F8eZoXIbhHspDCSP1KL+XO192KNT2VZFL3G4yPMaGBF1SKMrv6rRZTa37TGhOL0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yIiVETiccds2zLkjCiKuZlUeMe9lENg+8cWHsJoSEm8=;
	b=RZU53+j4ey4vKJ11clfNq+N/CvKagyIDq5AMi13B9yP8+UaD1uWyUrLvaNY20VE8E2sw
	 rtCz6Zp5wAedz0Ns009j9wNWqtJ/zd6HOaaxIa64HXNZXcsmIP4F464zBqJeg4e8DZHly
	 gcdtr5K4hf7Es03y8FSHc49StglnQEgZlpJwtyuAA2sra1gigOkSBXJ3jwm1R4s0eRUEf
	 Hoy/z1iKG3Zrjk1klnYFUrpMr3vzLbhT5cufC4L3Egrq5J5MmKotxKcROTwnoXjIMzXLm
	 HK0hosYNz6qYYbOfvimvLf3E+bnuUhCrdOfmIx5kOHtkf/C51+jlGhdzPLLhhDScRfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYSvWhVL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62662606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GYSvWhVL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77B21F00A15;
	Thu,  5 Nov 2026 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902619;
	bh=yIiVETiccds2zLkjCiKuZlUeMe9lENg+8cWHsJoSEm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GYSvWhVLCoKWr2jvxHKs8hJ61YwzYjyq3fExwViVV4PLHv9lSFsmKPekmjj2/U7ri
	 XdgPsWChBga1wLo7eZhV7tss5U1v74ZSW6ORx/pZXasJj2Xq5E+HB81oUupaTUTpYz
	 caB8qCdg3szXI2gBCkG/pS0GpsHJCAr9a/RlaoMP0SygzMuUmxDC2p3i1wHcutqfjc
	 tj3GIXlEg/f/GpQutM3kcCYzrg79F/wdqBrMtsvmuGo4dvTh95O/wbMGH0CmXi3iM+
	 SOTkGHVBWeh0kUFwnEA2VQSsPOImwf5+VGWVwWERmh1Nlk1MKnVmbnqb23z3WlIBfn
	 /XYVNUAY3nFgA==
Message-ID: <sashiko-outbox-199716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 07/17] libbpf, bpftool, resolve_btfids: Dump
 kflagged BTF tags as is
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261105175845.30357-8-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
 <20261105175845.30357-8-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:16:58 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: changing kflag BTF_KIND_TYPE_TAG format breaks C dumps acro=
ss versions
--

commit 02905c14788165a6bc8db8f66ae9bfa227c2d55a
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

libbpf, bpftool, resolve_btfids: Dump kflagged BTF tags as is

This commit changes btf_dump to print kflagged BTF decl and type tags as-is
without wrapping them in __attribute__((...)), updates resolve_btfids to
encode the full __attribute__((address_space(1))) string in TYPE_ATTR_ARENA,
and adds a split-BTF decl tag override in bpftool for older kernel BTF.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 5ad5473563034..c16dd93fa6d4c 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -204,7 +204,7 @@ struct btf_links {
>  #define KF_ARENA_ARG2	(1 << 15)
>  #define KF_IMPLICIT_ARGS (1 << 16)
>  #define KF_IMPL_SUFFIX "_impl"
> -#define TYPE_ATTR_ARENA "address_space(1)"
> +#define TYPE_ATTR_ARENA "__attribute__((address_space(1)))"
>  #define PARAM_SUFFIX_ARENA "__arena"
>  #define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
> =20
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index c12c3c248407f..fcd97aa905897 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1023,7 +1023,7 @@ static void btf_dump_emit_decl_tag(struct btf_dump =
*d, const struct btf_type *t)
>  	const char *name =3D btf_name_of(d, t->name_off);
> =20
>  	if (btf_kflag(t))
> -		btf_dump_printf(d, " __attribute__((%s))", name);
> +		btf_dump_printf(d, " %s", name);
>  	else
>  		btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", name);
>  }
> @@ -1602,7 +1602,7 @@ static void btf_dump_emit_type_chain(struct btf_dum=
p *d,
>  				break;
>  			name =3D btf_name_of(d, t->name_off);
>  			if (btf_kflag(t))
> -				btf_dump_printf(d, " __attribute__((%s))", name);
> +				btf_dump_printf(d, " %s", name);
>  			else
>  				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
>  			break;

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v3 [1], changing how kflagged
BTF_KIND_TYPE_TAG entries are encoded by resolve_btfids and emitted by
btf_dump_emit_type_chain() causes regressions when dumping C headers across
versions.

In tools/bpf/resolve_btfids/main.c, TYPE_ATTR_ARENA is changed to
"__attribute__((address_space(1)))" and passed to btf__add_type_attr() in
arena_tag_ptr(), which encodes the full attribute wrapper into vmlinux BTF =
for
arena kfuncs. When an existing bpftool built with libbpf 1.6 or later dumps
vmlinux.h from a newly built kernel, its btf_dump_emit_type_chain() wraps t=
he
kflagged type tag in __attribute__((%s)) again, emitting:

  void __attribute__((__attribute__((address_space(1))))) *

This breaks compilation of any BPF program including vmlinux.h unless
BPF_NO_KFUNC_PROTOTYPES is defined.

Conversely, in tools/lib/bpf/btf_dump.c, changing btf_dump_emit_type_chain()
to print kflagged BTF_KIND_TYPE_TAG strings without __attribute__((...))
means that any external caller of btf_dump__dump_type() or
btf_dump__emit_type_decl() outside bpftool (which does not run
btf_c_annotate_type_tags()) will emit bare address_space(1) when dumping
existing v6.16+ kernel BTF or BTF produced by pahole with
--btf_features=3Dattributes, which also fails to compile.

Since btf_dump already allows a kflagged BTF_KIND_DECL_TAG (with
component_idx =3D -1) in the dump split BTF to override how a referenced
BTF_KIND_TYPE_TAG is printed, could btf_dump_emit_type_chain() and
TYPE_ATTR_ARENA in resolve_btfids be left unchanged, and raw printing be
restricted to kflagged BTF_KIND_DECL_TAG in btf_dump_emit_decl_tag() as
requested by Alexei Starovoitov on v3?

[1] https://lore.kernel.org/r/b8912e062900f51fd8c8f44c44ef43d0788ce6af12582=
abc0060dd6cd4c05065@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105175845.3035=
7-1-ihor.solodrai@linux.dev?part=3D7
