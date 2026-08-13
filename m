Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D4378823;
	Thu, 13 Aug 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609453; cv=none; b=u9iQU+sK6TnINM3C+YAjqqnOh406UmlKkDD/rqx3aQ9FBIS6H+reJvOMKfsdWb3RT/O5pF3XXX6X+3IBKdPM+BFiyZQAB2xxwLTKQCtOQBqitqZxSv67JMCaieuuvVYHEZsa3Qt2KB6YnpAPCeJImcLSp4kK8F8bqS4wm4cF9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609453; c=relaxed/simple;
	bh=RSICgLmtm1xRZiiIp0/AoqJMWfn4igydVeZCt0+fC+Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uy71hegyRH7NFbCd22tRSNt43f0Zcm1YkRZtVufh+WkMquYisQ46EOL/l3dPPN1mQt1KGRe1/FtRWrUG+Y5haUfU1rXHpQ6PFu7y4Y73QGd8N1B98XRsQJiyVrJ5F/vvbj7eMitd5TNEwYUkdcc+zc7jE1Cvtip7lHqfQfq82OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cx_9Iof31qNdgAAA--.2670S3;
	Thu, 13 Aug 2026 16:24:08 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxTs8lf31qQSADAA--.21057S2;
	Thu, 13 Aug 2026 16:24:06 +0800 (CST)
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Enable timed may_goto tests
 for LoongArch
To: bot+bpf-ci@kernel.org, chenhuacai@kernel.org, hengqi.chen@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260813070906.5164-1-yangtiezhu@loongson.cn>
 <6a9f7ec666d4f36867e91cf21a36d7f8ef6a3872ac694f1eb468aa5278372ce3@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <69daa817-a3cc-370e-dbb4-33450ab2cb43@loongson.cn>
Date: Thu, 13 Aug 2026 16:24:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a9f7ec666d4f36867e91cf21a36d7f8ef6a3872ac694f1eb468aa5278372ce3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTs8lf31qQSADAA--.21057S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr48Wr4UXF43XrW5trWrJFc_yoW5KFW7pw
	n29FZFqrn5Jan5G39Fy3WjvFyYvFyxJw43G3WxtrW5JF1Fq3ZrKFy8K3ZruFWFvF1UCw1r
	tw45Za4UX3WUAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwnYwUUU
	UU=

On 2026/8/13 下午4:11, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Enable timed may_goto tests for LoongArch
>>
>> Enable stream_cond_break, may_goto_interaction, and verifier_may_goto_1
>> tests for LoongArch, aligning with recent architectural infrastructure
>> support (timed may_goto and arch_bpf_stack_walk JIT).
> 
> The changelog states the tests are enabled "aligning with recent
> architectural infrastructure support (timed may_goto and arch_bpf_stack_walk
> JIT)". Does LoongArch have this infrastructure at this commit?
> 
> Looking at the tree, bpf_jit_supports_timed_may_goto() is not implemented for
> LoongArch (only the __weak false stub in kernel/bpf/core.c:3379 exists).
> arch/loongarch/net/Makefile builds only bpf_jit.o -- there is no
> bpf_timed_may_goto.S file, unlike arm64, riscv, s390, powerpc, and x86. Also,
> arch_bpf_stack_walk() is not implemented for LoongArch (only arch_stack_walk()
> exists in arch/loongarch/kernel/stacktrace.c, but not the BPF-specific
> variant).
> 
> If the enabling JIT work is in a separate series or a different tree, should
> the changelog name it and state the dependency? As applied, this patch makes
> three previously-skipped subtests fail on LoongArch.

Please see the additional comments after the --- marker line:

"This patch is based on the latest bpf-next tree, it depends on the
following two patches:

LoongArch: BPF: Add timed may_goto support
https://lore.kernel.org/loongarch/20260804153938.16129-3-dongtai.guo@linux.dev/

LoongArch: BPF: Implement arch_bpf_stack_walk()
https://lore.kernel.org/loongarch/20260813045306.21571-1-yangtiezhu@loongson.cn/

They are expected to be merged into v7.3-rc1 during the upcoming merge
window through the loongarch-next tree."

Here are the test results:

Before:
$ sudo ./test_progs -a stream_success/stream_cond_break
#466/2   stream_success/stream_cond_break:SKIP
#466     stream_success:OK (SKIP: 1/14)
Summary: 1/0 PASSED, 1 SKIPPED, 0/0 FAILED
$ sudo ./test_progs -a verifier_bpf_fastcall/may_goto_interaction
#580/24  verifier_bpf_fastcall/may_goto_interaction:SKIP
#580     verifier_bpf_fastcall:OK (SKIP: 1/29)
Summary: 1/0 PASSED, 1 SKIPPED, 0/0 FAILED
$ sudo ./test_progs -a verifier_may_goto_1
#635/1   verifier_may_goto_1/may_goto 0:SKIP
#635/2   verifier_may_goto_1/batch 2 of may_goto 0:SKIP
#635/3   verifier_may_goto_1/may_goto batch with offsets 2/1/0:SKIP
#635/4   verifier_may_goto_1/may_goto batch with offsets 2/0:SKIP
#635/5   verifier_may_goto_1/timed may_goto preserves R0-R5:SKIP
#635     verifier_may_goto_1:SKIP
Summary: 1/0 PASSED, 5 SKIPPED, 0/0 FAILED

After:
$ sudo ./test_progs -a stream_success/stream_cond_break
#466/2   stream_success/stream_cond_break:OK
#466     stream_success:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED
$ sudo ./test_progs -a verifier_bpf_fastcall/may_goto_interaction
#580/24  verifier_bpf_fastcall/may_goto_interaction:OK
#580     verifier_bpf_fastcall:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED
$ sudo ./test_progs -a verifier_may_goto_1
#635/1   verifier_may_goto_1/may_goto 0:OK
#635/2   verifier_may_goto_1/batch 2 of may_goto 0:OK
#635/3   verifier_may_goto_1/may_goto batch with offsets 2/1/0:OK
#635/4   verifier_may_goto_1/may_goto batch with offsets 2/0:OK
#635/5   verifier_may_goto_1/timed may_goto preserves R0-R5:OK
#635     verifier_may_goto_1:OK
Summary: 1/5 PASSED, 0 SKIPPED, 0/0 FAILED

Thanks,
Tiezhu

