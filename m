Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914540;
	b=C2a4WHiIsD64Dd0K7x8WKVleifeiLoL+Pd/lgnUimCRm1jN+11tfVVQLvvYsAmfKDohU
	 9BPR9mOfr/2/adimf00EIoylgA0RQF1gVIaSawnYy71+fc2fINA7HFdZD68MeldWb3GV5
	 UUMZ/FFQ3HuKMd5psUrRCZqhrtK9f6mYipU0MihAIZ4GdAIlr1UzrD59YCZNIm/cagKvu
	 agvP1u5KO5k6fEISRoLRLFDpD0qDa60Rb7AWzpm1b4/9T0uOp4WZY3NZrBBPJIB5KuhxV
	 SGeBLBj3E9PycKca1R6HYVl1QSfCp3GIiTFT1YwoAglDqhpgAbMNjBcP/oRx+jOFWNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914540;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KteQeuxaX2tCpwHVgcVeAmv7ocpt87d6yrpEjvz4yqQ=;
	b=bLokAHHD6B/6mGFt9elgA+EM1tZhWBDH79UPtnmbiy9FMdBXsjfm2DM/kLm1Zkx+g3lt
	 p0MJB3+DmHFaeLYJA+Rl2Gs5N2LSJXZtxZAoNF/afBBhdrb6iAPDMdf26w8SxGY+jJyJn
	 emzKsF5Z5MxVuF8BUS0jiAIKaPwtcD6EoaX5p2bAjMIdhFNJOKs0OfiJMQaZlcHyDopx/
	 b+lICjMlL5aAVjCWyvrQT5Bdl0MdxXU/uPsBjCQ2ECXUqVFe9SSy0GvGmKuxGYmz+KS44
	 ynvZbVwSDzQD6PjC5Dx6M4XcW6GArD51EF4O5u6HS61dY+BOMwdzMlbl2fF37Nopkkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knEWQrTg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7948606A335
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=knEWQrTg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAC11F008BE;
	Thu,  5 Nov 2026 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914539;
	bh=KteQeuxaX2tCpwHVgcVeAmv7ocpt87d6yrpEjvz4yqQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=knEWQrTghasr7FV4N7blEumQPSk3W/Bg34kl33LdpI5FmOiIk1CN1P7el04X1XmL5
	 P2w4e7FByImrHg2Sh3J47UYKA5bbx2qq1tP6pxqrXWQqfrLzBjvLifbkn7kX/OB80b
	 0TKoWl+Upu6Qhfofcn892ff7LBRhJ8aW2kWrzkCHPAFWRu/ByCuF66pqn1v+t4hoH9
	 TByRTtb5nhrgEnQ6YrUnQQwnM0P3nekIcLnTPWIv/Ff+WHDJ/tdT05rI/OceBygV8T
	 IVFGC+02OVVu1oMbzdWqFd/+wuHsSDgkHELi51HOuUIslpbbBiPBOuij9LAg06O12s
	 zQcuefKXHpxIg==
Content-Type: multipart/mixed; boundary="===============4827271521712746813=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <2fb8818fc3672d32024737e9aa212dab897444383eb115483de87216d647c4c6@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-10-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-10-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/35] bpf: Find the registers that hold a number or a pointer to arena
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:39 +0000 (UTC)

--===============4827271521712746813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Find the registers that hold a number or a pointer to arena

TL;DR:
- bpf_cast_to_kern_ctx() and bpf_rdonly_cast() results may be treated as plain
  numbers, so valid programs with variable offsets could be wrongly rejected
- addr_taken is unset mid-series, so callback arguments may be classed as
  numbers, with similar false rejections

> diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
> index 0f5acdf1cb94..837d5054c2a3 100644
> --- a/kernel/bpf/flow.c
> +++ b/kernel/bpf/flow.c

[ ... ]

> +/* What a helper or a kfunc returns */
> +static enum flow_kind flow_returned_kind(struct bpf_verifier_env *env, int idx)
> +{

[ ... ]

> +	if (bpf_pseudo_kfunc_call(insn)) {
> +		if (bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
> +			return FLOW_IS_OTHER;
> +		t = btf_type_skip_modifiers(meta.btf, meta.func_proto->type, NULL);
> +		if (!btf_type_is_ptr(t))
> +			return FLOW_IS_PLAIN;
> +		/* void * is a number, unless the verifier knows the kfunc. Such kfunc may fail. */
> +		t = btf_type_skip_modifiers(meta.btf, t->type, NULL);
> +		return btf_type_is_void(t) && !(meta.kfunc_flags & KF_RET_NULL) ? FLOW_IS_PLAIN :
> +										  FLOW_IS_OTHER;
> +	}

Can this classify a kernel object pointer as a number?  The check relies on
KF_RET_NULL to recognize the void * kfuncs that the verifier special-cases,
but two of them do not carry that flag.  In kernel/bpf/helpers.c:

  BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_FASTCALL)
  BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_FASTCALL | KF_PERFMON)

check_special_kfunc() makes R0 a PTR_TO_BTF_ID for both of them (trusted
for bpf_cast_to_kern_ctx(), untrusted for bpf_rdonly_cast(), which is what
libbpf's bpf_core_cast() expands to).  Here they return FLOW_IS_PLAIN, and
flow_loaded_kind() then returns FLOW_IS_PLAIN for anything loaded through
that base as well.

With the pointer in value_regs, flow_ptr_off_regs() computes
'ptrs = both & ~value_regs' as 0 at 'rX += rY', so the scalar offset is
never kept as a needed constant and the two states are joined.  For the
'y = z ? task->pid : task->tgid' pattern named in the comment above
flow_compute_need_const():

  r6 = bpf_rdonly_cast(r1, ID)
  r2 = offsetof(pid); if z goto L; r2 = offsetof(tgid);
  L: r6 += r2
  r0 = *(u32 *)(r6 + 0)

After the join r6 has a variable offset, and btf_struct_access() would
reject the load with "invalid variable offset access into struct
task_struct".  The program was accepted before the series, since each path
had a constant offset.  Only valid programs are rejected, nothing unsafe is
loaded.

No later commit in the series changes flow_returned_kind().  Should this
test for the special kfuncs explicitly, for instance by comparing
meta.func_id against special_kfunc_list, or return FLOW_IS_OTHER for
bpf_cast_to_kern_ctx() and bpf_rdonly_cast()?

[ ... ]

> +	memset(kinds, 0xff, len * sizeof(*kinds));
> +	memset(ret, 0xff, env->subprog_cnt * sizeof(*ret));
> +
> +	/* what the kernel, a helper, callx or another prog calls: only the context is known */
> +	for (s = 0; s < env->subprog_cnt; s++) {
> +		if (s && !bpf_subprog_is_global(env, s) && !sub[s].addr_taken)
> +			continue;
> +		flow_kinds_enter(&kinds[sub[s].start], &k);

This isn't a regression in the final tree, but is the sub[s].addr_taken test
effective at this point in the series?

Nothing sets addr_taken until 7d38def0aa01 ("bpf: callx reads what the
subprogs whose address is taken read"), whose message says "Nothing set it
so far".  bpf_flow_compute_kinds() is called from bpf_check() starting at
0b369589ee67 ("bpf: Verify programs as a fixpoint over the control flow
graph"), so from there through 8a9f232040a7 ("bpf: Track a pointer to one
of a set of functions") every static callback is skipped by the continue
above.  That covers bpf_loop, bpf_for_each_map_elem, timer, wq and rbtree
callbacks, and every callx target.

flow_kinds_step() does not seed those entries either, since a pseudo_func
ld_imm64 only sets dst to FLOW_IS_OTHER and callx enters no callee.  So
kinds[sub[s].start] keeps its memset(0xff) value, where every register is
FLOW_IS_PLAIN, FLOW_IS_VALUE and FLOW_IS_CTX together.  That contradicts the
comment ("only the context is known").

The callback arguments (map, key, value, callback_ctx) are then treated as
plain numbers, and flow_ptr_off_regs() and flow_base_regs() never ask the
main pass to keep states apart for arithmetic or loads based on them.  For
example a for_each_map_elem callback that picks one of two constant offsets
into a value holding a bpf_spin_lock or timer would be rejected after the
join, although each constant path is valid.

Could addr_taken be set earlier, or the pseudo_func targets be seeded here
directly, so that every commit in the series matches the comment?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============4827271521712746813==--
