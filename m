Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DE1E98E3;
	Wed,  2 Sep 2026 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318803; cv=none; b=CUavuTtX85YKovcov5NW9XWTeL+ZjbnyXNCVVdYZ8lLL1BHG+8dN6/pQbPCnSSvyBDtb/o+DRqOr0S8lX73QcBZpPRV1SATFif8d+9AtZ5iFTlXBpMK0fipqaOoTxm0ePGjdv6a+ICMQ95qxeq1mSF29AFzZLKE1lUpIhQ9K1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318803; c=relaxed/simple;
	bh=C+Uo2kt5ZOqlw8/33V+ZcOjMsJv6LTfRgew/gLDOF+s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jwOlzWFZKXHG8c2EQN9tCq6OK3PC44bDxRApuoRLwZZI9iFYVoQefkql9IMQF1BmtvDpYwcg1+o25rgSiLtlp81lg/85Ly8pM8nKtmvb/TONzwIdmQo4TTULUi05K8VGlobOnHd47MbgugXJJnI7Rnjftf/2Jaj1K1+y8r3rLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxPtMMjZdqhZsHAA--.21507S3;
	Wed, 02 Sep 2026 10:42:20 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c4JjZdq3EcZAA--.53851S2;
	Wed, 02 Sep 2026 10:42:18 +0800 (CST)
Subject: Re: [PATCH bpf v1 RESEND] bpf: Fix timer_lockup deadlock using
 atomic_fetch_inc()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902005106.22187-1-yangtiezhu@loongson.cn>
 <DL4FK2P8LMEQ.216J5ZMX9B7VC@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7d0bd14f-d13e-6735-92f3-68f474c66a73@loongson.cn>
Date: Wed, 2 Sep 2026 10:42:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DL4FK2P8LMEQ.216J5ZMX9B7VC@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3c4JjZdq3EcZAA--.53851S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4DZF18GrWkXw4kAw1xXrc_yoWrZr4kpr
	WxCF47Kr4kXr48Xw1kJa1UuF1F939Yka43Jr4rGr1Uu3W5Kr1YyF409r43WFy5Cws8Jry2
	yry0q3sagFn8JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcApnDUUUU

On 2026/9/2 上午9:13, Kumar Kartikeya Dwivedi wrote:
> On Wed Sep 2, 2026 at 2:51 AM CEST, Tiezhu Yang wrote:
>> When testing the BPF selftest "sudo ./test_progs -t timer_lockup", there
>> is a kernel lockup and panic on LoongArch:
>>
>>    watchdog: BUG: soft lockup - CPU#1 stuck for 8s! [test_progs:39601]
>>    Kernel panic - not syncing: softlockup: hung tasks
>>    ...
>>    Call Trace:
>>    ...
>>    [<9000000000c40e98>] panic+0x44/0x48
>>    [<9000000000e8b000>] watchdog_timer_fn+0x500/0x520
>>    [<9000000000dfd9a4>] __hrtimer_run_queues+0xc4/0x530
>>    [<9000000000dffe90>] hrtimer_interrupt+0x140/0x320
>>    ...
>>    [<9000000002ad9e4c>] _raw_spin_unlock_irqrestore+0x8c/0xc0
>>    [<9000000000dfe9e0>] hrtimer_try_to_cancel.part.0+0x70/0x350
>>    [<9000000000dfed58>] hrtimer_cancel+0x38/0x80
>>    [<9000000000f6d944>] bpf_timer_cancel+0x94/0x1e0
>>    [<ffff80000200fad0>] bpf_prog_108ab87b32f22e44_timer_cb1+0xb0/0xfc
>>    [<9000000000f6b838>] bpf_timer_cb+0x98/0x170
>>    [<9000000000dfdaac>] __hrtimer_run_queues+0x1cc/0x530
>>    [<9000000000dfde94>] hrtimer_run_softirq+0x84/0xd0
>>    ...
>>    [<900000000271d9e0>] bpf_test_run+0x1c0/0x5c0
>>    [<900000000271f548>] bpf_prog_test_run_skb+0x6e8/0xe20
>>    [<9000000000f39940>] __sys_bpf+0x1690/0x2c50
>>    [<9000000000f3af28>] sys_bpf+0x28/0x40
>>    [<9000000002ac2d68>] do_syscall+0x108/0x5e0
>>    [<9000000000c6a850>] handle_syscall+0xd0/0x170
>>
>> In bpf_timer_cancel() of kernel/bpf/helpers.c, it explicitly notes that
>> "Need full barrier after relaxed atomic_inc" to ensure global visibility
>> of the cancelling state before performing the lockless dependency checks.
>>
>> However, on weakly-ordered architectures such as LoongArch, the current
>> combination of a relaxed atomic_inc() followed by smp_mb__after_atomic()
>> fails to guarantee the physical store-load ordering because the latter
>> currently expands to an empty compiler barrier rather than a hardware
>> data barrier on LoongArch.
>>
>> This allows a subsequent read to bypass the prior write due to store-load
>> reordering, enabling concurrent CPUs to simultaneously bypass the software
>> deadlock detection, enter hrtimer_cancel(), and then trigger a severe ABBA
>> deadlock in the hrtimer core.
>>
>> Instead of relying on arch-specific macro implementations which may vary
>> in strictness, fix this issue directly in the BPF core helper by replacing
>> atomic_inc() and smp_mb__after_atomic() with a single atomic_fetch_inc()
>> to provide full ordering natively.
> 
> This paragraph is completely bogus. LoongArch's smp_mb__after_atomic() had a
> bug. The specification in LKMM for smp_mb__after_atomic() is that it should be a
> full barrier, which can be relaxed if the prior atomic operation already
> provides the necessary ordering.
> 
> As I already said, there is no point in changing or "optimizing" this atomic
> inc. Just let it be. You will see no measurable difference for this function.
> 
> Just accept that it was a bug, and fix the lowering for your arch. Plenty of
> other logic in the kernel uses this primitive, so I think you folks were just
> lucky this wasn't hit before by something else.

Thanks for your feedback.

I looked into tools/memory-model/Documentation/ordering.txt,
as it explicitly clarifies, atomic_inc() does not guarantee
full ordering on weakly-ordered architectures, therefore
smp_mb__after_atomic() must emit a hardware data barrier to
comply with the LKMM specification, rather than expanding to
a plain compiler barrier.

I also noticed there are hundreds of smp_mb__after_atomic()
call sites across the core kernel (kernel/, drivers/, mm/,
net/, fs/) that currently lack necessary hardware data barriers
on LoongArch, which have potential risks.

So please disregard this bpf patch, I will send a v2 patch to
remove the definition of __smp_mb__{before,after}_atomic() in
arch/loongarch/include/asm/barrier.h, so that these two macros
can automatically fall back to the generic definition in
include/asm-generic/barrier.h:

#ifndef __smp_mb__before_atomic
#define __smp_mb__before_atomic()	__smp_mb()
#endif

#ifndef __smp_mb__after_atomic
#define __smp_mb__after_atomic()	__smp_mb()
#endif

Thanks,
Tiezhu

