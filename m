Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [40.65.178.148])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191F364052
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=40.65.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336577; cv=none; b=HdPZvh+8BLe8oZbnoL2t9Du7MXs8tZWV7bawvyKyoCTlOsZNrpjzYBgIW4uH0WM8QH4XAhiSxkSH69ar35ebTReTwEdRWXZVUjwV3Xs4npAVaU1WGRFeMAH3c4GX6evjCp01z2KRWN2pXq4vWwmMO+Ko21zY0ud6i5cKkCfCmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336577; c=relaxed/simple;
	bh=9XMfAD2yuQTfp1MPkL3pLSz4mluqi45jz4nwjR/4VMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhMga/4id7Jy85rDF0aJ7NLk5+VsTyX7r5bwULdfKlCQw4hkSop0PYdHVCwClKOjWUo2fyChD8YdnaAw0b6XOc27dElZgNps/BufB0BkctI+bEuXDNb5P0tgjUurmofMKJlgsKQk2ERWVeMlcOGwpINDZq6rpq1v2P9Zv5stbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=40.65.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wAH4X222ZdqTFjjAA--.35110S3;
	Wed, 02 Sep 2026 16:09:27 +0800 (CST)
Received: from [192.168.2.114] (unknown [10.14.28.207])
	by mail-app4 (Coremail) with SMTP id zi_KCgBnmjG22ZdqeFWOAw--.61813S3;
	Wed, 02 Sep 2026 16:09:26 +0800 (CST)
Message-ID: <d53e56b4-1183-4efe-891a-e301c7e315d1@zju.edu.cn>
Date: Wed, 2 Sep 2026 16:09:25 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 3/6] bpf: Reject UHMUL/SHMUL in unsupported
 JITs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-4-tangyazhou@zju.edu.cn>
 <20260902072110.3C5851F000E9@smtp.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <20260902072110.3C5851F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zi_KCgBnmjG22ZdqeFWOAw--.61813S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgUCCmqXKpkdQwAAsb
X-CM-DELIVERINFO: =?B?4mjsswXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BOublG3SAcsduZqn8TTFhlsSWPYJe/V7xxOxkw8ph17heSpOU/gp+Z1CuS2hpE+hqSY
	mPX6UoI5k4/AqJi0CfzRRx9LepSHS0JHYd57yBetHyo4xHEvsd4yMTHDVYpTAg==
X-Coremail-Antispam: 1Uk129KBj93XoWxurykKw1UAry5ZrWxXw4rXrc_yoW5ZrykpF
	Z5Aa43AFykXrZ7ur18t3yjgw1aqr40gF4UJa4UKrW5AanIqrnayF18Ka1j9F98Ar15ZF1j
	qFWY9rnFvas7ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==



On 9/2/26 3:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The PowerPC JIT backends check the first instruction of the program instead of the current instruction when rejecting UHMUL/SHMUL.
> --
> 
> commit 1bfedfff9f6c73dc718b4f4866c0696e836592cb
> Author: Yazhou Tang <tangyazhou518@outlook.com>
> 
> bpf: Reject UHMUL/SHMUL in unsupported JITs
> 
> CPU JIT backends currently lower BPF_MUL based on the opcode without
> examining insn->off. Once the verifier accepts UHMUL and SHMUL, a backend
> without explicit support would therefore lower either variant as the
> existing low-half multiplication and silently produce the wrong result.
> 
>> diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
>> index bfdc50740da8e..b578b19017b22 100644
>> --- a/arch/powerpc/net/bpf_jit_comp32.c
>> +++ b/arch/powerpc/net/bpf_jit_comp32.c
>> @@ -349,6 +349,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>>   		u32 true_cond;
>>   		u32 tmp_idx;
>>   
>> +		if (bpf_insn_is_hmul(insn))
>> +			return -EOPNOTSUPP;
>> +
> 
> [Severity: High]
> Does this code check the correct instruction? In bpf_jit_build_body(),
> insn points to the first instruction of the program (fp->insnsi), and
> the loop uses the index i. By calling bpf_insn_is_hmul(insn) instead of
> bpf_insn_is_hmul(&insn[i]), the check only ever looks at the 0-th
> instruction of the program.

Thanks for catching this. I overlooked that the PowerPC JIT keeps insn
pointing at fp->insnsi and uses i to select the current instruction,
whereas the other modified JITs use insn to refer to the current instruction.

Both PowerPC checks should use &insn[i]. I will fix them in the next revision.

> 
> If an unsupported UHMUL or SHMUL instruction occurs anywhere other than the
> very first instruction, it will not be rejected and will instead be compiled
> silently as a standard lower-half multiplication.
> 
>>   		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
>>   		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
>>   		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
> 
> [ ... ]
> 
>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
>> index fc9db691e8203..4ef0f3cffe848 100644
>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>> @@ -992,6 +992,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>>   		u32 tmp_idx;
>>   		u32 jmp_off;
>>   
>> +		if (bpf_insn_is_hmul(insn))
>> +			return -EOPNOTSUPP;
>> +
> 
> [Severity: High]
> Similarly, does this code check the correct instruction for the 64-bit JIT?
> It appears to check the first instruction instead of &insn[i], which will
> cause the same silent incorrect compilation for unsupported UHMUL/SHMUL
> instructions not located at the first position in the program.
> 
>>   		/*
>>   		 * addrs[] maps a BPF bytecode address into a real offset from
>>   		 * the start of the body code.
> 

