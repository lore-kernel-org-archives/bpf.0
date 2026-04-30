Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9F3DD52D
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560484; cv=none; b=lWPmXfv+d6EfUFvOABkD1uT17YDQ4CVnj5vB4PQqDOzm1wo/6iFtoEmCq1wC1gJYm16HXFIbuiuVdld0v6hCqsuFv90MlevpGizb6PYUvrc4C6kcYBlGp7QvBlo9zEydDQN4Dl+lotb+Y2GBh1Z9ujP5QcDPz069Ssdud1u651M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560484; c=relaxed/simple;
	bh=jIIa8o1+xEycbsW+1IiK92t3XOyyMjwSuQ4peuVayZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krxI2POc1AClPOyWlQau6zQ+pxACEOLetFRI04R7Km9UhHGQDRTXgiFuvhqcNk5wfyWMJDKGgxcEdaQjeZ/NmZeNzrG3IOLNbuZLpQSZrSUrLTIU1G/eWqu/kGh7F5zWRDch7o17YhHEIC2+ti0l/r++sgz29Ye0oGIuhIc8k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.175.228])
	by mtasvr (Coremail) with SMTP id _____wA3HQCca_Np7NDrAA--.9698S3;
	Thu, 30 Apr 2026 22:47:57 +0800 (CST)
Received: from [10.162.175.228] (unknown [10.162.175.228])
	by mail-app3 (Coremail) with SMTP id zS_KCgCXQHOca_NpkMXMAA--.4148S3;
	Thu, 30 Apr 2026 22:47:56 +0800 (CST)
Message-ID: <c8fd766b-3704-4a8a-9366-1dcdcd84aed8@zju.edu.cn>
Date: Thu, 30 Apr 2026 22:47:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260429171904.107244-3-tangyazhou@zju.edu.cn>
 <20260429211006.E55AAC19425@smtp.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <20260429211006.E55AAC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zS_KCgCXQHOca_NpkMXMAA--.4148S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgwRCmnyXw4YuAABs6
X-CM-DELIVERINFO: =?B?fM21QQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HMx7PSTORDyc/TnL254NCvEQ4HKagyW4wNawHHVf9D0sc3egDOVdyhRfKRL9XbKRZhM
	iDNorCyij0ZSoN9++CYLhTEUnFd3SGa6TKvPMQn3HhIIVyLVLAXKP3S6prXyWw==
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1DKrWxCF1xKw13KFyDJwc_yoW8tF4DpF
	WrtFy7Cr4DXr1SkFy7Ars5Gw45Kw4xCr4UWFn8JryFvw4aqryvkF4kKr4Fgay3Cr1Iyr4F
	vFsFv3Zavw1DAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU



On 4/30/26 05:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unprivileged users will see broken control flow graphs and `call pc+0` in BPF-to-BPF pseudo calls.
> --
> 
> commit c7ae76817147356f188b1975260698d1d9dcd44a
> Author: Yazhou Tang <tangyazhou518@outlook.com>
> 
> bpf: Fix s16 truncation for large bpf-to-bpf call offsets
> 
> This commit fixes s16 truncation for large BPF-to-BPF call offsets by keeping
> the relative offset in the 32-bit imm field instead of downcasting it to the
> 16-bit off field. It updates the JIT, interpreter, and related dumper code to
> swap the usages of imm and off for BPF pseudo calls.
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 300e4e251931..8947ef74f6a8 100644
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
> Because this patch swaps the usage of insn->imm and insn->off for BPF pseudo
> calls, will this cause a regression for unprivileged users dumping programs?
> 
> In kernel/bpf/syscall.c:bpf_insn_prepare_dump(), the kernel zeroes insn->imm
> for all BPF_CALL instructions when the user lacks privileges:
> 
>      if (code == (BPF_JMP | BPF_CALL)) {
>          insns[i].imm = 0;
>          ...
> 
> Previously, this only hid the subprogram index. Now that insn->imm holds the
> actual relative offset, zeroing it means tools like bpftool will receive an
> offset of 0.
> 
> Could this regression cause bpftool prog dump xlated to output call pc+0 and
> break the control flow graph generation for unprivileged users?
> 

OK, this problem is confirmed.

As root user, executing "sysctl -w kernel.kptr_restrict=2" before "bpftool
prog dump xlated" will indeed demonstrate the bug. I will change the
bpf_insn_prepare_dump() function in v10.

