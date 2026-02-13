Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F473185B48
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943139; cv=none; b=tykUgmdO5Ed1v3ofhrBd6WDOPMYe90P89OglyWT6lt6Bwl0jE8o7aTqXCpdhzjPP/fbZ+E9VnAW1qnT7r4QdSE2ALSIMUMkrOOgJ2ym/2//Ey+VywFG+UAhTmTZ9jejPKUjAJTBrY4xxY5flshHBTsDBVjWS60pL1x+NJ/pE6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943139; c=relaxed/simple;
	bh=t/+3wyweMkhjwVY2qvSMuKbG8mkGC5i0DHQ0TzmGcNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F58od7DREWNAaQ1fDhv3tJGDu23LB11PmFS9VG02bpMlrWVrpWTOJgxm3fpQ3YFZI5jj4aUyJETYteDE7eXSj/wLtk1FaS1Ej71MVsTsLsroHjeXO4iS6qf+e1EMUTHqALBj6H0SuUGc7FrH7zhO1eGm7jcJx9eT9EvTdF2oWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4dbM5iM; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4dbM5iM"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso413865eec.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770943137; x=1771547937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lp9040amXhpFPWQBTbbqsO5bbDZPitD7bxgNCwcTcG0=;
        b=O4dbM5iMYx+hC473R22ijUI0lZpm6cdrFrNmHh8qiVVi6mMita1w4d2PR6Akbcz9c+
         1OKTt8BL7xNdmSHjXiWu72amsRryuBbbxDX5MMGjI6Ru7ROn6oemG5LT4pcykRlwTBud
         pWAwKCv745EF6QABauIPfqbGXz/5fYqyIqWHRabXORb+0VsiAEwnn/pwYGhI3KDwMIFu
         A9ruoh8X7Cpl9Q8t5G5eXF3PlutUn1oGmOjzadHzAyw2PJ9692Kgi/KlhiSuC8aWuE7X
         9qFSWNCmr9wymbrJDXFWuzk/aTz9F3agQ1KNu0wZIxEJsnDk0I9kJHbACBfrcO7FU+VC
         XZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770943137; x=1771547937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp9040amXhpFPWQBTbbqsO5bbDZPitD7bxgNCwcTcG0=;
        b=Q0nQyK4nhtRRe9hKIK2oXTy+EUya68VYJgzEKfbLgxxOmsL8Jk6ceap2MRZdpznFLW
         FMI+KbnNLAbPGRYgUwffP7spX5opkTbYMRspTITXwZ79fJsS3ws4Am4UfdbX6RAOsZub
         LIqhMGSteTXiJEguWRLf/oeLlCl/QRlNJOhYzEsZb10h0aKkwLpsGhNVn8K5fChBJfLa
         8hxGOT1ly50y0xGRYUZWjw+hjr2h9Iyc9TSycf+3bj9kz6+SiEIARwWFS1sHLxyMqEzp
         w8A9mfoRF1iZbUhHLKP9vPwcG/lfm25DgVJeEOxHjsxOP6uC+XU3vpZE3wrM0b7kS+8l
         QFpg==
X-Forwarded-Encrypted: i=1; AJvYcCXU+WKsJzfLimo0qk5XVNfLHsxPTRTTI33o9BX8u8DO99KenhsClD+vJeOheHW/lX8Txt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhA0XZdELkmLdi41jxZ1v1iDu5lJg1n+o5Lbmkmtg0UjO3DYGb
	0MKSyZijsvieOoxx5rCJDpGmNP6f0E6G/bFJQqt+H8t69go7GT2r+AnL
X-Gm-Gg: AZuq6aJHUabryPa2JHR+c1KQkUzjQeLC2KQGqeVOsrI38XaQ+hQcYQiDPNUIsmPUraH
	P9g31pGRQRU+z4qHuhxWXDiEeNpR7o973dDltAfzES9azD9/dObY6rs3XlF6ppt84zZGPmWs3rT
	3+THqsakwhV1MiUxe1V5tu8m7K6+4l5Wk1oYKErqxK+y0v3xOWWkXPyJHvrFbHehHks+G3UTg3j
	V5g9izaC3pDTUU88v2SSPcxs1LuleLdkcc9uIebeMj8ilS/Aq5SD2uamK0xJmvLOE/sktdIxtBS
	DTbwT+iBu0JqiNTm5Il6ZVccxht6kjl+hnKzAcMmA8PGpNGCbxqA+pH9oTD2DOqxTejAKDoRj1J
	3N5C7q6BNOE9ix9Vlcx7TeNL6jRRcXguU7A+EJ+31DS6IvRVfAq2NI+uPklBHXESBRHl5LopPGZ
	8vPy7KYTiWqzv9izw3+3MBwuofng54MPP77YsXquAtmts=
X-Received: by 2002:a05:693c:2b06:b0:2ba:75f5:72a2 with SMTP id 5a478bee46e88-2babc3a4e2emr44150eec.2.1770943136554;
        Thu, 12 Feb 2026 16:38:56 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd00d2sm5059384eec.20.2026.02.12.16.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 16:38:56 -0800 (PST)
Message-ID: <51bbd728-c712-4601-8a4a-7c602c67fe75@gmail.com>
Date: Thu, 12 Feb 2026 16:38:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] mm/memcontrol: Return error when accessing
 kmem with nokmem
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
References: <cover.1770883926.git.zhuhui@kylinos.cn>
 <733422f72ccbac94126ae67b9e49f4a3d460b76a.1770883926.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <733422f72ccbac94126ae67b9e49f4a3d460b76a.1770883926.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 12:23 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When running tests on hosts with cgroup.memory=nokmem enabled for
> performance reasons, test_kmem always gets a value of 0 for kmem
> statistics.
> 
> Since BPF programs cannot easily determine whether kmem is enabled,
> add a check in memcg_stat_item_valid() to return an error when
> attempting to access MEMCG_KMEM statistics while kmem accounting
> is disabled via cgroup_memory_nokmem.
> 
> This prevents BPF programs from silently receiving zero values and
> allows them to properly handle the case where kmem accounting is
> unavailable.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   mm/memcontrol.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 129eed3ff5bb..4d8419623d1c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -667,7 +667,8 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>   
>   bool memcg_stat_item_valid(int idx)
>   {
> -	if ((u32)idx >= MEMCG_NR_STAT)
> +	if ((u32)idx >= MEMCG_NR_STAT ||
> +	    (cgroup_memory_nokmem && (u32)idx == MEMCG_KMEM))
>   		return false;

It's still a valid stat though, right? When it's disabled the value will
just remain zero. I don't think this is necessary.
