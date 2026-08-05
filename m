Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260330D40F;
	Wed,  5 Aug 2026 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903548; cv=none; b=qKCCZY90iqCfxHTKl/oQY7b6k0/kdIHVZDUE7+QAH/5XDwm73Dl62yemiAtaL/9ajqT9JTIlyYEhpxbL0ilEo6xBciGW7/GorXQkS36gFI2h+MXVvet5++SM43DPfbZmjKwh9AQ8I8nnY/6MvsB/eiGuNX6zRIThJb5Tc5Xx/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903548; c=relaxed/simple;
	bh=oZJZraMK13FyH+wy77uTJ6GK383KIsW0v9B1IgSt8tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN5Nzy5a4I7pQnGAWzLtB/Us5GL7/gtXorPv+YcMlev6TuZWcX5nfppOuQO1LGlOdL/Zvl3PYB5AypVHJUeHb8VAIEFkQ+6MjsbIoMZEP6pEevAjb2Ep7ESRKBmzyPWz/RgRkxwvJD5FjGpGavOd7YMXaI/9zL4c5jKCOGbr2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFHFq1k0GzYQtwG;
	Wed,  5 Aug 2026 12:18:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ACAA24056E;
	Wed,  5 Aug 2026 12:18:59 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAnY8+zuXJqh8mqBA--.10709S2;
	Wed, 05 Aug 2026 12:18:59 +0800 (CST)
Message-ID: <5e5c449a-7453-486d-ac42-b2e3f70330ca@huaweicloud.com>
Date: Wed, 5 Aug 2026 12:18:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] bpf: Fix UAF when reading prog type in
 bpf_mprog_link
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260728074223.2831773-1-pulehui@huaweicloud.com>
 <da7357fe-9d64-4e9c-a0f6-573a9761c8b2@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <da7357fe-9d64-4e9c-a0f6-573a9761c8b2@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnY8+zuXJqh8mqBA--.10709S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWfGrykKrWUJFWrZw47urg_yoW7KF47pF
	s5JryUGryUWr18Xr1Utr1UAryUXr1UJ3WUJr1UXF1UAr17Xr1jqr4UWr1Ygr15Jr4kGr48
	Jr1jqrnrZryUXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/8/4 3:00, Daniel Borkmann wrote:
> On 7/28/26 9:42 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In bpf_mprog_link, the code currently allows a user to pass an abnormal
>> non-netkit or non-tcx link via relative_fd. If a concurrent
>> BPF_LINK_UPDATE is performed on this abnormal link before dereferencing
>> link->prog->type in bpf_mprog_link(), it can trigger a UAF issue.
>>
>> CPU0                                      CPU1
>> netkit_link_prog_attach
>> bpf_mprog_attach
>> bpf_mprog_tuple_relative
>> bpf_mprog_link
>>    /* non-netkit or non-tcx link */
>>    link = bpf_link_get_from_fd(id_or_fd);
>>                                            BPF_LINK_UPDATE on relative 
>> link
>>                                            ...
>>                                            old_prog = 
>> xchg(&link->link.prog, new_prog);
>>                                            bpf_prog_put(old_prog);
>>    if (type && link->prog->type != type) <-- trigger UAF
>>
>> The reason for the UAF is that each subsystem provides its own
>> protection for link->prog. Since there is no cross subsystem protection
>> (if not considering the RCU of prog tear down), dereferencing the prog
>> of an anchor link that does not belong to the current subsystem is not
>> safe: it may have been freed.
>>
>> To resolve this, we access link->prog under RCU protection to safely
>> fetch the pointer and guarantee its lifetime during the type check.
>> Meanwhile, add a comment explaining that when ptype == UNSPEC in
>> bpf_mprog_detach, it acts as a wildcard.
>>
>> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for 
>> multi-progs")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>> v4:
>> - Access prog->type under rcu protection to simplify the repair logic,
>>    and let unconditional detachment make sense when the bare prog or
>>    link->prog being detached is NULL.
>> - Add Reviewed-by tag by Emil.
>> - Separate from patchset [0]. (Andrii)
>>
>> Link: 
>> https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [0]
>>
>> v3: 
>> https://lore.kernel.org/bpf/20260722072326.1545677-3-pulehui@huaweicloud.com
>> - BPF_F_LINK flag set means the relative id_or_fd is a link, not the 
>> object being
>>    attached. We can not get the link while attach a bare prog with 
>> relative link.
>>    So passing expected link type from callers of 
>> bpf_mprog_attach/detach. (Sashiko)
>> - Add comment to explain that why ptype == UNSPEC. (Emil)
>>
>> v2: 
>> https://lore.kernel.org/bpf/20260721041048.1394085-3-pulehui@huaweicloud.com
>> - Improve commit msg for patch 2. (Amery)
>>
>> v1: 
>> https://lore.kernel.org/bpf/20260720134547.1289964-3-pulehui@huaweicloud.com
>>
>>   kernel/bpf/mprog.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> index 1394168062e8..af3e6c1c6a1f 100644
>> --- a/kernel/bpf/mprog.c
>> +++ b/kernel/bpf/mprog.c
>> @@ -10,6 +10,8 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>   {
>>       struct bpf_link *link = ERR_PTR(-EINVAL);
>>       bool id = flags & BPF_F_ID;
>> +    bool type_mismatch = false;
>> +    struct bpf_prog *prog;
>>       if (id)
>>           link = bpf_link_by_id(id_or_fd);
>> @@ -17,13 +19,20 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>           link = bpf_link_get_from_fd(id_or_fd);
>>       if (IS_ERR(link))
>>           return PTR_ERR(link);
>> -    if (type && link->prog->type != type) {
>> +
>> +    rcu_read_lock();
>> +    prog = READ_ONCE(link->prog);
>> +    if (!prog || (type && prog->type != type))
>> +        type_mismatch = true;
>> +    rcu_read_unlock();
> 
> Hm, what about progs under rcu_read_lock_trace cases, wouldn't the UAF
> still be there?
> 
> Even though the diff is smaller, I'd kind of lean towards link->type
> testing since this addresses the underlying issue and avoids touching
> the prog completely.. do you want me to look into it and also add a
> BPF selftest to it as patch 2/2?

Hi Daniel, that would be awesome! I'd be very happy for you to look into 
it and add the selftest.

FWIW, I actually tried the link->type check earlier [0], but it seemed 
to remove the wildcard semantics during detach and might break the 
interface. Thanks a lot!

[0] 
https://lore.kernel.org/bpf/20260722072326.1545677-3-pulehui@huaweicloud.com

> 
>> +    if (type_mismatch) {
>>           bpf_link_put(link);
>>           return -EINVAL;
>>       }
>>       tuple->link = link;
>> -    tuple->prog = link->prog;
>> +    tuple->prog = prog;
>>       return 0;
>>   }
>> @@ -343,8 +352,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>       if (!bpf_mprog_total(entry))
>>           return -ENOENT;
>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>> -                       prog ? prog->type :
>> -                       BPF_PROG_TYPE_UNSPEC);
>> +                       /* Use UNSPEC as wildcard when prog is NULL */
>> +                       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
>>       if (ret)
>>           return ret;
>>       if (dtuple.prog) {

