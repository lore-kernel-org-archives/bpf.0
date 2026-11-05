Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897666;
	b=KJw5LlU8VIDyupma/qw/Ti9WSp89bxrP8HGwOuwyV9OOCizjxXamYTLKCULQgcKH4++b
	 QVZoj/JXg/XVRNqJoMtGv5ajYKJg1VH6X2Aa+zEzyF8YDcXJwY8PSJQbfHq6Swlto5Yr/
	 0tic6cPSOtrln9qOtnwwOFQvhFuRVHhnjpZFS9JvfWckf6N8z27N8BXPiRGl6UAotzlc9
	 MLAOew7/BusjLRgGdeL5m2CbLfkhzD7C3NHhMrcGF0Gp39535vCD0b2J2clStMQTp+Ao0
	 /ZE5Wc+BX/EIisUmnMzlesM7EonXyFZ0bPM/ZLuzQ5W7K8a1ny1Y3RIxljMtcHuXCLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SSqaSgRbmAYc3RBRQCMq6UhvYDQQrS1zI5i3XLTAkcA=;
	b=5nOQ5G3ZEra1M7F7FOKV6D+KVqTWflkciUFCVmaoegsJYdBO/o0+lmin6uHR0hPjBsDw
	 C6OOgj/zibM3lPTTI28A/kPYszx/oJxhNnhzBibVoPz2V5lRlp9Y9FSfBZUWl+KSD7NKz
	 tlmh82oXflEa6nnqqPTElVUA1830/Y5fMCbxpm7Z/TIhsNf7kvEoyI9UUeyFxLV667P2I
	 w/azanmQFmKKYEwmMhNitHpH2LE/cz/X+l62ULkEe8De9jOPHPkHcyVOIDtbzqubzuq9/
	 DlueRVMXtQ3WLv29l1e2QwEzgRJvC1u0FTQwyD8Dgns7RAfOBFI1kpoYkwUYCFGLMiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZLbHI7K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDF606A328;
	Thu,  5 Nov 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZLbHI7K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7798E1F000C1;
	Thu,  5 Nov 2026 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793897665;
	bh=SSqaSgRbmAYc3RBRQCMq6UhvYDQQrS1zI5i3XLTAkcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZLbHI7KJ3Kb/GgaGpuia7dEQIGaFxwhcp39Wv21HvA5sW3PyBQCjK3bI8l8udVfC
	 gKNl7RGbOZj+2q+B4z+WMQarD3ktXyJ9r1Ud5C3XXYDa25H17qdjKpBoo4LuBZcMox
	 P29Mc0ykFUaIDNnvgErz/+lzNtXd6qiPQut2f2bFh5Fo3yx6xaCamuIc2+BO0SwX7c
	 Hh8CFyLi3pF6/ZPFofawhVnYeyEJf9Q5lI+WkbooQjRMQyQt+XZBftZy0mqk3+Owen
	 YZsXO8L8fXXs8Yun1mzcmReQttxnIXzpI7LVJnktjwgTzHK1wOokB8hmq18fQciEZX
	 1mD6cwv+7oR5A==
Message-ID: <sashiko-outbox-199556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] riscv: probes: reject probes inside an LR/SC
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-lrsc-only-v5-3-f0648f57b2e1@mobileye.com>
References: <20261105-lrsc-only-v5-0-f0648f57b2e1@mobileye.com>
 <20261105-lrsc-only-v5-3-f0648f57b2e1@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:54:25 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] riscv: probes: arch_check_kprobe() falsely rejects probes after =
__cmpwait()
--

commit 4dd5cb2e2ba32786ac861a461730851e4daa6b77
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: probes: reject probes inside an LR/SC sequence

This commit updates the RISC-V kprobes and uprobes instruction decoders and
validators to reject probes placed on or between load-reserved (lr) and
store-conditional (sc) instructions, preventing infinite retry loops caused
by breakpoint traps clearing the hart's reservation.

> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 9e2afabf94e80..9c2284eafae90 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
[ ... ]
> @@ -61,9 +70,18 @@ static bool __kprobes arch_check_kprobe(unsigned long =
addr)
> =20
>  	while (tmp <=3D addr) {
>  		if (tmp =3D=3D addr)
> -			return true;
> +			return !in_lrsc;
> +
> +		insn =3D *(u16 *)tmp;
> +		if (GET_INSN_LENGTH(insn) =3D=3D 4) {
> +			insn |=3D (u32)*(u16 *)(tmp + 2) << 16;
> +			if (riscv_insn_is_lr(insn))
> +				in_lrsc =3D true;
> +			else if (riscv_insn_is_sc(insn))
> +				in_lrsc =3D false;
> +		}
> =20
> -		tmp +=3D GET_INSN_LENGTH(*(u16 *)tmp);
> +		tmp +=3D GET_INSN_LENGTH(insn);
>  	}

[Severity: Medium]
Can this leave in_lrsc stuck at true for the rest of a function after an
inlined __cmpwait() sequence?

In arch_check_kprobe(), in_lrsc is set to true whenever riscv_insn_is_lr()
matches an lr.w or lr.d instruction, and is only cleared when
riscv_insn_is_sc() matches an sc.w or sc.d instruction.

However, when CONFIG_RISCV_ISA_ZAWRS is enabled (which is default y),
__cmpwait() in arch/riscv/include/asm/cmpxchg.h uses lr.w or lr.d paired wi=
th
wrs.nto and no sc instruction to implement smp_cond_load_relaxed(),
smp_cond_load_acquire(), and atomic_cond_read_*():

	case 4:
		asm volatile(
		"	lr.w	%0, %1\n"
		"	xor	%0, %0, %2\n"
		"	bnez	%0, 1f\n"
			ZAWRS_WRS_NTO "\n"
		"1:"
		: "=3D&r" (tmp), "+A" (*(u32 *)ptr)
		: "r" (val));
		break;

When register_kprobe() -> arch_prepare_kprobe() -> arch_check_kprobe() walks
past an inlined __cmpwait() in functions such as try_to_wake_up(),
queued_spin_lock_slowpath(), or osq_lock(), won't in_lrsc remain true after
the wrs.nto and cause arch_check_kprobe() to falsely reject kprobes on all
subsequent instructions in that function (unless an unrelated sc happens to
appear before addr)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-lrsc-only-=
v5-0-f0648f57b2e1@mobileye.com?part=3D3
