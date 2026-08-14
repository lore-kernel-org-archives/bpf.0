Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04173E3DAB
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691129; cv=none; b=TiEzqTTRqh1JIk9QWa6u2mwztB42Tm6a9bSl18awuFhyg/2P012c6X50iV1sZYNRkKpNRudgY09cCvb7gvdyajB+3G1ZSjTOtzu30d2LVli0OnL5UJBamno/z4wsAwhuImEluFox7PFVg5dw63t/m8hOVTFi01uS4XuBhZUZtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691129; c=relaxed/simple;
	bh=aIBBGo7/6I5alDH3NE0hq5kKZwwxoJH+F8QbAtOfFWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rXFKf52lr2Lp6vR8jYNnSQhSVp/EJPPkWNOVVt2daly/4fAZZqpOC0tx19QyIuJZXlBgI7M4I8c3uMVhAoTuV9C/Xgyd6Zkdb8II8LY8Okhk+SQZ11H/KQ04kTHc5yOA3hMV+1VVPxwLE6Gf5dCSP1eQDhDVpkefrvMHtGlaPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WU02/kGY; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WU02/kGY; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WU02/kGY";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WU02/kGY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=y0Uf0XX1APdX7Q2hkkHKB9cUIHVfZJeabZoHcsm/gUw=;
	b=WU02/kGYziPDzmuFWIZQJVLn6sSNr/ahg2T6yjApwn4iGdUPRfR5MCCQvVex7om9X5IxV3XSS
	JxI8CVcvLqf3c6B6z34QBz8DLDwHr2bM7kzejltbaZCTQMxLN7uskwm4p+w966na+/lYjMpc79e
	ZPuAnrJNMQudOVy++f8AHo8=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hLtWy0dcvz126Lth
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:04:46 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=y0Uf0XX1APdX7Q2hkkHKB9cUIHVfZJeabZoHcsm/gUw=;
	b=WU02/kGYziPDzmuFWIZQJVLn6sSNr/ahg2T6yjApwn4iGdUPRfR5MCCQvVex7om9X5IxV3XSS
	JxI8CVcvLqf3c6B6z34QBz8DLDwHr2bM7kzejltbaZCTQMxLN7uskwm4p+w966na+/lYjMpc79e
	ZPuAnrJNMQudOVy++f8AHo8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hLtJ226S8zmVY2;
	Fri, 14 Aug 2026 14:54:26 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 8284240586;
	Fri, 14 Aug 2026 15:05:04 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 14 Aug
 2026 15:05:04 +0800
Message-ID: <676c2841-8d29-412a-8003-464e59a249e1@huawei.com>
Date: Fri, 14 Aug 2026 15:05:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed
 1-byte and 2-byte kfunc args
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, Pu Lehui <pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>
References: <20260814064726.3607615-1-pulehui@huaweicloud.com>
 <20260814065737.D1B361F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260814065737.D1B361F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/14 14:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch introduces a call to a `sign_extend()` function that is undeclared and undefined, resulting in a compilation failure.
> --
> 
> --- Patch [1]: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args ---
> commit 47567ad8c96e02d677f1ae5123565efa9cf1b55f
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args
> 
> This commit updates the RISC-V BPF JIT to sign-extend 1-byte and 2-byte
> kfunc arguments as required by the RV64 ABI. This addresses an issue exposed
> by recent state pruning liveness analysis changes.
> 
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 10e01ff06312d..0c6de02eb33a8 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1784,9 +1784,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   
>>   			for (idx = 0; idx < fm->nr_args; idx++) {
>>   				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
>> +				bool sign = fm->arg_flags[idx] & BTF_FMODEL_SIGNED_ARG;
>>   
>> -				if (fm->arg_size[idx] == sizeof(int))
>> -					emit_sextw(reg, reg, ctx);
>> +				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
>> +					return -EINVAL;
> 
> [Severity: Low]
> Is sign_extend() declared in this context?

No, sign_extend() has been add by commit fd2e08128944a("riscv, bpf: Sign 
extend struct ops return values properly"), and there is no building 
failure.

> 
> It appears this function might be missing from this file or requires an
> unapplied prerequisite patch. Looking through the source, there doesn't
> appear to be a sign_extend() function defined in the RISC-V BPF JIT code
> that matches this 5-argument signature. Will this cause a build failure due
> to an undeclared function?
> 
>>   			}
>>   		}
>>
> 
