Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99E34D4FE
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033174; cv=none; b=LCC9T6ZX1jcIvX3i6XHKa1kSzyd0RMG+6EqONMbDPjmh6kPufHpF8XkkxYwoRIQNsSRodashWIwhsrdBm/LwQodxPAIXTV90h7PumIEU2tuoiFEwhrHPaafF8k7J6d5eEBQb4JPt89rpwCqtnP7T4x8gFnq7lLMe8wszJKydxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033174; c=relaxed/simple;
	bh=TwnCrAoeVyiFWJ3KP+QspY8FsG63ElTMGHDe2LkZ2Wg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLnEVySLTbkAtAyOFi5PGUZidXCYMYefVldBN9qE6Xo7zleyOD3q+WK/JaBEa5kaJl1pK0hl3RTfpXE0qA5M7glIqDNACKhPBV1US2D82XibGzjpfPBu13hqUJP7P+pKv98kQ/s7p07WblU9nkJejJOLJqmLXxvDdh5ZI0zH4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgbYkYDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgbYkYDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0C21F000E9;
	Tue, 14 Jul 2026 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784033173;
	bh=CXQzN6XP2xrKvESK8FlyvucOQhJFW6xpcNhVU7fqgnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YgbYkYDTzQ02I5rQOui/Uv7BhMvyd54K0KFfYgEJeQqePrpeodPMr9FnbxrKndpYr
	 s+BFG8tJtws4fbR173X57YpktSrmRO+d2vION23jXJHABAK4vBKNsu/iwkPiO50YGa
	 CqcrwLxxALyFLOYkySbocWdJBdCF2JHU6lP0mPS03OA409DBrEqyCe5juCIWV6kn5x
	 y/d4wsp62KWBgynxIjTjnJ23h14ZolSsbPwQa1k8HsUa/WpL//IUlmicFuE/PeBQhF
	 jyqMBVGsn+QnO0gVexV8rmF18LKaSbQocgpgy6EHRo/hQzdy2Mh95OsCjpMQmL809S
	 10SZWwIoEMzvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] bpf, riscv: add support for timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-riscv-bpf-timed-may-goto-v2-1-eeb6201aedcc@kylinos.cn>
References: <20260714-riscv-bpf-timed-may-goto-v2-0-eeb6201aedcc@kylinos.cn>
 <20260714-riscv-bpf-timed-may-goto-v2-1-eeb6201aedcc@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:46:12 +0000
Message-Id: <20260714124612.CB0C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The assembly trampoline `arch_bpf_timed_may_goto` does not set u=
p a frame pointer (`s0`), which breaks stack unwinding when `CONFIG_FRAME_P=
OINTER` is enabled and omits the BPF program from stack traces.
--

--- Patch [1]: [PATCH v2 1/2] bpf, riscv: add support for timed may_goto ---
commit 08fb72c94674edd23d2e12eda1b3dd76cb372fdc
Author: Feng Jiang <jiangfeng@kylinos.cn>

bpf, riscv: add support for timed may_goto

Implement arch_bpf_timed_may_goto() for the RV64 JIT. The argument and
return value are carried in BPF_REG_AX, and BPF R0-R5 are preserved
across the call to the generic bpf_check_timed_may_goto(). Enable
bpf_jit_supports_timed_may_goto() so the verifier uses the timed
expansion path.

> diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_tim=
ed_may_goto.S
> new file mode 100644
> index 0000000000000..f54f389d921e0
> --- /dev/null
> +++ b/arch/riscv/net/bpf_timed_may_goto.S
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2026 Feng Jiang <jiangfeng@kylinos.cn> */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +
> +/*
> + * Trampoline for the BPF timed may_goto loop bound. Custom calling conv=
ention:
> + *	- input:  stack offset in BPF_REG_AX (t0)
> + *	- output: updated count in BPF_REG_AX (t0)
> + *
> + * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, whe=
re
> + * ptr =3D BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are =
saved
> + * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
> + */
> +
> +SYM_FUNC_START(arch_bpf_timed_may_goto)
> +	addi	sp, sp, -64
> +	sd	ra, 56(sp)

[Severity: Medium]
Does this code need to set up a frame pointer (s0)?

When CONFIG_FRAME_POINTER is enabled on RISC-V, the unwinder relies on
the frame pointer to chain frames. Because arch_bpf_timed_may_goto() alloca=
tes
stack space and saves ra but fails to save the caller's s0 or update s0 to
point to its own stack frame, stack traces triggered from within
bpf_check_timed_may_goto() (or functions it calls) might omit the JITed BPF
program.

> +
> +	/* Save BPF registers R0-R5 (a5, a0-a4) */
> +	sd	a5, 48(sp)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-riscv-bpf-=
timed-may-goto-v2-0-eeb6201aedcc@kylinos.cn?part=3D1
