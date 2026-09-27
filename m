Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7BA3C2782
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541789; cv=none; b=XvD04tlYZGP/xEGwyNmb6e8wqV2gVUe14aIVu1EClcInhhY8He+fo4Uuy4NGB+p5i0HNQk35ZGxoonipLJTP5i4qA505kux0c3k6dGGr/vsLd7azvp00hWp7q88aXu5MwOsBzOr9/aoVBNDpAEJM45K/rP643xvdGtYaMbJsqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541789; c=relaxed/simple;
	bh=DT2hb37fjH9qyTHgiXTnPxZmGGp/nHbQeTZja+jZdEI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DzfO4vjd8z/s4JWTaNJwRaEd4ZAGptKaCQkxvEhvEQcms9WL92rc+CIXXYZ0b+qbEmutre32Gix/N+GkQz0ks0LTVH1LEYsAIlq2AXtJzGquLkIgEOjNXKDskUlWaSSgvwV4aAUqkR+7rR34mkJUj8kCsqWMjgttJO017ZiBnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTx2BT0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTx2BT0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631E01F00893;
	Sun, 27 Sep 2026 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541788;
	bh=9tknpAc/LzzvK/wF09ZknVUzihfWX2+Jh15o8HrkTOE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YTx2BT0zPY4ImGzq6O9KZr+a5BvZxRwFsnH59BELslBsF7yh/zIK0hlf7X+6cmepj
	 lUtOW6Mic4T7hRwdcn409N+/97vSHkwmpsvl/j5SKM43ISvXdeIaGFaafj3ELzpElQ
	 eO4C4XOR8BelXK+xL1fZTgILYkpMzrIIKup5z38j7PjO5fOnm08H5GKNTrC0TZNGfI
	 YDRgf66eHio6SiSXPNuPWeWH1Pb4DukbBo2TS7YZ+5embZ63GN3OAEVGX5dNi4p4vS
	 VMzwzq/atbGLcpjUck8KtBMlKc8gKU95RI86H97e0EACTSHAF0fhgtmgzvxfRSfJka
	 hrYgNsA+pHuZw==
Content-Type: multipart/mixed; boundary="===============3608749445591823376=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dbf8cc0cf4abbe79d0de0dc37e12461542d4513ac1bf8eb5abb2db4301b85b2d@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-19-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-19-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 19/36] bpf: compute loop hierarchy
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:43:07 +0000 (UTC)

--===============3608749445591823376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5e6fa41a1353..d8142f1b2347 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -751,6 +782,10 @@ struct bpf_insn_aux_data {
>  	u16 const_reg_map_mask;
>  	u16 const_reg_subprog_mask;
>  	u32 const_reg_vals[10];
> +	/* index of a loop header of the innermost loop containing this instruction, -1 if none */
> +	s32 loop_header;
> +	/* additional information about the loop if this instruction is a loop header */
> +	struct bpf_loop *loop;
>  };

Does the comment on loop_header match what the code stores for loop
header instructions?

Looking at assign_header() in kernel/bpf/loops.c, for a loop header
instruction, loop_header holds the header of the enclosing (parent)
loop, or -1 for an outermost loop:

    /* Don't encode self-loops, otherwise can't reflect loops nesting structure. */
    if (n == h)
        return 0;

The field does not hold the instruction's own index, even though the
header is itself part of the innermost loop that contains it.

Every consumer has to special-case headers with the pattern
'aux[idx].loop ? idx : aux[idx].loop_header' (seen in
bpf_loop_at_index() and twice in bpf_compute_loops()). bpf_is_nested_loop()
walks loop_header from a header to find its ancestors.

A reader who trusts the comment and uses aux[i].loop_header directly as
"the loop this insn belongs to" gets the wrong loop for every header
instruction.

Could the comment clarify that for loop headers, this field holds the
header of the enclosing loop? Something like: "for loop headers, the
header of the enclosing loop; for other instructions, the header of the
innermost loop containing them; -1 if none. Use bpf_loop_at_index() to
get the innermost loop."

[ ... ]

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> index e7ff02e9ab3a..e269870f6a6e 100644
> --- a/kernel/bpf/loops.c
> +++ b/kernel/bpf/loops.c

[ ... ]

> +int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +
> +	return aux[idx].loop ? idx : aux[idx].loop_header;
> +}
> +
> +static int find_dominating_condition(struct bpf_verifier_env *env, int n, int top)
> +{
> +	struct bpf_insn *insns = env->prog->insnsi;
> +	int common_dom, n_loop, t_loop, f_loop;
> +	int *idoms = env->idoms;
> +
> +	n_loop = bpf_loop_at_index(env, n);
> +	common_dom = idoms_intersect(env, n, top);
> +	if (common_dom != top)
> +		return -1;
> +	while (n >= 0) {
> +		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) == n_loop) {
> +			t_loop = bpf_loop_at_index(env, n + insns[n].off + 1);
> +			f_loop = bpf_loop_at_index(env, n + 1);
> +			if (f_loop != n_loop && !bpf_is_nested_loop(env, f_loop, n_loop))
> +				return n;
> +			if (t_loop != n_loop && !bpf_is_nested_loop(env, t_loop, n_loop))
> +				return n;
> +		}
> +		if (n == top)
> +			break;
> +		n = idoms[n];
> +	}
> +	return -1;
> +}

Does find_dominating_condition() return the correct latch when the
backedge to 'top' comes from inside a nested loop?

The reference loop is taken from the backedge source:

    n_loop = bpf_loop_at_index(env, n);

When the backedge to 'top' comes from inside a nested loop (for example
a 'continue' of the outer loop issued from the inner loop body), n_loop
is the inner loop. The function then returns a conditional jump that
only leaves the inner loop, and stays inside 'top' on both of its
targets. Example:

    2: r6 += 1                ; H (outer header)
    3: r2 += 1                ; L2 (inner header)
    4: if r2 == 3 goto 2      ; H's only backedge, 4 -> 2
    5: if r6 > 100 goto 7     ; the only exit of H
    6: goto 3                 ; L2 backedge, 6 -> 3
    7: exit

The loop pass computes loop_header[3] = 2 and loop_header[4..6] = 3.

find_dominating_condition(env, 4, 2) sets n_loop = 3 and
idoms_intersect(4, 2) == 2.

At n = 4:
  f_loop = loop_at(5) = 3 == n_loop
  t_loop = loop_at(2) = 2
  bpf_is_nested_loop(env, 2, 3) is false

So it returns 4 as H's latch. Neither successor of insn 4 (2 and 5)
leaves H, so insn 4 does not decide whether execution stays in H.

With 'top' as the reference loop, the walk would visit 4, 3 and 2
without finding an exiting condition and return -1.

In this commit the wrong latch only appears in the verbose log. The SCEV
code added later in the same series trusts it, though.

bpf_compute_loop_iters() takes 'latch_idx = loop->backedges[0].latch'
for the header without checking that bpf_loop_at_index(latch_idx) ==
header. match_linear_latch() then evaluates the condition in the inner
loop's environment and flips the opcode because the true target is
"outside" the inner loop. compute_max_iters() documents the assumption
that "The latch is a conditional jump with one jump target exiting the
loop." As a result, the outer loop's max_header_count can be derived
from an induction variable of the inner loop that does not bound the
outer loop. Registers at the outer header are then widened and clamped
to that bound, which risks verifier unsoundness.

Should n_loop use 'top' as the reference loop instead?

[ ... ]

> @@ -22820,6 +22824,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	if (ret < 0)
>  		goto skip_full_check;
>
> +	ret = bpf_compute_loops(env);
> +	if (ret < 0)
> +		goto skip_full_check;
> +
>  	ret = bpf_compute_live_registers(env);
>  	if (ret < 0)
>  		goto skip_full_check;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============3608749445591823376==--
