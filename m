Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00137BE6D
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965997; cv=none; b=YqycdDJbBe+89bBq7M0o9lDY+nJpJAagw0RN3rmsXaPnZJ4GAy+1e0qSiReCnZ7YzQoE+l3IWZ/RPHWnqyfvNB5lQZlbgeP1Ug3lFlLGxhhsMwkT1A7WTMjVtxgt/TBeZiP7WqbsolOigyN6lBfZvqMKkoTerfAklXyWeUoE2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965997; c=relaxed/simple;
	bh=5ewo0bnTOBrJZ7AmcZh4521IXih7mlge49O8K2sZIzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCkGwRsKNo9P4gjGG68WkcYxBIzYDA2ntjobWKNnlyyVg9RpxqtkknDkwNKmgkpAqghqhP55PksHgB8AlAJTByx0kO5+e+u2sDPvEGX+o/FCsrrLSMemuIdu5moiaAkympDakVsH/HgipFKNG4ZeR/IqzpNph4izGTqzuay2h9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtR+hWM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtR+hWM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27923C2BCB4;
	Tue,  5 May 2026 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777965997;
	bh=5ewo0bnTOBrJZ7AmcZh4521IXih7mlge49O8K2sZIzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qtR+hWM4atKGuPVucb9JsOI+8xKX8XiXb60NjgpoFFOgHRDv1ygQZb23SwILa7d+F
	 yIbsFew2T0QIDfxduFC7kp4IXY9I+1tJqzt0kWQ58amtLpEwkSof+BYMyOtJQw2hmM
	 HwdonvK0zlOg5Ieen36/mAuezN7c/Qt8qFXsRiAnnwBsYKhOcrBmb9ZJy37goUcvz+
	 PiP0vnkeHhFofKiciaIgsBrfZWJvlcbrwBHavScd3geguwilASw6R/0tZg3nGqNwI6
	 nVJ04z9VPEWWy7fPtUcDl+TyDg4OV7opL6cxfXN670nRkfB+N9NZakXmjG0u2Kzz56
	 JGVQ0qnCBuqtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] riscv: introduce percpu.h into include/asm
Reply-To: sashiko@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505062026.91724-3-cuiyunhui@bytedance.com>
References: <20260505062026.91724-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 07:26:34 +0000
Message-Id: <20260505072635.27923C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The 8-bit and 16-bit `this_cpu_add` fallback logic fails to ma=
sk arithmetic overflow, corrupting adjacent percpu variables.
- [High] The 32-bit and 64-bit `this_cpu_and` macros incorrectly perform an=
 AND-NOT operation instead of a bitwise AND.
- [High] Missing early-clobber modifiers (`=3D&r`) on output operands in `P=
ERCPU_8_16_RET_OP` allow destructive register overlapping.
--

commit f4a490dc0b24e17cbd874e03d02e506d017e61b6
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: introduce percpu.h into include/asm

This commit introduces a RISC-V percpu header to implement direct this_cpu
operations. It provides macros for 8, 16, 32, and 64-bit read, write, and
atomic memory operations.

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/per=
cpu.h
> new file mode 100644
> index 0000000000000..3b26fe45e70f4
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h

[ ... ]

> +#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr, =
asm_op)			\
> +static inline void __percpu_##name##_amo_case_##sz(void *ptr, unsigned l=
ong val)		\
> +{												\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
> +		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
> +		asm volatile ("amo" #amo_insn #sfx " zero, %[val], %[ptr]"			\
> +			: [ptr] "+A"(*(val_type *)ptr)						\
> +			: [val] "r"((val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz)))	\
> +			: "memory");								\
> +	} else {										\
> +		u32 *ptr32 =3D PERCPU_8_16_GET_PTR32(ptr);					\
> +		const unsigned long shift =3D PERCPU_8_16_GET_SHIFT(ptr);				\
> +		const u32 mask =3D PERCPU_8_16_GET_MASK(sz) << shift;				\
> +		const val_type val_trunc =3D (val_type)((new_val_expr)				\
> +					   & PERCPU_8_16_GET_MASK(sz));				\
> +		u32 retx, rc;									\
> +		val_type new_val_type;								\
> +												\
> +		asm volatile (									\
> +			"0: lr.w %0, %2\n"							\
> +			"and %3, %0, %4\n"							\
> +			"srl %3, %3, %5\n"							\
> +			#asm_op " %3, %3, %6\n"							\

Is it possible for an 8-bit or 16-bit addition to overflow here? If there a=
re
carry bits outside the subword boundary, they aren't masked out before the
result is shifted left.

Could this silent overflow spill into and corrupt adjacent per-CPU variable=
s?

> +			"sll %3, %3, %5\n"							\
> +			"and %1, %0, %7\n"							\
> +			"or %1, %1, %3\n"							\
> +			"sc.w %1, %1, %2\n"							\
> +			"bnez %1, 0b\n"								\
> +			: "=3D&r"(retx), "=3D&r"(rc), "+A"(*ptr32), "=3D&r"(new_val_type)		\
> +			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(~mask)			\
> +			: "memory");								\
> +		}										\
> +}

[ ... ]

> +#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_ex=
pr)			\
> +static inline val_type __percpu_##name##_return_amo_case_##sz(void *ptr,=
 unsigned long val)	\
> +{												\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
> +		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\

[ ... ]

> +	} else {										\
> +		u32 *ptr32 =3D PERCPU_8_16_GET_PTR32(ptr);					\
> +		const unsigned long shift =3D PERCPU_8_16_GET_SHIFT(ptr);				\
> +		const u32 mask =3D (PERCPU_8_16_GET_MASK(sz) << shift);				\
> +		const u32 inv_mask =3D ~mask;							\
> +		const val_type val_trunc =3D (val_type)((new_val_expr)				\
> +					   & PERCPU_8_16_GET_MASK(sz));				\
> +		u32 old, new, tmp;								\
> +												\
> +		asm volatile (									\
> +			"0: lr.w %0, %3\n"							\
> +			"and %1, %0, %4\n"							\
> +			"srl %1, %1, %5\n"							\
> +			"add %1, %1, %6\n"							\
> +			"and %1, %1, %7\n"							\
> +			"sll %1, %1, %5\n"							\
> +			"and %2, %0, %8\n"							\
> +			"or %2, %2, %1\n"							\
> +			"sc.w %2, %2, %3\n"							\
> +			"bnez %2, 0b\n"								\
> +			: "=3Dr"(old), "=3Dr"(tmp), "=3D&r"(new), "+A"(*ptr32)			\

Should the old and tmp output operands use the early-clobber modifier (=3D&=
r)?

Since they are written to early in the instruction sequence before inputs
like mask (%4), shift (%5), or val_trunc (%6) are consumed, could the compi=
ler
allocate them to the same physical registers, leading to clobbered inputs?

> +			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(PERCPU_8_16_GET_MASK(sz)=
), \
> +			"r"(inv_mask)								\
> +			: "memory");								\
> +		return (val_type)(tmp >> shift);						\
> +	}											\
> +}

[ ... ]

> +#define this_cpu_and_1(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_8=
, pcp, ~(val))
> +#define this_cpu_and_2(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_1=
6, pcp, ~(val))
> +#define this_cpu_and_4(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_3=
2, pcp, ~(val))
> +
> +#ifdef CONFIG_64BIT
> +#define this_cpu_and_8(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_6=
4, pcp, ~(val))
> +#endif

Since the underlying __percpu_andnot_amo_case_32 and 64 macros directly use=
 the
amoand instruction on the value passed, does negating val here with ~(val)
cause the hardware to perform an AND-NOT operation (pcp &=3D ~val) instead =
of a
bitwise AND (pcp &=3D val)?

> +
> +#define this_cpu_or_1(pcp, val)	_pcp_protect(__percpu_or_amo_case_8, pcp=
, val)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505062026.9172=
4-1-cuiyunhui@bytedance.com?part=3D2
