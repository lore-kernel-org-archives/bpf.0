Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0F2C028F
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532748; cv=none; b=ZFdAsua/wykbEWwNrae4EKERIRrC+XHxaCklaewqdGqbiEeT5HchgD4XQ2h5i66cF7p8q4p2Uj4yYxp0lw4YUYeMGMy6KApR0VyG4kL4Y9gdYWDsP1Fru4cGwgBujtsMRK519rTzQp69yDuKC4Lrrxbi9KWwcBieeNSBRbCvcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532748; c=relaxed/simple;
	bh=DakBrvoXOimngun+K2mtNzDj8kLPBn5OHNzlkPLBQao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nblExsOdrUH8iSpCqQTrbYNb8Yzgx/D4F5RbftfBCeJKQb8CT0KxaPAuQewnqY/o+bl+2hN7Znc3Uh9CqkITuUMQKQHdReagZV37z1wFVC+XXp9KgSa2/xX/1hMnq7jtF6u+QvPPrL/2e5TTI/hDwfYXn9FS1V13LADX3U3ZsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhQ4t2CBdzKHLtp
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 21:45:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9BB254058D
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 21:45:42 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBHIUyFOMVpZ+dFCQ--.52416S2;
	Thu, 26 Mar 2026 21:45:42 +0800 (CST)
Message-ID: <319906e9-3b47-472f-9a11-a0da60626144@huaweicloud.com>
Date: Thu, 26 Mar 2026 21:45:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 1/3] bpf: Reject bpf-to-bpf call with large offset
 in interpreter
Content-Language: en-US
To: Yazhou Tang <tangyazhou@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-2-tangyazhou@zju.edu.cn>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260326090133.221957-2-tangyazhou@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIUyFOMVpZ+dFCQ--.52416S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw15Xw4fGw4ruF15uryxGrg_yoW8Cr4fpF
	WkKa47Aa1qqw4Ik39rCF4UZw15tws5tay7Ga4rJ34ftr4UXws8Gr1Ygay3Zry3Krn3Cw4I
	vF4j9ryIy342g37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 3/26/2026 5:01 PM, Yazhou Tang wrote:

[...]
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 39ddc7eb49b1..471ce73b760e 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2396,13 +2396,16 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>   #undef PROG_NAME_LIST
>   
>   #ifdef CONFIG_BPF_SYSCALL
> -void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
> +int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>   {
> -	stack_depth = max_t(u32, stack_depth, 1);
> +	if (insn->imm < S16_MIN || insn->imm > S16_MAX)
> +		return -EINVAL;
>   	insn->off = (s16) insn->imm;
> +	stack_depth = max_t(u32, stack_depth, 1);
>   	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
>   		__bpf_call_base_args;

Maybe I’m missing something, but since interpreters_args is a small array, why not
just store the index (round_up(stack_depth, 32) / 32) - 1 in insn->off?

That way, the interpreter could directly use this index to find the function address,
without needing insn->imm to record the address offset, thus avoiding the need to use
another field like insn->off in the instruction to back up the original insn->imm.

>   	insn->code = BPF_JMP | BPF_CALL_ARGS;
> +	return 0;
>   }
>   #endif
>   #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df22bfc572e2..702579f56f7d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23112,7 +23112,11 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>   		depth = get_callee_stack_depth(env, insn, i);
>   		if (depth < 0)
>   			return depth;
> -		bpf_patch_call_args(insn, depth);
> +		err = bpf_patch_call_args(insn, depth);
> +		if (err) {
> +			verbose(env, "bpf-to-bpf call offset out of range for interpreter\n");
> +			return err;
> +		}
>   	}
>   	err = 0;
>   #endif

