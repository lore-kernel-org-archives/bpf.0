Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD630F938
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872003; cv=none; b=BcSF/soCU3pdAbuwlA85mp3/cLIO7AwAnoa4x2eS9N88oIWJVpFHK/6n30mrcUlBEvkza+36wgFaw2AP0rhKcCr4hXRz5S9O6N2fx8cypF3+vM4n7dahSAG+IH1nMIn8Oih+CAZAWXMKv24MzArhwQiO3GT1LSvI3nH973g0cWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872003; c=relaxed/simple;
	bh=XlFSrGpKRZwx64dhnng+IMVZAFgvoncijSqVCiEKHH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4IZ4VDms0cCXmTaV/uGwsVUFAnsLCfqRm+N+jh2gytTgm7wU8w/oV9Z5PDADhKjrWIGYcAE94sN+FPO9N1uqdHgl4uPUcLC57nLOBIK1D5EvG1Bu+9S1jIO8vvLvis0acQr1E9iplPRNMX5qO44nkDbi7FD8/6wqf5g10sXRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wD3dTw46uhplYCmAA--.3137S3;
	Wed, 22 Apr 2026 23:33:12 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgB3eaM46uhpK1SkAA--.350S3;
	Wed, 22 Apr 2026 23:33:12 +0800 (CST)
Message-ID: <5c172edc-3323-4fbc-ad16-24c1109e4b05@zju.edu.cn>
Date: Wed, 22 Apr 2026 23:33:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
 <20260421204648.B573FC2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <20260421204648.B573FC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgB3eaM46uhpK1SkAA--.350S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg4JCmnn0w6TGgAAsV
X-CM-DELIVERINFO: =?B?a0VR8wXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HJ05lIkNOUgLnhdlL20wRVRCJvYJlrQNF5F0uKdCau5Py86DXEXw9fD3iArbkeiAUPI
	RoGwRXmqtSOBY1rJNqSM6002mYEWZq3xZZB6jvj4wutqzY4mz7p39tDa1d/Qrw==
X-Coremail-Antispam: 1Uk129KBj93XoW7WF17XFWkWFy8Zr1rAr4UKFX_yoW8tFy8pa
	y5Ga4Ikr4UXr4aka47tF4DCay5trZrC3WjgF15try3tr42grnrKr17KF4Sga43Jr1q9F1v
	qr4jvwna9w1DZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==



On 4/22/26 4:46 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] bpftool's control-flow graph generator (cfg.c) was not updated to reflect the `insn->off` and `insn->imm` swap for BPF_PSEUDO_CALL, which will break visual dumps.
> --
> 
> commit bbf026d16d77a3e1debc60ea3a7b2fef7d7def5e
> Author: Yazhou Tang <tangyazhou518@outlook.com>
> 
> bpf: Fix s16 truncation for large bpf-to-bpf call offsets
> 
> This commit fixes an s16 truncation issue for large bpf-to-bpf call
> offsets when JIT is disabled or falls back to the interpreter.
> It does this by using the off field to store the interpreter function
> index and the imm field to pass the original offset.
> The related dumper code was also updated to adapt to this change.
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 300e4e2519318..8947ef74f6a88 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>   		}
>>   		if (!bpf_pseudo_call(insn))
>>   			continue;
>> -		insn->off = env->insn_aux_data[i].call_imm;
>> -		subprog = bpf_find_subprog(env, i + insn->off + 1);
>> -		insn->imm = subprog;
>> +		insn->imm = env->insn_aux_data[i].call_imm;
>> +		subprog = bpf_find_subprog(env, i + insn->imm + 1);
>> +		insn->off = subprog;
>>   	}
> 
> Since insn->imm and insn->off are now swapped for exported translated
> programs, should tools/bpf/bpftool/cfg.c also be updated?
> 
> It looks like cfg_partition_funcs() currently relies on cur->off to
> calculate the target subprogram start when generating the control-flow
> graph:
> 
> tools/bpf/bpftool/cfg.c:cfg_partition_funcs() {
>          ...
> 	for (; cur < end; cur++) {
> 		if (cur->code != (BPF_JMP | BPF_CALL))
> 			continue;
> 		if (cur->src_reg != BPF_PSEUDO_CALL)
> 			continue;
> 		func = cfg_append_func(cfg, cur + cur->off + 1);
> 		if (!func)
> 			return true;
> 	}
>          ...
> }
> 
> Because cur->off now holds the subprogram index instead of the jump offset,
> could this point to the wrong instruction and cause a corrupted graph or
> out-of-bounds memory access during bpftool prog dump xlated visual?
> 

This is a valid point. I will fix this issue in next version.

