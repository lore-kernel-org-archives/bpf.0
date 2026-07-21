Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD691643B;
	Tue, 21 Jul 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605166; cv=none; b=ivQmQsqY9viTCom6COrBQiZWbxbwIjF2oy2+kwJJrT4EvPiVlWXuZx9wKbfW/+yA71s32hOrOcVlncMaNGcXPPVfiBnOQSCFYwdVU+aIFZSgYJg0IQoXgoR6tMT6LptqaLGTk56EnlinI//inKYSByMtsGV6LylAM5fAIEj2grE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605166; c=relaxed/simple;
	bh=MWTsroq01+9yB5tle0Pu0XvnbeT03iDDeXGCJ1mEw7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCo4mAKyHSnKA+iUhE7z9Urz3ROeLoT1XdWXgdnDfIEtfL7bNP2f49vnCKSc3xaGhqs0IEqIgLm1hmpETfllDZPVawo/OYZBMi3dGKK8ckrEEQiPms8TNHtwEVFNYUyVOdqy48PYR0WZrZdj8t8dhBgyiyeCpLNXZHF2+qZ/mLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h435B1gy0zKHN46;
	Tue, 21 Jul 2026 11:38:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AA2064056B;
	Tue, 21 Jul 2026 11:39:19 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXB1nn6V5qxsP7Bw--.62987S2;
	Tue, 21 Jul 2026 11:39:19 +0800 (CST)
Message-ID: <cf40ce57-b216-4f49-b43a-7f873fa48748@huaweicloud.com>
Date: Tue, 21 Jul 2026 11:39:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 2/4] bpf: Fix UAF due to missing link type check in
 mprog
Content-Language: en-US
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-3-pulehui@huaweicloud.com>
 <4b343a35-45a2-40c2-a27d-36998688f5d7@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <4b343a35-45a2-40c2-a27d-36998688f5d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXB1nn6V5qxsP7Bw--.62987S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar48Aw1DuF17Xry3XrW5Wrg_yoW7tFWfpF
	1kJryUJryUAr18Xr1UJr1UAryUXF1UJw1UJr18XFyjyr1UXr1jqr1UWr1Ygr15Jr4kJr48
	Jr1UXrnrZr1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/7/21 2:44, Amery Hung wrote:
> 
> 
> On 7/20/26 6:45 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In bpf_mprog_link, the code does not check the link->type first before
>> dereferencing link->prog->type. This missing validation allows a user to
>> pass an abnormal non-netkit or non-tcx link via relative_fd. If do
>> BPF_LINK_UPDATE on the abnormal link, it can trigger a UAF issue.
>>
>> CPU0                                      CPU1
>> netkit_link_prog_attach
>> bpf_mprog_attach
>> bpf_mprog_tuple_relative
>> bpf_mprog_link
>>    link = bpf_link_get_from_fd(id_or_fd);
>>                                            BPF_LINK_UPDATE
>>                                            ...
>>                                            old_prog = 
>> xchg(&link->link.prog, new_prog);
>>                                            bpf_prog_put(old_prog);
>>    if (type && link->prog->type != type) <-- trigger UAF
>>
>> Fix this by strictly validate link->type in bpf_mprog_link against the
>> expected link type. bpf_mprog_tuple_relative is also adjusted to accept
>> and pass down the expected link type.
>>
>> Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for 
>> multi-progs")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> 
> The message can be improved. The reason for the UAF is that each 
> subsystem provides its own protection for link->prog. Since there is no 
> cross subsystem protection (if not considering the RCU of prog tear 
> down), dereferencing the prog of an anchor link that does not belong to 
> the current subsystem is not safe: it may have been freed. Therefore, we
> need to validate link->type to reject foreign anchors.
> 
> There are also some grammar errors:
> If do -> If doing
> strictly validate -> strictly validating.

make sense to me, thanks Amery, will respin soon.

> 
>> ---
>>   kernel/bpf/mprog.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> index 1394168062e8..367f8f10da0a 100644
>> --- a/kernel/bpf/mprog.c
>> +++ b/kernel/bpf/mprog.c
>> @@ -6,7 +6,7 @@
>>   static int bpf_mprog_link(struct bpf_tuple *tuple,
>>                 u32 id_or_fd, u32 flags,
>> -              enum bpf_prog_type type)
>> +              enum bpf_link_type type)
>>   {
>>       struct bpf_link *link = ERR_PTR(-EINVAL);
>>       bool id = flags & BPF_F_ID;
>> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>           link = bpf_link_get_from_fd(id_or_fd);
>>       if (IS_ERR(link))
>>           return PTR_ERR(link);
>> -    if (type && link->prog->type != type) {
>> +    if (type && link->type != type) {
>>           bpf_link_put(link);
>>           return -EINVAL;
>>       }
>> @@ -52,21 +52,22 @@ static int bpf_mprog_prog(struct bpf_tuple *tuple,
>>   static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
>>                       u32 id_or_fd, u32 flags,
>> -                    enum bpf_prog_type type)
>> +                    enum bpf_link_type ltype,
>> +                    enum bpf_prog_type ptype)
>>   {
>>       bool link = flags & BPF_F_LINK;
>>       bool id = flags & BPF_F_ID;
>>       memset(tuple, 0, sizeof(*tuple));
>>       if (link)
>> -        return bpf_mprog_link(tuple, id_or_fd, flags, type);
>> +        return bpf_mprog_link(tuple, id_or_fd, flags, ltype);
>>       /* If no relevant flag is set and no id_or_fd was passed, then
>>        * tuple link/prog is just NULLed. This is the case when before/
>>        * after selects first/last position without passing fd.
>>        */
>>       if (!id && !id_or_fd)
>>           return 0;
>> -    return bpf_mprog_prog(tuple, id_or_fd, flags, type);
>> +    return bpf_mprog_prog(tuple, id_or_fd, flags, ptype);
>>   }
>>   static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
>> @@ -243,6 +244,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>>           return -EEXIST;
>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>>                          flags & ~BPF_F_REPLACE,
>> +                       link ? link->type :
>> +                       BPF_LINK_TYPE_UNSPEC,
> 
> nit: keep it in a line. It is well under 100 cols.
> 
>>                          prog_new->type);
>>       if (ret)
>>           return ret;
>> @@ -343,6 +346,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>       if (!bpf_mprog_total(entry))
>>           return -ENOENT;
>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>> +                       link ? link->type :
>> +                       BPF_LINK_TYPE_UNSPEC,
> 
> Same here.
> 
>>                          prog ? prog->type :
>>                          BPF_PROG_TYPE_UNSPEC);
>>       if (ret)

