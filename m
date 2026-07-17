Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A03DC4A9
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272750; cv=none; b=ubRd3479KAc0fb7Kg8rDUuQmmtltqu0mIVFVqdMq7rTlF9vLu1Gt2WGzGbKItL1JhfCslsR5QYy31jRUA9jSNUrrdx0ROZl18VG7KRkxSo4roBVe0boqyqoo1+nVlN2kaUfL1v0PSXO1N1UKdeDTSPGbS+dYTBbZLjKtt6DhYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272750; c=relaxed/simple;
	bh=4XV5j8l+ZaaMiZ3dJH+bmX/koa4RnjUehAxPZxq37ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6LSNkcbWmlIW0RzsWLta8UKa7fqgVXec1qPuioQL8Zjbq52GqTotwd+tcniYDTu0DfNQrDr8nMqXbdB9h5KRMNplCCAGgIyAYP+sClHJWK6KJnTumuuA7LdiVp9Q3Q0t5NXHPhcpILchLw2Sh+4WfYSmeVkruZbGWWFcgepTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h1h8z35kPzYQtLm
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:18:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 807114098A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:19:03 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAH7Shm11lq0ygiBg--.18846S2;
	Fri, 17 Jul 2026 15:19:03 +0800 (CST)
Message-ID: <5890190e-125c-4555-bf35-f9e7003ee08d@huaweicloud.com>
Date: Fri, 17 Jul 2026 15:19:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260714014659.401063-1-pulehui@huaweicloud.com>
 <20260714015658.123021F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260714015658.123021F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAH7Shm11lq0ygiBg--.18846S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykGF1rtFWUtrWrWF47XFb_yoW5XF4kpF
	WDAr95u34DJwnYvrnrt3yIvF18ZF1ktF15KrZ8Xw4xCr4SqFyFgrySg3y5uFZ3Zrnruw10
	qr1Yvw4vkr12vFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/14 9:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] In-place updates of `item->cgroup_storage` in the active RCU-protected `bpf_prog_array` cause data races with concurrent RCU readers, leading to NULL pointer dereferences or Out-Of-Bounds memory accesses.
> --
> 
> --- Patch [1]: [PATCH bpf] bpf, cgroup: Fix storage null-ptr-deref after replacing prog ---
> commit 3d155d588030a7a30403e9ee7737c108f47b5cb3
> Author: Pu Lehui <pulehui@huawei.com>
> 
> bpf, cgroup: Fix storage null-ptr-deref after replacing prog
> 
> This commit fixes a storage null pointer dereference when replacing a
> program by allocating, assigning, and linking the required cgroup storage
> for the replacement program during link_update.
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 4355ccb78a9c6..52b5b685a93c5 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1014,6 +1014,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
>>   				desc->bpf.effective[atype],
>>   				lockdep_is_held(&cgroup_mutex));
>>   		item = &progs->items[pos];
>> +		bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> 
> [Severity: High]
> Does this in-place update of item->cgroup_storage create a data race with
> concurrent RCU readers?
> 
> If CPU1 is executing bpf_prog_run_array_cg() under the RCU read lock and
> starts running the old program:
> 
> CPU1:
> bpf_prog_run_array_cg()
>      while ((prog = READ_ONCE(item->prog))) {
>          run_ctx.prog_item = item;
>          func_ret = run_prog(prog, ctx);
> 
> And CPU2 concurrently replaces the program with one that doesn't use storage,
> it updates the storage in-place:
> 
> CPU2:
> replace_effective_prog()
>      bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
>      WRITE_ONCE(item->prog, pl->link->link.prog);
> 
> If CPU1's executing program then calls bpf_get_local_storage(), it could
> read the updated NULL storage pointer while still executing the old program:
> 
> CPU1:
> bpf_get_local_storage()
>      storage = ctx->prog_item->cgroup_storage[stype];
>      if (stype == BPF_CGROUP_STORAGE_SHARED)
>          ptr = &READ_ONCE(storage->buf)->data[0];
> 
> Could this lead to a NULL pointer dereference or out-of-bounds access?

Sashiko is right. When the storage changes, rcu readers calling 
bpf_get_local_storage could trigger an invalid access. Therefore, for 
scenarios where the storage changes, we need to fallback to RCU-safe 
operations, update_effective_progs. I will fix this in the next version.

> 
>>   		WRITE_ONCE(item->prog, pl->link->link.prog);
>>   	}
>>   }
> 

