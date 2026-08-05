Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E873C5DCD;
	Wed,  5 Aug 2026 03:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900588; cv=none; b=f5x4qcTy87Hs7wHMye5bG6+co31iBxQzgS7/vCnPIt2TM5F1kemvXUqkRlrAvOIZ2E96BBFbm3QRhpgATSG6+JK5rWupkE0UU9y3BUKT7YRvTQZP4O/DgZxUeFZRL+ej45mkHslHxAYR/BaU5PLLGqAHymhBUZ4TJydAbknAnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900588; c=relaxed/simple;
	bh=rRXWDY7VygmgMC2YEi1GtsoTQkVpHedRnp/pbvBdmAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ3KmhjXT1Oz/dbvD1AqJv7uBSHQkTP6cecDK9+78VdPFoYMZAqGT5zSeAVx2xO33M0solT2vDz29ndeccENjsOWPBhMOv7gr6DRG16yJWEEMEhTSzknaEHAjZmpremS1Oi+HJ9q9l1wmSE7TH/H2SFzK5rXFU5UFVv8Iu1xe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFG9n2RkBzKHMTv;
	Wed,  5 Aug 2026 11:29:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EE5AA4056B;
	Wed,  5 Aug 2026 11:29:38 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAnYs4hrnJq+5SmBA--.1144S2;
	Wed, 05 Aug 2026 11:29:38 +0800 (CST)
Message-ID: <4701db80-7985-4a5a-8939-e4bd22ae4a18@huaweicloud.com>
Date: Wed, 5 Aug 2026 11:29:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260728133058.2858367-1-pulehui@huaweicloud.com>
 <CAEf4BzbbWsETCtOdsi-sCo2TVFFGi97Z-x1zcNgTANoBkop1rg@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4BzbbWsETCtOdsi-sCo2TVFFGi97Z-x1zcNgTANoBkop1rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnYs4hrnJq+5SmBA--.1144S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8tFWrCF1DKryUWr17ZFb_yoW7JFWkpF
	1kZ3ZxGw1jq3ySvrn7tw42vF1Fqa10qr1jkrZxJw1rCF42yFyFgry7CryY9FyfZFnrWr1I
	yw1YqF4q9w1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/8/5 6:56, Andrii Nakryiko wrote:
> On Tue, Jul 28, 2026 at 6:26 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
>> This occurs in the following scenario:
>> 1. prog A, an empty prog, is attached to a cgrp.
>> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>>     bpf_get_local_storage helper.
>> 3. link_update is called to replace prog A with prog B.
>>
>> The reason is that __cgroup_bpf_replace fails to alloc and assign the
>> required cgrp storage for the incoming replacement prog. Consequently,
>> the new prog inherits an uninit storage, leading to null-ptr-deref panic
>> when kick the new prog.
>>
>> Fix this by properly allocating the storage and comparing the old and
>> new storage pointers. If the storage changed, fallback to
>> update_effective_progs which performs a RCU-safe update of the entire
>> array. If the storage remains unchanged, we can safely retain the
>> fast-path in-place update.
>>
>> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>> v4:
>> - Extract the fix for __cgroup_bpf_attach() into a standalone patch [0].
>> - Add Reviewed-by tag by Amery.
>> - Separate from patchset [1]. (Andrii)
>>
>> Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com [0]
>> Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [1]
>>
>> v3: https://lore.kernel.org/bpf/20260720134547.1289964-5-pulehui@huaweicloud.com
>> - Include the storage and flags rollbacks to patch4 for sake of code rigor,
>>    as it's hard to make update_effective_progs fail in __cgroup_bpf_attach.
>>
>> v2: https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweicloud.com
>> - Fix invalid access for in-place update when storage changed. (Sashiko)
>>
>> v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com
>>
>>   kernel/bpf/cgroup.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 4355ccb78a9c..e2fa0ebeed83 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -1032,11 +1032,17 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>>                                  struct bpf_cgroup_link *link,
>>                                  struct bpf_prog *new_prog)
>>   {
>> +       struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>> +       struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
>> +       enum bpf_cgroup_storage_type stype;
>>          enum cgroup_bpf_attach_type atype;
>> +       bool storage_changed = false;
>>          struct bpf_prog *old_prog;
>>          struct bpf_prog_list *pl;
>>          struct hlist_head *progs;
>>          bool found = false;
>> +       int err;
>>
>>          atype = bpf_cgroup_atype_find(link->link.attach_type, new_prog->aux->attach_btf_id);
>>          if (atype < 0)
>> @@ -1056,10 +1062,39 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>>          if (!found)
>>                  return -ENOENT;
>>
>> +       if (bpf_cgroup_storages_alloc(storage, new_storage, link->link.attach_type,
>> +                                     new_prog, cgrp))
>> +               return -ENOMEM;
>> +
>> +       for_each_cgroup_storage_type(stype) {
>> +               if (storage[stype] != pl->storage[stype]) {
>> +                       storage_changed = true;
>> +                       break;
>> +               }
>> +       }
>> +
>>          cgrp->bpf.revisions[atype] += 1;
>>          old_prog = xchg(&link->link.prog, new_prog);
>> -       replace_effective_prog(cgrp, atype, pl);
>> +
>> +       if (!storage_changed) {
>> +               replace_effective_prog(cgrp, atype, pl);
>> +               bpf_prog_put(old_prog);
>> +               return 0;
>> +       }
>> +
>> +       bpf_cgroup_storages_assign(old_storage, pl->storage);
>> +       bpf_cgroup_storages_assign(pl->storage, storage);
>> +       err = update_effective_progs(cgrp, atype);
>> +       if (err) {
>> +               xchg(&link->link.prog, old_prog);
> 
> I'm not a fan of having this transient link.prog transition from old
> to new and back to old prog if something goes wrong.
> 
> Given this is syzbot (only) reported issue, how about we just check
> that cgroup storage (legacy one at that) of old and new program is
> compatible, and if not, just reject link update? that would be less
> risky change

Ah, I didn't think of that! It seems to be much simpler.

> 
> pw-bot: cr
> 
> 
>> +               bpf_cgroup_storages_assign(pl->storage, old_storage);
>> +               bpf_cgroup_storages_free(new_storage);
>> +               cgrp->bpf.revisions[atype] -= 1;
>> +               return err;
>> +       }
>> +
>>          bpf_prog_put(old_prog);
>> +       bpf_cgroup_storages_link(new_storage, cgrp, link->link.attach_type);
>>          return 0;
>>   }
>>
>> --
>> 2.34.1
>>

