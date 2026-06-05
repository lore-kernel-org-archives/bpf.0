Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252363DF002
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671270; cv=none; b=stPRTVVqVuC0P/VG5LStcU7pEf6p7um3XafJ2HeXZ8LybYCoiAFK5xYT28ez/hzmuSVfuBQMv7zSTpDXH/dOy7VLq5CYvRPme9LNaftKg5jGVO+GfLm8oSyl9ShSzGBqqtnbqGZHy0yoeYm7lZ32GKEkZx+pJO/9r/zgHcFI/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671270; c=relaxed/simple;
	bh=i4E+VdlXcJIZoKH/3s2EkdAngxymKZfj6XnKsAc/jfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7lt7uv448/vkqP44CmDNXi4UoC0l3QUwxPSpqlrwPRYljbAS1qtKa4XldZxfqqaYb6PX0kgcivOGBpNc32sP0q/6ChTe3IDbjRLmF2Cpo7Z5vDSAQfjYuiE+q4khk2wYVYvz1EmZteaV8YDAiRW4mSZ0wvfcHO2w0694U30ZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BxFUAK/A; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BxFUAK/A"
Message-ID: <78009c06-4233-4e0a-88ec-33eba10ad8b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780671264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T10tbTpcV2pUBQyWyrHxm7GXYtp6nDFJhaWs/Lxnh8=;
	b=BxFUAK/AN0wgD8eGGuFvdxWnrnCkHUxSLZUNCUu//z2V+cA/zvbouPYpYAlPSkzosrFZU4
	J/W40RsQpiE5xjC0yjYu9DCCYN3v6ILmOEpt/EJFIv4gFx4ius1bqklwFG5NlxcYMFStI9
	OVRzcmh7CdTWQmTPodFF0Il4jS6egCY=
Date: Fri, 5 Jun 2026 07:54:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/8] bpf, x86: emit KASAN checks into x86
 JITed programs
Content-Language: en-GB
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
 <20260604-kasan-v2-5-c066e627fda8@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260604-kasan-v2-5-c066e627fda8@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/4/26 1:22 PM, Alexis Lothoré (eBPF Foundation) wrote:
> Insert KASAN shadow memory checks before memory load and store
> operations in JIT-compiled BPF programs. This helps detect memory safety
> bugs such as use-after-free and out-of-bounds accesses at runtime.
>
> The main instructions being targeted are BPF_ST, BPF_STX and BPF_LDX,
> but not all of them are being instrumented:
> - if the load/store instruction is in fact accessing the program stack,
>    emit_kasan_check silently skips the instrumentation, as we already
>    have page guards to monitor stack accesses.
> - if the load/store instruction is a BPF_PROBE_MEM or a BPF_PROBE_ATOMIC
>    instruction, we do not instrument it, as the passed address can fault
>    (hence the custom fault management with BPF_PROBE_XXX instructions),
>    and so the corresponding kasan check could fault as well.
>
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - support BPF_ATOMICS
> - support BPF_ST
> - make sure to systematically pass correct instruction to kasan check
> ---
>   arch/x86/net/bpf_jit_comp.c | 63 ++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 53 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 943a0f315cf2..cb3c03edc4bd 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1516,17 +1516,30 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
>   	return 0;
>   }
>   
> -static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
> -			     u32 src_reg, s16 off, u8 bpf_size)
> +static int emit_atomic_ld_st(u8 **pprog, struct bpf_insn *insn, u8 *ip,
> +			     u32 dst_reg, u32 src_reg, bool accesses_stack_only)
>   {
> +	u32 atomic_op = insn->imm;
> +	int err;
> +
>   	switch (atomic_op) {
>   	case BPF_LOAD_ACQ:
> +		err = emit_kasan_check(pprog, src_reg, insn, ip, false,
> +				       accesses_stack_only);
> +		if (err)
> +			return err;
>   		/* dst_reg = smp_load_acquire(src_reg + off16) */
> -		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
> +		emit_ldx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
> +			 insn->off);
>   		break;
>   	case BPF_STORE_REL:
> +		err = emit_kasan_check(pprog, dst_reg, insn, ip, true,
> +				       accesses_stack_only);
> +		if (err)
> +			return err;
>   		/* smp_store_release(dst_reg + off16, src_reg) */
> -		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
> +		emit_stx(pprog, BPF_SIZE(insn->code), dst_reg, src_reg,
> +			 insn->off);
>   		break;
>   	default:
>   		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
> @@ -1904,6 +1917,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   		const s32 imm32 = insn->imm;
>   		u32 dst_reg = insn->dst_reg;
>   		u32 src_reg = insn->src_reg;
> +		bool accesses_stack_only;
>   		u8 b2 = 0, b3 = 0;
>   		u8 *start_of_ldx;
>   		s64 jmp_offset;
> @@ -1924,6 +1938,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   			EMIT_ENDBR();
>   
>   		ip = image + addrs[i - 1] + (prog - temp);
> +		accesses_stack_only =
> +			bpf_insn_accesses_stack_only(env, bpf_prog, i - 1);
>   
>   		switch (insn->code) {
>   			/* ALU */
> @@ -2304,6 +2320,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   		case BPF_ST | BPF_MEM | BPF_H:
>   		case BPF_ST | BPF_MEM | BPF_W:
>   		case BPF_ST | BPF_MEM | BPF_DW:
> +			err = emit_kasan_check(&prog, dst_reg, insn, ip, true,
> +					       accesses_stack_only);
> +			if (err)
> +				return err;
>   			switch (BPF_SIZE(insn->code)) {
>   			case BPF_B:
>   				if (is_ereg(dst_reg))
> @@ -2369,6 +2389,10 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
>   				dst_reg = BPF_REG_FP;
>   			}
> +			err = emit_kasan_check(&prog, dst_reg, insn, ip, true,
> +					       accesses_stack_only);
> +			if (err)
> +				return err;
>   			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>   			break;
>   
> @@ -2530,6 +2554,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   				/* populate jmp_offset for JAE above to jump to start_of_ldx */
>   				start_of_ldx = prog;
>   				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
> +			} else {
> +				err = emit_kasan_check(&prog, src_reg, insn, ip,
> +						       false,
> +						       accesses_stack_only);
> +				if (err)
> +					return err;
>   			}
>   			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
>   			    BPF_MODE(insn->code) == BPF_MEMSX)
> @@ -2592,13 +2622,13 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   			fallthrough;
>   		case BPF_STX | BPF_ATOMIC | BPF_W:
>   		case BPF_STX | BPF_ATOMIC | BPF_DW:
> +			bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> +			u32 real_src_reg = src_reg;
> +			u32 real_dst_reg = dst_reg;

With llvm23, I got the following build failure:

     /home/yhs/work/bpf-next/arch/x86/net/bpf_jit_comp.c:2625:4: error:
             label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
      2625 |                         bool is64 = BPF_SIZE(insn->code) == BPF_DW;
           |                         ^
     1 error generated.

The below is a fix:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cb3c03edc4bd..61faf8d8f157 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2621,7 +2621,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
                         }
                         fallthrough;
                 case BPF_STX | BPF_ATOMIC | BPF_W:
-               case BPF_STX | BPF_ATOMIC | BPF_DW:
+               case BPF_STX | BPF_ATOMIC | BPF_DW: {
                         bool is64 = BPF_SIZE(insn->code) == BPF_DW;
                         u32 real_src_reg = src_reg;
                         u32 real_dst_reg = dst_reg;
@@ -2695,6 +2695,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
                         if (err)
                                 return err;
                         break;
+               }
  
                 case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
                 case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:

> +			u8 *branch_target;
>   			if (insn->imm == (BPF_AND | BPF_FETCH) ||
>   			    insn->imm == (BPF_OR | BPF_FETCH) ||
>   			    insn->imm == (BPF_XOR | BPF_FETCH)) {
> -				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> -				u32 real_src_reg = src_reg;
> -				u32 real_dst_reg = dst_reg;
> -				u8 *branch_target;
>   
>   				/*
>   				 * Can't be implemented with a single x86 insn.
> @@ -2612,7 +2642,19 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   				if (dst_reg == BPF_REG_0)
>   					real_dst_reg = BPF_REG_AX;
>   
> +				ip += 3;
> +			}
> +			if (!bpf_atomic_is_load_store(insn)) {
> +				err = emit_kasan_check(&prog, real_dst_reg,
> +						       insn, ip, false,
> +						       accesses_stack_only);
> +				if (err)
> +					return err;
>   				branch_target = prog;
> +			}
> +			if (insn->imm == (BPF_AND | BPF_FETCH) ||
> +			    insn->imm == (BPF_OR | BPF_FETCH) ||
> +			    insn->imm == (BPF_XOR | BPF_FETCH)) {
>   				/* Load old value */
>   				emit_ldx(&prog, BPF_SIZE(insn->code),
>   					 BPF_REG_0, real_dst_reg, insn->off);
> @@ -2644,8 +2686,9 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>   			}
>   
>   			if (bpf_atomic_is_load_store(insn))
> -				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
> -							insn->off, BPF_SIZE(insn->code));
> +				err = emit_atomic_ld_st(&prog, insn, ip,
> +							dst_reg, src_reg,
> +							accesses_stack_only);
>   			else
>   				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
>   						      insn->off, BPF_SIZE(insn->code));
>

