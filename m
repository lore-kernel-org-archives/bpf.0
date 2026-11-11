Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385671;
	b=HSRLI0hZntTnGvcNfsV6slLxl6/h381SKpKi92qrbdp2bRu+690OwbHZFusAox8VB57Z
	 jrHJZk6lvbMKPgNVneWDYg/XZZp7KrtctFdgJEaPY9E8ucnNUyowghpfwli64nr30n58r
	 JHcV2hMyB5LoRu56sDtC7huOogmEKS+EbXrzDrGWHP/6H/trhRmUt7gDKNxbjAX95bpm+
	 hiSFnl04U9tjt7Jy/05OUMkV5vwsU6pnaff3VlTUAlvJbGzt0JHCM7tRYz5IjApSsNt67
	 IkNRmVENBuNAu3uykwW7+AZ8JobNPHruqZUHbZW/N2avUlnNaU2lM+Py6vRXwTMydsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385671;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=p60Gim0dwkpuBrAgl48EatUiS+j0Set/GRaryYINq5w=;
	b=Ltea76Ww6zrGWNyFTo19E6LxDM8r7lD9t9sNg1pvzI4pnDiPKapjjsb+MVaRQ5gPaCSF
	 JRIb+dOUfVtIs/1qxeHUJPe/LTlK2nrVuVVVLdxZDWgOsAdT0WqOwqF1rXfbMosRJk1SZ
	 qlFKFovYwpCLRUeE2f63mtuS0RlMWb6LG/P/CFxm4X0Rzr6AkU0kn1vBcLaCsb10/45Sd
	 1b8oERe24AFSd+eG4gvGp1GPp/LEjUkmMLHBSvaFtkW/grF7pHiUgd3pryy11gY0cmLLw
	 aL5tKLeruUAyo4jrlWco6lto5aqFUXEdqGZ2Q3g0x+EmFDLB/ANtmtVeTHvV75dAv6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kMXRk4/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87660A260D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMXRk4/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EB61F00A05;
	Wed, 11 Nov 2026 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385670;
	bh=p60Gim0dwkpuBrAgl48EatUiS+j0Set/GRaryYINq5w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kMXRk4/IQxIraPWuw7Vcek3NVCofdlhx+FQt0H7ExYoxf6CL99pwRUIUho1t4G+dL
	 isEEfAzm6pZQuhg17dP0Y0AoSl9xqsNQs+IGOholQCGtutB+IyJjwUX9Fs5KUMdgFT
	 pk78dVSRAtuBeLuBm1oEoOf2c4Z8IzqiwONtSAmUej0tUdOCRqxNyZZbtaqNs/lMmE
	 u3nvsKBv3+WSYmfSPxYjErz9d+/W0jq2B1L+8p1rPteu/waCmQF2mDid0eu/Bq/NQX
	 OuOqL8xUS2RxPaKFimC2/2QYa9tFvVZojozb2fPt9cn4IkIuH+01iPbcMzPgQs9Bn8
	 h3nAy8qkCPLKg==
Content-Type: multipart/mixed; boundary="===============1121918324758650602=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f0c1de1cac27de4cc0a76ee6b1469e2bb1e10149e9584891332368bf1993d7e9@mail.kernel.org>
In-Reply-To: <20261111051341.2800252-5-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/29] bpf: Don't join dead registers in scalar evolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:27:50 +0000 (UTC)

--===============1121918324758650602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't join dead registers in scalar evolution

TL;DR:
- Dead-register pruning in scalar evolution join() may lose precision for live
  stack slots after must-write probe reads, contradicting the commit message
- Liveness may be queried at the wrong index for irreducible nested loops,
  possibly causing false rejections

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -1001,7 +1003,9 @@ next:;
>
>  	for (i = 0; i < REGS_NUM; i++) {
>  		if (!same_exprs(scev, acc->reg2expr[i], cur->reg2expr[i])) {
> -			id = mk_any(scev, acc->reg2expr[i], cur->reg2expr[i]);
> +			/* no phi for a dead register: pruned SSA */
> +			id = reg_alive_at(env, i, idx) ?
> +			     mk_any(scev, acc->reg2expr[i], cur->reg2expr[i]) : UNKNOWN_EXPR_ID;

The commit message says "Expressions change, but only those that have no
users". Is that accurate for stack slots?

reset_scevs_at_indirect_writes() reads the old expression of a slot before
overwriting it:

	mask = bpf_may_write_mask(env, idx);
	opaque = bpf_helper_call(insn) && is_probe_read_helper(insn->imm);
	for_each_set_bit(spi, mask, MAX_BPF_STACK_SLOTS) {
		reg = MAX_BPF_REG + spi;
		if (cur_env->reg2expr[reg] == UNKNOWN_EXPR_ID)
			continue;
		replace_reg(scev, cur_env, reg, opaque ? OPAQUE_EXPR_ID : UNKNOWN_EXPR_ID);
	}

Consider a privileged program calling bpf_probe_read_kernel(fp-16, 16, ptr)
with a constant size.  bpf_helper_stack_access_bytes() reports a must_write,
so the slot is dead at every join before the call.  Take a loop where the
slot is read at the top of the iteration and written on only one of two
branches, and the branches join at J before the probe read.

Before this patch the slot at J was (any opaque fpN), and the probe read
turned it into OPAQUE.  Now it is '?' at J, the UNKNOWN_EXPR_ID check above
skips it, and it stays '?' after the helper even though it now holds freshly
read memory and is live.

That '?' reaches the back edge and the header env.  In
bpf_compute_loop_iters(), expr_is_fresh() returns true for OPAQUE but false
for '?', so the slot moves from iters->fresh_regs to iters->forget_regs.
made_from_partial_spill() also returns true for '?'.  A non-empty fresh_regs
sets entry->first/entry->apart in verifier.c, whereas without it
bpf_widen_scev_regs() runs at once.

The result is conservative, but it is a precision change for a live value,
not the "no users" change the commit message describes.  It can change what
loads or how many states are needed.

Could join() leave dead stack slots alone when the next write is a
must-write, or could reset_scevs_at_indirect_writes() tell a dead-at-join
'?' apart from a real unknown?  If the change is intended, could the commit
message say so?

[ ... ]

> @@ -1339,7 +1343,7 @@ static int join_successor(struct bpf_verifier_env *env, int cur_header, int succ
>  		return -ENOMEM;
>  	if (log_level2)
>  		memcpy(old_env, succ_env, sizeof(*old_env));
> -	err = join(scev, succ_env, cur_env);
> +	err = join(env, succ_env, cur_env, succ_idx);

Is succ_idx the right index for the liveness query here?  The new comment on
join() says "@acc is the env before the insn at @idx", but join_successor()
has already remapped succ_idx to the topmost nested header:

	succ_idx = nested_header;
	...
	succ_env = get_loop_env(scev, cur_header, succ_idx);

For a reducible nested loop every entering edge targets that header, so this
is fine.  For an irreducible loop nested in a computable outer loop,
compute_loops_in_subprog() marks only the inner loop irreducible, and an
edge from the outer loop body into a secondary entry s of the inner loop is
mapped by topmost_nested_loop() to the header H.  It is then joined into H's
env with liveness taken at H, not at s.

A register can be live at s and dead at H, for example when the path through
H writes it before s reads it.  The two entering edges then give '?' instead
of (any a b).

That env is used.  When H is popped in compute_scev_for_loop(), the nested
loop's masks are pulled up from it:

	for_each_set_bit(r, nested_loop->store_base_regs, BPF_SCEV_REGS_NUM)
		or_expr_regs(env, cur_env->reg2expr[r], cur_loop->store_base_regs);
	for_each_set_bit(r, nested_loop->tested_regs, BPF_SCEV_REGS_NUM)
		or_expr_regs(env, cur_env->reg2expr[r], cur_loop->tested_regs);

For an irreducible nested loop both masks are bitmap_fill()ed, so every
register's expression is consulted.  With '?', the outer loop's
store_base_regs and tested_regs lose the outer header registers that the
register live at s was computed from.

Missing store_base_regs bits could let bpf_compute_loop_iters() widen a
register that a stack address in the nested loop depends on.  Missing
tested_regs bits could wrongly put a sum into loop->linear_regs, which makes
join_place_is_linear()/bpf_reg_widen_range() forget its range.  The
or_expr_regs() comment already notes this "may cause false rejections".

Could join() skip the liveness pruning when succ_idx was remapped to an
irreducible nested header, or take liveness at the original successor?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42982641817
--===============1121918324758650602==--
