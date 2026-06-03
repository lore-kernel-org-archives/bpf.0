Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411C1E531
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528242; cv=none; b=AMTfAk8UXsRFTOcfBAXGofVB7J5FijgBuzFSUb4OmWh7ektpVoi/upm5rrr4TukKjD0ynQNHXvh9xBtzcip046DPYBj6CIWIuFpLp/1O8oLEBFgj3mH8mI9J9fJAjs81QaCTm8S+mFfNwT84pCgeXVLc+YEuG4kLhsoUG9ofTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528242; c=relaxed/simple;
	bh=y4+jbt0PQfwVSHAfLKV+GcrXONUemJ/A8VqUh6dXKLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IElD6j/fNIZ4Zbn1tgjTAUOInToCEIAiVPr872a7vvHhPZBQW+cZvNwtIj+TbNyhzIuxbf3DqSzr5Oo5IZ6lx91k1FnnjBAZTOtKnQG4oERGlBobsaLRSKEPS2cd3g8VORD4or6hFr0EaNcWgG1fXHJqGcEIertTH3Vif858x34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VsF174sh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VsF174sh"
Message-ID: <312e1689-fbcf-4ea0-ad49-9818c92b0aeb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780528228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQw2huqWjqggoXaqi+42ih3g7tWLzItDU0TMhAe7O0g=;
	b=VsF174sht9dX/Bn1CDCdbP2vA2GDvHYgdUS+A+BFWb0Q1FKXwfUmKLd9sjoymRt20zXtEU
	WoXb97jfqiqZ2OSMK4LoRJlywJ989xpuzyoBx8blvZVlWJBV4+ZR+3VVT0JnuHIvosH+9g
	s0pJI5I61vlEOoA6hs8a5ljf6+GtH2c=
Date: Wed, 3 Jun 2026 16:10:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Factor out stack_map build ID
 helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260525223948.1920986-2-ihor.solodrai@linux.dev>
 <20260525231131.895201F000E9@smtp.kernel.org>
 <CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-iWVUN3F06=g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bza2fRDGhLQoPE-EzM7F34xaEJfi5Exmxb-iWVUN3F06=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026-05-28 2:57 p.m., Andrii Nakryiko wrote:
> On Mon, May 25, 2026 at 4:11 PM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] The refactored VMA caching logic bypasses the cache for fallback cases and evicts valid VMAs, directly contradicting the patch's stated goal.
>> --
>>
>> commit e38559ed451d61a994765f3bfb260cc14edd3569
>> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
>>
>> bpf: Factor out stack_map build ID helpers
>>
>> This patch refactors stack_map_get_build_id_offset() to use helpers and
>> continue-driven control flow. It also attempts to optimize VMA caching
>> by updating the cached VMA on the fallback-to-IP branch to prevent
>> redundant parsing attempts for anonymous or failing VMAs.
>>
>> Link: https://lore.kernel.org/bpf/CAEf4Bzac9uWWqBvzH0iFzKvJcq3vxscZ3pKm0sUHmN-F-z9wVQ@mail.gmail.com/
>> Link: https://lore.kernel.org/bpf/226398c1ff3f2b686c0aeb010408d85fb15df13f9ff60a045bee31e79b9e41e9@mail.kernel.org/
>>
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index da3d328f5c15a..e23be7d445038 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>
>> [ ... ]
>>
>>> @@ -165,44 +187,45 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
>>>   static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>>                                          u32 trace_nr, bool user, bool may_fault)
>>>   {
>>
>> [ ... ]
>>
>>>        for (i = 0; i < trace_nr; i++) {
>>>                u64 ip = READ_ONCE(id_offs[i].ip);
>>> +             u64 offset;
>>>
>>> -             if (range_in_vma(prev_vma, ip, ip)) {
>>> +             if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
>>>                        vma = prev_vma;
>>> -                     memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
>>> -                     goto build_id_valid;
>>> +                     offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>>> +                     stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
>>> +                     continue;
>>>                }
>>>                vma = find_vma(current->mm, ip);
>>> -             if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>>> +             if (!vma || vma_is_anonymous(vma) ||
>>> +                 fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>>>                        /* per entry fall back to ips */
>>> -                     id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>>> -                     memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>>> +                     stack_map_build_id_set_ip(&id_offs[i]);
>>> +                     prev_vma = vma;
>>> +                     prev_build_id = NULL;
>>
>> [Severity: Medium]
>> Does setting prev_build_id to NULL here inadvertently defeat the VMA caching
>> optimization mentioned in the commit message?
>>
>> The commit message states the intent is to update prev_vma and prev_build_id
>> on this fallback branch so the cache reflects the actual VMA seen. However,
>> the cache check at the top of the loop now requires prev_build_id to be
>> non-NULL:
>>
>>      if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
>>
>> Since prev_build_id is set to NULL on failure, won't consecutive IPs falling
>> into the same anonymous or failing VMA bypass the cache completely and trigger
>> redundant find_vma() lookups?
> 
> yeah, it seems so to me... we have prev_build_id and prev_vma, we
> should set prev_build_id to NULL if build ID fetching failed, but we
> should preserve prev_vma always to avoid unnecessary find_vma() calls.
> And if it so happens that we have matching prev_vma, then depending of
> prev_build_id being NULL or not we either set absolute ip or
> build_id+offset, respectively
> 
> Let's do a follow up to improve this, nothing is really broken, I
> think, so applying.

Hi Andrii, thanks for applying.

I'll send a follow up as soon as I can.

> 
> 
>>
>> Also, does overwriting prev_vma with the failing VMA while disabling the
>> cache hit (via NULL prev_build_id) evict the last successful VMA from the
>> cache, potentially degrading performance if stack frames interleave?
>>
>>> +                     continue;
>>>                }
>>> -build_id_valid:
>>> -             id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
>>> -             id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>>> +             offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>>> +             stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
>>>                prev_vma = vma;
>>>                prev_build_id = id_offs[i].build_id;
>>>        }
>>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260525223948.1920986-1-ihor.solodrai@linux.dev?part=1
>>

