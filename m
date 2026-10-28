Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150446;
	b=rs5WrKbl3zloZ2yVTeWfbslbKxbdpKAvF3of5py5gChREb+9ZlTTTlUoYyb5b2lg/lhw
	 mMRo6tAgsJUT+AsTockyspxk/Uq/AD7sQuraMRX3Dvsu9pP69mmXoQX7mNwhJL3AY/pHU
	 IFbF2bou53JMQXj0KAjRlxoptNJxAljYKp0x2nJ2iYyz69YF3AdxpIwfQvCSBE6rhzIzx
	 7KABEz1asCEVmIYJEUQZlQ/2fzye4OIaRmVvhkKBuYn+HhlUPtClyZWUVKj7XXAxfCgIa
	 N/T3VEH9p0coRB00q68KujsX9ADLXTXNgM7TlMT1MP77N8w92g+soKi2wVVZHCl4DTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WV+xq2EwzkT02SwUBZq/db/O91jZ3MxXqXM8UCtU/sU=;
	b=aRy6XqE3oLFy4Uxfqid1telHMSeGdTLO1u1USmPzcRP+ibIHsHXtqFtsSk3l+UpSbU6z
	 j9hF+K8blB343dajxxUE9JIAN7sxUv/vRRZ+0Ltjf/OYKZ8MYW3whwhvXWjx72h/vCPxi
	 yzuMMYkwo3nYbozRA7eWLGy0wnYBwPd8Z6c/g8lY1kzHDIXvsQJSiCWSwGDR9Iqr+zggU
	 +FT0MMXVa9xF+op+JysdnrNFKai8uYBJlscq3uIuQPh6Dg38Fps5D/hGCCf0Q5qfBRc7t
	 +SjFhFZGH3c9Eru4LJlfVpGDNPsVOZL2mB4ZG0DRIfeCZ7ynKdTmyxxTSeReVvsiS4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWMMkuwf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9342606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWMMkuwf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C6B1F01825;
	Wed, 28 Oct 2026 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150445;
	bh=WV+xq2EwzkT02SwUBZq/db/O91jZ3MxXqXM8UCtU/sU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mWMMkuwfLLxpiVuCyPBJFFpn6bB8g3+XRN8TQqZn+DE07DK9MlOxoC/wtnCb3RW9E
	 pUgvLG/I64xtKo1wTwQENenzvj7F4ZraJVeo0HbtaBtBggCLsb9vQw6p2P3UWc+Sik
	 WcnI2ZHsQA30n7sE2Ux0y+jtgNuNDYhdSr7dxaz1b23kRWEhy+q819Y+h3U47cWhpJ
	 TPx68spCeqvsKw5a8KV45QxCM7FElsSikI+rPPFsogCt1qoQKlqdHdoAxW6zOg3Re8
	 hVdg4jxf1LEHFZvv1++uYF4AvdSNGg9o9mGq5u+zDIxgzV/6bycwEYRGguMxSsRRMc
	 0VRULl9qN9YXg==
Message-ID: <sashiko-outbox-187312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 01/11] bpf: Give a helper a way to call
 its callback with a pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:20:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: clobber of local register variables during arg evaluation in =
__bpf_call_cb()
- [High] bpf: dead-store elimination of return address write in bpf_unwind_=
leave()
--

commit d437def6fc298113c802447cf3c5d5281b1f3dd3
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Give a helper a way to call its callback with a pad

This commit introduces bpf_call_cb() and bpf_unwind_leave() in
include/linux/bpf_unwind.h, along with bpf_unwind_target() in the x86-64
and arm64 JITs, so C helpers invoking BPF callbacks can catch callback
unwinds via an EX_TYPE_BPF exception table entry and redirect their own
return address to the caller's unwind pad.

> diff --git a/include/linux/bpf_unwind.h b/include/linux/bpf_unwind.h
> new file mode 100644
> index 0000000000000..190d6dbae8568
> --- /dev/null
> +++ b/include/linux/bpf_unwind.h
> @@ -0,0 +1,282 @@

[ ... ]

> +#define __bpf_call_cb(type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
> +do {										\
> +	register u64 __fn asm("r11") =3D (u64)(long)(fn);				\
> +	register u64 __a5 asm("r8") =3D (u64)(long)(a5);				\
> +	register u64 __c5 asm("r8");						\
> +	register u64 __c11 asm("r11");						\
> +	u64 __c1, __c2, __c3, __c4;						\
> +										\
> +	asm_goto_output(BPF_KCFI_CHECK(type)					\
> +		 "	" CALL_NOSPEC "\n"					\
> +		 "1:\n"								\
> +		 _ASM_EXTABLE_TYPE(1b, %l[unwound], EX_TYPE_BPF)		\
> +		 : "=3Da"(r0), "=3DD"(__c1), "=3DS"(__c2), "=3Dd"(__c3), "=3Dc"(__c4),=
	\
> +		   "=3Dr"(__c5), "=3Dr"(__c11)					\
> +		 : [thunk_target] "r"(__fn), "D"((u64)(long)(a1)),		\
> +		   "S"((u64)(long)(a2)), "d"((u64)(long)(a3)),			\
> +		   "c"((u64)(long)(a4)), "r"(__a5)				\
> +		 : "r9", "r10", "memory", "cc"					\
> +		 : unwound);							\
> +} while (0)
> +
> +/*
> + * The return address of the helper is the word below its canonical frame
> + * address. The pad is in the frame that BPF code called, see above, so =
there is
> + * a pad to go to: a miss is a bug, and the exception would be lost in a=
 return.
> + */
> +static __always_inline void bpf_unwind_leave(void)
> +{
> +	unsigned long *slot =3D (unsigned long *)__builtin_dwarf_cfa() - 1;
> +	unsigned long to =3D bpf_unwind_target(*slot);
> +
> +	WARN_ON_ONCE(to =3D=3D *slot);
> +	*slot =3D to;
> +}

[ ... ]

> +#define __bpf_call_cb(type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
> +	___bpf_call_cb(__UNIQUE_ID(unwound), type, fn, a1, a2, a3, a4, a5, r0, =
unwound)
> +
> +#define ___bpf_call_cb(lbl, type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
> +do {										\
> +	register u64 __fn asm("x15") =3D (u64)(long)(fn);				\
> +	register u64 __a0 asm("x0") =3D (u64)(long)(a1);				\
> +	register u64 __a1 asm("x1") =3D (u64)(long)(a2);				\
> +	register u64 __a2 asm("x2") =3D (u64)(long)(a3);				\
> +	register u64 __a3 asm("x3") =3D (u64)(long)(a4);				\
> +	register u64 __a4 asm("x4") =3D (u64)(long)(a5);				\

[Severity: High]
Can evaluating the macro arguments in ___bpf_call_cb() on arm64 and
__bpf_call_cb() on x86-64 clobber the caller-saved local register
variables before the asm_goto_output() statement is reached?

On arm64, ___bpf_call_cb() in include/linux/bpf_unwind.h initializes x15
and x0..x4 directly from the macro expressions in sequence:

	register u64 __fn asm("x15") =3D (u64)(long)(fn);
	register u64 __a0 asm("x0") =3D (u64)(long)(a1);
	register u64 __a1 asm("x1") =3D (u64)(long)(a2);
	register u64 __a2 asm("x2") =3D (u64)(long)(a3);
	register u64 __a3 asm("x3") =3D (u64)(long)(a4);
	register u64 __a4 asm("x4") =3D (u64)(long)(a5);

And on x86-64, __bpf_call_cb() assigns __fn (r11) and __a5 (r8) before
evaluating a1..a4 in the asm_goto_output() input operands:

	register u64 __fn asm("r11") =3D (u64)(long)(fn);
	register u64 __a5 asm("r8") =3D (u64)(long)(a5);
	...
		 : [thunk_target] "r"(__fn), "D"((u64)(long)(a1)),
		   "S"((u64)(long)(a2)), "d"((u64)(long)(a3)),
		   "c"((u64)(long)(a4)), "r"(__a5)

Per GCC and Clang local register variable rules, local register variables
do not reserve caller-saved registers across function calls that occur
between their assignment and the extended asm statement.

Later in this series, commit "bpf: Let the callback of
bpf_for_each_map_elem unwind" updates bpf_each_rhash_elem() in
kernel/bpf/hashtab.c to pass a helper call and pointer dereferences as
macro arguments:

	bpf_call_cb(callback_fn, map, elem->data,
		    rhtab_elem_value(elem, map->key_size), callback_ctx, 0,
		    ret, unwound);

If evaluating a3 or another argument invokes a function call -- such as an
out-of-line call to rhtab_elem_value() (which is marked static inline
rather than __always_inline) or sanitizer instrumentation like
__asan_load4() under outline KASAN or __tsan_read4() under KCSAN -- that
call executes after __fn (x15 / r11) and earlier argument registers (x0,
x1 / r8) have already been populated, clobbering the callback target and
arguments prior to blr x15 or CALL_NOSPEC.

Should fn and a1..a5 be evaluated into ordinary C temporary variables
first before assigning them to the local register variables, similar to
how include/linux/arm-smccc.h stages register arguments?

> +	register u64 __c0 asm("x0");						\
> +	register u64 __c1 asm("x1");						\
> +	register u64 __c2 asm("x2");						\
> +	register u64 __c3 asm("x3");						\
> +	register u64 __c4 asm("x4");						\
> +	register u64 __c15 asm("x15");						\

[ ... ]

> +static __always_inline void bpf_unwind_leave(void)
> +{
> +	unsigned long *slot =3D (unsigned long *)__builtin_frame_address(0) + 1;
> +	unsigned long from =3D ptrauth_strip_kernel_insn_pac(*slot);
> +	unsigned long to =3D bpf_unwind_target(from);
> +
> +	WARN_ON_ONCE(to =3D=3D from);
> +#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
> +	{
> +		register unsigned long x17 asm("x17") =3D to;
> +#ifdef __clang__
> +		register unsigned long x16 asm("x16") =3D (unsigned long)__builtin_spo=
nentry();
> +#else
> +		register unsigned long x16 asm("x16") =3D (unsigned long)__builtin_dwa=
rf_cfa();
> +#endif
> +
> +		asm("pacia1716" : "+r"(x17) : "r"(x16));
> +		to =3D x17;
> +	}
> +#endif
> +	*slot =3D to;
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +	if (scs_is_enabled()) {
> +		unsigned long *scs;
> +
> +		asm("mov %0, x18" : "=3Dr"(scs));
> +		scs[-1] =3D to;
> +	}
> +#endif
> +}

[Severity: High]
Could the compiler eliminate the *slot =3D to store in bpf_unwind_leave()
(on both x86-64 and arm64) as a dead store to the current function's stack
frame right before returning?

In include/linux/bpf_unwind.h, both implementations of bpf_unwind_leave()
compute slot from __builtin_dwarf_cfa() or __builtin_frame_address(0) as a
non-volatile unsigned long * and perform a plain store:

	*slot =3D to;

Because bpf_unwind_leave() is __always_inline and runs at the end of the
helper's unwound path immediately before return, nothing in C reads *slot
before the function exits. In GCC's RTL dead-store elimination pass
(pass_rtl_dse1, which runs before prologue/epilogue threading),
non-volatile frame-related stores based on arg_pointer_rtx
(__builtin_dwarf_cfa()) or hard_frame_pointer_rtx
(__builtin_frame_address(0)) that are not read before EXIT_BLOCK are
candidates for elimination. If *slot =3D to is elided, the helper returns to
its normal call site instead of the caller's unwind pad, losing the BPF
exception after the helper has already released its resources.

Existing kernel code that overwrites the stack return address via
__builtin_frame_address(0) in drivers/misc/lkdtm/cfi.c:set_return_addr()
explicitly marks the store volatile for this reason:

	/* Use of volatile is to make sure final write isn't seen as a dead store.=
 */
	unsigned long * volatile *ret_addr =3D
		(unsigned long **)__builtin_frame_address(0) + FRAME_RA_OFFSET;

	/* Make sure we've found the right place on the stack before writing it. */
	if (no_pac_addr(*ret_addr) =3D=3D expected)
		*ret_addr =3D (addr);

Should bpf_unwind_leave() use WRITE_ONCE(*slot, to) (and
WRITE_ONCE(scs[-1], to) on arm64) or qualify slot as volatile so the
return-address update cannot be optimized away?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D1
