Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60A23B61B
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959993; cv=none; b=VoIvW0ZF1a65WqBkI2e/vBm9POANWJScYpM/E0jm1qYrt5pEdFwXEbrHTWZEc5ijp0KPz0LM/ugBIKryKwR4wxG1lFis4UKVjugVcNl9y+yS9tmUJEaf2Qr9mI7BSJB8ZurNU9PTa89goaBRkEnA9siFekFzgB9y4GVRmMOrm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959993; c=relaxed/simple;
	bh=JYqEJ5tHy/mSuXAPLZxjkAdJ0q066KsHKiGj9yKtbU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DYqwolfKIBKvx1QvbQxYPFV3pthUKyiMsxT/omx4w9wyUVUL+0BiCduhoz71HBXM4CoCA/PuuDPUfOnfAJcEKGHlAiPZZwGvPAcyjfwCw+IiCWC64mPD5JmW3yZeznuJ5xIYBMNc52F+ePXXOWqDYmBjYCPKL7890y96m+p5UhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDW13+s6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDW13+s6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAED1F000E9;
	Thu,  2 Jul 2026 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782959992;
	bh=zMrXWT1QFN6ljk7iOBMOppQJCYWa3Qr40/ApNUgIcI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDW13+s6eBlbPVmDNWBg8cDvWw2ufngvdxPfJR1NEyLwrL6/dWSnyHbyxebpxpbFl
	 wF+W9s5u5TVKQQxYoaUTxs477LD/X8aMT/DAqv1Tr+C2VzkoWyN86iStFw2efS/jZu
	 /0lWa/OhXRndJKg+KdDHP+f8OWibZHDJkA3AlRYlDACRbWu79lp6qhjkmtn0DzD7RO
	 iZgRYWw/lbBPRbewvSH/rf31w6WtqI0VB+LljM21lhRbDH0mWVhg8WsA6GHC6ka36b
	 5aoG7ZSokbvX1VAyPaZKmpWfkBE2+pwgsA5wAvUZiiRltcgi5noH82dLUu4vqF9ppS
	 ux+LnPWPl3r1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 05/11] LoongArch: BPF: Add exceptions
 (bpf_throw) support
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702022322.51033-6-dongtai.guo@linux.dev>
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-6-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:39:51 +0000
Message-Id: <20260702023951.DFAED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The BPF frame pointer ($r22) can be clobbered by bpf_throw() befor=
e it is captured, causing stack unwinding to fail and crash.
- [Low] Multi-line comment does not follow the required BPF kernel comment =
style.
--

commit a22e7d51563237179d5ffdc8ffe6290c25f1ddba
Author: George Guo <guodongtai@kylinos.cn>

LoongArch: BPF: Add exceptions (bpf_throw) support
   =20
This patch implements BPF exception support for LoongArch. It introduces
arch_bpf_stack_walk() to find the exception boundary frame using the ORC
unwinder, allowing bpf_throw() to properly unwind the stack and invoke
the exception callback.

> diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/s=
tacktrace.c
> index 387dc4d3c4868..718c98b3f1fc4 100644
> --- a/arch/loongarch/kernel/stacktrace.c
> +++ b/arch/loongarch/kernel/stacktrace.c
[ ... ]
> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp),
> +			 void *cookie)
> +{
> +	unsigned long fp;
> +
> +	/*
> +	 * Capture the live frame pointer ($r22/$fp) here, before handing off to
> +	 * the worker. The kernel is built with -fomit-frame-pointer, so $fp is
> +	 * an ordinary callee-saved register that is preserved across the call
> +	 * from the JITed BPF program into bpf_throw() down to here, and thus
> +	 * still points at the innermost BPF frame. The ORC frame-pointer
> +	 * fallback walks the BPF frames up to the exception boundary from it.
> +	 *
> +	 * This must be a thin wrapper with no large stack locals: the worker
> +	 * uses $r22 to address its frame, which would clobber the live $fp
> +	 * before it could be read. __builtin_frame_address() cannot be used
> +	 * either, as it is $sp-derived and would yield a kernel-stack frame.
> +	 */
> +	asm volatile("move %0, $r22" : "=3Dr"(fp));
> +	walk_stackframe_bpf(consume_fn, cookie, fp);
> +}

[Severity: High]
Can the C compiler clobber the BPF frame pointer ($r22) before this inline
assembly captures it?=20

Because the kernel is built with -fomit-frame-pointer, the compiler is free=
 to
use $r22 as a general-purpose callee-saved register. If the intermediate C=
=20
caller (bpf_throw) modifies $r22 during its execution, this assembly will=20
capture the clobbered value instead of the BPF frame pointer.

If the frame pointer is clobbered, the ORC unwinder will fail to find the
exception boundary, leaving ctx.aux as NULL. bpf_throw() then unconditional=
ly
dereferences ctx.aux, which would cause a kernel panic.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3822e05a07790..f172ffc2c011c 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -29,16 +29,20 @@
> =20
>  static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
>  {
[ ... ]
> -	/* An arena program reserves one extra word above them (REG_ARENA),
> -	 * which pushes the tail call count pointer down by one slot.
> +	/* An arena or exception program reserves one extra word above them
> +	 * ($s6, see build_prologue()), which pushes the tail call count
> +	 * pointer down by one slot.
>  	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
comment style? The BPF subsystem requires the opening /* of a multi-line
comment to be on its own line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702022322.5103=
3-1-dongtai.guo@linux.dev?part=3D5
