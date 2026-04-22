Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A631E84D
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874011; cv=none; b=pnah3ILU5uJlss7pyPM6TDEX8F1BENyeeRxkg1B4gxuG9Rg2wn9LymC2ysQ2O2CJ2FUsGC+cajLCOj40OtHQx6I8nEAhEJrrEiY0XGK1RwmQ/4SipWgt7Qeb7m9i6tlsTD+De7AcdOerqEBYjPK00PLjrZLCs9uBFmIBWYZmL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874011; c=relaxed/simple;
	bh=YsgLrZdMJpnQhifZZhTSdPVmjQLsScnIQg8OPfb9y0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfuAwx3rjEpHtPIjO1wlXRYFbrMrn36zy3RM2yljbaNsXc/6gsa88s0cqIRBMDJC35/M4KDuitiY5Dfpi1DYWxNl43qXB1Tm5zM3KZsZ7Bu+9zR03MSg5FjCV2zU+6imTiZ9RqrGT86KKWJ11iWP9+bkiDCfvIiZ9j/xkLaA4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDXoUXb8ehp766mAA--.3486S3;
	Thu, 23 Apr 2026 00:05:48 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2M3Y8ehpVPTPAA--.842S3;
	Thu, 23 Apr 2026 00:05:45 +0800 (CST)
Message-ID: <b8e72e17-b254-4323-b355-989641523eb8@zju.edu.cn>
Date: Thu, 23 Apr 2026 00:05:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org,
 xukuohai@huaweicloud.com
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260421144504.823756-3-tangyazhou@zju.edu.cn>
 <7e3963b44fcf235bd898c41fbf188f765bfc03c404aea0d6913fc6dd2a07e832@mail.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <7e3963b44fcf235bd898c41fbf188f765bfc03c404aea0d6913fc6dd2a07e832@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgBn2M3Y8ehpVPTPAA--.842S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhMJCmnn0w2UIwAAsx
X-CM-DELIVERINFO: =?B?Th/nVwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9O+GfsRvWgc5oLPrSlr2ZUVcBfL9vZEiPRA+f9wPWUCZw+86oovgQBdcEO7sEYsbIvb5
	SWU0vCvwSWDwsRpfutPiH8i28f/TsOsFP+0d+WxDIlTha1k3OnS4aIURl5QAdA==
X-Coremail-Antispam: 1Uk129KBj93XoWxuF4UuFy8KFyxuFW8GFy5ZFc_yoW5ArWxpF
	WDKF1UCr1kXr4Iy34IyFZF9a15ursayF1UCa4rJFyxurs0qr1DGFy5KFs0vF9I9rnY934x
	XF1Iv3s2k3y2kacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGO
	UUUUU



On 4/21/26 11:29 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 63044ebe5721..cdccb1b319a6 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2400,9 +2403,7 @@ int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>>   	/* Prevent out-of-bounds read to interpreters_args */
>>   	if (stack_depth > MAX_BPF_STACK)
>>   		return -EINVAL;
>> -	insn->off = (s16) insn->imm;
>> -	insn->imm = interpreters_args[(round_up(stack_depth, 32) / 32) - 1] -
>> -		__bpf_call_base_args;
>> +	insn->off = (round_up(stack_depth, 32) / 32) - 1;
>>   	insn->code = BPF_JMP | BPF_CALL_ARGS;
>>   	return 0;
>>   }
> 
> In the v6 review thread at https://lore.kernel.org/bpf/CAADnVQ+m2pFaPbRi=A+tsROKP2CPPkny_LXUKR3vUgH2+u1jRg@mail.gmail.com/,
> Alexei Starovoitov noted that Sashiko flagged a real OOB read issue.
> 
> The author acknowledged this concern in a follow-up discussion, stating
> that v6 inadvertently turned a pre-existing load-time OOB read into a more
> critical run-time OOB read when stack_depth exceeds MAX_BPF_STACK. The
> author committed to fixing this in v7 by changing bpf_patch_call_args()
> return type to int and adding strict boundary checks for the array access.
> 
> However, the current version still lacks a boundary check on the computed
> array index before accessing interpreters_args. The code checks if
> stack_depth exceeds MAX_BPF_STACK:
> 
>      if (stack_depth > MAX_BPF_STACK)
>          return -EINVAL;
> 
> But does this check guarantee that (round_up(stack_depth, 32) / 32) - 1
> stays within the bounds of the interpreters_args array?

The "stack_depth > MAX_BPF_STACK" check perfectly guarantees this.

The interpreters_args array is hardcoded and strictly aligned with
MAX_BPF_STACK. The array is designed to accommodate exactly up to
512 bytes, which yields an array size of exactly 16 elements (512/32).
Therefore, checking the stack depth is mathematically equivalent to
an explicit ARRAY_SIZE bounds check.

> 
> Looking at the array access in ___bpf_prog_run():
> 
>      BPF_R0 = (interpreters_args[insn->off])(BPF_R1, BPF_R2,
>                                              BPF_R3, BPF_R4,
>                                              BPF_R5,
>                                              insn + insn->imm + 1);
> 
> If the computed index exceeds the array size, this would cause a run-time
> OOB access. Should there be an explicit check ensuring the index value
> is within the valid range of the interpreters_args array, as promised in
> the v6 discussion?
> 

I prefer checking MAX_BPF_STACK directly because it explicitly shows
the root cause of the verifier's rejection. It also maintains consistency
with the existing check in bpf_do_misc_fixups().

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24729984210

