Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939665;
	b=rM/vXxl/dimAwYNfm5ZLgu9VtXAbq4tHgic4LbxY/N0/v7oKpOAS6ul6WqQhNxl+w45f
	 9lTaElhgDcFbC41L0KTNc3xTt5T4MdKqJriJq5jziQlvKmlOWghf7XzHWmNVI7Ec1JmIY
	 Kv9j5kbz1NVPM2JFC8eYdyLB9rdn9EYJbZMCXURwsoBgkBlEFMIIeXjI0/78GW8FdKk8o
	 4cgSc4SwdJegBF2b2EMLakuEIdipsAY6Uzsz5a6Ao4ylJzcSTH2EFdDDSbrZytN8t5cWb
	 SZeV6fjTv0xSBI2N+lZeCGVblZ5mL4V0jzvWQQymunZRFl0obEUxt94dAUa+ukYb04g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939665;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=io5QALPjLMpVlzyKWa7cKGVshcxol7NaiIJslSWax5M=;
	b=uUffv3vS6pDruEQnyPe6kPtR8Czd3u0gzrPFYAO3f6zgOwjm4CxNwmRlevVUPvsEAhrj
	 kG9NRdAJtUKw1qnlOoGLXNpA114rAaAQ66VbXiA081OgDJYSsV8Wx5/XsjTCvfKbaTIfh
	 GYwScwIGdx7PG1eUxkoPT09LKNzENMzbpo+4ybNexucffbGrRToUUY7KgPtp5pCQYBvrr
	 c4bRcOOLHsVHXG2BmVEuNHTMOFoP68uu/L9jElhTlrYlzFJqs8owSh1p61MrJyUbaR5Q2
	 BcjSl1cXLvRPYY7hDQohai9JGYFoefhtLynFfcQglC7xpmb9VnMAJoV/Ol0jQVAwmpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iglgWnkD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBF606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iglgWnkD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFE81F0089F;
	Fri,  6 Nov 2026 04:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939665;
	bh=io5QALPjLMpVlzyKWa7cKGVshcxol7NaiIJslSWax5M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iglgWnkDBodRhBk/QM9UOZtoNGG7HhyVkIbisygo/V5vw4xZ2cOchqQtjOAC71hmO
	 I6k90Hahu7GcjW4Mx0XDfbBPCeDLbIaPCvIfxY5YSZZC1Wfanv8fWauK8zZ9DOWzJE
	 D38iOJRH/AgS5fmGxyP1ii6eRzAK4J7BIlpo0l42kofJXe8H3u4oZwnCSnZ3L4wVOG
	 hB62QJuIwpsZYXsfj77ukb/Wbr//7s0QL3o6j5T4dA0xycFQzLOcJ7Id/F/MjC684F
	 ayL1HP5K6drzzowPdiY85/t1LVsEe8xJ/j6a2Z9/FTzVM+OPtPU9n9hvhv1Tr4FjOD
	 7xUB8YS8slG3g==
Message-ID: <sashiko-outbox-200734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 40/45] selftests/bpf: Adjust tests to new
 verdicts, messages and order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-41-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-41-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:34:24 +0000
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
- [Medium] selftests/bpf: ineffective __not_msg() window in correlated_regs=
()
--

commit 02c8d77860efe8ec36bb7092420fc94e1e92c1cc
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Adjust tests to new verdicts, messages and order

This commit updates BPF selftests to match the new verifier behavior for
fixpoint verification over the control flow graph, standalone static
subprogram verification, and recursive subprograms.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/te=
sting/selftests/bpf/progs/verifier_scev.c
> index 07c356fde68db..5e566933f7e44 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> @@ -2396,18 +2374,15 @@ __msg_next("  r1=3D(+ r1 2) / (linear (+ r1 2) 2)=
")
>  __msg("loop header at 11, widening r0")
>  __msg("loop header at 11, widening r1")
>  __msg("11: R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=
=3D7,var_off=3D(0x0; 0x7)) R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax=
32=3Dumax32=3D14,var_off=3D(0x0; 0xe),step=3D0+2)")
> -/* loop exit */
>  __msg("16: (a5) if r0 < 0x8 goto pc-6")
> -__msg("exiting loop 11")
> -__msg("17: (95) exit")
>  /* second iteration */
>  __msg("loop header at 11, clamping r0")
>  __msg("loop header at 11, clamping r1")
>  /* iteration convergence */
> -__msg("from 16 to 11: safe")
>  __not_msg("{{^}}11:")
> -/* map lookup error path */
> -__msg("from 7 to 17: safe")
> +/* loop exit */
> +__msg("exiting loop 11")
> +__msg("17: (95) exit")
>  __naked void correlated_regs(void)

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [1], in correlated_regs() in
tools/testing/selftests/bpf/progs/verifier_scev.c, does placing
__not_msg("{{^}}11:") before __msg("exiting loop 11") make the convergence
check a no-op?

In tools/testing/selftests/bpf/test_loader.c, match_negative_msgs() only
searches for the negative pattern between the end of the preceding positive
match ("loop header at 11, clamping r1") and the start of the next positive
match ("exiting loop 11").

In kernel/bpf/verifier.c, when do_check_block() processes conditional jump
instruction 16 (if r0 < 0x8 goto pc-6), check_cond_jmp_op() pushes the
branch target (instruction 11) onto env->head and advances env->insn_idx to
17. Still within the same do_check_block() call:

1. flow_drain() delivers the 16 -> 11 backedge via
bpf_flow_deliver() -> flow_add() -> bpf_flow_loop_enter() ->
maybe_clamp_scev_regs(), which emits "loop header at 11, clamping r0" and
"loop header at 11, clamping r1", followed by flow_merge() which either
logs "from 16 to 11: within" on convergence or queues instruction 11 in
flow->pending via flow_set_pending() without executing instruction 11.

2. Immediately after flow_drain() returns, do_check_block() checks
bpf_flow_is_point(env, 17) and calls bpf_flow_deliver(env, state, 17, 16),
where flow_arrive() -> bpf_flow_loop_leave() -> loop_stack_pop() emits
"exiting loop 11" before returning to do_check().

3. Only after do_check_block() returns does do_check() call
bpf_flow_next() to dequeue the next pending block. Because flow->pos orders
instruction 11 before instruction 17, a non-converged state at instruction
11 would be logged after "exiting loop 11" and before "17: (95) exit",
outside the span checked by __not_msg("{{^}}11:").

Should __not_msg("{{^}}11:") be moved after __msg("exiting loop 11")
(between "exiting loop 11" and "17: (95) exit"), or should this match
__msg("from 16 to 11: within") as done in clamp_dependent_overshoot() and
clamp_callee_state_pruning() in the same file?

[1] https://lore.kernel.org/r/53c16606b21ca4743d6f2dcc8f31619c9e070d7ca0a72=
9fcb0ae723bb1c04ee5@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D40
