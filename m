Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E793348C7B
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008494; cv=none; b=n9V4FJCIDooqCtR+R38HCZd4eh48pj7WFt56uu/k/4WdphpyqgtfCYrMB3HwWY1s/v2mE3p6rF42G0WKCCNS80gw8Iov4/rkI24Z1LWww6Rd8B2pzFd//Ozfl/tuEDb5/71kpa4pb2YLs5gFo0PS76+27EKWEX9wAI84XW6Uu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008494; c=relaxed/simple;
	bh=mHIc9MUWvhIvOMaJ53StabgXjtnnhvfhTIcgkTRWR8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1HbNeBmj4JGxRv788jRPQBSGDsOVar6vEl8WGoxFfn1K5Yyw96wvuCgWTyYFEcjM7butS+PVMIVXOXPFQDw5/IoxVRq7ahAHW/Aj68f+7tJgDd5x4GSAOO2lMHPXeGIbCZVeZYXUfJ7CixpI34ASM519RlukTlK3qxM4wkKajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZrZeMMF; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZrZeMMF"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so23988175e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790008491; x=1790613291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yj1asAzCGNZYx/eFh4sVykVhyDqH4wbYpV+T9HpxLgM=;
        b=gZrZeMMFQLM3mvsKCCaUY4w5i2v9EjSP7589zNwD23P3GWwn56BJjkWGnGW0cP3q0u
         nduw0QvSrjcsGiRrwh9TEnWBfu6EGrQZ89MXzRrgGyRRZ39nKq27rkONxm97u1t3F7jv
         rT1w64Tn/sQePDqZHZABL5iGMm+nnzPoQExpD77HE2z5TccmvLRoc2KaMJzV/6Fd4xje
         N6UfcUjnkBqaYR/XJuZvN2a1ZMFS+Igb7prMSXnvA61dr82+JllDlshKAL/VWwUD0Idr
         4qCzJ2Dt68qSBh5s46K+wIgxV00qgBnzUwVO3gCaGvFgQC4Ldy3nieZNbkVSiFmPmUpN
         WOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008491; x=1790613291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yj1asAzCGNZYx/eFh4sVykVhyDqH4wbYpV+T9HpxLgM=;
        b=DObtlAS8zgttAlJMt1e+BYQH2rfmHtPipYff96nE/rBYtFM/kOOP1Jeo2x2R52sJer
         7Ix4bAbvRj6sSlN7V2TeyCpeSj8UNIaLWlPVz1Jbtik8yTT8e6mpvANnlcFA7IP+xT9X
         KtNGWqHywxt4rKKvppmihdjYfV/qGEJGVo5y4KG3OE++c/YBwRcv6waKwCZyX444nJz+
         Fu2AvJOeTjDhFWh35II/qrh4Y2BWg8XIIpbhe6flfCUQrsrCoXR5QidU7rrORY2i7PGF
         I7YWkaF4opmnP6zvqxHsi0uQqwCJ63fgbpRnfIQ55qFDTevQIB7ZZupezoORp8/v+ts7
         cn2A==
X-Gm-Message-State: AFuF++nskKJt2sIded5kW5ylkZ7gW5lzGuQ3VSQ8uyN8s+R+TrpnQR2P
	QFkqXk2KHI7XzT1YHAEXelj+hXWY6h92sMXLttfIXH9kc/Cx8oTmK6Z1
X-Gm-Gg: AYBFou2qtbBJuZJNjX9i+76IqWzPfAQqpYqmk9xR4D2TCk+0nLK7TObTRtTgCSv+NBC
	oV4LMjVVhziC3KbJhC+Lfl4OsZx6bA797b+M9Gon/S0tPyCwdSRnvCR7HR5pTu0CyTYy5b6cALm
	1xvDCTs+btlltf7L33JBvCvngCow8Y4YtMeIc5OvwoAPE6qnMbini7HSUbTG8bZ2E2ctXxbvoij
	3LY+Gl/3EnGjNIQrn5o429VMWSPsr8fATR0usYQqLP30VmDVtdRPYyE9RWcHZyhRdBTSI5BCueb
	DhWoeDdBBaU7B3mCVWofmF3NE8ybd0IcdXkZRKvCF3IR9oGiPbalk+WFoVtWFQQ3ZRH9BqaEq9H
	gcZYQhaMrhIjNT1CDpVoHtc2VAkKCkqSMQbbmPk69KVLLR6RrepFR/SVe6daCkoe2gHSnLNAiYQ
	TSyCbofFSJk60z37yS8L4wgA6YSCinf8IAPm1QXFCKFgJyigQs58m7siorxuFSRtvPi5GH0aQdn
	+/z3SIw
X-Received: by 2002:a05:600c:4e56:b0:49e:79c5:ee93 with SMTP id 5b1f17b1804b1-49fc56b4fccmr159370375e9.8.1790008491088;
        Mon, 21 Sep 2026 09:34:51 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ce24fesm2828105e9.12.2026.09.21.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:34:50 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:45:22 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next] bpf: Speed up htab hashing for u32/u64 keys
Message-ID: <arFfIh-vdGc9ylj_@mail.gmail.com>
References: <20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com>

On 26/09/21 08:28AM, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Four- and eight-byte keys are common enough to warrant avoiding the
> generic jhash2() path. Fold JHASH_INITVAL and the key length into
> hashrnd when allocating maps with these key sizes, then use
> __jhash_nwords() during lookup.
> 
> This preserves the jhash2() result while avoiding its length handling
> and repeated state setup.
> 
> Measure this with six runs of:
> 
>   ./bench -w3 -d10 -a bpf-hashmap-lookup \
>       --key_size KEY_SIZE --max_entries MAX_ENTRIES \
>       --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
>       --map_flags 0x40
> 
> inside a vng guest with two vCPUs and 4 GiB of RAM. Keep each map 50%
> full with these workloads:
> 
>              max entries   entries       loops
>   small              512       256   8,388,608
>   medium          10,000     5,000   8,000,000
>   large          100,000    50,000   8,000,000
> 
> Mean throughput in million lookups per second is:
> 
>   Baseline:
>                          key size (bytes)
>                       1        4        8       10
>     small         87.55    85.65   102.20    85.74
>     medium       120.88    79.02    89.12    76.52
>     large        126.61    52.28    57.78    47.54
> 
>   Optimized:
>                          key size (bytes)
>                       1        4        8       10
>     small         85.97   106.06   129.24    84.47
>     medium       115.97    91.30   101.41    74.17
>     large        120.27    58.16    62.03    45.99
> 
>   Change:
>                          key size (bytes)
>                       1        4        8       10
>     small         -1.80%  +23.83%  +26.46%   -1.48%
>     medium        -4.06%  +15.54%  +13.79%   -3.06%
>     large         -5.00%  +11.24%   +7.36%   -3.26%
> 
> The targeted four-byte lookups improve by 11-24%, and eight-byte
> lookups improve by 7-26%. Untargeted one- and ten-byte lookups are
> 1-5% slower, consistent with the extra key-size checks on those paths.
> 
> For bigger key sizes the overhead of optimized key size checks
> should be less visible.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6f331c80130d..4f1dbd6ebc07 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  		htab->hashrnd = 0;
>  	else
>  		htab->hashrnd = get_random_u32();
> +	/*
> +	 * Fold the jhash constant and key length into hashrnd once for the
> +	 * fixed-size fast paths instead of doing it on every lookup.
> +	 */
> +	if (htab->map.key_size == sizeof(u32) ||
> +	    htab->map.key_size == sizeof(u64))
> +		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
>  
>  	htab_init_buckets(htab);
>  
> @@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  
>  static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
>  {
> -	if (likely(key_len % 4 == 0))
> +	const u32 *k = key;
> +	u32 b;
> +
> +	if (key_len == sizeof(u32))
> +		b = 0;
> +	else if (key_len == sizeof(u64))
> +		b = k[1];
> +	else if (likely(key_len % 4 == 0))
>  		return jhash2(key, key_len / 4, hashrnd);
> -	return jhash(key, key_len, hashrnd);
> +	else
> +		return jhash(key, key_len, hashrnd);
> +
> +	return __jhash_nwords(k[0], b, 0, hashrnd);
>  }
>  
>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
> 
> ---
> base-commit: 6849a44e5946ebf646e82c6a0296840d2b3bda5f
> change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e
> 
> Best regards,
> --  
> Mykyta Yatsenko <yatsenko@meta.com>
> 

Nice!

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
