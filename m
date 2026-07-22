Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E9330B01;
	Wed, 22 Jul 2026 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689516; cv=none; b=nF2L0dwJ2QAR0cpy/TD67Ieye88ywf1I+BY3uAIHWzFk8OlbsD/jVPut5PQeoZRN0NqF3023vxrZ1QPSFLMJvfXHDVIJ4pRrb4FSx0RDNCuYDLLUxVrsCTJIHLhtKhCS/ZknT0sWvpWTPPUVATzQBD3Tacum8vSvpOnNNd8gQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689516; c=relaxed/simple;
	bh=g7FO+VxvCX0lYh6tvT4b0cumwylrjMXeuxdz4HOXgs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaAyQWScbD99Rv2dN6tusTam5lBo7D40bfOHOq6f6qLUNzXhnSouyF9Nx6r9Fz0ZdmAGtV3+SA4NQHMI6QO7Gan26ApSV1/Irft61VbANMl6lbxOTKLQb3585ErqZWvsCeInWgC6j53SGgKYA06x0J40wQPk/KDa+3k4b8mPrHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h4fHG481KzKHMQm;
	Wed, 22 Jul 2026 11:04:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9425640539;
	Wed, 22 Jul 2026 11:05:09 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAnWVphM2BqOzByCA--.55067S2;
	Wed, 22 Jul 2026 11:05:06 +0800 (CST)
Message-ID: <ee25c5b9-97fb-409a-8529-e8689babb44f@huaweicloud.com>
Date: Wed, 22 Jul 2026 11:05:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 0/7] Mixing bpf2bpf and tailcalls for RV64
Content-Language: en-US
To: patchwork-bot+netdevbpf@kernel.org
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, alex@ghiti.fr, pulehui@huawei.com
References: <20260708064436.2971933-1-pulehui@huaweicloud.com>
 <178465861815.931197.16356281577887013283.git-patchwork-notify@kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <178465861815.931197.16356281577887013283.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnWVphM2BqOzByCA--.55067S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr48AFWUJF48Kry5Ar13Arb_yoW8KFWkpa
	yxCrn8Cr1vqr4xuanIgF48AF9Y9an5Cr15Cr15tr1rA3WfXF1qgryIvr4F9as8XrWvkw4U
	uFnIvrn0qw4xXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/22 2:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Kumar Kartikeya Dwivedi <memxor@gmail.com>:
> 
> On Wed,  8 Jul 2026 06:44:29 +0000 you wrote:
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
>> [...]
> 
> Here is the summary with links:
>    - [bpf-next,v6,1/7] bpf: Extract the is_struct_ops_tramp helper
>      https://git.kernel.org/bpf/bpf-next/c/6bcecae4b65d
>    - [bpf-next,v6,2/7] riscv, bpf: Fix memory leak in bpf_jit_free
>      https://git.kernel.org/bpf/bpf-next/c/369e4635d048
>    - [bpf-next,v6,3/7] riscv, bpf: Using kvzalloc_objs to allocate cache buffer
>      https://git.kernel.org/bpf/bpf-next/c/f3ab878594b5
>    - [bpf-next,v6,4/7] riscv, bpf: Fix kernel stack corruption in tailcall with CFI
>      https://git.kernel.org/bpf/bpf-next/c/52fb1756ea1d
>    - [bpf-next,v6,5/7] riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
>      https://git.kernel.org/bpf/bpf-next/c/a21731f54cfe
>    - [bpf-next,v6,6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
>      https://git.kernel.org/bpf/bpf-next/c/ec72848ca0ad
>    - [bpf-next,v6,7/7] selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64
>      https://git.kernel.org/bpf/bpf-next/c/683ed8b78c1d
> 
> You are awesome, thank you!

Finally got this covered, what a long journey...

But it looks like bpf selftests in riscv is pretty unhappy now.😅
If anyone has some spare cycles, it'd be awesome if we could figure 
these out together.:)

