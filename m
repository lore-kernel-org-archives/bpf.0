Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951E4AA036
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274600; cv=none; b=eii3qxMo1+sAQlTvojprN1nG13kiecNsQQCNsF5ohlYZxRUm3M/7jykYsmuP57EchWUHKVao+nP6L8S4PjrHFXTkEMkuAVXGjGmaNpLIkSXSK1Ge2/D3jYr9yVsKizAW7IyHqcHn9pNvvCPfZubsni1m+SOFDAPkMLhy8qrj4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274600; c=relaxed/simple;
	bh=M/v9fTSSwo8NtDcmO7C3xVTVCYyBfbVzs5jsrtPsWH8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KKmgSxujvFD5mVArPJ6k0nw3VkNJu/NTzv+ZWq/SmtWHUcUcwoAzcvv479WPsSGygPR/uzxX4QawtYTwuIUJJARkBr/zmgQm3lKRes5z/TjRydMLI0e2Q8N0DLlr/+j81ytDPiOw+1QpbYmQGiPC6upfkv0uZ+dqX1GwPIdS0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=FtphDCNo; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="FtphDCNo"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so142948a91.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790274598; x=1790879398; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1glkVmXF4TAzT4eX6BU6NxXZuycQ5JW/Z2wzboxeP2A=;
        b=FtphDCNoWjGaOjaK4GeV99VKb6K6yz1wW74qDsWl3E2hE5wKcpc/zlAQkI/JLVa4NQ
         nUsEkbfssJ27SMi3kunf4MVlamur4tUq88JJSYrubmUqAshKfXThe4ytKytoYFFhEOSC
         r8jISDGFw+2bgn8U2IAxhgS5pQzjCfHk+2GlSciDPQMQNSAqa1jcFEuctSqn2tTIH496
         0eFY3q0Gq82zOwqj5GG84m51t6NRtLZstZLRt9OKswAOaU7Yf5hXunPlznbcqaGP5Qc+
         8TQxhjbP5X/F48MkHmNnTMO/7BUAphiY3i+xBetsjsdZDoSWXaQT9JluiGSnr/Tc5P/z
         hc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790274598; x=1790879398;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1glkVmXF4TAzT4eX6BU6NxXZuycQ5JW/Z2wzboxeP2A=;
        b=VkeeLh9PNpJi1IqI6HsFjhDI+LJVUvpQnTXC3XKPBsFKqbxw5xKACLCtV+Y7yx0/zu
         sF++sf+vF0qd7XOkb36WYL9W2Fmz//jS8BDeMWKDaZqn5WleHJE4c42SaUiwfhEvx49A
         jjEK/1adX9unjyxR57EHMSY4UtK6Ev0ug4qRhRvptwSpp82SXQUF6wmzLKw4BG/pSKqc
         u9X1JgaaEYt+a8PU1ucEE+SmeJKXKUz1KThH6vZRe+KbgojlSAJhJp738FPTPhvg5//g
         OC5Te6AZbdXMsThJGevvJnPtbtftanuQRNLUDJSIR6TAabMDSxmg/yfDyKglc9Jmjz3C
         ujEA==
X-Forwarded-Encrypted: i=1; AKwUvBzXo5/MDb5eKZjGr+V9VZW2dVBqoN+3GFXgrTrVYd2H5EIi4fZfPh0S3TtY4eFzSGzEgR8=@vger.kernel.org
X-Gm-Message-State: AFuF++kSCJPmltfgho4h2fZfuM7CIziehy7ywk59W4oCfzLgbrrvShjq
	WeqGMUh+SoGaMNFLyxY/LxxCm67w6hd4A+nDoy7WlPdY0rI9BXxWbT2bxeMu1E4bs5o=
X-Gm-Gg: AYBFou0pim4/rzDg3fDCuF4pMZ3EmGhNRFXkcTwAi2vQaoKUyk7WHlW07846vJhsYzX
	IOqv7r2jkhTtjsxPo8dr5fJCiPOwdc85tQHMXVAqlkrfGJvvbTJU/nFAUhe/pdRbGrytM9WZJHO
	hLEaXdOpoR2wz3Xtb5IbTD8f/Q+1aw7WaUkOW/ZFph9SH7CH5dMpgqTqnzwNqvAcYQgrqXRVq5m
	MQnUVBx2ocnvDeFMx7Ke2EXZeGLew9FTdu/S+TfC4LDwmSfyjgMbOr6sUtWgzXpKZKyVr5NlLpL
	Civk9QLlI7s0fPhbNjWDJlCv82nRVGWgdmKBnW+7C09HggJO5DqkByznF7syAg1mcIOg4WxiKWk
	3XNePRrJwob96yHWB36wrvxokam4e5+gQhLk28gUyxM2f+M01pzYIfvgNs1SXrve4Svh/s5AvI1
	MCCwBGJTEiPwaSKS7gvDJ3t/fZFdo8aHktTSEse2BHgkVPRA6Y0sG8tiz0tDjBTswuFeXEXT88E
	YUb9nnZ/Ld3lzhuYDFIu7xQtyy8dJuR
X-Received: by 2002:a17:90b:4a89:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3a098fc84eamr2956316a91.62.1790274597454;
        Thu, 24 Sep 2026 11:29:57 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fd0sm6071227a91.9.2026.09.24.11.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 11:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 18:29:56 +0000
Message-Id: <DLNRDNIJW1EJ.3CIERD6PZ2XT1@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v2 1/2] bpf: Add sleepable arena page allocation
 path
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924053621.7076-2-emil@etsalapatis.com>
 <8012e6b9f32534518dd069e927814eceb41c0f3bd7474c64349143d4283aa4be@mail.kernel.org>
In-Reply-To: <8012e6b9f32534518dd069e927814eceb41c0f3bd7474c64349143d4283aa4be@mail.kernel.org>

On Thu Sep 24, 2026 at 6:29 AM UTC, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 1d2676782d70..71688190a7f0 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>
> [ ... ]
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 7b6847200b43..013faacc4551 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> @@ -698,31 +721,38 @@ static long arena_alloc_pages(struct bpf_arena *ar=
ena, long uaddr, long page_cnt
>>  	}
>>
>>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>> -	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() c=
an succeed. */
>> -	alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct p=
age *));
>> -	pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_AC=
COUNT, NUMA_NO_NODE);
>> -	if (!pages) {
>> -		bpf_map_memcg_exit(old_memcg, new_memcg);
>> -		return 0;
>> +
>> +	can_sleep =3D sleepable && !is_bpf_alloc_nonsleepable();
>> +	if (can_sleep) {
>> +		alloc_pages =3D page_cnt;
>> +		pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL_ACCOUN=
T);
>> +		if (!pages)
>> +			goto out_memcg;
>> +
>> +		ret =3D bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>> +		if (ret)
>> +			goto out_free_array;
>> +		data.i =3D 0;
>> +	} else {
>> +		/* Cap allocation size so kmalloc_nolock() can succeed. */
>> +		alloc_pages =3D min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct =
page *));
>> +		pages =3D kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_A=
CCOUNT,
>> +				       NUMA_NO_NODE);
>> +		if (!pages)
>> +			goto out_memcg;
>>  	}
>> +
>>  	data.arena =3D arena;
>>  	data.pages =3D pages;
>>
>>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>>  		goto out_free_pages;
>>
>> -	if (uaddr) {
>> -		ret =3D is_range_tree_set(&arena->rt, pgoff, page_cnt);
>> -		if (ret)
>> -			goto out_unlock_free_pages;
>> -		ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt);
>> -	} else {
>> -		ret =3D pgoff =3D range_tree_find(&arena->rt, page_cnt);
>> -		if (pgoff >=3D 0)
>> -			ret =3D range_tree_clear(&arena->rt, pgoff, page_cnt);
>> +	ret =3D arena_adjust_tree(arena, uaddr, page_cnt, &pgoff);
>> +	if (ret) {
>> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +		goto out_free_pages;
>>  	}
>> -	if (ret)
>> -		goto out_unlock_free_pages;
>
> In the sleepable path, the code now preallocates the entire pointer
> array via kvcalloc(page_cnt, ..., GFP_KERNEL_ACCOUNT) and all page_cnt
> pages via bpf_map_alloc_pages() before checking whether the requested
> arena range is actually available.
>
> The range check happens later in arena_adjust_tree() under the spinlock.
> That check rejects requests where a uaddr hint overlaps already
> allocated pages (is_range_tree_set() returns -ESRCH) or where no
> contiguous free range exists (range_tree_find() returns -ENOENT).
>
> The old code ran these checks under the lock before allocating anything,
> so rejected requests returned NULL at minimal cost. With the new
> sleepable path, each rejected request allocates and zeroes all the pages
> first via GFP_KERNEL allocations, potentially pushing the system into
> direct reclaim or OOM, then frees them all through the out_free_pages
> loop.
>
> Can a sleepable program that retries a fixed-address allocation or
> probes an almost-full arena repeatedly cause large reclaim and OOM
> pressure for requests that were never going to succeed?
>
> One approach would be to reserve the range under the lock first via
> arena_adjust_tree() and allocate afterwards, restoring the range with
> range_tree_set() if allocation fails. Another option would be an
> unlocked or locked precheck against the range tree before
> preallocating.

Not possible. Reserved ranges can be pages in with minor page faults from
userspace, causing the allocation to fail halfway. Any pages we install=20
after dropping the lock will be visible because apply_to_page_range will
have completed for them, preventing us from rolling back the allocation
as they may have been modified by userspace.

>
> [ ... ]
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 244a939b9d2d..9eeb65f2d929 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359618=
88778

