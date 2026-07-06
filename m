Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905F39E9C8
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322352; cv=none; b=OLj8h6U/ZDdTgKRuKBGhI7fNC9ntQpHts+6Er0qzINL78SCudOoRW/59x5YOrMDr4dycqAFmoG4NpuPUrbrPRW1Y1+LtMjNurBbYl0qGgWdAHhagryNpPU5ZZEw7qKUJ9EmgqHbUBw7bSAE8Pueio1ql2RMZpVg5dFJNavqNNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322352; c=relaxed/simple;
	bh=jw+AKUqvXa6peZUSX1ld2ajFCd6hBYDF8Cq0Z7vvk0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAj0V9fb2R25ZwOq1hToNQdUDJxEycCNXzGWra7XPOPd1xUm9x6HtrUlFCp2lBE+7v/6FmtWIZVzlodEMrBLGgMqroSybrbgv3XxX35lW0ls5FQGe+cW0vAy/MmzUI43DShegdjXnpzivTZt7Cd7Nrs7rZitclbjEjQbnM/Gdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gtwhJ0LXYzYQtkl
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:18:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 451C34058D
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:18:57 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBnl1jhVktql2jzAA--.45440S2;
	Mon, 06 Jul 2026 15:18:57 +0800 (CST)
Message-ID: <35a5578d-dc51-4fc7-9fa6-2429f2cd49da@huaweicloud.com>
Date: Mon, 6 Jul 2026 15:18:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/6] riscv, bpf: Remove redundant ctx->offset
 initialization
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260629140048.733346-1-pulehui@huaweicloud.com>
 <20260629140048.733346-3-pulehui@huaweicloud.com>
 <20260629140839.D2DE71F00A3A@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260629140839.D2DE71F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnl1jhVktql2jzAA--.45440S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Cw4UJF15Gr13Gw48WFg_yoW8tFyfpF
	s3K3ZxC398XrsYgwnrJa48ZFWYyw4kC3W7CFs09ryUZF90grnFqF1Yyw45uF95ArWF9F1j
	9rWjvwn3Ar1DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/6/29 22:08, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Buffer Overflow / JIT Convergence Failure due to violated monotonic shrinking guarantee
> --
> 
> commit 1c7e15d4942628f7431314e8bb5d6ca1fb3134f1
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Remove redundant ctx->offset initialization
> 
> This commit removes the loop initializing ctx->offset and prev_ninsns in
> bpf_int_jit_compile, operating under the assumption that the implicit
> zero-initialization is sufficient and the manual setup is redundant.
> 
>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>> --- a/arch/riscv/net/bpf_jit_core.c
>> +++ b/arch/riscv/net/bpf_jit_core.c
>> @@ -79,11 +79,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   	if (build_body(ctx, extra_pass, NULL))
>>   		goto out_offset;
>>   
>> -	for (i = 0; i < prog->len; i++) {
>> -		prev_ninsns += 32;
>> -		ctx->offset[i] = prev_ninsns;
>> -	}
>> -
> 
> [Severity: Critical]
> Could removing this worst-case initialization loop cause a regression by
> breaking the monotonic shrinking guarantee of the JIT convergence algorithm?
> 
> When ctx->offset is simply zero-initialized, forward branches will initially
> evaluate to a zero or negative distance in the first pass. This causes the
> JIT to emit short branch instructions. As targets resolve to their actual
> positive offsets in subsequent passes, these branch distances increase,
> which forces the JIT to expand the branch instructions.
> 
> Can this lead to a situation where a branch expands while another shrinks
> by the same amount, resulting in a net zero size change for that pass?
> 
> If the JIT falsely detects convergence because ctx->ninsns equals
> prev_ninsns, it allocates a fixed-size executable buffer based on that
> length. In the final emission pass, if internal offsets shift again and
> cause a branch to expand unexpectedly, would this result in an out-of-bounds
> write past the allocated buffer?
> 

Right, ctx->offset use for branch and tailcall, and remove this init 
would hit some corner case. Let's keep it.

