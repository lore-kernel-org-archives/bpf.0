Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BF3F6C48
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639197; cv=none; b=K2f2uSQkKO/rWUPnRvk7rjrpRfY9b+I95E6LKp6y+AYwUXgFiGvHFq4KfNIiRT1T3pIyM+6Ksz6C+h39WuFCYUREdkmo6OKK9cHBQUBwTknhWvRau/kWuwgkRuMK4i511u65mgE5OBavVzobn/LuAmEYcxg0TQ4Xhr9GyiaOgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639197; c=relaxed/simple;
	bh=lrr4g6FU+RivDyeUGkBU/v808emUDjF2Q1MbajPODLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y1lVNHWVjBbo7rYZwDz78o+pf+iYh6oIOfWT5/uLqQHwgHdXBiXqt+tYUvlnKRZHqmLUiRJhSOEwwwS9GrFQt7UISV269u2LUeWq0sLCc1f+8hCwb0DAKX424gJoy9yLJrgU2wfvliMwTyIzJgFAIMxiMvig4NOeWiR4QtffP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuqCGwAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuqCGwAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EC81F00893;
	Fri,  5 Jun 2026 05:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639196;
	bh=Eg6Rqnce/kslX2V1vvLr1FzAXgRIVnGAUwXFv/BJ/I8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IuqCGwAAojgRBxLiO9CiKlD3XEcxVOleI3mnoTIyzI34Y2cy/1AtHAp36667+hXRf
	 Me4AFi0akZo4gEbNNLJOmH0OHLNayULvNv1tfHq81SwXCmqcWHfDIbl8uSQHj5mjRK
	 CmkzwuYViBCB3cJ726bLxoEiLB2FENbgXTVcMKIWed3vDgyeFkDLBs9DBaC7SKI4Tf
	 CJ3tR3J9Go/Rr1vV1bTEmurOyYqBRC7xK2OBFFSfYSzkVZU0gVJ79QdYaOTxp/cntf
	 MviB1ieQ0EjWLTzRowpcfgD5i5qn2lTr7g0smEsisCwmM8kFZSffwWUaVddrExEZjU
	 kUln5IYfRVOsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] preempt: Introduce
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: bpf@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260605054128.5925-11-boqun@kernel.org>
References: <20260605054128.5925-11-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 05:59:55 +0000
Message-Id: <20260605055956.46EC81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional select of `HAS_SEPARATE_PREEMPT_RESCHED_BITS` viol=
ates Kconfig dependency on `PREEMPT_COUNT`.
--

commit 0d37eeeba0d2e4fb4b795207e44eb2cab20db648
Author: Boqun Feng <boqun@kernel.org>

preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS

This commit introduces HAS_SEPARATE_PREEMPT_RESCHED_BITS to allow 64-bit=20
architectures to maintain NMI nesting bits in the 32-bit preempt count,=20
avoiding the need to maintain them outside the same cache line. It also=20
enables this feature for x86_64.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fdaef60b46d65..9a35c3a087573 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -329,6 +329,7 @@ config X86
>  	select USER_STACKTRACE_SUPPORT
>  	select HAVE_ARCH_KCSAN			if X86_64
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS		if X86_64

[Severity: Medium]
Will selecting HAS_SEPARATE_PREEMPT_RESCHED_BITS unconditionally for X86_64=
=20
cause Kconfig unmet direct dependency warnings if PREEMPT_COUNT is disabled?

Looking at the definition in kernel/Kconfig.preempt, the config symbol=20
HAS_SEPARATE_PREEMPT_RESCHED_BITS explicitly depends on PREEMPT_COUNT:

config HAS_SEPARATE_PREEMPT_RESCHED_BITS
    bool
    depends on PREEMPT_COUNT && 64BIT

Because select bypasses depends on, configuring a kernel where PREEMPT_COUNT
is disabled (e.g., PREEMPT_NONE=3Dy with no debug options) might force the=
=20
target symbol to y. Should this select be conditional on PREEMPT_COUNT?

>  	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
>  	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
>  	select FUNCTION_ALIGNMENT_4B

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D10
