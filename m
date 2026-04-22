Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621330F938
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871984; cv=none; b=Lnxjkrn+NBXWlM4gcZlfHNymXQMFmxUUWo8qJTi1m72QbS9AQoqDQ8XXKqi0Lflzkex5ckFMaBdMyWIVzHPFJSTgNmxcU7Vu9DTfOJZsazCwtJuM3+TZqWX9jfVwUz1l5R/WVWugxs3YJBXSfIdEZum7tT3KrNNNWwpFZ07uh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871984; c=relaxed/simple;
	bh=J5cuVz1zEKo89rLo+otrDYXrNP44ctBeVmit2mkj9Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhwFFDVXXT3PhbLJWvfmWXjNomRFKtjI/+EkLbXqNtQXp0HjzvHA24TLQil2/cxgCJ2SX4D2kWJgU7jKuadSljxb3I6LKWQOrBpcqFOPxFPBS7KylQTGO5FjCI5rJ8BapBCJMj/zm2OgKr09pxSqaFY+jJVgw8LA5/tkJ3rzlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCnry8M6uhpT3+mAA--.901S3;
	Wed, 22 Apr 2026 23:32:29 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgA3OqQL6uhpolOkAA--.803S3;
	Wed, 22 Apr 2026 23:32:27 +0800 (CST)
Message-ID: <7a7f3455-3cb2-42a8-a1a1-47ba40ee1a2f@zju.edu.cn>
Date: Wed, 22 Apr 2026 23:32:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com, Shenghao Yuan
 <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>
References: <20260421-cnums-everywhere-rfc-v1-v1-0-8f8e98537f48@gmail.com>
 <9d47111a-61c8-491b-8750-63fb79968125@zju.edu.cn>
 <DHZRWV9NZOPX.1PD401F76IUT9@gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <DHZRWV9NZOPX.1PD401F76IUT9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:yy_KCgA3OqQL6uhpolOkAA--.803S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgEJCmnn0w6TEAAAsQ
X-CM-DELIVERINFO: =?B?d7QGIQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HPAz25DttWpHO0EovEbnhwc6/Pq6sCTrYrSC6K12ReuYLznGuLF6dPj8VYyBJFPtL8/
	lvTZkFRLTc11J06oT1lLR2nJ2xliPrJ0fKTcQOUXIQczIVEGVw1Et4NATdJaYQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyDKFW7AFyxAr1fAF4DWrX_yoW8ArW8pF
	W3Jr4DCF4DJa9FgFyxZ3ySv3Wa9a1rJF4Uurs3G3yrX39xXF92qFy8Krsxua4xGFn3W347
	trW2vF98X3W5A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07je9a9UUUUU=

Hi Alexei,

Thanks for the quick response!

On 4/22/26 11:03 PM, Alexei Starovoitov wrote:
> On Wed Apr 22, 2026 at 7:50 AM PDT, Yazhou Tang wrote:
>> This was built for potential integration into Solana BPF and is
> 
> we were thinking about adding these insns as well
> 
> uhmul64_imm	dst = ((u128)dst * (u128)imm)>>64	0x77	BPF_PQR	BPF_UHMUL | BPF_K	v2
> uhmul64_reg	dst = ((u128)dst * (u128)src)>>64	0x7f	BPF_PQR	BPF_UHMUL | BPF_X	v2
> shmul64_imm	dst = ((i128)dst * (i128)imm)>>64	0x87	BPF_PQR	BPF_SHMUL | BPF_K	v2
> shmul64_reg	dst = ((i128)dst * (i128)src)>>64	0x8f	BPF_PQR	BPF_SHMUL | BPF_X	v2
> 
> if you have kernel patches for that please share.

We haven't implemented the interpreter and JIT backends for these
new uhmul64 and shmul64 instructions yet. However, we are actually
very familiar with these specific high-half multiplication
instructions, as they are already implemented in Solana BPF
(which we work closely with).

We would absolutely love to take this on for the Linux kernel.
We can prepare the implementation across several RFC patchsets,
which will include:

1. Verifier: The value analysis for these new uhmul/shmul instructions
    using tnum and the upcoming cnum, backed by our formal proofs.
2. Interpreter: The core implementation in kernel/bpf/core.c for
    these 4 instructions.
3. JIT support starting with x86_64 (and subsequently arm64, etc.).

(Note: We assume the LLVM frontend/backend support for emitting
these instructions might be handled separately, but we are happy
to provide the kernel-side implementation first).

For the initial RFC, we plan to focus on the first two parts
(the Interpreter and Verifier semantics) to establish the groundwork.

Best,
Yazhou

