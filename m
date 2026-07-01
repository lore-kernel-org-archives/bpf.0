Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA31CAA7D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782880695; cv=none; b=cG7e6POzhSqdH4wTyfpFhaZ3WyKuFI5vQLAbpXJROZ01oT7GAWdRLMmgUMrJw3QBaNSP5FTSmJKWgxyfhl9HR4+H4FL783cFzRgJdgZ4yz/gXKnVO/KXYTryqNHUVdNDsdKYJmX7sC6TNywLfJsYFF/lwlubw7CqQle+0lIOw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782880695; c=relaxed/simple;
	bh=19PMHQl/tl9HDU9cyINoh7Jp0RcLsty2mQ8UYsc0RP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FRI6yvJ2KY+179dkWjrSvqlmmMhNJb1dL7QuQEMLn376eI3Z+1+OrT2na0Fg4zSYN8IruerPLQheLCZN9MgiWTg6alJ8zVkYXIqCrsBzB/fkju4nXg2786TUfyUcQMXAlc2nKXQBgm68tdjbVol/dAgVjwQhK/ir+P+XesWtZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQvzs5x6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQvzs5x6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEB81F000E9;
	Wed,  1 Jul 2026 04:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782880694;
	bh=J57tadxDZh5GxuDfZnQqzvgj/+XKZKVUHQnqiAFtmVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQvzs5x6d/2eedIqNSlTSjSPJXOG9IV22RE79+RRaYvo38mKiIWyOx73Zuq/nO6cU
	 gtmokXrF1oTMHdvzwNAz5qsQ8SA4Gkwu7HuJs3D3SJI1ktCKhvRts1klnmohRxbwUd
	 CpJ77S5j+J9v09/yZ6vdfDGN1qnVfwMsnSh9gnrOVRTSjGIHQkEtGiuTStlHmo11Ub
	 IYIP/eM6xXPAtFKWcPq0cotaKrUYJ2LLxLOVQ7Ek8fRMhTZLXakTaxnsKSVn2Rqq0P
	 mhS9aVM6CyxAz65EP82SfJ4f+XGZ4yOcO1m4KC2uTZ9bGVLRWi8R3peVX9h1ge8nLT
	 /MpouGzE5vKwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] riscv: introduce percpu.h into include/asm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <d6afed2c271de42efe2a3580ea30c7601cae9c0c.1782877663.git.cuiyunhui@bytedance.com>
References: <cover.1782877663.git.cuiyunhui@bytedance.com>
 <d6afed2c271de42efe2a3580ea30c7601cae9c0c.1782877663.git.cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:38:13 +0000
Message-Id: <20260701043814.0FEB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `<asm/cmpxchg.h>` silently drops NMI-safe ZACAS optimizati=
on and causes arbitrary compile errors.
--

commit 81a0db6d3f915424f8959abac9007e01a81b105c
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: introduce percpu.h into include/asm

This commit adds RISC-V specific this_cpu helpers for percpu operations.
It uses AMOs for native-width operations, and Zabha or local 32-bit LR/SC
fallbacks for 8/16-bit operations.

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/per=
cpu.h
> new file mode 100644
> index 0000000000000..46f1901d3bb88
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h

[ ... ]

> +#define this_cpu_xchg_1(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp,=
 val)
> +#define this_cpu_xchg_2(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp,=
 val)
> +#define this_cpu_xchg_4(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp,=
 val)
> +
> +#ifdef CONFIG_64BIT
> +#define this_cpu_xchg_8(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp,=
 val)
> +#endif
> +
> +#define this_cpu_cmpxchg_1(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxe=
d, pcp, o, n)
> +#define this_cpu_cmpxchg_2(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxe=
d, pcp, o, n)
> +#define this_cpu_cmpxchg_4(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxe=
d, pcp, o, n)

[Severity: High]
Does this missing <asm/cmpxchg.h> include lead to build failures?

Since these macros rely on cmpxchg_relaxed, if callers expand them without
manually including the atomic headers, it looks like cmpxchg_relaxed will
be undefined.

> +
> +#ifdef CONFIG_64BIT
> +#define this_cpu_cmpxchg_8(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxe=
d, pcp, o, n)
> +
> +#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
> +#endif
> +
> +#ifdef system_has_cmpxchg128

[Severity: High]
Will this macro evaluate to false and silently drop the NMI-safe ZACAS
optimization?

Because <asm/cmpxchg.h> is not included, if a file includes <asm/percpu.h>
first (for example via <linux/spinlock.h> and <linux/irqflags.h>),
system_has_cmpxchg128 is not defined here.

Does this cause the kernel to silently fall back to
this_cpu_generic_cmpxchg?

Since the generic fallback only disables interrupts and does not block NMIs,
could this introduce a data corruption race condition if a percpu variable
is updated concurrently from both NMI and normal contexts?

> +#define this_cpu_cmpxchg128(pcp, o, n)					\
> +({									\
> +	u128 ret__;							\
> +	typeof(pcp) *ptr__;						\
> +									\
> +	preempt_disable_notrace();					\
> +	ptr__ =3D raw_cpu_ptr(&(pcp));					\
> +	if (system_has_cmpxchg128())					\
> +		ret__ =3D cmpxchg128_local(ptr__, (o), (n));		\
> +	else								\
> +		ret__ =3D this_cpu_generic_cmpxchg(pcp, (o), (n));	\
> +	preempt_enable_notrace();					\
> +	ret__;								\
> +})
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782877663.gi=
t.cuiyunhui@bytedance.com?part=3D2
