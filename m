Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DD38AC6A
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237072; cv=none; b=PgawzjH1WBS4IzuCqtukzx+cfyxKxkNo31rTPaGzYEdgGCH3JFPclHPewWuVfwyp5GNm3dZPwL4/CyGfgfl1j1LAbzgEeA90Al1/a266tkqXpcE0h6SGgnIIuOxUgK/KD03EdxhKHfrYvmL1rUL0HBM+ED3/Xb6v8f9+sGtzT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237072; c=relaxed/simple;
	bh=I03hV+fsgw+YxmWiCxILqTvV5u33B4Ch2JpW2sVzy/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NFtj9uhTD4wBjJ49IYg2+qkB8Sg4Pf4s5ka+NA/NYxoBp2pQoi0sMikyQtQ16xRnZB41PZ/0PLr/Sf7yMvM2Z2HFMItDZvqa4IcdvMRDTXiJWMnzLxRtVIbfI39hz4uJLlIw4JrdWw6YNDi6lI9ay/Kj5iYg06Vr/nFrHVfm+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyg3zadU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyg3zadU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F761F000E9;
	Tue, 23 Jun 2026 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782237071;
	bh=Ozb3F8oVd5jbUEDxKtCURWmYKC2VOw0iPWMTGPYvyKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tyg3zadU7lvCRfiQaE0vuPxlLbVI1n3JkRdVxPXzJTLgy9Gyx0NxFxQ9u1jVXSYH9
	 tFdyE3XHaZOMkPOa4ioKP755BM786ql0aIBuP7MR4zuQkNnHTC3MizzWrmHQmYYy0q
	 JLZcOUTW6aiJ0b/6nK4FhF0tA9C4JXjPHJkefh7Wf+GCXO8fmO4peDeAYSTuRkrfrL
	 U1sq9Ei6vaB3Xs0f2TTNTuHqyg7vrBpDEvelRcsSzCgzzA+2rYtH6iE//r3obkdnpu
	 IVUrfD9GCNgXvqoogqQBcnwGlA38xQhLroYSIK8FERGcvjuqbMR2ovYrhhRhWEIwcJ
	 0ZPAcNjSeRjfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject MEM_ALLOC BTF accesses past
 object bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <703a2cbfeb17ae707fa4a003b795c5326cc0abb8.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
 <703a2cbfeb17ae707fa4a003b795c5326cc0abb8.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:51:11 +0000
Message-Id: <20260623175111.60F761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] btf_struct_ids_match() hardcodes `is_alloc=3Dfalse`, bypassing the=
 MEM_ALLOC bounds protection and allowing out-of-bounds kfunc accesses.
--

commit ea4066197ea8dc72df56252849c8752b81c506d6
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Reject MEM_ALLOC BTF accesses past object bounds

This patch modifies the BTF struct walk logic to reject memory accesses past
the object bounds when dealing with MEM_ALLOC objects. It disables the
trailing flexible array relaxation for these allocated objects, keeping
verifier-approved BTF accesses strictly within the bytes provided by the
allocation kfunc.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15ae7c43f594b..3e68af9c1a5eb 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -7441,7 +7445,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *=
log,
>  	type =3D btf_type_by_id(btf, id);
>  	if (!type)
>  		return false;
> -	err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL);
> +	err =3D btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL, false=
);

[Severity: High]
This isn't a bug introduced by this patch, but hardcoding false for the
is_alloc parameter here completely bypasses the newly introduced strict
bounds check for MEM_ALLOC types during struct matching.

Can this allow a BPF program to obtain a pointer to unallocated slab memory
and pass it to a kernel kfunc or store it in a map kptr?

For example, in kernel/bpf/verifier.c:check_kfunc_args(), it calls
btf_struct_ids_match() with reg->var_off.value without conveying that
the register possesses the MEM_ALLOC flag:

kernel/bpf/verifier.c:check_kfunc_args() {
        ...
        struct_same =3D btf_struct_ids_match(&env->log, reg_btf, reg_ref_id,
                                           reg->var_off.value, meta->btf,
                                           ref_id, strict_type_match);
        ...
}

A similar path exists in map_kptr_match_type() when storing into
unreferenced kptrs (where strict is false).

Does btf_struct_ids_match() need a way to know if the register type is
MEM_ALLOC so it can properly apply the bounds protection here as well?

>  	if (err !=3D WALK_STRUCT)
>  		return false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782197377.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
