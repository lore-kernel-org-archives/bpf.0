Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134752;
	b=bv/tA1XlFQeGT/Jme0VmRZ1flnlE//68f0qDemNMRARAF//EkgHwiOFqt+nyHx0j6tHM
	 Mfzgx38V8cjlx8zLmZR6fvxuY05CfcrC35//jQ5v5En7awSL52SdeRLj9Cd+z/1kNCtn+
	 l4pXgC03M0j7qIyRvxGxqMu1Srsll/fwEuzs1BbBmPb7a76Bp3chn5x5XihxKgTtycmE0
	 9tUWdfJ8+UN/m52oSk7j2ZatDFBfPzXRKm+K6LHTmlNqOoAtyRbL9VFy3tT3Dn7LyYOU7
	 bTfRUYFkXqdwhQv7N2uVRD7CfquSEX+iuZZcJLwpVdOGMwmgEWgtO8aNhqJWjztwQ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134752;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=5qct+wBRLRk00QzcUug9+o65/kpJioVbaHpWBHplmLM=;
	b=JpzjAi6PVSCIrdY0VFqsWbEckmT2xiJtDTz3fehES3shJj16aHFRUArdMwgYB0gPLwkJ
	 PE97N4JmPRkWaII1Hkzv/swx9dvv6K4s70mYPwk7e6LMRLFp317odXlp7JZgRQYM9//bL
	 Q+oWNjuu4/OYiE4nphADIILeN3YL61ITS9LHgC0vGkbjPx/hCD0cGqRmz4y45CGZes0vK
	 EjM43j7TERQ5YI/CekmRNTalJiGxq32PhwmBbdHHczB/NZahsk77uZ16/qsXULZczCbqV
	 XkIoDcAxz0bAvvdEtOsaV87i2cE5dGQLBv6/IZ97w7VY1BsR0gi1prxtM4JwFlhSMeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oiUIM3R/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE731606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiUIM3R/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB0D1F01825;
	Tue, 27 Oct 2026 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134751;
	bh=5qct+wBRLRk00QzcUug9+o65/kpJioVbaHpWBHplmLM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oiUIM3R/CcLRgejZZNSoqeIq2yCWjV9h6KR0HbnxN6kI95boxtCrPPVg30v2S9L4j
	 xjwkf4zeMAqzgBJVW8nJF0KDt+BtVdver5tlViRzY47VzieiPNZ8QZdNYlVO/qqaCO
	 ECxDvQ/7uvT0Ia2PdWu+pJZaDF21jyeEyDYwpObeal6Z/dK8l9fXZbcBJjROCy9wUS
	 Z02dq0L7AHIA3J0+U0GZWEXOD+9Rgl0mOs2tUMPosu1f9mfpP3h9Bbb+oaj97Xf9ld
	 CW46bo94WCZklPkZDN51E8F+ElZJ1hRcKlvI8V53XEUeC9LxfTvGZ4UplBdkoxafpC
	 mTxbPTOZBP+uQ==
Content-Type: multipart/mixed; boundary="===============5077807729473474553=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f7b5a34c2b903996cd2e758f4c30c70e7ffc860a52a9a2a08886a14dff82cb72@mail.kernel.org>
In-Reply-To: <20261027201436.3192716-3-alexei.starovoitov@gmail.com>
References: <20261027201436.3192716-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test the valid bytes of a packet pointer in a counted loop
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 20:59:11 +0000 (UTC)

--===============5077807729473474553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test the valid bytes of a packet pointer in a counted loop

TL;DR:
- Selftest clamp_pkt_pointer_step_lowers_umax may expect wrong __msg: r=56 vs
  r=54 (unrun, from reading code)
- If so, the clamp may subtract rounding twice and wrongly reject a valid
  packet load

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> +/* The access is in the second iteration only: the verifier gets to it after the clamp */
> +SEC("tc")
> +__failure __msg("invalid access to packet, off=56 size=2, R6(id=3,off=56,r=56)")
> +__naked void clamp_pkt_pointer_step_lowers_umax(void)
> +{
> +	asm volatile (
> +	PKT_PLUS_R4(0, 8)
> +	"r9 = 0;"
> +	"w1 = 0;"
> +	"*(u32 *)(r10 - 8) = r1;"
> +"1:"
> +	"w1 = *(u32 *)(r10 - 8);"
> +	"if w1 == 0 goto 2f;"
> +	"r0 = *(u16 *)(r6 + 0);"
> +"2:"
> +	"w1 = 1;"
> +	"*(u32 *)(r10 - 8) = r1;"
> +	"r6 += 8;"
> +	"r9 += 1;"
> +	"if r9 < 2 goto 1b;"
> +"9:"
> +	"r0 = 0;"
> +	"exit;"
> +	:: PKT_IMMS : __clobber_all);
> +}

[ ... ]

Will this __msg() match what the verifier prints once the previous patch in
the series is applied?  The expected "R6(id=3,off=56,r=56)" assumes r6 still
has r=58 when the clamp runs at the back edge.

Tracing the prog (r4 has step 1 because the BPF_AND calls reg_step_reset(),
so umax stays 50 after 'if r4 > 50'):

1. Before the loop r6 = pkt + r4 is [0,50] with var_off (0;0x38) and id=1.
   'if r5 > r7' gives it r=58.

2. On first arrival at the loop header handle_loop_entry_exit() calls
   bpf_widen_scev_regs().  linear_bounds() gives 0..58 step 8 and
   bpf_set_reg_range() reaches sync_widened_reg():

    u64 umax = reg_umax(reg);          /* 58 */
    reg_bounds_sync(reg);              /* umax 56 via step 8 */
    if (type_is_pkt_pointer(reg->type) && reg->range > 0)
        reg->range = max_t(s64, reg->range - (s64)(umax - reg_umax(reg)), 0);

   so r goes from 58 to 56.  This is the same state in which
   widen_pkt_pointer_step_lowers_umax expects "R6(id=2,off=56,r=56)".

3. In the first pass fp-8 holds 0, so 'if w1 == 0 goto 2f' skips the load.
   'r6 += 8' is a known add, so adjust_ptr_min_max_vals() keeps the range:
   r6 is [8,64] with r=56.

4. At the back edge maybe_clamp_scev_regs() calls bpf_clamp_scev_regs().  It
   takes linear_bounds() from the entry checkpoint (range 58, giving 0..58
   step 8) and gives the reg id=3, then calls bpf_set_reg_range() on the
   back-edge reg, whose range is already 56.  sync_widened_reg() subtracts
   the same 2 bytes again: umax 58 -> 56 and range 56 -> 54.

5. regsafe() does not prune against the header checkpoint (rold->range is 56
   and rcur->range is 54, and fp-8 is 0 vs 1).  The second pass reaches the
   load, and check_mem_region_access() -> __check_mem_access() would report:

    invalid access to packet, off=56 size=2, R6(id=3,off=56,r=54)

Should the test expect r=54 here?

If r=56 is the intended value, then the clamp path in the previous patch
looks too strict instead.  bpf_clamp_scev_regs() takes the bounds from the
entry reg but keeps the range of the back-edge reg, which already lost the
header rounding.

A prog that this would wrongly reject is clamp_pkt_pointer_step_lowers_umax
with PKT_PLUS_R4(0, 16) and an 8-byte load in the second iteration only.  In
the second iteration r6 = r6_entry + 8 and r6_entry + 16 <= pkt_end, so the
load is in bounds.  The clamped r6 has umax 56 and r=62, so 56 + 8 > 62 and
the load is rejected.  A verifier without scalar evolution accepts it (second
iteration r6 umax 58, r=66), and so did the scalar evolution code before the
previous patch.  Should the clamp start from the entry reg's range so that
the rounding is subtracted only once?

This was derived by reading the code, not by running the test.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40578692597
--===============5077807729473474553==--
