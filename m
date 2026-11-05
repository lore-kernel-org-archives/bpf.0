Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899996;
	b=UlAeGkntPgHMHEGZ/zRORqTMbnuv6nuKgzK7uU8RIJLpjTVpvr0ckPGscVY4XNcuMnip
	 X29ZNmpPF/OmAws/fWQD976BHYN/1T8brt8PnjYC8aSUMiZZIloPzZaSXzF+cqsJsmboH
	 DFy3uVfBcVSLmCxUruol25gpwkOeC/oxHFwxofApLcgAU8wchXzpa1GEPqFhRHncMdQGM
	 xranWjDHmFxrOynue8rCXsJpD5uy788hzj5fljS5UY/6B9Rs2McXMQnxpPb/DL8xY7x05
	 7ZnjrJcR5YjOL1g5LpHkbYyZk1kD/nUK/nx/T59bP9sg0Hkgdc2qTage4PJ64ZtxyWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899996;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=oSm1ozRsqu0jVQ66QOQEEYOnT9bhWnL4fGvmxHAa0xU=;
	b=acYuEji1xjH9qVtrH9QHB8KygxhkORba5g4NwnsjDK/F/7rEQpBraM8jXUvyaw8JRO1S
	 1C7e/OcuZstj9eORK5btSOc5W3PPh0hXX08eUh6mNm6p+5OvLXz6WHxWzN8RghEJWPqzZ
	 8W2Z6DRrr6O9WBKpEvraT5+RlGptOhCfDEUhyCjq3DlTzB7MbhZS2u/zIS1tn+vAK+9AL
	 viz0TMbZ1mCpaO15jmt7YHU8RBo0AHYZdxDzOqa7Asu/9L5oA64cy+W2GA5agQEKhfKCd
	 n/lbquj3PWiW3ptu29z2qK2wsWpJgWn0l1mqSoSiy4JQYXJ0ywKcOsaQXApnWOyu3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSvp97un;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C31606A326;
	Thu,  5 Nov 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSvp97un
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7E91F000C1;
	Thu,  5 Nov 2026 17:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899995;
	bh=oSm1ozRsqu0jVQ66QOQEEYOnT9bhWnL4fGvmxHAa0xU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RSvp97unsAj22ZXChSJySDgVd/iaulJgETAf9ZXTRJvjnqPxDni25Cusy3HfgjWRw
	 YHgIA/KYMu4iysgB+aprQV4Z6DIE7Tlr0z7U9fmzHpBcLeHmbSy54sXy9p4PuPrHx8
	 aPz2itEwJ6z3cZmjdMwaSpVwnskA0R4ZJKcpqol3Id44WSW6hUBhkddccNbAGM54T2
	 OF0D8bUl8uMojLBdwQ5ZBO/5nTPuE2X8VMmqlqeGDhjygcNn0Dj0eqSwqy8jq+75R9
	 m6i8/3JrokG29nPRJULrTcXp9MQwzj2QChqSrRGzLYQR51qEqdJTl1E+hSj++PlcPP
	 u4b/Ixq7PiaTA==
Content-Type: multipart/mixed; boundary="===============4354460838823676982=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <18c9fcbaea4f427a23d9769e82c5b065ccb61392e2f87f97c97614cf252dd48c@mail.kernel.org>
In-Reply-To: <20261105-lrsc-only-v5-1-f0648f57b2e1@mobileye.com>
References: <20261105-lrsc-only-v5-1-f0648f57b2e1@mobileye.com>
Subject: Re: [PATCH v5 1/3] riscv: build kernel atomics from LR/SC when Zaamo is disabled
From: bot+bpf-ci@kernel.org
To: vladimir.kondratiev@mobileye.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,will@kernel.org,peterz@infradead.org,mark.rutland@arm.com,gary@garyguo.net,yury.norov@gmail.com,linux@rasmusvillemoes.dk,chao-ying.fu@globalfoundries.com,torvalds@linux-foundation.org,olof@lixom.net,aleksa.paunovic@htecgroup.com,arikalo@gmail.com,boqun@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,mhiramat@kernel.org,oleg@redhat.com,boqun@kernel.org
Cc: linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,Vladimir.Kondratiev@mobileye.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,vladimir.kondratiev@mobileye.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 17:33:14 +0000 (UTC)

--===============4354460838823676982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> riscv: build kernel atomics from LR/SC when Zaamo is disabled

TL;DR:
- Unbounded futex LR/SC loop may starve, spinning with hash locks held
- kprobe on LR/SC atomics may livelock
- Zacas/Zabha still emit AMOs, contradicting docs
- redundant lr/sc ordering suffixes

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig

[ ... ]

> +config RISCV_ISA_ZAAMO
> +	bool "Zaamo extension support for AMO atomics" if TOOLCHAIN_HAS_ZALRSC_ZAAMO
> +	default y
> +	help
> +	  Use AMO instructions for kernel atomic memory operations. When
> +	  disabled, those operations are built from LR/SC and the kernel
> +	  is compiled with zalrsc instead of the A extension.
> +
> [ ... ]
> +	  A kernel built without Zaamo runs on any CPU that implements the
> +	  A extension; it only does not use AMO.

The help text says a kernel built without Zaamo "only does not use AMO", and
the commit message says "On such a CPU the kernel must use LR/SC for every
atomic" and "every atomic is a constrained LR/SC loop".

Is that accurate when the hart reports Zacas or Zabha?  RISCV_ISA_ZACAS and
RISCV_ISA_ZABHA stay default y and do not depend on RISCV_ISA_ZAAMO, so a
ZAAMO=n kernel still issues AMO-class instructions on those harts:

__arch_cmpxchg():
    if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) && ...
        riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS))
    -> amocas.w / amocas.d

__arch_cmpxchg_masked() -> amocas.b / amocas.h
__arch_xchg_masked()    -> amoswap.b / amoswap.h (Zabha)

riscv_spinlock_init() also selects the queued spinlock using Zabha when
Zabha and Zacas are both present, so the spinlock fast paths would run on
amocas/amoswap.h.

On a CPU that emulates AMOs with an M-mode trap and also reports
Zacas/Zabha, the hottest atomics would still trap.

Should RISCV_ISA_ZACAS and RISCV_ISA_ZABHA depend on RISCV_ISA_ZAAMO?  If
not, should the help text and changelog say that Zacas/Zabha AMOs are still
used when the hart reports them?

[ ... ]

> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h

[ ... ]

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
> +		: "+A" (v->counter), "=&r" (ret), "=&r" (temp)		\
> +		: "r" (I)						\
> +		: "memory");						\
> +}
> +#endif

Can a kprobe placed on one of these lr/sc loops livelock the CPU?  With
CONFIG_RISCV_ISA_ZAAMO=n, every inlined arch_atomic{,64}_<op>() and
arch_atomic{,64}_fetch_<op>{,_relaxed}() becomes an lr / op / sc / bnez
loop, where before it was a single amo<op> instruction that is safe to
probe.

arch_check_kprobe() only checks that the address is on an instruction
boundary, and riscv_probe_decode_insn() rejects only system, fence and
c.ebreak instructions, so a probe on the lr, the sc, or an instruction
between them is accepted.  The exception return path in entry.S then clears
the reservation on purpose:

    REG_L  a2, PT_EPC(sp)
    REG_SC x0, a2, PT_EPC(sp)

The trap for the single-step slot does the same, so the following sc always
fails, bnez goes back to lr, the probe fires again, and the loop never
completes.

This was already possible for the existing cmpxchg and conditional-atomic
LR/SC loops, but with ZAAMO=n it now reaches every atomic_inc(),
atomic_add() and atomic_fetch_*() site, including small out-of-line
functions whose first instruction is the lr.

A later commit in this series, 01f0e5fb499d ("riscv: probes: reject probes
inside an LR/SC sequence"), fixes this, but it is still reachable at this
commit, which matters for bisection and backports.

[ ... ]

> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h

[ ... ]

> +#else
> +#define __test_and_op_bit_ord(op, mod, nr, addr, ord)		\
> +({								\
> +	unsigned long __res, __mask, __temp;			\
> +	__mask = BIT_MASK(nr);					\
> +	__asm__ __volatile__ (					\
> +		"1: " __LR #ord " %0, %1\n"			\
> +		#op " %2, %0, %3\n"				\
> +		__SC #ord " %2, %2, %1\n"			\
> +		"bnez %2, 1b\n"					\
> +		: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
> +		: "r" (mod(__mask))				\
> +		: "memory");					\
> +	((__res & __mask) != 0);				\
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
> +		: "=&r" (__res), "+A" (addr[BIT_WORD(nr)]), "=&r" (__temp)	\
> +		: "r" (mod(BIT_MASK(nr)))			\
> +		: "memory");					\
> +} while (0)
> +#endif

Both macros put the same ordering suffix on the lr and on the sc.  That
gives:

arch_test_and_set_bit_lock()   (ord = .aq)  -> lr.d.aq  ... sc.d.aq
arch_clear_bit_unlock()        (ord = .rl)  -> lr.d.rl  ... sc.d.rl
arch___clear_bit_unlock()      (ord = .rl)  -> lr.d.rl  ... sc.d.rl

arch_xor_unlock_is_negative_byte() hard-codes the same pattern with
__LR ".rl" and __SC ".rl".

The A extension spec says software should not set rl on an LR unless aq is
also set, and should not set aq on an SC unless rl is also set, and that
LR.rl and SC.aq are not guaranteed to provide any stronger ordering than
having both bits clear but may result in lower performance.

The ordering that is wanted still comes from lr.aq and sc.rl, so the
semantics hold, but the other annotations do nothing useful and may be
slower on the hardware this option targets.  They also differ from the rest
of arch/riscv, where LR/SC ordering is a plain lr plus sc.rl and fences (see
arch_cmpxchg_acquire/_release and __arch_cmpxchg(), whose lr has no
ordering suffix).

Could these macros take separate lr and sc suffixes, as the cmpxchg macros
do with lr_sfx/sc_sfx?

[ ... ]

> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h

[ ... ]

This is the same issue as the Kconfig comment above.  The #ifdef
CONFIG_RISCV_ISA_ZAAMO in this header does not touch these paths, which
still emit AMO instructions when the hart advertises Zabha or Zacas:

__arch_xchg_masked()      -> amoswap.b/.h (Zabha), including xchg_relaxed()
                             on the 16-bit qspinlock tail
__arch_cmpxchg()          -> amocas.w/.d (Zacas), i.e. every cmpxchg and
                             try_cmpxchg, including the spinlock fast paths
__arch_cmpxchg_masked()   -> amocas.b/.h (Zabha + Zacas)
__arch_cmpxchg128()       -> amocas.q

These still build because each one enables the extension with
".option arch, +zabha" or ".option arch, +zacas".

This contradicts the commit message statement "A kernel built this way runs
on any hart that implements A; it just does not use AMO".  Should
RISCV_ISA_ZACAS and RISCV_ISA_ZABHA depend on RISCV_ISA_ZAAMO?

[ ... ]

> diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
> --- a/arch/riscv/include/asm/futex.h
> +++ b/arch/riscv/include/asm/futex.h

[ ... ]

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

Can this loop run unbounded while the futex hash-bucket locks are held?
With CONFIG_RISCV_ISA_ZAAMO=n, FUTEX_WAKE_OP now runs an LR/SC loop on user
memory:

futex(FUTEX_WAKE_OP)
  futex_wake_op()                    /* kernel/futex/waitwake.c */
    double_lock_hb(hb1, hb2)
    futex_atomic_op_inuser(op, uaddr2)
      pagefault_disable()
      arch_futex_atomic_op_inuser()
        __futex_atomic_op()

The loop exits only when sc.w.aqrl succeeds or faults.  The RISC-V
eventual-success guarantee for constrained LR/SC loops (the one Ziccrse
provides) does not hold while other harts keep writing to the reservation
set; the spec says that in that case no hart is guaranteed to leave its
LR/SC loop.

A process can do exactly that: one thread calls FUTEX_WAKE_OP on uaddr2
while a second thread on another hart stores to *uaddr2, or anything else
in the same reservation granule, in a tight loop.  The kernel then spins
with preemption disabled and both hash-bucket locks held.  The old
amo*.w.aqrl version cannot be starved this way because an AMO always
completes.

arm64 bounds its LDXR/STXR futex loop: LLSC_FUTEX_ATOMIC_OP() in
arch/arm64/include/asm/futex.h counts down FUTEX_MAX_LOOPS and returns
-EAGAIN, and futex_wake_op() already handles that:

    if (!IS_ENABLED(CONFIG_MMU) ||
        unlikely(op_ret != -EFAULT && op_ret != -EAGAIN))

by dropping the locks, calling cond_resched() and retrying.

The commit message says Ziccrse is "the forward-progress guarantee for such
loops", which does not cover this case.  The existing riscv
futex_atomic_cmpxchg_inatomic() has the same unbounded pattern, but that
does not make the new instance correct.

Should both loops be bounded the way arm64 does it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42069736200
--===============4354460838823676982==--
