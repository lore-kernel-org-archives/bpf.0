Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6039E166
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673521; cv=none; b=YV+7/TlnN2gZkuzpBvVlS/NJYBwj7CsW0uPTAIIYJDziT6QPgLlqUSQMnfIx0liQdRLlG4SMrnb22mHGI8r5eegHS/1W6OrFVonaZdZKaZ3Df9jZsRhvf37Zt/g6gugPoDJSq8UfBX9HJSvL7jluapydgNYUt62CkwXhmk7d/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673521; c=relaxed/simple;
	bh=RnzelXQEhcmD1T1EIc3JYmO2mAx5i3ChXWZTRK+KT6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGAxh5WSI9JpRHZIlLMFRbQDrG2ancIEQD0abx0S4TXzD4ko98gtx0fmlyE5xqtdWOOvkyzVybE4c24O19haq4b4kUeXPg9Db5+r4Vnv50wZzm1ddAeE8V/Z8mepvBQxya8hdmhSvuocf3oJuLgOeCYAM3jD5mpYkNRlcOJBlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUS7nlHy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUS7nlHy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852ff06541so52844005e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773673518; x=1774278318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqco5SPEd6UaXLI10tvcOr9r7x/pSR9Rg9OAhUkP36s=;
        b=hUS7nlHyle7WeHcHg7sagZtDpm3MfyYPIVSEJToV9Y7WU5ONqqxdP0ET829XxrhXKi
         fppHrvTyudMI2SIhx+yAxkDsnHX3+YQTk0Uq0HuY03R1cTGXnxXhayTmCi2eXU9AjgW6
         C+Ppjaeo0ZL7uh5U7LBowOvMm1NUOVqapaiJOC2Rp2pgQv4iOghEPddJRDY+nb7SPxNe
         lXOSgiAWeYcjTxA9MN/nkV9lgoJTfO9nKLRi8C5w9VRL8Aseks/J+Uf3MOgLWn8DqCKY
         V/n2Yu5bPhdTgMfCox0DE7tydzanNvR+OhY+/j/Q4PnjjMGUcsgrDHNxnNVtJ3069yPk
         EbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673518; x=1774278318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqco5SPEd6UaXLI10tvcOr9r7x/pSR9Rg9OAhUkP36s=;
        b=gUgk7KT5vsPVUTiI2sm/OEg8eprt95s0slcoCcdgl7hS60XqjggJJERBYfWAWAS1oB
         KJJ/KoyKfEURcOUdDTk2VTJEOOGH1UTLekxH33MT3cZDCYsRIRSRNfKb9V+Jp4M0qn31
         0ZKDKueI5NCqEFaxwE9EoozMgnFznrS7njRq7bysPFWfkGfLLizWpKfia8V2I6wf+dli
         1q+lMyACsmDX2FhFme1TQSMPFVW8Mdwtp2haJFFY+mYS7JEUCbD8AXssiWzmCoyDuUSo
         jlcNl75CIiFBJGcRuL5m0P7M07SsO60v9R3KgU50V7MTckd5cTMmRfBQpXRgqKCh9RQF
         QQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKwhX1RWtfQpvZQeQoY7hSp+1+rIJsjemsPvlcDbMWZKHVzUtErp9FXSoXcOP0e2vPdKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7hfUR9s/D5vwRncEjSyJiwNI9sf3hqKRi5lGVRt3Z4mYYTBM
	eZJhzRiWZtbvmGXh90ZUC66cchff66eJGpdoEJtHb5EOhN+VflCnOcj3
X-Gm-Gg: ATEYQzysaZwcu7kWa7bsiRxOxz12fHV5ImqmH4j8MRuRtytnmo3uyGezmSWNIvmqJ+S
	bDfNcDTTlwi+E+jNbP6JldwuhAySlWGv6MA07dJFkK0oscLxHwecWoEe8xkYVyhGAJyu0u6lrds
	EExVr3KqveP/7YDp70F29eDbWJ1ysIp68y2Mmo2Yy5ONxH9GrY6/siujmCKSdhDvbokGRS6x7Xj
	R4vMe284T6Am6q7yNQGuJIxYtzI1R3rBAyDF92eg3I30CiO8zGvHxcH/ucA7H3rDnFEDz9y0UGl
	OmjpM1XQYpVzhJvILl6Rx8qPSqi2vsEI7C3F2cCVbXpzTd/8k422Q+fvBCCQFvWjuUYa6/dbxl5
	YalsxRUcvgvTnP31GacrrF0I0s7u5K3ekFfpBeJJcUnq8b3fg8jIqpF8iXBytwJSEIK9ikp/mmz
	1UfU/E6LaF60H+Xu0tLeJD++pkJ/AetO8gcUqG4ea19cInMkpVu+tzZHxeDB1XbPSZgsnDW13Y8
	Sdp3qSyI1wrMU5ydhpxgbH7x9grmpaLEN5ZQa5tJR5hN8PNulSlB9E7DkUYxmDX/oN9T5WPbT1o
	NPIRrXEVQN4=
X-Received: by 2002:a05:600c:8b2c:b0:485:4bd1:4c7e with SMTP id 5b1f17b1804b1-485567148e8mr223653815e9.33.1773673517657;
        Mon, 16 Mar 2026 08:05:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077fb9a9968087a66.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:77fb:9a99:6808:7a66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm398807025e9.5.2026.03.16.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:05:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:05:14 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Amery Hung <ameryhung@gmail.com>, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Message-ID: <abgcKvuSQc2ZYKw4@mail.gmail.com>
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>

On Sun, Mar 15, 2026 at 12:02:48AM +0800, Levi Zim via B4 Relay wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> For example, this causes bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> 
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> for correctness. Add a comment about this limitation that architecture's
> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> bpf_local_storage_alloc always fail.
> 
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---

Note there may be something broken with your setup as lore is reporting
that you sent this v3 email three times. Not sure if it could be an
issue.

[...]

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 8157e8da61d40..d8f2c5d63a80e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,6 +18,7 @@
>  #include <asm/rqspinlock.h>
>  
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>  
>  struct bpf_local_storage_map_bucket {
>  	struct hlist_head list;
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index c2a2ead1f466d..cd18193c44058 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> +	return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> +					   KMALLOC_NOLOCK_SUPPORTED);
>  }
>  
>  static void cgroup_storage_map_free(struct bpf_map *map)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 9c96a4477f81a..a6c240da87668 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>  	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>  	 * preemptible context. Thus, enforce all storages to use
>  	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> +	 *
> +	 * However, kmalloc_nolock would fail on architectures that do not
> +	 * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> +	 * bpf_local_storage_alloc would always fail.
>  	 */
>  	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
>  
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 605506792b5b4..6e8597edea314 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>  {
> -	return bpf_local_storage_map_alloc(attr, &task_cache, true);
> +	return bpf_local_storage_map_alloc(attr, &task_cache,
> +					   KMALLOC_NOLOCK_SUPPORTED);

I can confirm that this does fix one selftest using
BPF_LOCAL_STORAGE_GET_F_CREATE on riscv64: test_ls_map_kptr_ref1 in
map_kptr. Other tests using BPF_LOCAL_STORAGE_GET_F_CREATE are still
failing so I guess they have other issues.

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

>  }
>  
>  static void task_storage_map_free(struct bpf_map *map)
> 
> ---
> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
> 
> Best regards,
> -- 
> Levi Zim <rsworktech@outlook.com>
> 
> 
> 
