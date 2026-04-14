Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98E3D5228;
	Tue, 14 Apr 2026 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165403; cv=none; b=IWtHeRXDlhslooGkdwAt9/7RNgvUSmVW/P4wdd/udw6nbHL9jchAoalz7PR5Np6lJfnYII8tf1+SdHjffDz7RaI52ltEJpoNWs0TjTtrzdNW3EEE1b41IiIlgrN9ySjYznMk3/aV96D1DwXV4F2uB+aJoZmfwtaig8e6KZK0g7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165403; c=relaxed/simple;
	bh=yt0lS0QXUu6mFWtbtcS7Iy5hebn27WJtwcTvwwmBGXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAk5HesIyqpVIzms85DXQwn8f67jSQoWaRSb1ZzZ9ygalJco5ISpG39bJfjnkw0HnSGPBn3gDhJ1vrHw1r3QkrgFfa1qM3CjSzgpAclF4ALhnibKK/cSTexIupbCvnArlKtMEybbL4GM/gcIidhUCt+8LlzcY0VIExn39JMZrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fw1sz1HTszYQv3s;
	Tue, 14 Apr 2026 19:15:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 65B744056E;
	Tue, 14 Apr 2026 19:16:35 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgDXyAMRIt5pWY9+AQ--.18262S2;
	Tue, 14 Apr 2026 19:16:35 +0800 (CST)
Message-ID: <5b7bb008-ac7b-41a5-9ee6-bdef6cd33d98@huaweicloud.com>
Date: Tue, 14 Apr 2026 19:16:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, arm64: Remove redundant
 bpf_flush_icache() after pack allocator finalize
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260413191111.3426023-1-puranjay@kernel.org>
 <20260413191111.3426023-2-puranjay@kernel.org>
 <dd645fcf-76dc-4c68-8b6f-1a168cafd44f@huaweicloud.com>
 <CANk7y0js0YxPFX1HqpYumN-ji6-OkKi4YO5=CRz8nx8aTzYxPw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CANk7y0js0YxPFX1HqpYumN-ji6-OkKi4YO5=CRz8nx8aTzYxPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXyAMRIt5pWY9+AQ--.18262S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxJw1kJry5GFWkGFW8tFb_yoW8Aw4UpF
	WfA3Z8KF4kXw4Dur10gF48XFySyws7JayUJ3WrCF9ak34Yvr97KFy3Kw409Fn0kryruw4j
	vF4jywsxuFy5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/14/2026 5:38 PM, Puranjay Mohan wrote:
> On Tue, Apr 14, 2026 at 2:56 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 4/14/2026 3:11 AM, Puranjay Mohan wrote:
>>> bpf_flush_icache() calls flush_icache_range() to clean the data cache
>>> and invalidate the instruction cache for the JITed code region. However,
>>> since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
>>> management"), this flush is redundant.
>>>
>>> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
>>> region via bpf_arch_text_copy() -> aarch64_insn_copy() -> __text_poke(),
>>> and __text_poke() already calls flush_icache_range() on the written
>>> range. The subsequent bpf_flush_icache() repeats the same cache
>>> maintenance on an overlapping range, including an unnecessary second
>>> synchronous IPI to all CPUs via kick_all_cpus_sync().
>>>
>>
>> So icache is flushed twice: once per instruction and again after all
>> instructions are copied. I think it's better to remove the per-instruction
>> flush and retain the single final flush to avoid repeating flush overhead
>> for each instruction.
> 
> No, bpf_jit_binary_pack_finalize() is called at the end after the
> whole program is jited, and it calls: bpf_arch_text_copy(ro_header,
> rw_header, rw_header->size); which does aarch64_insn_copy(dst, src,
> len), this calls __text_poke() which copies the whole program and then
> does flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len); once.
> This is correct, after this we don't need to call flush_icache_range()
> on the same range again.
> 
> If we had been calling flush_icache_range() for each instruction, the
> system would hang due to the storm of IPIs.
Right, thanks for the explanation!

LGTM.

