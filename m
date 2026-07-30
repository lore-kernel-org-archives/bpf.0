Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44980269D18;
	Thu, 30 Jul 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395557; cv=none; b=irp/twbvw+ok3y/YYbIGZ/oXpDvZBd8j2KxL/GtgHTzoYr+MRtEnv/nndiKDZDrErAKVk1bfvFsSY7C7EWdbiqwDOXtDP2IIMKzo/5fyrwNXIrIbyNvxuze3szpUnv0JdO8BJhiN/77KMtbrW0y+VLc0FykNbdWAZQWx747LCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395557; c=relaxed/simple;
	bh=gH2hyiokf6xiM9h0rNCC2wC+lKCys2adF3SleeA3EdU=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gQ/DqpFZHMD7jKyuVrfvMvTJ4/grj9s2f/0OHsoqil9t7PwHkxdhXMNDWFmUbzixzO6GjkjDrpaxyFjXoyfwqdwwv5LNyQ44zwAx5t45o9Z29sPJIZKkWob+Nzh9ODqaSsE3mx5TdQ6rLtFdDv6FFeFK0L6Gy5sIGXEnueZAVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxJOpY+WpqXsYIAA--.28599S3;
	Thu, 30 Jul 2026 15:12:24 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxSsRT+Wpqm4odAA--.41301S2;
	Thu, 30 Jul 2026 15:12:21 +0800 (CST)
Subject: Re: [PATCH v1 0/2] Refine move_imm() and optimize memory load
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Chenguang Zhao <chenguang.zhao@linux.dev>, George Guo
 <guodongtai@kylinos.cn>, George Guo <dongtai.guo@linux.dev>
References: <20260728031615.9389-1-yangtiezhu@loongson.cn>
Message-ID: <a3099547-6742-2ba3-e53f-4153376da924@loongson.cn>
Date: Thu, 30 Jul 2026 15:12:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260728031615.9389-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxSsRT+Wpqm4odAA--.41301S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Wr4kuw4xAFWUtF43uF43XFc_yoW8Jr43pF
	4a9F43Gr4kWryxXFsxC3ykWrnxX34fGrZ3Wa13trW8CrWDZrn8Wr1xWw1kXF9rC34fG3y0
	qr4rZ3Wq93WUG3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==

On 2026/7/28 上午11:16, Tiezhu Yang wrote:
> This series is based on 7.2-rc5 and the following two series:
> 
> Fix and optimize BPF tailcall for LoongArch
> https://lore.kernel.org/loongarch/20260707101508.32283-1-yangtiezhu@loongson.cn/
> 
> LoongArch: BPF: clean up for build_insn() paths
> https://lore.kernel.org/loongarch/20260711100956.4351-1-yangtiezhu@loongson.cn/

...

> Tiezhu Yang (2):
>    LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
>    LoongArch: BPF: Eliminate zero-extension for memory load operations
> 
>   arch/loongarch/net/bpf_jit.c | 123 ++++++++++++++++++++++-------------
>   arch/loongarch/net/bpf_jit.h |   7 +-
>   2 files changed, 79 insertions(+), 51 deletions(-)
> 

Here is the latest loongarch-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

I noticed there are several patch series from others (Chenguang Zhao,
George Guo) that need to be rebased. To avoid unnecessary conflicts,
please bypass mine for now and focus on theirs.

I will hold off and send these refactoring and optimization patches
later when the timing is better.

Thanks,
Tiezhu

