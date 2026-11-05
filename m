Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898207;
	b=gDOTS4csfd8Nib6d2iR9aUkajrSwPBLk9xQoB+DQT9r6eZQYQcDH3Ua+OuHD4Vl9EJWe
	 HaCTx/zDUjOivhtMGnLSTJIJ3ntcEghFv1xY3SgmlKXr6+h85Y7WB1g/i78m38xwI+Yi+
	 PGfkJMweoJxThnXsih5FaffIj6DqJyjJ5alC1BVIg1h9ME1EWo7ffbNsbzsLrgDtLT+wf
	 3IGO7nD5lKYgUPrvbaMfBwAxN1DK32Gv6DM6OH5AwHjWaHXPWA2oEVJnK6gpY0Bvwojuf
	 Cq+S1doi8QX4v9raY37krgM+D+Kd1atMTBkd+hIok33+ALAEqULoaTUAoZZ8Z9fxO/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hfztDg25paIoRz2d1klOsMoFcv9JJEbXDHV48grZ9zs=;
	b=wcbUkCs48bNTm2fqMBm+0WvEe6r+jXHydm6yzF/fBuL8LNOJ8uPLZzZyWfDfy7sCnvSn
	 9UycVJ1vxzxbUmfR/sRiwCq2FMpAfrGeA91hotRNXFztIFKj8RLf09EH7bdtjFgqnCDfn
	 Z95x/DgAJgGdMl0NnExkZp9/h/hDNulg3beOxR7wAh1Avn0iRT/M+3h2KSgaNJdUl8o7R
	 NKmhjpxuBir5Gzi3KFE24vLAAYjBNqfjapE6dV1yhCMALzOaO1pserlTKqC2mh2RLg2IC
	 rfsn+xrRqKZA6jMO0jJUPMojOIxR7JnJEuHmKMZB56GgCHWxPBGO0oPjV/cUmsKwd7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2ZCS2cj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C835606D81E;
	Thu,  5 Nov 2026 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2ZCS2cj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F251F000C1;
	Thu,  5 Nov 2026 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898206;
	bh=hfztDg25paIoRz2d1klOsMoFcv9JJEbXDHV48grZ9zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2ZCS2cje7ioHclfSeoh5Ib5zBGDsEfP45RaGAsiS0rphLWABtmeLiusiIyW/gGK9
	 ms+u7rLo/yTIuh6+wp2L19hrXXX5P/BqDRW7Jy7vRs+EoHBcE43+Y5TDfSRvUcsrx9
	 lvWT5VhmWItf10Z28Aan88rhUvuGmULNJ7p7mr7tdWRj4QG8LNyiQXRlFlc3g9eZ1V
	 FrAyvjzsE23/mt7n4RpKAvRU9T4ozPjaQZ293U2oRmXHGL09EUfEkKf/OZsMEFzwch
	 pD77msh1LpIt/pRbVws+e9WpaQka0bdIREkQNztMtgcl6aEbKf3038yCTfA0oGH57Y
	 Ms/Bf9Gs8lzRA==
Message-ID: <sashiko-outbox-199569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] riscv: build kernel atomics from LR/SC when
 Zaamo is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-lrsc-only-v5-1-f0648f57b2e1@mobileye.com>
References: <20261105-lrsc-only-v5-0-f0648f57b2e1@mobileye.com>
 <20261105-lrsc-only-v5-1-f0648f57b2e1@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:03:26 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] riscv: missing RISCV_FULL_BARRIER in LR/SC value-returning ato=
mics
- [High] riscv: bitops: broken RVWMO ordering and leaked macros in LR/SC bi=
tops
- [Medium] riscv: missing Zaamo dependency for Zicfiss when RISCV_ISA_ZAAMO=
=3Dn
- [Low] riscv: unreachable _zaamo march rule and unused CONFIG_RISCV_ISA_ZA=
LRSC
- [Low] riscv: missing workload benchmarks and userspace slow-AMO reporting=
 for Zaamo
--

commit 0594932503c2ca9d6aebe33d3c6b28a68cd3db5e
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

riscv: build kernel atomics from LR/SC when Zaamo is disabled

This commit adds CONFIG_RISCV_ISA_ZAAMO (and CONFIG_RISCV_ISA_ZALRSC /
CONFIG_RISCV_ISA_A) so kernels can be built using LR/SC loops instead of AMO
instructions on CPUs where Zaamo is trap-emulated in M-mode.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5874ca30f4f6d..07d15a0bb3799 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -730,6 +730,59 @@ config RISCV_ISA_ZACAS
> =20
>  	  If you don't know what to do here, say Y.
> =20
> +config TOOLCHAIN_HAS_ZALRSC_ZAAMO
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64im_zaamo_zal=
rsc)
> +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32im_zaamo_za=
lrsc)
> +
> +config RISCV_ISA_ZAAMO
> +	bool "Zaamo extension support for AMO atomics" if TOOLCHAIN_HAS_ZALRSC_=
ZAAMO
> +	default y
> +	help
> +	  Use AMO instructions for kernel atomic memory operations. When
> +	  disabled, those operations are built from LR/SC and the kernel
> +	  is compiled with zalrsc instead of the A extension.
> +
> +	  Disable this for a CPU where AMO is much slower than LR/SC. That
> +	  is the case when AMO instructions are emulated by a trap into
> +	  M-mode, as on the MIPS P8700: an emulated atomic costs hundreds
> +	  of cycles where LR/SC costs tens. Such a CPU still advertises
> +	  the A extension, and userspace still sees it.

[Severity: Low]
As reported by Palmer Dabbelt on v4 [1], when treating M-mode trap-emulated
AMOs on hardware like MIPS P8700 as implemented-but-slow and continuing to
advertise the A extension to userspace in CONFIG_RISCV_ISA_ZAAMO, could
real-world application performance numbers be provided (rather than only the
40-cycle vs 600-cycle microbenchmark), along with a mechanism such as hwpro=
be
to report slow AMO behavior to userspace?

> +
> +	  A kernel built without Zaamo runs on any CPU that implements the
> +	  A extension; it only does not use AMO.
> +
> +	  The compiler must accept _zaamo and _zalrsc in -march to make
> +	  this choice. GCC 15.1 is the first release that does. With an
> +	  older compiler the option stays enabled and -march keeps the A
> +	  extension.
> +
> +	  If you don't know what to do here, say Y.
> +
> +config RISCV_ISA_ZALRSC
> +	def_bool y
> +	help
> +	  Zalrsc provides LR/SC. cmpxchg and the conditional atomics are
> +	  LR/SC sequences, so this is always enabled.
> +
> +	  It exists because asm/hwcap.h already has RISCV_ISA_EXT_ZALRSC
> +	  next to RISCV_ISA_EXT_ZAAMO, and the kernel pairs each
> +	  RISCV_ISA_EXT_<ext> it can be built for with a
> +	  CONFIG_RISCV_ISA_<ext>; rv_ext_enabled() in the BPF JIT, for
> +	  example, tests both.
> +
> +	  Zaamo plus Zacas could provide every atomic as well, with CAS
> +	  loops in place of LR/SC. This option is where that would go,
> +	  by allowing it to be disabled.
> +
> +config RISCV_ISA_A
> +	def_bool RISCV_ISA_ZAAMO && RISCV_ISA_ZALRSC
> +	help
> +	  The A extension is Zaamo plus Zalrsc. This is the Kconfig
> +	  counterpart of RISCV_ISA_EXT_A, for the same reason as
> +	  RISCV_ISA_ZALRSC above, and puts "a" in -march.
> +
>  config TOOLCHAIN_HAS_ZBB
>  	bool
>  	default y
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 44f5a439741a9..5cdc9cc017bb1 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -58,8 +58,9 @@ ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
>  endif
> =20
>  # ISA string setting
> -riscv-march-$(CONFIG_ARCH_RV32I)	:=3D rv32im
> -riscv-march-$(CONFIG_ARCH_RV64I)	:=3D rv64ima
> +riscv-march-$(CONFIG_ARCH_RV32I)	:=3D rv32im
> +riscv-march-$(CONFIG_ARCH_RV64I)	:=3D rv64im
> +riscv-march-$(CONFIG_RISCV_ISA_A)	:=3D $(riscv-march-y)a
>  riscv-march-$(CONFIG_FPU)		:=3D $(riscv-march-y)fd
>  riscv-march-$(CONFIG_RISCV_ISA_C)	:=3D $(riscv-march-y)c
>  riscv-march-$(CONFIG_RISCV_ISA_V)	:=3D $(riscv-march-y)v
> @@ -75,9 +76,16 @@ else
>  riscv-march-$(CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI) :=3D $(ris=
cv-march-y)_zicsr_zifencei
>  endif
> =20
> -KBUILD_BASE_ISA =3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(=
rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +KBUILD_BASE_ISA =3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(=
rv32ima?|rv64ima?)fd([^v_]*)v?/\1\2/')
>  export KBUILD_BASE_ISA
> =20
> +# Without "a", name the sub-extensions. Zaamo can be off only when the
> +# compiler accepts _zaamo and _zalrsc in -march.
> +ifneq ($(CONFIG_RISCV_ISA_A),y)
> +riscv-march-$(CONFIG_RISCV_ISA_ZAAMO) :=3D $(riscv-march-y)_zaamo
> +riscv-march-$(CONFIG_RISCV_ISA_ZALRSC) :=3D $(riscv-march-y)_zalrsc
> +endif

[Severity: Medium]
As reported by Sashiko on v4 [2], does disabling CONFIG_RISCV_ISA_ZAAMO bre=
ak
the build when CONFIG_RISCV_USER_CFI=3Dy (which defaults to y on 64-bit MMU
kernels)?

When CONFIG_RISCV_ISA_ZAAMO=3Dn, riscv-march-y and KBUILD_BASE_ISA are buil=
t with
_zalrsc and omit both a and _zaamo. However, CONFIG_RISCV_USER_CFI in
arch/riscv/Kconfig checks:

	depends on 64BIT && MMU && \
		$(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zicfiss_zicfilp -fcf-protection=
=3Dfull)

without depending on RISCV_ISA_ZAAMO.

Because the Zicfiss extension requires Zaamo for ssamoswap, two build failu=
res
follow:

1. In arch/riscv/kernel/usercfi.c, amo_user_shstk() emits:

	asm goto(".option push\n"
		".option arch, +zicfiss\n"
		"1: ssamoswap.d %[swap], %[val], %[addr]\n"

In both GNU binutils and LLVM, .option arch, +zicfiss does not enable +zaam=
o,
so assembling ssamoswap.d fails when KBUILD_CFLAGS lacks a and _zaamo.

2. In arch/riscv/kernel/vdso/Makefile (included by
arch/riscv/kernel/vdso_cfi/Makefile with VDSO_CFI_BUILD :=3D 1), CFI_MARCH
appends _zicfilp_zicfiss to $(KBUILD_BASE_ISA), which fails when the base
-march has _zalrsc without _zaamo.

Should RISCV_USER_CFI depend on RISCV_ISA_ZAAMO, or should +zaamo be enabled
where Zicfiss is used?

[Severity: Low]
As reported by Conor Dooley on v3 [3], since CONFIG_RISCV_ISA_ZALRSC is
unconditionally def_bool y and CONFIG_RISCV_ISA_A is defined as
RISCV_ISA_ZAAMO && RISCV_ISA_ZALRSC, CONFIG_RISCV_ISA_A is always identical=
 to
CONFIG_RISCV_ISA_ZAAMO.

Doesn't that make the _zaamo assignment inside ifneq ($(CONFIG_RISCV_ISA_A)=
,y)
unreachable dead code, and could the unused CONFIG_RISCV_ISA_ZALRSC and
CONFIG_RISCV_ISA_A options be dropped in favor of using CONFIG_RISCV_ISA_ZA=
AMO
directly?

[ ... ]

> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/ato=
mic.h
> index 616b8b332ac56..3b189bea1d08c 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h

[ ... ]

> @@ -108,6 +126,38 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, at=
omic##prefix##_t *v)	\
>  		: "memory");						\
>  	return ret;							\
>  }
> +#else
> +#define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
> +static __always_inline							\
> +c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
> +					     atomic##prefix##_t *v)	\
> +{									\
> +	register c_type ret, temp;					\
> +	__asm__ __volatile__ (						\
> +		"1:	lr." #asm_type " %1, %0\n"			\
> +		"	" #asm_op " %2, %1, %3\n"			\
> +		"	sc." #asm_type " %2, %2, %0\n"			\
> +		"	bnez %2, 1b\n"					\
> +		: "+A" (v->counter), "=3D&r" (ret), "=3D&r" (temp)		\
> +		: "r" (I)						\
> +		: "memory");						\
> +	return ret;							\
> +}									\
> +static __always_inline							\
> +c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)=
	\
> +{									\
> +	register c_type ret, temp;					\
> +	__asm__ __volatile__ (						\
> +		"1:	lr." #asm_type ".aqrl %1, %0\n"			\
> +		"	" #asm_op " %2, %1, %3\n"			\
> +		"	sc." #asm_type ".aqrl %2, %2, %0\n"		\
> +		"	bnez %2, 1b\n"					\
> +		: "+A" (v->counter), "=3D&r" (ret), "=3D&r" (temp)		\
> +		: "r" (I)						\
> +		: "memory");						\
> +	return ret;							\
> +}
> +#endif

[Severity: Critical]
As reported by Sashiko on v4 [2], does pairing lr.aqrl with sc.aqrl without=
 a
trailing RISCV_FULL_BARRIER violate the LKMM full-barrier requirement for
fully-ordered value-returning atomic RMW primitives when
CONFIG_RISCV_ISA_ZAAMO=3Dn?

Under RVWMO, a single AMO instruction with .aqrl is both a load and a store=
, so
PPO Rule 6 (rw -> store.rl) orders prior accesses before the AMO and PPO Ru=
le 5
(load.aq -> rw) orders the AMO before subsequent accesses. In an LR/SC loop,
lr.aqrl is only a load and sc.aqrl is only a store: prior memory accesses a=
re
ordered before sc.aqrl, and subsequent memory accesses are ordered after
lr.aqrl, but because lr.aqrl executes before sc.aqrl, a prior plain store a=
nd a
subsequent plain load to different addresses can be reordered into:

	lr.aqrl -> subsequent load -> prior store -> sc.aqrl

As established in commit 5ce6c1f3535f ("riscv/atomic: Strengthen
implementations with fences") and commit 1d84afaf0252 ("riscv: Fix fully
ordered LR/SC xchg[8|16]() implementations"), fully-ordered LR/SC sequences=
 in
RISC-V Linux must use plain lr.{w,d}, sc.{w,d}.rl, and a trailing
RISCV_FULL_BARRIER (fence rw, rw).

This affects four places when CONFIG_RISCV_ISA_ZAAMO is disabled:
- ATOMIC_FETCH_OP() in arch/riscv/include/asm/atomic.h (and ATOMIC_OP_RETUR=
N()
  built on top of it)
- __test_and_op_bit_ord() / __test_and_op_bit() in
  arch/riscv/include/asm/bitops.h
- __arch_xchg() and _arch_xchg() in arch/riscv/include/asm/cmpxchg.h (where
  cases 4 and 8 pass swap_sfx =3D ".aqrl" and swap_append =3D "" instead of
  sc_sfx =3D ".rl" and sc_append =3D RISCV_FULL_BARRIER, and where __arch_x=
chg()
  declares __typeof__(*(__ptr)) temp; using caller variable __ptr rather th=
an
  macro parameter p)
- __futex_atomic_op() in arch/riscv/include/asm/futex.h

Should these four LR/SC sequences use plain lr, sc.rl, and a trailing
RISCV_FULL_BARRIER instead of lr.aqrl + sc.aqrl?

> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bit=
ops.h
> index 3c1a15be54d80..ab3ffc3bfcfcb 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -170,12 +170,17 @@ static __always_inline int variable_fls(unsigned in=
t x)
> =20
>  #if (BITS_PER_LONG =3D=3D 64)
>  #define __AMO(op)	"amo" #op ".d"
> +#define __LR	"lr.d"
> +#define __SC	"sc.d"
>  #elif (BITS_PER_LONG =3D=3D 32)
>  #define __AMO(op)	"amo" #op ".w"
> +#define __LR	"lr.w"
> +#define __SC	"sc.w"
>  #else
>  #error "Unexpected BITS_PER_LONG"
>  #endif
> =20
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  #define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
>  ({								\
>  	unsigned long __res, __mask;				\
> @@ -194,6 +199,35 @@ static __always_inline int variable_fls(unsigned int=
 x)
>  		: "+A" (addr[BIT_WORD(nr)])			\
>  		: "r" (mod(BIT_MASK(nr)))			\
>  		: "memory");
> +#else
> +#define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
> +({								\
> +	unsigned long __res, __mask, __temp;			\
> +	__mask =3D BIT_MASK(nr);					\
> +	__asm__ __volatile__ (					\
> +		"1: " __LR #ord " %0, %1\n"			\
> +		#op " %2, %0, %3\n"				\
> +		__SC #ord " %2, %2, %1\n"			\
> +		"bnez %2, 1b\n"					\
> +		: "=3D&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=3D&r" (__temp)	\
> +		: "r" (mod(__mask))				\
> +		: "memory");					\
> +	((__res & __mask) !=3D 0);				\
> +})
> +
> +#define __op_bit_ord(op, mod, nr, addr, ord)			\
> +do {								\
> +	unsigned long __res, __temp;				\
> +	__asm__ __volatile__ (					\
> +		"1: " __LR #ord " %0, %1\n"			\
> +		#op " %2, %0, %3\n"				\
> +		__SC #ord " %2, %2, %1\n"			\
> +		"bnez %2, 1b\n"					\
> +		: "=3D&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=3D&r" (__temp)	\
> +		: "r" (mod(BIT_MASK(nr)))			\
> +		: "memory");					\
> +} while (0)
> +#endif
> =20
>  #define __test_and_op_bit(op, mod, nr, addr) 			\
>  	__test_and_op_bit_ord(op, mod, nr, addr, .aqrl)
> @@ -337,12 +371,25 @@ static __always_inline void arch___clear_bit_unlock(
>  static __always_inline bool arch_xor_unlock_is_negative_byte(unsigned lo=
ng mask,
>  		volatile unsigned long *addr)
>  {
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  	unsigned long res;
>  	__asm__ __volatile__ (
>  		__AMO(xor) ".rl %0, %2, %1"
>  		: "=3Dr" (res), "+A" (*addr)
>  		: "r" (__NOP(mask))
>  		: "memory");
> +#else
> +	unsigned long res, temp;
> +
> +	__asm__ __volatile__ (
> +		"1: " __LR ".rl %0, %1\n"
> +		"xor %2, %0, %3\n"
> +		__SC ".rl %2, %2, %1\n"
> +		"bnez %2, 1b\n"
> +		: "=3D&r" (res), "+A" (*addr), "=3D&r" (temp)
> +		: "r" (__NOP(mask))
> +		: "memory");
> +#endif
>  	return (res & BIT(7)) !=3D 0;
>  }

[Severity: High]
As reported by Sashiko on v4 [2], in arch/riscv/include/asm/bitops.h when
CONFIG_RISCV_ISA_ZAAMO=3Dn, __test_and_op_bit_ord() and __op_bit_ord() paste
#ord onto both __LR and __SC, and arch_xor_unlock_is_negative_byte() emits
__LR ".rl".

Doesn't this produce reserved/ineffective Zalrsc ordering combinations and
weaken release ordering in arch_xor_unlock_is_negative_byte()?

1. When arch_test_and_set_bit_lock() calls __test_and_op_bit_ord() with
ord =3D .aq, it emits sc.{d,w}.aq, which has aq=3D1, rl=3D0 on a store-cond=
itional.
2. When arch_clear_bit_unlock() calls __op_bit_ord() with ord =3D .rl, and =
in
arch_xor_unlock_is_negative_byte(), it emits lr.{d,w}.rl, which has aq=3D0,=
 rl=3D1
on a load-reserved.
3. In arch_xor_unlock_is_negative_byte(), callers such as
folio_xor_flags_has_waiters() unlock PG_locked with release semantics while
checking BIT(7) (PG_waiters) in the old value res. Because .rl on lr has no
RVWMO release effect (PPO Rule 6 only orders prior accesses before stores w=
ith
.rl), memory accesses inside the critical section are only ordered before
sc.rl and can be reordered after the lr load that samples BIT(7) into res.
4. For __test_and_op_bit() (used by arch_test_and_set_bit(),
arch_test_and_clear_bit(), and arch_test_and_change_bit()), ord =3D .aqrl e=
mits
lr.aqrl + sc.aqrl without a trailing RISCV_FULL_BARRIER.
5. Finally, at the bottom of arch/riscv/include/asm/bitops.h:

	#undef __test_and_op_bit
	#undef __op_bit
	#undef __NOP
	#undef __NOT
	#undef __AMO

should __LR and __SC also be undefined here so they do not leak into
translation units that include asm/bitops.h?

[1] https://lore.kernel.org/r/mhng-6BAAFBCB-95B3-45AC-9087-C00241996255@Pal=
mers-Mini.rwc.dabbelt.com
[2] https://lore.kernel.org/r/20261101-lrsc-only-v4-1-4e1d010463b3@mobileye=
.com
[3] https://lore.kernel.org/r/20261102-persuader-catering-5ed81c35ae0e@spud

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-lrsc-only-=
v5-0-f0648f57b2e1@mobileye.com?part=3D1
