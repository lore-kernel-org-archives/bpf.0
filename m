Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76C3B42D6;
	Mon,  6 Jul 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321764; cv=none; b=tBqj+bw1iz2AlGjLJJPCKu8gzAlK4BoPKzuoPoOcrBgaxImL3PNQxGcXWgyl+k0DIDA3kCvuNTMIVMw4BlKdylJqKhR+QlCJDcYqqWEGV969d3f+2PMRGBltZrZXf3FSyr/relgkzKZ5ydqA8Nb7EdsYVPg1iPSKRQVa/vav984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321764; c=relaxed/simple;
	bh=tcsFM7ARHJ8Laep0mLsnO/EHNTadvDiuU04w0JZqPHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtuWeVBRmbQ69sCeM8wpY0cP9gcKhrvtULffhp+XTowzHAEEAh19lgD7b8c+5xiV82V3H1UeUklYFKmXDyxhhwtam8Cb7Y5HTjBM7ikIbkmsfy0mewD6F7OYEqLBq8bL4C3fxXQNlkNgEat9LlUNBk5ZE7TN/7niBr181w/idfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gtwSt5ZxRzYQtlh;
	Mon,  6 Jul 2026 15:09:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0206B4056E;
	Mon,  6 Jul 2026 15:09:04 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnzCiJVEtq7aPxAA--.22259S2;
	Mon, 06 Jul 2026 15:09:03 +0800 (CST)
Message-ID: <468262e0-43c6-46dd-a9dc-0b216f2beab1@huaweicloud.com>
Date: Mon, 6 Jul 2026 15:08:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/6] Mixing bpf2bpf and tailcalls for RV64
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Pu Lehui <pulehui@huawei.com>,
 Pu Lehui <pulehui@huaweicloud.com>
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAJ+HfNhn9eK+3xsd3ewEsG-duCgBeYXeLAtNan=qefas2Ya0dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnzCiJVEtq7aPxAA--.22259S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8XF18CFy7WrWkAr1kKrg_yoW5CF1kpa
	97uw4ay34vqr4xuw47Ka1xJFWrGFZ3CayUAr15tr1rAF45Cryvkr17KFW0va45GrWvkw1j
	vr4jqan8Za1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Hi Björn,

Sorry for late reply.

On 2026/6/29 22:21, Björn Töpel wrote:
> Hey!
> 
> On Mon, 29 Jun 2026 at 15:56, Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
>> the TCC can be propagated from the parent process to the subprocess, but
>> the updated TCC of the parent process cannot be restored when the
>> subprocess exits. Since the RV64 TCC is initialized before saving the
>> callee saved registers into the stack, we cannot use the callee saved
>> register to pass the TCC, otherwise the original value of the callee
>> saved register will be destroyed. So we implemented mixing bpf2bpf and
>> tailcalls similar to x86_64, i.e. using a non-callee saved register to
>> transfer the TCC between functions, and saving that register to the
>> stack to protect the TCC value. As for the tailcall hierarchy issue,
>> inspired by the s390's low-overhead approach, we store TCC from
>> RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
>> func in bpf trampoline.
>>
>> In addition, some code cleans are also attached to this patchset.
>>
>> Tests test_bpf.ko and test_verifier have passed, as well as the relative
>> testcases of test_progs*.
>>
>> v4:
>> - Fix tailcall hierarchy issue.
>> - use is_struct_ops_tramp helper in bpf trampoline
> 
> Alexei outlined some (major) concerns on the whole mixing side of
> things [0]. I haven't been following that space -- did Leon have a

Yes, Leon addressed this issue years ago [0]. He solved it by passing 
the TCC PTR to the subprog, ensuring that the updated TCC is correctly 
propagated back upon the subprog's return. It's time for riscv64 to 
implement this feature.

[0] 
https://lore.kernel.org/all/CAADnVQ+TOFOA0Ya4qzrLDFV331uxZy8ay0svBMt-2Sh5E0tr2A@mail.gmail.com/

> workaround/fix? Can you explain more how you fixed it, and why it
> would make sense to add it to RISC-V now?

When dealing with the tailcall hierarchy issue, x64 and arm64 check if a 
register is a TCC PTR right in the function prologue, which may adds 
some overhead. To get around this, riscv64 plan to pass the updated TCC 
value to the stack using the TCC register after calling a subprog or a 
trampoline's orig_call, which something similar to s390.

Because of this, we have to use a caller-saved (non-callee-saved) 
register for the TCC. If we used a callee-saved one, the old TCC value 
would just get restored by mistake when the function returns.

As for the overall plan for mixing tailcalls and bpf2bpf, the main idea 
is to keep the TCC value on the stack and pass it between function calls 
using that caller-saved TCC register. Since we need to grab the latest 
updated TCC value after calling a subprog or a tailcall leaf node, we 
have to make sure the prologue always pushes the TCC to the stack, and 
the epilogue always restores it from the stack back into the TCC register.

> 
> Thanks,
> Björn
> 
> 
> [0] https://lore.kernel.org/bpf/CAADnVQ+rLneO4t=YYmLYtc945Fz0=ucNTWZBxgvs8toFY-onRg@mail.gmail.com/

