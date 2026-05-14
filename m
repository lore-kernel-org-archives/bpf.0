Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F11A9FAF
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756433; cv=none; b=LZyZx1uZ20Ecf62dpDGG2YCIiGJlui7G1+DnpiCvhqOw2dIxX6myr4JUW6X5B3r04sUYv9VfegvbJY3lUyiqxrTPB430vsPkpYCw4ivGU+fA2GEtogHIpxLWlxGcT06FZaghtfNStFJ0UoBPEgzzjMHB2xQUCD2puXQM1D2jMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756433; c=relaxed/simple;
	bh=jKHlI1SykydpHqzxlOXgwkT6qneU7u1kV5DByzcEN2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fqj2T+AipFbEkzk/uqhKS4yOiyxy4vzyWP+s5xPpsCRLqtXudI0VUGsbkzr/QYYPRbDigUg6Akw2TbLZh8j8pGKnVjvuoYHWUUHyxL2U2uMN89kLQC3pb3Lk5DW3zJc7is2pTR2YPkKPl0ctDVEDjKAhc5STlG300ZHE/aSwQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWej06rA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWej06rA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48909558b3aso76013785e9.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778756424; x=1779361224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCTTq4Nu8x1TzDhQ426HVxP49M3o28yaArLLG0LGmvg=;
        b=KWej06rArC4KF5yT0o1r42BhwAxz/N/aqVel6ijb3GyPGANHMD6Ht8xzZL8kNyGWFM
         TkuV3/pt2FbaYpzo47X97aUuwJmsqsSXIBg+9iv1vbr8QobhUnXEnt0LFjhCMpTcSosC
         XMeoDZa+I9BqnLu43U9B2MbyHAor9HGnYKFIRb6F1VgW0qfc8wH9CB6wcI93cpfxYlzq
         4+0TEKiJnKND3OvRjMWXiPmke6qzH6d6aEMvksm+nyAOSgC6BjmmI+bZapegH1JQoPnV
         oxgM+WwnbzbtVoJ/aTCfISQ5B5zco7fIvq8POCqdukt1lUGRhZ5pI0ttVuLXVnRWBrhD
         sVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756424; x=1779361224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCTTq4Nu8x1TzDhQ426HVxP49M3o28yaArLLG0LGmvg=;
        b=bmRqJ3q49fP1Rc/ubAkx0kqyAR9i9OrBsEL++T9kqNToVDMSab0I/X1kA8uK/d0O1o
         7rsPqvQHrxfI+6qNBNzivgoY/DH31KjfwEzTbixt+KdQVzjn+QfZu9CEgCTg28Nv+weK
         Vt52KM0DYlwrWJnO2C5QhlN+hcmGYJq0xCR62Ij2EQXpVWFWWLyeozBWLMq88zwwtCgB
         Wqx5TJRx1QeOOgZ7uC7VDA5HiTT1PBAb3z5/jlU9gbMStbEn+CVZqei5oYaMfeq+wLpg
         iYwQYWXT8adHmJ8BbWIbYccOPt62d8j6AqOnOVCzBy3rb0WMPvI0MZiuaqmTTwMNF9es
         huEg==
X-Forwarded-Encrypted: i=1; AFNElJ+hTRVUJYnVF5cRDp9oTrAEkz16ood/Fi4yC7JzEwUu8ouP4ozT7mPUvJxYQUgkCn/ukpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEx//oKz+fuovAZn8BoAndXI3S2C+fJagwP3EeMmAX1D+yNAHw
	3+u23/NYJQ5qz0ybuf7epA0tlGnXz2Cl5D04XKGicXhbw1now7VwnKlJ
X-Gm-Gg: Acq92OHrPQH4dusj5uiYe1j3FhJCT1cwhW2eYGpT695r2Mt/d1201L27NEjmg9pn2+4
	CLPt4aqhRKroovdrxNHmauCRnt2hpabrQJS3Keh1la1i1nf/pOjFkB9RFWoK95EJiwaZzF8S3Zj
	yggWpya7rBtsAoIZHCjvbCgSxMZnCK4QSmdJwC1bK1bPQZhx7NJyWZli/3C4W4oCGumjZ8NF/GJ
	qpAIMO93fdavv68agNGx5VRzB0OyvoSKKQ5CNU9kHagdAaZOLMXrd7VXBMcJk65cg8WR15jjt69
	QlxdAnwrX2CVyjrtPb0fcYk4hQze28LpWU568u1/8rdyh2OtdsTRP4N8ETKlDgS/1pS4W7YjspE
	f0XSkFlhT511tRRTblCGDpzmMjsRHPLBS21pjcIPH7yoSjFX9GFgqRYJb+otaLzukqgs+kpXPdv
	u7us1dtkCpI02OGEg7LtQCcnbnmpcqBL9Kt0E7qrRPFIrCNA==
X-Received: by 2002:a05:600c:8586:b0:48f:e230:2a21 with SMTP id 5b1f17b1804b1-48fe2302b4amr6631035e9.32.1778756424207;
        Thu, 14 May 2026 04:00:24 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:6819:f883:3543:af7e? ([2620:10d:c092:500::7:3aea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdb2c80f2sm39604865e9.9.2026.05.14.04.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 04:00:23 -0700 (PDT)
Message-ID: <77fb2a01-5318-4e7e-973d-aefcfaa71a8b@gmail.com>
Date: Thu, 14 May 2026 12:00:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 05/11] bpf: Allow special fields in resizable
 hashtab
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260513-rhash-v4-5-dd3d541ccb0b@meta.com>
 <252dc423a3bc75b3f4d936e7706085da71939a88a7ef148926c317d463d20a12@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <252dc423a3bc75b3f4d936e7706085da71939a88a7ef148926c317d463d20a12@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/26 12:21 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 61eb88cb9229..9cc41850dc79 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> @@ -2943,6 +2965,7 @@ static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void
>>  static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *elem, void *value,
>>  				      u64 map_flags)
>>  {
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>>  	void *old_val = rhtab_elem_value(elem, map->key_size);
>>
>>  	if (map_flags & BPF_NOEXIST)
>> @@ -2952,6 +2975,13 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>>  		copy_map_value_locked(map, old_val, value, false);
>>  	else
>>  		copy_map_value(map, old_val, value);
>> +
>> +	/*
>> +	 * copy_map_value() skips special-field offsets, so old timers/
>> +	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>> +	 * to match arraymap's update semantics.
>> +	 */
>> +	rhtab_check_and_free_fields(rhtab, elem);
>>  	return 0;
>>  }
> 
> Could calling rhtab_check_and_free_fields() after copy_map_value() create
> a race with concurrent BPF programs?

Same as arraymap, yes, there is a race.
> 
> When copy_map_value() skips special field offsets, the old timer/kptr/etc.
> remains active in the slot during the copy. If a concurrent program acquires
> the spinlock (in the BPF_F_LOCK case via copy_map_value_locked) or just
> accesses the value between copy and free operations, couldn't it still use
> those special fields even after rhtab_check_and_free_fields() cancels them?
> 
> In v3 of this series, sashiko-bot raised this concern about the ordering
> of these operations. While the patch moved rhtab_check_and_free_fields()
> to occur after the copy (matching arraymap semantics), the fundamental
> timing window between copy and free still allows concurrent access to
> special fields that are about to be canceled.
> 
> [ ... ]
> 
> Commit message:
> 
>>     bpf: Allow special fields in resizable hashtab
>>
>>     Add support for timers, workqueues, task work and spin locks.
>>     Without this, users needing deferred callbacks or BPF_F_LOCK in a
>>     dynamically-sized map have no option - fixed-size htab is the only
>>     map supporting these field types. Resizable hashtab should offer the
>>     same capability.
>>
>>     Properly clean up BTF record fields on element delete and map
>>     teardown by wiring up bpf_obj_free_fields through a memory allocator
>>     destructor, matching the pattern used by htab for non-prealloc maps.
>>
>>     Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> This looks like a bug fix for resizable hashtab support. Should this
> include:
> 
>   Fixes: 9cf2facd6b40 ("bpf: Implement resizable hashmap basic functions")
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25830929099

