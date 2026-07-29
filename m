Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC23009D4
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341900; cv=none; b=Mcr99sj3SVIUEtZfOeqOzOZW/3VRe6RFlKiVB0s7RyPrHxgUgw5UOSvC6+0q94NrrmDM89LMQQMDJFSb9nLs61V6LHuMtcFC3y6AnHZ9qRAT1UAgCOQgDRQORe6nUZB686+AfJI69KkUHMgx1xh24breghVNDS5wMBYzpJrjcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341900; c=relaxed/simple;
	bh=3Hwwn/JAcq3R93jm+wPT7OHhaMnLI0ZBaDmqylw4uDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPymeZUKRw5iBE+QVXEgqAnJcPNoQmQbwx0pmYiGFzmxrPfi31SPwkwMMfpYDx0AGVvsx9GTDbARSgNpv4LyKWpdaGBsBefSGoHKfMuyUpyGAp3ldPn2+6OZpskjJ3NWAfwXWsUeaDKD5V/ZSllVAD6WMLDRdfktvSyNmC1XlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/0DUmQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/0DUmQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AB21F000E9;
	Wed, 29 Jul 2026 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785341898;
	bh=g9lflhLSD5u77xD944Y5namx4jkf7MWKJEfJW4P8iU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/0DUmQ2FkvAM9uaDts1afWq1Xq02iOXYod3SgMC3/KHOH5Y/jx21ImWbUyXVdDob
	 GR8cBDdd83zrRDyyOU1L0zETDbNNM0XifX9dMxCXO5QvNZLQY2J9kEB2uFtN+Xb2oy
	 r/Ww3WXZ4k/mgEqYLt4YUduercZJrNC1Mnz/6qpExGqkx2YxmQF7NuRa15o1MMF0Bb
	 tzKyO0OhfKBpRn5t4Wm0chMcZF/vIst4DvFAXciA/X8E8G8k2773FA/oh4aFvII3ZS
	 nm2xyu4BxtXD1Vvaluo+UGhy152GDXl4Jznrk0QoCkOy2dOuKsakT+tEBffbocKT2B
	 6XRqEjxvkjDHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] powerpc64/bpf: Fix build break for
 arch_bpf_timed_may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
References: <cover.1785339155.git.skb99@linux.ibm.com>
 <c57271230ed1c33fffe0704de86d2ee8a557a553.1785339155.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:18:18 +0000
Message-Id: <20260729161818.A5AB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The assembly trampoline `arch_bpf_timed_may_goto` saves BPF re=
gisters in the callee's parameter save area, exposing them to silent corrup=
tion by the C function `bpf_check_timed_may_goto`.
--

--- Patch [2]: [PATCH 2/2] powerpc64/bpf: Fix build break for arch_bpf_time=
d_may_goto ---
commit 991cd0fd25b432c448bce574ccb7dc7d8af6d3a2
Author: Saket Kumar Bhaskar <skb99@linux.ibm.com>

powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto

With CONFIG_PPC_KERNEL_PCREL enabled, calling bpf_check_timed_may_goto()
using a bl instruction results in a link-time failure. This commit replaces
the direct 'bl' call with the CFUNC() macro to properly annotate the call,
avoiding the TOC restoration linker error.

> diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf=
_timed_may_goto.S
> index 6fd8b1c9f4ac8..84ecf6fa7f5dc 100644
> --- a/arch/powerpc/net/bpf_timed_may_goto.S
> +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> @@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>  	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
>  	 */
>  	add     r3, r31, r12
> -	bl      bpf_check_timed_may_goto
> +	bl      CFUNC(bpf_check_timed_may_goto)

[Severity: Critical]
This is a pre-existing issue, but does this function corrupt the saved BPF
registers by placing them in the callee's parameter save area?

In arch_bpf_timed_may_goto, the stack frame is allocated with 112 bytes, and
the BPF registers are saved from offsets 32(r1) to 72(r1):

    stdu    r1, -112(r1)
    ...
    std     r3, 32(r1)
    ...
    std     r8, 72(r1)

According to the PowerPC64 ELF ABI, offsets 32(r1) to 95(r1) in the caller's
frame are the parameter save area reserved for the callee.

When we call the C function bpf_check_timed_may_goto(), the compiler is
allowed to use this parameter save area (e.g., to spill the 'p' argument
when it calls ktime_get_mono_fast_ns()). If it does, it will silently
overwrite the saved BPF registers.

Upon return from bpf_check_timed_may_goto(), arch_bpf_timed_may_goto
restores these registers, which could now hold corrupted values:

    ld      r3, 32(r1)
    ...
    ld      r8, 72(r1)

Could this lead to silent data corruption or panics during BPF program
execution?

> =20
>  	/* Put return value back into AX */
>  	mr      r12, r3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785339155.gi=
t.skb99@linux.ibm.com?part=3D2
