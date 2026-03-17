Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854A2DB790
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718082; cv=none; b=fFR+kxlB/ZEXLZEQa03lmixGuBxXXjmLVDVimb/bHeh1aPdndLTg7QyDM1IdYDob1nECOnShzPGkC1BDtjQ67rq9aBDx7xKaDFfUgNcKjqQMCdx7iUlDKsdJv+HfTuyD0EDo4aPQsDDLwQfUlAkaEW1SHuKd4PDs/eGT4si5nyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718082; c=relaxed/simple;
	bh=xmPnwGQlygcI4i49wKsfYuswq5avJjVPc09y+gMzRLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQsf+fAgbCe9IQssA2u5ztxNPCQr3/x9DH2eNerimR+2Qaz32fHVXiaCCFQT+9wy23s0HGvQTgIF/tIARxNm28bwvy0Ua9lZrr2OCIDQDnBG6vuMUzgdEQega5paEjwFYdyscnI1EP9nejqJZvON+Rsmfj3ez8NHzpAQ+f7+0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.192.132])
	by mtasvr (Coremail) with SMTP id _____wCnoI8eyrhpb9UhAA--.10587S3;
	Tue, 17 Mar 2026 11:27:26 +0800 (CST)
Received: from [10.162.192.132] (unknown [10.162.192.132])
	by mail-app1 (Coremail) with SMTP id yy_KCgCnsdseyrhpWkC1Bg--.29291S3;
	Tue, 17 Mar 2026 11:27:26 +0800 (CST)
Message-ID: <80feff2e-ae08-46db-b986-e8399e94f32d@zju.edu.cn>
Date: Tue, 17 Mar 2026 11:27:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: reject bpf-to-bpf call with large offset in
 interpreter
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260316190220.113417-1-tangyazhou@zju.edu.cn>
 <20260316190220.113417-2-tangyazhou@zju.edu.cn> <m25x6vtsf1.fsf@kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <m25x6vtsf1.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgCnsdseyrhpWkC1Bg--.29291S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhINCmm4XQoOXwAAsA
X-CM-DELIVERINFO: =?B?BOt65QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JsjacUve5r2CgQhy7orc7wtiGF1glIyil+q9MO9XvSZIVOnGfZs8hNegItNB2z4ms3F
	BQt2OcAMTa4GMQmOXVWFw+hivQ+3dxk3muuN18dgyU4fOcZe22n6ClMkGtAGQA==
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWfJw13tr1xJryrXr1fAFc_yoW8Aw1Upa
	yUXa1rJrnrJr42kwn7AFWjgw4akFs7Z3WUWa45W3sxuw1fXF9xCr18Kr4rWayDCr4kAFnF
	qr42yFWfuw1DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eH
	DUUUU

Hi Puranjay,

Thanks for the review and for catching this!

On 3/17/26 04:45, Puranjay Mohan wrote:
> Thanks for the patch. The interpreter truncation fix looks correct, but there's
> a similar truncation bug in the JIT success path that should be addressed as
> well.
> 
> In jit_subprogs(), the "make interpreter insns consistent for dump" fixup at
> the end has the same s16 truncation problem:
> 
> insn->off = env->insn_aux_data[i].call_imm;
> subprog = find_subprog(env, i + insn->off + 1);
> insn->imm = subprog;
> 
> When call_imm exceeds s16 range, insn->off truncates it, and find_subprog()
> looks up the wrong instruction index. In my testing with your selftest,
> find_subprog() returns -ENOENT (-2), so insn->imm = -2. This causes bpftool to
> compute the call target as __bpf_call_base + (-2), which shows a bogus address
> in the xlated dump instead of the actual subprog symbol:
> 
>     1: (85) call pc+9#bpf_prog_115951674716e036_padding_subprog
>     2: (85) call pc+3402#0xffff80008026d276
> 
> The 0xffff80008026d276 is __bpf_call_base - 2, not target_subprog.  This also
> leaks the address of __bpf_call_base to userspace.
> 
> The fix is to use call_imm directly for the find_subprog() lookup instead of
> reading back from the truncated insn->off:
> 
> insn->off = env->insn_aux_data[i].call_imm;
> subprog = find_subprog(env, i + env->insn_aux_data[i].call_imm + 1);
> insn->imm = subprog;
> 
> this still leaves the ->off to be wrong, but that is fine in my opinion.
> 
> Could you fold this into the series as well?

You are absolutely right. Using the truncated `insn->off` in the JIT 
dump path is indeed a bug, and your proposed fix makes perfect sense.

I will fold this fix into `jit_subprogs()` and add your `Suggested-by` 
tag in v2.

Best,

Yazhou

