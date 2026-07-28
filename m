Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142A18C933;
	Tue, 28 Jul 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203792; cv=none; b=kvODegwC2R+bcdPfTM4SJkv9e24q7904cfTdUo8LLbSfVynHgPxDla3qQs2OhbJGils0ceNFIjWXBcx84GQl+Xft6kaDmAkiGJrfKWe0XW3fodwKuOK3vE+KcDra/khSUyA6+U+tpitkgt5jV0rfJBvoV/AWLKkTNg8FDGS+8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203792; c=relaxed/simple;
	bh=/+RjkPH3LEnm3g5v1LmTqvzV0sPc2CtkBu0NeWz7bck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uzMHPtIaWFyddflPNUDqamdE13xnNPax4yQfdTfGcFA/Qfenb80fuF/yC2vWGB2rfvcncmKtZCh34QWyHLJnpmcoz2INORkEjmammxLUvABhPN1v+wjQJI8dKFCZG/HlrhEwYpCjq+MVnDwLZ+rRRJmE4PacVvc1ZnJBgyPUs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5G6fxpTS; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5G6fxpTS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=I9VD8jzTAo2D/M7rntuSl8R9mzTGxb89q9BBN7DIntA=;
	b=5G6fxpTSENSpXCegfT1uh+T3xaZjjHBOayz0VDGz3OOYuSH6rB6bHPkrLagf3/p+UdNijlzAm
	ETVFfqmRFfajvWaFJ7nq20rb+zAlhJ+YMc6lperTMtPSL1KcJkMl9UhCjbiyt+mZAZFZUWl6Rig
	CqtFCd2kQugxOqhl6EjqpDY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h8JH06chLz12LFy;
	Tue, 28 Jul 2026 09:46:52 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 82AD340537;
	Tue, 28 Jul 2026 09:56:23 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 28 Jul
 2026 09:56:22 +0800
Message-ID: <02ab6310-8457-43f9-81f2-642a1e3f6e58@huawei.com>
Date: Tue, 28 Jul 2026 09:56:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 2/4] bpf: Fix UAF due to missing link type check in
 mprog
Content-Language: en-US
To: Emil Tsalapatis <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Song Liu
	<song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
	<pulehui@huaweicloud.com>, Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko
	<mykyta.yatsenko5@gmail.com>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-3-pulehui@huaweicloud.com>
 <DK58NPCIRLIH.SMOILLVYTZ1Q@etsalapatis.com>
 <3c41af85-0dc2-4c84-8745-b7d37b7b37f5@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <3c41af85-0dc2-4c84-8745-b7d37b7b37f5@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)

Hi Emil,

Gentle ping~, is that acceptable to you?

On 2026/7/23 11:14, Pu Lehui wrote:
> 
> On 2026/7/23 0:25, Emil Tsalapatis wrote:
>> On Wed Jul 22, 2026 at 3:23 AM EDT, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> In bpf_mprog_link, the code does not check the link->type first before
>>> dereferencing link->prog->type. This missing validation allows a user to
>>> pass an abnormal non-netkit or non-tcx link via relative_fd. If doing
>>> BPF_LINK_UPDATE on the abnormal link, it can trigger a UAF issue.
>>>
>>> CPU0                                      CPU1
>>> netkit_link_prog_attach
>>> bpf_mprog_attach
>>> bpf_mprog_tuple_relative
>>> bpf_mprog_link
>>>    /* non-netkit or non-tcx link */
>>>    link = bpf_link_get_from_fd(id_or_fd);
>>>                                            BPF_LINK_UPDATE on 
>>> relative link
>>>                                            ...
>>>                                            old_prog = 
>>> xchg(&link->link.prog, new_prog);
>>>                                            bpf_prog_put(old_prog);
>>>    if (type && link->prog->type != type) <-- trigger UAF
>>>
>>> The reason for the UAF is that each subsystem provides its own
>>> protection for link->prog. Since there is no cross subsystem protection
>>> (if not considering the RCU of prog tear down), dereferencing the prog
>>> of an anchor link that does not belong to the current subsystem is not
>>> safe: it may have been freed. Therefore, we need to validate link->type
>>> to reject foreign anchors.
>>>
>>> Fix this by strictly validating link->type in bpf_mprog_link against the
>>> expected link type. mprog APIs is also adjusted to accept and pass down
>>> the expected link type. Meanwhile, add a comment explaining that when
>>> ptype == UNSPEC in bpf_mprog_detach, it acts as a wildcard.
>>>
>>> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for 
>>> multi-progs")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Reviewed-by: Amery Hung <ameryhung@gmail.com>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>
>> Unless I'm missing something, at the very least there's no need for the
>> extra argument in detach() since we pass UNSPEC to bpf_mprog_link() and
>> never use it otherwise.
>>
>> Even for the attach case, aren't we required to provide a new link
>> for attachment, and so already have the ltype available to test
>> against?
>>
> Hi Emil,
> 
> The BPF_F_LINK flag only indicates that relative_fd refers to an anchor 
> link or prog; it is independent of whether the object being attached or 
> detached is a bare prog or a link. This means that when attaching or 
> detaching a bare prog relative to an anchor link, we cannot obtain the 
> expected_link_type because the link parameter passed in is NULL.
> 
> Furthermore, as you mentioned, we should support unconditional 
> detachment. But in the current version, because we strictly check 
> expected_link_type, the detach operation will fail if the relative link 
> type does not match.
> 
> Therefore, we can simplify the approach to fix this UAF—similar to patch 
> 3—by relying on RCU protection when accessing the prog type of a 
> relative link. When attaching or detaching a bare prog or a link 
> relative to an anchor link, we simply verify that 
> relative_link->prog->type matches the bare prog->type or 
> link->prog->type. This logic also naturally applies to unconditional 
> detachment with relative link, such as when the bare prog or link->prog 
> being detached is NULL.
> 
> And the patch will be follow, wdyt?
> 
> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> index 1394168062e8..512821c21aa6 100644
> --- a/kernel/bpf/mprog.c
> +++ b/kernel/bpf/mprog.c
> @@ -10,6 +10,8 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>   {
>       struct bpf_link *link = ERR_PTR(-EINVAL);
>       bool id = flags & BPF_F_ID;
> +    bool type_mismatch = false;
> +    struct bpf_prog *prog;
> 
>       if (id)
>           link = bpf_link_by_id(id_or_fd);
> @@ -17,13 +19,20 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>           link = bpf_link_get_from_fd(id_or_fd);
>       if (IS_ERR(link))
>           return PTR_ERR(link);
> -    if (type && link->prog->type != type) {
> +
> +    rcu_read_lock();
> +    prog = READ_ONCE(link->prog); <-- relative_link->prog
> +    if (!prog || (type && prog->type != type))
> +        type_mismatch = true;
> +    rcu_read_unlock();
> +
> +    if (type_mismatch) {
>           bpf_link_put(link);
>           return -EINVAL;
>       }
> 
>       tuple->link = link;
> -    tuple->prog = link->prog;
> +    tuple->prog = prog;
>       return 0;
>   }
> 
>>> ---
>>>   drivers/net/netkit.c      | 13 ++++++-------
>>>   include/linux/bpf_mprog.h |  6 ++++--
>>>   kernel/bpf/mprog.c        | 23 ++++++++++++++---------
>>>   kernel/bpf/tcx.c          | 13 ++++++-------
>>>   4 files changed, 30 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
>>> index a3931cd82132..99ddf2befb23 100644
>>> --- a/drivers/net/netkit.c
>>> +++ b/drivers/net/netkit.c
>>> @@ -768,7 +768,7 @@ int netkit_prog_attach(const union bpf_attr 
>>> *attr, struct bpf_prog *prog)
>>>       }
>>>       ret = bpf_mprog_attach(entry, &entry_new, prog, NULL, 
>>> replace_prog,
>>>                      attr->attach_flags, attr->relative_fd,
>>> -                   attr->expected_revision);
>>> +                   attr->expected_revision, BPF_LINK_TYPE_NETKIT);
>>>       if (!ret) {
>>>           if (entry != entry_new) {
>>>               netkit_entry_update(dev, entry_new);
>>> @@ -802,7 +802,7 @@ int netkit_prog_detach(const union bpf_attr 
>>> *attr, struct bpf_prog *prog)
>>>           goto out;
>>>       }
>>>       ret = bpf_mprog_detach(entry, &entry_new, prog, NULL, 
>>> attr->attach_flags,
>>> -                   attr->relative_fd, attr->expected_revision);
>>> +                   attr->relative_fd, attr->expected_revision, 
>>> BPF_LINK_TYPE_NETKIT);
>>>       if (!ret) {
>>>           if (!bpf_mprog_total(entry_new))
>>>               entry_new = NULL;
>>> @@ -850,7 +850,7 @@ static int netkit_link_prog_attach(struct 
>>> bpf_link *link, u32 flags,
>>>       ASSERT_RTNL();
>>>       entry = netkit_entry_fetch(dev, true);
>>>       ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, 
>>> NULL, flags,
>>> -                   id_or_fd, revision);
>>> +                   id_or_fd, revision, BPF_LINK_TYPE_NETKIT);
>>>       if (!ret) {
>>>           if (entry != entry_new) {
>>>               netkit_entry_update(dev, entry_new);
>>> @@ -877,7 +877,7 @@ static void netkit_link_release(struct bpf_link 
>>> *link)
>>>           ret = -ENOENT;
>>>           goto out;
>>>       }
>>> -    ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 
>>> 0, 0);
>>> +    ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 
>>> 0, 0, BPF_LINK_TYPE_NETKIT);
>>>       if (!ret) {
>>>           if (!bpf_mprog_total(entry_new))
>>>               entry_new = NULL;
>>> @@ -919,9 +919,8 @@ static int netkit_link_update(struct bpf_link 
>>> *link, struct bpf_prog *nprog,
>>>           ret = -ENOENT;
>>>           goto out;
>>>       }
>>> -    ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
>>> -                   BPF_F_REPLACE | BPF_F_ID,
>>> -                   link->prog->aux->id, 0);
>>> +    ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog, 
>>> BPF_F_REPLACE | BPF_F_ID,
>>> +                   link->prog->aux->id, 0, BPF_LINK_TYPE_NETKIT);
>>>       if (!ret) {
>>>           WARN_ON_ONCE(entry != entry_new);
>>>           oprog = xchg(&link->prog, nprog);
>>> diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
>>> index 0b9f4caeeb0a..1fbe1a923968 100644
>>> --- a/include/linux/bpf_mprog.h
>>> +++ b/include/linux/bpf_mprog.h
>>> @@ -321,12 +321,14 @@ int bpf_mprog_attach(struct bpf_mprog_entry 
>>> *entry,
>>>                struct bpf_mprog_entry **entry_new,
>>>                struct bpf_prog *prog_new, struct bpf_link *link,
>>>                struct bpf_prog *prog_old,
>>> -             u32 flags, u32 id_or_fd, u64 revision);
>>> +             u32 flags, u32 id_or_fd, u64 revision,
>>> +             enum bpf_link_type expected_link_type);
>>>   int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>>                struct bpf_mprog_entry **entry_new,
>>>                struct bpf_prog *prog, struct bpf_link *link,
>>> -             u32 flags, u32 id_or_fd, u64 revision);
>>> +             u32 flags, u32 id_or_fd, u64 revision,
>>> +             enum bpf_link_type expected_link_type);
>>>   int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr 
>>> __user *uattr,
>>>               struct bpf_mprog_entry *entry);
>>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>>> index 1394168062e8..b4a1b35ff569 100644
>>> --- a/kernel/bpf/mprog.c
>>> +++ b/kernel/bpf/mprog.c
>>> @@ -6,7 +6,7 @@
>>>   static int bpf_mprog_link(struct bpf_tuple *tuple,
>>>                 u32 id_or_fd, u32 flags,
>>> -              enum bpf_prog_type type)
>>> +              enum bpf_link_type type)
>>>   {
>>>       struct bpf_link *link = ERR_PTR(-EINVAL);
>>>       bool id = flags & BPF_F_ID;
>>> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>>           link = bpf_link_get_from_fd(id_or_fd);
>>>       if (IS_ERR(link))
>>>           return PTR_ERR(link);
>>> -    if (type && link->prog->type != type) {
>>> +    if (type && link->type != type) {
>>>           bpf_link_put(link);
>>>           return -EINVAL;
>>>       }
>>> @@ -52,21 +52,22 @@ static int bpf_mprog_prog(struct bpf_tuple *tuple,
>>>   static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
>>>                       u32 id_or_fd, u32 flags,
>>> -                    enum bpf_prog_type type)
>>> +                    enum bpf_link_type ltype,
>>> +                    enum bpf_prog_type ptype)
>>>   {
>>>       bool link = flags & BPF_F_LINK;
>>>       bool id = flags & BPF_F_ID;
>>>       memset(tuple, 0, sizeof(*tuple));
>>>       if (link)
>>> -        return bpf_mprog_link(tuple, id_or_fd, flags, type);
>>> +        return bpf_mprog_link(tuple, id_or_fd, flags, ltype);
>>>       /* If no relevant flag is set and no id_or_fd was passed, then
>>>        * tuple link/prog is just NULLed. This is the case when before/
>>>        * after selects first/last position without passing fd.
>>>        */
>>>       if (!id && !id_or_fd)
>>>           return 0;
>>> -    return bpf_mprog_prog(tuple, id_or_fd, flags, type);
>>> +    return bpf_mprog_prog(tuple, id_or_fd, flags, ptype);
>>>   }
>>>   static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
>>> @@ -226,7 +227,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>>>                struct bpf_mprog_entry **entry_new,
>>>                struct bpf_prog *prog_new, struct bpf_link *link,
>>>                struct bpf_prog *prog_old,
>>> -             u32 flags, u32 id_or_fd, u64 revision)
>>> +             u32 flags, u32 id_or_fd, u64 revision,
>>> +             enum bpf_link_type expected_link_type)
>>>   {
>>>       struct bpf_tuple rtuple, ntuple = {
>>>           .prog = prog_new,
>>> @@ -243,6 +245,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>>>           return -EEXIST;
>>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>>>                          flags & ~BPF_F_REPLACE,
>>> +                       expected_link_type,
>>>                          prog_new->type);
>>>       if (ret)
>>>           return ret;
>>> @@ -328,7 +331,8 @@ static int bpf_mprog_fetch(struct bpf_mprog_entry 
>>> *entry,
>>>   int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>>                struct bpf_mprog_entry **entry_new,
>>>                struct bpf_prog *prog, struct bpf_link *link,
>>> -             u32 flags, u32 id_or_fd, u64 revision)
>>> +             u32 flags, u32 id_or_fd, u64 revision,
>>> +             enum bpf_link_type expected_link_type)
>>>   {
>>>       struct bpf_tuple rtuple, dtuple = {
>>>           .prog = prog,
>>> @@ -343,8 +347,9 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>>       if (!bpf_mprog_total(entry))
>>>           return -ENOENT;
>>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>>> -                       prog ? prog->type :
>>> -                       BPF_PROG_TYPE_UNSPEC);
>>> +                       expected_link_type,
>>> +                       /* Use UNSPEC as wildcard when prog is NULL */
>>> +                       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
>>>       if (ret)
>>>           return ret;
>>>       if (dtuple.prog) {
>>> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
>>> index 02db0113b8e7..f208cef13a98 100644
>>> --- a/kernel/bpf/tcx.c
>>> +++ b/kernel/bpf/tcx.c
>>> @@ -38,7 +38,7 @@ int tcx_prog_attach(const union bpf_attr *attr, 
>>> struct bpf_prog *prog)
>>>       }
>>>       ret = bpf_mprog_attach(entry, &entry_new, prog, NULL, 
>>> replace_prog,
>>>                      attr->attach_flags, attr->relative_fd,
>>> -                   attr->expected_revision);
>>> +                   attr->expected_revision, BPF_LINK_TYPE_TCX);
>>>       if (!ret) {
>>>           if (entry != entry_new) {
>>>               tcx_entry_update(dev, entry_new, ingress);
>>> @@ -76,7 +76,7 @@ int tcx_prog_detach(const union bpf_attr *attr, 
>>> struct bpf_prog *prog)
>>>           goto out;
>>>       }
>>>       ret = bpf_mprog_detach(entry, &entry_new, prog, NULL, 
>>> attr->attach_flags,
>>> -                   attr->relative_fd, attr->expected_revision);
>>> +                   attr->relative_fd, attr->expected_revision, 
>>> BPF_LINK_TYPE_TCX);
>>>       if (!ret) {
>>>           if (!tcx_entry_is_active(entry_new))
>>>               entry_new = NULL;
>>> @@ -152,7 +152,7 @@ static int tcx_link_prog_attach(struct bpf_link 
>>> *link, u32 flags, u32 id_or_fd,
>>>       if (!entry)
>>>           return -ENOMEM;
>>>       ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, 
>>> NULL, flags,
>>> -                   id_or_fd, revision);
>>> +                   id_or_fd, revision, BPF_LINK_TYPE_TCX);
>>>       if (!ret) {
>>>           if (entry != entry_new) {
>>>               tcx_entry_update(dev, entry_new, ingress);
>>> @@ -183,7 +183,7 @@ static void tcx_link_release(struct bpf_link *link)
>>>           ret = -ENOENT;
>>>           goto out;
>>>       }
>>> -    ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 
>>> 0, 0);
>>> +    ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 
>>> 0, 0, BPF_LINK_TYPE_TCX);
>>>       if (!ret) {
>>>           if (!tcx_entry_is_active(entry_new))
>>>               entry_new = NULL;
>>> @@ -229,9 +229,8 @@ static int tcx_link_update(struct bpf_link *link, 
>>> struct bpf_prog *nprog,
>>>           ret = -ENOENT;
>>>           goto out;
>>>       }
>>> -    ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
>>> -                   BPF_F_REPLACE | BPF_F_ID,
>>> -                   link->prog->aux->id, 0);
>>> +    ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog, 
>>> BPF_F_REPLACE | BPF_F_ID,
>>> +                   link->prog->aux->id, 0, BPF_LINK_TYPE_TCX);
>>>       if (!ret) {
>>>           WARN_ON_ONCE(entry != entry_new);
>>>           oprog = xchg(&link->prog, nprog);
> 
