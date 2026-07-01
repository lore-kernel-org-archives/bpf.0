Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61C1A0BF3;
	Wed,  1 Jul 2026 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782882358; cv=none; b=ejuT3LHBeSHqt+Pi9BD5m0WMXirp+tcqesVXpmGoiNEA0PavziPB2KN8JCJvxAyb6PkDaN7/jhaU8YmaWUHFbdn8BGEh+6hcl1JGXoGczP7Dgfi1NYWJXeO7h/1e8jKXwDhgk3vJPxXwdyCVjOZl6BL1Cm5oY3LC1EykTQ+E0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782882358; c=relaxed/simple;
	bh=u58eJlHKQ8NVdj3jMaVgB4kaqGpjNVYB5bWjrceF3QY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uHNKzP3eN0htrnsplto61yVcg4d5YGs8VTnGheBsqcAVUxbjaSc8OxiWAsGPrSFj+01DPhIUkp5zOBqenhwpAN7GCeavD9ofBVl8djYd6BcfTgK0ihJXoysCnHueplFD5utspj5wVb9HZEzyC3riIglmPQsqbX0hyfyFKCP+0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRXPPDS0 reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRXPPDS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F4D1F000E9;
	Wed,  1 Jul 2026 05:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782882357;
	bh=cR1e3wgK4GDElvt4FzjPKvAbM9xG45FsEr5FNPN0UPE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mRXPPDS0ZZjbX/ABIk8RUZppNUKF2fdO+GefAa2ypmx1NYKWKqfKz6gkbybOlP9El
	 Fsq1M/qn7hn6nUob/mTvGscUqIhCvWtpQxLlXRyVZpf7l3N+dLRu41rfRKAd9ROi7S
	 PprfyhyxOIoPj2rM5rUT+Uyvt25W3eC7DMjzbpyz69Oo/cwcCuwLJSCPH747I/ulFy
	 Zy50Tj8K1lcvUxHAaDO8kDI6oNYQ/nxp3XoZ6L1zuxP2ZIQfz1YjhRqJ/VBnqG+I1B
	 TleHoSF3LcqFyOSkj4KFCE+uHtseQYfeUW6v1CEY1rBTHOS4oiiKYk6pz3bjWeCD5u
	 OcZpLy/5jMOGg==
Content-Type: multipart/mixed; boundary="===============4104290110149668795=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf03528b891e5f09ec46d075649474ce5f2228e80afe1d6fe5481789e9dca9d3@mail.kernel.org>
In-Reply-To: <d6afed2c271de42efe2a3580ea30c7601cae9c0c.1782877663.git.cuiyunhui@bytedance.com>
References: <d6afed2c271de42efe2a3580ea30c7601cae9c0c.1782877663.git.cuiyunhui@bytedance.com>
Subject: Re: [PATCH v5 2/3] riscv: introduce percpu.h into include/asm
From: bot+bpf-ci@kernel.org
To: cuiyunhui@bytedance.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,dennis@kernel.org,tj@kernel.org,cl@gentwo.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,thuth@redhat.com,ajones@ventanamicro.com,ben.dooks@codethink.co.uk,rkrcmar@ventanamicro.com,cuiyunhui@bytedance.com,samuel.holland@sifive.com,zong.li@sifive.com,conor.dooley@microchip.com,tglx@kernel.org,debug@rivosinc.com,seanwascoding@gmail.com,andybnac@gmail.com,menglong8.dong@gmail.com,cyrilbur@tenstorrent.com,wangruikang@iscas.ac.cn,atishp@rivosinc.com,apatel@ventanamicro.com,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,arnd@arndb.de,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,qingfang.deng@siflower.com.cn,linux-arch@vg
 er.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 05:05:56 +0000 (UTC)

--===============4104290110149668795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
> new file mode 100644
> index 000000000000..46f1901d3bb8
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h
> @@ -0,0 +1,283 @@

[ ... ]

> +#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr, asm_op)			\
> +static inline void __percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
> +{												\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
> +		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
> +		asm volatile ("amo" #amo_insn #sfx " zero, %[val], %[ptr]"			\
> +			: [ptr] "+A"(*(val_type *)ptr)						\
> +			: [val] "r"((val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz)))	\
> +			: "memory");								\
> +	} else {										\
> +		u32 *ptr32 = PERCPU_8_16_GET_PTR32(ptr);					\
> +		const unsigned long shift = PERCPU_8_16_GET_SHIFT(ptr);				\
> +		const u32 mask = PERCPU_8_16_GET_MASK(sz) << shift;				\
> +		const val_type val_trunc = (val_type)((new_val_expr)				\
> +					   & PERCPU_8_16_GET_MASK(sz));				\
> +		u32 retx, rc;									\
> +		val_type new_val_type;								\
> +												\
> +		asm volatile (									\
> +			"0: lr.w %0, %2\n"							\
> +			"and %3, %0, %4\n"							\
> +			"srl %3, %3, %5\n"							\
> +			#asm_op " %3, %3, %6\n"							\
> +			"and %3, %3, %8\n"						\
> +			"sll %3, %3, %5\n"							\
> +			"and %1, %0, %7\n"							\
> +			"or %1, %1, %3\n"							\
> +			"sc.w %1, %1, %2\n"							\
> +			"bnez %1, 0b\n"								\
> +			: "=&r"(retx), "=&r"(rc), "+A"(*ptr32), "=&r"(new_val_type)		\
> +			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(~mask),			\
> +			  "r"(PERCPU_8_16_GET_MASK(sz))						\
> +			: "memory");								\
> +		}										\
> +}

[ ... ]

> +#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_expr)			\
> +static inline val_type __percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
> +{												\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&						\
> +		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {				\
> +		register val_type ret;								\
> +		asm volatile ("amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"			\
> +			: [ptr] "+A"(*(val_type *)ptr), [ret] "=r"(ret)				\
> +			: [val] "r"((val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz)))	\
> +			: "memory");								\
> +		return ret + (val_type)((new_val_expr) & PERCPU_8_16_GET_MASK(sz));		\
> +	} else {										\
> +		u32 *ptr32 = PERCPU_8_16_GET_PTR32(ptr);					\
> +		const unsigned long shift = PERCPU_8_16_GET_SHIFT(ptr);				\
> +		const u32 mask = (PERCPU_8_16_GET_MASK(sz) << shift);				\
> +		const u32 inv_mask = ~mask;							\
> +		const val_type val_trunc = (val_type)((new_val_expr)				\
> +					   & PERCPU_8_16_GET_MASK(sz));				\
> +		u32 old, new, tmp;								\

This isn't a bug, but the two LR/SC fallback loops name the same roles
differently.  The non-return loop uses:

	u32 retx, rc;
	val_type new_val_type;

while the return loop above uses:

	u32 old, new, tmp;

The loaded word, the scratch/merge register and the computed field play the
same role in both loops.  Could they use one consistent set of names (e.g.
old/new/tmp) so the two loops read as clearly parallel?  As a smaller point,
new_val_type reads like a type name rather than a value, and new shadows a
common keyword.

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

This isn't a bug, but the read-modify-write LR/SC sequence here is nearly
identical to the one in PERCPU_8_16_OP, differing only in operand numbering.
The non-return loop parameterises the operation via #asm_op, but this loop
hardcodes add:

	"add %1, %1, %6\n"

Was the intent to keep the return path add-only, or could the two loops share
one templated sequence?

> +			: "=&r"(old), "=&r"(tmp), "=&r"(new), "+A"(*ptr32)			\
> +			: "r"(mask), "r"(shift), "r"(val_trunc), "r"(PERCPU_8_16_GET_MASK(sz)), \
> +			"r"(inv_mask)								\
> +			: "memory");								\
> +		return (val_type)(tmp >> shift);						\
> +	}											\
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28494034360
--===============4104290110149668795==--
