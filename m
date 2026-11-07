Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024769;
	b=2IcS5kg+lXOllC9FuoIASSbcNCwVsEfhosFzhfDNHAYfzX0FD2OQe6G6AfWyb2rS9gvt
	 l7Z202XQ+PUFAE3rhtnEw/Wuwjb97ZWScv0IBMf26+qOYPma9OK52/2gwltmVeGGWIt7O
	 2f5cWZwtVhYnHGCNpqfCJQYwdgIwODuBOnBcWlXZ5wHi0jd7oDXIPS/PlBYW4r3EPBqYN
	 vk5wtNJ5BGw8Y5AM0cgez+/0o71mPa4hmYA/EmxyjoSlDOnacqIG0ibnc1l5kPlcEzYRP
	 haD3nzMOVbjrOrlKw+r0zrjewj/yJekiJtFtws1pBlLOEb+Hcgubh1i3IPia15m0hxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gbHyeHI7Gci9tefWdhSW3PDeNvXzrdXlxOjTYdmMSHc=;
	b=H+cyPc8uppWn8L6QFqwWhT2DCNANZ0WNdsEkR1WgbAlkJ9TXYJjJ3ISC+AaCyXi7jiOt
	 /4SfoEgM3qiHix5SFq+tDirCX/g65lwE1eVySZooqvvKRuLlT7z29ITQmf7HGs3jL/N1a
	 +XJH/+mlS1+Y/FngxnTULcMmzEthfg89/ZZauUUU2QJCFt0R/Zf1ylFAsaw8BqfEghqH/
	 kugy4hOvaUOE6RwjB6ED1AmDoLiCaM6weQ7W7leEUuvpgQraT66/yLNFBoo8qnaZHCcZT
	 aMmVV+JLVC4tfSjMOp1XFX8G6ZKWPQvSayC50N53Ye5p/1uouCM2KoeNkWAqnNCY14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UstlTFxp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B69606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UstlTFxp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C811F0089F;
	Sat,  7 Nov 2026 04:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024768;
	bh=gbHyeHI7Gci9tefWdhSW3PDeNvXzrdXlxOjTYdmMSHc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UstlTFxptaztM47JpSUJuSGv89eYQGu1W851Pmc9dZMVKxlNGjhdnxEj/iiyWjkVp
	 UX/4VM6MwMthtvPTngJ63s4fLsYjX5R2XdG0n+sn5z2VruEV5pWApg5c2gjpoYJy/u
	 QCk5U6UzHB5ruqPFy47zHCmer9CVfm0jvk3PU0JHvr4Ksf8E+S8acM7DeAgvYr74rV
	 njkTy6fz34qY/S92d+iypydk/IaxOxyDMPPOjzxyZmVOem37VbKjbtNmgJBfpMQdip
	 sZQW8eN8Mr0qWfxsjlawMMXyAJROz1328PPBhyah9nbtovgeMl1QdTfgHfcFn2waI9
	 iK5h4fhIyphRA==
Message-ID: <sashiko-outbox-202561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 16/46] bpf: Make the state after a call from
 the caller's state and an exit state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-17-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-17-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:12:47 +0000
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
- [High] bpf: missing exit->speculative propagation in bpf_flow_return()
--

commit 96816fe78c2229631b095b8d13a8d312f8d07492
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Make the state after a call from the caller's state and an exit state

This commit adds bpf_flow_return() and BPF_INHERITED_ID to construct the
caller's post-call verifier state from the waiting caller state and the
callee's exit state when verifying a static subprogram on its own.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d42c67d6d70b2..5e66d6768fcf7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11757,8 +11757,146 @@ static int push_callback_call(struct bpf_verifi=
er_env *env, struct bpf_insn *ins
[ ... ]
> +int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_st=
ate *caller,
> +		    const struct bpf_verifier_state *exit, int call_idx)
> +{
> +	struct bpf_func_state *frame =3D caller->frame[caller->curframe];
> +	const struct bpf_func_state *callee =3D exit->frame[0];
> +	struct bpf_idmap *idmap =3D &env->idmap_scratch;
> +	u32 caller_rcu =3D caller->active_rcu_locks, caller_preempt =3D caller-=
>active_preempt_locks;
> +	struct bpf_reference_state *held;
> +	struct bpf_reg_state *reg;
> +	u32 i, j, nregs, nheld, kept =3D 0, id;
> +	int err;
> +
> +	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + =
1])) {
> +		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %=
d\n",
> +			call_idx);
> +		return -EINVAL;
> +	}
> +	caller->unwound =3D exit->unwound;

[Severity: High]
Should bpf_flow_return() also propagate exit->speculative to
caller->speculative?

When a subprogram verified on its own spawns a speculative path via
sanitize_speculative_path() that reaches BPF_EXIT, caller->speculative is
false in the waiting caller state.  Leaving caller->speculative false on
return treats the speculative return path as architectural execution in the
caller: instructions reached only along that path are marked seen (skipping
dead-code sanitization), speculative return bounds in R0/R2 are joined into
the caller's architectural state, and recoverable speculative errors in the
caller are rejected instead of being mitigated with a speculation barrier.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D16
