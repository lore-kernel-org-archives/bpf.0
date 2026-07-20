Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A640B38B
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549208; cv=none; b=Lu95+QHZq1QDwJeR9FKv6pjYs6PprZrxU1kGGhv2HwNDK+vV/GIlxBE914yV+DJ9UyCUWa19Nm4f4olaxc/LRJbEaS45+3jWRfg51r+fcF2I/O5/EfmVJ/mO18F7sGL7lu8jGtARHvtnQ8jVTmJ9Ky+6ABuI9Kmep3ymH5lJNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549208; c=relaxed/simple;
	bh=W9ysGgeud+PgmmG660NwiP8TFxSwk5U4/dvu7RQNEKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+ZxBqpXC12KMQ/mSDd+ppt9aXvGQeCN3AfT8l9EdcWjWjWp6iPXF2N8tGMw1MgQdcnCEtNfr/P7oxIqtgSwr70XFCkc/ruBDcHQq6k//JmxSyK4gVPaut0Rf4q3hzVDlHNV/S+CMrqgnIMLxFTjp3nIjG9HiBgjjwDc1+3lniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3fPL182mzYQtKL
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:06:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B2BFA4058C
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 20:06:39 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3RKVOD15qZu6WBw--.27241S2;
	Mon, 20 Jul 2026 20:06:39 +0800 (CST)
Message-ID: <129fd2d4-ba44-4aff-baff-7a2cf86564ba@huaweicloud.com>
Date: Mon, 20 Jul 2026 20:06:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/3] bpf, cgroup: Fix storage not restored when
 update_effective_progs failed
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260720033055.1215477-1-pulehui@huaweicloud.com>
 <20260720033055.1215477-3-pulehui@huaweicloud.com>
 <20260720034110.19AB51F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260720034110.19AB51F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgB3RKVOD15qZu6WBw--.27241S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUZw4DZF1DAFW7Jw1rtFb_yoW5ZFWUpF
	n5Zas8G3Wqq395Ar4kt34xuF48Jw48XryYkr98tryrCF42gF9YgryxJayY9Fy3CFnruw1I
	yryYvF4qk3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 11:41, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Uninitialized memory is read when saving `pl->storage` into `old_storage` for newly allocated `bpf_prog_list` entries.
> 
> Pre-existing issues:
> - [High] If the first program attach to a cgroup fails, `cgrp->bpf.flags[atype]` is not rolled back, leading to a complete bypass of ancestor mandatory security policies.
> --
> 
> --- Patch [2]: [PATCH bpf v3 2/3] bpf, cgroup: Fix storage not restored when update_effective_progs failed ---
> commit 30470afb00630f3ed1a914958997d62e12b1f60a
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, cgroup: Fix storage not restored when update_effective_progs failed
> 
> In __cgroup_bpf_attach(), if update_effective_progs() fails, pl->storage
> is not restored to old_storage. This patch saves the old_storage before
> assigning the new one, and restores it in the error path.
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
> [ ... ]
>> @@ -883,6 +884,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>   	pl->prog = prog;
>>   	pl->link = link;
>>   	pl->flags = flags;
>> +	bpf_cgroup_storages_assign(old_storage, pl->storage);
> 
> [Severity: Medium]
> When __cgroup_bpf_attach() allocates a new bpf_prog_list entry, it does so
> without zeroing the memory:
> 
>          pl = kmalloc_obj(*pl);
> 
> Because pl is not zero-initialized, does calling bpf_cgroup_storages_assign()
> here result in reading uninitialized garbage pointers from pl->storage and
> copying them into old_storage? This could trigger KMSAN uninit-value warnings
> when attaching a new program.

will fix in next

> 
>>   	bpf_cgroup_storages_assign(pl->storage, storage);
>>   	cgrp->bpf.flags[atype] = saved_flags;
>>   
> [ ... ]
>> @@ -916,6 +918,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>   		pl->prog = old_prog;
>>   		pl->link = NULL;
>>   	}
>> +	bpf_cgroup_storages_assign(pl->storage, old_storage);
>>   	bpf_cgroup_storages_free(new_storage);
>>   	if (!old_prog) {
>>   		hlist_del(&pl->node);
>>   		kfree(pl);
>>   	}
>>   	return err;
>>   }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the error path, if
> the very first program attach to a cgroup fails (for example, if
> update_effective_progs() fails), the newly added list entry is deleted and
> freed here, making the list empty again.
> 
> However, the flags set earlier in the function are not rolled back:
> 
>          cgrp->bpf.flags[atype] = saved_flags;
> 
> Could an attacker attempt an attach with BPF_F_ALLOW_MULTI, intentionally
> force an error (like hitting memory limits in update_effective_progs()), and
> leave the compromised cgroup with permanently altered BPF flags?
> 
> If the flags stay stuck, does this allow bypassing mandatory, non-overridable
> programs from ancestor cgroups during compute_effective_progs()?
> 

It's hard to make update_effective_progs fail in __cgroup_bpf_attach, 
but for the sake of code rigor, I will include the storage and flags 
rollbacks in the original bugfix patch.

