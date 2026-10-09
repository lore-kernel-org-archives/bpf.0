Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126132E68D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529705; cv=none; b=oAjx1p0C6LH3HtLj3NR7niSo+2gEk+OTV/73msIUoQmdzb/skiziPtqLln/WCLkv8uSol7R4q2SoLB3i/vgDiK+Cp3yDV5NNOLnh08rHRvH58mpAr3i+GuCGZZfSSDGVcRvW1H3Q6fr8wl3wG+eV98v51w9Nzrn8rx3H2lEpuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529705; c=relaxed/simple;
	bh=/sBPhyg3ToLxxOq89HghXKwqykczmnxPmHoJTOkGv00=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gOp+XhNciJVqUtVX97oxr1ZDPw3uD3swGbcF0XFg9S2QyvtPnDdcUXQuZxCTOPL4+izhUXrZNwlzKu8EMYghnpIzPb2/cgdKHh4++ZQ03/MVZioSJXH01KWJtaB2nczIL/3FczJgkacDvQG3LEvsoBR3gmTN7+pMuB6MJSuRyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKt7gOGy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKt7gOGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E42E1F000FF;
	Fri,  9 Oct 2026 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791529703;
	bh=A/Z9Zijr4eLnTKkURXm7uaq2yBYRiy6/hrMrctujIQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKt7gOGypFgaMAu1BjOSTGJcHvTghX0GQcdkEsM0A7VYROTmXwkqE67pII+xWhJhh
	 8sBC37/JRY0G2R5SuYqrdzLIy5KK6RHvpKec3DZ1PkayKA2QpihUNs9Fbp23iU6ZTf
	 MNAM8qdOjML1XseS85gxmQs0I8jdlFVZ3hjM1YE7i5iHfiBDzWIOFY/nkBfqrbO0sJ
	 O/+ldLk0A94NRvTRbvg37tDI7BQwjGX9A6FrWNblZTj7n5Pc6a0zUqn8UKNY5nQigS
	 /Np7wbQtJkLGGzADsNKsIUQAr8zIdH5SSffFhZdI97hXV/N+qvbFTprALuo7vzx1Fy
	 WGBYpSOnKOu8A==
Message-ID: <sashiko-outbox-164976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/5] bpf, x86: Place trampoline arguments by
 the x86-64 calling convention
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009064221.1240081-1-yonghong.song@linux.dev>
References: <20261009064206.1238047-1-yonghong.song@linux.dev>
 <20261009064221.1240081-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:08:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf, x86: stack arguments offset mismatch and misalignment with BP=
F_TRAMP_F_TAIL_CALL_CTX
- [Medium] bpf: info leak of uninitialized kernel stack memory due to missi=
ng garbage cleanup
--

commit ffb54c9ff7ace6fffcfc471ab2c2927e34131e44
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Place trampoline arguments by the x86-64 calling convention

This commit updates the BPF trampoline to place on-stack arguments
according to the x86-64 calling convention. It introduces a backfill
mechanism using bpf_jit_place_args() to handle arguments like __int128
that may span stack slots and create alignment holes.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 083fcd6cf15b7..0fc7715e569b5 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -3472,8 +3479,35 @@ static void save_args(const struct btf_func_model =
*m, u8 **prog,
>  		 *
>  		 * the arg1-5,arg7 will be passed by regs, and arg6 will
>  		 * by stack.
> +		 *
> +		 * An argument aligned to 16 bytes, an __int128 or a struct
> +		 * holding one, also starts at an even stack slot, which can
> +		 * leave a hole before it. bpf_jit_place_args() worked out
> +		 * where each eightbyte is.
>  		 */
> -		if (nr_regs + arg_regs > 6) {
> +		for (j =3D 0; j < arg_regs; j++, slot++, bargs_off -=3D 8) {
> +			u8 pos =3D pos_of_slot[slot];
> +			u32 src;
> +
> +			if (!x86_arg_on_stack(pos)) {
[ ... ]
> +			/* copy function arguments from origin stack frame
> +			 * into current stack frame.
[ ... ]
> +			 *
> +			 * The area for the origin call mirrors the incoming
> +			 * one, hole and all; only the bpf program takes the
> +			 * arguments packed.
>  			 */
> -			for (j =3D 0; j < arg_regs; j++) {
> -				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> -					 nr_stack_slots * 8 + stack_args_off);
> -				if (arena_arg)
> -					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
> -							    (u32)arena_base);
> -				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
> -					 -stack_size);
> -
> -				if (!nr_stack_slots)
> -					first_off =3D stack_size;
> -				stack_size -=3D 8;
> -				nr_stack_slots++;
> -			}
> +			off =3D x86_arg_stack_off(pos);
> +			doff =3D for_call_origin ? stack_size - off : bargs_off;
> +			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
> +				 stack_args_off + off);
> +			if (arena_arg)
> +				emit_arena_arg_conv(prog, BPF_REG_0, nullable,
> +						    (u32)arena_base);
> +			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -doff);
> +
> +			if (!nr_stack_slots)
> +				first_off =3D doff;
> +			nr_stack_slots++;
>  		}
>  	}
> =20
>  	clean_stack_garbage(m, prog, nr_stack_slots, first_off);
>  }

[Severity: Medium]
Does this code leak uninitialized kernel stack memory?

The x86-64 ABI allocates 8-byte stack slots for arguments, but compilers
frequently use 32-bit instructions to place 32-bit arguments, leaving the u=
pper
4 bytes of the slot uninitialized.

Since clean_stack_garbage() explicitly returns early when nr_stack_slots !=
=3D 1,
copying the full 64 bits with emit_ldx(..., BPF_DW, ...) captures this
uninitialized kernel memory into the BPF context. Can this leak kernel stack
memory to privileged BPF users if there are multiple stack arguments?

[ ... ]
> @@ -4011,8 +4014,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
>  	}
> =20
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> -		restore_regs(m, &prog, regs_off);
> -		save_args(m, &prog, arg_stack_off, true, flags, 0);
> +		restore_regs(&prog, pos_of_slot, nr_regs, regs_off);
> +		save_args(m, &prog, pos_of_slot, arg_stack_off, true, flags, 0);
> =20
>  		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
>  			/* Before calling the original function, load the

[Severity: High]
Are stack arguments misaligned here if BPF_TRAMP_F_TAIL_CALL_CTX is active?

When __arch_prepare_bpf_trampoline() executes, it checks for
BPF_TRAMP_F_TAIL_CALL_CTX and emits a push rax instruction (pushing 8 bytes)
after sub rsp, stack_size, which permanently shifts RSP down by 8 bytes.

However, the updated save_args() calculates the stack argument offsets base=
d on
the original stack_size (doff =3D stack_size - off) without accounting for =
this
extra 8-byte shift.

Because the push rax is unpopped before call orig_call, the original functi=
on
will read its first stack argument from [RSP + 8]. Due to the 8-byte shift,
this points to the tail call counter pointer instead of the actual first st=
ack
argument, corrupting all on-stack arguments.

Additionally, doesn't this 8-byte shift break the required 16-byte stack
alignment on function entry for x86-64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009064206.1238=
047-1-yonghong.song@linux.dev?part=3D3
