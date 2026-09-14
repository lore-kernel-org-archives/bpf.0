Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E133F58B
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405844; cv=none; b=FHLmtEzgRWVLnHjepnaIDkuA8O1/767ffpBRyhD5fTZ47ePvLLmK8BXC3cEh/iXb1Yk7VN+B+NsP9oKys8imHgdg6tMatRLWgr9PwpIvfX37CKIp767gNr9XLm9KtqmEsY+4+t9/hMiWAH6HtvG6dHidp3PPSf0gGBEKuCQDagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405844; c=relaxed/simple;
	bh=xQ2pu+HM/06vTUjL8JliUVjVhiH3G0PU2OaCP20xVBU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jv4lcMXxTbUcWPZMZYNKlFWBCvTEkFBP0AAikIp0aK4vDzXYFSq5foD6Jqdxai80kVy5OwvmxF93aDUGMqHvjKnoxsz4H075r9QUXJAyMQ7YdIcI7tJYNf7MEMuEqHawhuy34Jbq1FfGjw26ppPadiQNGHFzk9IEKro7AwrliDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWk6xjE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWk6xjE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1F61F000FF;
	Mon, 14 Sep 2026 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789405842;
	bh=jeA+sP6HlyM2/Zc6gi6fNsjXvosByC3MUrdbYfpLgN8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VWk6xjE0291A2olYukHQ1tt1pVDJwaB+hJqG3Grgi9bwGJEx8OtTMkHEpBKREtI4r
	 u72ggSS1pqye7iA+Em5n7zpvyxbSZWPdpt2QcYtUpINRL9R00f7XqCgLrtYBnYwfn0
	 LqYgzE4boUSKqCGk2odBxKPybQZE9+V+4pscWs8KffGDF2SY0EonKoKEtt09JHht99
	 0z3EewG5AlYWfxIMtB1mPty4pIwmgMiuHlsXQ4ZIAyNXhu6oltLMWT43yydPg0KK34
	 u4qNSxy0tPowpcWBpq+r+0vbN54bnYIn5YIVWBsRvqexMKjFKHIrODzUrwOv2W6zW7
	 uqX3YXumDAsKg==
Content-Type: multipart/mixed; boundary="===============7017108975632157352=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <adc9899d09edb3dcea0de0a1997f1f189d524159e3aed2110ae92bb5bf77f86f@mail.kernel.org>
In-Reply-To: <20260914161340.3419141-2-memxor@gmail.com>
References: <20260914161340.3419141-2-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Compare stack frames in regs_exact()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 17:10:42 +0000 (UTC)

--===============7017108975632157352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 66fb11b6c6a76..827038ec18b7a 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -491,7 +491,8 @@ static bool regs_exact(const struct bpf_reg_state *rold,
>  {
>  	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>  	       check_ids(rold->id, rcur->id, idmap) &&
> -	       check_ids(rold->parent_id, rcur->parent_id, idmap);
> +	       check_ids(rold->parent_id, rcur->parent_id, idmap) &&
> +	       rold->frameno == rcur->frameno;
>  }

The frameno comparison is moved into regs_exact(), but regs_exact() is
not PTR_TO_STACK-specific. It is called from two other places:

states.c:509   if (exact == EXACT)
                       return regs_exact(rold, rcur, idmap);

states.c:650   default:
                       return regs_exact(rold, rcur, idmap);

The change depends on frameno staying zero for non-stack register types,
as the changelog states. Can that invariant actually be maintained?

Looking at bpf_reg_state.frameno writes, there is exactly one assignment:

verifier.c:2284  regs[BPF_REG_FP].frameno = state->frameno;

and one clearing mechanism, the memset in
bpf_mark_reg_unknown_imprecise():

verifier.c:2193  void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
                 { memset(reg, 0, sizeof(*reg)); ... }

The other reset helper does NOT clear frameno, and deliberately clears
only id and parent_id:

verifier.c:1860  static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
                 {
                         /* Clear off and union(map_ptr, range) */
                         memset(((u8 *)reg) + sizeof(reg->type), 0,
                                offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
                         reg->id = 0;
                         reg->parent_id = 0;
                         ___mark_reg_known(reg, imm);
                 }

So any site that turns a register into a non-stack pointer with
mark_reg_known_zero() followed by a type assignment carries over whatever
frameno the register previously held. Is mark_btf_ld_reg() this shape?

verifier.c:2249  case PTR_TO_BTF_ID:
                         mark_reg_known_zero(env, regs, regno);
                         regs[regno].type = PTR_TO_BTF_ID | flag;

And the LDX destination is not cleared before that:

verifier.c:6666  err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);

Concrete path inside any subprogram (frameno == 1):

    if r7 == 0 goto L1
    r1 = r10                  /* PTR_TO_STACK, frameno = 1 */
    goto L2
L1: r1 = 0                    /* DST_OP -> mark_reg_unknown -> memset -> frameno = 0 */
L2: r1 = *(u64 *)(r6 + 0)     /* r6 is PTR_TO_BTF_ID; check_ptr_to_btf_access() ->
                                 mark_btf_ld_reg(PTR_TO_BTF_ID) -> frameno survives */
    ... common tail using r1 ...

At the join point r1 is PTR_TO_BTF_ID with frameno == 1 on one path and
frameno == 0 on the other. frameno is meaningless for PTR_TO_BTF_ID, yet
regsafe()'s default: arm now rejects the pair. Before this patch
regs_exact() ignored frameno there and the states pruned.

This is a pruning regression. The change is monotonically stricter, and
the states_equal(..., EXACT) call sits inside `if (sl->state.branches)`
whose every exit is `goto miss`, so a failed exact compare never falls
through to pruning. The patch cannot cause an infinite loop to be
accepted. The cost is duplicate state exploration, which for a program
near the complexity limit turns a loadable program into one rejected as
too complex.

Could frameno be kept in the PTR_TO_STACK arm of regsafe() and also added
to the exact == EXACT early return? Or could frameno be normalized in
__mark_reg_known() alongside id and parent_id?

[ ... ]

> @@ -639,10 +640,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		return range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off);
>  	case PTR_TO_STACK:
> -		/* two stack pointers are equal only if they're pointing to
> -		 * the same stack frame, since fp-8 in foo != fp-8 in bar
> -		 */
> -		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
> +		return regs_exact(rold, rcur, idmap);
>  	case PTR_TO_ARENA:
>  		return true;
>  	case PTR_TO_INSN:

[ ... ]

Regarding the commit message:

>     Include frameno in regs_exact() so both exact and ordinary stack-pointer
>     comparisons enforce it. The field stays zero for other register types.

Is "The field stays zero for other register types" accurate?

bpf_reg_state.frameno is written in exactly one place (verifier.c:2284,
R10 in init_reg_state()) and is only cleared as a side effect of the
memset in bpf_mark_reg_unknown_imprecise() (verifier.c:2193).

__mark_reg_known() clears id and parent_id explicitly but leaves frameno
alone (verifier.c:1860-1868), so mark_btf_ld_reg()'s PTR_TO_BTF_ID arm
(verifier.c:2249-2253) produces a register with a stale non-zero frameno
whenever the LDX destination previously held a stack pointer.

Non-stack register types do not keep frameno at zero. frameno is
unmaintained for them, and only PTR_TO_STACK ever reads it.

Should the changelog either drop this claim and state the pruning
consequence, or should the patch establish the invariant it asserts?

Also, Eduard Zingerman requested in the v1 review that frameno should be
moved inside the bpf_reg_state's union or near the delta field for better
struct layout. You agreed to make this change but it has not been
implemented yet.

The v1 review comment:
https://lore.kernel.org/bpf/9c64f514a0afb6a491ff316246ec6cefa4adeff7.camel@gmail.com/

Eduard wrote: "After that, could you please respin, but try to move
frameno inside the bpf_reg_state's union or near the delta field?"

Currently, frameno is still at the end of the struct after parent_id, not
inside the union or near delta. Are you planning to make this change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34868467454
--===============7017108975632157352==--
