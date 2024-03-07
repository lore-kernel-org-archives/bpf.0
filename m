Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA681EEEA
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826929; cv=none; b=QlPXQBOCDt/nM/UMgiu3HCkZf/E38Pf69h4bnFSF8YSQ10mBFAXc3N974XBwLphz2Frghrt3Ay9hLJ0bvh7K2BPu7E84e8qJ1lxOEKZcoy3moeGheuQ9P4LNixE85KYZeVWMomyJtsA+3eYXX6CSXG48nhVxA2iezmERql1s0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826929; c=relaxed/simple;
	bh=iNXW9piONrvgQUxvGpX0lgVN2E1VFDzAvhi146jZa+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpq57Fj4ASKa8NS79WmD36HiUZrp2TkHffEE+XolN49hCFT7U9VN1VTitf2gNxcVPgG04somU72+4NlVrWKKmCKGviui9uWzOVgQstYVpe5kqADr0EkQ+kQA1IiBHLd6b0lT9VKC61FEMklbu6H71McEEkCs8QbWmmO/Hn8TOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbU5bwW6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbU5bwW6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so898065a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709826927; x=1710431727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIpY1hULVE5WNgEUQeRJYLOZD8uZ+zvYIIjXd6Uiogc=;
        b=lbU5bwW6GUPXRXtVRNPcUTFg0EdfJXY308X7tYiG843D3CAb4ZNKD4dQc1oZFdZijg
         jm/NbrDy9sXNzQRAvouVbeTguzMK8E5UP8jdIGmYoGoVd6UWAcvvKweJZ7bNno9k6Cuq
         1h5h+J6I0HZtVhmR4kogc8/6CAqPOmQ3I8o8X2QF8jhxwe9RQERBkQzgIEPfUy+dtZRx
         xmRbI2myLajncmBqZbkwjPkS2qeYXoTQaQbDdmI4EdIHS5K8WHp8ZPUq4QFEbl4weFCX
         GFQ4bPg/6H41O46wgel3LmsXsDp5shn1JNyJ9Uhn7ACq3K0BENOiOOroWISs6uV0fR+X
         3XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709826927; x=1710431727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIpY1hULVE5WNgEUQeRJYLOZD8uZ+zvYIIjXd6Uiogc=;
        b=pjVsU7LPGwKoblMqaHD/iy03p/cEjBLfqqAQ1/T5SmAnQ13n7zsMGFhMVyAwDPL6ht
         h/vW1/DFg57gFvvVZxph6OU2II3/6Uqf1X72gyE7kS5KgkmTVgMWz8TmluGHYFuI1dUZ
         OV7w+nZ6aTwliVQC3jKs9pmvPnp5PzlYliPbVL6MXopXWaPhzU/t9vPxi+2a+ZXoeZlh
         glN4OvLeTIKdDu130pMOqywuFA65XJngpPUSP4kIScm5B/AQgAkR8URTAQV9QCD08Kn3
         1EXOEV/uVVY78mcjX4jU5FAQaSc6qVfQqwq4cD/YFyXIBI/PVKPrKgb1Q5HlnEOQFfd9
         hWlw==
X-Gm-Message-State: AOJu0YzC1mNS/IIWsGL9tOYNyEnX8PMs7KrNukvDP0vKqr2XlUj8ahn+
	pqcgDVdVIjJHGeDwvW8A6yLqHQR8KrPYGcbvwPPUVsr5dQx3lN9E
X-Google-Smtp-Source: AGHT+IEA+1MmPaCP7JPenm+zPdpzFv4QbdDo3x91BBn8jrMp9K7K16wODQFzZ09l6xGnlyV3DGaCVg==
X-Received: by 2002:a05:6a21:3405:b0:1a0:f3d0:15af with SMTP id yn5-20020a056a21340500b001a0f3d015afmr9212620pzb.34.1709826926702;
        Thu, 07 Mar 2024 07:55:26 -0800 (PST)
Received: from [192.168.0.115] ([14.191.95.87])
        by smtp.gmail.com with ESMTPSA id fa26-20020a056a002d1a00b006e62dfd60b8sm6275051pfb.45.2024.03.07.07.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 07:55:26 -0800 (PST)
Message-ID: <549972cd-15e6-4520-a99b-c70c1ed455e5@gmail.com>
Date: Thu, 7 Mar 2024 22:55:19 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 3/3] bpf: Fix stackmap overflow check on 32-bit
 arches
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org
References: <20240307120340.99577-1-toke@redhat.com>
 <20240307120340.99577-4-toke@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20240307120340.99577-4-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/24 19:03, Toke Høiland-Jørgensen wrote:
> The stackmap code relies on roundup_pow_of_two() to compute the number
> of hash buckets, and contains an overflow check by checking if the
> resulting value is 0. However, on 32-bit arches, the roundup code itself
> can overflow by doing a 32-bit left-shift of an unsigned long value,
> which is undefined behaviour, so it is not guaranteed to truncate
> neatly. This was triggered by syzbot on the DEVMAP_HASH type, which
> contains the same check, copied from the hashtab code.
> 
> The commit in the fixes tag actually attempted to fix this, but the fix
> did not account for the UB, so the fix only works on CPUs where an
> overflow does result in a neat truncation to zero, which is not
> guaranteed. Checking the value before rounding does not have this
> problem.
> 
> Fixes: 6183f4d3a0a2 ("bpf: Check for integer overflow when using roundup_pow_of_two()")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>   kernel/bpf/stackmap.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index dff7ba539701..c99f8e5234ac 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -91,11 +91,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
>   	} else if (value_size / 8 > sysctl_perf_event_max_stack)
>   		return ERR_PTR(-EINVAL);
>   
> -	/* hash table size must be power of 2 */
> -	n_buckets = roundup_pow_of_two(attr->max_entries);
> -	if (!n_buckets)
> +	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
> +	 * into UB on 32-bit arches, so check that first
> +	 */
> +	if (attr->max_entries > 1UL << 31)
>   		return ERR_PTR(-E2BIG);
>   
> +	n_buckets = roundup_pow_of_two(attr->max_entries);
> +
>   	cost = n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
>   	smap = bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
>   	if (!smap)

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>

Today I learned to be more careful with UB in C.

Thanks,
Quang Minh.
