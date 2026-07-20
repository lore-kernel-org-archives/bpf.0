Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59A2D94BA
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517080; cv=none; b=ZM+bN+6NUKPOIP1m+spFvLQXbtEb6tLSn71K4uKHLUcUaII2H4wiTvKUcVjRHyRvoB4nJLs2v471fZLReYfJg0z2VObsjYdwy27fH70wz47wnQ11HMz58LQksa2zd34o7KyDgALXu839ybn1OroSY1jS7V+xCV7N9rVigBPgNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517080; c=relaxed/simple;
	bh=jjhsPF6TSZ/m41A0kxlzGYPJ5SgkMYeQROxh5fsdnmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1XCIwjbP+Ec8BuxkRFTpJqRiFIMEbWT9MUkcdJqzewOVjX6vToBbYgGVQZ2umIslWm8eGbAJQ38odZjGX/m2PTjW3/zEy4zpNRPZaZ8oKYqwNTX/tNUu+UURY3MrbbTijVtm3ErVDMTynpXvPTrMAZYb47Tn9AVL3g21Le9yX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h3QW918MgzKHMZf
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:10:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ED1C74056E
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:11:08 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3q1zLkV1qHb5+Bw--.65160S2;
	Mon, 20 Jul 2026 11:11:08 +0800 (CST)
Message-ID: <af398f5d-213d-46e3-8bd3-4432f40022f8@huaweicloud.com>
Date: Mon, 20 Jul 2026 11:11:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260717073343.958862-1-pulehui@huaweicloud.com>
 <20260717080028.7C9F11F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260717080028.7C9F11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3q1zLkV1qHb5+Bw--.65160S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZw47uF4xXFWUZFy3XFb_yoWrCw18pF
	1DJFn8tw15JwsYvr4kXwn2vFyrXa18Xr1YkrZ8tw1ruF4YyFWFgry7urWY9FyfuFn7uw1I
	vws0qF4qkr1jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/17 16:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lockless access to `link->prog` in `bpf_link_show_fdinfo` can race with program replacement, leading to a use-after-free.
> - [High] `__cgroup_bpf_attach` fails to restore `pl->storage` on its error path, leaving dangling pointers when replacing a BPF program.
> --
> 
> --- Patch [1]: [PATCH bpf v2] bpf, cgroup: Fix storage null-ptr-deref after replacing prog ---
> commit 1bd69188dee95afa5142df58a443716090d9272e
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, cgroup: Fix storage null-ptr-deref after replacing prog
> 
> This commit addresses a null pointer dereference caused when an empty BPF
> program is replaced by one requiring cgroup storage. It properly allocates
> the new storage and checks if the storage pointers changed to decide between
> an in-place update or a full RCU-safe replacement array update.
> 
> Link: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 4355ccb78a9c6..e2fa0ebeed830 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1032,11 +1032,17 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>>   				struct bpf_cgroup_link *link,
>>   				struct bpf_prog *new_prog)
>>   {
> 
> [ ... ]
> 
>> @@ -1056,10 +1062,39 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>>   	if (!found)
>>   		return -ENOENT;
>>   
>> +	if (bpf_cgroup_storages_alloc(storage, new_storage, link->link.attach_type,
>> +				      new_prog, cgrp))
>> +		return -ENOMEM;
>> +
>> +	for_each_cgroup_storage_type(stype) {
>> +		if (storage[stype] != pl->storage[stype]) {
>> +			storage_changed = true;
>> +			break;
>> +		}
>> +	}
>> +
>>   	cgrp->bpf.revisions[atype] += 1;
>>   	old_prog = xchg(&link->link.prog, new_prog);
>> -	replace_effective_prog(cgrp, atype, pl);
>> +
>> +	if (!storage_changed) {
>> +		replace_effective_prog(cgrp, atype, pl);
>> +		bpf_prog_put(old_prog);
> 
> [Severity: High]
> This is a pre-existing issue, but does dropping the reference to old_prog
> here introduce a race condition with lockless readers like
> bpf_link_show_fdinfo() in kernel/bpf/syscall.c?
> 
> If a user reads the fdinfo of the cgroup link, bpf_link_show_fdinfo() reads
> link->prog without holding a lock or taking a reference:
> 
> kernel/bpf/syscall.c:bpf_link_show_fdinfo() {
> 	...
> 	prog = link->prog;
> 	...
> 	if (prog) {
> 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> 		...
> 	}
> }
> 
> If __cgroup_bpf_replace() is called concurrently, it replaces link->prog via
> xchg() and immediately releases old_prog. If the RCU grace period elapses
> before bpf_link_show_fdinfo() accesses prog->tag, could this result in a
> use-after-free?
> 
>> +		return 0;
>> +	}
>> +
>> +	bpf_cgroup_storages_assign(old_storage, pl->storage);
>> +	bpf_cgroup_storages_assign(pl->storage, storage);
>> +	err = update_effective_progs(cgrp, atype);
>> +	if (err) {
>> +		xchg(&link->link.prog, old_prog);
>> +		bpf_cgroup_storages_assign(pl->storage, old_storage);
> 
> [Severity: High]
> This is a pre-existing issue, but while this rollback correctly restores
> pl->storage in __cgroup_bpf_replace(), does the error path in
> __cgroup_bpf_attach() have a similar issue?
> 
> In __cgroup_bpf_attach(), if update_effective_progs() fails, the code restores
> pl->prog but seems to miss restoring pl->storage before freeing the newly
> allocated storage:
> 
> kernel/bpf/cgroup.c:__cgroup_bpf_attach() {
> 	...
> 	bpf_cgroup_storages_assign(pl->storage, storage);
> 	err = update_effective_progs(cgrp, atype);
> 	if (err)
> 		goto cleanup;
> 	...
> cleanup:
> 	if (old_prog) {
> 		pl->prog = old_prog;
> 		pl->link = NULL;
> 	}
> 	bpf_cgroup_storages_free(new_storage);
> 	...
> }
> 
> Since pl->storage was overwritten but never restored, does freeing
> new_storage leave pl->storage with dangling pointers?
> 
>> +		bpf_cgroup_storages_free(new_storage);
>> +		cgrp->bpf.revisions[atype] -= 1;
>> +		return err;
>> +	}
>> +
>>   	bpf_prog_put(old_prog);
>> +	bpf_cgroup_storages_link(new_storage, cgrp, link->link.attach_type);
>>   	return 0;
>>   }
> 

