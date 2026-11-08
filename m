Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794180826;
	b=A/cXuLmx4r9MTY8ZVGhba2pUGG1ilr3qnSEVnf4xGhVzNEY0ATVTubWXq6gPDXNfgiNN
	 W9wK2GiigBUa2aLIGbVQWB9El/sIJpUt9ZGHwQ7N15UlNyA4+tCi3DEixCbZF+ikDp1bk
	 av9KHp5uzBjmTH3/u64w89B4NQeewiGqmEVZgKTXCzIP8z7F70UZF49EHSDm5bKHMcH7P
	 FhJtbSGgXIz77F6v1PYNZLf+CVazihRAL3L5ThMp+5vxj1CTHRD9rwin+fz1SUYQmoIE8
	 VPdI1ouMzs703sYLFLNiHQqqzWLbbqDKk7xStcpCQQmqxGv9l8osfFYaYAJz7eEKDYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794180826;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D5maVvDebpKiBgpSMGQ/ItivhTv8Sfp3ws0qqnZ0qZI=;
	b=E13/IrzDGQb99rQMqZ/ymhwkuGapcpk0Pad0dLGEwIvn5Zh/LoI2wDarKUv2Wd5AKvsb
	 /I6g2qjz027bSyZNuv+cezAy3nFcwkTatFtobT++bBAGwb520+vHVu0yzKjtbWYi+eOzO
	 csodpfZkk9UIvyAKPMAXFwZJML8MZYluVaKaDn7Hm8I2zoIXHf9auJAnLEdeKpSUE8KcO
	 n2HdvTbSc3bUNzh7nrNL6GNvN6XCFj2oFiK6G5E66g4qEX78TNPm8LNqF7TPOxqqvWbdU
	 lWAz8vrAqvnfcsoO7AwN/64aQoEcGnM+4k5cbw2xwaoQKGcBVuv72LzgjUHd56QL0Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKnPubRz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D072606A31C;
	Sun,  8 Nov 2026 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKnPubRz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497871F0089F;
	Sun,  8 Nov 2026 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794180825;
	bh=D5maVvDebpKiBgpSMGQ/ItivhTv8Sfp3ws0qqnZ0qZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dKnPubRzVFIabw8iRBs2jGgbFXsQdM1uy4AKHVtpzU9pj51A6gc3YyhoyKErxn/+T
	 6rwB0HcfTaAfAMgem2os9EIRc74DI0yBYWcPxdjqLKE4opjnwJIbAEDCX4jqYrDPHu
	 ului21TGdXT8sWyKXp3Fo3jTLfPWAIVE4PhhrQGm7Zy5kDVQ01iQlP3WcxXtBNMJIT
	 2Gg8vuEXKccQII2lu5uXg2bV1mEX7IjZoCNJ+vhTRfCaTqqyzfKPGfij52ZX9+dVUT
	 ikiDI0+KIEC6j7rtyjxQykadBRhEBkuar19sSUZyY0dNK5He7C2LCmshHgWM7o6BII
	 esRxPfHEMCLHQ==
Date: Sun, 8 Nov 2026 23:33:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Chao-ying Fu <chao-ying.fu@globalfoundries.com>,
	torvalds@linux-foundation.org, olof@lixom.net,
	aleksa.paunovic@htecgroup.com, arikalo@gmail.com,
	Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] riscv: build kernel atomics from LR/SC when Zaamo
 is disabled
Message-ID: <20261108-pleading-dealt-ecf444d378ee@spud>
References: <20261105-lrsc-only-v5-0-f0648f57b2e1@mobileye.com>
 <20261105-lrsc-only-v5-1-f0648f57b2e1@mobileye.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eNtwCUDsbkoNbPJt"
Content-Disposition: inline
In-Reply-To: <20261105-lrsc-only-v5-1-f0648f57b2e1@mobileye.com>

--eNtwCUDsbkoNbPJt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 06:37:36PM +0200, Vladimir Kondratiev wrote:
> The A extension is Zaamo plus Zalrsc. On some CPUs Zaamo is present
> only formally. MIPS P8700 traps every AMO instruction into M-mode and
> emulates it there, so the extension is supported but very slow. A
> typical uncontended atomic increment costs:
>=20
>   native AMO                                     2..5 cycles
>   LR/SC, private L1 reservation monitor         6..12 cycles
>   LR/SC, PoC (L2) reservation monitor       about 40 cycles
>   AMO emulated by an M-mode trap           about 600 cycles
>=20
> The last two were measured on the eyeq7h hardware. On such a CPU the
> kernel must use LR/SC for every atomic.
>=20
> Add RISCV_ISA_ZAAMO, default y. The default keeps "a" in -march and
> the generated code unchanged. When it is disabled, -march carries
> _zalrsc instead of "a", and atomic_*, bitops, xchg, futex and the
> early boot code use LR/SC loops. The sequence is chosen with the
> preprocessor, on CONFIG_RISCV_ISA_ZAAMO like the other ISA options in
> the headers, because the assembler rejects AMO mnemonics once -march
> lacks Zaamo. A kernel built this way runs on any hart that implements A; =
it just
> does not use AMO. It is therefore a plain option, not a NONPORTABLE
> one, and the hart keeps advertising "a" to userspace, which is true.
>=20
> The choice is made at compile time rather than with alternatives.
> Nearly every CPU has a native A extension, and an alternative would
> inflate all those kernels with the nops needed to pad one AMO to the
> size of an LR/SC loop, at every atomic site, for the benefit of a few.
>=20
> Turning Zaamo off needs a compiler that accepts _zaamo and _zalrsc in
> -march. GCC 15.1 is the first release that does.
> TOOLCHAIN_HAS_ZALRSC_ZAAMO checks for it; with an older compiler the
> option stays at y.
>=20
> Add RISCV_ISA_ZALRSC as well, always y, because cmpxchg and the
> conditional atomics are LR/SC sequences that Zaamo cannot replace. It
> exists as the Kconfig counterpart of RISCV_ISA_EXT_ZALRSC in hwcap.h,
> added by commit 35173b666a16 ("riscv: add parsing for Zaamo and Zalrsc
> extensions"). The two sets are used together, for instance by
> rv_ext_enabled() in the BPF JIT, so an extension the kernel can be
> built for has both. RISCV_ISA_A, the counterpart of RISCV_ISA_EXT_A,
> follows the same rule and puts "a" in -march.
>=20
> Three sets of extensions provide every atomic Linux needs. "a" is what
> the kernel supports today. Zalrsc plus Ziccrse is what this patch adds:
> every atomic is a constrained LR/SC loop, and Ziccrse is the
> forward-progress guarantee for such loops. Zaamo plus Zacas would do as
> well, with CAS loops in place of LR/SC as on x86. This patch leaves
> that option open: RISCV_ISA_ZALRSC is where it would go, by allowing
> "n" there and making amocas the base implementation.
>=20
> Suggested-by: Chao-ying Fu <chao-ying.fu@globalfoundries.com>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

NAK, on the basis laid out in
https://lore.kernel.org/linux-riscv/20261106-smock-headband-d6a7d568c228@sp=
ud/

On any future interations please include:
NAKed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/linux-riscv/20261106-smock-headband-d6a7d568c=
228@spud/

> ---
>  arch/riscv/Kconfig               | 53 ++++++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/Makefile              | 16 +++++++++---
>  arch/riscv/include/asm/atomic.h  | 52 ++++++++++++++++++++++++++++++++++=
++++-
>  arch/riscv/include/asm/bitops.h  | 47 +++++++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/cmpxchg.h | 16 ++++++++++++
>  arch/riscv/include/asm/futex.h   | 45 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/entry.S        |  7 ++++++
>  arch/riscv/kernel/head.S         | 12 +++++++++
>  8 files changed, 243 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5874ca30f4f6..07d15a0bb379 100644
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

https://lore.kernel.org/linux-riscv/20261104-headlamp-improve-21863d9ca13e@=
spud/

I've also repeated asked for this to be deleted.

Thanks,
Conor.

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
> index 44f5a439741a..5cdc9cc017bb 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -58,8 +58,9 @@ ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
>  endif
> =20
>  # ISA string setting
> -riscv-march-$(CONFIG_ARCH_RV32I)	:=3D rv32ima
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
> +
>  # Remove F,D,V from isa string for all. Keep extensions between "fd" and=
 "v" by
>  # matching non-v and non-multi-letter extensions out with the filter ([^=
v_]*)
>  KBUILD_CFLAGS +=3D $(KBUILD_BASE_ISA)
> @@ -85,7 +93,7 @@ KBUILD_CFLAGS +=3D $(KBUILD_BASE_ISA)
>  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
> =20
>  # For C code built with floating-point support, exclude V but keep F and=
 D.
> -CC_FLAGS_FPU  :=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(r=
v32ima|rv64ima)([^v_]*)v?/\1\2/')
> +CC_FLAGS_FPU  :=3D -march=3D$(shell echo $(riscv-march-y) | sed -E 's/(r=
v32ima?|rv64ima?)([^v_]*)v?/\1\2/')
> =20
>  KBUILD_CFLAGS +=3D -mno-save-restore
> =20
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/ato=
mic.h
> index 616b8b332ac5..3b189bea1d08 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -50,6 +50,7 @@ static __always_inline void arch_atomic64_set(atomic64_=
t *v, s64 i)
>   * have the AQ or RL bits set.  These don't return anything, so there's =
only
>   * one version to worry about.
>   */
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
>  static __always_inline							\
>  void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
> @@ -59,7 +60,23 @@ void arch_atomic##prefix##_##op(c_type i, atomic##pref=
ix##_t *v)	\
>  		: "+A" (v->counter)					\
>  		: "r" (I)						\
>  		: "memory");						\
> -}									\
> +}
> +#else
> +#define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
> +static __always_inline							\
> +void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
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
> +}
> +#endif
> =20
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC_OPS(op, asm_op, I)					\
> @@ -84,6 +101,7 @@ ATOMIC_OPS(xor, xor,  i)
>   * There's two flavors of these: the arithmetic ops have both fetch and =
return
>   * versions, while the logical ops only have fetch versions.
>   */
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
>  static __always_inline							\
>  c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
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
> =20
>  #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
>  static __always_inline							\
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bit=
ops.h
> index 3c1a15be54d8..ab3ffc3bfcfc 100644
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
> =20
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index 662e160b0522..883dc4aa1dc3 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -57,6 +57,7 @@
>  	}									\
>  })
> =20
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  #define __arch_xchg(sfx, prepend, append, r, p, n)			\
>  ({									\
>  	__asm__ __volatile__ (						\
> @@ -67,6 +68,21 @@
>  		: "r" (n)						\
>  		: "memory");						\
>  })
> +#else
> +#define __arch_xchg(sfx, prepend, append, r, p, n)			\
> +({									\
> +	__typeof__(*(__ptr)) temp;					\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"1:	lr" sfx " %0, %1\n"				\
> +		"	sc" sfx " %2, %3, %1\n"				\
> +		"	bnez %2, 1b\n"					\
> +		append							\
> +		: "=3D&r" (r), "+A" (*(p)), "=3D&r" (temp)			\
> +		: "r" (n)						\
> +		: "memory");						\
> +})
> +#endif
> =20
>  #define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
>  		   sc_append, swap_append)				\
> diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/fute=
x.h
> index 6f3bc9bdb85e..58f12bf2af68 100644
> --- a/arch/riscv/include/asm/futex.h
> +++ b/arch/riscv/include/asm/futex.h
> @@ -19,6 +19,7 @@
>  #define __disable_user_access()		do { } while (0)
>  #endif
> =20
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
>  {								\
>  	__enable_user_access();					\
> @@ -32,6 +33,27 @@
>  	: "memory");						\
>  	__disable_user_access();				\
>  }
> +#else
> +#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)	\
> +{								\
> +	int temp;						\
> +								\
> +	__enable_user_access();					\
> +	__asm__ __volatile__ (					\
> +	"1:	lr.w.aqrl %[ov], %[u]			\n"	\
> +	"	" insn "				\n"	\
> +	"2:	sc.w.aqrl %[t], %[t], %[u]		\n"	\
> +	"	bnez %[t], 1b				\n"	\
> +	"3:						\n"	\
> +	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %[r])			\
> +	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %[r])			\
> +	: [r] "+r" (ret), [ov] "=3D&r" (oldval),			\
> +	  [t] "=3D&r" (temp), [u] "+m" (*(uaddr))			\
> +	: [op] "Jr" (oparg)					\
> +	: "memory");						\
> +	__disable_user_access();				\
> +}
> +#endif
> =20
>  static inline int
>  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *ua=
ddr)
> @@ -43,6 +65,7 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *ova=
l, u32 __user *uaddr)
>  	uaddr =3D untagged_addr(uaddr);
> =20
>  	switch (op) {
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  	case FUTEX_OP_SET:
>  		__futex_atomic_op("amoswap.w.aqrl %[ov],%z[op],%[u]",
>  				  ret, oldval, uaddr, oparg);
> @@ -63,6 +86,28 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *ov=
al, u32 __user *uaddr)
>  		__futex_atomic_op("amoxor.w.aqrl %[ov],%z[op],%[u]",
>  				  ret, oldval, uaddr, oparg);
>  		break;
> +#else
> +	case FUTEX_OP_SET:
> +		__futex_atomic_op("mv %[t], %z[op]",
> +				  ret, oldval, uaddr, oparg);
> +		break;
> +	case FUTEX_OP_ADD:
> +		__futex_atomic_op("add %[t], %[ov], %z[op]",
> +				  ret, oldval, uaddr, oparg);
> +		break;
> +	case FUTEX_OP_OR:
> +		__futex_atomic_op("or %[t], %[ov], %z[op]",
> +				  ret, oldval, uaddr, oparg);
> +		break;
> +	case FUTEX_OP_ANDN:
> +		__futex_atomic_op("and %[t], %[ov], %z[op]",
> +				  ret, oldval, uaddr, ~oparg);
> +		break;
> +	case FUTEX_OP_XOR:
> +		__futex_atomic_op("xor %[t], %[ov], %z[op]",
> +				  ret, oldval, uaddr, oparg);
> +		break;
> +#endif
>  	default:
>  		ret =3D -ENOSYS;
>  	}
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 61b7a7716697..ba2db6804a6c 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -73,7 +73,14 @@
>  	beq	a2, zero, .Lnew_valid_map_cpus_restore_context
> =20
>  	/* Atomically reset the current cpu bit in new_valid_map_cpus */
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  	amoxor.d	a0, a1, (a0)
> +#else
> +1:	lr.d	a2, (a0)
> +	xor	a2, a1, a2
> +	sc.d	a2, a2, (a0)
> +	bnez	a2, 1b
> +#endif
> =20
>  	/*
>  	 * A sfence.vma is required here. Even if we had Svvptc, there's no
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index f6a8ca49e627..dc3862ed29c4 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -265,7 +265,19 @@ SYM_CODE_START(_start_kernel)
>  	/* Pick one hart to run the main boot sequence */
>  	la a3, hart_lottery
>  	li a2, 1
> +#ifdef CONFIG_RISCV_ISA_ZAAMO
>  	amoadd.w a3, a2, (a3)
> +#else
> +	/*
> +	 * hart_lottery is a small 32-bit counter. add is valid on RV32
> +	 * and RV64; sc.w stores the low 32 bits.
> +	 */
> +1:	lr.w t0, (a3)
> +	add t1, t0, a2
> +	sc.w t1, t1, (a3)
> +	bnez t1, 1b
> +	mv a3, t0
> +#endif
>  	bnez a3, .Lsecondary_start
>  #endif /* CONFIG_RISCV_BOOT_SPINWAIT */
> =20
>=20
> --=20
> 2.43.0
>=20

--eNtwCUDsbkoNbPJt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavEGzwAKCRB4tDGHoIJi
0n2BAP0ag1gYuMNlhru1pZzF41mHB35NNsxqZw9R5F/QRRA0hwD/Y5KbYd4MbgcW
NBGDwRB7UpznGk5kbv99OV707xe+qwk=
=P1y3
-----END PGP SIGNATURE-----

--eNtwCUDsbkoNbPJt--
