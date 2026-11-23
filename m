Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474345;
	b=o+Z9f2taju0MjCguncs9DVKc5F63yA9//zmQY3+b55jQQXyPBfMJEjEaCeHAfPH/dhjO
	 aTYZc+fFR6FPhD2vsJheg2AZunZmkADlZ5gJC+WzOn0+mIeOi6LxVH4vXPOjuWB3syYjE
	 iyM3wfO6i1ZghjnASUOOObfaEeSGC8sOx0F7G6UbvNQSUt/wOwsJsgPdLAd+/GPE8YuNz
	 UA7Vmvy65Ru7dCxGjIW2cGexr+LRccx5Zw6ok6PCx1v3A0Q/SIMKBXrxqrH4HNFH1w7Yh
	 PtyvX2pBSq/K/m9j8txctnYOHOwBBdYQv4a5mlVohD06fI2cTKg2ZCemVfpvirL1Rew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474345;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d+VtIv92QBhQ398hTZEBec1WPJGvJbnc/7KUWoX15Y4=;
	b=y2Tf0W455aYUOZi3ZB+hdOwY6qmy8V6G0g4dyEm3g7b0f8BIFbmJjqValPjPW8FDAfmC
	 0EszBKtIkFUcqio0ofmfurOjQkRy4aUlUr4yiLCCa+mleU/rPWX4aJAWsxfAYUhUtrtUz
	 LhtiYMHEfU+eVqQHHXAlI3URFxIxp8hKahKnkA+CdVQU+rvSfxHOqQ6EoYQBrtNpI9Dpc
	 9XsLMErPzAWQUyiRhoiydLGAMn6Irdc52JbBkTrEE+iK9xQrgaqAkOtZlS+8WOy5xGpCn
	 WePLE3Qm1HlPUmwG3RpxTkCaU6aaZCRjQ4HNw65ThAxB4d1gON+/ET2JewV2cOgLfrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUPbPqwQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38495606A331
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUPbPqwQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2C41F000F2;
	Mon, 23 Nov 2026 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474344;
	bh=d+VtIv92QBhQ398hTZEBec1WPJGvJbnc/7KUWoX15Y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUPbPqwQyg6p0GJMbKXmRPqLWh+BcK0zgM9L64gmRRq9Yu3sWksLgoyf83b9xEqjD
	 j2PdjABA/SSbQko6ahMktf1mNBP+EdxkqhpKF0/YupvuEeEvwjW2HsSP/0SOqqPQs/
	 45KTN4PuJ8hDQMX8GnZtpV6yaULDCwSSI78d7CnTgWRhxS48LsZPLCbKj5RXfJ++7J
	 ujGmMbNh6swGWW1eCYXVwPPgjStF74jyYydz1jT2ZT/VlpDtcRCaGuWQ816qzUx8eY
	 fTz/ZLWqOKdyQClRTnnjCK0zES6VcRxT+T37BOUupZZgy+1jL7Lhqb1X3rDHB/54JB
	 SzaNx11b3n+sg==
Message-ID: <sashiko-outbox-230161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/7] bpf: Support CO-RE relocation of tracing
 program arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <almagui@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123223227.745345-3-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
 <20261123223227.745345-3-almagui@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 22:52:24 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: quadratic BTF type scan in bpf_core_apply() via
  bpf_core_is_func_args_type()
- [Low] bpf: non-standard multi-line comment above
  bpf_core_func_args_cand_prog()
--

commit fb7674aa7cef4ed7e344622061c7c9391f5b51c3
Author: Alan Maguire <almagui@kernel.org>

bpf: Support CO-RE relocation of tracing program arguments

This commit passes the BPF program being loaded to bpf_core_apply() so
that CO-RE relocations against function argument structs can be resolved
against the program's attach target.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c4386a9a1ad41..f93ed8908d655 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -10709,11 +10709,39 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u=
32 local_type_id)
>  	return populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_=
SIZE);
>  }
> =20
> +/* Function argument structs (see __bpf_func_args in libbpf's bpf_tracin=
g.h)
> + * are matched against the parameters of the program's attach target.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style puts the opening /* of a
multi-line comment on its own line.

[ ... ]

> @@ -10734,6 +10762,16 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, con=
st struct bpf_core_relo *relo,
>  		return -EINVAL;
>  	}
> =20
> +	if (need_cands && ctx->prog && bpf_core_is_func_args_type(ctx->btf, rel=
o->type_id)) {
> +		/* no locking needed, prog holds a reference to attach_btf */
> +		need_cands =3D false;
> +		err =3D bpf_core_func_args_cand_prog(ctx, relo_idx, &func_args_cand);
> +		if (err)
> +			goto out;
> +		cands.cands =3D &func_args_cand;
> +		cands.len =3D 1;
> +	}

[Severity: Medium]
Does calling bpf_core_is_func_args_type() here introduce a quadratic scan
of ctx->btf across CO-RE relocations?

bpf_check_core_relo() sets ctx.prog for all program types, so
bpf_core_apply() now runs bpf_core_is_func_args_type() on every relocation
where relo->kind !=3D BPF_CORE_TYPE_ID_LOCAL before consulting
vmlinux_cand_cache:

tools/lib/bpf/relo_core.c:bpf_core_is_func_args_type() {
    ...
	n =3D btf__type_cnt(btf);
	for (i =3D 1; i < n; i++) {
		t =3D btf_type_by_id(btf, i);
		if (btf_kind(t) =3D=3D BTF_KIND_DECL_TAG && t->type =3D=3D type_id &&
		    strcmp(btf__name_by_offset(btf, t->name_off), BPF_CORE_FUNC_ARGS_TAG)=
 =3D=3D 0)
			return true;
	}
    ...
}

Unlike libbpf's bpf_core_resolve_relo(), which checks its candidate cache
by local type ID before calling bpf_core_is_func_args_type(), this scans
all types in the program's BTF on every relocation (and btf_has_decl_tag()
does the same per matched argument), turning in-kernel CO-RE relocation
into O(nr_core_relo * btf_nr_types(ctx->btf)).  In the kernel, program BTFs
already pre-link decl tags in btf->next_tag via d01bec4218c7 ("bpf: Link
the decl tags of a type"), so walking that chain (or using
btf_find_decl_tag_value()) would keep tag lookups O(1).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123223227.7453=
45-1-almagui@kernel.org?part=3D2
