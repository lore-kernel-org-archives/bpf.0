Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA333B7742
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478412; cv=none; b=MfWOJlbhIg2mY6uuYh1HGj27cXzTJzt+luO85uRtkkgpKgAzVcRb/CmXvLDzDY8cWnz2UomSKWHPeXkC6lpvBdjERqZOghO3Y2r6Uhe4qw0iEOJCFCFifnj859W1sDdeaK96FZcMr3oPHX+nr/LZjW/AvybnIn8X2hB3/9Xz4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478412; c=relaxed/simple;
	bh=7a2ywGSxYzudq4PgBFRVGJkch0Z2aaMfXQmTFH/uv6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKdJrVtqjGKECE+dnt07sNinvaqS45ZTmWrEPIm2gM1gCgRk09envC71Z1yWQ6Vh7qTKQwHmBDG59cJ/C7xGziMjrjvoFAB8VAjoPuMf7hu/L3VIuCnqaBv+UHg1nrI9FaAzjWpfdXubBnLvHgWMz43aKgQE2Gsl3l2RpC0coho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw2P24dcjzKHLtC
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:39:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E87B24058C
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:39:54 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCXy1xzuE1qZQrOAQ--.42776S2;
	Wed, 08 Jul 2026 10:39:54 +0800 (CST)
Message-ID: <5c5d53e7-83dc-4795-ac89-3984db1d14e9@huaweicloud.com>
Date: Wed, 8 Jul 2026 10:39:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 5/6] riscv, bpf: Mixing bpf2bpf and tailcalls
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260707142219.2871758-1-pulehui@huaweicloud.com>
 <20260707142219.2871758-6-pulehui@huaweicloud.com>
 <20260707144908.AB3151F000E9@smtp.kernel.org>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260707144908.AB3151F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXy1xzuE1qZQrOAQ--.42776S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDGF18Jw47JFyDuF13XFb_yoW5KrW7pa
	4xCayfCrWvqFn5KanrXa1xXw1akr4kuFnrWr1rGw4Sya1q9rWkW3WfKw4ruF98Ar1rJw48
	Xr4qvF1Sv3WDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/7 22:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Extension programs (BPF_PROG_TYPE_EXT) targeting subprograms incorrectly reset the Tail Call Counter (TCC), bypassing the tail call limit and allowing infinite loops.
> --
> 
> --- Patch [5]: [PATCH bpf-next v5 5/6] riscv, bpf: Mixing bpf2bpf and tailcalls ---
> commit f7082c3640c8a167ff897d3870ee0dd71fc2faab
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Mixing bpf2bpf and tailcalls
> 
> This commit implements mixed bpf2bpf and tailcalls for the RV64 JIT.
> It changes how the Tail Call Counter (TCC) is passed and preserved,
> storing it in a non-callee saved register and explicitly saving/restoring
> it around bpf2bpf calls and tail calls.
> 
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 7c6304e0b846a..823262ca47ebf 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
> [ ... ]
>> @@ -1836,10 +1829,18 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   			}
>>   		}
>>   
>> +		/* restore TCC to RV_REG_TCC before bpf2bpf call */
>> +		if (aux->tail_call_reachable && insn->src_reg == BPF_PSEUDO_CALL)
>> +			emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
>> +
>>   		ret = emit_call(addr, fixed_addr, ctx);
>>   		if (ret)
>>   			return ret;
>>   
>> +		/* store updated TCC back to stack after bpf2bpf call */
>> +		if (aux->tail_call_reachable && insn->src_reg == BPF_PSEUDO_CALL)
>> +			emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
>> +
> 
> [Severity: High]
> If the bpf2bpf call jumps to a BPF_PROG_TYPE_EXT program that incorrectly
> reset RV_REG_TCC, will the caller now save that clobbered value to its own
> stack?
> 
> If the TCC is continuously reset to 33 in this manner, could this bypass the
> tail call limit and allow an infinite loop resulting in a CPU soft lockup?
> 
>>   		if (insn->src_reg != BPF_PSEUDO_CALL)
>>   			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
>>   		break;
> [ ... ]
>> @@ -2038,11 +2038,10 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
>>   	for (i = 0; i < RV_FENTRY_NINSNS; i++)
>>   		emit(rv_nop(), ctx);
>>   
>> -	/* First instruction is always setting the tail-call-counter
>> -	 * (TCC) register. This instruction is skipped for tail calls.
>> -	 * Force using a 4-byte (non-compressed) instruction.
>> -	 */
>> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
>> +	if (!is_subprog)
>> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
>> +
> 
> [Severity: High]
> Does this logic handle BPF_PROG_TYPE_EXT (freplace) programs correctly?
> 
> When an extension program is loaded independently and attached to a global
> subprogram of another BPF program, is_subprog will be false because it is the
> main program of its own object.
> 
> Won't this cause the EXT program to unconditionally emit this instruction,
> clobbering the inherited TCC passed in RV_REG_TCC from the caller?
> 
>> +	/* tailcall starts here, emit insn before it must be fixed */
>>   
>>   	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>>
> 

This two issue have been prevent in core framework by the patch [0], and 
the following testcase will cover these situation.

tailcalls/tailcall_freplace
tailcalls/tailcall_bpf2bpf_freplace

[0] https://lore.kernel.org/all/20241015150207.70264-1-leon.hwang@linux.dev/

