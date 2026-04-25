Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE013016F2
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777149701; cv=none; b=bSgb75tGnV+EVc/G20jlofdqJ1a2naAOjgGi/EQM+7XtDLaHMChl7zdNv5CmWgpa72nJF1r4FdrQ3p2J8EpGNb4pS3xYCMIuhRbSH2PMmvtQLMd6btag36+6czjVOGsBGxBVBgkyF5jkXPLp98vl7Lk5UmsQWqbMwV0agHadkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777149701; c=relaxed/simple;
	bh=FXBxGvBl06ZlcKUDyZV2TZHtOpngPHeaJHwdnWkwd8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzr4ycGSX/Si6lHl79MgHssmuJhHxr2Wfud0CIY9RJjWeY2BPamDxevuzRiJeKZlcvStz3UXn9o/Ce/9YO2nujYaJiZxHfelORYN4H3lVKKxRRuqywMJOv2MFwkcQqtGG6prf8vpVYzaBLzfMSvSsdMCbQbJiNWOK36NuMXTMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug2lkP5w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug2lkP5w"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ad135063so81485055e9.0
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777149698; x=1777754498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LikAQzNP+mJgI6rYkKWWaPcezC8tu0NiBOArYumtAVw=;
        b=Ug2lkP5wLKtjF6Xzg2RhFivtyYliFruAdaSn8Ee24RNAqZx0sZIQuFnUyCDY4CU8ON
         v1OivV7q4UyL3x75IQbtyEy6YzXafjV4SfRqlYaNp4S9alK++LOlJS41raLNcZHQghHJ
         q0xJVd8qioVC6JSc8FpdnTN5C9AFq9j2EPPG3ZEmbheTpPJWVQ0QEtrlQoKnyrPKvYKH
         eKundjFXz0S6PeUL9QtyrcmcF+ikVskstMgMEzUoSAc2BcruNT3+Qp3OVGzZjR5IqmgR
         RLcTab0fEViwJghfEKqlxF+VRI37hNX+pAOQK/LLfVsdV48cRdYQAlfIjBHH5gH37bQJ
         5kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777149698; x=1777754498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LikAQzNP+mJgI6rYkKWWaPcezC8tu0NiBOArYumtAVw=;
        b=brkYR1hK6fWLZheuvmW2+E/jU33krHCrKraiz1Wbbb5J/MtAdQiTZafmMKW41qZ57N
         1FuKMOxv5Ths3cDgmld4y+0vT3q0L6VJLoJNMv7hvSwx7k+6xoWJjnu+tEs53MF5YA62
         chD3ApWq30Q4NQ6df66Xcy/h2swX9+4+kWlTjdMw9itEULvLsjj0BIEtD3JTjt9Vs6Sp
         g+qbgWV0JTfz9MKqaQI/jYuJHBX+sgbyXvygzmGPa9PCcm8qR7i4qpXeLeuvY3ufYa1R
         C6ZnvYJSeLVPLGt1eggEf0kwaDnG6mJge6FVEVJY6ApDtt7vP3bW0x2BWBRZlmPDHiLU
         PDGg==
X-Gm-Message-State: AOJu0YyOjPIhjGcN6awtKfAZT+UKt6n/gwiC3b120+jDioB2+QFhSXxH
	I3kx/2KanbgI6jW6jomee2ZdsZ7+dNjFhW8SBXIZqBV0rMfi2vW5vGgh
X-Gm-Gg: AeBDiet1I0uQGedIuRR+XPul44K7HuwrMhROfs8YdMBDyv5N0OL3lQdFoCve6OlOfW2
	/OmYTwfg7N9ydNp0TEFBlFNqYuW0j/ncDRcU65QOCuVZxtoRlvnjPmdWs+PdjcVsdr28GUZe4I1
	HgywmwkjHpZFR8STeDZ5MIQZbg5O7tGt6H7o+BXxOVn1WWGAtnK1ivtpp4BRPjUJNHuJ8nBATE1
	HLIivjfHX6xgiMfV51wpKDZOXs6TzzAErp/q5/438n8DhyPzeX51D0cq/7enm/fTkqV0iI7SEuL
	MWsGC0BoGBbBnXoKyuQlHkBTKWTV/MYW9b4qFvTK/vglA9cL0vP8ymR+EURBFtoMJZ8qSAYM6fb
	AKzONyXefJwwdDYtmIOsGKRNZmeaOTrMjb7y7MNzl35lbb8aEW9WPfeF61fy/i4Uo41EeAetmqd
	1q40IYginFlYTT16cyTnzJKSM0wLdk4vgys6ZfCfDYEjfEmV6iYgx/4L28MpeC++rFNkPdEE/gq
	k1RgCZzvExXee8Gv8b/eQ==
X-Received: by 2002:a05:600c:8b38:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488fb7925dcmr521703365e9.27.1777149697632;
        Sat, 25 Apr 2026 13:41:37 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm70465389f8f.3.2026.04.25.13.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 13:41:37 -0700 (PDT)
Message-ID: <c2db26e6-b6d2-4f5f-8b8c-0ad8a1e24865@gmail.com>
Date: Sat, 25 Apr 2026 21:41:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Implement resizable hashmap basic
 functions
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
 <20260424204011.E6C7BC19425@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260424204011.E6C7BC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 9:40 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Critical] Using rhashtable for BPF map updates/deletes is unsafe and will lead to hard deadlocks from IRQ/NMI/softirq contexts.
> --
> 
> commit 47c235933705172d3a36c4339c754282500161f1
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> bpf: Implement resizable hashmap basic functions
> 
> This commit adds a new BPF map type BPF_MAP_TYPE_RHASH backed by the kernel
> rhashtable implementation. It provides basic map operations like lookup,
> update, and delete using rhashtable APIs.
> 
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 3dd9b4924ae4fb..a37bd2a7b30f4b 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
>> +{
>> +	int err;
>> +
>> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
> 
> Can this lead to a deadlock when used by non-sleepable BPF programs in
> interrupt or softirq contexts?
> 
> The verifier permits BPF_MAP_TYPE_RHASH to be used by non-sleepable BPF
> programs, such as those attached to XDP or TC, which execute in softirq
> context and do not check bpf_prog_active.
> 
> Map operations like rhashtable_remove_fast() and
> rhashtable_lookup_get_insert_fast() internally use bit_spin_lock() for
> bucket-level synchronization. This locking mechanism disables preemption
> but leaves hardware and software interrupts enabled, unlike the
> raw_spin_lock_irqsave() approach used by the standard htab.
> 
> If a syscall updates the map from process context and acquires the bucket
> lock, and is then preempted by a hardware interrupt that schedules a softirq
> on return, the softirq will execute the XDP or TC BPF program.
> 
> If this BPF program attempts to access the same hash bucket, wouldn't it spin
> indefinitely waiting for the bit_spin_lock held by the interrupted process,
> causing a system deadlock?
> 

This is right, I forgot to add if (irqs_disabled()) return -EBUSY 
pointed to in v1: 
https://lore.kernel.org/all/CAADnVQKvp2tnQSWW4Kh3ofGLvaEYJ47kyZeNUscAH_DShw8XHw@mail.gmail.com/

I'll add it in v4.

> [ ... ]
> 
>> +static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +	struct rhtab_elem *elem, *tmp;
> 
> [ ... ]
> 
>> +	tmp = rhashtable_lookup_get_insert_fast(&rhtab->ht, &elem->node, rhtab->params);
> 
> Does the same deadlock mechanism apply here as well, given that
> rhashtable_lookup_get_insert_fast() also relies on bucket-level locks?
> 

