Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B3480DF7
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122634; cv=none; b=fvG9HQJRkW8XfQqqoGYoPomd0pGglG3Tos/mi4qUuhX5ZXwvKpud8JPK2ow1o1KmIRJkZ4UsuUi3ddMRk1WtwwmhCy+hqGAEoLpeJze+rArbLn1bJ6KfP0DRCHKChGIpO4KScuwb/5/owAYN9qqFkAQsvyor5p2m1ptAghJCPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122634; c=relaxed/simple;
	bh=BpUI463qOnTFoISKFwnX5ZskGYYCjuOqBstCVOJYwzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlS+7WEYSq7VB/Pz7Do7RWFW017ijxSXnG8fzetgDSgwalL1HzN9SeBPyMNv5/zht0ij6Xf3U5Em4pxDN2G5ArQepQh7KVsQuX+WRCodr6is65ybYS8TrlAbhCA0aL1giYyuDZjsjVuKdWjo5Q7Pw3iIbke1YzJOh6XpvuxGvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tL8Qus3F; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL8Qus3F"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48896199cbaso19759135e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122631; x=1779727431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSt4x+poU4p8LXWInMRteFG4LHeESzIi5up8Mh8FuBw=;
        b=tL8Qus3F4zRUUEGV3qGi6geTpbWwiLc8IvlQAXmMSYPz2bJo67wbRasQux7hs12qIq
         ABmyKdA65WCX5fnURIFo2bBmWdmKcnH4m/o1DqnStNEh/kU6bNdLHuFJR/pOrFvABqwS
         i/2v1zd/Y0xEtRuFdjILbJmQ+Zc7n/TRjwhUKm1m2O+y3fu+WkOuUcnsVXci8LUUu0jM
         StcAG8kOznCaV3BS9GTEr27aCZMkfIppstjtBdEXyMHzMZFtSIDiQHKaF8oyWdTeVWrG
         t/M4uTSVTrlWA2D4CVy3s8t5lXat2kx1Dm+ddWDNcpHWRTC+gswyTYsYuQIOXKfzcARD
         boUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122631; x=1779727431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSt4x+poU4p8LXWInMRteFG4LHeESzIi5up8Mh8FuBw=;
        b=Ub6DEG6IaXa9dcx3AAu+kaNFWkLNaFmnPogY4isaMcq+Rdrin6j5oQl3EK3j5JODzY
         9zbmWiZY7nNNXB1IQkJhAeucWJCctSkJ9yLtYp+eIx6HCwCsM/CU5fM25pkLFLT2oXrL
         W+ZYsTb+BSDCv6bQBE+Ko2LMYB8jZI66TS5J93ggsCvinLWaB5xczk2ty0aX5mBQQA8K
         KyHuaiSjfIU3bOz34LreWuYPwh1qvmzMJeu3N4TccLvJyphdO1Un536Fm4G68zt+L2wt
         RMYf9wQGVwMm4+oedQQBsFbjfxRdco5HEjO1HQxSBXmRFsjUuEdc77davYiyK/5U36/N
         wAZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NrzM0UixhHQqNn0FYjDQS8ummjJOIpGmh2ZoCXe6gEDWiZNzConc1DafCP9IfM0n89kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJa9NvMIoWe5hJgbyVt4NY3x3HLXdAmTkFMMNKlU6LnC2POqN
	zqy3fm4piYbGvx4MRHJ+oI8EFCs2L4w2zGAIs1bX9S5//Hih+1wijAKu
X-Gm-Gg: Acq92OFusXMbOzbFbF+93FqDB+2MeYRk7zQZ6yAgpJa5Cd098uqGHCseh6ejfIB+2vu
	gPyvH/Qq08e1aFZS/ye1BiINK2nEf4mpQntSeKnNdAAF5V+mLGIf828MuVMQVAkBptmWGcw4405
	lOMzNevTwrOGwb5rNJYLviAi8jcZWmJAsxqp3y2RLjGCMKyp8fv9oJH3480t0o5M9pR7R0hpN7z
	MmKcLHdwrtorqBqpQYuvwIC3Ey2mB3WVCtxtkte2zldC0EDWrXAjutNKI0QASQk5iXzi1Ms60vS
	NzH9RfnH8WVEdS4USsmn53M2cTawZBjcrEOVCF2iPmHCMFSb5W6r6VGASxY6jXm6iWui6X9X693
	+fSas/6ih8JVKRxHrtNQ+AoWYmMyeDTsPjHVUYeEjsnmc6uFR+D1CW2LH4FX6nbMBb+FcLPIgIq
	pDarkpPh4wNvy2/3+eYfXU8PdbB9c/AhegzazoJbvhYRNG8NUNfMl98rq1nVCj2iSv4mLN/IQ=
X-Received: by 2002:a05:600c:8b0d:b0:48f:e230:2a26 with SMTP id 5b1f17b1804b1-48fe6631679mr255364615e9.33.1779122631321;
        Mon, 18 May 2026 09:43:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1178:9251:cb12:6150? ([2620:10d:c092:500::5:5e25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4dac000sm272950585e9.0.2026.05.18.09.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 09:43:50 -0700 (PDT)
Message-ID: <261a47f4-a92b-4a61-86ca-c1de362be105@gmail.com>
Date: Mon, 18 May 2026 17:43:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in
 map_create()
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260518145446.6794-1-leon.hwang@linux.dev>
 <20260518145446.6794-3-leon.hwang@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260518145446.6794-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/18/26 3:54 PM, Leon Hwang wrote:
> Because there is time gap between bpf_map_new_fd() and close_fd(), a
> concurrent thread is able to close the new fd and opens a new, unrelated
> file with the exact same fd number. Thereafter, this close_fd() might
> inadvertently close the unrelated file.
> 
> To avoid such regression, drop close_fd() and override err when failed to
> create map and failed to finalize the log.
> 
> In other word, when succeed in creating map but fail to finalize log,
> users will get the map fd instead of the finalization error.
> 
> Fixes: 49f9b2b2a18c ("bpf: Add syscall common attributes support for map_create")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/syscall.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 83de8fb9b9aa..322865a88b3a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1647,11 +1647,18 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_at
>  
>  	/* preserve original error even if log finalization is successful */
>  	ret = bpf_log_attr_finalize(&attr_log, log);
> -	if (ret) {
> -		if (err >= 0)
> -			close_fd(err);
> +	if (ret && err < 0)
> +		/*
> +		 * Failed to finalize the log.
> +		 * Should not close_fd(err) here. Since the bpf_map_new_fd()

nit: you can't close_fd(err) here, because err < 0? The comment overall appears to
explain why we are making this change right now, rather than why this works this way.

If map_crate() failed with error code and then log finalization failed, do we really
want to override error code? It sounds like map_create error is more important.

> +		 * has published the map fd, if a concurrent thread closes the
> +		 * fd, then opens new, unrelated file that receives the exact
> +		 * same fd number, close_fd(err) might inadvertently close the
> +		 * unrelated file.
> +		 * As a trade-off, override the err only when failed to finalize
> +		 * the log and failed to create map.
> +		 */
>  		err = ret;
> -	}
>  
>  	kfree(log);
>  	return err;

