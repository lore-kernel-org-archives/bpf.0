Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE792C029D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519796; cv=none; b=AA4LrXA4Eo882xfVSPp6SjDMj7K87AD2TvC2nk21CkyscJJxzvVkLPyzMsYuLjP7lmKZm60OBb/ci1UCAEEtIbtGP27moiE/TPIgx3gafJs/igfRoF5XSkf5h5C7gOT3yF8/x2NiPigb+aWBFxYYFBqQBXIdd8Zo7WuAj7AMEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519796; c=relaxed/simple;
	bh=8yUuzkaN7FLb/doP4dKXBKlpTbxFX260d18X1QLBBL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upgom8Zy5E9GYWYi3ynvVP8ha6SeRPA7z8WVbOKIm2PDVsvCN+o0AnZbv0nTVRTKflLucWeCKVZoQadFoZMIzREylhBdaQgJQw6+XmwsoiOHmc9rSHDMuPrcVLh2CVzxcwa7xKpiG46O36tTdxiePPZcq17PaxWQPuOITaeOXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g5fmj3W0LzYQtp8
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:29:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 29F8B4058D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:29:51 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAXdS2WzPJpRX0vAg--.53135S3;
	Thu, 30 Apr 2026 11:29:50 +0800 (CST)
Message-ID: <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
Date: Thu, 30 Apr 2026 11:29:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
Content-Language: en-US
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Quentin Monnet <qmo@kernel.org>
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-3-tangyazhou@zju.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260429171904.107244-3-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXdS2WzPJpRX0vAg--.53135S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWxWF17ArWrJF4Dtw4fKrg_yoWDJF43pa
	90gFy2kr4DJF4Fv3srCr4UCr45Grs5A347Cas5ArySvr47tF9xWF18KF4SqF93Cr929w1F
	yr4q9F97uw1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GF
	v_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTmDUUU
	U
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/30/2026 1:19 AM, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> Currently, the BPF instruction set allows bpf-to-bpf calls (or internal
> calls, pseudo calls) to use a 32-bit imm field to represent the relative
> jump offset.
> 
> However, when JIT is disabled or falls back to the interpreter, the
> verifier invokes bpf_patch_call_args() to rewrite the call instruction.
> In this function, the 32-bit imm is downcast to s16 and stored in the off
> field.
> 
>      void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>      {
>          stack_depth = max_t(u32, stack_depth, 1);
>          insn->off = (s16) insn->imm;
>          insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
>              __bpf_call_base_args;
>          insn->code = BPF_JMP | BPF_CALL_ARGS;
>      }
> 
> If the original imm exceeds the s16 range (i.e., jump offset > 32KB),
> this downcast silently truncates the offset, resulting in an incorrect
> call target.
> 
> Fix this by:
> 1. In bpf_patch_call_args(), keeping the imm field unchanged and using the
>     off field to store the index of the interpreter function.
> 2. In ___bpf_prog_run() for the JMP_CALL_ARGS case, retrieving the
>     interpreter function pointer from the interpreters_args array using the
>     off field as the index, and passing the original imm to calculate the
>     last argument of the interpreter function.
> 
> After these changes, the truncation issue is resolved, and __bpf_call_base_args
> is also no longer needed and can be removed, which makes the code cleaner.
> 
> Performance: In ___bpf_prog_run() for the JMP_CALL_ARGS case, changing the
> retrieval of the interpreter function pointer from pointer addition to
> direct array indexing improves performance. The possible reason is that the
> latter has better instruction-level parallelism. See the v5 discussion [1]
> for more details.
> 
> [1] https://lore.kernel.org/bpf/f120c3c4-6999-414a-b514-518bb64b4758@zju.edu.cn/
> 
> The related dumper code is also updated to adapt to the verifier changes.
> Specifically, the usages of insn->imm and insn->off are swapped:
> 1. When JIT is enabled, use insn->imm as the call offset, and insn->off
>     as the subprog id.
> 2. When JIT is disabled, print insn->imm as the call offset.
> 3. The cfg_partition_funcs() function in bpftool is also updated to use
>     insn->imm to calculate the call target, preventing error during
>     "bpftool prog dump xlated visual".
> 
> Consequently, the workaround introduced in tools/testing/selftests/bpf/disasm_helpers.c
> by commit 203e6aba7692 ("selftests/bpf: print correct offset for pseudo calls in disasm_insn()")
> is no longer needed. Since the verifier now correctly exposes the offset
> in the imm field, we can safely remove the custom print_call_cb() and
> allow the selftests to rely on the native BPF disassembler.
> 
> Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
> Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>   include/linux/filter.h                       |  3 ---
>   kernel/bpf/core.c                            | 11 ++++++-----
>   kernel/bpf/fixups.c                          |  6 +++---
>   tools/bpf/bpftool/cfg.c                      |  2 +-
>   tools/bpf/bpftool/xlated_dumper.c            | 10 +++++-----
>   tools/testing/selftests/bpf/disasm_helpers.c | 18 ------------------
>   6 files changed, 15 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index b77d0b06db6e..c4d25d78291b 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1152,9 +1152,6 @@ bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
>   void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
>   
>   u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> -#define __bpf_call_base_args \
> -	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
> -	 (void *)__bpf_call_base)
>   
>   struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog);
>   void bpf_jit_compile(struct bpf_prog *prog);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fcc881909969..8f7db5f0c7e5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1771,6 +1771,9 @@ static u32 abs_s32(s32 x)
>   	return x >= 0 ? (u32)x : -(u32)x;
>   }
>   
> +static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5,
> +				  const struct bpf_insn *insn);
> +
>   /**
>    *	___bpf_prog_run - run eBPF program on a given context
>    *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -2077,10 +2080,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   		CONT;
>   
>   	JMP_CALL_ARGS:
> -		BPF_R0 = (__bpf_call_base_args + insn->imm)(BPF_R1, BPF_R2,
> +		BPF_R0 = (interpreters_args[insn->off])(BPF_R1, BPF_R2,
>   							    BPF_R3, BPF_R4,
>   							    BPF_R5,
> -							    insn + insn->off + 1);
> +							    insn + insn->imm + 1);
>   		CONT;
>   
>   	JMP_TAIL_CALL: {
> @@ -2400,9 +2403,7 @@ int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   	/* Prevent out-of-bounds read to interpreters_args */
>   	if (stack_depth > MAX_BPF_STACK)
>   		return -EINVAL;
> -	insn->off = (s16) insn->imm;
> -	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
> -		__bpf_call_base_args;
> +	insn->off = (round_up(stack_depth, 32) / 32) - 1;
>   	insn->code = BPF_JMP | BPF_CALL_ARGS;
>   	return 0;
>   }
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 300e4e251931..8947ef74f6a8 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   		}
>   		if (!bpf_pseudo_call(insn))
>   			continue;
> -		insn->off = env->insn_aux_data[i].call_imm;
> -		subprog = bpf_find_subprog(env, i + insn->off + 1);
> -		insn->imm = subprog;
> +		insn->imm = env->insn_aux_data[i].call_imm;
> +		subprog = bpf_find_subprog(env, i + insn->imm + 1);
> +		insn->off = subprog;
>   	}
>   
>   	prog->jited = 1;
> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
> index e3785f9a697d..df43a0e0023f 100644
> --- a/tools/bpf/bpftool/cfg.c
> +++ b/tools/bpf/bpftool/cfg.c
> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg, struct bpf_insn *cur,
>   			continue;
>   		if (cur->src_reg != BPF_PSEUDO_CALL)
>   			continue;
> -		func = cfg_append_func(cfg, cur + cur->off + 1);
> +		func = cfg_append_func(cfg, cur + cur->imm + 1);

Do we need to matain backward compatibility with the old bpftool here?
I suspect not, but I'm not entirely sure.

>   		if (!func)
>   			return true;
>   	}
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 5e7cb8b36fef..6ccda6787245 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -150,13 +150,13 @@ static const char *print_call_pcrel(struct dump_data *dd,
>   	if (!dd->nr_jited_ksyms)
>   		/* Do not show address for interpreted programs */
>   		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> -			"%+d", insn->off);
> +			"%+d", insn->imm);
>   	else if (sym)
>   		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> -			 "%+d#%s", insn->off, sym->name);
> +			 "%+d#%s", insn->imm, sym->name);
>   	else
>   		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> -			 "%+d#0x%lx", insn->off, address);
> +			 "%+d#0x%lx", insn->imm, address);
>   	return dd->scratch_buff;
>   }
>   
> @@ -181,8 +181,8 @@ static const char *print_call(void *private_data,
>   	struct kernel_sym *sym;
>   
>   	if (insn->src_reg == BPF_PSEUDO_CALL &&
> -	    (__u32) insn->imm < dd->nr_jited_ksyms && dd->jited_ksyms)
> -		address = dd->jited_ksyms[insn->imm];
> +	    (__u32) insn->off < dd->nr_jited_ksyms && dd->jited_ksyms)
> +		address = dd->jited_ksyms[insn->off];
>   
>   	sym = kernel_syms_search(dd, address);
>   	if (insn->src_reg == BPF_PSEUDO_CALL)
> diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
> index f529f1c8c171..96b1f2ffe438 100644
> --- a/tools/testing/selftests/bpf/disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/disasm_helpers.c
> @@ -4,7 +4,6 @@
>   #include "disasm.h"
>   
>   struct print_insn_context {
> -	char scratch[16];
>   	char *buf;
>   	size_t sz;
>   };
> @@ -19,22 +18,6 @@ static void print_insn_cb(void *private_data, const char *fmt, ...)
>   	va_end(args);
>   }
>   
> -static const char *print_call_cb(void *private_data, const struct bpf_insn *insn)
> -{
> -	struct print_insn_context *ctx = private_data;
> -
> -	/* For pseudo calls verifier.c:jit_subprogs() hides original
> -	 * imm to insn->off and changes insn->imm to be an index of
> -	 * the subprog instead.
> -	 */
> -	if (insn->src_reg == BPF_PSEUDO_CALL) {
> -		snprintf(ctx->scratch, sizeof(ctx->scratch), "%+d", insn->off);
> -		return ctx->scratch;
> -	}
> -
> -	return NULL;
> -}
> -
>   struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
>   {
>   	struct print_insn_context ctx = {
> @@ -43,7 +26,6 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
>   	};
>   	struct bpf_insn_cbs cbs = {
>   		.cb_print	= print_insn_cb,
> -		.cb_call	= print_call_cb,
>   		.private_data	= &ctx,
>   	};
>   	char *tmp, *pfx_end, *sfx_start;

Aside from the potential bpftool compatibility issue, it looks good to me.

Acked-by: Xu Kuohai <xukuohai@huawei.com>

