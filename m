Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655057;
	b=p0J75WsC97O1FuByiLVWYwH+4dpRc0lzd3sgoZKyUoS1fn0YkGMP1txErJZIM5A0X+aP
	 DBO6r/wDuyO4NsP236DrQDIV6S7AtwxfL3rntjZiYFjkwa4F9B6htuZwIAj3ag0tKFxNU
	 Gj1fXuJ1+jd9m5dqhD8QVKSL4YRKq5pewJ8kXfIiW8vtWlwLwhZXLWDzkav3UlViLyoVu
	 4twu3jW7eunGJ6OCMj53IGxQd2qs632fI1xr0NymKmYg7YXFYS0AcnWaz7uJ6hEX/xizk
	 RMCImHIIEd/CAWTsZ2h6X7WmHgDghWeC3qHtQd76BoeyxiTni+B3uqiRBLxt5uNxhWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655057;
	h=DMARC-Filter:Received:Received:Subject:From:To:Cc:References:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=AoA1P7WKLNrOX02YQSL55viI6QWHAQ+FD5QbIV/xp6s=;
	b=BYnL9wW9FApTvfuAd661QycXzLrYD9R59Q+K5vQNLie1vU0GkzvQE4Mn/MIfcyWqoYR4
	 BtF3WU91RkR838ONYvg2Et+0XxkNZcvuTPAxibc1mIuI/yxHlQHBjfpaDhgTHAsfaA811
	 G23r0Av0beyg2R3iqXbHbMPZVhE86mtNYbMJzLouOJ9MMU/jCNc1dPKA9yqv1o8Vr6AL1
	 jnFpJTUGhR+n5eLyYYnhx+wAQMReWbwWY+/qQm+0CeBItOua1Ym1MnlaqDVmBFLx96Yka
	 1u2LzRezxPzbIO6Y1Te8mqZmuob0qqIjULjmhva5k297FC3I7zy91wsT2qCA87ClT1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05D606A31B;
	Thu, 22 Oct 2026 07:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E05D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxTNLFvtlqClIYAA--.5034S3;
	Thu, 22 Oct 2026 15:44:06 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs++vtlqeRsvAA--.32704S2;
	Thu, 22 Oct 2026 15:43:59 +0800 (CST)
Subject: Re: [PATCH v3 0/3] LoongArch: BPF: Refine move_imm() and optimize
 32-bit operations
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016081006.26069-1-yangtiezhu@loongson.cn>
Message-ID: <0b06e77e-540d-19d4-4d9f-de3db1f2c317@loongson.cn>
Date: Thu, 22 Oct 2026 15:43:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261016081006.26069-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs++vtlqeRsvAA--.32704S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4DXFyUuFyUAry7CryDArc_yoW8CF4rpF
	Z8XFs7KF4DXFyjqa4kCr48JFyYka1rtFWDJw4rCryUJrn8Cr18tFWIqF48Aas5CrWF9r9I
	v3yjqrsxZFsxJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU88Ma5UUUUU==

On 2026/10/16 下午4:10, Tiezhu Yang wrote:
> v3:
>    -- Add a prerequisite patch to detect CPUCFG2_DIV32 feature.
>    -- Fix a hardware compatibility bug by checking cpu_has_div32
>       before emitting native 32-bit div/mod instructions.
> 
> This version is based on v7.3-rc7 and has been tested on Loongson-3A6000
> and Loongson-3A5000 physical machines.
> 
> All of the testcases of test_bpf passed on Loongson-3A6000 (with DIV32)
> and Loongson-3A5000 (without DIV32), here are the test results:
> 
> $ sudo modprobe test_bpf
> $ dmesg -t | grep Summary
> test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
> test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> 
> For the BPF selftests test_verifier and test_progs, there are no any
> regressions.
> 
> Tiezhu Yang (3):
>    LoongArch: Add CPUCFG2 DIV32 feature detection
>    LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
>    LoongArch: BPF: Optimize 32-bit operations using native instructions

Hi Huacai, Hengqi,

A gentle ping on the last 2 patches of this series since patch 1
has been applied.

There are no any reports from bot+bpf-ci and sashiko-bot,
and also "test_bpf" and "./test_progs -t jit_insns" tests passed.

Just to clarify the testing status: the 3 failures mentioned in
the previous test report are entirely pre-existing on the clean
bpf-next tree and completely unrelated to this 32-bit optimization
series.

The core ALU32/JMP32 paths introduced here have been fully verified
and passed without any regressions on both 3A6000 and 3A5000 physical
machines.

Do you have any further comments or objections to patches 2 and 3?
If these look good to you, it would be great to have them merged to
avoid rebasing and resending these patches after this merge window.

Thanks,
Tiezhu

