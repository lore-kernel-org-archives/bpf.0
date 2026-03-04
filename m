Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BC39EF04;
	Wed,  4 Mar 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626297; cv=none; b=tVeT5ZGskE69tpIvxYx1GX1G7EfBI2e93diwsqxtaft1sTzalmBc9IZilTv/PXP/ZpMxqo1yDQJDxfyQ6228DLgP2FuytHZslV59Sk/3tNUZ4Pwyhzc/jDaxMRfEDHN5EVn7k7TbZFZ77HsaCSs7aQuyLNopCAV2mR5YOamtATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626297; c=relaxed/simple;
	bh=bmx8pZ9qIvJRYqx+gkLKoots0PXirjgUXTNMBuAciuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTtR9igA8K09md+VS26pofqTSXphRG6/UmZSmIbRfGplmeErmEWSBZXl/O2BYdByahMtkk6r1BwWdS1TQT2NYUzk6Aq0ls86HZ4pARt2VVBKqrh5Ov+kmm6TYtHOWljm5HccUu2HzswkYZ2QjoOdh+Z0ItqCcgBH4N7BBTZ/gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fQs2L0MW9zYQv7X;
	Wed,  4 Mar 2026 20:10:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 91A8A40574;
	Wed,  4 Mar 2026 20:11:25 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDHFhVoIahpfHNjJQ--.1526S2;
	Wed, 04 Mar 2026 20:11:21 +0800 (CST)
Message-ID: <aa422869-0c20-4185-8791-4007ce01f60d@huaweicloud.com>
Date: Wed, 4 Mar 2026 20:11:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 0/5] emit ENDBR/BTI instructions for indirect
 jump targets
Content-Language: en-US
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
 <DGTAFQ1WX43H.2R6R1RS5F09Q7@bootlin.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <DGTAFQ1WX43H.2R6R1RS5F09Q7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHFhVoIahpfHNjJQ--.1526S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy7WF1fKFWUKFy5uF18uFg_yoW5AFyrpF
	48CF13Cr4v9r4xZF1Iqr47Cry3tw48Ww42grnFk3yfZF90va42qr4agw4fuFZ8ZrW8Ka45
	ZF4a9F90k34kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 3/4/2026 12:29 AM, Alexis Lothoré wrote:
> Hi Xu,
> 
> On Mon Mar 2, 2026 at 11:27 AM CET, Xu Kuohai wrote:
>> On x86 CPUs with CET/IBT and arm64 CPUs with BTI, missing landing pad instructions
>> at indirect jump targets triggers kernel panic. So emit ENDBR instructions for
>> indirect jump targets on x86 and BTI on arm64. Indirect jump targets are identified
>> based on the insn_aux_data created by the verifier.
>>
>> v5:
>> - Switch to pass env to JIT directly to get rid of coping private insn_aux_data for
>>    each prog
> 
> Nice, thanks for this. As discussed in [1], I'm planning to reuse this
> in my KASAN work to pass info to JIT comp about ldx/stx instructions
> (especially, whether those insn are accessing prog stack or elsewhere).
> So far I've been using a small POC aiming to do the same kind of thing,
> but your series made me aware of a few points I missed, like the offset
> induced by constant blinding. I'll keep my work rebased on top of your
> series, and track it until it is merged.
>

Glad to hear that. Thanks for letting me know.

> Thanks
> 
> Alexis
> 
> [1] https://lore.kernel.org/bpf/CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com/
> 
>> v4: https://lore.kernel.org/all/20260114093914.2403982-1-xukuohai@huaweicloud.com/
>> - Switch to the approach proposed by Eduard, using insn_aux_data to indentify indirect
>>    jump targets, and emit ENDBR on x86
>>
>> v3: https://lore.kernel.org/bpf/20251227081033.240336-1-xukuohai@huaweicloud.com/
>> - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov)
>>
>> v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicloud.com/
>> - Exclude instruction arrays not used for indirect jumps (Anton Protopopov)
>>
>> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
>>
>> Xu Kuohai (5):
>>    bpf: Move JIT for single-subprog programs to verifier
>>    bpf: Pass bpf_verifier_env to jit
>>    bpf: Add helper to detect indirect jump targets
>>    bpf, x86: Emit ENDBR for indirect jump targets
>>    bpf, arm64: Emit BTI for indirect jump target
>>
>>   arch/arc/net/bpf_jit_core.c      | 19 +++----
>>   arch/arm/net/bpf_jit_32.c        |  4 +-
>>   arch/arm64/net/bpf_jit_comp.c    | 21 ++++----
>>   arch/loongarch/net/bpf_jit.c     |  4 +-
>>   arch/mips/net/bpf_jit_comp.c     |  4 +-
>>   arch/parisc/net/bpf_jit_core.c   |  4 +-
>>   arch/powerpc/net/bpf_jit_comp.c  |  4 +-
>>   arch/riscv/net/bpf_jit_core.c    |  4 +-
>>   arch/s390/net/bpf_jit_comp.c     |  4 +-
>>   arch/sparc/net/bpf_jit_comp_64.c |  4 +-
>>   arch/x86/net/bpf_jit_comp.c      | 25 +++++----
>>   arch/x86/net/bpf_jit_comp32.c    |  4 +-
>>   include/linux/bpf.h              |  2 +
>>   include/linux/bpf_verifier.h     | 10 ++--
>>   include/linux/filter.h           |  6 ++-
>>   kernel/bpf/core.c                | 93 ++++++++++++++++++++++++--------
>>   kernel/bpf/syscall.c             |  2 +-
>>   kernel/bpf/verifier.c            | 22 ++++++--
>>   18 files changed, 157 insertions(+), 79 deletions(-)
> 
> 
> 
> 

