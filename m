Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422954;
	b=taFf2iG5BG76nxjLhXu3O/TSyKn64sQpEjbIFL7SttYHvE03rfw1SZAUxh41Ss6YrDuP
	 i3n5zUfOOgHFjMB2abfBuSJ1GVJ0y057HQWOrxwpdUvi4Brk91m1Ywvozo2AF3yBxxGcs
	 BbHVSF5WVRkWmxBGf07sajMLBaAJPqxBEQkZV2dFefn7ITQZOEcZr67UiDQvqaKMjVxra
	 DfZInX7RiU5y7jQ+aXaM/hIVqDRlNXTBqK//5zjLZ5oRkkhkNDHbROEAsFFpRhcM4wTSI
	 iAhcMYuaNVgutnNREscI/3J8JtUfhtaGd3pLmtglu2OuADvZrvTltnsORrO+861Qn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422954;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4kjU0ZNgKeDuSC3sF79gmSkLBZmEmKeau6g9lhc612o=;
	b=YGjetZinQx1+g7aNFPIg6voaj4tFQw3hIt8UqmNCnel/jcMlrdY72nXlEk5pAK4avegz
	 K/m0VgoXLBTUviDNXQp+NPyVH/kiKj8yx5aqRZmerfZQkRtiYh9sZ0KJi82YCntijgsIt
	 4SmelrLBr9EMte6XYPBYnqsoDM0HgLBVlWENg4vGdrZwzGwQJ2EVnS/z/46vzl8lsMZy5
	 Khf2fis/CgvnfZry674WzqDnY0kLtEegRD9TSQZOmQqwHGlGWUoKObmdlCRLs+KKT+Ix3
	 fVkBJxadZi9pzAqiPrisHRJw0XXH5W2fUai+zij/pUzKmA4QpgwKINe87YMZimrpXFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoO3f1iJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A79609DCFF
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoO3f1iJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA331F000C4;
	Mon, 19 Oct 2026 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422954;
	bh=4kjU0ZNgKeDuSC3sF79gmSkLBZmEmKeau6g9lhc612o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LoO3f1iJxqQv0Cn4CPWroGE6AUuvIXKHnrjjD2MKzk/EhhIxTiG8shnmcRutpd9AY
	 X52VIRIB7cAPMg8GmxrtlaLF/8AMPEuWBjLCCu2XBKqQIeeTjjkj2wjPSrwFB4s79A
	 pqNADVdCGb4kZpVdIU2pVwkIuiUnRVqY5A5rEVpN1jqRdwnPxabEXBjhu8RX+OBc1+
	 PV+muUphjYjSKHiOxy+5oPPByHefje/QxocZB7nNiy3CETTlfsNBwOZwhxtVT1EjCh
	 UYQMDFezol3TjREGjDeaQpFK0+8C4yxbVA9328sQGYayOx+RceuQIVVm93OFWy2VAF
	 57BrHKUIkQxHQ==
Content-Type: multipart/mixed; boundary="===============2455065071638320290=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fc72351703797f0b378539604785e0c12576199cf2462de31a6ef0b8fb07e042@mail.kernel.org>
In-Reply-To: <20261019144851.4052056-2-memxor@gmail.com>
References: <20261019144851.4052056-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Refuse CO-RE relocations for a signed program
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 15:15:54 +0000 (UTC)

--===============2455065071638320290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse CO-RE relocations for a signed program

TL;DR: Commit message may be inaccurate: unsigned program BTF still drives
post-signature insn patching (bpf_obj_new size, struct_meta, exception
callback), so signed programs may still change; check itself looks correct.

>     bpf: Refuse CO-RE relocations for a signed program
>
>     The signature of a program covers its insns as submitted, along with the
>     frozen metadata maps of a signed loader, and bpf_prog_verify_signature()
>     checks it before the verifier does anything else with the program. CO-RE
>     relocations are the one input besides the insns that changes them: the
>     loader hands them in with the program, and bpf_check_core_relo() applies
>     them after the signature check, rewriting the immediate or the offset of
>     every insn a record names with a value the loader chooses, a field
>     offset, a type size or id or an enum value of the kernel BTF, or a type
>     id of the BTF the loader supplies itself. Whoever holds a signed program
>     can so change its constants once the signature has passed, the offsets a
>     signed loader reads its metadata map with for instance, and run a
>     program the signer never saw. The exclusive metadata map of a signed
>     loader does not make up for it: the hash that binds the map to a program
>     is chosen by whoever creates the map, so it can name the relocated
>     program as well.
>
>     Refuse a signed load that carries relocations, before the signature is
>     examined, like the other checks on the shape of a signed load. A signed
>     loader has none to lose: the programs it embeds are relocated by the
>     loader itself through bpf_core_apply(), and nothing relocates the loader.
>     The BTF of the program itself can stay: without relocations it steers
>     only the verification, through func_info, line_info and the annotations
>     of global function arguments, and rewrites nothing.
>
>     Fixes: 349271568303 ("bpf: Implement signature verification for BPF programs")
>     Cc: KP Singh <kpsingh@kernel.org>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The commit message says CO-RE relocations "are the one input besides the
insns that changes them", and that the BTF of the program "steers only the
verification ... and rewrites nothing".

Are both statements accurate?

The program BTF (prog_btf_fd, installed into prog->aux->btf by
bpf_prepare_btf_info()) is not part of the signed payload.
bpf_prog_verify_signature() hashes only the insns followed by the frozen
maps, and it runs before the BTF is read.

The verifier still patches the insns using values taken from that BTF.  In
check_special_kfunc(), for bpf_obj_new_impl() and bpf_percpu_obj_new_impl():

    ret_btf = env->prog->aux->btf;
    ...
    insn_aux->obj_new_size = ret_t->size;
    insn_aux->kptr_struct_meta = struct_meta;

and later bpf_fixup_kfunc_call() emits:

    insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, obj_new_size);

followed by a BPF_LD_IMM64 of the struct_meta pointer into R2.  The same
BTF-derived struct_meta is patched in for bpf_obj_drop and
bpf_refcount_acquire, and for the list push and rbtree add kfuncs through
__fixup_collection_insert_kfunc().

These kfuncs are registered for BPF_PROG_TYPE_SYSCALL (the signed loader
type) as well as TRACING, SCHED_CLS, XDP, STRUCT_OPS and CGROUP_SKB, and
nothing in the signed load path refuses them.

Can a holder of a signed program still have the kernel patch in an
allocation size and struct_meta pointer derived from a BTF type the signer
never saw, after the signature check has passed?  That looks like the same
class of post-signature constant change this patch sets out to close.

Similarly, bpf_find_exception_callback_insn_off() picks the exception
callback subprog from an "exception_callback:" decl tag in the same
unsigned BTF, which changes run-time control flow and not only the
verification.

The memory safety impact looks limited, since the verifier checks accesses
against the same BTF it then patches in.  This is mainly a question of the
message's accuracy, and of the scope of the hardening it describes.

Separately, the statement that the embedded programs "are relocated by the
loader itself through bpf_core_apply()" seems imprecise.  The loader
program only issues a nested BPF_PROG_LOAD carrying core_relo_cnt
(bpf_gen__prog_load() in tools/lib/bpf/gen_loader.c), and the kernel
applies the relocations in bpf_check_core_relo() -> bpf_core_apply() on
that nested, unsigned load.

Could the message be narrowed so it does not claim the program BTF
"rewrites nothing", or could it acknowledge the bpf_obj_new, list and
rbtree fixups and the exception_callback decl tag?  Should those paths
also be refused for a signed program?

The check itself looks correct: core_relo_cnt is zero for the signed
loader (bpf_load_and_run() in skel_internal.h memsets attr), the early
return leaks nothing, and the err_prep path in bpf_check() cleans up.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39273821952
--===============2455065071638320290==--
