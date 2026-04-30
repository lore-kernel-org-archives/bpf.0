Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E4374756
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519780; cv=none; b=MdP/+sHjKwdBTjvEgN3vacmYOicyfzmY1kcBZ+66kXzi6xseey3TEIeJfeUIGCxpNc7oySgRKYfWpE5xJ+E1tdYieKTS7dZk/nk7YHeJXN+2hZHaeahi+fw1hjJGVXBVjaUmWkS1bAIKsNBl7NC1pzGE1Xw7z3cqT+7wokKObBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519780; c=relaxed/simple;
	bh=kC83K0xCxetNHyeXgE+d5WpbEbt/gzVyZI7Af/5vc6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpxztzoRCFTrVe82yYdw7Wdv1A3O+zeU+i9zolYeczP7olu48jVpW8mxwWsE6NAdvYOCSD7y1/W375CPzd3fBIdMnCpr4Ebns2Yat9yN+bjrFuq+m39RvTja+SZQItyhLQptAHnfaB5xVbqxG2edesJeUtU9qY1E8dPSUGWiU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g5fmG0MtQzYQtqf
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:29:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B157E4056D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 11:29:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgAXdS2WzPJpRX0vAg--.53135S2;
	Thu, 30 Apr 2026 11:29:27 +0800 (CST)
Message-ID: <2f4565e1-eb06-4f63-886b-8c74f10d4c8a@huaweicloud.com>
Date: Thu, 30 Apr 2026 11:29:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/3] bpf: Fix out-of-bounds read in
 bpf_patch_call_args()
Content-Language: en-US
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-2-tangyazhou@zju.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260429171904.107244-2-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXdS2WzPJpRX0vAg--.53135S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xXF4fGFWrur4UuFy3Jwb_yoW5tr18pF
	1DK3WjkF48tw4Ika43GF47ur15Jrs5ZFW7KayrJ340krsFqFs7Grn0g3ZrZFyfWrn2kw48
	JF1I9r9ak3yxW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/30/2026 1:19 AM, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> The interpreters_args array only accommodates stack depths up to
> MAX_BPF_STACK (512 bytes). However, do_misc_fixups() may allow a larger
> stack depth if JIT is requested.
> 
> If JIT compilation later fails and falls back to the interpreter, the
> verifier invokes bpf_patch_call_args() with this oversized stack depth.
> This causes a load-time out-of-bounds (OOB) read when calculating the
> interpreter function pointer index.
> 
> Fix this by changing bpf_patch_call_args() to return an int and explicitly
> rejecting the JIT fallback (returning -EINVAL) if the stack depth exceeds
> MAX_BPF_STACK.
> 
> Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
>   include/linux/bpf.h | 2 +-
>   kernel/bpf/core.c   | 6 +++++-
>   kernel/bpf/fixups.c | 6 +++++-
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 715b6df9c403..eb6b816bc8b5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2922,7 +2922,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t expected_size,
>   int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size);
>   
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
> +int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
>   #endif
>   
>   struct btf *bpf_get_btf_vmlinux(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ae10b9ca018d..fcc881909969 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2394,13 +2394,17 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>   #undef PROG_NAME_LIST
>   
>   #ifdef CONFIG_BPF_SYSCALL
> -void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
> +int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   {
>   	stack_depth = max_t(u32, stack_depth, 1);
> +	/* Prevent out-of-bounds read to interpreters_args */
> +	if (stack_depth > MAX_BPF_STACK)
> +		return -EINVAL;
>   	insn->off = (s16) insn->imm;
>   	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
>   		__bpf_call_base_args;
>   	insn->code = BPF_JMP | BPF_CALL_ARGS;
> +	return 0;
>   }
>   #endif
>   #endif
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fba9e8c00878..300e4e251931 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1416,7 +1416,11 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>   		depth = get_callee_stack_depth(env, insn, i);
>   		if (depth < 0)
>   			return depth;
> -		bpf_patch_call_args(insn, depth);
> +		err = bpf_patch_call_args(insn, depth);
> +		if (err) {
> +			verbose(env, "interpreter stack depth %d is too large\n", depth);

Nit: the log is misleading, change it to "stack depth %d exceeds interpreter
stack depth limit"?

> +			return err;
> +		}
>   	}
>   	err = 0;
>   #endif

Aside from the the log wording, it looks good to me.

Acked-by: Xu Kuohai <xukuohai@huawei.com>

