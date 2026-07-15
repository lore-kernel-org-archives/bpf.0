Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC523D4119
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154534; cv=none; b=O+/A6TlBTX1p//sen9xNrGFYnAsgT+gvz4lHuZM56WxA8yfGYbMEXJvkCZTwoZENuUuohbbKkRY7BaSk+ywCjy2Pu1uaDXbRCUKYotYfzKP57OzYFdqan7RE8s6GUHJ7pIOSrl0J1L0Tut5dBJ3ruMPUxGjiJFKBmB7dXJfSWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154534; c=relaxed/simple;
	bh=SfQaAssZoqZDdymBmzrlzv2/C/Nnk5ElpvhUuxiH67Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWQEXKWmMv9zsTPQheUS30KCtun8u1W3pCCdQhhkJ1tlA15D1vjmXijxfSB5HEJN8lfY+hvALKuZPUpFZf8wuirsjgX2edQKsKGE/tgcppiEMxw/5cw9sbBAk86wIfilZ9OwQvnLsmUiKfcLdUwh8MWDt1IlX3uu2AnYH3tMH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fNt493B1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fNt493B1"
Message-ID: <293c6a91-d7d7-4870-8f41-b20f6737d7af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784154529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8x5Lf6lYBneeeSQwKT2h3L1us58Uy7btMQGV909J6wI=;
	b=fNt493B1FLsAgmAgrPmUt+fHFSpcAjq1W7Hlkhj2qik5Qrrmf7SnQxr0F1rit6dnkzyc+U
	BeSNZ0qeNh7jjFksKLPzqvnn3Sj9zBu7b6i9Bceokyv3GWuo2a+1XI2l4rlIquEabrVP+q
	AK+Mku+4VdbCXTck+5ZRjS9YsyXpYgQ=
Date: Wed, 15 Jul 2026 15:28:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 06/10] bpf, x86: emit KASAN checks into x86
 JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-6-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-6-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Insert KASAN shadow memory checks before memory load and store
> operations in JIT-compiled BPF programs. This helps detect memory safety
> bugs such as use-after-free and out-of-bounds accesses at runtime.
> 
> The main instructions being targeted are BPF_ST, BPF_STX and BPF_LDX,
> but not all of them are being instrumented:
> - if the load/store instruction is in fact accessing the program stack,
>   emit_kasan_check silently skips the instrumentation, as we can already
>   benefit from guard pages to monitor stack accesses.
> - if the load/store instruction is a BPF_PROBE_MEM or a BPF_PROBE_ATOMIC
>   instruction, we do not instrument it, as the passed address can fault
>   (hence the custom fault management with BPF_PROBE_XXX instructions),
>   and so the corresponding kasan check could fault as well.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v5:
> - change access type (read -> write) for atomic RMW check
> 
> Changes in v4:
> - refactor BPF_FETCH handling
> 
> Changes in v3:
> - fix LLVM23 build failure
> 
> Changes in v2:
> - support BPF_ATOMICS
> - support BPF_ST
> - make sure to systematically pass correct instruction to kasan check
> ---
>  arch/x86/net/bpf_jit_comp.c | 79 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 63 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 959fcaa0cde9..9dbe3a52444e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1576,17 +1576,31 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
>  	return 0;
>  }
>  
> -static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
> -			     u32 src_reg, s16 off, u8 bpf_size)
> +static int emit_atomic_ld_st(struct bpf_verifier_env *env, u8 **pprog,
> +			     struct bpf_insn *insn, u8 *ip, u32 dst_reg,
> +			     u32 src_reg, bool accesses_stack_only)
>  {
> +	u32 atomic_op = insn->imm;
> +	int err;
> +
>  	switch (atomic_op) {
>  	case BPF_LOAD_ACQ:
> +		err = emit_kasan_check(env, pprog, src_reg, insn, ip, false,
> +				       accesses_stack_only);
> +		if (err)
> +			return err;
>  		/* dst_reg = smp_load_acquire(src_reg + off16) */
> -		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
> +		emit_ldx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
> +			 insn->off);
>  		break;
>  	case BPF_STORE_REL:
> +		err = emit_kasan_check(env, pprog, dst_reg, insn, ip, true,
> +				       accesses_stack_only);
> +		if (err)
> +			return err;
>  		/* smp_store_release(dst_reg + off16, src_reg) */
> -		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
> +		emit_stx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
> +			 insn->off);
>  		break;
>  	default:
>  		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
> @@ -1964,10 +1978,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		const s32 imm32 = insn->imm;
>  		u32 dst_reg = insn->dst_reg;
>  		u32 src_reg = insn->src_reg;
> +		bool accesses_stack_only;
>  		u8 b2 = 0, b3 = 0;
>  		u8 *start_of_ldx;
>  		s64 jmp_offset;
>  		s32 insn_off;
> +		int insn_idx;
>  		u8 jmp_cond;
>  		u8 *func;
>  		int nops;
> @@ -1984,6 +2000,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			EMIT_ENDBR();
>  
>  		ip = image + addrs[i - 1] + (prog - temp);
> +		insn_idx = i - 1 + bpf_prog->aux->subprog_start;
> +		accesses_stack_only =
> +			env ? !env->insn_aux_data[insn_idx].non_stack_access :
> +			      false;

I don't like how accesses_stack_only is a boolean argument to
emit_kasan_check(), that is only used for early return.
I can see not wanting to do

    if (!accesses_stack_only)
        err = emit_kasan_check(...);

on every call site, but a bool arg is even worse IMO.


>  
>  		switch (insn->code) {
>  			/* ALU */
> @@ -2364,6 +2384,11 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		case BPF_ST | BPF_MEM | BPF_H:
>  		case BPF_ST | BPF_MEM | BPF_W:
>  		case BPF_ST | BPF_MEM | BPF_DW:
> +			err = emit_kasan_check(env, &prog, dst_reg, insn, ip,
> +					       true, accesses_stack_only);
> +			if (err)
> +				return err;
> +
>  			emit_st(&prog, insn, dst_reg, outgoing_arg_base,
>  				outgoing_rsp);
>  			break;
> @@ -2383,6 +2408,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
>  				dst_reg = BPF_REG_FP;
>  			}
> +			err = emit_kasan_check(env, &prog, dst_reg, insn, ip,
> +					       true, accesses_stack_only);
> +			if (err)
> +				return err;
>  			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>  			break;
>  
> @@ -2544,6 +2573,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				/* populate jmp_offset for JAE above to jump to start_of_ldx */
>  				start_of_ldx = prog;
>  				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
> +			} else {
> +				err = emit_kasan_check(env, &prog, src_reg,
> +						       insn, ip, false,
> +						       accesses_stack_only);
> +				if (err)
> +					return err;
>  			}
>  			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
>  			    BPF_MODE(insn->code) == BPF_MEMSX)
> @@ -2605,15 +2640,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			}
>  			fallthrough;
>  		case BPF_STX | BPF_ATOMIC | BPF_W:
> -		case BPF_STX | BPF_ATOMIC | BPF_DW:
> -			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> -			    insn->imm == (BPF_OR | BPF_FETCH) ||
> -			    insn->imm == (BPF_XOR | BPF_FETCH)) {
> -				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> -				u32 real_src_reg = src_reg;
> -				u32 real_dst_reg = dst_reg;
> -				u8 *branch_target;
> -
> +		case BPF_STX | BPF_ATOMIC | BPF_DW: {
> +			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +			u32 real_src_reg = src_reg;
> +			u32 real_dst_reg = dst_reg;
> +			u8 *branch_target;
> +			bool is_atomic_fetch =
> +				(insn->imm == (BPF_AND | BPF_FETCH) ||
> +				 insn->imm == (BPF_OR | BPF_FETCH) ||
> +				 insn->imm == (BPF_XOR | BPF_FETCH));
> +			if (is_atomic_fetch) {
>  				/*
>  				 * Can't be implemented with a single x86 insn.
>  				 * Need to do a CMPXCHG loop.
> @@ -2626,7 +2662,17 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  				if (dst_reg == BPF_REG_0)
>  					real_dst_reg = BPF_REG_AX;
>  
> +				ip += 3;

nit

IIUC the 3 comes from emit_mov_reg() above it (:2659), right?  I was
thinking to suggest a comment, but well I figured it out from the
code, so others should too...

Maybe instead of hardcoding 3 we could calculcate the diff
before/after the mov is emitted?


> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				err = emit_kasan_check(env, &prog, real_dst_reg,
> +						       insn, ip, true,
> +						       accesses_stack_only);
> +				if (err)
> +					return err;
>  				branch_target = prog;
> +			}
> +			if (is_atomic_fetch) {
>  				/* Load old value */
>  				emit_ldx(&prog, BPF_SIZE(insn->code),
>  					 BPF_REG_0, real_dst_reg, insn->off);
> @@ -2658,15 +2704,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  			}
>  
>  			if (bpf_atomic_is_load_store(insn))
> -				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
> -							insn->off, BPF_SIZE(insn->code));
> +				err = emit_atomic_ld_st(env, &prog, insn, ip,
> +							dst_reg, src_reg,
> +							accesses_stack_only);
>  			else
>  				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
>  						      insn->off, BPF_SIZE(insn->code));
>  			if (err)
>  				return err;
>  			break;
> -
> +		}
>  		case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
>  		case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
>  			if (!bpf_atomic_is_load_store(insn)) {
> 

