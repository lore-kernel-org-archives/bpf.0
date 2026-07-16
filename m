Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41E28C869;
	Thu, 16 Jul 2026 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186793; cv=none; b=q0UDmyOBjG9TLFKKhSu05t5hYt7fSHYSKZMIcmqp0+KZNzqnG1xRLrZry5J1HnBT5l9mya3DVaoAsURSpwtUOM9EOSb0SR7gqQ2nexNtM+mtgN2LIslMgGDiAVaAboxqT6MkfpddRUpR0xVR8qs2dqxiZPv0mLXqnmg09kikAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186793; c=relaxed/simple;
	bh=3OhdXQwxYuUOwNmPTHHmrYXkdBRV8xmSUY/IwcXh88A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naG7Xt+QewVx8dpc84rqd1Syf6Ijm6Q2p5nsyi51Vjqgt0XuOyMHnSqm7RMdiBwYtUn5IKxf73d7UI55r0Cg2MFQ4wJtnvL4HcUJkMNlIBZwEwApHXs9Cyz3NsGijaTFqcDu5oBoD1DAhrfirHLv6lXKK29hdkS4GPsWFxtG0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a447501880e711f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7685f8c4-8899-48d2-b484-b9d5d74bd90e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0d4e1e5c6215962a8491b5039acde1e8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a447501880e711f1aa26b74ffac11d73-20260716
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 620461011; Thu, 16 Jul 2026 15:26:20 +0800
Message-ID: <714418f3-03a8-40e7-81b7-68ca20a26437@kylinos.cn>
Date: Thu, 16 Jul 2026 15:26:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, riscv: fix missing extable entry for arena
 load_acquire
To: Pu Lehui <pulehui@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260716-bpf-riscv-fix-extable-v1-1-af023cc17af4@kylinos.cn>
 <ed7c71d1-f692-4a8f-954e-2d3ea9177c28@huawei.com>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <ed7c71d1-f692-4a8f-954e-2d3ea9177c28@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/16 15:01, Pu Lehui wrote:
> 
> On 2026/7/16 14:15, Feng Jiang wrote:
>> emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
>> a sub-word load_acquire. The caller does "ret = ret ?:
>> add_exception_handler(...)", which skips add_exception_handler() on any
>> non-zero ret, so the extable entry is missing and a faulting
>> PROBE_ATOMIC load_acquire oopses.
>>
>> Check ret >= 0 before calling add_exception_handler(), and return ret
>> unchanged so build_body() still skips the zext.
>>
>> Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> ---
>>   arch/riscv/net/bpf_jit_comp64.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index f9d5347ba966..4fd4392dd080 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1986,10 +1986,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>           else
>>               ret = emit_atomic_rmw(rd, rs, insn, ctx);
>>   -        ret = ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
>> -        if (ret)
>> -            return ret;
>> -        break;
>> +        /* ret can be 1 (skip-zext); extable entry still needs to be added */
>> +        if (ret >= 0) {
>> +            int err = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> 
> Thanks Feng Jiang. Maybe we could remove this additional variable.
> 
> ```
> /* ret can be 1 (skip-zext); extable entry still needs to be added */
> if (ret >= 0)
>   ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx) ?: ret;
> 
> if (ret)
>   return ret;
> 
> break;
> ```
> 

Thanks for the review! Your suggestion is indeed cleaner and more concise. I'll send v2 shortly.

> 
>> +
>> +            if (err)
>> +                return err;
>> +        }
>> +        return ret;
>>         default:
>>           pr_err("bpf-jit: unknown opcode %02x\n", code);
>>
>> ---
>> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
>> change-id: 20260716-bpf-riscv-fix-extable-399947ca778d
>>
>> Best regards,

-- 
With Best Regards,
Feng Jiang

