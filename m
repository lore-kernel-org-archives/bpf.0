Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF93287268;
	Tue, 30 Jun 2026 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782044; cv=none; b=OaNVyuMVN+cKYwl2UKGGCbmA2YxnLczQfxOfvBrgPaDe0IDglrSM7ZtBw0kwc06adaVZTbe0hyv0Nh/PMtSRJ4Ovj/SPyGgt8OagOljlxAj8Ql7VqR555WRpIGkHayAWSuxj1J0YUrI79irZeiokl/PJCUB1uZwnzPmjhsEZhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782044; c=relaxed/simple;
	bh=gYPpa6Sqm4w7uMS5KVTf1sAiXmd6DsTtkDuR6g8v6gI=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qCr8ppGiw3eQCawQSGnik6dGaGysdvjYx8WolufMvpIrTzzCQ4QS7PqoGRAqE9FntMknkGEilIV/OdghqDZkpECcngn2W/ds6M6vpkU+Qpmcl0PoCPcE0f/ggImy62Lp4HBq7pTtBzgTCYusVotsDD2/tAEZh3rF8upYzVfyloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxNehMGENqsHIZAA--.59115S3;
	Tue, 30 Jun 2026 09:13:48 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx28FCGENq6me4AA--.20790S3;
	Tue, 30 Jun 2026 09:13:39 +0800 (CST)
Subject: Re: [PATCH bpf-next v4] bpf: Fix unaligned interpreter panic on JIT
 fallback path
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615025316.24429-1-yangtiezhu@loongson.cn>
Message-ID: <ed0326b4-2953-16a6-0472-5fa96df1d63e@loongson.cn>
Date: Tue, 30 Jun 2026 09:13:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260615025316.24429-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx28FCGENq6me4AA--.20790S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryfGw4xAw1UJr4xCw43CFX_yoWrArW8pF
	WkCw4akr48XF4I9a1xJw42vw15K3yrGFWUGa93Ga4FkF1Yqrn7WF4UKw40gFZxGr409F1S
	vw42vFy29w18JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

On 2026/6/15 上午10:53, Tiezhu Yang wrote:
> When an architecture implements bpf_jit_inlines_helper_call(), such
> as LoongArch, ARM64, and RISC-V, the BPF verifier skips rewriting
> the helper call offset (insn->imm) during the bpf_do_misc_fixups()
> phase if the helper is expected to be inlined by the JIT compiler.
> As a result, insn->imm remains as the raw helper enum ID.
> 
> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0)
> or if the JIT compilation later dynamically fails (e.g., due to OOM
> during bpf_jit_alloc_exec()), the core BPF subsystem falls back to
> the BPF interpreter.
> 
> When the fallback interpreter executes (__bpf_call_base + insn->imm)
> with the unpatched raw helper ID, it jumps into an unaligned invalid
> address space, triggering a fatal instruction alignment fault (ADEF)
> or illegal memory access kernel panic.
> 
> This issue impacts all architectures that support helper inlining,
> so introduce a late fixup pass via bpf_fixup_fallback_helpers() in
> __bpf_prog_select_runtime() to fix this panic.
> 
> When JIT compilation fails or is disabled, the helper call offsets
> originally skipped for inlining are rewritten to relative memory
> offsets right before transferring control to the interpreter.
> 
> 1. Test case (test_panic.c):
> 
>    #include <linux/bpf.h>
>    #include <bpf/bpf_helpers.h>
> 
>    SEC("kprobe/sys_getpid")
>    int test_panic(void *ctx)
>    {
>    	struct task_struct *task;
> 
>    	task = (struct task_struct *)bpf_get_current_task();
>    	if (task)
>    		bpf_printk("Task address: %p\n", task);
> 
>    	return 0;
>    }
> 
>    char LICENSE[] SEC("license") = "GPL";
> 
> 2. Reproduction steps:
> 
>    $ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
>    $ sudo sysctl -w net.core.bpf_jit_enable=0
>    $ sudo bpftool prog load test_panic.o /sys/fs/bpf/test_panic autoattach
>    $ sudo cat /sys/kernel/debug/tracing/trace_pipe
> 
> 3. Panic information on LoongArch:
> 
>    Kernel ade access[#1]:
>    ...
>        ra: 9000000000486e50 ___bpf_prog_run+0x1370/0x36b0
>       ERA: 9000000000485383 __bpf_prog_ret0_warn+0x13/0x20
>    ...
>     ESTAT: 00080000 [ADEF] (IS= ECode=8 EsubCode=0)
> 
> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> Tested-by: Xu Kuohai <xukuohai@huawei.com>
> ---
> v4:
>    - Rename the static function to bpf_fixup_fallback_helpers() to
>      be more accurate and concise, following the file's naming style.
>    - Remove redundant helper ID bounds check since invalid helper
>      IDs are already filtered out in bpf_jit_inlines_helper_call().
>    - Simplify code by merging nested if statements for helper checks.
> 
>   kernel/bpf/core.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..0db6e55bad52 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2608,6 +2608,25 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>   	return prog;
>   }
>   
> +/* Fix up helper call offsets on JIT fallback path. */
> +static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
> +{
> +	struct bpf_insn *insn = fp->insnsi;
> +	const struct bpf_func_proto *fn;
> +	int i;
> +
> +	if (!env || !env->ops->get_func_proto)
> +		return;
> +
> +	for (i = 0; i < fp->len; i++, insn++) {
> +		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) {
> +			fn = env->ops->get_func_proto(insn->imm, env->prog);
> +			if (fn && fn->func)
> +				insn->imm = fn->func - __bpf_call_base;
> +		}
> +	}
> +}
> +
>   struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
>   					   int *err)
>   {
> @@ -2643,6 +2662,9 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>   			*err = -ENOTSUPP;
>   			return fp;
>   		}
> +
> +		if (!fp->jited)
> +			bpf_fixup_fallback_helpers(env, fp);
>   	} else {
>   		*err = bpf_prog_offload_compile(fp);
>   		if (*err)
> 

Ping? Any more comments?

Thanks,
Tiezhu

