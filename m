Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D6396D1C;
	Wed,  8 Jul 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500904; cv=none; b=qHNkTXOJsLzWpdt3lbqSbPColUn7vgvrgh6ysc6Qjf2qua1KD40Kkxnt1ZMiifDnmosQNrngDGhq86ydamgYSUMIaQsrccfJnFuc5nC4JN+0yIQU6ruSnMfYYN4oWXY/Ci0lemVhQb8B9ZAqLBryQHSRLXos0pVBEJj3XEO2yqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500904; c=relaxed/simple;
	bh=pGMPlxkveq5g1NOS+lkDvnsKl9agy9XrYgbUKIMw2u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X92rJ59d5Sf9TvFBIEtGBJZsWCQw8Fvi472yitS4uYAp9iT+R2CfOFwzT3OVQECtCPtQG+0EOPlpQCQbzeB1BtmkgcpcqCGbrL0RWRYigGt9J5SeEh0TUl6khLDhihv6OGPxYr7FgIEdmkkGVs+OSJMLcZ2XYbv8fyiTWhLgy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwBjy15r8zYQtkP;
	Wed,  8 Jul 2026 16:54:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DD0474057D;
	Wed,  8 Jul 2026 16:54:50 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgA3RnJaEE5qfZjqAQ--.40631S2;
	Wed, 08 Jul 2026 16:54:50 +0800 (CST)
Message-ID: <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
Date: Wed, 8 Jul 2026 16:54:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgA3RnJaEE5qfZjqAQ--.40631S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDJw1ftrWUGr4xZr4ktFb_yoWrXryfpa
	yfCws3CFWvqr18Cw17tF4kXayYkrs5uw47Gr15GrySyanxZF1kKF13Kw4ruFyUJrWFk340
	vrWjq3WfuaykA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	7PEDUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/8 15:35, bot+bpf-ci@kernel.org wrote:
>> commit 64161f8a9f1c78ecd88b27109e6ed8b53282f94b
>> Author: Pu Lehui <pulehui@huawei.com>
>> Date:   Wed Jul 8 06:44:35 2026 +0000
>>
>>      riscv, bpf: Mixing bpf2bpf and tailcalls
>>
>>      In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>>      the TCC can be propagated from the parent process to the subprocess, but
>>      the updated TCC of the parent process cannot be restored when the
>>      subprocess exits. Since the RV64 TCC is initialized before saving the
>>      callee saved registers into the stack, we cannot use the callee saved
>>      register to pass the TCC, otherwise the original value of the callee
>>      saved register will be destroyed. So we implemented mixing bpf2bpf and
>>      tailcalls similar to x86_64, i.e. using a non-callee saved register to
>>      transfer the TCC between functions, and saving that register to the
>>      stack to protect the TCC value. As for the tailcall hierarchy issue,
>>      inspired by the s390's low-overhead approach, we store TCC from
>>      RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
>>      func in bpf trampoline.
>>
>>      Tests test_bpf.ko and test_verifier have passed, as well as the relative
>>      testcases of test_progs*.
>>
>>      Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> This looks like a bug fix for TCC handling across bpf2bpf calls and
> tailcalls. Should this include:
> 
>    Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
> 
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index da02717902442..419b9d795f2a7 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -81,6 +81,7 @@ struct rv_jit_context {
>>   	int ex_jmp_off;
>>   	unsigned long flags;
>>   	int stack_size;
>> +	int tcc_offset;
>>   	u64 arena_vm_start;
>>   	u64 user_vm_start;
>>   };
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 7c6304e0b846a..823262ca47ebf 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
> 
> [ ... ]
> 
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
>> +	/* tailcall starts here, emit insn before it must be fixed */
>>
>>   	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
> 
> The TCC initialization is now conditionally emitted based on is_subprog.
> Does this affect the RV_TAILCALL_OFFSET calculation?
> 
> Looking at the RV_TAILCALL_OFFSET macro definition:
> 
>    #define RV_TAILCALL_OFFSET ((RV_FENTRY_NINSNS + 1) * 4)
> 
> This assumes a fixed number of instructions before the tailcall entry
> point. When is_subprog is true, the rv_addi() instruction is not emitted,
> which means the tailcall entry point moves forward by 4 bytes relative to
> where RV_TAILCALL_OFFSET expects it to be.
> 
> The tailcall entry is used in emit_bpf_tail_call() when calculating the
> jump target for the tail call. If RV_TAILCALL_OFFSET doesn't account for
> the conditional emission, could this cause the wrong entry point to be
> used when tail calling into subprograms?

This is not an issue, subprog can not be the tailcall callee.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28923410500

