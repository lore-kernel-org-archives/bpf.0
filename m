Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986797;
	b=aXMVcPm5KWvQ6FwA4GcZDEV6hhRrKS2ay8O7r6ooLxIaeku0m+14rQIyCYAdiSQVHmpJ
	 Qwy0266gDKBfPtol7AkT0zGKJiQZHTaq/YSCHQTAy346bSqRau6/EPfGHh0xu1fiXnDIx
	 ZQ6hm8GHpKwgAwQjR6WbAtMz9XRn/s0Go2NC8tCk0RoylUR9Grb1U/boKjLFlSdvkTW6L
	 JVopnLEafRIAnW/md+bzPNgUO3tWgms71899xMqvq2JKzetsNC/KHJtNYd71vwsW3C7T5
	 +H53oWJYL/ekSZ4leawlJO/mN2aqOGQXMdJaMIPbzj5z4HWk+AoffG+VsaIdU+464HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986797;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ddbQeZADm9UHgBr9oDthiCtyhwXSGmkPd0DwDo2UVb8=;
	b=0qyi2y2WQ1s770cVpOfqiGs/ZS8W/JHS0Auqb7/20Jvwq2Q5c1bsSZ5npKLNHgeLT6t3
	 C1WDecPIuwdyDEWgAzfjYkioCXkLg3UuHq2NHaQM+BvthC7jnphOg7CxHaL/EtMScy7Lj
	 2mWShEMlEN8gHATFD8FKCLRtzRiuFzFhIPw0leV8BjXCNUS6p1pBfLtZb2RXb/YKpQdBA
	 X3DgCGHDWN8RSclcrSelb1orPJqziBzuL1852Lzdxre3X9X3T2poMhaeBX9CAQgkGIdLr
	 A7YF8Ni7tex77MQJcG4251D9kx7xUT4nfsI2yuwrTN64Dm62dNtEZGr7E8XNbNAR8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipPVsgRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64330606A323
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipPVsgRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D401F01825;
	Mon, 26 Oct 2026 03:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986797;
	bh=ddbQeZADm9UHgBr9oDthiCtyhwXSGmkPd0DwDo2UVb8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ipPVsgRD6oQFDUV0PKFPyKWTsblJOH5Bf5XrQI3U3RnkfMoQ+avorfjw+JNuLnht3
	 +KRjEV+HtZ0WW78e2oLF/0WNt5Ty1ixdd3hEb2Agqp3SHGK83b0hkB9XwN+Tom5w2I
	 XsDn2TKVeFpFR8v6oP/B2RD6sRrK34DhRCcYVszngbiD390DCdked1M4CpgJ3Md+nV
	 ZBW0ktN2Shb/j4JtOVa6guUptxdVR3ie82EGYzLOGbYdC5mv9LMZgTcHrrmiSRC54U
	 ahbh5DMvHTBY0aVQBcS8ZdlzpjZOF9jye1PlhnsuvPG/70WT+S09CUbyLj1Z39s8TK
	 XTAEUhHcB0PvA==
Content-Type: multipart/mixed; boundary="===============6895279405081666600=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3d8c6e36b30309c183b6b096f97524d381be9a0d34ec149f631bf351012228bb@mail.kernel.org>
In-Reply-To: <20261026025943.404450-71-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-71-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 70/81] selftests/bpf: Adjust tests of precision tracking
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:17 +0000 (UTC)

--===============6895279405081666600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Adjust tests of precision tracking

TL;DR:
- Test issue: stack_slot_aliases_precision may index the stack (R1=fp-4)
  instead of vals, as r7/r8 are missing from clobbers
- Nit: comments still describe the removed precision backtracking

> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index dc0c7034c04f..3f9a65ff134e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c

[ ... ]

> @@ -604,9 +436,7 @@ __naked int parent_stack_slot_precise_with_callback(void)
>  
>  		"r6 *= 4;"
>  		"r1 = %[vals];"
> -		/* here r6 is forced to be precise and has to be propagated
> -		 * back to the beginning, handling (and ignoring) subprog call
> -		 */
> +		/* here r6 has to be known: the subprog call doesn't change it */

this isn't a bug, but the new comment here says "the subprog call doesn't
change it" in a prog that calls bpf_loop() with a callback, while the
register variant (parent_callee_saved_reg_precise_with_callback) says "the
callback doesn't change it".

The comments next to the rewritten ones still describe the removed
backtracking, for example in this prog:

    /* ensure we have callback frame in jump history */
    ...
    /* restore reg from stack; in this case we'll be carrying
     * stack mask when going back into subprog through jump
     * history
     */

and "complicate jump history" in parent_callee_saved_reg_precise,
parent_callee_saved_reg_precise_global, parent_stack_slot_precise and
parent_stack_slot_precise_global.

Since jump history and stack masks no longer exist, should these be
reworded along with the "here r6 has to be known" comments?

[ ... ]

> @@ -730,32 +533,12 @@ __naked int subprog_spill_into_parent_stack_slot_precise(void)
>  
>  SEC("?raw_tp")
>  __success __log_level(2)
> -__msg("17: (0f) r1 += r0")
> -__msg("mark_precise: frame0: regs=r0 stack= before 16: (bf) r1 = r7")
> [ ... ]
> -__msg("mark_precise: frame0: regs=r0 stack= before 6: (07) r7 += -8")
> -__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r7 = r10")
> [ ... ]
> +__msg("17: (0f) r1 += r0                     ; R0=4 R1=fp-4")
>  __naked int stack_slot_aliases_precision(void)
>  {
>  	asm volatile (
> [ ... ]

> @@ -777,11 +560,10 @@ __naked int stack_slot_aliases_precision(void)
>  		"r0 = *(u64 *)(r8 + 16);"
>  		"*(u64 *)(r7 - 8) = r0;"
>  		"r0 = *(u64 *)(r10 - 16);"
> -		/* get ready to use r0 as an index into array to force precision */
> +		/* get ready to use r0 as an index into array */
>  		"r0 *= 4;"
>  		"r1 = %[vals];"
> -		/* here r0->r1->r6 chain is forced to be precise and has to be
> -		 * propagated back to the beginning, including through the
> +		/* here r0 has to be known: the constant went through the
>  		 * subprog call and all the stack spills and loads
>  		 */
>  		"r1 += r0;"

this isn't a bug, but the new __msg() expects R1=fp-4 when "r1 += r0" runs,
so r1 appears to be fp-8 here and not &vals.

The removed log lines show that "r1 = %[vals]" was compiled as "r1 = r7",
and the asm sets r7 earlier with "r7 = r10; r7 += -8".  The clobber list at
the end of the asm only names:

    : __clobber_common, "r6"

so the compiler is free to place &vals in r7 or r8, which the asm
overwrites.  The prog then reads the unwritten stack slot at fp-4 instead
of vals[1].

Should "r7" and "r8" be added to the clobbers, with R1=map_value(...,imm=4)
as the expected value?  Otherwise, should "get ready to use r0 as an index
into array" and "here r0 has to be known" be reworded to say the prog
indexes the stack?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============6895279405081666600==--
