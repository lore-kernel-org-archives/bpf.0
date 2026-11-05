Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914516;
	b=2yK9QbO4BWtjS2x+03MrM+kdRMJbNHbW2ngiQlVpZSUfAFqDhV9b6wakn/jYgh3YEEZD
	 eIxp5sy+/hvBwmYNDqgsHCmC6dj4mLITTOvaePWw+Qs7cie/rZeY1wDF+kfbMAonqROZt
	 j+gZGqCW+rYr06glktlAK5KvUe/YoSmVLlAkI0kvz5UGbPG65SNxsrUGhiZAp+bU1aKia
	 L5GbkmtS13w4AZObfLDTVGu4stj8m/r27tPbC9cYIWp6Edg9sb6Q3NQoJy5t/Bk50hQCI
	 xR+mi9K4k1ecproMf80kEoepSr5SC7qsS52lmSMxXWWoIr+GlNbvlYWDvD/J+jwNyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914516;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YHEKHGlcKNAcHRaaVAroR4sUmZnhNxNREeMfwOv5AFw=;
	b=1a0Wp9mlh8i04ZaEF6BhOpbe8V7Yxh1YoX/5+3JZQTGWJjbuYQpXGoTEKjuzxLZHUwv6
	 WvkmCkIe5XNrbkRn4qKabMlXSH2SfCIKFMiP2Grs2b8TqXutTiKZ9LUJWF/dGEPsQUzc+
	 TLh3aeSTT+3kiraOXUXcOhq+Qv3nEsLcUwril23hguvslcxsJxSaQIi2QEcxuDLWxB7UF
	 CFnFVIceOmlIRWsF+Jg/F6cO/+HFq+VW+REkoB5AGEtyEiyI26w1uXHYLzfRl+FE1mE/G
	 SnFBJ3G5Flf6Wbe5D+II9+KSIKONzY0UmI2QpKrj7H0Qd7irR9T6p/uvYhyMt2XGuqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ4xZX7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD06606A339
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ4xZX7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA7C1F008A1;
	Thu,  5 Nov 2026 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914515;
	bh=YHEKHGlcKNAcHRaaVAroR4sUmZnhNxNREeMfwOv5AFw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fQ4xZX7rgocbH9SgBfet0SSDmWLX0XYU8NAvChD9e+pUW1qCg7khBKhHl2PgiJK+S
	 K2oowmW5Zx4RFQ81y9E13GglbatXs7jGr/BF8/67xezHJ3rtQy5ZaFVqi3YbcyO4Ag
	 FMjYjGinUZ2RWmG9yEC3uASvyPhI2+QLw1ZCenn1Prz53VZpeRCInYSPCIn5kBmETJ
	 6S9VuXGn2wQRTGGaR/GgOW8EMmGDt0C7IjVZoFAsSifbTSB0eXauoUNDSKaFJk0M0q
	 qrDLVbLF0pjHL9tNosOv8fsV3OnhSfS9pXavgeZOLipJKZnd2ny4JywmsNXHN/dmN/
	 7l2VVj1RU+UYg==
Content-Type: multipart/mixed; boundary="===============1723269833923957996=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <53c16606b21ca4743d6f2dcc8f31619c9e070d7ca0a729fcb0ae723bb1c04ee5@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-31-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-31-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 30/35] selftests/bpf: Adjust tests to new verdicts, messages and order
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:15 +0000 (UTC)

--===============1723269833923957996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests to new verdicts, messages and order

TL;DR: Test issue in verifier_scev.c correlated_regs(): the
__not_msg("{{^}}11:") window may now be too narrow to catch a non-converging
loop, so it may check nothing; suggests matching "from 16 to 11: within"
instead.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> index 07c356fde68d..5e566933f7e4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> @@ -2396,18 +2374,15 @@ __msg_next("  r1=(+ r1 2) / (linear (+ r1 2) 2)")
>  __msg("loop header at 11, widening r0")
>  __msg("loop header at 11, widening r1")
>  __msg("11: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7)) R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=14,var_off=(0x0; 0xe),step=0+2)")
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
>  {
>  	asm volatile ("					\

Does the __not_msg("{{^}}11:") in correlated_regs() still check anything
now that "from 16 to 11: safe" is gone?

match_negative_msgs() only looks for the negative pattern between the end
of the "clamping r1" match and the start of the "exiting loop 11" match.
With the new verifier both messages are written while the successors of
insn 16 are delivered, with no insn processed in between:

do_check_block()
    flow_drain()
        bpf_flow_deliver() -> flow_add() -> bpf_flow_loop_enter()
            maybe_clamp_scev_regs()    /* "loop header at 11, clamping r1" */
        flow_merge()                   /* "from 16 to 11: within|widened" */
    flow_arrive() -> bpf_flow_loop_leave() -> loop_stack_pop()
                                       /* "exiting loop 11" */

If the clamped state is not within the header state, flow_merge() leaves
it pending at 11, and bpf_flow_next() takes pending states in flow->pos
order, so "11: ..." would be printed after "exiting loop 11" and before
"17: (95) exit".  That is outside the window, so the test would still
pass.  There is also no "processed N insns" check to catch a loop that
does not converge, so the "/* iteration convergence */" comment describes
a check that is no longer made.

clamp_dependent_overshoot{,32} in this same patch replaced "from 6 to 2:
safe" with "from 6 to 2: within".  Would __msg("from 16 to 11: within")
after the clamping lines work here, or alternatively moving the
__not_msg("{{^}}11:") to between "exiting loop 11" and "17: (95) exit"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============1723269833923957996==--
