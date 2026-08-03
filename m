Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98128634C;
	Mon,  3 Aug 2026 01:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720483; cv=none; b=FA3dy0rpkjXv95mEmoBbkoSyet+cYxA9805/zRjk39KALeO3VCjEae4fWENS/eUASdqCuYsX6j5l+1Wjr6YY0+CyTYSuGcABcsENOCTyC66pddJ1GGUlcljmrtGPrmtNPZFFlTchRkz86fsXXpYQA3tq0oRS+tzdgfvu+uPxbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720483; c=relaxed/simple;
	bh=Pem6haOE1Mo6y13aG3a0X0QF8yZeA+tbDdy65j6CZ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm4oYHKtZ/lLZADzNPbvP6l83MUFqxlAgmeaU3VJY1SkHWVdWHFhRez4Yuhl9KwsgTSqJfYK6bDT7NHtKtPeBM3Xl2QffzCuJZG6WA/rJDyBiXlctgLE0rqGdvMoBbQPqHbjqaNOygFg6rMu7bxDJKFeoV9cGxJo4P3f+qfGDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hCzYN124FzYQtkV;
	Mon,  3 Aug 2026 09:27:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EB50E4058D;
	Mon,  3 Aug 2026 09:27:52 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAnYs6X7m9q_lWnAw--.57085S2;
	Mon, 03 Aug 2026 09:27:52 +0800 (CST)
Message-ID: <50d3ccff-0021-406c-8934-7477ca317395@huaweicloud.com>
Date: Mon, 3 Aug 2026 09:27:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf, cgroup: Fix invalid storage access after
 __cgroup_bpf_attach failed
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20260729100208.3076769-1-pulehui@huaweicloud.com>
 <DKBP2V5WYH31.3QHSY5V8WTNDD@etsalapatis.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <DKBP2V5WYH31.3QHSY5V8WTNDD@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAnYs6X7m9q_lWnAw--.57085S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4UCr4UGryUtr48CFWDtwb_yoWrGw47pF
	4kZ3Z8G3Z8X39YvF1kt39IvF1rAa10qr1jkrZ0yw1fKFW2gF9YgryIkryY9F9xZF17u3WS
	yF1Y9F4qkF10qFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/30 14:33, Emil Tsalapatis wrote:
> On Wed Jul 29, 2026 at 6:02 AM EDT, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Sashiko reported a potential invalid storage access issue after
>> replacing a cgroup bpf prog.
>>
> 
> Nit: No need to mention Sashiko reports in the commit message imo,
> the Reported-by is enough and imo it makes it confusing for people
> not familiar with the system.

alright, will respin soon.

> 
>> This occurs in the following scenario:
>> 1. prog1 with storage is attached to a cgroup in multi-attach mode.
>> 2. prog1 is replaced with prog2 using BPF_F_REPLACE in multi-attach
>>     mode, but fails midway (e.g. in bpf_trampoline_link_cgroup_shim or
>>     update_effective_progs).
>> 3. A new prog3 is attached to the cgroup in multi-attach mode.
>>
>> The reason is that __cgroup_bpf_attach overwrites pl->storage with the
>> new storage prior to attachment completion. When attachment fails
>> midway, the cleanup path calls bpf_cgroup_storages_free(new_storage) to
>> free the newly allocated storage, but fails to restore pl->storage back
>> to old_storage.
>>
>> Consequently, the still-active prog1 holds invalid or dangling storage
>> pointers, leading to an invalid memory access when prog1 executes and
>> calls bpf_get_local_storage. Additionally, original pl->flags and
>> cgrp->bpf.flags[atype] are left unrestored.
>>
>> Fix this by saving old_pl_flags, old_storage, and old_flags prior to the
>> update, and properly restoring all of them in the cleanup path on error.
>>
>> Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
>> ---
>> v2:
>> - Remove the link relative code as link only support
>>    BPF_F_ALLOW_MULTI attach, so will not occur UAF pl.
>>
>> v1: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com
>>
>>   kernel/bpf/cgroup.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index e2fa0ebeed83..be24ca453cab 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -813,8 +813,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>   	struct bpf_prog *old_prog = NULL;
>>   	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>>   	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>> +	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>>   	struct bpf_prog *new_prog = prog ? : link->link.prog;
>>   	enum cgroup_bpf_attach_type atype;
>> +	u32 old_flags, old_pl_flags;
>>   	struct bpf_prog_list *pl;
>>   	struct hlist_head *progs;
>>   	int err;
>> @@ -865,6 +867,8 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>   
>>   	if (pl) {
>>   		old_prog = pl->prog;
>> +		old_pl_flags = pl->flags;
>> +		bpf_cgroup_storages_assign(old_storage, pl->storage);
>>   	} else {
>>   		pl = kmalloc_obj(*pl);
>>   		if (!pl) {
>> @@ -884,6 +888,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>   	pl->link = link;
>>   	pl->flags = flags;
>>   	bpf_cgroup_storages_assign(pl->storage, storage);
>> +	old_flags = cgrp->bpf.flags[atype];
>>   	cgrp->bpf.flags[atype] = saved_flags;
>>   
>>   	if (type == BPF_LSM_CGROUP) {
>> @@ -915,12 +920,15 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>>   	if (old_prog) {
>>   		pl->prog = old_prog;
>>   		pl->link = NULL;
>> +		pl->flags = old_pl_flags;
>> +		bpf_cgroup_storages_assign(pl->storage, old_storage);
>>   	}
>>   	bpf_cgroup_storages_free(new_storage);
>>   	if (!old_prog) {
>>   		hlist_del(&pl->node);
>>   		kfree(pl);
>>   	}
>> +	cgrp->bpf.flags[atype] = old_flags;
>>   	return err;
>>   }
>>   

