Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE53AA1B5
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244648; cv=none; b=Dk907BaUDw/3iI92OLoqJMsg+7N8L9sG/8pQrLzwuUpoqwnRNNCETgqkOqaj1bxjQqDYgb5DtT/mFoiBBaJd/0EQAWPlm+drpiRGe4UTT0q/e8SwOZJLxC1ORdMTs50iI3B4KcEcHOZUcbM9hPv63yi+Khbe9DdraGmv/VJLh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244648; c=relaxed/simple;
	bh=FsRkVSS3IGfUI2qQz/EWgl1svRHONwonEcMTFZgJxSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kaub5OGVfCcJ1XXbHuI4cEUDJKMHFEOixpencnATRW2PAwqWMr1NCHDnhADHkRyKBRcWMfFPoCtOct5NQkZkx2DxVlLdTNUzZU56uVUQCGyNXhKGiTfnjym4rB2PAgwwmBrFs4k3cF/zIbUo7d5lrig/b//lce5aoCmw/a+6phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h8bZg5cbjzKHMhb
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 21:16:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 459F840590
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 21:17:21 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXhtLgq2hq6IQJAQ--.19023S2;
	Tue, 28 Jul 2026 21:17:21 +0800 (CST)
Message-ID: <a092ae94-ccd2-4dfa-a1d6-2f4d33005fb3@huaweicloud.com>
Date: Tue, 28 Jul 2026 21:17:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 4/4] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-5-pulehui@huaweicloud.com>
 <20260722073501.64ACE1F00A3A@smtp.kernel.org>
 <d1c272dd-9db3-4d93-806e-ba8b4dcc0e91@huaweicloud.com>
In-Reply-To: <d1c272dd-9db3-4d93-806e-ba8b4dcc0e91@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXhtLgq2hq6IQJAQ--.19023S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48GF18GF1DJr43WF1DGFg_yoWrWrWfpF
	1kJFyDJas8Gr9Yvr1vq34qvFW8Aw48X3Z8Krn8J3W8GFW7tr1Fgr4xurZ09Fy3Jr4kZ3WI
	qr1YvrsruF1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/22 15:48, Pu Lehui wrote:
> 
> On 2026/7/22 15:35, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] Missing rollback of `pl->flags` on the error path in 
>> `__cgroup_bpf_attach` permanently corrupts the execution order of the 
>> replaced program.
>> -- 
>>
>> --- Patch [4]: [PATCH bpf v6 4/4] bpf, cgroup: Fix storage 
>> null-ptr-deref after replacing prog ---
>> commit f8726e124d0a4e72b87976830f0741e286d474df
>> Author: Pu Lehui <pulehui@huawei.com>
>>
>> bpf, cgroup: Fix storage null-ptr-deref after replacing prog
>>
>> Syzkaller reported a storage null-ptr-deref issue after replacing a prog.
>> The issue is fixed by properly allocating the storage and comparing 
>> the old
>> and new storage pointers, falling back to an RCU-safe update if they 
>> change.
>> Additionally, proper rollbacks for storage and flags are added to the 
>> error
>> path in __cgroup_bpf_attach for code rigor.
>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -883,7 +885,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>>       pl->prog = prog;
>>>       pl->link = link;
>>>       pl->flags = flags;
>>> +    if (old_prog)
>>> +        bpf_cgroup_storages_assign(old_storage, pl->storage);
>>>       bpf_cgroup_storages_assign(pl->storage, storage);
>>> +    old_flags = cgrp->bpf.flags[atype];
>>>       cgrp->bpf.flags[atype] = saved_flags;
>>>       if (type == BPF_LSM_CGROUP) {
>>
>> [ ... ]
>>
>>> @@ -915,12 +920,14 @@ static int __cgroup_bpf_attach(struct cgroup 
>>> *cgrp,
>>>       if (old_prog) {
>>>           pl->prog = old_prog;
>>>           pl->link = NULL;
>>> +        bpf_cgroup_storages_assign(pl->storage, old_storage);
>>>       }
>>
>> [Severity: High]
>> This is a pre-existing issue, but since this patch tightens the error 
>> handling
>> and rollbacks in __cgroup_bpf_attach(), should we also restore the 
>> original
>> pl->flags here?
> 
> 
>>
>> Earlier in the function, pl->flags is overwritten with the incoming 
>> flags:
>>
>>     pl->prog = prog;
>>     pl->link = link;
>>     pl->flags = flags;
>>
>> If update_effective_progs() later fails (e.g., due to memory allocation

update_effective_progs() is unlikely to fail, whereas 
bpf_trampoline_link_cgroup_shim() can fail.

In __cgroup_bpf_attach(), when replacing an existing bpf_link in a 
single-attach scenario, old_prog is NULL while old_link holds the active 
link. If attachment fails mid-way during 
bpf_trampoline_link_cgroup_shim() or update_effective_progs(), the 
cleanup path checks if (!old_prog). This incorrectly identifies the 
existing pl entry as newly allocated and wrongly frees it via kfree(), 
triggering a Use-After-Free (UAF) bug.

To resolve this cleanly, I will split this into two individual patches.

> 
> It's hard to make update_effective_progs fail in __cgroup_bpf_attach, as 
> it will failed only when allocating failed:
> 
> progs = bpf_prog_array_alloc(cnt, GFP_KERNEL);
> 
> failed for the above alloc is not a high issue, as cnt max is no more 
> than BPF_CGROUP_MAX_PROGS.
> 
>> failure), the error path restores pl->prog, pl->link, and pl->storage, 
>> but
>> misses pl->flags. If a user attempts to replace a program using 
>> BPF_F_REPLACE
>> with different BPF_F_PREORDER settings and the replacement fails, 
>> could this
>> leave the original program active but with its execution order silently
>> corrupted?
>>
>>>       bpf_cgroup_storages_free(new_storage);
>>>       if (!old_prog) {
>>>           hlist_del(&pl->node);
>>>           kfree(pl);
>>>       }
>>> +    cgrp->bpf.flags[atype] = old_flags;
>>>       return err;
>>>   }
>>

