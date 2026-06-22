Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA333B5E10;
	Mon, 22 Jun 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137626; cv=none; b=To/td5VG2gdgzNT5PVo1BunCR16P/ejE6myd5hq8K6d1zRgJdLuDFrdy0lwpAqItHfgHvWGhWcTZQHf0xdS7sc4nAe0IOnqbgjhYS5cPGsV4mt+4FWYWrOy7KuJTFgtp6plU2iEBZgzfdTVWebGxf0tHPMifkg6j57UXz0mUzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137626; c=relaxed/simple;
	bh=RxBO3bY20IK3jLyu1eW/kflbV7dTh6Nb8ypvRcPu8S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kU5PZlD237BnmZXLGodzwTnVnB1I46cfdXnjUb4S28S4c88xVsy+X6WrbXmGLI5h6FwIt0fpUJ7NvlBLXL3a8NsvmQagCwaZX+/uVuQ8zkOHr1hO5B/8I36+gGzsXVGFgj9NqgqD+rsMzLS8PHQuUKAo4vzk+THs/NUelWgTwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uMEuUwBP; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uMEuUwBP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lhM0w5RwW/rGQWTCRisi1w9Hdy/5TctPsnbjJjiIjvk=;
	b=uMEuUwBPHg08rRjyCgP0rKJnC1ncdX6SmaEKX0WMKYgdm8OOAfZ4KJoki1AIHsMp5v72klxhA
	7SDqV9e12RYwsupLWhQbrhjiSLh/ufwTDxC6Dzr3FFPa1jP8g5ejwoN54VJjgIcOyi3RMmxWRyz
	PddlOySuwRgPfa5FIdTM5oU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gkVLn2z0PzRhqk;
	Mon, 22 Jun 2026 22:04:33 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B20340569;
	Mon, 22 Jun 2026 22:13:36 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Jun
 2026 22:13:35 +0800
Message-ID: <25072645-3981-4251-8364-ee793bfa8041@huawei.com>
Date: Mon, 22 Jun 2026 22:13:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] riscv: stacktrace: Implement
 arch_bpf_stack_walk() for BPF
Content-Language: en-US
To: Varun R Mallya <varunrmallya@gmail.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <bjorn@kernel.org>
CC: <alex@ghiti.fr>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<puranjay@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260621144259.288135-1-varunrmallya@gmail.com>
 <20260621144259.288135-2-varunrmallya@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260621144259.288135-2-varunrmallya@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Varun,

Thank you for implementing bpf exception for riscv64.

On 2026/6/21 22:42, Varun R Mallya wrote:
> This will be used by bpf_throw() to unwind till the program marked as
> exception boundary and run the callback with the stack of the main
> program.
> This is required for supporting BPF exceptions on RISC-V.
> This depends on the frame pointer unwinder, so it is only built under
> CONFIG_FRAME_POINTER, else falls back to the weak no-op.
> 
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>   arch/riscv/kernel/stacktrace.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index b41b6255751c..a4c2411f4038 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/export.h>
> +#include <linux/filter.h>
>   #include <linux/kallsyms.h>
>   #include <linux/sched.h>
>   #include <linux/sched/debug.h>
> @@ -102,6 +103,33 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>   	}
>   }
>   
> +void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
> +				 void *cookie)
> +{
> +	unsigned long fp, sp, pc;
> +
> +	fp = (unsigned long)__builtin_frame_address(0);
> +	sp = current_stack_pointer;
> +	pc = (unsigned long)arch_bpf_stack_walk;
> +
> +	for (;;) {
> +		struct stackframe *frame;
> +
> +		if (unlikely(!__kernel_text_address(pc)))
> +			break;
> +		/* pc belongs to the function whose frame pointer is fp */
> +		if (!consume_fn(cookie, pc, sp, fp))
> +			break;
> +		if (unlikely(!fp_is_valid(fp, sp)))
> +			break;
> +
> +		frame = (struct stackframe *)fp - 1;
> +		sp = fp;
> +		fp = READ_ONCE_TASK_STACK(current, frame->fp);
> +		pc = READ_ONCE_TASK_STACK(current, frame->ra);
> +	}
> +}
> +
>   #else /* !CONFIG_FRAME_POINTER */
>   
>   void notrace walk_stackframe(struct task_struct *task,

Reviewed-by: Pu Lehui <pulehui@huawei.com>
