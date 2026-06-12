Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB337D104
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229777; cv=none; b=JE6oPCn0XGmn652qhkzYOc7RuI6JWcKaKsvn11Tl2LCkHLW29Ydhxnq1jHFTjmBY3oiyyjHBLn9iFrsI+mZF0TMkYbTLLOmdSZ1DRdISto4VtBa3XYSehsS2YCStpdiGQHhPqvg/m1LGU7b7svIP9O7x9K+0dOSs/lETvzZmiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229777; c=relaxed/simple;
	bh=EYg/L3M5bcDmxoGhkwP6K60O0aaKPTs2U6yI2h7Q6Hw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RkJZvRaxXz1/AZErshPwr0i/OvZCzcP4/HQu+7hgUZjMhdfz+CMGhCmEYn5mrSJNMQrD1yupU+qGbKvUUOQ732nhzJktx2umfvzc+8LOtHdlhjio5ii2TlvAvreM1v8H3AUGD5azvWTKEod0l9O/+Sbi1+tSEywZp47K5Jn2Qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxVunEaCtqK1ATAA--.45330S3;
	Fri, 12 Jun 2026 10:02:44 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx28G_aCtq7HijAA--.47351S3;
	Fri, 12 Jun 2026 10:02:41 +0800 (CST)
Subject: Re: [PATCH v3 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, WANG Rui <wangrui@loongson.cn>
References: <20260612011616.27771-2-yangtiezhu@loongson.cn>
 <20260612012945.1CB951F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <05dce31c-91e1-117f-07b5-5c480d25d55d@loongson.cn>
Date: Fri, 12 Jun 2026 10:02:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260612012945.1CB951F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx28G_aCtq7HijAA--.47351S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurykGFWxKFWxAw47ZFy5GFX_yoWrWF48p3
	4akr17tr48Jr1Iv3W8Cw48ZFyrC397Ar13Gr4kCFyrt3Z0yrnYqr4Iqas5Zw15uw1fK34S
	vrWqyr929a1DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOF4_U
	UUUU=

On 2026/6/12 上午9:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Temporary biased `$tp` on 32-bit LoongArch causes infinite recursive faults during panic/exceptions, breaking stack traces and debuggability.
> --
> 
> commit 031d5abd58aa95ea089ae24763bb03c5e684dbc3
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
> 
> Select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
> stack into task_struct. This updates the thread pointer recovery path
> and context switch logic to adapt to the new layout.
> 
>> In the context of __switch_to(), local interrupts are disabled, and the
>> kernel is in a critical switching phase where handling any synchronous
>> exception is practically impossible and prohibited.
>>
>> If any synchronous exception or watchpoint does trigger in this narrow
>> window, it constitutes a fatal double fault and the kernel is expected
>> to die/panic immediately anyway. Therefore, the temporary biased value
>> in $tp is safe and acceptable here.
> 
> [Severity: High]
> Could this temporary biased value in $tp on 32-bit kernels prevent the
> system from printing the expected panic trace and instead cause an
> infinite recursive fault?
> 
> If an exception like a hardware watchpoint, NMI watchdog, or machine
> check triggers in this window, the unwinder calls show_stacktrace(),
> which defaults to current:
> 
> arch/loongarch/kernel/traps.c:show_stacktrace() {
>          if (!task)
>                  task = current;
> 
>          if (!try_get_task_stack(task))
>                  return;
> ...
> 
> Because current is derived from $tp, and $tp is offset by 2000 bytes
> (TASK_STRUCT_OFFSET), accessing the task stack refcount inside
> try_get_task_stack() will trigger a page fault.
> 
> The page fault handler then calls die(), which calls show_stacktrace()
> again. This creates an infinite recursive fault and stack overflow
> without printing the intended panic trace.
> 
>> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
>> index f377d8f5c51a6..d6e0d05d6fd39 100644
>> --- a/arch/loongarch/kernel/switch.S
>> +++ b/arch/loongarch/kernel/switch.S
> [ ... ]
>> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>>   	LONG_SPTR	t8, t7, 0
>>   #endif
>>   
>> -	move	tp, a2
>> +	move		tp, a1
>>   	cpu_restore_nonscratch a1
> 
> [Severity: High]
> Is there an alternative way to handle the structural pointer bias for
> 32-bit kernels without temporarily storing an invalid pointer in $tp,
> so that panic handling and debuggability remain intact?

Thanks for your review comments, I prefer to use
"PTR_ADDI        tp, a1, -TASK_STRUCT_OFFSET"
for both 64-bit and 32-bit here rather than use
"move		tp, a1"
for only 64-bit here.

But I discussed with the LoongArch maintainer Huacai, here is his
opinion in the previous v2:

"As I said before, even if you use "PTR_ADDI        tp, a1,
-TASK_STRUCT_OFFSET", it is impossible to handle exceptions in
__switch_to().

It is a type of "double fault" if exceptions really happen, "double
fault" means to die. So just keep it."

In the commit message, there is a corresponding description:

"To preserve the optimal and clean "move tp, a1" path for 64-bit kernels,
the thread pointer ($tp) is assigned directly from a1 in the core path.
For 32-bit kernels, where a1 carries a 2000-byte structural pointer bias
at entry, an explicit adjustment "PTR_ADDI tp, tp, -TASK_STRUCT_OFFSET"
is introduced at the function exit.

In the context of __switch_to(), local interrupts are disabled, and the
kernel is in a critical switching phase where handling any synchronous
exception is practically impossible and prohibited.

If any synchronous exception or watchpoint does trigger in this narrow
window, it constitutes a fatal double fault and the kernel is expected
to die/panic immediately anyway. Therefore, the temporary biased value
in $tp is safe and acceptable here."

Thanks,
Tiezhu

