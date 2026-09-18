Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3D3CF209
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760708; cv=none; b=DNqB+T9FySHcNCOUXMGwJI8scLdtqiLgKE6pieiv/JW5j6uI2zRbGlNZz/DQIMavQTmDHbn6ZaOhzV8W15lTPkmo9JY6ym27s+Pt0uesuyeRB8wuHfOgVZK+teRodm9Lc1x9qRpeezlack7sZmev41kPsGgwpy5eLamO0Tmz5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760708; c=relaxed/simple;
	bh=8ZTrrIxJky21okgg3OV+LOiHHfsI6KM7FDw7JnLT294=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdpmuUGyMBLnWCo5iRNhNC1evWUFHKLThPb9zRsEZTNpPd/d2i2w8cgzpebziJ+het/E3giTgFZEhsswv10yi7yT59cteqa3FWTymV/kzKMhMvZo9wZszGKREsb61YCUJT/sj5GL0I2549UnAOXNf6aZhGrCVmjV2C5W6sr0C6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkdNQCCU; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkdNQCCU"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so7664395ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789760706; x=1790365506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szCxdCB52TPTOMoJOhzrKbvc6KVcFeMOqRe/OAFYPcE=;
        b=HkdNQCCUSzoRPufrnynAs9T6fTxmu4H2nO7mxIszLEOl9Yl4l7RKzLs8TBuG5Jdf1q
         /UK/KOHfhtFF54ibrxFbzw39YAQolmjoJsRaNS+VXFhTappT6SwpHf0ybYh90ExHX5Gg
         QppZmOINR6aj3WnNvkIFxHCyj7eYV18+5qsC7ZOERFEpIMSuZgofK14hrtgnh5F2xR3r
         iF9QhUY3wrjQa6lAc+wETeQdjkM5GvIygA49Ah0VyMakgy7t6Q3S5txQ9uFygov9DaXW
         z72AAQL6Ym/5heeIEeN6x3ijKNFuRbjV5AFjO+MEA9pvHto2VBBbDriMfqirB5lRqCnL
         TSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789760706; x=1790365506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szCxdCB52TPTOMoJOhzrKbvc6KVcFeMOqRe/OAFYPcE=;
        b=VC78oWijug0XuMCmT1tx1WJ/mb7H1z8BZvHPIXL669jWtTewjSD4dK2jjsoubGbGWJ
         fzRAoY+BKktDkTzWkkfSgjlf94+r/kUnL4VkXqSCHMCyXwKK5GHp3SxkDMvx7HyjwcaP
         OHfj/LfPGBRdxMRkGaRhAfKt4BnJUS1MYSysWUD8Z0OThwZjBNwohQGQri3CpV8fnEur
         9xltpPzwYfMABuk8thVXmSaxIPIKGx2zVEUeWQtarz/OMRvpszhk4SgbEvLQUNZMEm0L
         RajSJUcFBG/WFoy5QK1lyOdRLU5zIR2NsMPMDoWGwSuOJMk0XJCuqd9KEzLp693yrZZD
         9J4w==
X-Forwarded-Encrypted: i=1; AKwUvBxfHDPNpAQPQi+3scS4FtV1/A7Ju0jaupUBmsI/d/8i5dInYW0FUtYo1HIiDmcpw0oqH8A=@vger.kernel.org
X-Gm-Message-State: AFuF++naPmM0JGoctd+9PbKTTSCx1hAn5jfi+78YSCeOyYiX5R2ynPrs
	dC78ciahgTogh7gHafUehfB8iy8X1Kxcs+HFMQzdzhsuvofDXyUcY5bO
X-Gm-Gg: AYBFou0K/f6arhJ88WLLY52kq+segH+HkXFmo46h9ZwzoGVec67LGgbZ9nU5pQ7XsBf
	vHAeQak7OKQ052KiRIWw8HMKO95i601atavOQ8s8WOB1xU1p++FjekR8LGUHsKTIaGDp756iyPM
	KXN0gVqaYPcHAgNEUun5MHywM34gWTMCi4r/pA9U4+9K9ir1tznrH0Bn654+y0U9BcaXRtCTRr5
	eVYrvY1Eer0vIKkugmgg9Uu245Sxj0jbyRqHz8C0BLWF5rg0rqct2J5VodnBBSMDH+66XXLEynW
	wts5wXNHJXf7acKGrZfFUMnN9icOblJ3G+YYiGe7uYYJcTevYy8fc6xgMOKpeXtUmxIBHcH0rZO
	Be291C+JFHyac456tpDbeKO/eCpMwKKIeBq/isapCw+BQsBStoXBc4RTELSUMbD/wk4mJvE8m00
	SI9j++xO9YZOBemr+tSv4yaU19Pcd/FUlY/Wj9Fa1wNJGIHEL3Bby/JTnqrWHNgzt5RieRtWpTv
	y+yCGI=
X-Received: by 2002:a17:902:fc4b:b0:2dd:ad74:ac2f with SMTP id d9443c01a7336-2ddb1ba7187mr75143905ad.24.1789760705947;
        Fri, 18 Sep 2026 12:45:05 -0700 (PDT)
Received: from [192.168.2.190] ([24.23.128.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331b0d6esm670462eec.27.2026.09.18.12.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 12:45:04 -0700 (PDT)
Message-ID: <b115ece2-33a1-412e-ac25-38f339a13599@gmail.com>
Date: Fri, 18 Sep 2026 12:45:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
To: Hui Zhu <hui.zhu@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@kernel.org>, Barry Song <baohua@kernel.org>,
 Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1789714023.git.zhuhui@kylinos.cn>
 <02f0a8dc45a840d7801ec17e0c1168f7dacf9b73.1789714023.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <02f0a8dc45a840d7801ec17e0c1168f7dacf9b73.1789714023.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 11:58 PM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> BPF programs can observe memory pressure on a cgroup, e.g. refault
> stats via bpf_mem_cgroup_page_state(), but cannot act on it:
> triggering reclaim requires writing to memory.reclaim, which BPF
> cannot do.
> 
> Add bpf_proactive_reclaim(), a sleepable kfunc performing one
> proactive reclaim pass on a memcg, like a write to memory.reclaim
> but without retrying until the target is reached, so that when and
> how hard to reclaim is BPF policy rather than hard-coded thresholds.
> The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> as high_work_func() does for memory.high; reclaiming more is left to
> the program, which can call the kfunc once per bpf_wq callback and
> stop at any point. It is limited to BPF_PROG_TYPE_SYSCALL, because
> other sleepable programs may run with filesystem locks held, on
> which the reclaim path could deadlock via filesystem shrinkers.
> 
> Convert MIN_SWAPPINESS, MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY from
> macros to an enum so that they are emitted into BTF and usable from
> BPF programs via vmlinux.h.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>   mm/bpf_memcontrol.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
>   mm/internal.h       | 10 +++++---
>   2 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..c5d7f29ade85 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -8,6 +8,8 @@
>   #include <linux/memcontrol.h>
>   #include <linux/bpf.h>
>   
> +#include "internal.h"
> +
>   __bpf_kfunc_start_defs();
>   
>   /**
> @@ -159,6 +161,48 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>   	mem_cgroup_flush_stats(memcg);
>   }
>   
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory cgroup
> + * @memcg: the target memory cgroup to reclaim from.
> + * @size: the amount of memory to reclaim, in bytes, clamped to
> + *        MEMCG_CHARGE_BATCH.
> + * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS,
> + *              SWAPPINESS_ANON_ONLY], or -1 to use the memcg's own
> + *              swappiness.

The ANON_ONLY enumerator shouldn't be included as part of the range. I
would change this to [MIN_SWAPPINESS, MAX_SWAPPINESS] and then specify
that ANON_ONLY is a special mode like -1 is.

> + *
> + * Performs one proactive reclaim pass on @memcg, like a write to
> + * memory.reclaim but without retrying until @size is reached. Call it
> + * repeatedly to reclaim more than one batch.
> + *
> + * Only available to BPF_PROG_TYPE_SYSCALL, because other sleepable programs
> + * may run with filesystem locks held, which the reclaim path can deadlock
> + * on via filesystem shrinkers.
> + *
> + * Return: The amount of memory reclaimed, in bytes, or a negative error.
> + */
> +__bpf_kfunc long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +				       unsigned long size,
> +				       int swappiness)
> +{
> +	unsigned long nr_reclaimed;
> +	unsigned long nr_pages;
> +
> +	if (swappiness < -1 || swappiness > SWAPPINESS_ANON_ONLY)
> +		return -EINVAL;

Related to the previous comment, you treat the special values as part of
the range. It works currently, but creates a layout dependency on the
enum. I think it would be more future-proof if you did:

if (swappiness != -1 && swappiness != SWAPPINESS_ANON_ONLY) {
	if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
		return -EINVAL;
}

The previous comments I brought up are now resolved, so assuming you'll
make the changes above you can include:

Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
