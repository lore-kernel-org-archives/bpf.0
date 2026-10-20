Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510211;
	b=jsej10c3MCEhkqGzo7frCl/6v8Qt6EhbD7GDzuZKquea7eZmvflFtmL71YmOqxo4dqsa
	 e22nTMVYYzxQT/B/9GIIXV+B8bmRDRiixaJRbsSiVWHUObjyErBlCtziJhw4Ibjg3A9Lw
	 QDCjag/1mUf0abm4NADX+I9KK4sRtL5t3MjyRHdyADIKJXOaJK7PyYyyw6x8c0Umw9OUp
	 UDUguQOV06JynlJd1cLFk9nM0g6k7/KKXBAMVxOEBvZpvt2+jXASPgFmOnva8AuWYcCDV
	 6o/+Qv6GOtUZYQRKNi6tJjDqDYogB81xembSKLEHkkZsmi9dc2MpDOQ2RbInyQ46H5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510211;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oiW1SyicLwAWmVV/Xn0Hpj+kC04S86sNJ9kaMOA17is=;
	b=zM4LmaH4uMyNVgob4yM/329nLVQfK4pefOUDFtkABqZHlZ+a4ESGjLLjULkOTOdJS+eg
	 vuP0Zl/otRIb0Fn2lgCejysquls2FToKCVb8zStIh/4EaRP9v9R193eBqejcEPJodVZVS
	 6LSCORPx9QI/GQxaX+6NzGfJD/V3JCIsODZT/swhloy6pvzhM7s/+r4im+hmkym8s1lKG
	 1GDqVI604ojetCPvSyf0M20xRoSsfEQaHEa0Qp8w44a20/K8HY0dkRS7ThXR+dP8n2T6b
	 N7y/8TDn3FyYvExSBOUARy9WMYwBehyK+AZNbKmcZXmFoWGbSw0yRhkgGKTI71Rf8ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EEF60A2618
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A31F000C4;
	Tue, 20 Oct 2026 15:30:10 +0000 (UTC)
Message-ID: <sashiko-outbox-179248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/6] bpf: Bind iterator elements to their
 iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261020145059.2146170-6-utilityemal77@gmail.com>
References: <20261020145059.2146170-1-utilityemal77@gmail.com>
 <20261020145059.2146170-6-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:29:35 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: iterator elements stay PTR_TRUSTED across next() in check=
_kfunc_call()
- [High] bpf: missing parent_id reference propagation in check_func_arg() a=
nd check_kfunc_call()
--

commit 5ca4ad8c9e1677551effb1ab248bfb034b276685
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Bind iterator elements to their iterator

This commit sets parent_id on PTR_TRUSTED elements returned by open-coded
iterator next() kfuncs to the iterator's reference id so that destroying the
iterator invalidates the returned element and any trusted fields derived fr=
om
it.

> diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_=
iterators.rst
> index 189e3ec1c6c8e..08c9c15b59acd 100644
> --- a/Documentation/bpf/bpf_iterators.rst
> +++ b/Documentation/bpf/bpf_iterators.rst
> @@ -79,7 +79,11 @@ Constructor/next/destructor implementation contract is=
 as follows:
>      will eventually return NULL when elements are exhausted. Once NULL is
>      returned, subsequent next calls *should keep returning NULL*. Next m=
ethod
>      is marked with KF_ITER_NEXT (and should also have KF_RET_NULL as
> -    NULL-returning kfunc, of course).
> +    NULL-returning kfunc, of course). An element is only guaranteed to be
> +    valid until the iterator is destroyed, so the verifier invalidates i=
t,
> +    and every trusted pointer derived from it, at `bpf_iter_<type>_destr=
oy()`.
> +    Elements of an RCU-protected iterator (see KF_RCU_PROTECTED) are ins=
tead
> +    valid until the end of the RCU critical section.
> =20
>    - destructor, `bpf_iter_<type>_destroy()`, is always called once. Even=
 if
>      constructor failed or next returned nothing.  Destructor frees up any
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c85c83a6ee63a..9ce5517dc1a02 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15504,6 +15504,19 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  			regs[BPF_REG_0].btf =3D desc_btf;
>  			regs[BPF_REG_0].type =3D type;
>  			regs[BPF_REG_0].btf_id =3D ptr_type_id;
> +
> +			/*
> +			 * A trusted element is pinned by the iterator that
> +			 * produced it and dies with it, like the memory
> +			 * returned by bpf_iter_num_next() above. An RCU
> +			 * element is bounded by the critical section instead.
> +			 */
> +			if (bpf_is_iter_next_kfunc(&meta) && (type & PTR_TRUSTED)) {
> +				err =3D validate_ref_obj(env, &meta.ref_obj);
> +				if (err)
> +					return err;
> +				regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;
> +			}

[Severity: Critical]
Does binding parent_id to the iterator's reference id still leave elements
and derived pointers valid across subsequent bpf_iter_<type>_next() calls?

In process_iter_arg(), unmark_stack_slots_iter() (which calls
release_reference(env, st->id)) is only invoked when is_iter_destroy_kfunc()
is true:

kernel/bpf/verifier.c:process_iter_arg() {
	...
	meta->iter.spi =3D spi;
	meta->iter.frameno =3D reg->frameno;
	update_ref_obj(&meta->ref_obj, &bpf_stack_slot(state, spi)->spilled_ptr);

	if (is_iter_destroy_kfunc(meta)) {
		err =3D unmark_stack_slots_iter(env, reg, nr_slots);
		if (err)
			return err;
	}
	...
}

However, non-RCU open-coded iterator next() implementations drop the
previous element's reference during the next bpf_iter_<type>_next() call
(including the final call that returns NULL), before destroy is called:

- bpf_iter_task_vma_next() calls bpf_iter_task_vma_snapshot_reset(snap),
  which calls fput(snap->vm_file) and overwrites the snapshot.
- bpf_iter_kmem_cache_next() decrements prev->refcount and calls
  kmem_cache_destroy(prev) when prev->refcount =3D=3D 1.
- bpf_iter_dmabuf_next() calls dma_buf_iter_next(kit->dmabuf), which calls
  dma_buf_put() on the previous dma_buf.
- bpf_iter_css_task_next() calls css_task_iter_next(kit->css_it), which
  calls put_task_struct(it->cur_task) on the previous task.

If a BPF program saves an element pointer or a trusted field walked from it
(such as file =3D vma->vm_file) in a callee-saved register or stack spill,
calls bpf_iter_<type>_next() again, and then accesses the saved pointer
before calling bpf_iter_<type>_destroy(), won't the pointer remain
PTR_TRUSTED after the underlying reference has been dropped?

Also, should Documentation/bpf/bpf_iterators.rst state that an element is
only valid until the next bpf_iter_<type>_next() call or
bpf_iter_<type>_destroy()?

[Severity: High]
What happens when a pointer pinned via parent_id (such as vma->vm_file) is
passed to bpf_dynptr_from_file() or a kfunc returning a borrowed
PTR_TO_BTF_ID such as bpf_real_data_inode()?

In check_func_arg(), meta->ref_obj is only updated when reg_is_referenced()
is true, which checks cur_state->refs for reg->id and ignores reg->parent_i=
d:

kernel/bpf/verifier.c:check_func_arg() {
	...
	if (reg_is_referenced(env, reg))
		update_ref_obj(&meta->ref_obj, reg);
	...
}

When file =3D vma->vm_file (which has reg->parent_id set to the iterator's =
id
and reg_is_referenced() =3D=3D false) is passed to bpf_dynptr_from_file(),
mark_stack_slots_dynptr() sees ref_obj->id =3D=3D 0 and calls
acquire_reference(env, insn_idx, 0). Doesn't this create the file dynptr
with parent_id =3D 0, allowing the dynptr and its slices to outlive
bpf_iter_task_vma_destroy() after fput(snap->vm_file) has run?

Note also that if a child reference is bound to the iterator's reference id
and left unreleased at destroy time, unmark_stack_slots_iter() ignores the
-EINVAL return from release_reference():

kernel/bpf/verifier.c:unmark_stack_slots_iter() {
	...
	if (i =3D=3D 0)
		WARN_ON_ONCE(release_reference(env, st->id));
	...
}

Similarly, in check_kfunc_call() above, setting regs[BPF_REG_0].parent_id is
gated on bpf_is_iter_next_kfunc(&meta) (unlike the PTR_TO_MEM branch above
it). If a BPF program calls bpf_real_data_inode(file) on either an acquired
file or vma->vm_file, won't the returned trusted struct inode * have
parent_id =3D=3D 0 and remain valid after bpf_put_file() or
bpf_iter_task_vma_destroy()?

>  		}
> =20
>  		if (is_kfunc_ret_null(&meta)) {

([Morph](https://morph.so))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020145059.2146=
170-1-utilityemal77@gmail.com?part=3D5
