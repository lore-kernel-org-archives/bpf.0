Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929854014B2
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500500; cv=none; b=uXTNipHpOa/nkT9a7Rfru6f8qzPzpCA6tvzT3WNEpBh/L6IA194GEFWnU4HA1ggpj3qoSeZx/wRBiUeE4RRvK52ASliihV+TjtxvGBz9+dYj9KKRDn/wGCOQ1sljbXf5DEfX/VLC8zLrfQkCjRfjQ21QH5SBUIFHLVdsEkvjc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500500; c=relaxed/simple;
	bh=GS8J5cPCM1gt8tGQiI0Ng/r79Op9m1dnvtoaqnHahUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEjQlqWTLUiULCrIfoXWpc/l7po4Og5fKJ7xFQlEPtCsTmI6GAgakLK4TXDLJ3oo488VFxoonK5ADdYXeOJdOLdC5bSqC52etLPVXIhLRs4/mw7cnNGll6x2zhR7vPaATrnae/E/gqoeZqFoHPpO9KKtE2EjN/iWDVzcYOelBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwBZ12MhSzKHML7
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 16:47:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0D51F4057C
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 16:48:14 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDH91jMDk5qzSntAQ--.43470S2;
	Wed, 08 Jul 2026 16:48:14 +0800 (CST)
Message-ID: <053bba67-1d78-4c35-85ac-0ebb8be12db2@huaweicloud.com>
Date: Wed, 8 Jul 2026 16:48:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
 <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <20260708070736.47B571F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260708070736.47B571F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH91jMDk5qzSntAQ--.43470S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZFWDWFWrGF4kWw4Uurg_yoW5Jw1rpa
	y7uw13uryvqr4xCw17Wa18Xa4Fqr4kZF43Jr1ruF1FyFs2kr92gF1akw4ruFy5Aryft3y8
	ur4j9w1S93WkA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/8 15:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Uninitialized Tail Call Count (TCC) in synchronous BPF callbacks allows bypassing tail call limits, leading to kernel stack overflow or DoS.
> --
> 
> --- Patch [6]: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls ---
> commit c63e8081e54742ee045ae19d7f5fc9de4b31396f
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Mixing bpf2bpf and tailcalls
>      
> This commit implements mixing bpf2bpf and tailcalls for the RV64 JIT,
> similar to x86_64, by using a non-callee saved register to transfer the
> TCC between functions and saving that register to the stack. It stores the
> TCC back to the stack after bpf2bpf calls or calling the original bpf
> func in a bpf trampoline.
> 
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 7c6304e0b846a..823262ca47ebf 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
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
> Does skipping TCC initialization for all subprograms leave the TCC uninitialized
> for synchronous BPF callbacks?
> 
> If a BPF program uses a C helper like bpf_loop() to invoke a synchronous
> callback (which is treated as a subprogram where is_subprog is true), the C
> helper will have clobbered the RV_REG_TCC (A6) register.
> 
> Because the callback skips initializing the TCC, it will inherit whatever
> garbage value was left in A6 and save it to the stack. If this callback then
> calls another subprogram that executes a tail call, could this garbage TCC
> value bypass the tail-call limit, leading to unbounded tail calls and
> a kernel stack overflow?

This not an issue, callback can not call tailcall.

> 
>> +	/* tailcall starts here, emit insn before it must be fixed */
>>   
>>   	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>>
> 

