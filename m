Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379864A6CD3
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472964; cv=none; b=Rg2NpCaWpgNqcU517kavROklSnoYDpXB0DA2P7ny9xwm+PvIvq+dCQlDhEZIJStmw1/KyM0bkoEO+DuVHb2oYEU/G7WNq7U5YEoolygiv1PkoecM+hnH+14UJ+z/ffQVF+jp9WJFGytJlUraj8e54jhogRPdN4w3SrpbMRJlWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472964; c=relaxed/simple;
	bh=pmnZdmBkrY6MTJfCk6ExMXAB7WE+ROCyypKDXNVw8Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBfGGTiwZl5uji7zM9rU/xUzTYD6nydgO8OEKQf5BFCBOTltGuvPRjYdq6TtIc9nYoOR5xlGDCDSSdM0wNhli8AHsJdDNCtL/J853GhMmyzIbR+011jCS253koLN8mY060/7SzGzVgfTwV25DinTcutFb0NtKLHDUA2dj98mT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.195.234.248])
	by mtasvr (Coremail) with SMTP id _____wDXwH6iMKlqftsWAQ--.2146S3;
	Tue, 15 Sep 2026 19:48:51 +0800 (CST)
Received: from [10.195.234.248] (unknown [10.195.234.248])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXhsuiMKlq0PJ8BA--.8795S3;
	Tue, 15 Sep 2026 19:48:50 +0800 (CST)
Message-ID: <59e754a2-6158-485c-93b9-6f60d9f57528@zju.edu.cn>
Date: Tue, 15 Sep 2026 19:48:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add UHMUL and SHMUL instructions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, eddyz87@gmail.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-2-tangyazhou@zju.edu.cn>
 <DL9CGP0NFZ37.25Y31VZH6PKPQ@gmail.com>
 <94eba3a8-6bca-432b-859b-d14e608d34f2@zju.edu.cn>
 <DLD0Y0CFA97S.3RC5RTORRYY9N@gmail.com>
 <4147c261-7518-4700-9ca5-12c020256aca@zju.edu.cn>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <4147c261-7518-4700-9ca5-12c020256aca@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXhsuiMKlq0PJ8BA--.8795S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgcPCmqoTho1XwAAs8
X-CM-DELIVERINFO: =?B?mIatEAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9L4pm5+/qViLdx8+gA4Ezj/dw49NZYBqH18vEIU7JHdrOuIqg7lTPvyD6LcRysUN3I+Z
	gBWaf/9ZhuekqXAZ5/TwuOthjJe6xMoPe7/1vt1qpbhjFb9P+imq6hPe7qncHg==
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy7JrWkWw17Cr1DZw4DZFc_yoWrJFW8pr
	4DK3W5KFWkGryUC348Kw4UGr1Yk3Wfta18XFyDXw1UAF9IgFyFqF42yw4Y9a98Gr4fuF12
	vrZ0qa47Zw4UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13r
	cDUUUUU==



On 9/14/26 16:36, Yazhou Tang wrote:
> 
> 
> On 9/12/26 11:40 AM, Alexei Starovoitov wrote:
>> On Tue Sep 8, 2026 at 1:30 AM PDT, Yazhou Tang wrote:
>>>
>>>
>>> On 9/8/26 3:51 AM, Alexei Starovoitov wrote:
>>>> On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
>>>>> From: Tianci Cao <ziye@zju.edu.cn>
>>>>>
>>>>> Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by insn->off.
>>>>> UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product, while
>>>>> SHMUL returns the high 64 bits of a signed product. Keep off == 0 as the
>>>>> existing low-half multiplication, and assign off == 1 and off == 2 to
>>>>> UHMUL and SHMUL, respectively.
>>>>>
>>>>> These operations are inspired by the UHMUL and SHMUL instructions
>>>>> introduced as part of the PQR instruction class in Solana sBPF[1].
>>>>>
>>>>> The encoding and immediate semantics differ from current sBPF.
>>>>>
>>>>> 1. Solana sBPF assigns these operations dedicated opcodes in the BPF_PQR
>>>>>      class, whereas this implementation selects them through the offset
>>>>>      field of BPF_MUL.
>>>>>
>>>>> 2. Solana sBPF initially sign-extended the immediate operand of UHMUL,
>>>>>      but later changed unsigned PQR immediates, including UHMUL, to be
>>>>>      zero-extended[2].
>>>>
>>>> Why did you switch to zero-extend ?
>>>> Sounds odd to do zero extend just for these ops.
>>>
>>> Sorry, I wasn't clear. This patch does not zero-extend the UHMUL immediate.
>>>
>>> Both UHMUL and SHMUL follow the existing BPF_ALU64 convention and
>>> sign-extend the 32-bit immediate to 64 bits first. The zero-extension
>>> I mentioned refers only to current Solana sBPF behavior. I'll clarify
>>> this in the respin.
>>
>> My question was "why in Solana you switched to zero-extend?"
> 
> I wasn't involved in that Solana change.
> 
> https://github.com/solana-labs/rbpf/pull/642
> 
> In Solana BPF, PQR is a separate instruction class for product, quotient,
> and remainder operations. PR #642 mentioned above changed the treatment of
> 32-bit immediates for all three 64-bit unsigned PQR operations (UHMUL,
> UDIV, and UREM) from sign-extension to zero-extension. This appears to
> have been a broader convention change for unsigned PQR operations, rather
> than something specific to UHMUL.
> 
> I couldn't find the design reason documented in the PR, though. I'll try
> to ask the author about it.

I asked Alexander Meißner, the author of the Solana BPF change. He confirmed
that zero-extension was an intentional ISA design choice rather than a fix
for a particular compatibility issue.

He gave two main reasons.

1. First, for explicitly unsigned instructions such as UHMUL/UDIV/UREM,
treating the 32-bit immediate as an unsigned value was considered more
intuitive. For example, with an encoded immediate of 0xffffffff, zero-
extension gives 0x00000000ffffffff (2^32 - 1), while sign-extension gives
0xffffffffffffffff (2^64 - 1). Similarly, 0x80000000 becomes 2^31 with
zero-extension, rather than 2^64 - 2^31 with sign-extension.

2. Second, zero-extension gives the continuous unsigned range [0, 2^32 - 1].
With sign-extension, the upper half of the immediate encoding instead
represents values in [2^64 - 2^31, 2^64 - 1], while values in [2^31, 2^32 - 1]
cannot be represented directly. The Solana BPF design considered the range
provided by zero-extension more useful for unsigned operations.

For Linux, given that the existing ALU64 UDIV/UMOD instructions with
immediate operands sign-extend the 32-bit immediate to 64 bits and then
use the resulting value as an unsigned operand, I'm inclined to do the
same for UHMUL for consistency.

