Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985467;
	b=xgM+1g6KJvgZgb3f9bW8lHmGMaqyw/tpHZPoSFsJjqGqk6tCvkJOqVauutMvAxDx/q46
	 TE6aRFOXn3g3GTTeg7k5KWDUxafrwgZgnl0s55iZO3X9IpB2oJudlx1LOe2HRVEtXS/Tu
	 fGWfNWWpsH7o/jkzy12bu2TPLt7D8TXlFDtqt8EqvWFGl5opl4r/xwe2qotB+Eb1loDeC
	 BDVRgvAP4wYdmZjcehx8tJAuZFSbyAsqonevX5VNldIsJ/BSZi2WyfEbc7SI0C1q5i13F
	 NOTc/tBWWDfVyXWwZtql36O5E27vzi+FSqUi58Yvu+BOBzOuJmj8mVBbVuExVUFed0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985467;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DyMei4abpdDzbQhv2Ifx2fXVyvazWyjj/OdbvGY9UQc=;
	b=cTIqkgkqz7TBFhyRKXX9hVWKFWJwy1VLWIcyBJ7vwo72nBV0w65VNta26b5xZXt3wZIl
	 fkE08UxCnJ4NI/Vbc2bF4zoOIM33XsUuxwqSBPrBbQy/kw4AcEJ5m4dJV126v2DpPcXyt
	 TLzxaGVV0pMs/srMgNgw0GVIUO6kZDJ0H3WLETxZACfTf/GMyQPXgtHQyBSKkyFEtdUqu
	 rnb2PC47ZYjCWAeeNsFdZPvr9I5Jh6Wlo+BC6GkovSv4XmwA2Q0Y1n7vE1Wd0Y9h052ug
	 ADklADH71r3iLQh4ESP3EWTip8pfhPjpsDGNUPYA+CejmjHvEzOPM9lI995y4UYAplg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKTlBCaE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39277606A332
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKTlBCaE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29511F0089F;
	Fri,  6 Nov 2026 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985467;
	bh=DyMei4abpdDzbQhv2Ifx2fXVyvazWyjj/OdbvGY9UQc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kKTlBCaEkXoeTCISoDSpxEHX/WbScwOHJyp9+vLYo9IuUGBqO9coUr6zpY9zUeG4g
	 9S6gVIgcOH0oZbvCmXXWHfPdQ3p14M/TcbEME0OzEOVbFb7uxv5MH7bxMrj00hKRzp
	 nHPjF+5chET/Ga8Ti26ByMEv1s5Hv/BItuHCMYZJp3iAPaL/DqxIeNR9EGyK5V/Tjs
	 Pn/NNMja6AFTS+AJUIVCMc4G3Eov/M9hV2BMnYLtiZNTxIGD2qKjNSr0ITMTxac3YY
	 mW/w6wTqbK+rUQL8DhlfruI1qFqPrr0ijwKC2+Jb05tB79Zc/mb9eUQ0KOQm2ATmzW
	 4RG2QE9DcBNHQ==
Content-Type: multipart/mixed; boundary="===============6092167187052590773=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c5a67b62f878af7cd0492bfd739e9f6a74b6749f6552d486a1e887f8b183f0a7@mail.kernel.org>
In-Reply-To: <20261106164043.546879-3-jolsa@kernel.org>
References: <20261106164043.546879-3-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Disable private stacks for untagged kprobe programs
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,sammiee5311@gmail.com,simon@swine.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 17:17:46 +0000 (UTC)

--===============6092167187052590773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Disable private stacks for untagged kprobe programs

TL;DR: Disabling private stacks for classic kprobe programs may make
previously loadable programs fail verification (-EACCES) once frames count
combined against the stack limit, e.g. on powerpc64; the commit message
doesn't mention it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5749,6 +5749,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
>  	 */
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_KPROBE:
> +		/*
> +		 * Uprobes are preemptible and lack recursion protection. Classic
> +		 * kprobe and uprobe progs have no expected attach type, so enable
> +		 * private stacks only for kprobe.multi and kprobe.session progs.
> +		 */
> +		if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI &&
> +		    prog->expected_attach_type != BPF_TRACE_KPROBE_SESSION)
> +			return NO_PRIV_STACK;
> +		fallthrough;

Classic SEC("kprobe"), kretprobe and ksyscall programs run through
trace_call_bpf(), which has cant_sleep() and the per-CPU bpf_prog_active
guard, so they never had the re-entry problem.  They lose private stacks
only because they cannot be told apart from uprobes.

Does this change which classic kprobe programs the verifier accepts?
check_call_depth() treats a frame separately when private stacks are on:

    if (si[s].priv_stack_mode == PRIV_STACK_ADAPTIVE) {
            depth = round_up_stack_depth(env, si[s].stack_depth);
            ...
            continue;
    }
    depth = dinfo[s].depth + subprog_stack_size(env, s);
    ...
    if (depth > env->stack_limit) {
            verbose(env, "combined stack size of %d calls is %d. Too large\n", ...

subprog_stack_size() returns 0 for an ADAPTIVE frame, so before this patch
the frames of a kprobe program were not added together.  Now they are, and
a program that loaded before can fail with -EACCES.

For example, on powerpc64 bpf_jit_supports_private_stack() returns
IS_ENABLED(CONFIG_PPC64) and there is no bpf_jit_supports_large_stack(), so
bpf_prog_stack_limit() returns MAX_BPF_STACK (512).  A SEC("kprobe")
program with a 512-byte main frame calling a subprog with a 32-byte frame
used to load, and would now fail with "combined stack size of 2 calls is
544. Too large".  This is the shape of the "Private stack, subtree >
MAX_BPF_STACK" selftest that this patch moves to kprobe.multi.

On x86-64 and arm64 the limit becomes MAX_BPF_STACK_JIT (2048) combined,
where it used to be 2048 per frame.  If this is backported to a tree
without MAX_BPF_STACK_JIT, x86-64 and arm64 would fall back to 512
combined for these programs.

The commit message does not mention that existing classic kprobe programs
can now fail verification, or that users need to move to kprobe.multi or
kprobe.session to keep the larger stack budget.  Is this rejection
intended?  If so, could the changelog say so?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42256932632
--===============6092167187052590773==--
