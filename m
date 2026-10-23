Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792361;
	b=a00Tlly6h30gDLOoANufxoPJvO0JAp3N64doutpo+jQ7BS7UaYRWskF6SnDn4KUqz7k2
	 PmsQqGf/tA65jrbY5yaOh5KT8lFyN4qdiNBvlYaljainLHlPjRAJ4Lqkt3UyERkZzClR7
	 KaQDEl+AhdDnxMd1eEO81wl0OD4Ty3v+oJVK+rCaixt5cHyRyAyqGnTnQRjo6nPBvjZpB
	 tQH94LoiwTAW1ilCOqFkiZl0k6ui5Kve8myOEz5RVPOCQ/2X42aCJTGTYjdN/2acgy49M
	 mTAZDeDgWYEB8YRz/3GKx/oXEaVsyjmkgiCE3wVamDR0aDfdSbJMBiPTEazcNdOGnSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ApQ4cefWNqlNnQY8ZpeeiZZTqkahMNzeIzWJ3YtXoVY=;
	b=jVnpAL7eDMXvf6XaEriBkMPB3XmiWrhRELhUxyFOEAf9F0Fpglj8MphuelSMu1dZyf/m
	 L2ZG/Hsf2Jt7WqpQQ7EIjEF2TB9cIs7D/lFFKynutggII+VlabnuCQ6Lito6ioIuhX5Xt
	 CigaDIdPnNnhR9lcyyC2h628D0CI5tw4lFuVDYJS40OyFP+hVabMY8JZw/ABkPuvYSyUO
	 5HqiqEV/Ff97sI8HiHpVnk1xBbiPicOZg+63AUln21hLO63OjbNaxdoxfL+gDf5FohuFL
	 vo9T6OAYhsRjwtgr6Gaatv28Nxib9tlePY5GJW1DqhTeiOgaGj63k2irC2heazUVXjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAETnXLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0A9606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAETnXLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21F1F01825;
	Fri, 23 Oct 2026 21:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792792360;
	bh=ApQ4cefWNqlNnQY8ZpeeiZZTqkahMNzeIzWJ3YtXoVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LAETnXLkZ1jHCHCfy3tbYYOEIKYGDtFfYsYZKM6B/eBohlVAkdv/lRWmEfhrtQA+o
	 VP1XpGQ3aTYqy8YpIN5H7S26n67D3hEya/S1U7oiANSqYI3F0u5U0QozpaeqEr1Q/A
	 MPpurfhOlf3wEH6i2cc6ORzhBl8WJ/JLFp+iqpW5v5I/9sU9w/9Y6ZMlCouSGNST3/
	 fMrzzGgjTgoja8k8KH0ft6c8JIhnwWSyNbh/GUC9NDxoHcVSLDclGpjE53vUSLqxgZ
	 +P4fQ+fB/Ra1p1g4viy9VFr2kuhe68CNePiE0UeyFOa6OnxSAgG09oxWf2uPeS9GwE
	 GK+GDuCVPxgvA==
Message-ID: <sashiko-outbox-183265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Add a __derives_ret kfunc argument
 annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261023212041.884996-4-utilityemal77@gmail.com>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
 <20261023212041.884996-4-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 21:52:39 +0000
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
- [Critical] bpf: check_func_arg() fails to propagate parent_id into meta->=
ref_obj
--

commit 3a36b9b9ff614d7729738b098cb55d91d05fb314
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Add a __derives_ret kfunc argument annotation

This commit adds a __derives_ret parameter name suffix for kfunc pointer
arguments whose lifetime bounds the returned pointer. When a kfunc with a
__derives_ret argument is called, the verifier propagates the argument's
reference lifetime (via parent_id) or RCU protection (via MEM_RCU) to the
returned register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4a32875d70778..5a13b5ef688b7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9848,6 +9856,13 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg, u32 slot, u32 p
>  	if (reg_is_referenced(env, reg))
>  		update_ref_obj(&meta->ref_obj, reg);
> =20
> +	/* The return of a __derives_ret kfunc lives exactly as long as this ar=
gument. */
> +	if (btf_arg && is_kfunc_arg_derives_ret(meta->btf, btf_arg)) {
> +		meta->derives_ret.found =3D true;
> +		meta->derives_ret.rcu =3D is_rcu_reg(reg);
> +		meta->derives_ret.parent_id =3D reg_lifetime_id(env, reg);
> +	}

[Severity: Critical]
When a pointer returned by a __derives_ret kfunc is kept alive by a parent
reference (where reg->id is not in cur_state->refs, but reg->parent_id holds
the active reference ID), should check_func_arg() and update_ref_obj() also
propagate reg_lifetime_id(env, reg) into meta->ref_obj?

Currently, in kernel/bpf/verifier.c:check_func_arg(), update_ref_obj() is
only called when reg_is_referenced(env, reg) is true, and update_ref_obj()
records reg->id rather than reg_lifetime_id(env, reg):

kernel/bpf/verifier.c:update_ref_obj() {
	ref_obj->id =3D reg->id;
	ref_obj->parent_id =3D reg->parent_id;
	ref_obj->cnt++;
}

If a BPF program acquires a referenced object, passes it to a __derives_ret
kfunc to obtain a borrowed PTR_TO_BTF_ID | PTR_TRUSTED pointer with id =3D=
=3D 0
and parent_id !=3D 0, and then passes that derived pointer to another helper
or kfunc that relies on meta->ref_obj.id, meta->ref_obj.id remains 0:

1. In check_func_arg() -> process_dynptr_func() -> mark_stack_slots_dynptr()
   (for example, via bpf_dynptr_from_file() or bpf_dynptr_from_skb()),
   mark_stack_slots_dynptr() sets:

	parent_id =3D ref_obj->id;
	if (dynptr_type_referenced(type)) {
		id =3D acquire_reference(env, insn_idx, parent_id);

   Because ref_obj->id is 0, the dynptr and any child reference it acquires
   are created with parent_id =3D=3D 0 instead of the underlying reference =
ID,
   so releasing the original reference neither rejects an unreleased file
   dynptr nor invalidates the dynptr or its slices.

2. In check_kfunc_call(), for a non-__derives_ret kfunc returning PTR_TO_ME=
M:

	if (meta.derives_ret.found) {
		regs[BPF_REG_0].parent_id =3D meta.derives_ret.parent_id;
	} else if (meta.ref_obj.id) {
		err =3D validate_ref_obj(env, &meta.ref_obj);
		if (err)
			return err;
		regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;
	}

   When passed a __derives_ret-derived pointer, meta.ref_obj.id is 0, leavi=
ng
   regs[BPF_REG_0].parent_id as 0 (and bypassing validate_ref_obj() if
   another referenced argument was also passed).

3. In check_helper_call() for socket pointer-casting helpers
   (is_ptr_cast_function()), meta.ref_obj.id is 0, so the cast pointer is
   not bound to the original reference.

Can this allow derived dynptrs, memory pointers, or cast socket pointers to
outlive release_reference() on the original acquired object and cause a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023212041.8849=
96-1-utilityemal77@gmail.com?part=3D3
