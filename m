Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258F443E4E
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567111; cv=none; b=uBrx5x+VuDFDY4FTZVWJ5rWpT82RCxPdYWI9Oy1XTpG3qkoxaiBbCmEKdfvJoKzoNw/x6HGO8QIxMtFn/TF5jtJpqhRKBWB2vn/0ptrHaSkVqyTAk+SbjJtDwR/h39BEDAQWkdFinQqKBa0ssGzd1FdtfrZ/ugNWffAmDm/Yl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567111; c=relaxed/simple;
	bh=p63SB3OchU4aa22zvNKUA56KEtBToPDC9J+QYJC933s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q9LKNqiZyMVtsCFy7fvH7WreWlbk6GxYAW2Pl1ni/BPP5yw0YGVVUT3tAU4Z76YqpKRqIno7dQOKvYMo1KpIQ9vybvCoN5eQyEBMgPcmGFSyPhrXsbW/g+LrhJM7ZJe11E+m7NskdcEjGPpksqcrvWqUz76QfxrgWvU1p9jFE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO8YkSLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO8YkSLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA8C1F000E9;
	Mon, 20 Jul 2026 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784567105;
	bh=+IINyjFrklJ7x6DJK1BbaJtavjQ9RiOwqYPpy3P68sM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iO8YkSLap0KZ1gpLwyyU5zp3X1WIPHGFQZ9d0AyY+SxvjPE7L2o+x8am3HxZFW0Y9
	 2GAWm8AqcCzqGB68BU842w3hOgnXM04EqBaBJaKJoL3xiaAy0PKd21IboXbXE1s/oG
	 2GMDgreJXylZ0VOFIkXc9OSC1zwa+5X0gcQz5Avs0jnXXNp+54CMIgnkZHGqWNvPPk
	 aOJpkV7YcnoTFdInUxVYhNujtAVLTTOmRJLszZtSURWUdgFBdAyprJfzjJTWJxap0m
	 j4QrysE07WSRcoQlmuIb6pyJj4y6Bt9H7N7Q0cx78xLSd1t7LvaW5P9eJq92zc8+xD
	 RbhgXHGDQkyAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve stack frame number for
 commuted arithmetic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <fee8d44c3c792e29b8898951a68c8313d9d2da53.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
 <fee8d44c3c792e29b8898951a68c8313d9d2da53.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 17:05:05 +0000
Message-Id: <20260720170505.9FA8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing inheritance of `parent_id` in commuted pointer arithmetic =
(scalar +=3D pointer) allows derived pointers like dynptr slices to escape =
reference invalidation, leading to a Use-After-Free.
- [High] An early return for untrusted pointers during commuted arithmetic =
leaves the verifier state desynchronized from the runtime state, allowing a=
rbitrary kernel memory read/write.
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf: Preserve stack frame number for co=
mmuted arithmetic ---
commit e1439595e89ba75141d297320a4a5530c2e2c8ce
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Preserve stack frame number for commuted arithmetic

When scalar +=3D pointer is handled in adjust_ptr_min_max_vals(), the
destination register inherits the pointer type and id from the source
pointer. For PTR_TO_STACK, the inherited pointer state also has to carry
the stack frame number.

Without the frame number copy, a stack pointer derived inside a callee
through scalar +=3D fp can be recorded as pointing to frame 0. Stack reads
and writes through that register can then update or consult the caller
frame while the actual instruction uses the callee frame.

Copy the frame number when PTR_TO_STACK state is inherited by the
commuted arithmetic form.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce0..58017141d52b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13796,11 +13796,14 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
>  		return -EACCES;
>  	}
> =20
> -	/* In case of 'scalar +=3D pointer', dst_reg inherits pointer type and =
id.
> -	 * The id may be overwritten later if we create a new variable offset.
> +	/* In case of 'scalar +=3D pointer', dst_reg inherits pointer type, id,
> +	 * and for stack pointers also the frame number. The id may be overwrit=
ten
> +	 * later if we create a new variable offset.
>  	 */
>  	dst_reg->type =3D ptr_reg->type;
>  	dst_reg->id =3D ptr_reg->id;
> +	if (base_type(ptr_reg->type) =3D=3D PTR_TO_STACK)
> +		dst_reg->frameno =3D ptr_reg->frameno;

[Severity: High]
This isn't a bug introduced by this patch, but should we also copy parent_id
here?

During commuted arithmetic (scalar +=3D pointer), the verifier transforms
the scalar destination register into a pointer but fails to copy the
parent_id from the source pointer, leaving it as 0.

If a BPF program obtains a dynptr slice (PTR_TO_MEM with parent_id tied
to the dynptr), performs commuted arithmetic (scalar +=3D slice_ptr), and
then releases the dynptr (e.g., bpf_ringbuf_discard_dynptr), will
release_reference() skip invalidating the commuted pointer?

release_reference() looks for matching parent_id:

kernel/bpf/verifier.c:release_reference() {
    ...
		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
			if (reg->id !=3D id && reg->parent_id !=3D id)
				continue;
    ...
}

Because the commuted pointer has a parent_id of 0, could it escape
invalidation and be dereferenced later to read or write freed memory?

[Severity: High]
This is a pre-existing issue, but does the early return for untrusted
pointers in adjust_ptr_min_max_vals() handle scalar +=3D untrusted_ptr
correctly?

Earlier in adjust_ptr_min_max_vals(), we have:

kernel/bpf/verifier.c:adjust_ptr_min_max_vals() {
    ...
	/*
	 * Accesses to untrusted PTR_TO_MEM are done through probe
	 * instructions, hence no need to track offsets.
	 */
	if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type & PTR_UNT=
RUSTED))
		return 0;
    ...
}

If a BPF program executes scalar +=3D untrusted_ptr, check_alu_op() invokes
adjust_ptr_min_max_vals() with the scalar as dst_reg and the untrusted
pointer as src_reg.

If the early return succeeds, it returns 0 without modifying the
destination register's type. Does this leave the verifier tracking dst_reg
as a scalar, while at runtime it becomes a pointer?

Could a program then use this register as a forged index into an array or
map, bypassing bounds checks?

> =20
>  	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
>  	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784563939.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
