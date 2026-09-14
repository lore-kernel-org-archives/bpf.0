Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4F40F73E
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375022; cv=none; b=EwyI9QmF6N5DC+EIY6nkbTcnvr45ed5wziICQvA92GZSb0P7HWcNKrmMFWfFkeVL2jVsmLdCvHaCDaf2dl4n5O82Gxq78BI1LydkOInBjuN648n62y3O9nMi0IMQrBpZrz1GlbJ0H8W2HO59MqLlrbnvQbI+lUNcaXesL1NIGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375022; c=relaxed/simple;
	bh=r6jG+BRZdPwCvdmoEsdD2MJ2vzs1cbI8bVA6idcaEcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHmSyMlTwod4E/GwivCWYb0+hnZTdxoocvnEKMCbbmw0kBC8CG1c2pkn+0LhScQirXIGDTatZFlnIzreafsFNbAt0XYx3aM5d7UnWDFIYGHkqIaNMZdGDZBpd6NBRtBDbY4hlFuFmKRUAMa4PugGuNOB/zYYyJLPzPgqtjBFG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wC3oH4WsqdqVW8SAQ--.24475S3;
	Mon, 14 Sep 2026 16:36:39 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app2 (Coremail) with SMTP id zC_KCgAHdssWsqdqvKd4BA--.1316S3;
	Mon, 14 Sep 2026 16:36:38 +0800 (CST)
Message-ID: <4147c261-7518-4700-9ca5-12c020256aca@zju.edu.cn>
Date: Mon, 14 Sep 2026 16:36:38 +0800
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
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DLD0Y0CFA97S.3RC5RTORRYY9N@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgAHdssWsqdqvKd4BA--.1316S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBg8OCmqm-JomtAAAs1
X-CM-DELIVERINFO: =?B?9SFa2AXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ek0blBrQqP2+PpkNd6puXfq0G+hAq58XDRoZH7REeIeZACzz9Mdzq0RrKII+FAL4vwH
	wr350ktVPR8BbB/ao4yLsimcoEnDzLo+HJdI+o1EkJR0A9EIzsdgZ53ftirYWA==
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw48KFWfuF13Xw4xurWkKrX_yoW8tw4xpr
	4Dta4UtFWDK3yj9Fy8tw4DGF1YyFn3ta1UXF98Xw1UAF9IqF1FqF4jyw4YgFZ3GF4xuF12
	qrZ0qa47Z3yUCabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGO
	UUUUU



On 9/12/26 11:40 AM, Alexei Starovoitov wrote:
> On Tue Sep 8, 2026 at 1:30 AM PDT, Yazhou Tang wrote:
>>
>>
>> On 9/8/26 3:51 AM, Alexei Starovoitov wrote:
>>> On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
>>>> From: Tianci Cao <ziye@zju.edu.cn>
>>>>
>>>> Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by insn->off.
>>>> UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product, while
>>>> SHMUL returns the high 64 bits of a signed product. Keep off == 0 as the
>>>> existing low-half multiplication, and assign off == 1 and off == 2 to
>>>> UHMUL and SHMUL, respectively.
>>>>
>>>> These operations are inspired by the UHMUL and SHMUL instructions
>>>> introduced as part of the PQR instruction class in Solana sBPF[1].
>>>>
>>>> The encoding and immediate semantics differ from current sBPF.
>>>>
>>>> 1. Solana sBPF assigns these operations dedicated opcodes in the BPF_PQR
>>>>      class, whereas this implementation selects them through the offset
>>>>      field of BPF_MUL.
>>>>
>>>> 2. Solana sBPF initially sign-extended the immediate operand of UHMUL,
>>>>      but later changed unsigned PQR immediates, including UHMUL, to be
>>>>      zero-extended[2].
>>>
>>> Why did you switch to zero-extend ?
>>> Sounds odd to do zero extend just for these ops.
>>
>> Sorry, I wasn't clear. This patch does not zero-extend the UHMUL immediate.
>>
>> Both UHMUL and SHMUL follow the existing BPF_ALU64 convention and
>> sign-extend the 32-bit immediate to 64 bits first. The zero-extension
>> I mentioned refers only to current Solana sBPF behavior. I'll clarify
>> this in the respin.
> 
> My question was "why in Solana you switched to zero-extend?"

I wasn't involved in that Solana change.

https://github.com/solana-labs/rbpf/pull/642

In Solana BPF, PQR is a separate instruction class for product, quotient,
and remainder operations. PR #642 mentioned above changed the treatment of
32-bit immediates for all three 64-bit unsigned PQR operations (UHMUL,
UDIV, and UREM) from sign-extension to zero-extension. This appears to
have been a broader convention change for unsigned PQR operations, rather
than something specific to UHMUL.

I couldn't find the design reason documented in the PR, though. I'll try
to ask the author about it.

