Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F12E7F20
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356283; cv=none; b=cKQCh/1WNl490rzzTTB1zwM+EdyN6MOCkUu94o7EROsBjzzj5lrd/SFVaO/06WFa7rD381cQDhCvJm0UT5kn3yc6DXRMEbmENuDXqQM9n42DE7O2ZjhltOOqN7a/9WH28GsoXm7cjEu7XIGFx4XsHPB7bLJWgKpIIiGMVJ9VaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356283; c=relaxed/simple;
	bh=WNi2L5VbZhTRor1ql7YmwwBb0Mcc7PFgO/oSFo5riKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smK+sGjUTLUh/TqlJk8CDvGNGDXImqPcSpwsizDXvAYCjdnh9FPoxKNQ7NWLhzyIJ5PBYYeD9CENobK7xtVD2Sc62gLH3oLMe/XYeTnHj+z/gAw4HSBv+XyQzKms4mQ/zgg1o58JgBsNTq6Uuxt17bFv2AqCuoCia7ipb0OetwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBJCeP1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBJCeP1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137D51F000E9;
	Fri, 21 Aug 2026 23:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787356282;
	bh=PCCJmaWrqOMj8CB1rZlegg0Gm3vDJvBhAzLJQYLvik8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cBJCeP1SwFzFnbyhBqk3ZqnKn3RPPyaHHnpd+h+h3t5pIOUU44RrHP2sVdpR7iXEg
	 JGeEFZ5UiMOdEbSKA/e2OWuwfcd1xXOIGwPjVLxwZNtRaNJIQitwQpP3XMViyDtN68
	 B4AlBGuUffhYZ/CndKiuDwCkDlUOEUnc5qsgUHXeI+lKCI5cA0YE3hUgDFgJVTMj00
	 rbhj0tZ79ojTJ4WY6ltZvV1BaDZsqOb5eZVXS8y6wxzaLDBr2QVr9LFnZcQg4m7EQI
	 Ragjgg2ymXdYc+JQSuQuM7i8CA2XQWB6Td0KfFGGDZQiy96cm9yrjWtCM17bDDc3eM
	 VzcWQKoJvoydQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 09/14] bpf, loongarch: Convert struct_ops
 arena arguments in trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821233516.3426127-10-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-10-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 23:51:21 +0000
Message-Id: <20260821235122.137D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `cast_user` JIT implementation on LoongArch fails to preserve =
NULL pointers due to an incorrect branch offset.
--

--- Patch [9]: [PATCH bpf-next v1 09/14] bpf, loongarch: Convert struct_ops=
 arena arguments in trampolines ---
commit ef7bc691896c4955d9e0b94ff8e49c81e26f20ef
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf, loongarch: Convert struct_ops arena arguments in trampolines
   =20
This patch allows an arena BPF program on LoongArch to receive
native kernel addresses converted to 32-bit arena offsets for
struct_ops callbacks. It introduces emit_arena_arg_conv() to
handle the conversion while preserving native NULL pointers.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 33cabaa7353f9..5020414bfd9f2 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
[ ... ]
> @@ -1680,21 +1685,55 @@ int bpf_arch_text_invalidate(void *dst, size_t le=
n)
>  	return ret;
>  }
> =20
> -static void store_args(struct jit_ctx *ctx, int nr_arg_slots, int args_o=
ff, bool is_struct_ops)
> +/*
> + * Convert an arena kernel address into a 32-bit arena offset while copy=
ing it
> + * into the BPF ctx. A nullable argument preserves a native NULL.
> + */
> +static void emit_arena_arg_conv(struct jit_ctx *ctx, int dst, int src, b=
ool nullable, int base)
> +{
> +	if (dst !=3D src)
> +		move_reg(ctx, dst, src);
> +	if (nullable)
> +		emit_insn(ctx, beq, dst, LOONGARCH_GPR_ZERO, 2);

[Severity: High]
This is a pre-existing issue, but seeing the correct offset of 2 used here =
for
the beq instruction made me notice a potential bug in build_insn() when
handling cast_user:

arch/loongarch/net/bpf_jit.c:build_insn() {
...
    emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 1);
    emit_insn(ctx, or, t1, dst, t1);
    move_reg(ctx, dst, t1);
...
}

Does this pre-existing offset of 1 cause the branch to jump to the immediat=
ely
next instruction (PC + 4), failing to skip the 'or' instruction?

If so, would a NULL user pointer casted via cast_user incorrectly receive t=
he
value of user_vm_start instead of remaining NULL?

Could this lead to invalid pointers being passed to userspace, potentially
causing logic errors or data corruption if userspace believes the pointer is
valid and writes to the start of the arena?

> +	emit_insn(ctx, subd, dst, dst, base);
> +	emit_zext_32(ctx, dst, true);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821233516.3426=
127-1-memxor@gmail.com?part=3D9
