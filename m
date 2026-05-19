Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463E216A395
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161444; cv=none; b=nSqLFzlL8CujtT6ey4fBkhZWCcD5itDTVsxpMhpM+JdpteOYV5kdqYsWeCDjYT0DoPS9FXpIB0DT1qzR9QoI7jCW8CeLLB/koCcn0E0EbL+X9XFaQcxIt4b4QYU13Pc18JiqsGMHYYfj6rDC+iolDrPS+ZFDZO76jm+5FfuB8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161444; c=relaxed/simple;
	bh=h8LEAiCCNiQn5WPiAv9acMabbPsAsaGXYO2XOgk/vtA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RmW5KVzz92BL/oFKR8uMtZ6J1PWBKCsbm9XT6E+oaspmMfPiUnrWSm33efJGJvhiuFOKcBrmwYrVFbjITzuwNEdpBpglGhmpPgF8nErd/xtvx0vWi2zaki2EZPzuxotJ6XvmQtP6Ijys/d+/YJE7SW4TSiGaJ6DG8RBccJFLNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx3ele2QtqbxgLAA--.32470S3;
	Tue, 19 May 2026 11:30:39 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBx68Fd2QtqnOOHAA--.58923S3;
	Tue, 19 May 2026 11:30:37 +0800 (CST)
Subject: Re: [PATCH RFC bpf-next 2/2] selftests/bpf: Add LoongArch support for
 get_preempt_count()
To: Ihor Solodrai <ihor.solodrai@linux.dev>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260420111516.19982-3-yangtiezhu@loongson.cn>
 <20260420133532.4973DC2BCB4@smtp.kernel.org>
 <800726d7-7f09-40ee-a3ae-faf879364bdf@loongson.cn>
 <20bb1a25-4b5b-4d92-8096-fbc325cdf88d@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7936d4ed-7778-4606-c6f3-9dbbffbf6bac@loongson.cn>
Date: Tue, 19 May 2026 11:30:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20bb1a25-4b5b-4d92-8096-fbc325cdf88d@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68Fd2QtqnOOHAA--.58923S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1fKr4fCFW8ur15urWDKFX_yoW8Zr4fpF
	yFyr42yw4kGa40q34kJa1DuF9Iyw1kGryrWanxK3ySkw15Gw4Yq3y2kay5AFn8uryI9r40
	9rZ7KwnakF1DCagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
	UUU==

On 2026/5/16 上午1:45, Ihor Solodrai wrote:
> On 4/20/26 5:47 PM, Tiezhu Yang wrote:

...

> Hi Tiezhu,
> 
> I think it makes sense to include the selftests changes in the
> series implementing CONFIG_THREAD_INFO_IN_TASK for loongarch [1].
> 
> With respect to riscv part of this, I suggest you drop it unless you
> have the means to run the tests. Landing without any testing is silly.
> 
> Also I think you may drop the RFC tag. AFAIU you're trying to bring
> loongarch to parity with mainstream arch-es, and that shouldn't be
> controversial.

Hi Ihor,

Thanks for your reply and suggestions.

1. riscv part:

Given that riscv already supports CONFIG_THREAD_INFO_IN_TASK and there
is preempt_count member in struct thread_info, it can get the preempt
count via bpf_get_current_task_btf()->thread_info.preempt_count.

But this is only in theory, I did not test it on riscv TBH and there is
no "Tested-by" from the community so far. I will drop it in the next
version.

2. loongarch part:

Since LoongArch is transitioning to CONFIG_THREAD_INFO_IN_TASK, I have
found a proper way to handle this special status.

Use bpf_core_field_exists() to provide compatibility for both legacy and
future kernels. A struct flavor "task_struct___local" is introduced to
bypass static compiler checks when thread_info is missing from the base
task_struct.

For the newer kernels that select CONFIG_THREAD_INFO_IN_TASK, it reads
preempt_count from the thread_info embedded within task_struct. For the
older kernels without selecting CONFIG_THREAD_INFO_IN_TASK, it retrieves
the thread_info pointer from the bottom of the kernel stack(task->stack)
and then reads the preempt_count. This ensures the BPF selftests remain
functional across various LoongArch kernel versions.

"./test_progs -t exe_ctx" passes on LoongArch regardless of whether
CONFIG_THREAD_INFO_IN_TASK is set.

I will send new version ASAP.

Thanks,
Tiezhu

