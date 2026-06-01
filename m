Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1F37FF4D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319134; cv=none; b=HlhTeC+CJznXxL9QVWKvVIRSpvYKQY+kW9P0XSJrZkGTu56Z5zG8wKRZkh8+duyiDb49K5Fw0EHVccbQluWuZaDYCgr63qI2YpfPrMzzUM1W9p5akxovxpuGGUCEw7RUgC7rJxg5vfEOaJLgJVqRS6ExQMkyyM2ooK2b1EXX6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319134; c=relaxed/simple;
	bh=ozR9ltLTApkw85OG/688OP8CpIqLRYqGlMxSC7/6o4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvTJtD2IW5oUank4IhYlzep/p7L6AGDx1RdiGSrpPSCjeMIKF2OrR84y05ZlcgbyZsn5U/rZXLKEijAojagie1mIxuthfTn7NqnQqMijxpy6d6HTN8pbnXQ5W+Xba7zvj4erUKolpZ7RtFQsqs7Eyh/0qxwbkcgw7M+Pz8fRFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLzOjqn7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLzOjqn7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so90293245e9.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780319131; x=1780923931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8nNMSGnhUOGcXS6kBwWvWpfl1j5D5LauCE8c5VrDv0=;
        b=PLzOjqn7DxW8Gi/vrjKKUu3JoTOW2qmDPBV7TJAa8eLgEvge9MBATs5clemQShGLkP
         nB7+XhyEyptVadl+CT1U9nLNim7yDbOgVwH5N9b9JhGp6KKugYhA2aVcCS28QZHYs7Nt
         W/nPkwNJ4fAh/7NKHSQTF/jaPgsm2OYWLfkIoeeD4ddBYGXZ1B2eizjgrVrBcLJ199dF
         g1f5T8Uxvh3GD8yw+0JlEj2flQoIOXDJ9p8LOkDwDN7p3zRjHtd1u7MvVJ7REMlSnyjV
         NRfMmgCog81OhafSz9RfYdGkIKJG8Kq/ppswYSumAmVfzwR9puRWetrdB54L1Z920FtV
         Fevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780319131; x=1780923931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8nNMSGnhUOGcXS6kBwWvWpfl1j5D5LauCE8c5VrDv0=;
        b=Qs0Itw092l6aChT4kIxjGK9YbMbX10gnYBUke/7JmgMyFBUdMrwSA6CA/AQPGwWPOi
         ryAEsd69PRgnbAY6uhryds9o6x3WlBBZw5tzJXJlQCRvQOv3sFz8TPi5e5Jf3QlA+oer
         dIx5ixjfOuMObi5yb0mIXDYr/XVRwRbRTku/nTbWHwdamHVUGI2b71EPJNCLGKEKJ3rr
         eXGMTRkwxkkt41DKKv3Q3I0ZgdkqKOXLzKGml//7wTkR5x0gxY164NbWoDta+9s5olku
         cTKtw5cGJ+p0jCxgjqGa/BXQ+eO/RWEhLxG19CDGR8uwQ6Psuw1Ahl2CcA9XpT3lp2cd
         1FjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/l9UM3IXeu8/EEDWQRVl9/bYn4pRV3BgYM2nT/ufi8mg4Zy2PRpl364fb1XiXX932VN1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws59reCX33gWRwR8Jp1X6F2VGMuwX3uy7KOltbSxJnda1mTbpP
	H6fzS3y+CnLTLmN5SqTeVNnS0B+bvda/voJm0F3WFRmrCOFaw5UyIPVr9UQL9A==
X-Gm-Gg: Acq92OHToSMxYZh+qlq7aIekeKsjEYlH/bHiECawAsEyI9fMzGeyhbdkjGSvXiHSh4A
	1+lHvGVp3q5WnZGF7jE3JU1r9T020nE8HOVS9fixKogLySeLaAJHzaLk3SX4wRTPom6XEorr5pt
	d0mdala2txLYjcoO/D7uIoK/UyVCed4wZE4LXvdk35vjvzHEI6MdYAvtA8Yd3Vp5QblGnfWElZ6
	ZeRQHvcXNp5VlIJwVgbRnCnmfsk2RZAx/mX/FVG618e9kzR8Jsl0GTugJt7COcsNNCBabGW3mu/
	PEUXPK8mqz1gqH96QNox6E2ZRWtYCnagAWpB0j4SAto/vODRpi2QZMj3Ytk0LTRE/63jZ7nN4Eu
	976f2TPcVEK2OsNXt3+HawJO3EPbUTP9dsIsmlXsAfrgVnMSVnYEgkaQpeWoQj/zRQay9bIU5Xd
	3G7KBeuN2WcnynSQcHg5iu9oxkrIE5i0X9Gg3TlVLMLUEEfovnfNMiEUaoZuInjPrr47L1xGgbW
	F32QZ+0G2CeLHJWemeZzQ==
X-Received: by 2002:a05:600c:1988:b0:490:9d1b:201f with SMTP id 5b1f17b1804b1-490a294d4b0mr190386275e9.32.1780319130791;
        Mon, 01 Jun 2026 06:05:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm26542924f8f.10.2026.06.01.06.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:05:30 -0700 (PDT)
Message-ID: <a6924048-718c-4012-a6a4-1167d27c65de@gmail.com>
Date: Mon, 1 Jun 2026 14:05:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 05/11] bpf: Allow special fields in resizable
 hashtab
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260528-rhash-v5-5-7205191b6c57@meta.com>
 <ec7827303c4fdb3bc7d4153ca65387f4929d4c9e53aafd1c7d79dcabaea2b192@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <ec7827303c4fdb3bc7d4153ca65387f4929d4c9e53aafd1c7d79dcabaea2b192@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/26 7:26 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index a03fa5fa6545..50e9d57b2790 100644
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
>> @@ -2952,6 +2975,17 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>>  		copy_map_value_locked(map, old_val, value, false);
>>  	else
>>  		copy_map_value(map, old_val, value);
>> +
>> +	/*
>> +	 * Torn reads: a concurrent reader without BPF_F_LOCK may observe
>> +	 * the value mid-copy. Callers requiring consistent reads must use
>> +	 * BPF_F_LOCK, matching arraymap semantics.
>> +	 *
>> +	 * copy_map_value() skips special-field offsets, so old timers/
>> +	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>> +	 * to match arraymap's update semantics.
>> +	 */
>> +	rhtab_check_and_free_fields(rhtab, elem);
>>  	return 0;
>>  }
> 
> In the v4 discussion on lore, a concern was raised about the ordering of
> copy_map_value() and rhtab_check_and_free_fields() operations. When
> copy_map_value() is called, it skips special field offsets, leaving the
> old timer/kptr/etc. active in the slot during the copy.
> 
> Could a concurrent BPF program access those special fields in the window
> between the copy and the free operations? Specifically, in the
> BPF_F_LOCK case where copy_map_value_locked() is used, if a concurrent
> program acquires the spinlock and accesses the value between the copy
> completion and rhtab_check_and_free_fields() call, would it still see
> the old timer/kptr that gets canceled immediately after?

Yes the concurrent BPF program may access timer, wq, task_work, etc that
is immediately canceled, this is by design, what matters is that the operations
are safe.

> 
> The comment mentions matching arraymap's update semantics and acknowledges
> torn reads for the non-locked case, but it's not clear whether the locked
> case fully prevents concurrent access to special fields that are about to
> be freed.
> 
> Reference: https://lore.kernel.org/bpf/252dc423a3bc75b3f4d936e7706085da71939a88a7ef148926c317d463d20a12@mail.kernel.org/
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26592533594

