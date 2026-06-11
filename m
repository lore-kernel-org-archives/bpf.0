Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2A240D586
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148196; cv=none; b=umiKt80dtuvP1VjM593Ftjb+XvUcQw44BDlfXs/xbT9x0ALsCO8PCnBSi0t+kPufMhNh5EC9cIVAzyWgSntDyP6QktvBaGqGN/bCgk/JmgWv4WcBfdi7F9ZpfSDRJx41+2D9tf59eDa7zpeg6i7BqhJTroB8CC0Wm2a0bI3rRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148196; c=relaxed/simple;
	bh=Ire34GyNL1aIr6ZC2zlXI0S2/dMeLu/+8HjtAfXHD/w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VL0cdpaPRY3BYyeimPvlVc0GzhKpdHmq6NlHjbQ5RHh60xNFpOmGy3Pw9lReEZ+xCdtBm7Jbh6bM2s3C0CnGT2vAdWajaNzBe0MW8SAHhRhBZXzH+SCvicUOVUWekSfLtBQRs3Eoxzjyy1qeURNYq1Ghvw3sdHYYAFtljIBC3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxhngfKipqpOwSAA--.25590S3;
	Thu, 11 Jun 2026 11:23:11 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxLMIVKipq5YSiAA--.45500S3;
	Thu, 11 Jun 2026 11:23:02 +0800 (CST)
Subject: Re: [PATCH v2 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260611015327.12108-2-yangtiezhu@loongson.cn>
 <20260611020820.1F18B1F00893@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b22f3a7f-4d23-a3be-73de-a30be745b444@loongson.cn>
Date: Thu, 11 Jun 2026 11:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260611020820.1F18B1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMIVKipq5YSiAA--.45500S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3AFy5tFy8JF4fKFy8JryxJFc_yoW7Xr17pw
	sxA3ZFqF4UJr1jga4UJ34DZr9xJws7C3y3KFZFka40kF15JF1Fvr12qas8ZF15A348ta4I
	vrZYqrs29anrAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HS
	oJUUUUU==

On 2026/6/11 上午10:08, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] In 32-bit kernels, the `$tp` (current task pointer) holds a biased pointer during `__switch_to()`, exposing the kernel to memory corruption or crashes if a synchronous exception occurs.
> - [High] Missing `try_get_task_stack()` in `show_stacktrace()` allows a use-after-free read of kernel stack memory, causing an information leak.
> --
> 
> commit a68f9b2fc34ae06149cefb44ef7146643d52f85f
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
> 
> Select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
> stack into task_struct. Initialize a per-CPU cpu_tasks variable, update
> assembly paths to restore the $tp register from it, and adjust stack
> accesses and unwinding to account for the new configuration.
> 
>> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
>> index f377d8f5c51a6..d6e0d05d6fd39 100644
>> --- a/arch/loongarch/kernel/switch.S
>> +++ b/arch/loongarch/kernel/switch.S
> 
> [ ... ]
> 
>> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>>   	LONG_SPTR	t8, t7, 0
>>   #endif
>>   
>> -	move	tp, a2
>> +	move		tp, a1
>>   	cpu_restore_nonscratch a1
>>   
>> -	li.w		t0, _THREAD_SIZE
>> -	PTR_ADD		t0, t0, tp
>> +	LONG_LPTR	t0, a1, (TASK_STACK - TASK_STRUCT_OFFSET)
>> +	PTR_LI		t1, _THREAD_SIZE
>> +	PTR_ADD		t0, t0, t1
>>   	set_saved_sp	t0, t1, t2
>>   
>>   	LONG_LPTR	t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
>> @@ -45,6 +46,7 @@ SYM_FUNC_START(__switch_to)
>>   
>>   #ifdef CONFIG_32BIT
>>   	PTR_ADDI	a0, a0, -TASK_STRUCT_OFFSET
>> +	PTR_ADDI	tp, tp, -TASK_STRUCT_OFFSET
> 
> [Severity: High]
> Could the delayed removal of the bias from the thread pointer cause
> issues if a synchronous exception occurs?
> 
> For 32-bit kernels, a1 is biased by TASK_STRUCT_OFFSET at the start
> of __switch_to(). The code copies this biased pointer directly into tp
> and only removes the bias at the end of the function.
> 
> While local interrupts are disabled during this window, synchronous
> exceptions such as hardware data watchpoints might still trigger. If
> do_watch() executes during this window, it would use the biased tp
> (pointing to next_task + 2000), potentially causing out-of-bounds
> memory accesses or kernel panics.

I used "PTR_ADDI        tp, a1, -TASK_STRUCT_OFFSET" rather than
"move		tp, a1" before sending v2, but Huacai suggested
the current code.

@Huacai, what is your opinion?


>>   #endif
>>   	jr	ra
>>   SYM_FUNC_END(__switch_to)
> 
>> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
>> index 5d49b742e3bf6..7e4206da4876b 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -90,6 +90,9 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
>>   	if (!task)
>>   		task = current;
>>   
>> +	if (!try_get_task_stack(task))
>> +		return;
>> +
> 
> [Severity: High]
> Is there a similar use-after-free risk in show_stacktrace() when
> reading from the stack pointer?
> 
> While try_get_task_stack() correctly protects show_backtrace(),
> show_stacktrace() appears to read directly from the task's stack
> pointer via __get_addr() without acquiring a reference.
> 
> With THREAD_INFO_IN_TASK enabled, the stack can be freed before the
> task_struct. If show_stacktrace() is called on an exiting task
> (for example, via SysRq-T iterating over all tasks), could it read
> from a freed and reallocated stack, leaking memory contents?
> 

I will do the following changes:

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 7e4206da4876..776523747ea3 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -90,9 +90,6 @@ static void show_backtrace(struct task_struct *task, 
const struct pt_regs *regs,
         if (!task)
                 task = current;

-       if (!try_get_task_stack(task))
-               return;
-
         printk("%sCall Trace:", loglvl);
         for (unwind_start(&state, task, pregs);
               !unwind_done(&state); unwind_next_frame(&state)) {
@@ -100,8 +97,6 @@ static void show_backtrace(struct task_struct *task, 
const struct pt_regs *regs,
                 print_ip_sym(loglvl, addr);
         }
         printk("%s\n", loglvl);
-
-       put_task_stack(task);
  }

  static void show_stacktrace(struct task_struct *task,
@@ -112,6 +107,12 @@ static void show_stacktrace(struct task_struct *task,
         unsigned long stackdata;
         unsigned long *sp = (unsigned long *)regs->regs[3];

+       if (!task)
+               task = current;
+
+       if (!try_get_task_stack(task))
+               return;
+
         printk("%sStack :", loglvl);
         i = 0;
         while ((unsigned long) sp & (PAGE_SIZE - 1)) {
@@ -134,6 +135,8 @@ static void show_stacktrace(struct task_struct *task,
         }
         pr_cont("\n");
         show_backtrace(task, regs, loglvl, user);
+
+       put_task_stack(task);
  }

  void show_stack(struct task_struct *task, unsigned long *sp, const 
char *loglvl)

Thanks,
Tiezhu

