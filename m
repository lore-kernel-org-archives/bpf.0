Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522535;
	b=LQVI67a7fnVGD7iZYt1wST6v8+zC38zxkUJbSxrLr/wHXKAYyaA9kFdr6QqKcc4p0Sr3
	 Emq4ECPi4lS8oxzGaOhu8PHADEAVvyodmybQ1pflvBhe39SDErN0sU87NBEr6fpWVKV0S
	 SzErf309XIaBlsz6OHlTAQjh+cyBxKlALjterwZ936ygtD7irUxj4qMTBmZ4T8CSjyhXE
	 VvL72iZimArNnoYgUxDBfjkcBFOfuSR08PNWhZSP4cifpok6fArSQGeL5I0Vq0b72ouC1
	 Xzu/VS2pF9L4WPajMloVSosaD9W/CuO/NkhI2aP8ZSQS9uCu66fHuZFQpXhMBGXA7UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522535;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=YN5l1F1WkAC5DzEkakx77XHf5PwoQiFtzuDBxVBHuN8=;
	b=4wYHjWBEPKCTmPgwpd/5+H9wtkB4Fb0CRdVNdtbd1+dk/qNM8meatWWF/iAubFJ38k1J
	 6bnx/59RcAgK3+r1LrcNwGcaUPYzIRVppEcrilw5jKCAui37KcCEW6b0UiVOxmchUDHXx
	 IkVgirN5zH36okAy2w6wSl1tk7dcNAUWd49FyP65epTT6tXmBAMQAUVG9KVTq11PDwEBp
	 ESt7T5U26PoXgEYYVZF7vFRO87SPHCTgsYcgK8uIBKI6n1SO3Z1BskOE0Oq3xqlE0ik6l
	 E7GztAm/Y8UT50GT15MqDTG4FqgrQWyjTbMRit9AH+TpDHNfYnU/EDzpxFwrUNCv/yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+dN3uU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D274606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+dN3uU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699071F000C9;
	Tue, 20 Oct 2026 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522534;
	bh=YN5l1F1WkAC5DzEkakx77XHf5PwoQiFtzuDBxVBHuN8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J+dN3uU1Q+weTbkFSVrkKkJqZO3w18QVj2mYbPCCvbwLHAvGHg5HN0gNmc/bPC8DH
	 FnrKzREy/ArZQ87K2QkZonH35H2oJEw4vB/Ghi9qqbI062JESXAIZwyFivT3/6f5Mb
	 drLziZ4muJDTlf14K8BvdoVgHd1lXWDwOa1ZdPQGN1pYEkl6RsqLzYcqO+4Zkw8KYZ
	 Jz0zWnqIw3IgpKFPELe0CNfX02JRIxtPIUB2gY5JVwET2vOOCVjvf15epjl9nHYfwP
	 3Vw7oFxsQ4l1Cz3ZNf33uNcFsy9UqojWQpVyAz/WUkXcLqR3Nix8YPmpr5Bokgia9d
	 oACr1HefA8Geg==
Content-Type: multipart/mixed; boundary="===============6361276860528685436=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5f24cbed1ec4a6a0ecd0b834d738c48dc9eb64362be4fa50dfb0eaddfad928b3@mail.kernel.org>
In-Reply-To: <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/6] bpf, x86: Support unwind_goto and unwind_exit
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:55:34 +0000 (UTC)

--===============6361276860528685436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, x86: Support unwind_goto and unwind_exit

TL;DR: An exception callback's unwind_exit may return into an unwind pad the
verifier never checked for that path (via freplace or tail call), possibly
yielding unsafe register state; JIT should skip it there.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> +static u64 bpf_unwind_target(u64 ret_addr)
> +{
> +	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
> +
> +	/*
> +	 * The verifier made sure that unwind_goto follows a call in a prog. When
> +	 * the kernel called an async or an exception callback, it's exit.
> +	 */
> +	return e ? ret_addr + e->fixup : ret_addr;
> +}
> +
> +/* unwind_exit: fix the return address of this frame. r0 and r2 are returned. */
> +static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
> +{

[ ... ]

> +	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */

[ ... ]

> @@ -3774,13 +3865,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			break;
>
>  		case BPF_JMP | BPF_EXIT:
> +			if (src_reg == BPF_UNWIND_EXIT && bpf_prog_can_unwind(bpf_prog) &&
> +			    emit_unwind_ret_addr(&prog, ip))
> +				return -EINVAL;
>  			if (seen_exit) {

Can an exception callback's unwind_exit land in a pad that the verifier
never explored for that path?

An exception callback is a subprog (func_idx != 0), so
bpf_prog_can_unwind() is true for it and do_jit() emits
emit_unwind_ret_addr() for its unwind_exit.  The verifier treats
unwind_exit in an exception callback as a plain exit, and
prepare_func_exit() only handles curframe > 0.  The comment in
bpf_unwind_target() relies on the same assumption:

    /*
     * The verifier made sure that unwind_goto follows a call in a prog. When
     * the kernel called an async or an exception callback, it's exit.
     */

The exception callback does not run in a frame of its own, though.
bpf_throw() calls ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, 0, 0)
with the frame of the first non-subprog prog on the stack, and
emit_prologue() does "mov rbp, rdx" for is_exception_cb.  So
"mov rdi, [rbp + 8]" reads the return address of the main prog's frame,
and that address is not always in the kernel:

- Extension: freplace is a jmp from the replaced subprog's nop5
  (bpf_arch_text_poke(..., BPF_MOD_JUMP, ..., prog->bpf_func)), so
  [rbp + 8] of the extension's frame is the return address of "call b" in
  the target prog.

- Tail call from a subprog: emit_bpf_tail_call_indirect() does not pop rbp
  and jumps past push rbp / mov rbp, rsp, so the tail-called main prog runs
  in the subprog's frame and [rbp + 8] is the return address of "call S" in
  the caller.

If an unwind_goto follows that call, search_bpf_extables() finds its entry
and the exception callback returns into the pad.

One example with extensions: target prog P has

    call a; unwind_goto pad; ...; call b; unwind_goto pad

where global a() can unwind and global b() cannot.  The pad is seen via
a(), so bpf_opt_hard_wire_dead_code_branches() keeps the unwind_goto after
"call b" and the JIT emits an extable entry for it.

Extension E replaces b().  E's main has no unwind_exit, so
prog->aux->can_unwind (which is only subprog_info[0].can_unwind) is false
and the "Extension program can unwind, while original does not" check
passes.  E calls bpf_throw(), and E's exception callback ends with
"r0 = 0; unwind_exit".

At runtime the callback returns into P's pad with the registers and
references that follow "call b".  The verifier only checked the pad with
the state that follows "call a" unwinding, e.g. r6 as a map value pointer
there, while P could set r6 to an arbitrary scalar before "call b".

The tail call route does not need an extension.  A subprog S with
unwind_exit (for example one that returns a pointer in r0 on its unwind
path) tail-calls T, T throws, and T's exception callback unwind_exit sends
it into P's pad after "call S" with r0 taken from the callback.

Should do_jit() skip emit_unwind_ret_addr() when bpf_prog->aux->exception_cb
is set, so the JIT matches the verifier's "exception callback unwind_exit
is exit" model?  The alternative is for the verifier to account for the
exception callback's can_unwind.

The arm64 patch in this series, c1df16f0ed1d ("bpf, arm64: Support
unwind_goto and unwind_exit"), has the same structure, and none of the
later commits in the series change this.

>  				jmp_offset = ctx->cleanup_addr - addrs[i];
>  				goto emit_jmp;
>  			}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39474515830
--===============6361276860528685436==--
