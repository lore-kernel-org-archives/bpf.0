Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843424;
	b=LRdTOUUDm/1ZTTVgo7PvHt5JXRc+mc0uEDvpQHCgrazlkERhV3NTCvnISTLthtj7Fpg7
	 DBX8iPd0lmalpma4NxPNlVqV3uSY43WL4IwiRQNFITw6qgX1PAXyq7LnGZ6URhq4Js5YV
	 qzIeab3KxciXWMwmyzxO98sY9ZwBtIUAqNOuGjjGeylskx5+rK8ATXe4GltsoJR2c7J/N
	 6yid2ESBTGDG0D8AGmlRx8fzRmz/81mtB6FD0NaDfjeJNz90bYRa1fS8QKOL109swRblF
	 Lzcj9vvHlnDAv9mUYSKvj4sJqZG8LNG027S1Rj5BPuJpcuE2cawy5E+qcK9i5GvxIhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843424;
	h=DMARC-Filter:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=w3bjmnRpABvjjTMc+j8jy7xf8N+60afMMXD7WGaabWI=;
	b=cCm/FyDhKL/ynFJO+y9MiwVS6lNjhgtCIyWzgypWWVQAO/olXZdtRFlP+A6RidJZWh8w
	 TKIGBkKAmmBmnJzEUNRRrExQ5/2Lal1GVqEfCtT6Zfb2V37nu11dsr+THuB5I9T0bYic+
	 ec28b6or81lImYFV/BhuFT0x/aIg3pwtTMPGrhtw4GiXMBwZS5PXofGY4SnzyRVVaocCS
	 2SfLi41Q3y4GLqFG+9b0/LJA+gEBtqoHWSMgc8r6qalMtWmNMA5sFdWPB7t+s/wGC0UCL
	 GmWvU4jc7nAFaKi9Y4s+vxNEiegmKcHa0Ey3AvVbn+u76FZyupTfDvd9ftbjGh2tvZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7066606A31B;
	Thu,  5 Nov 2026 01:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7066606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Bxn9HW4Otq8H4cAA--.16332S3;
	Thu, 05 Nov 2026 09:50:14 +0800 (CST)
Received: from [127.0.0.1] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs3T4OtqVHgyAA--.61748S2;
	Thu, 05 Nov 2026 09:50:12 +0800 (CST)
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ
 extension
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, hengqi.chen@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102072808.23080-2-yangtiezhu@loongson.cn>
 <20261104101753.20704-1-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4e9bcddf-7dfe-b78f-035f-8a4b76584fdd@loongson.cn>
Date: Thu, 5 Nov 2026 09:50:11 +0800
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
In-Reply-To: <20261104101753.20704-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJBxJs3T4OtqVHgyAA--.61748S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFW3Cr17ZFW5tFWDAry7Jwc_yoW8ur15pa
	y8Wr4UZrZ0gw1jyr4Iyw4fuF4rW34rCF4UJw1fW348Zwn8Wr1fWr4FkFW5XF1Uurs3AF4U
	tF4Iqa429r4jyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

On 11/4/26 6:17 PM, George Guo wrote:
> Hi Tiezhu,
> 
> On 2026/11/2 15:28, Tiezhu Yang wrote:
>> This is because the arena range tree uses kmalloc_nolock(), which requires
>> 128-bit atomic cmpxchg support, provided by SCQ extension on LoongArch.
> 
> There is an existing SLUB debug fallback worth checking before making
> arena support depend on SCQ.
> 
> In __kmalloc_nolock_noprof(), the rejection condition is:
> 
>          if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>                  return NULL;
> 
> Debug caches do not require cmpxchg128 for this path. They use
> kmem_cache_node->list_lock with spin_trylock_irqsave() instead.
> With CONFIG_SLUB_DEBUG=y, booting with slab_debug enables this path;
> CONFIG_SLUB_DEBUG_ON=y enables debugging by default as well.
> 
> The proposed bpf_jit_supports_arena() check would reject arena maps on
> CPUs without SCQ, even when the SLUB debug fallback is available.
> This would prevent us from running arena tests on those machines
> with slab_debug enabled.
> 
> Could you rerun jit_insns/cast_to_user on the 3A5000 with slab_debug
> enabled, before and after this patch? The claim that kmalloc_nolock()
> requires 128-bit cmpxchg should account for debug caches, and it would
> be useful to preserve that fallback when addressing the error reporting.

I noticed that a similar concern regarding the slub_debug exception
was previously raised by the CI bot in the RISC-V ZACAS patch:
https://lore.kernel.org/bpf/594ed4944926f6a7202b016eca03d879d11bfdf09a2cbaea039421ae4ab962c0@mail.kernel.org/

I highly agree with the bot's conclusion there:
 > "That narrowing is arguably desirable (BPF should not depend on a SLUB
 > debug-mode escape hatch)."

Moreover, handling this runtime debug mode inside the architecture's JIT
layer would inevitably introduce undesirable cross-module coupling with
SLUB internals. Restricting the JIT capability solely to native hardware
and toolchain support keeps the implementation clean and robust.

Thanks,
Tiezhu

