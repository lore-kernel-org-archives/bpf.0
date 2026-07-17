Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1321CA02;
	Fri, 17 Jul 2026 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256745; cv=none; b=TYeM97bUJS20kprr3Mr1Mz8de++p1cr0NRRug5ICjigdjJcw72MuULm1yIEPifnFKY7BIP9/UwH/8FcQJIhs7149Q7BJT2Oz9cTcvGsq78FT1QbLG9yyKa53CO+bowdaa4jtHS0eUIiVcXZA3zhjEZ2drBUZcGgmUvaonf/pgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256745; c=relaxed/simple;
	bh=2jLBWbKLhsAY0hP+CnhGsLZWu+gO8Ds4tpJxCw1hKuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC3jV9Sx/cQ5Ry72tdO2gghNR/Q3mMjdvsbV4yF0OZpRAxkQbf3PAQAAyloESYOw40s5pRdTJlv0b4K64DMV+VfHl1ObLigTDj6HeHuAvEJtWK/Lf9T9gIZZU7MLMabJT6tYw+szbwifXRvWYRSGl/C2NZeQENpDZ5SG8zd1RcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 848757c0818a11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6a28a301-fe4a-4a87-9769-c44122893332,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:10e6812197b47bb712ec1f1c4f19dbf6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|865|898,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 848757c0818a11f1aa26b74ffac11d73-20260717
X-User: jiangfeng@kylinos.cn
Received: from [10.42.12.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1511717193; Fri, 17 Jul 2026 10:52:15 +0800
Message-ID: <0676b1c8-b4e5-4118-9211-58fd57aa0439@kylinos.cn>
Date: Fri, 17 Jul 2026 10:52:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] bpf, riscv: add support for timed may_goto
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Pu Lehui <pulehui@huawei.com>,
 Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn>
 <20260715-riscv-bpf-timed-may-goto-v3-1-cf2a9c3d843f@kylinos.cn>
 <8733xjwe5a.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Feng Jiang <jiangfeng@kylinos.cn>
In-Reply-To: <8733xjwe5a.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/16 16:08, Björn Töpel wrote:
> Feng Jiang <jiangfeng@kylinos.cn> writes:
> 
>> Implement arch_bpf_timed_may_goto() for the RV64 JIT. The argument and
>> return value are carried in BPF_REG_AX, and BPF R0-R5 are preserved
>> across the call to the generic bpf_check_timed_may_goto().
>>
>> Enable bpf_jit_supports_timed_may_goto() so the verifier uses the timed
>> expansion path.
> 
> Thanks for working on this!
> 
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index c03c1de16b79..4f88a446278a 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1841,7 +1841,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>  		if (ret)
>>  			return ret;
>>  
>> -		if (insn->src_reg != BPF_PSEUDO_CALL)
>> +		/*
>> +		 * arch_bpf_timed_may_goto() is emitted by the verifier and
>> +		 * returns its result in BPF_REG_AX instead of BPF_REG_0, so
>> +		 * skip the normal "move return register into R0".
>> +		 */
>> +		if (insn->src_reg != BPF_PSEUDO_CALL &&
>> +		    addr != (u64)arch_bpf_timed_may_goto)
> 
> Nit: In the future, please use full 100 chars lines, instead of breaking
> the line.
> 
> Would it be possible to add a test for this custom ABI? The fact that it
> was missed in v1 hints that it would be good.
> 
> I asked an LLM to suggest a test [1]. Feel free to be inspired by it.
> ;-)
> 
> 
> Björn
> 
> [1] https://paste.debian.net/hidden/9dd769d6

Thanks Björn! I'll fix the line wrap and add a test for the custom ABI.
Will send a v4 later.

-- 
With Best Regards,
Feng Jiang

