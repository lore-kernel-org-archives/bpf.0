Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE921C2324;
	Mon, 29 Jun 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782701152; cv=none; b=GLn/srjteR89qmOX/wVqVtSqDXFf+4XJrPMQkMmcboZJYkeBA5lwoRBu+WCwE3g8m3MMLxfkLj4zmFSskzwq0Z/bTymj2MV6gblTVgxLQGhLrTxD2rTvOp5WU9mT2cbambBPOO/2xc9rkV/PCh7g9RA7fPU/ONEKEaORpG8ogbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782701152; c=relaxed/simple;
	bh=6whlM472XDbDK4oAY86QBQE4lLMTcLBzRjw0kH7xu6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GUaKdwJMfnmOi3oCOC9qiL5s24g3Aze/oBVS3Dtc0K6WlcbjHD05VmiOgnL1nSdejntHFy44YJfdyTIFt65y+OUa0f9MZeYu/xxFSUGomu0Wc0HABkQWpSjn+Jj9Vabyv5JrUEcL2JxIkuoyIJqn6H3l6np9eW6wU0p8nOpOX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zLFZCyhK; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zLFZCyhK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+RJGyhOhZ1tq7Gv/WlbCg3jJO5RCxNjVoq4LnTJ7QMw=;
	b=zLFZCyhKBZTaW85ElrIqjEtWjtBULUaJRgJ79csFigvWxfctAYuAhpSmb0X8384DNa/kmMLwK
	+oWvsgT6b/pzLEEso0TzdGz+WkNEBVKx8eHnrWybYlaUklmJyMyAHDO3RccwX7+fIfz06j3WE+v
	OC2qxfpzMkzbl76y2sbMM2w=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gpVlg4bDmz1K98D;
	Mon, 29 Jun 2026 10:36:31 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id A47AA40578;
	Mon, 29 Jun 2026 10:45:38 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 29 Jun
 2026 10:45:37 +0800
Message-ID: <912fa271-7358-46b6-ad19-8a2a25b7d34a@huawei.com>
Date: Mon, 29 Jun 2026 10:45:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] riscv: stacktrace: Implement
 arch_bpf_stack_walk() for BPF
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Varun R Mallya
	<varunrmallya@gmail.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
CC: <alex@ghiti.fr>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<puranjay@kernel.org>, <shuah@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
 <20260628081710.113333-2-varunrmallya@gmail.com>
 <87ik72y3sr.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87ik72y3sr.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/6/29 1:26, Björn Töpel wrote:
> Varun!
> 
> Thanks for spending time on getting RV eBPF more feature complete! Sorry
> for the slow replies.
> 
> Varun R Mallya <varunrmallya@gmail.com> writes:
> 
>> This will be used by bpf_throw() to unwind till the program marked as
>> exception boundary and run the callback with the stack of the main
>> program.
>> This is required for supporting BPF exceptions on RISC-V.
>> This depends on the frame pointer unwinder, so it is only built under
>> CONFIG_FRAME_POINTER, else falls back to the weak no-op.
>>
>> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
>> Reviewed-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/kernel/stacktrace.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
>> index c7555447149b..64929381bb30 100644
>> --- a/arch/riscv/kernel/stacktrace.c
>> +++ b/arch/riscv/kernel/stacktrace.c
>> @@ -5,6 +5,7 @@
>>    */
>>   
>>   #include <linux/export.h>
>> +#include <linux/filter.h>
>>   #include <linux/kallsyms.h>
>>   #include <linux/sched.h>
>>   #include <linux/sched/debug.h>
>> @@ -102,6 +103,36 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>>   	}
>>   }
>>   
>> +void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
>> +				 void *cookie)
>> +{
>> +	unsigned long fp, sp, pc;
>> +	int graph_idx = 0;
>> +
>> +	fp = (unsigned long)__builtin_frame_address(0);
>> +	sp = current_stack_pointer;
>> +	pc = (unsigned long)arch_bpf_stack_walk;
>> +
>> +	for (;;) {
>> +		struct stackframe *frame;
>> +
>> +		if (unlikely(!__kernel_text_address(pc)))
>> +			break;
>> +		/* pc belongs to the function whose frame pointer is fp */
>> +		if (!consume_fn(cookie, pc, sp, fp))
>> +			break;
>> +		if (unlikely(!fp_is_valid(fp, sp)))
>> +			break;
>> +
>> +		frame = (struct stackframe *)fp - 1;
>> +		sp = fp;
>> +		fp = READ_ONCE_TASK_STACK(current, frame->fp);
>> +		pc = READ_ONCE_TASK_STACK(current, frame->ra);
>> +		pc = ftrace_graph_ret_addr(current, &graph_idx, pc,
>> +					   &frame->ra);
>> +	}
>> +}
> 
> We don't need more stack unwinders. Can you see if you can extend
> walk_stackframe() with "cookie" to match BPF's needs? Have a look at
> what arm64 does.
> 
> Sashiko had a good point about ftrace_graph_ret_addr() -- now what about
> kretprobe? Do we need to take that in consideration as well?

IIUC, arch_bpf_stack_walk only unwind for bpf prog stack, maybe we could 
not need to handle kretprobe.

> 
> 
> Thanks,
> Björn
