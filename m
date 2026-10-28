Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151555;
	b=gdo8LbkBTFyKHAip7aqDYitx6CAzY1hMFREZVqSgSGtoWw0k2UTyv6dHGm3t9ZQQ/uhd
	 eKG4mUn2dbMisJq+U3vwPKSiL/zZLEHPez69IjFiKgCOaW4/mjcSKxSz1N6/HbAMNTFo7
	 YXGi9s1O5YpIBlMjQKcfQodBTjZ5hsMT3RQNQK6eTNJ1R2eLZKiP5BszN2TnIdTQnzFM2
	 ejtIWqk/yYNLeJcVQpVIaOHGaMBbhQTRq826VwDn+VZ2AQockXxpUpzCE1yPXbuy+4Ghf
	 EcXFcdLa+d//KKZgH0my/NVvUX7nLwTiaBbVDEs3aOheCptExQjxklMoHtVKSAPZSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151555;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=A87FZXA9a5ZtfFbaRBNlBmYgipJa+cj+6SnsRzBUS+c=;
	b=EerKfgj9MCTKN1+Z14S00L16DmiLZ4etRHdS/1tSC/cVZtgLsIsrTBpmgDu0H9jIEXWF
	 yW9ajLwlfZf3amPWF3p4o+Y1FAQye+efVYKg71yV1E+2bSa/QGRB2ur+ax/0oSTrfzF3L
	 MOSWvtDa/DN6eaF9UE0xRR1YQ0gQRYrx55JMAqK+8/WgXj7+xwbUh51+dF8Re7ILJq2P/
	 s+KqKO0HOCNbYt4ryQUj5tjicwX+tGBYCHj23vIV7xPSsIG6CHp5KotmT/Kta+ZqxHYYN
	 V9VY4dmam9KlexLy3iLLiUZdZACubwk8OETgB60kIoC20sKvGA6urwdXkQs/fkJgTXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXSRKBfk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D2606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXSRKBfk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B01F01825;
	Wed, 28 Oct 2026 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151555;
	bh=A87FZXA9a5ZtfFbaRBNlBmYgipJa+cj+6SnsRzBUS+c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IXSRKBfkGyxktM9O3Wy9kqBqcmO9gPXVcbsBf85lzE6GFzoMv33bZs9mODYRWrFId
	 Y70q0+GaRFqn4WMs9Vy6gKeU0H4uxqkP1mNkWzcmfO5brL8c1R5JhBSygJJC77a6+k
	 TlLS0nmq2fM0uX1NRDvrLwQYsJLhxHDeE3n3S/mBZqmJyZ03ZyhspaZuiPhCrJ2Smm
	 tDLksDVkeuF9oLEjFOizHr9g4YrZyoY0Df6BtKEP7EhGsfhXNqgjXRaXDPikXAydzT
	 CvO+GgWF788WaMKqX08fR43bgxvLUOcah0TEQNltEJBM6I2RehQrvRy9tuUTg8nSfk
	 R0US2/6J7Rzng==
Content-Type: multipart/mixed; boundary="===============0395306993928219988=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <81df2f63249021a13160d155eccab3bbd591e464d05db9765a15427c3cc97650@mail.kernel.org>
In-Reply-To: <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com>
References: <03d6c53ccdf3eb0f5503eae9f9ffa5e6570549c3.1793147364.git.memxor@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 01/11] bpf: Give a helper a way to call its callback with a pad
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 01:39:14 +0000 (UTC)

--===============0395306993928219988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Give a helper a way to call its callback with a pad

TL;DR:
- bpf_unwind_leave() may misbehave if the helper is ftrace/kretprobe/fexit
  traced: unwind lost, pointer or reference treated as scalar
- With gcc, bpf_call_cb() register variables may be clobbered by KASAN/KCSAN
  calls, possibly jumping to a bad address

> diff --git a/include/linux/bpf_unwind.h b/include/linux/bpf_unwind.h
> new file mode 100644
> index 000000000000..190d6dbae856
> --- /dev/null
> +++ b/include/linux/bpf_unwind.h
> @@ -0,0 +1,282 @@

[ ... ]

> +/*
> + * The registers the call clobbers are outputs, so that none of them can be an
> + * operand of anything else. r0 is rax, on the way out and on the way to the pad.
> + * The return address stays the byte after the call through what
> + * apply_retpolines() and apply_fineibt() make of the call: they pad in front of
> + * it, never behind it.
> + */
> +#define __bpf_call_cb(type, fn, a1, a2, a3, a4, a5, r0, unwound)		\
> +do {										\
> +	register u64 __fn asm("r11") = (u64)(long)(fn);				\
> +	register u64 __a5 asm("r8") = (u64)(long)(a5);				\
> +	register u64 __c5 asm("r8");						\
> +	register u64 __c11 asm("r11");						\
> +	u64 __c1, __c2, __c3, __c4;						\
> +										\
> +	asm_goto_output(BPF_KCFI_CHECK(type)					\
> +		 "	" CALL_NOSPEC "\n"					\
> +		 "1:\n"								\
> +		 _ASM_EXTABLE_TYPE(1b, %l[unwound], EX_TYPE_BPF)		\
> +		 : "=a"(r0), "=D"(__c1), "=S"(__c2), "=d"(__c3), "=c"(__c4),	\
> +		   "=r"(__c5), "=r"(__c11)					\
> +		 : [thunk_target] "r"(__fn), "D"((u64)(long)(a1)),		\
> +		   "S"((u64)(long)(a2)), "d"((u64)(long)(a3)),			\
> +		   "c"((u64)(long)(a4)), "r"(__a5)				\
> +		 : "r9", "r10", "memory", "cc"					\
> +		 : unwound);							\
> +} while (0)

Can the argument evaluation here clobber the register variables?

__fn is bound to r11 and __a5 to r8 before a1 through a4 are evaluated as
asm inputs.  The arm64 version has the same shape, binding x15 and x0
through x4 one after another before later arguments are evaluated.

With gcc, a register variable is only guaranteed to hold its register at the
asm statement itself.  If evaluating a later macro argument involves a call,
the earlier binding is not kept across it.

A later patch in this series (7a687425732b) calls:

    bpf_call_cb(callback_fn, map, elem->data,
                rhtab_elem_value(elem, map->key_size), callback_ctx, 0,
                ret, unwound);

The map->key_size load becomes a call to __tsan_read4 with CONFIG_KCSAN, or
to __asan_load4_noabort with CONFIG_KASAN_OUTLINE, and kernel/bpf is not
excluded from either.  That call is placed after the register variables
have been set.

On arm64 the call's own argument goes in x0, so the callback could get a
garbage map pointer, and x15 (the call target) can be clobbered as well.  On
x86 r11 and r8 are call-clobbered, so the call __x86_indirect_thunk_r11 that
follows could jump to a garbage address.

clang ties register variables only at the asm itself, so this would only
affect gcc builds.

Would it be safer to evaluate fn and a1 through a5 into ordinary
temporaries first, for example typeof(a) __t = a;, and only then declare the
register variables, the way the arm-smccc.h macros do?

> +
> +/*
> + * The return address of the helper is the word below its canonical frame
> + * address. The pad is in the frame that BPF code called, see above, so there is
> + * a pad to go to: a miss is a bug, and the exception would be lost in a return.
> + */
> +static __always_inline void bpf_unwind_leave(void)
> +{
> +	unsigned long *slot = (unsigned long *)__builtin_dwarf_cfa() - 1;
> +	unsigned long to = bpf_unwind_target(*slot);
> +
> +	WARN_ON_ONCE(to == *slot);
> +	*slot = to;
> +}

Can *slot hold something other than the address in the bpf program that
called the helper?

bpf_unwind_leave() assumes that it does, and the comment says a miss is a
bug.  While the helper is traced, though, the slot can be replaced:

  - function_graph: prepare_ftrace_return()/ftrace_graph_func() put
    return_to_handler in *parent
  - kretprobe/rethook: arch_rethook_trampoline is put there
  - a bpf fexit/fmod_ret trampoline calls the original function, so the
    return address is inside the trampoline

On arm64 the same replacement is made to the link register at entry, and the
prologue then saves it into the frame record that bpf_unwind_leave() reads.

kernel/bpf/Makefile removes CC_FLAGS_FTRACE only from percpu_freelist.o,
bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o and rqspinlock.o.
So bpf_loop() (bpf_iter.c), the map iterators (hashtab.c, arraymap.c),
bpf_find_vma() (task_iter.c) and bpf_rbtree_add (helpers.c) can all be
graph-traced.  They can also be kretprobed, and so can
bpf_user_ringbuf_drain().

Later commits in this series give these helpers pads (4e61c40fe5c0,
7a687425732b, 59e3a600668d, bee41eec3c39, ecd4c98df2ee) and add no notrace,
NOKPROBE or attach restriction.

If the callback unwinds in that state, bpf_unwind_target(return_to_handler)
misses in the bpf table and in the kernel table, and returns its argument:

    unsigned long to = bpf_unwind_target(*slot);   /* to == *slot */

    WARN_ON_ONCE(to == *slot);                     /* fires */
    *slot = to;                                    /* unchanged */

The helper then returns through the tracer to the normal continuation after
the call instead of to the pad, and the exception is lost after the helper
has already stopped and dropped what it holds.

There is also a typing consequence.  According to b2f03cf6322f the pad gets
the callback's r0 bit for bit, "a pointer stays the pointer it was, with its
type and its reference".  On the fallthrough path the verifier instead types
r0 as the helper's own return (RET_INTEGER, for example).  So a pointer or a
referenced object the callback unwound with reaches code that treats it as a
scalar, and the pad that would have consumed or released it never runs.

bpf_check_attach_target() already refuses the analogous case for bpf
targets: "Only fentry can attach to %s, which can unwind".  Is there
something equivalent for the C helpers that have a pad?

Would translating the slot with ftrace_graph_ret_addr() and the rethook
equivalent (and refusing fexit/fmod_ret on these helpers) cover this?
Alternatively, could the helpers with pads be made notrace and NOKPROBE, with
tracing attachment to them denied?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40612543702
--===============0395306993928219988==--
