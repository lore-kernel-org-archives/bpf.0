Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA943043DE
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228144; cv=none; b=RfHAjOQs6qKSvFgDwNw6Gnu1LrcHIoHOdZnYe2zBgPKi06C/xqaEAn8rgMJgRQKoeRjja31XeFiiIW9ZC4vO+MRtWf6UGEUTS6gMjfwx597A7SeSYPYM8XhwG/bLwbAuV9gfHZloGBwPC51v8dcqaI2vUhxDoifRPCg4Ml+IdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228144; c=relaxed/simple;
	bh=xTh6NMeLn5btFXfeJW1RTSHEMstDTM+dBpAHEjZLx+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RqvWCRH57y+fCJvRQEn2ZZsx9V2z6wZIr1DwjFGZFrNSGLOn/SCKCqdQXDFD8zUBEPCpwMa7Q74E4vc8jA4yPgzHItGLqYGUM7GQGTAPg0ALdwnnLeIPCZZC/+cvvWR/zPBKb+NmShk2xNHdcp3qfYa4NXIhH5WiEV+GvgI9HOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl0Fl5+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl0Fl5+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4871F000E9;
	Tue,  1 Sep 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228131;
	bh=YDqNsgEnEro17kzy4e9QzprkBvrv3+NAttmqc4Xis20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fl0Fl5+dzWU3HSc1TJUoPylwHKz5SY1q8JpC6h9RF2kw1zvQJT3vObGWu8VBDhpOF
	 tx3FrPQVa6rKM+0kgu96ODmDPT+mzR+5z+eAE1ODRYXpxjXFPILgvOCR2ydrXGEcrf
	 I7yQl1GZaX3Fgk6xthqEExcie8pccp2nc57rw5uc1HGG1LWacTYMooI4VYUHCs4ye2
	 JeSUOvd/ENIPCIM6UN6WyWZF8gtmBiUPKZwgyHGpwfQ1tlb0drop07EyvcqGuxcQqX
	 pnrnUT+px4OlVzS6lfQM6jndc8+t+aIrm6ZGUIijboukVFt/EGhHZp/52UjGT6jfEB
	 8aRHvSNCQJOmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: backtracking shouldn't clear outer frame
 R1-R5 for callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
References: <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 02:02:10 +0000
Message-Id: <20260901020211.6F4871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Flawed heuristic for distinguishing subprog exits from callback ex=
its causes the verifier to erroneously reject safe programs that call a sub=
prog immediately before a looping callback.
--

commit 09e9430ffafbb3bf72d2c301a4d20da098050142
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: backtracking shouldn't clear outer frame R1-R5 for callbacks

This commit fixes precision propagation for R1 during a second iteration of
bpf_loop(). It removes the logic in backtrack_insn() that previously cleared
R1-R5 when backtracking through a callback's BPF_EXIT, ensuring precision
marks are not incorrectly reset.

> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
> index a2b18a9f1694c..4fe9065106739 100644
> --- a/kernel/bpf/backtrack.c
> +++ b/kernel/bpf/backtrack.c
> @@ -520,37 +520,34 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
[ ... ]
>  		} else if (opcode =3D=3D BPF_EXIT) {
> -			bool r0_precise;
> +			bool from_subprog_call, r0_precise;
> +
> +			/* BPF_EXIT in subprog or callback always returns
> +			 * right after the call instruction, so by checking
> +			 * whether the instruction at subseq_idx-1 is subprog
> +			 * call or not we can distinguish actual exit from
> +			 * *subprog* from exit from *callback*. In the former
> +			 * case, we need to propagate r0 precision, if
> +			 * necessary. In the former we never do that.
> +			 */
> +			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
> +					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);

[Severity: High]
Can this heuristic misclassify a callback exit as a subprog exit?

If a program calls a subprog immediately followed by an iterating callback
helper (like bpf_loop()), and we backtrack from the callback's BPF_EXIT,
subseq_idx equals the index of bpf_loop(). Checking subseq_idx - 1 evaluates
the instruction before bpf_loop(), which happens to be the subprog call.

This makes from_subprog_call incorrectly evaluate to true for the callback.

> +
> +			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
> =20
>  			/* Backtracking to a nested function call, 'idx' is a part of
>  			 * the inner frame 'subseq_idx' is a part of the outer frame.
>  			 * In case of a regular function call, instructions giving
>  			 * precision to registers R1-R5 should have been found already.
> -			 * In case of a callback, it is ok to have R1-R5 marked for
> -			 * backtracking, as these registers are set by the function
> -			 * invoking callback.
> +			 * In case of a callback from bpf_loop(), R{1,4} in the calling
> +			 * frame would be set as precise and that is correct.
>  			 */
> -			if (subseq_idx >=3D 0 && bpf_calls_callback(env, subseq_idx))
> -				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
> -					bt_clear_reg(bt, i);
> -			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> +			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
>  				verifier_bug(env, "backtracking exit unexpected regs %x",
>  					     bt_reg_mask(bt));
>  				return -EFAULT;
>  			}

[Severity: High]
Will this incorrectly trigger the verifier bug check for callbacks?

Because bpf_loop() requests R1 precision (which falls under BPF_REGMASK_ARG=
S),
the misclassified from_subprog_call causes this safety check to evaluate to
true. Could this prematurely abort verification with -EFAULT and falsely re=
ject
perfectly safe BPF programs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-bug-015-ba=
cktrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com?part=3D1
