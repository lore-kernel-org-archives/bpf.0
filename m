Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71928852E;
	Fri, 17 Jul 2026 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784255664; cv=none; b=RFKuuEdgRCmERlR0FiykdJXCv7gy0bKtpOMWfvdZf9gv5omiyBxVIO1ZRkqDLXK3TqntQb63OTFydVxJQwWg83NY5EDVYi5qp167h9u4PM9aUOSEFnau75UoV4xuUvOt2lRX7T1uNK4NLmCGARVXUujLTVrFf32YQEtPTg1fy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784255664; c=relaxed/simple;
	bh=3pGWHh6GaClJzNMeJXFhyrToz1++RraSMW/oWMC35zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwaiM0KGPkywcFVwTQ5lD9sZ27jROeyYWT25qPIHxVADhCUQfyw78O0RtAMrykBWPo/p+QRBKdwA3LE6X+vR0JjoWbIK4qDfOpeG+6hEDXEVR207ZQgL7Py5BbJVgsKwIf/4R0u05nXGnPwEVVHIGz3qbXSU4Z4KWfzQzyuG/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fc8feb72818711f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:010ad878-b273-422c-9786-f0f4305f756d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c699595e90fe9c06c531f61dfbb4aa92,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fc8feb72818711f1aa26b74ffac11d73-20260717
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1977151119; Fri, 17 Jul 2026 10:34:08 +0800
Message-ID: <793cc487-3607-4b4d-bdfd-5c4599366e28@kylinos.cn>
Date: Fri, 17 Jul 2026 10:34:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf, riscv: fix missing extable entry for arena
 load_acquire
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Pu Lehui <pulehui@huawei.com>,
 Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
 <87wluvuy3b.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <87wluvuy3b.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/16 16:40, Björn Töpel wrote:
> Feng Jiang <jiangfeng@kylinos.cn> writes:
> 
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
>> Suggested-by: Pu Lehui <pulehui@huawei.com>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>> ---
>> Changes in v2:
>> - Drop extra variable as suggested by Pu Lehui.
>> - Link to v1: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v1-1-af023cc17af4@kylinos.cn
>> ---
>>  arch/riscv/net/bpf_jit_comp64.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index f9d5347ba966..0db89093ff89 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1986,7 +1986,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>  		else
>>  			ret = emit_atomic_rmw(rd, rs, insn, ctx);
>>  
>> -		ret = ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
>> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
>> +		if (ret >= 0)
>> +			ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx) ?: ret;
> 
> I don't agree with Sashiko that this was fully pre-existing. This fix
> changes the existing behaviour of BPF_DW | BPF_LOAD_ACQ. We can now end
> up with stale register data.
> 
> I'd like to see a v3 that addresses REG_DONT_CLEAR_MARKER for atomic
> loads (zext included).
> 
> 
> Björn

Thanks Björn, makes sense. LOAD_ACQ is just a load into rd, so on a
fault it should zero rd like PROBE_MEM does. I'll do a v3 that passes
rd for LOAD_ACQ, the other atomic ops keep REG_DONT_CLEAR_MARKER.

-- 
With Best Regards,
Feng Jiang

