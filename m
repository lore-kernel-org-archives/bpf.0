Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4903EC2E6
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704519; cv=none; b=Ox6tGQUjBTpSFVNbJPtcdqh9lnfdG2BA7nQ6zbYA8Boap+ePTXc4ffAYJl+nK12D+nLlUFwQf2ishGLNgNzioHyJTyFltAUkL+8yCfSQhGjlRYc4x1lZchUX+97TP5nib0Z9Y/Ck6h3jC4l0+Otk2lUU2IyPdIuzAxvk0OjOta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704519; c=relaxed/simple;
	bh=hZ9qu5PaDa1DgkrG9mGkifxxDGPOsqE3xCRNrHfqidc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojshe79gcUCffIvBhPmid9HLwlFT1RAw0GgSyJZRzaqKMumWftW9hXT4muYYJkQGEY7KWZqJCB00CKJeyGuGq57CX2gX8UGxcHF87qEaVL4PzYGo/HJOblDGYmY6+GPxIAGno4gs29PUmSNfTtuhvFonce3eSRVq4ZIoFW/F94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4lr422GFzYQtkR
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:14:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E51214056B
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:15:12 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAXJ3P_bWBqJ8B+CA--.19569S2;
	Wed, 22 Jul 2026 15:15:12 +0800 (CST)
Message-ID: <bdccaa6e-cf8c-438d-ba05-98652e9ce988@huaweicloud.com>
Date: Wed, 22 Jul 2026 15:15:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check in
 mprog
Content-Language: en-US
To: Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-3-pulehui@huaweicloud.com>
 <20260721042151.E6F941F000E9@smtp.kernel.org>
 <723495f2-f4a0-4723-90a8-d4774e6dce05@huaweicloud.com>
 <CAMB2axMocV3+cC8O5LEu-0bPcGvchwjASbjM_afx=Stc_8AvKw@mail.gmail.com>
 <DK4GW4BH8RPS.32N0A91SQGMOH@etsalapatis.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <DK4GW4BH8RPS.32N0A91SQGMOH@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXJ3P_bWBqJ8B+CA--.19569S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWxZr43JF48Cr13ArWkZwb_yoWrXr1xpF
	Z7JF1vyFWUXry2qr1jq3Z5AryjgF4kJr1UXrn5Xw1jyFn09F1IqF1UKr4ruw1Syr4DJw4v
	vw1jqF9xZ34DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/22 2:40, Emil Tsalapatis wrote:
> On Tue Jul 21, 2026 at 1:40 PM EDT, Amery Hung wrote:
>> On Tue, Jul 21, 2026 at 2:18 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>
>>>
>>> On 2026/7/21 12:21, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>> - [Medium] Anchor link type validation is bypassed when attaching or detaching bare BPF programs, leading to wildcard insertions/deletions and data races.
>>>> --
>>>>
>>>> --- Patch [2]: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check in mprog ---
>>>> commit 830a4e62ebb8e98cc45b0ce829c6686aacafabc4
>>>> Author: Pu Lehui <pulehui@huawei.com>
>>>> Subject: bpf: Fix UAF due to missing link type check in mprog
>>>>
>>>> This commit adds a link type validation in bpf_mprog_link() to prevent a
>>>> use-after-free when dereferencing link->prog for foreign anchors. It also
>>>> adjusts bpf_mprog_attach() and bpf_mprog_detach() to pass down the expected
>>>> link type.
>>>>
>>>>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>>>>> index 1394168062e85..37ce91e0bcd21 100644
>>>>> --- a/kernel/bpf/mprog.c
>>>>> +++ b/kernel/bpf/mprog.c
>>>>> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>>>>               link = bpf_link_get_from_fd(id_or_fd);
>>>>>       if (IS_ERR(link))
>>>>>               return PTR_ERR(link);
>>>>> -    if (type && link->prog->type != type) {
>>>>> +    if (type && link->type != type) {
>>>>>               bpf_link_put(link);
>>>>>               return -EINVAL;
>>>>>       }
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -243,6 +244,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>>>>>               return -EEXIST;
>>>>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>>>>>                                      flags & ~BPF_F_REPLACE,
>>>>> +                                   link ? link->type : BPF_LINK_TYPE_UNSPEC,
>>>>>                                      prog_new->type);
>>>>>       if (ret)
>>>>
>>>> [Severity: Medium]
>>>> When attaching a bare BPF program, link is NULL. This passes
>>>> BPF_LINK_TYPE_UNSPEC (0) to bpf_mprog_tuple_relative() as the expected
>>>> anchor link type.
>>>
>>> Ah, so when attaching a bare prog with a relative link, having the
>>> BPF_F_LINK flag set means the relative id_or_fd is a link, not the
>>> object being attached. Sorry, that definitely confused me.
>>>
>>>>
>>>> In bpf_mprog_link() above, the validation check is:
>>>>
>>>>       if (type && link->type != type) {
>>>>
>>>> Because type is 0, the validation is bypassed entirely.
>>>>
>>>> If a user passes a foreign link with a NULL prog (like struct_ops) as an
>>>> anchor via id_or_fd, the positioning logic treats tuple->prog == NULL as
>>>> 'no anchor provided' instead of rejecting the invalid anchor with -EINVAL.
>>>>
>>>> Does this allow wildcard insertions or deletions, and leave a benign data
>>>> race when reading link->prog locklessly? Should the expected link type be
>>>> explicitly provided when attaching bare programs?
>>
>> I also overlooked this. Make sense to pass the expected link type from
>> callers of bpf_mprog_attach().
> 
> +1 on this, and can we add a comment that ptype == UNSPEC is because
> detach() uses this as a wildcard? UNSPEC is only valid in very few
> places in the subsystem.

both ack, thanks

> 
>>
>>>>
>>>> [ ... ]
>>>>
>>>>> @@ -343,6 +345,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>>>>       if (!bpf_mprog_total(entry))
>>>>>               return -ENOENT;
>>>>>       ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>>>>> +                                   link ? link->type : BPF_LINK_TYPE_UNSPEC,
>>>>>                                      prog ? prog->type :
>>>>>                                      BPF_PROG_TYPE_UNSPEC);
>>>>>       if (ret)
>>>>
>>>> [Severity: Medium]
>>>> Similarly, when detaching a bare BPF program, link is NULL. This also
>>>> passes BPF_LINK_TYPE_UNSPEC as the expected link type.
>>>>
>>>> Does this bypass the new validation and allow wildcard deletions when using
>>>> foreign anchors?
>>>>
>>>
>>>

