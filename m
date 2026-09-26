Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB6639CCED
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790467176; cv=none; b=ZETpZqZBsMnfVWKbrPA8KNok73PRJF3d0gGaEHZHbTufCkX6m5CP0/MYCOetaiYp2lX9wQW8QLJr64+5c2HBYXaf+eL27FkXU5RIMPOgsCKue+re4TiByQGLu4kR0cwUhSDt62MegQsLdO7Rv4EhFptym3lr0h+qGi/B5vcjmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790467176; c=relaxed/simple;
	bh=m2MqmzD08qgD+9S0NAlLS6onslEAlPCR6igK5NcUvLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fNyHqqpDq3/6UwDsvi6G2+WgJY5Nu8y0FbiCgfwe9tx4DoPr1vPl02j25I4Zp837kuxkMQjiuoFE9BFwLxHlHkFr/OO/UP5I2C10CTSDTxzLizX48Vb28yslJo8/EKpg88CWvM0OfTu+jlZ3lTocHBaGq9Y1YJ51loNq70Cmo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqPLvRq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqPLvRq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C4E1F000FF;
	Sat, 26 Sep 2026 23:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790467174;
	bh=9g+wUfsxtwxGG08rPe2CG5u0ld7CWiMWuLyRvYMYP3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aqPLvRq59TcPRttVE0Cz50BidqsmgfYmODMvj61XY+R4B0Y706W0BEM90IFiXGhJQ
	 3b5FRQECYcSAnwtnZ6T16eQeHQKM0p6PMi9v64qpjh9SFcQS7xvPjBJ2fnzbMmbeAo
	 7IBBz7eA4MErsU1RJOxtZh3wdqPA6QzZBQb+4WydFrKTWNQrbG4UWdOQlq4bd2Axbp
	 V6q8GoNqMgP3bDdq9dwlRHmrK3LguOUzoka2dN3BS6SY+9DfYQnckBIEu9gfwk697f
	 NHPcwY8o78dORbx9ElvJ9yl+FASZrNVt0tZJ/YtJLYMt+W4ZSfAq5JglUwfMXq4wCo
	 mZVTyy7pr4C3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 06/16] bpf: Support special fields in
 typed arena objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-7-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-7-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:59:34 +0000
Message-Id: <20260926235934.B6C4E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: bpf_kptr_xchg allows user-space to forge kernel pointers =
via typed arena memory
- [High] bpf: bpf_kptr_xchg on arena pointers causes kernel panic on archs =
lacking inline support
--

commit 2d0dbe5c6fd18e1e3096285d4ab48687f876b4ce
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Support special fields in typed arena objects

This commit allows bpf_kptr_xchg() to take a pointer to a kptr field of a
typed arena object. It modifies the verifier to permit objects in arena
memory to own references to kernel objects and program-allocated objects.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 75697e52a2df6..f854d8419fff0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -8063,7 +8063,7 @@ static int process_kptr_func(struct bpf_verifier_en=
v *env, int regno,
>  	struct btf_record *rec;
>  	u32 kptr_off;
> =20
> -	if (type_is_ptr_alloc_obj(reg->type)) {
> +	if (type_is_ptr_alloc_obj(reg->type) || type_is_typed_arena_obj(reg->ty=
pe)) {
>  		rec =3D reg_btf_record(reg);

[Severity: Critical]
Does this allow user-space to forge kernel pointers?

Because arena memory (BPF_MAP_TYPE_ARENA) is inherently shared between the
kernel and user-space, it can be mmapped with PROT_READ and PROT_WRITE.
Furthermore, arena maps lack a map-level btf_record (it is NULL), which
bypasses the standard check in bpf_map_mmap() that forbids mmapping maps
containing special fields.

Could a malicious user-space process mmap the arena, write an arbitrary
64-bit value to the offset of the kptr field, and then have the BPF program
call bpf_kptr_xchg() to read this user-supplied value? The verifier would
unconditionally track the returned value as a trusted kernel pointer.

Could this forged pointer then be dereferenced or passed to bpf_obj_drop(),
leading to memory corruption or KASLR bypass?

>  	} else { /* PTR_TO_MAP_VALUE */
>  		map_ptr =3D reg->map_ptr;
[ ... ]
> @@ -8834,6 +8834,7 @@ static const struct bpf_reg_types kptr_xchg_dest_ty=
pes =3D {
>  		PTR_TO_BTF_ID | MEM_ALLOC,
>  		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
>  		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU,
> +		PTR_TO_BTF_ID | MEM_ARENA,

[Severity: High]
Could this cause a kernel panic on architectures that lack inline support
for ptr_xchg?

On architectures that support arenas but do not override
bpf_jit_supports_ptr_xchg() to return true (e.g., PowerPC and s390x), the J=
IT
will fall back to calling the bpf_kptr_xchg() C kernel helper.

The bpf_kptr_xchg() helper uses the raw xchg() macro on the provided pointe=
r,
which resides in demand-paged arena memory:

kernel/bpf/helpers.c:bpf_kptr_xchg() {
    ...
    return xchg(kptr, (unsigned long)ptr);
}

If the accessed arena page is unmapped, a kernel page fault occurs. Because
bpf_arena_handle_page_fault() is only wired up in the architecture-specific
fault handlers for arm64 and x86, it is completely ignored on PowerPC and
s390x.

Since the xchg() macro lacks an exception table entry inside the helper,
wouldn't an unmapped arena page result in an unhandled fault and a direct
kernel panic?

>  	}
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D6
