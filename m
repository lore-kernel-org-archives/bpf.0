Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92274299A82
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625920; cv=none; b=rB5OKpbhQB8a8Bj4bPJlAE6xn49E1rcPZCl35bdovAIfnr/n7Liv3KX9cXp26ok58iGhjPJ8ZTlW8jS/rmU9ntrv++4jjhSoQEpJ8Lp4b272w4rKxLr2pZgwOYQctGZsGf1XZYb20SamychFUrDP/0h0pJMUonraGuo6vgEVN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625920; c=relaxed/simple;
	bh=Ix2GOzGCyiIhyKT7bbCLr+W9jSeP4A5LMvutgLVT3Ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=feo9hqb65rmLeMfOTPK2s/PzEHR6k1nzsPPE9V9IxTUVtUTIW7nHPrIdngsANp+qm/PTTKObX7tENodYphHFwb/HMhTM7CCuDofBoMtc75P95alM1EbRAo01gxhovzFBqnH2ziqC2TDwC844iAOz5m9LDGkeIRsYOhM+8uXZ5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvi/c57A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvi/c57A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F013C1F000FF;
	Thu, 17 Sep 2026 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625919;
	bh=/j+iHyWfLM7hqTCdOdo6pZ3NNjoW5H0lim6FRR/cpSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hvi/c57A9k0U40mJC+urZNutQhAHx3zh1gmCEyDSjxfVtffO8IGAlCwkCR9Pc2ONq
	 jb4QsLAjxkMnmL0TR1CGEODgAugaMtw2+8V4PK3PUTyj2M3WBJ9Q+OwIusBvkyHOgk
	 vpwK8aRrJZvkrLVYUXYT4VEj6AZFhmenzC8boO37RvdWqAIdEtbMjLHOJI5b7uDo7S
	 gBavTfU1MgB+HXqEqDahZNZeXPnTYMruXEwZ1YNtX7K2aN0tqDPK6Rf3H1hVX9EI/y
	 MkLz90zlsUTj6qqAytS24aJx7Pr75hxrj+jw+NdWMp+vShKntXst8sl4S7JwL2k7xC
	 T2FxwCH5RDvUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 16/20] libbpf: Carry the exception cleanup
 table through the light skeleton
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055807.3934205-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055807.3934205-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:18:38 +0000
Message-Id: <20260917061838.F013C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] libbpf: unconditional cleanup_info emission breaks backward compat=
ibility on older kernels
- [Medium] libbpf: integer overflow in cleanup_info size calculation leads =
to OOB read/write
--

commit 076a2794e54df3a939c1a2aebf4467a8a0af5e41
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Carry the exception cleanup table through the light skeleton

This commit adds support for carrying the exception cleanup table through
the light skeleton during BPF program loads. It expands the bpf_attr union
to include cleanup_info fields and handles endianness byte-swapping for the
records.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index af3a04f161ac1..e9bb282a557a3 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
[ ... ]
> @@ -1011,8 +1016,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>  			       load_attr->line_info_rec_size;
>  	int core_relo_tot_sz =3D gen->core_relo_cnt *
>  			       sizeof(struct bpf_core_relo);
> +	int cleanup_info_tot_sz =3D load_attr->cleanup_info_cnt *
> +				  load_attr->cleanup_info_rec_size;

[Severity: Medium]
Is there a risk of integer overflow here when parsing untrusted ELF files?

If load_attr->cleanup_info_cnt is large enough, the multiplication with
load_attr->cleanup_info_rec_size could overflow the 32-bit signed integer
cleanup_info_tot_sz, resulting in a truncated heap allocation.

Later in info_blob_bswap(), the loop executes load_attr->cleanup_info_cnt
times:

info_blob_bswap() {
    ...
    for (i =3D 0; i < load_attr->cleanup_info_cnt; i++)
        bpf_cleanup_info_bswap(ci++);
}

Could this lead to an out-of-bounds memory read and write over the
truncated buffer, potentially causing memory corruption in userspace
tooling like bpftool?

[ ... ]
> @@ -1085,6 +1101,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>  	/* populate union bpf_attr with a pointer to core_relos */
>  	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos);
> =20
> +	/* populate union bpf_attr with a pointer to cleanup_info */
> +	emit_rel_store(gen, attr_field(prog_load_attr, cleanup_info), cleanup_i=
nfo);

[Severity: High]
Will this unconditional emission cause light skeletons to fail to load on
older kernels?

By unconditionally writing a non-zero pointer (the offset in the data blob)
into the tail of the BPF attribute structure, older target kernels that do
not support the cleanup_info field might reject the BPF_PROG_LOAD syscall.

Because sys_bpf verifies that all fields beyond its known sizeof(union
bpf_attr) are zero using bpf_check_uarg_tail_zero(), it seems this could
fail with -E2BIG. Does this break backward compatibility for all light
skeletons running on older kernels, even those that do not use exceptions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D16
