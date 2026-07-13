Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0A361DDA
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979156; cv=none; b=bjluoUf/gxnJkgWZDcsjLqbLe6XRG0bPvOh67SNvr5NeisTWwjL0ZxyKIOOnfmeegA55BPgS4UY2WVixn36aZxCan9GuvmOqsgE/dldPxILdyex6zW5gPebIwgBXHM0z+q12oHLiuuvA9jxbioKu/kDEfn8NNPaVqKJVH40jzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979156; c=relaxed/simple;
	bh=xHSlpDS1uRfFzzC+WcIVYh4VBBtoWevu7x5mes11FTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aqcjcTJ2O+Xor3qwArQj/NRiw0qNfcTIXxEfUOHAjjxavn+BGHebjn47GWfqzlyt9MnH5iYeZAqvF8B3iYoHMlr9BC7mtkBqe2u6rEpvw2gBs3kyM8COEtw9IMAoTlHfPqJJUnlo+VNgfszlSSkuG674GLgYwCclje3QmfenkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSRZNmsM; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSRZNmsM"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so15303925e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783979151; x=1784583951; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zM90CX3PPNPUiEG0tzsIzjHh1Y33L9R+K2TV0tx8BJU=;
        b=SSRZNmsMQerrVfzSUcL3Q+PJqNeOOgCx1KwmRYHG7c1wwnVkaDO/o3iGeUNjCtjgrh
         SKeu7hCV+3MPDcdroTVObDada0v2d4FrlUGmxQrvnVSc4XGqwYt6ZydO2XqBryec54YD
         z0bKrh92Bgxm3G0Mgdh/iwuQY/RPcAszmtzPx4gG/0OCrhowb/CwwNcFe2wi9B8k3QRZ
         DDITyyr/72E/Rg/e+CEtXdy5bLs2Jqf1c86OALZHoZw43V3zSX8M53J8gY8vOI697kPG
         Zz2pSmq00cxQ4dLUywGKlTd7o3SGx4hnhwa3eCekHsl5PiuwtcWNCxMA+UNJdDsh53Zp
         WYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979151; x=1784583951;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zM90CX3PPNPUiEG0tzsIzjHh1Y33L9R+K2TV0tx8BJU=;
        b=EWRKYz0f1Wi1bO/XU8bjKr/qr+8Aq5ojqtS6a+eciqn1kHS6p6Nyu++11ITrvZWFxS
         TbUOoOyD77JCUVsv9Xhez/KPI4OE95boiKm7WMxOPgNOu36ejt7yq9aSaYSBxi741nA0
         FIJl9gAOH3rDdj7xtLYHVMg/v+yDZbsAg+z9Ue1rzuDi2mZX4RnZssrV/NamdB+dtbY+
         ZJlgAm80qiDZkr2VhzSs2cNOwRw7vP66Y0vF/WSXmyC6K08IKr8VlEImfBzPyJddR/fi
         mpvQedMM1qD5uHIPuscR4jG+26/moD+Ebq8XJNtr2nTzCqk2XEllr89ar6AAQbw6tIhA
         EZeg==
X-Forwarded-Encrypted: i=1; AHgh+RqEBJEJU5XeUGrG4mol5UrbE5aMm++utxHUAvPjYEnt2RhpH2vnjnRTdHu9Qqf6ciApGd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyi7nC8gQBhzrQy4EZCZ50e9iNwk87sz5pPLYz6nA7MkQsP38y
	baEtBhzgOofqdiRHbWV/kkn57V1s3e6AaPAm6gcQoBGysqczvrx9fgBt
X-Gm-Gg: AfdE7clgk4tOYu36D1piPJmNFz6wBv+Wc8Az+yC2uP/j8gjwYIJWCGbEFrpxWp6dVrW
	VvzqR0sggz2zKmHlto42v7/PB16FnCxdMFdC84TT6ZoJGEW86s4bFDArcgcutKQ+Lv4GhhFYpqm
	813qpb7XZI+gZAufPX7vwURjqoz5cu+H/7OHZYeNFHE0i0uwbaJoNYp5PY8NY/uLUXzNttpTk1r
	KWiAawpKGFTqCrhW3TGA8hetdUD3FOKqGW4eHmFndaMKxLsrG4j4d0vjh7JbeRCIFvRd1o9fBq+
	GNOADC+P3I74Yis7u2AsIvQF7yvjgY7AU2dJThiCwfontEFmYXsJLbsQrgnD9g5s5+PudFROUyh
	3hVtWihf2l+vkuUPO3gOU9KJmlqTwFfI2wnL9PxqNt4ztAFwfjxkdm77+l2cpmfNiL1FwSd+jyP
	PzWzatGLfkydnq8Da4HT44dkTh14C/DL8Q1NSqL9pwAMoDImBUytuzqyfO+JSUZz2OtSNxtwAPG
	1/2cfLU9vDgnqOk3oW76w/wbqPiZDI+WRbaVQDsUHxHdCWdtDYvJDw=
X-Received: by 2002:a05:600c:19c7:b0:493:fa7d:56a0 with SMTP id 5b1f17b1804b1-493fa7d589cmr103160745e9.13.1783979150439;
        Mon, 13 Jul 2026 14:45:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d88698sm313845205e9.1.2026.07.13.14.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 23:45:49 +0200
Message-Id: <DJXRTVC42PS0.297MXELFLCAEE@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET SLOP RFC 1/6] bpf: Support __arena suffix for kfunc
 arguments
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260713024414.3759854-1-tj@kernel.org>
 <20260713024414.3759854-2-tj@kernel.org>
In-Reply-To: <20260713024414.3759854-2-tj@kernel.org>

On Mon Jul 13, 2026 at 4:44 AM CEST, Tejun Heo wrote:
> Passing an arena pointer to a kfunc takes two steps today. There is no
> arena pointer argument type, so the pointer crosses the boundary as a bar=
e
> scalar, and the kfunc then offsets it by the arena base and casts it
> before it can touch the memory. Every such kfunc open-codes the same
> translation.
>
> Add the __arena argument suffix and both steps go away. The kfunc declare=
s
> the parameter by its real pointer type and dereferences it directly. The
> verifier rebases each one at the call site, rN =3D kern_vm_start + (u32)r=
N
> with NULL preserved. No bounds check is needed: the u32 offset stays with=
in
> the guard-padded arena kernel mapping, and a fault on an unpopulated page
> recovers through the per-arena scratch page. A suffixed argument accepts =
a
> PTR_TO_ARENA or scalar register, matching global subprog arena arguments.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst | 22 +++++++++
>  include/linux/bpf_verifier.h |  2 +
>  kernel/bpf/verifier.c        | 86 +++++++++++++++++++++++++++++++++---
>  3 files changed, 105 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index c801a330aece..bad2ac85b318 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -250,6 +250,26 @@ This annotation is used to indicate that the argumen=
t is a constant string.
>                  ...
>          }
>
> +2.3.7 __arena Annotation
> +------------------------
> +
> +This annotation is used to indicate that the pointer argument points int=
o
> +the program's arena. The verifier translates it to a directly
> +dereferenceable kernel address before the call, subject to the access
> +rules described in :ref:`BPF_kfunc_arena_access`. NULL is preserved and =
the
> +kfunc is responsible for checking for NULL before dereferencing.
> +

Here we can specify the maximum permitted size (GUARD_SZ/2 =3D 32kb).

> +An example is given below::
> +
> +        __bpf_kfunc int bpf_process_item(struct item *item__arena)
> +        {
> +        ...
> +        }
> +
> +Calling such a kfunc requires the program to use an arena map. The progr=
am
> +can pass any value without compromising the kernel. A value that does no=
t
> +point into the arena is a program bug.
> +
>  .. _BPF_kfunc_nodef:
>
>  2.4 Using an existing kernel function
> @@ -487,6 +507,8 @@ In order to accommodate such requirements, the verifi=
er will enforce strict
>  PTR_TO_BTF_ID type matching if two types have the exact same name, with =
one
>  being suffixed with ``___init``.
>
> +.. _BPF_kfunc_arena_access:
> +
>  2.8 Accessing arena memory through kfunc arguments
>  --------------------------------------------------
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 317e99b9acc0..2153d546736a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -690,6 +690,8 @@ struct bpf_insn_aux_data {
>  	 */
>  	u8 fastcall_spills_num:3;
>  	u8 arg_prog:4;
> +	/* bitmask of R1-R5 kfunc args to rebase to arena kernel addresses */
> +	u8 arg_arena_regs;
>
>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03e2202cca13..b2b00a612e58 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10856,6 +10856,11 @@ static bool is_kfunc_arg_irq_flag(const struct b=
tf *btf, const struct btf_param
>  	return btf_param_match_suffix(btf, arg, "__irq_flag");
>  }
>
> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_p=
aram *arg)
> +{
> +	return btf_param_match_suffix(btf, arg, "__arena");
> +}
> +
>  static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
>  					  const struct btf_param *arg,
>  					  const char *name)
> @@ -12060,6 +12065,32 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			continue;
>  		}
>
> +		if (is_kfunc_arg_arena(btf, &args[i])) {
> +			t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> +			if (verifier_bug_if(!btf_type_is_ptr(t), env,
> +					    "kfunc %s arg#%d has __arena tag on non-pointer",
> +					    func_name, i))
> +				return -EFAULT;
> +			if (!env->prog->aux->arena) {
> +				verbose(env,
> +					"%s arena pointer requires a program with an associated arena\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			if (regno < 0) {
> +				verbose(env, "%s arena pointer cannot be a stack argument\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			if (reg->type !=3D PTR_TO_ARENA && reg->type !=3D SCALAR_VALUE) {
> +				verbose(env, "%s is not a pointer to arena or scalar\n",
> +					reg_arg_name(env, argno));
> +				return -EINVAL;
> +			}
> +			cur_aux(env)->arg_arena_regs |=3D BIT(regno - BPF_REG_1);
> +			continue;
> +		}
> +
>  		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta, =
i))
>  			continue;
>
> @@ -19890,13 +19921,58 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
>  		*cnt =3D 6;
>  	}
>
> -	if (env->insn_aux_data[insn_idx].arg_prog) {
> -		u32 regno =3D env->insn_aux_data[insn_idx].arg_prog;
> -		struct bpf_insn ld_addrs[2] =3D { BPF_LD_IMM64(regno, (long)env->prog-=
>aux) };
> +	if (env->insn_aux_data[insn_idx].arg_prog ||
> +	    env->insn_aux_data[insn_idx].arg_arena_regs) {
> +		unsigned long arena_regs =3D env->insn_aux_data[insn_idx].arg_arena_re=
gs;
> +		u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(env->prog->aux->aren=
a);
> +		u32 prog_regno =3D env->insn_aux_data[insn_idx].arg_prog;
>  		int idx =3D *cnt;
> +		int bit;
>
> -		insn_buf[idx++] =3D ld_addrs[0];
> -		insn_buf[idx++] =3D ld_addrs[1];
> +		if (verifier_bug_if(idx, env, "kfunc call at %d already patched", insn=
_idx))
> +			return -EFAULT;
> +
> +		/*
> +		 * A kfunc may take both an __arena arg and the __prog aux. Emit
> +		 * each present fixup, then append the call once.
> +		 */
> +		if (arena_regs) {
> +			bool blinding =3D env->prog->blinding_requested;
> +			int base_reg =3D blinding ? BPF_REG_0 : BPF_REG_AX;
> +			struct bpf_insn ld[2] =3D { BPF_LD_IMM64(base_reg, kern_vm_start) };
> +
> +			/*
> +			 * rN =3D kern_vm_start + (u32)rN, NULL left as 0.
> +			 * Constant blinding rewrites immediate-carrying insns
> +			 * unless they use BPF_REG_AX. With hardening, the
> +			 * constant sits in R0 (an AX-destined LD_IMM64 would be
> +			 * corrupted) and NULL is tested against AX =3D 0. Without
> +			 * hardening, use the cheaper AX constant and immediate
> +			 * test.
> +			 */
> +			insn_buf[idx++] =3D ld[0];
> +			insn_buf[idx++] =3D ld[1];
> +			if (blinding)
> +				insn_buf[idx++] =3D BPF_MOV64_IMM(BPF_REG_AX, 0);
> +
> +			for_each_set_bit(bit, &arena_regs, MAX_BPF_FUNC_REG_ARGS) {
> +				int regno =3D BPF_REG_1 + bit;
> +
> +				insn_buf[idx++] =3D BPF_ZEXT_REG(regno);
> +				insn_buf[idx++] =3D blinding ?
> +					BPF_JMP_REG(BPF_JEQ, regno, BPF_REG_AX, 1) :
> +					BPF_JMP_IMM(BPF_JEQ, regno, 0, 1);
> +				insn_buf[idx++] =3D BPF_ALU64_REG(BPF_ADD, regno, base_reg);
> +			}
> +		}
> +		if (prog_regno) {
> +			struct bpf_insn ld_addrs[2] =3D {
> +				BPF_LD_IMM64(prog_regno, (long)env->prog->aux)
> +			};
> +
> +			insn_buf[idx++] =3D ld_addrs[0];
> +			insn_buf[idx++] =3D ld_addrs[1];
> +		}
>  		insn_buf[idx++] =3D *insn;
>  		*cnt =3D idx;
>  	}

I think overall this makes sense. One thing we can change is making __arena
imply non-NULL arena pointers, which will lead to a more optimized sequence=
, and
__arena_nullable when we want NULL to be preserved in either direction, to
represent optional data.

We likely need two bitmaps, one to represent nullness of arena regs and one=
 for
arena regs.

Also, instead of handling them in fixup in verifier, we can let JITs handle=
 them
because they already hold arena base in some fixed register.

E.g. we can add the following in kernel/bpf/core.c.

struct bpf_jit_arena_args {
	u8 regs;
	u8 nullable_regs;
};

struct bpf_jit_arena_args
bpf_kfunc_arena_args(const struct bpf_verifier_env *env,
		     const struct bpf_prog *prog, int insn_idx)
{
	struct bpf_jit_arena_args args =3D {};

	if (!env)
		return args;

	insn_idx +=3D prog->aux->subprog_start;
	args.regs =3D env->insn_aux_data[insn_idx].arg_arena_regs;
	args.nullable_regs =3D
		env->insn_aux_data[insn_idx].arg_arena_nullable_regs;
	return args;
}

The accessor expects a zero-based instruction index local to prog.
x86=E2=80=99s JIT loop is one-based and must pass i - 1 in such case.
You can see bpf_insn_is_indirect_target()'s usage for inspiration.

For now I guess we can add support for x86 and arm64. I'll show pseudocode =
for
both x86, arm64 would be similar in spirit.

We can place a new emit_kfunc_arena_args() right before emit_call().

if (!imm32)
	return -EINVAL;

if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
	emit_kfunc_arena_args(env, bpf_prog, i - 1, &prog);

ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
emit_call(&prog, func, ip);

For emit_kfunc_arena_args(), it would look something like this (pseudocode-=
ish):

static int
emit_kfunc_arena_args(struct bpf_verifier_env *env,
		      struct bpf_prog *prog, int insn_idx,
		      u8 **pprog)
{
	struct bpf_jit_arena_args args;
	u8 *native_prog =3D *pprog;
	int bit;

	args =3D bpf_kfunc_arena_args(env, prog, insn_idx);

	if (WARN_ON_ONCE(args.nullable_regs & ~args.regs))
		return -EINVAL;

	if (WARN_ON_ONCE(args.regs && !prog->aux->arena))
		return -EINVAL;

	for (bit =3D 0; bit < MAX_BPF_FUNC_REG_ARGS; bit++) {
		int reg;

		if (!(args.regs & BIT(bit)))
			continue;

		/*
		 * These logical JIT registers map as:
		 *
		 * BPF_REG_1 -> RDI
		 * BPF_REG_2 -> RSI
		 * BPF_REG_3 -> RDX
		 * BPF_REG_4 -> RCX
		 * BPF_REG_5 -> R8
		 */
		reg =3D BPF_REG_1 + bit;

		/*
		 * mov reg32, reg32
		 *
		 * Extract the low 32 bits and clear the native register's
		 * upper 32 bits.
		 */
		emit_mov_reg(&native_prog, false, reg, reg);

		if (args.nullable_regs & BIT(bit)) {
			/*
			 * test reg32, reg32
			 * jz after_add
			 */
			emit_test_reg32(&native_prog, reg);

			/*
			 * add reg64, r12 is three bytes for all argument
			 * registers, so a short jump can skip it directly.
			 */
			emit_jz_short(&native_prog, /* displacement */ 3);
		}

		/*
		 * add reg64, r12
		 *
		 * R12 contains kern_vm_start.
		 */
		emit_add_reg64(&native_prog, reg, X86_REG_R12);
	}

	*pprog =3D native_prog;
	return 0;
}

arm64 will be similar, but I will let AI figure out that one. One opportuni=
ty
for arm64 case is to use add xN, x28, wN, uxtw single-instruction sequence =
for
non-nullable case.

Lastly, we should add bpf_jit_supports_arena_args(), make it return false f=
rom a
__weak function in kernel/bpf/core.c, and then override from x86 and arm64 =
JIT.

Then return an error when arena kfunc args (nullable or not) are used when =
this
predicate is false in check_kfunc_call() logic.

Since we're using the JIT for emitting this, we should not need special bli=
nding
related handling.

For tests, I think we cover a lot already, but I'd confirmation on whether
nullable/non-nullable cases work correctly, in particular, low32 bits as ze=
ro
should produce kern_vm_start with __arena, and 0 with __arena_nullable, etc=
.
We can probably throw in tests that test JIT emitted sequence as well, ther=
e are
several examples that do this in the selftests.  Since we'll be limited to =
x86
and arm64 we can guard the tests to only work on these two arches.

Finally, it would make sense to add documentation for both tags, and we sho=
uld
be done.

--

Next, for the struct_ops side, the main idea would be to do translation bef=
ore
we save args into the context for the program instead of reloading it from
context, translating, and then having to store back. Just like program->ker=
nel,
we will need some per-JIT handling of kernel->program translation.

Thus, we can avoid injecting a BPF entry prologue or performing a second
load/modify/store pass over the saved context. Fold arena conversion into t=
he
architecture trampoline=E2=80=99s existing save_args() path while it copies=
 native
arguments into the BPF u64 ctx[].

Pseudocode:
/* __arena */
ctx_value =3D (u32)(kaddr - kern_vm_start);
/* __arena_nullable */
ctx_value =3D kaddr ? (u32)(kaddr - kern_vm_start) : 0;

For nullable arguments, test the complete 64-bit native pointer before
subtracting or truncating. Only an actual kernel NULL should take the NULL =
path.
Derive arena argument information from prog->aux->ctx_arg_info, keyed by
info->offset, which is the offset in the flattened trampoline context. Do n=
ot
use the logical argument number because preceding 16-byte arguments occupy =
two
u64 slots. This lookup happens while generating the trampoline; no runtime =
loop
or metadata lookup should be emitted.

Only enable this for the single-node struct_ops indirect trampoline. Obtain=
 the
program from the struct_ops fentry node and pass optional arena metadata in=
to
the initial save_args(..., for_call_origin=3Dfalse) invocation. Generic
trampolines may contain multiple programs with different arenas and must no=
t use
this conversion. We can probably make those return -ENOTSUPP if ther eis a =
p

On x86, translate through RAX and store the translated value directly into =
the ctx slot:
# __arena, native argument in RDI
movl    %edi, %eax
subl    $kern_vm_start_lo, %eax
movq    %rax, ctx_slot

# __arena_nullable
movq    %rdi, %rax
testq   %rax, %rax
jz      1f
subl    $kern_vm_start_lo, %eax
1:
movq    %rax, ctx_slot

Use the same operation after loading a stack-passed argument into RAX. A 32=
-bit
subtraction is sufficient and also clears the upper 32 bits:

(u32)(kaddr - base) =3D=3D (u32)kaddr - (u32)base;

On arm64, materialize only lower_32_bits(kern_vm_start) in a temporary such=
 as W11. For register arguments:
// __arena
sub     w10, w0, w11
str     x10, [sp, #ctx_slot]

// __arena_nullable
mov     x10, x0
cbz     x10, 1f
sub     w10, w10, w11
1:
str     x10, [sp, #ctx_slot]

For stack-passed arguments, first load the full pointer into X10, perform t=
he
same optional CBZ and 32-bit subtraction, and then store X10 into the ctx s=
lot.
Writing W10 automatically clears X10=E2=80=99s upper bits, so no separate U=
XTW is
needed.

Non-arena arguments should retain the existing direct save path. Since this=
 is
native trampoline code generation, kern_vm_start is not inserted into the B=
PF
instruction stream and requires no constant-blinding special case.

--

Once you respin arm64 experts can help validate arm64 bits, I am no expert
there.
