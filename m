Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0F37AA94;
	Tue, 16 Jun 2026 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574094; cv=none; b=PjiQx5NwUFP7eEtWuX7U1CP95dALicGdyaeuJ019QjetaQIjcYVnc5wiwdz49nmbBW+JRw0OeHiJiS2E9KK2ktgst5+3eHFClt9cPBMy/+8p87Zl3zqIQUKhkijPJNgGxKZobt0k+atEiUW86mc59W8P3BZlHWJwF3T/oYW+biI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574094; c=relaxed/simple;
	bh=AHxawmRiBCIKc3s43aVtrhuIkD9XvPkxFBysIIrVzdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JGofhs9b570ZD6wwxPyeCHpbZTFATDdiH/0s9WVG6x4TdlshDYNTdOLu6fNu0eD0obPQWCGiRfT4vEAlhN8wmKhDG2Gh+GxbblWJ6B6juWkoxk/4sirQgMtvmVV3nMZmbgWhcyMM4VjA6ECu9FYp46WmFgTd9PJm3VvATSrT5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=E9E2RAsa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="E9E2RAsa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wsOFNkJBmgV+d21//gqWitPG9/QNviG/zuToqCNtEVM=;
	b=E9E2RAsaJ94APIHxGlkEkQt88JFU0JVTVH93EDXbzItkhDgzOJiw8t82twD0tOvOt8qPc3TqM
	MXrR8xwV+A1BBreYcFNG7+9MW8CQtsbjLFV3Tr8r1OR/ZZbEHzea76B977JaYxh4fijaWo526m+
	Hh8/Zior8DUaB+ls431ixjY=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gfTyt1wpDz1cyt0;
	Tue, 16 Jun 2026 09:33:26 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id C0F25405D0;
	Tue, 16 Jun 2026 09:41:22 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Jun
 2026 09:41:21 +0800
Message-ID: <216ee1df-2945-4266-9c70-ebcd36faeb7f@huawei.com>
Date: Tue, 16 Jun 2026 09:41:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/3] riscv, bpf: Fix signed operations and add
 32 bit atomics
Content-Language: en-US
To: Kuan-Wei Chiu <visitorckw@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <luke.r.nels@gmail.com>, <xi.wang@gmail.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <alex@ghiti.fr>, <jserv@ccns.ncku.edu.tw>,
	<eleanor15x@gmail.com>, <marscheng@google.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
 <ajAlwK990NFUAMwq@google.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <ajAlwK990NFUAMwq@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/6/16 0:18, Kuan-Wei Chiu wrote:
> Hi,
> 
> On Mon, May 11, 2026 at 10:16:45PM +0000, Kuan-Wei Chiu wrote:
>> Fix miscompiled signed operations and expands 32 bit atomic support in
>> the RV32 BPF JIT.
>>
>> The current implementation ignores the instruction offset field used by
>> the bpf instruction set to specify BPF_SDIV/BPF_SMOD and BPF_MOVSX.
>> This causes these operations to be treated as unsigned or
>> zero-extended, leading to test_bpf failures. Fix this by checking the
>> offset and emitting the correct instructions.
>>
>> Additionally, we leverage the mandatory A extension to natively support
>> 32 bit bpf atomics (and, or, xor, xchg) by mapping them directly to
>> amo*.w instructions. BPF_CMPXCHG continues to fall back to the
>> interpreter.
>>
>> As a result, test_bpf.ko now runs with 0 failures, and the total number
>> of successfully JIT'ed test cases increases from 843 to 902.
> 
> Is there anything else I need to do for this patchset to land?

Hi Kuan-wei, it seems Luke and Xi haven't been as active in the 
community for a while, I'll make time to cover the review and testing 
for this.

Regards,
Lehui

> 
> Regards,
> Kuan-wei
> 
>> ---
>> - Add missing Fixes tags.
>> - Fix memory ordering by emitting aq=1, rl=1
>>
>> Kuan-Wei Chiu (3):
>>    riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
>>    riscv, bpf: Fix support for BPF_MOVSX in RV32 JIT
>>    riscv, bpf: Add 32 bit atomic operations to RV32 JIT
>>
>>   arch/riscv/net/bpf_jit_comp32.c | 101 +++++++++++++++++++++++++++-----
>>   1 file changed, 85 insertions(+), 16 deletions(-)
>>
>> -- 
>> 2.54.0.563.g4f69b47b94-goog
>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
