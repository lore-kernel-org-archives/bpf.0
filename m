Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204E23EA83;
	Fri, 12 Jun 2026 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267883; cv=none; b=KCKrAPceFSIDRYvbJS06se9W4w01uwdBGFvxGBCU33lIpUCEGk2J+Z/74xt+HToomGCF+7caUk8IXyhrUC2BkQFDjYV2bzTnihmtQ2fP9SJBK4rY+bCthnld5hkOPZkEquFhSblbc1nZR8p/vq9WYOVG1s6JqALUVXBI0HV0vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267883; c=relaxed/simple;
	bh=mRjsxTK/0C9WX6/C/aL+iF6znFLgdk/KXtkySFn1/vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/7ScQK8ra/kJny7VymgJNlZn2yNxK2gJyfIYEoub2671pM3k/G7AE5ml0kOWpG+v6ldLoFkHMUTFaBhhIlCBoH0JcCg3emFGugmFlZ0Vm90ZVe2UYS7HeHwfglYIPUsssM9leXU2Lsbe8WVekqe+nzKVpelzh8QhmF8qSMKz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gcJtW13DgzKHMVP;
	Fri, 12 Jun 2026 20:37:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7656D4056B;
	Fri, 12 Jun 2026 20:37:47 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgC3Xwua_StqjRMZBg--.59258S2;
	Fri, 12 Jun 2026 20:37:47 +0800 (CST)
Message-ID: <093f957d-3d3a-4ce7-b59b-06203c556629@huaweicloud.com>
Date: Fri, 12 Jun 2026 20:37:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT
 fallback path
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260611101216.30153-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3Xwua_StqjRMZBg--.59258S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfGw4DtrWrCw1kCw1xKrg_yoWrCFy8pF
	ykGw1akr4DXFW29a4xJa12vw1Ygw48Ga45Ga4fK3WFkFs0qrn7WF1UKw10gFsxGr48CF1I
	vw42yF129w1kJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 6/11/2026 6:12 PM, Tiezhu Yang wrote:
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
> This issue impacts all architectures that support helper inlining.
> Introduce a late fixup pass via bpf_fixup_fallback_inline_helpers()
> in __bpf_prog_select_runtime() to fix it.
> 
> When JIT compilation fails or is disabled, the helper call offsets
> originally skipped for inlining are rewritten to relative memory
> offsets right before transferring control to the interpreter.
> 
> A bounds check on insn->imm against __BPF_FUNC_MAX_ID is added to
> ensure already-patched address offsets of regular non-inlined helpers
> are safely filtered out during traversal.
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
> ---
>   kernel/bpf/core.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..5785c8cb4dbe 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2608,6 +2608,31 @@ static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *env, struc
>   	return prog;
>   }
>   
> +/* Fix up helper call offsets for inlined helpers on JIT fallback path. */
> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)

The function name is a bit long for a static function

> +{
> +	struct bpf_insn *insn = fp->insnsi;
> +	const struct bpf_func_proto *fn;
> +	int i;
> +
> +	if (!env || !env->ops->get_func_proto)
> +		return;
> +
> +	for (i = 0; i < fp->len; i++, insn++) {
> +		if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0) {
> +			/* Filter out already-patched address offsets. */
> +			if (insn->imm >= __BPF_FUNC_MAX_ID)

The check is redundant, since bpf_jit_inlines_helper_call() already
filters out insn->imm numbers that is not a valid helper id.

> +				continue;
> +
> +			if (bpf_jit_inlines_helper_call(insn->imm)) {
> +				fn = env->ops->get_func_proto(insn->imm, env->prog);
> +				if (fn && fn->func)
> +					insn->imm = fn->func - __bpf_call_base;
> +			}
> +		}
> +	}
> +}
> +
>   struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct bpf_prog *fp,
>   					   int *err)
>   {
> @@ -2643,6 +2668,9 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>   			*err = -ENOTSUPP;
>   			return fp;
>   		}
> +
> +		if (!fp->jited)
> +			bpf_fixup_fallback_inline_helpers(env, fp);
>   	} else {
>   		*err = bpf_prog_offload_compile(fp);
>   		if (*err)

I tested it on arm64 and the patch works.

Tested-by: Xu Kuohai <xukuohai@huawei.com>

