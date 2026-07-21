Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC753C3F65
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625098; cv=none; b=Nt+oOSTo7rZ4ThmaIV16oOKEm2luKxxdRL3Z/nR0z50DZhWC6pi1Mx5d5hg34MPyE2Bq0rdiaQcGiawgIkedPnlAiNaVFz+7Sk4v9I8XI/XjsyOqL7TZwjVfyv26OkKoE8Zhq3rTgFAUO+VAnhWf16rf6ZvTG9TEHQQKYjCESxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625098; c=relaxed/simple;
	bh=Fq581f2Sx/+i4uMXVCT2fm+RVrLLP4YGnLZyOvUb/YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpkhM3RfJmLdq9L23MTNhZoyeTJ193KgBrVlTLHVMuECxnUr3drc56r6cFAMqHHnWhZtXoTMJUahSUur7R/2a4KWATXJUu3HbjFv6sYxANt0fmOp2UiqPrVeVDMwG71eogQZsYCme8ma6Uj2xh0ODxkJIK38pZZM4/0I4U9UIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4BSh6dqTzYQttX
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:11:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F37B540A50
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 17:11:27 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDnsKG+N19qQcEBCA--.48593S2;
	Tue, 21 Jul 2026 17:11:27 +0800 (CST)
Message-ID: <723495f2-f4a0-4723-90a8-d4774e6dce05@huaweicloud.com>
Date: Tue, 21 Jul 2026 17:11:26 +0800
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-3-pulehui@huaweicloud.com>
 <20260721042151.E6F941F000E9@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260721042151.E6F941F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDnsKG+N19qQcEBCA--.48593S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryktrWxtw1rtrW5Xw4kCrg_yoW5CFy5pF
	Z3JFyvyryUWry2qFyjqas5ZFy0gF4kWr1UKFn5Xw40vrna9FyIvF1UKw4rZwnIyrWkKws2
	vwnFqF98Za4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/21 12:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Anchor link type validation is bypassed when attaching or detaching bare BPF programs, leading to wildcard insertions/deletions and data races.
> --
> 
> --- Patch [2]: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check in mprog ---
> commit 830a4e62ebb8e98cc45b0ce829c6686aacafabc4
> Author: Pu Lehui <pulehui@huawei.com>
> Subject: bpf: Fix UAF due to missing link type check in mprog
> 
> This commit adds a link type validation in bpf_mprog_link() to prevent a
> use-after-free when dereferencing link->prog for foreign anchors. It also
> adjusts bpf_mprog_attach() and bpf_mprog_detach() to pass down the expected
> link type.
> 
>> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
>> index 1394168062e85..37ce91e0bcd21 100644
>> --- a/kernel/bpf/mprog.c
>> +++ b/kernel/bpf/mprog.c
>> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>>   		link = bpf_link_get_from_fd(id_or_fd);
>>   	if (IS_ERR(link))
>>   		return PTR_ERR(link);
>> -	if (type && link->prog->type != type) {
>> +	if (type && link->type != type) {
>>   		bpf_link_put(link);
>>   		return -EINVAL;
>>   	}
> 
> [ ... ]
> 
>> @@ -243,6 +244,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
>>   		return -EEXIST;
>>   	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
>>   				       flags & ~BPF_F_REPLACE,
>> +				       link ? link->type : BPF_LINK_TYPE_UNSPEC,
>>   				       prog_new->type);
>>   	if (ret)
> 
> [Severity: Medium]
> When attaching a bare BPF program, link is NULL. This passes
> BPF_LINK_TYPE_UNSPEC (0) to bpf_mprog_tuple_relative() as the expected
> anchor link type.

Ah, so when attaching a bare prog with a relative link, having the 
BPF_F_LINK flag set means the relative id_or_fd is a link, not the 
object being attached. Sorry, that definitely confused me.

> 
> In bpf_mprog_link() above, the validation check is:
> 
>      if (type && link->type != type) {
> 
> Because type is 0, the validation is bypassed entirely.
> 
> If a user passes a foreign link with a NULL prog (like struct_ops) as an
> anchor via id_or_fd, the positioning logic treats tuple->prog == NULL as
> 'no anchor provided' instead of rejecting the invalid anchor with -EINVAL.
> 
> Does this allow wildcard insertions or deletions, and leave a benign data
> race when reading link->prog locklessly? Should the expected link type be
> explicitly provided when attaching bare programs?
> 
> [ ... ]
> 
>> @@ -343,6 +345,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>>   	if (!bpf_mprog_total(entry))
>>   		return -ENOENT;
>>   	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
>> +				       link ? link->type : BPF_LINK_TYPE_UNSPEC,
>>   				       prog ? prog->type :
>>   				       BPF_PROG_TYPE_UNSPEC);
>>   	if (ret)
> 
> [Severity: Medium]
> Similarly, when detaching a bare BPF program, link is NULL. This also
> passes BPF_LINK_TYPE_UNSPEC as the expected link type.
> 
> Does this bypass the new validation and allow wildcard deletions when using
> foreign anchors?
> 

