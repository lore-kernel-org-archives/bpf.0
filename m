Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939930;
	b=lEh/9XTpkEvRm7XQaq07hJF1wH0ngqZm+ybd+mTEQnnAECdVbzVO5uHwSCWbC5wfOUsg
	 OvKD7aX4oH52+/IBDPDYel6aUn5d0sPCXwaWgCt5DhGEj3LgaflX3EOkNKSO04/bpQZFD
	 Nxp9sPybrB5AnU0i0OPGJpM6CnSqSkixmh+L3spZ0mJGjuludXizawLkkXBmksGDbgeIG
	 vZkDvR0odkF2osf6vbpFnMs7Cwmfx51ChuODRwhwtWorJRZYW/T+s4oDDJN7zH9wQ1AKM
	 qE/deSDiS+/J1VJWNXcncq1CPOKvPtJUgCPjqi7WJK/LUV06geIRrD4ZKDGIPNlI6Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939930;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=OQPZSE2R8dN+WeRk9uaK+EZ9+WoLAl6pj2nylwsh/Ps=;
	b=FOogbDlLpjxp5bBNMRyrEn5HoQryt5w3Vd5z8p+DtwyoLWFiKrQk9zIizoSJBcsEW2Th
	 2oAN46QXLssUIiKtoOL+nWYLaImie5IBiBNzRpc+9pHigNKe2poJ/qGiV+s5ZjT/QqmHj
	 dmOZEZI6amtRNvlzNIOVoFKqiBWcLB7yg6ZmUs523J4aVcvV62FVoQ+W7mlnRiSM2xEZx
	 Ok9BZ9vmPzkX2EaGIOPCXOifXiVaiK3nNFa/DSkIAcUnc0I11X+lyH2dPREK+b+MjcyeH
	 kzgeuzXMzzkERGQc8eWEJkka1Lr50GFf6goauV5ZI2yW/zRQ+oqCQsgAIO9AKDsmZAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFyl8yv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA81606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFyl8yv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8011F0089F;
	Fri,  6 Nov 2026 04:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939929;
	bh=OQPZSE2R8dN+WeRk9uaK+EZ9+WoLAl6pj2nylwsh/Ps=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WFyl8yv40GskbPfOCkJq/NR5XN4BWAMmi0uXeu3iw0hT3S7WscWC5FdOBhm3F4MAy
	 Nowxev4WTTfAJ5vWTTkmLu+ZWrAGg/JUOqQyxPerK6GJebPwxkjct7Ka+wbsIDQ/YV
	 V71w9g70omxLusIXSl/L8r2Z64Pyy0GxS9DReQb7JxiNWAaWSdeY2ZxodCngbDFPun
	 2qibRn7YT/M3XOQo5juILOLpg+bAYNp8ncdMva6PlLeM1J8Yq+nye0UhURcg5cCD3r
	 q3eGX9zi394JP4ZynTTK1bqyT6oDvQQg2foEbM9XTov1QSK3724TrJOcWel34Nr+YI
	 Iv5VmngTj/6fw==
Content-Type: multipart/mixed; boundary="===============8639904350596191187=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c056ec4fb613b0adaf2d52d1400488548b97b42bf2cab9c841ca3782839fff6a@mail.kernel.org>
In-Reply-To: <20261106035111.3315285-23-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-23-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 22/45] bpf: Allow recursive subprogs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 04:38:49 +0000 (UTC)

--===============8639904350596191187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow recursive subprogs

TL;DR:
- Possible kernel stack overflow: a tail-calling fentry/fexit prog attached to
  a recursive subprog isn't rejected at attach time
- Nit: sort_subprogs_topo() callx walk looks like dead code

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -3529,9 +3529,9 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
>   * the current subprog to discover callees (direct subprogs and sync
>   * callbacks).
>   *
> - * The callees of callx are not known before the main verification pass.
> - * When callx is used the sort is repeated after it with the recorded callx
> - * edges added to the call graph to reject recursion through indirect calls.
> + * The callees of callx are not known before the main verification pass: callx
> + * is no edge here. The order within a cycle is arbitrary. For recursion see
> + * mark_recursive_subprogs() and check_recursion().
>   */
>  static int sort_subprogs_topo(struct bpf_verifier_env *env)

This isn't a bug, but the updated comment says "callx is no edge here", while
the body of sort_subprogs_topo() still has a callx walk:

	if (bpf_is_callx(&insn[idx])) {
		/* find a callee that is not explored yet */
		callee = -1;
		do {
			callee = next_callx_callee(env, cur, callee + 1);
		} while (callee >= 0 && color[callee] == 2);
		if (callee < 0)
			continue;

bpf_check() no longer calls sort_subprogs_topo() after do_check_all(), so
the only call left runs before the main pass.  env->callx_edges is only
allocated by record_callx_edge(), which is reached from check_func_callx()
and push_callback_call() during the main pass.

Doesn't that mean next_callx_callee() always returns -1 here, and this
branch always ends in continue?  Could it shrink to a plain continue, or be
dropped, since bpf_pseudo_call() never matches a callx and the final else
already does continue?

[ ... ]

> @@ -24240,6 +24445,11 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
>  			return -EINVAL;
>  		}
> +		/* It can have tail calls, which are not allowed there, see check_call_depth() */
> +		if (aux->func && aux->func[subprog]->aux->in_recursion && prog_extension) {
> +			bpf_log(log, "Cannot replace %s, which is called in a recursion\n", tname);
> +			return -EINVAL;
> +		}

This check rejects only extensions of a subprog that is called in a
recursion.  Can a tracing program that does tail calls still attach there?

An fentry program, or an fexit program when the target cannot unwind, can
attach to a subprog with in_recursion set.  bpf_tail_call is in
bpf_base_func_proto(), so such a program can use it.

The trampoline runs the tracing program between one recursive frame and the
next.  Any subprog with has_tail_call makes check_max_stack_depth() set
NO_PRIV_STACK, so that chain runs on the kernel stack and by the 256-byte
rule in check_call_depth() can take about 8K.

The run-time check in bpf_insert_recursion_checks() only keeps r10 of a
recursive subprog in the upper half of the stack.  Its comment says the
lower half is for "the frame of the subprog, then what it calls", which is
a chain that check_max_stack_depth() looked at together with that frame.  A
trampoline followed by a tracing tail-call chain is not such a chain.

With CAP_BPF and CAP_PERFMON on x86-64 with 16K stacks, a prog could
recurse until r10 of R_k is just above THREAD_SIZE / 2, with each call of R
going through the trampoline of an fentry program F that does tail calls.
The stack would then hold about 8K of recursion, R_k's frame (up to
stack_limit), the trampoline, and F's tail-call chain of about 8K or more,
which exceeds THREAD_SIZE.

Should the attach check also refuse tracing programs whose
aux->tail_call_reachable is set (or that have no private stack) when the
target subprog is in_recursion, the same way it refuses extensions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42160076968
--===============8639904350596191187==--
