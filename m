Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBE3DAADD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627417; cv=none; b=CrHYJqoPKuz4hD0zAQgDaQUEkompt4x7o7oWCHOWbdQvN2QO/fCVyoZPB9VCAz8OZ7MGi3RphNeaJuu825TAwG+eVs769aVPkgtOZ68x921g+d+XgaV1y/koVFYn7sm1e91XFCHyiL4lz3VF6fV7n7WF0xNSeEd5tIV9F9EWOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627417; c=relaxed/simple;
	bh=8Ub6FpYRKOhgDj3hXcd9jxmSBowsh6/ZAdELbfVUjKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4T3BQfDFdHFF/hxthnbGOnnNPl3qYCZbjYkLJ1+Xd5BfiMkMU3j+YGVPgwKN1hHgSmH6bDXbZ65jQGDul3AiZoBgprsiYPTdmYYUzjuikpI4fRP+ZLN5YScB4rnqxOk9H8+flOZtDU1PPN7muR2JS5Wvd7aWrt7y80cp8sDkhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wA3EX4JjKtq6HkdAQ--.4680S3;
	Thu, 17 Sep 2026 14:43:22 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3gXUIjKtqers3BQ--.29166S3;
	Thu, 17 Sep 2026 14:43:20 +0800 (CST)
Message-ID: <9e77473f-780a-4c31-80ae-8daaad454dfc@zju.edu.cn>
Date: Thu, 17 Sep 2026 14:43:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/8] bpf: Add UHMUL and SHMUL instructions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260917041712.1860722-2-tangyazhou@zju.edu.cn>
 <e6055fb14ceaf6cb1578d60e528708850341b4962410a9fb6dc5f5be9313241f@mail.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <e6055fb14ceaf6cb1578d60e528708850341b4962410a9fb6dc5f5be9313241f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zS_KCgC3gXUIjKtqers3BQ--.29166S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBg0RCmqq8RoeIgAAsH
X-CM-DELIVERINFO: =?B?KeymVQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9GxLxvAeMBU+Ym3E6JPordSWweFkgIP8laGwsxvzqQBq3FB9QtsYQGdoUALgI2j1C+GQ
	ds31XzO2jjDj/OdFQR1rPzNbSP3GnNB4SVTwJqfG/K6+Jg4LBDMdByYhgKVCcQ==
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw4rZF1UArWDtrWkGFy3Awc_yoW7GFy8pF
	Z7J3WUKFZFqr1rWan7Aw4qga4S9an3GrWUGF15G34rAr9xKw1xtF4xtw45tFy3JrZ7ZFWj
	qryYya4UZFyjv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8bd
	bUUUUUU==



On 9/17/26 1:22 PM, bot+bpf-ci@kernel.org wrote:
>> These operations are inspired by the UHMUL and SHMUL instructions introduced
>> as part of the PQR instruction class in sBPF sBPF (Solana's BPF variant)[1].
> 
> Could you drop the duplicated "sBPF" here? It reads as "... in sBPF sBPF
> (Solana's BPF variant)" which appears to be a copy-paste error.

Sorry, this is a typo. I'll fix it in the next version.

> 
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
>> index 39c74611752b6..3c2cde11fa234 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -330,6 +330,8 @@ register.
>>     ADD    0x0    0        dst += src
>>     SUB    0x1    0        dst -= src
>>     MUL    0x2    0        dst \*= src
>> +  UHMUL  0x2    1        unsigned high-half multiplication (``ALU64`` only)
>> +  SHMUL  0x2    2        signed high-half multiplication (``ALU64`` only)
>>     DIV    0x3    0        dst = (src != 0) ? (dst / src) : 0
> 
> [ ... ]
> 
>> @@ -379,13 +381,33 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
>>
>>     dst = dst ^ imm
>>
>> -Note that most arithmetic instructions have 'offset' set to 0. Only three instructions
>> -(``SDIV``, ``SMOD``, ``MOVSX``) have a non-zero 'offset'.
>> +Note that most arithmetic instructions have 'offset' set to 0. The following
>> +instructions may have a non-zero 'offset':
>> +
>> +* ``SDIV`` and ``SMOD``: ``offset == 1`` selects the signed variant.
>> +* ``MOVSX``: ``offset`` selects the source operand width.
>> +* ``MUL``: ``offset`` selects the multiplication variant (see below).
>>
>>   Division, multiplication, and modulo operations for ``ALU`` are part
>>   of the "divmul32" conformance group, and division, multiplication, and
>>   modulo operations for ``ALU64`` are part of the "divmul64" conformance
>>   group.
>> +
>> +For ``ALU64`` multiplication, ``offset == 1`` selects unsigned
>> +high-half multiplication (``UHMUL``), and ``offset == 2`` selects
>> +signed high-half multiplication (``SHMUL``).
> 
> Does this addition silently make UHMUL and SHMUL mandatory members of the
> existing divmul64 conformance group? The document's own rules at lines
> 123-125 state that "supporting a conformance group means it MUST support
> all instructions in that conformance group", and the unchanged sentence
> above says "division, multiplication, and modulo operations for ALU64 are
> part of the divmul64 conformance group."
> 
> UHMUL and SHMUL are ALU64 multiplication operations, so by that classifying
> sentence they become members of divmul64. Because group membership is
> defined as MUST-support, every runtime that currently advertises divmul64
> conformance (rbpf, uBPF, the Windows eBPF runtime, and any other
> implementation tracking RFC 9669) would become non-conformant the moment
> this text lands, even though their code has not changed.
> 
> The classification is also internally ambiguous. The document states at
> line 320 that "ALU64 instructions belong to the base64 conformance group
> unless noted otherwise", at line 136 that "base32 includes all instructions
> defined in this specification unless otherwise noted", yet the two new rows
> carry no group note at all - only a parenthetical "(ALU64 only)". A reader
> can arrive at base32, base64, or divmul64 for the same two instructions.
> 
> The expected pattern for new optional instructions in this document is a
> new group with its own label (compare "atomic32"/"atomic64" and
> "divmul32"/"divmul64", each introduced as its own bullet at lines 141-147).
> The patch adds neither a new bullet nor a note on the new rows, and the
> changelog does not mention conformance groups at all.
> 
> Shouldn't UHMUL and SHMUL either be assigned to a new conformance group
> (for example, "hmul64"), or carry an explicit note that they are not part
> of divmul64? The existing conformance framework was designed for capability
> discovery between runtimes and tool chains - growing an existing group
> without notice breaks exactly that contract.

I agree that silently extending an existing conformance group could be
problematic.

My initial thought was that UHMUL and SHMUL naturally belong to "divmul64",
since they are 64-bit multiplication operations. However, I just realized
that RFC 9669 also says that new instructions should not be added to an
already registered conformance group.

I'm not very familiar with the conformance-group conventions here, so I'd
appreciate suggestions from people who are more familiar with this part of
the specification. Would a separate group such as "hmul64", or a new group
that extends "divmul64", be more appropriate here?

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35182532243

