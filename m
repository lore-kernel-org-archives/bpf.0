Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B24C78F4A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604295; cv=none; b=ki00a+/5xkKSP0lHieFkphYzuIeu99OJFBMCVLNBhwraivQGD2h1rrgR1fQv9NiGBmBQ55d4FOiFI2NHsVGKVBXcuJrDh8oFaBEjIKJ2QEhgcTEjfFjp+OENXE3TBRsgvb6mHt20ZEoWOeLCQYmh2Vit3FC3wJaO6KcuPztAfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604295; c=relaxed/simple;
	bh=OSpiNwpJDeM4AcUNYHku5fBPQDHNh9uD8XT7M0lVMRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cX/P52fK4s2R9QvJCutBbAohWBAHlh/v2cJ8OsRLilxk6vYV1MBt8cwUpeVuzeSlbw2PPzPGQOCExKQieUDNFyqgh/h7hFEHXZ7hPRgbFS9yTfp/TP7EPwUgpSkE/60BBTYN1K7pUhDnuqBFlrsigBei416o2lYLjBJXNbtPPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.75])
	by mtasvr (Coremail) with SMTP id _____wDnOLDRT8ZptCMRAA--.1290S3;
	Fri, 27 Mar 2026 17:37:22 +0800 (CST)
Received: from [0.0.0.0] (unknown [115.236.2.75])
	by mail-app3 (Coremail) with SMTP id zS_KCgBHMnfFT8Zpm2IjAA--.46072S3;
	Fri, 27 Mar 2026 17:37:10 +0800 (CST)
Message-ID: <9a61d64e-7943-4e39-8c82-c79bb9ac65b4@zju.edu.cn>
Date: Fri, 27 Mar 2026 17:37:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 1/3] bpf: Reject bpf-to-bpf call with large offset
 in interpreter
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-2-tangyazhou@zju.edu.cn>
 <319906e9-3b47-472f-9a11-a0da60626144@huaweicloud.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <319906e9-3b47-472f-9a11-a0da60626144@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBHMnfFT8Zpm2IjAA--.46072S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgADCmnFjAspIwAAsq
X-CM-DELIVERINFO: =?B?xaO9awXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9OBCyAu4//tBYspsrrrqb5+QnwRYdX8k3V08FC5kVtFuKsrr5t6vLxvTJj5KcKqoA0Xi
	5Oy8wbgHUJkVtm1ArGTMpHxCtqOVjGxHDQlmVqntPJgV6uxzH6bbvNX6ZfOgiw==
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyDXr17JryDCr4UKr4xZrc_yoW8Jw4kpF
	WkWa4jyw1DA3y3K397Zw18Aw1Ygrs2ya15CFW5GryfAr43GF1ayF15KFZYvFy2krsrCr1j
	qFWjvw1kAa4qkacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Hi Kuohai,

On 3/26/26 21:45, Xu Kuohai wrote:
> Maybe I’m missing something, but since interpreters_args is a small 
> array, why not
> just store the index (round_up(stack_depth, 32) / 32) - 1 in insn->off?
> 
> That way, the interpreter could directly use this index to find the 
> function address,
> without needing insn->imm to record the address offset, thus avoiding 
> the need to use
> another field like insn->off in the instruction to back up the original 
> insn->imm.

Thanks for the suggestion! Conceptually, storing the array index in 
insn->off and keeping the 32-bits insn->imm unchanged is a very elegant 
way to solve this problem.
But I think it will introduce a performance regression in the 
interpreter's hot path (___bpf_prog_run).

Currently, the array lookup is done once during verification. The 
resulting offset is stored in insn->imm, allowing the runtime to use a 
fast ALU addition: __bpf_call_base_args + insn->imm.

However, If we store the index in insn->off instead, we force the 
runtime to perform a memory load (interpreters_args[insn->off]) on every 
single bpf-to-bpf call.

Because of this overhead, rejecting out-of-bounds offsets at load time 
with -EINVAL (as done in v5) seems to be the safer and more performant 
trade-off.

What are your thoughts on this?

Best,
Yazhou

