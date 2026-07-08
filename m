Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852673BB4A
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479455; cv=none; b=ByunSSQBW9Zp2VocBuvYK4DVjS2zqcIIzSRyEuOBke6XdmgoNAg4xNl7hrgCZ9UFKbxIfmWU3RKx5lexs6XJvoyr6L5a1hNjUbngXfK3pyAouPNiQMbLz/NVI8Pn1zQ+0R/KNPWw28uaruWP6SL2nJeaZ1YdKvoBuwljBYZFPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479455; c=relaxed/simple;
	bh=h562/F4Sii/Yn93c0IcVFU48VXfBRKVHbBCInoTfprg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5ItrZsVDlC1Rv3lJOaGr8nOQ+Afh7IKsKRYVueMrfIIPEkdM+cydSOnCZCbH/CnLni+vFUwu914i4VYzXl1lHcP6ctrZHZIV6RO9TcyiK7T2zSnPVu1LKiYPvPqL4jIgBZdnb2tdcVORlQNEpnFcYqGha5uA81hVzvgnptC0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw2nJ3fgvzKHLwm
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:57:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CBFC14058F
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:57:28 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBnL6CXvE1qJg7KAQ--.41824S2;
	Wed, 08 Jul 2026 10:57:28 +0800 (CST)
Message-ID: <25326f37-b28a-45dc-bb84-7bfe5b078d75@huaweicloud.com>
Date: Wed, 8 Jul 2026 10:57:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/6] riscv, bpf: Using kvzalloc_objs to
 allocate cache buffer
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260707142219.2871758-1-pulehui@huaweicloud.com>
 <20260707142219.2871758-3-pulehui@huaweicloud.com>
 <20260707142908.466981F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260707142908.466981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBnL6CXvE1qJg7KAQ--.41824S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Gw43Jr1kWFWfGrWkXrb_yoW8tFy7pF
	Z8Ka43CrZ0gw1kKFsrJw18ur18tw4kW3W3KFyj9ryfXFsIgrykGFs0k3yrWFZ8CFW8Xa48
	WrWYvrnxu34kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/7 22:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing `kvfree(jit_data->ctx.offset)` in `bpf_jit_free` causes a memory leak of the JIT context offsets when JIT compilation aborts during subprogram processing.
> --
> 
> --- Patch [2]: [PATCH bpf-next v5 2/6] riscv, bpf: Using kvzalloc_objs to allocate cache buffer ---
> commit a49923246dc7e8b492561a3a183fc88dc6914fa1
> Author: Pu Lehui <pulehui@huawei.com>
> 
> riscv, bpf: Using kvzalloc_objs to allocate cache buffer
> 
> It is unnecessary to allocate continuous physical memory for cache
> buffer, and when ebpf program is too large, it may cause memory
> allocation failure.
> 
>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>> index ce3bd3762e08c..367ae923ea40c 100644
>> --- a/arch/riscv/net/bpf_jit_core.c
>> +++ b/arch/riscv/net/bpf_jit_core.c
>> @@ -72,7 +72,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>>   	ctx->arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
>>   	ctx->user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
>>   	ctx->prog = prog;
>> -	ctx->offset = kzalloc_objs(int, prog->len);
>> +	ctx->offset = kvzalloc_objs(int, prog->len);
> 
> [Severity: High]
> This is a pre-existing issue, but does this leak the ctx->offset array if JIT
> compilation aborts during subprogram processing?
> 
> For subprograms during the first pass (!prog->is_func || extra_pass is false),
> bpf_int_jit_compile() returns early, keeping ctx->offset alive for the
> subsequent extra pass.
> 
> If a later subprogram fails JIT compilation, the BPF core aborts and calls
> bpf_jit_free() to clean up the first subprogram:
> 
> arch/riscv/net/bpf_jit_core.c:bpf_jit_free() {
> 	...
> 		if (jit_data) {
> 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> 			kfree(jit_data);
> 		}
> 	...
> }
> 
> It appears jit_data->ctx.offset is not freed during this cleanup, which could
> lead to a memory leak.
> 
>>   	if (!ctx->offset)
>>   		goto out_offset;
> 

right, will add this new fix in next

