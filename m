Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025616;
	b=B0Se93tmADQv8KhpCV1NjJSWnDD57hO0w9fR7bRyQYKbgZAI9tXvw2zpnIcqCRI2zMPH
	 NYAMFxK3wQCjspjv/fLs2Cy6w9jZdiGZgoi7QsgeBpKpLnGXQsvfO6p0dxju5OxM/Z81U
	 YOGSnsnxi8kZHcgZFYHY1xAb8vgnS6hhIh4nnrmbJdtdq32LIcAzDtHuuNrVNtyVgN/hu
	 LVixJjPoFiEwcd5KHlz08012yZI2Z6fSXVrKi8gQcwDUhKZfa5k/FefAklxcpCfLoruEJ
	 blg69UlH8Vn299DNofEOojSVdtk96JMrIa5UMkvXF6Gfe9ASPctHNF7vL9297H+gBWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025616;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l7yNTSY0kRh9IM3D7p0l9IVdLtJRAdyoCNbXsMev/io=;
	b=DHZgiqRMuEyUKUZWdK9taF1FYg8w9o+p0XZlUj4ybXUOoTUIJaTmkwyvqABQ8GbplJLT
	 q1y/vEBYzrH+Jyv9/pahBP0HaVExGHaPKb9JKc2sUoKzcWx9Sp2qevom+M0B2hd2n9shp
	 rbXtaeH9WvnZjVSnxnZ8f1IPwVJhNxTRrUfkjMCaxVPjJuPPccwW8Hb1UV7DgRNcD2JBf
	 wYfRvhjizZCZ1ZJh8/IXbIyE1pojX3G6aslFBKcCqPOYevJViXe8qZs9qjQ9FA5ENUVwi
	 MRMx3uETRHH/ia6PkcpX5qQ0n2nFCUqCB20TQW8GNHXGhUyhyBkS53NW7+DeeKP/RbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARMjqjxI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC77606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARMjqjxI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8854F1F0089F;
	Sat,  7 Nov 2026 04:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025615;
	bh=l7yNTSY0kRh9IM3D7p0l9IVdLtJRAdyoCNbXsMev/io=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ARMjqjxIAXg9s9cXimJ40ywlXJvHwcP/vIv08cN7YtsuNEW2qM7wqi+lcjFBPtMSR
	 gCejvSHLa7/Y1svleE3POszAG9+gRiU/raVRPdmlMsBjnUnfCTpIefhMrm14TXZOMs
	 DY4BWtjfzeCIZJB6DWJniyxumIQiA66k63QnZr1fC+jnFnevUm0XLX0tr1eGQNFQZ9
	 sF8GW9rp040wJ1TL+KPJYPZgtctQtwCxCcw+eRqm1XCr7vvd4/BovWl1R03L8Davo4
	 taSmO6wdZxPFbPU4WFb30cymmhS0BMnF3NNnVwlaql85mkSUqDxPOfaBwkUejKk1CA
	 h65ggKS72cKyg==
Message-ID: <sashiko-outbox-202577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 30/46] bpf: What a call returns in each
 iteration is like what the loop loads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-31-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-31-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:26:55 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: missing call OPAQUE handling in
  made_from_partial_spill()
--

commit 17f294cedba72c038cc095f26f37091b91a7fbf0
Author: Alexei Starovoitov <ast@kernel.org>

bpf: What a call returns in each iteration is like what the loop loads

This commit assigns an OPAQUE scalar evolution expression with parameter 1
to r0 after a BPF_CALL, allowing loop registers updated from call return
values to be marked in fresh_regs after walking short loops.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index d8c847efbd7f3..06f485853df13 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c
> @@ -852,8 +852,11 @@ static int transfer(struct bpf_verifier_env *env, st=
ruct env *e, int idx)
>  		break;
>  	case BPF_JMP:
>  	case BPF_JMP32:
> -		if (opcode =3D=3D BPF_CALL)
> +		if (opcode =3D=3D BPF_CALL) {
>  			forget_call_regs(e);
> +			/* made anew, like what is loaded. The parameter tells the two apart.=
 */
> +			return replace_reg(scev, e, BPF_REG_0, expr1(scev, OPAQUE, 1));
> +		}

[Severity: Medium]
Does made_from_partial_spill() also need to treat a call's OPAQUE
expression like UNKNOWN?

Before this change, BPF_CALL left r0 as UNKNOWN_EXPR_ID, so a known live
partial stack spill updated from a subprogram or helper return value had
made_from_partial_spill() return true and jumped to cant_widen in
bpf_compute_loop_iters():

kernel/bpf/scev.c:made_from_partial_spill() {
	const struct expr *e =3D &scev->exprs[id];
	u32 i;

	if (lvl >=3D EXPR_STACK_DEPTH || e->op =3D=3D UNKNOWN)
		return true;
    ...
}

kernel/bpf/scev.c:bpf_compute_loop_iters() {
    ...
		if (is_unbound_scev_reg(env, cur_func, r)) {
			if (is_known_partial_spill(cur_func, r) &&
			    bpf_stack_slot_alive(env, st->curframe, (r - MAX_BPF_REG) * 2 + 1) &&
			    made_from_partial_spill(scev, cur_func, header_env,
						    header_env->reg2expr[r], r, 0))
				goto cant_widen;
			continue;
		}
    ...
}

Because op_params_num(OPAQUE) is 0 and e->op is no longer UNKNOWN,
made_from_partial_spill() now returns false when a partial spill is set
from r0 after a call.  bpf_compute_loop_iters() then skips cant_widen,
leaving walk false and the slot out of fresh_regs, which causes join_slot()
to widen the partial spill at the loop head and causes a regression where
valid programs with bounded memory accesses using that spill are rejected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D30
