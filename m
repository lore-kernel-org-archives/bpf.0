Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9827F4CA
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266621; cv=none; b=Sx7DEZ2i32sPMWhJXNP8ctBTmRhTcQKIx1fI5cPOqMZWTOkF32fAcQDfjkuXxNq6xD80slu9EfQ+KLZ2frsnZ+X+wrX1vedfisSa74eFziUKt2YmvBjOIoolgvPqplnOirMN4EuT0uUpQAbte8OVox8G3UPYlYzKrmZUqF4ZWtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266621; c=relaxed/simple;
	bh=MAEs3Jddu85q70yGwvGJmRXFIyW3shtR1hg+pghMVm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VhwftFpEp7Me8f5xSETZtvQdn85msyjnycvQA4+lF2/Hs+3f+l7Cj4OcySvrOh9CGPI3FWiMV7vKbORvMg908L7RTNpWmk8RDw06Ac9I2qjvLRXHK6OGohjq2T4r17GbnIuRen41v5UkobW/GmQwiR2Vyc7gQ51EK8gnJbJEiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMLJktL2; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMLJktL2"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124a635476fso3846493c88.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771266619; x=1771871419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkJWUx4iz20mHMlM7dqbfruMTcGOgRj83PoFq0CJCIQ=;
        b=dMLJktL2qRHJHkLBftVGBt/ill/K2ExeWTvtZA/hZ1YMOwn9BPr0tXAhoCOoJDX+2E
         6FaWkjwiege15sgemLCZKR4DkHPqeGqOjbxeGjC+tOtZMWY1hJx38Zw6i9Ak1+C6c4hL
         DKqnQtuSrUE87hEQC6F/P9X2EUZZNeXkayRwR0QgQijMKjwvKF+sjsfEbNm+bZC6CZCV
         Y9KPtK60qsyAOGgmDG+SJobr7u//1MTnYeRTUiVa7/hW8uy95zbT+r9CObAMa1AgGTOt
         HPEkquwTmfsIIM4zz2V7B4GG+chjM7KRV+mYwAiND/qKsQ9lJe03DBT1m62bEtZofAcb
         ChZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771266619; x=1771871419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkJWUx4iz20mHMlM7dqbfruMTcGOgRj83PoFq0CJCIQ=;
        b=RQ7Qa7rMkFrQ5e9jWoscD1o2T2g/zViHBClPcl0KR4670pw3VNPQtQuA0zziB50P5/
         vUfxowMZ7hqJPIcyNPpPxm5Ovdk0BgAeLFg3cqWcj4q1fi93ewTB1AnDsOu4wB/vpiyd
         eArJ37O+oWXCvOtUKITIThOk754bAfgGjQbQ2ivpl/D8Bsgy5+tI+knNH8SZelD2+SQQ
         OmAgstM723ebpDQyVH82YvswQd9Nz93sxyAtHSKOhStTV9U3LiYdVTMtEGopDoUeMR5j
         Aa2YJv/mG5eU8e0mk2NTDFnDghLuDtx6E80gmNZrrIicBsRnVncC2KWcarmqS541tovr
         dSSg==
X-Forwarded-Encrypted: i=1; AJvYcCW4VKcyQu0QmhB9NmR5z5Ulxeci5VWOxNWV//IEyJRln6sJfj/D3aoWXw8smKLJGatwOPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx866i5Yg5/4YKHJdZfz88LZpF8CdzTCC0tga49fA/cv1FnZK3Q
	4PUxdGNg3FsELHmUdh9kGZ9DpHZfOprjL2OFF0K3V94ChyAE4u8l94tz
X-Gm-Gg: AZuq6aJl4l9HF6xxjRAQE1fjs+DHErNhRjXLu9tzbVZblMN93aZSCIBJ2SPoANe/4r+
	Vrd2UWbzBMRNAD6mzzDgsIvW8KPxLbZeu65q9F/b0g8SiQ+mFdBQV3THn1rmJM2kLwGZg3ukTr8
	2jSpKtBbn5YE52G2B9vJa+LZRzt4TNpv7Shy3QgYmIvYCU+RUOXTpvEUglPnXr0Dyg9Gz41pFgo
	cDBL0u7RAQzsZ9fe4d7vKxuAn/7w0muC7Z0CLDC46M8C+aUhyuvs6AKBWN/8pPwcLVi98k4RtlX
	soZIcWAe9EaFOOf3UWjshpmTzeQFTBO1u71a8/zE9wxoyHuEDP+sygngGIkKTAH2vusS1IqhMpA
	+b7HE2Zen55uncCkSZiuVKh+CoFIszB2LhN5DYexCwaJkCrZl8rk6HmQSIGM8BRe/PzLOsm2z1j
	dLXqRkTmK49J2AkHkq9KtiN0YB90AbztlF
X-Received: by 2002:a05:7022:692:b0:11b:a36d:a7f7 with SMTP id a92af1059eb24-1273add4230mr3788461c88.16.1771266619112;
        Mon, 16 Feb 2026 10:30:19 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc83e6sm11517513c88.15.2026.02.16.10.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 10:30:18 -0800 (PST)
Message-ID: <ac9ccc1c-acb1-4439-8db2-eafe757c4f9e@gmail.com>
Date: Mon, 16 Feb 2026 10:30:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Use bpf_core_enum_value for stats in
 cgroup_iter_memcg
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Hui Zhu <zhuhui@kylinos.cn>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1770965805.git.zhuhui@kylinos.cn>
 <24ac7bab25d8d2a24a35ab87a5283263eb6a4575.1770965805.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <24ac7bab25d8d2a24a35ab87a5283263eb6a4575.1770965805.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 11:23 PM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Replace hardcoded enum values with bpf_core_enum_value() calls in
> cgroup_iter_memcg test to improve portability across different
> kernel versions.
> 
> The change adds runtime enum value resolution for:
> - node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
>    NR_FILE_MAPPED
> - memcg_stat_item: MEMCG_KMEM
> - vm_event_item: PGFAULT
> 
> This ensures the BPF program can adapt to enum value changes
> between kernel versions, returning early if any enum value is
> unavailable (returns 0).
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   .../selftests/bpf/progs/cgroup_iter_memcg.c   | 41 +++++++++++++++----
>   1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> index 59fb70a3cc50..b020951dd7e6 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> @@ -15,6 +15,8 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>   	struct cgroup *cgrp = ctx->cgroup;
>   	struct cgroup_subsys_state *css;
>   	struct mem_cgroup *memcg;
> +	int ret = 1;
> +	int idx;
>   
>   	if (!cgrp)
>   		return 1;
> @@ -26,14 +28,39 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>   
>   	bpf_mem_cgroup_flush_stats(memcg);
>   
> -	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED);
> -	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> -	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
> -	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, NR_FILE_MAPPED);
> -	memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, MEMCG_KMEM);
> -	memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, PGFAULT);
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, idx);
>   
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_SHMEM);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum memcg_stat_item, MEMCG_KMEM);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum vm_event_item, PGFAULT);
> +	if (idx == 0)
> +		goto out;

This is getting messy. Most of these values should be on any system
regardless of boot-params. I was expecting you would make the call
inline.

Let's simplify this whole series. This selftest only needs to exercise
bpf_mem_cgroup_page_state() and bpf_mem_cgroup_vm_events(). I think we
can remove the kmem subtest altogether and still have the coverage we
need. You could then call bpf_core_enum_value() inline as an argument to
the kfuncs above and not need to check if they exist (just let them give
you the host-specific co-re value).
