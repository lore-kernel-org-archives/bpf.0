Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EE3F7873
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773197; cv=none; b=gaCeAikTRwSFd3Of29XIL9zXYpEKhd38pG5q11BbEfNTLoaI64/QOpRPfxly1mNhcLt0qQl8nfVbeVKBKWIUiitrdq32uiQvS7QfVIV64O2kS49pld1DEJbxkv/5twDc/Ql/xm7/YyZjwSi3+LgOtYkWwBJth4KhnD3Bs2M51AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773197; c=relaxed/simple;
	bh=XpR+5SbJGKjJNWFg9TkVcXYtF+7AXE+0Ocx7ZplxY4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITLE0cRXIZRsR0gEYFlsn6J6PAJ4RFYiJF9Xp9BrUELOTEGf9yX9/CFqMVP/ecqvuu+7xwjs4MSxw3iNPXqqDyGq9udMqrdWprNQUlUZhgsVNkr+tUJsHi0Vd86xf37CY0DWiZpX7eHEKua02EDaHK5KvA89dIcMk2yDWQ+9pnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecXkb9G8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecXkb9G8"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a646c96bdso543728b3a.2
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773195; x=1774377995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbrfUdKZrouKLBuG/aJfVhDz/p0TOOGj2/grzGDWoT0=;
        b=ecXkb9G879cfG7nK5Er2wHA2fAwgfntuEplonkkYjtvehGSTlygPujGojlojjOdFzB
         xLton+f81oTpbEfvNkaLIt5UGiGLca/O1O9p1NTEfS48BBETwXqo1uT/ivWxpW/OisEG
         CoUeLCF3DQZGfx1W7IGKl/9di/1GVVCbmWXurA5iocRA4xDrs+LLLbjpIPhfF7CdmQ9F
         /4H5T5rMSSAdMKFS4Th+QlZlHTuCUJ7hdFdAIdUTyGmmtVzed7Y03BZLkvBuiH0u3UXg
         EznUzqHsqaf/2g/vZz7ly8QH3j9oWqrUzYML0o94ODp0vcj4yBuqmNpK91iF/XgiMl+z
         LGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773195; x=1774377995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbrfUdKZrouKLBuG/aJfVhDz/p0TOOGj2/grzGDWoT0=;
        b=jN2KoOMnqFB0WowfctwxcpxPXB410cLXDkFqQGY+NaCpfsPBz2QGZj6Dnv+vQcf5MI
         1XmRdX7pd9PN0NxHom7Y9Bw6Dw8vdhI01MDXOTNT8z71t3BbyEFqdwtV+zcZv6ASKjDX
         Vvskl91f6GwQSuwQlEfMtDCCu6njg62LBkDwqYEq06L/7W2cvbd534K6Ca5/iUjuGAlW
         80lHI14rs+fP1XBF9EZ2ETgZv8n1uKltPGZnqxXvkWQeZlKJqC2Z7bB5LlwWjubzjwHy
         6AeTiNmqxUAkX9z9yPdQR53wmPXEE5bycEgGl8Dgrv5LyKgOOeRSNdMWZH98G0gjFMo8
         n2uw==
X-Forwarded-Encrypted: i=1; AJvYcCUIGUJRN5t2xuy3dB9rt5tW/c+jstzFL5o2lgJ57J8ThTe0OYpRkWGGwyCIV0rHOJ0leiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVorCpL/T9/sTPsOV2PEjyZQlqeGkM8g+HROi/nN2qCyhq0eq
	HSbptv+dlL4P0PMcRMG0qtSWKoPtZkoWBe1QEEO7+hpan1vFsSP1de06
X-Gm-Gg: ATEYQzwnbXGFqieILCkQY4RVHmq8LfNgUjv7kW2oR9jA+GmvYMWvm9+7/d+GCOLxKxx
	JKUfOeec1qO7dwZJVUZPHosDJOrCxNh1QdvdOjYVor3o6EA0tPIY+pcrS9RXQIrjUxRG5m+h/RR
	4YZT9GoBPzDmdBrmZuA2l3HlYXit07WlFDgjTOREY3vAdxR3EQdVBxhlm1gARhKpwansa6Ynvyg
	9OErO3r8AlHrMNQ/3kU12ZTfgg3CzbSWOKXOCYJ9fx8GbHBsFMsVfzAXUxEACzU7gjXbr+x6hoj
	zvvERJI3n7inzXCaHlDwGaqn9vwJya2lWl8tUYOlm3QdIsxDp+WT/9eYlbxNIQ491zoULe9BqBp
	0JJKtIBGP1hNQwKNgB2WinDqIdinveiKjqFSaNHnRavzBFTqpK1itLKb9TFzZKRRmknbhJqkXWr
	DLUgjm2QOVMvX809XdzW5rq/rPCVvJj1S/q06vUfaI5sPe9ItAM3nrVP7Oe6kCIBCixVjw
X-Received: by 2002:a05:6a00:acc:b0:82a:1044:356a with SMTP id d2e1a72fcca58-82a6acc07cemr370090b3a.26.1773773195217;
        Tue, 17 Mar 2026 11:46:35 -0700 (PDT)
Received: from eric-acer (36-225-83-37.dynamic-ip.hinet.net. [36.225.83.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb51d1sm174170b3a.28.2026.03.17.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:46:34 -0700 (PDT)
Date: Wed, 18 Mar 2026 02:46:28 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: Re: [PATCH] bpf: Always defer local storage free
Message-ID: <fvaatkuj2kzi66joz6xo3n3ftwqou4xoat4kpzbv3eboeyupyd@i3y6n4w3xhh2>
References: <20260316222758.1558463-1-arighi@nvidia.com>
 <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
 <abjzvz_tL_siV17s@gpd4>
 <abkNtYPMARqxXibW@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkNtYPMARqxXibW@gpd4>

Hi Andrea,

On Tue, Mar 17, 2026 at 09:15:49AM +0100, Andrea Righi wrote:
> From: Andrea Righi <arighi@nvidia.com>
> Subject: [PATCH] bpf: Avoid circular lock dependency when deleting local
>  storage
> 
> Calling bpf_task_storage_delete() from a context that holds the runqueue
> lock (e.g., sched_ext's ops.exit_task() callback) can lead to a circular
> lock dependency:
> 
>  WARNING: possible circular locking dependency detected
>  ...
>  Chain exists of:
>    rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&rq->__lock);
>                                 lock(&p->pi_lock);
>                                 lock(&rq->__lock);
>    lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
> 
>   *** DEADLOCK ***
> 
> Fix by adding a reuse_now flag to bpf_selem_unlink() with the same
> meaning as in bpf_selem_free() and bpf_local_storage_free(). When the
> task is in the TASK_DEAD state it will not run sleepable BPF again, so
> it is safe to free storage immediately via call_rcu() instead of
> call_rcu_tasks_trace() and we can prevent the circular lock dependency.
> 
> Other local storage types (sk, cgrp, inode) use reuse_now=false and keep
> waiting for sleepable BPF before freeing.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  include/linux/bpf_local_storage.h | 2 +-
>  kernel/bpf/bpf_cgrp_storage.c     | 2 +-
>  kernel/bpf/bpf_inode_storage.c    | 2 +-
>  kernel/bpf/bpf_local_storage.c    | 6 +++---
>  kernel/bpf/bpf_task_storage.c     | 7 ++++++-
>  net/core/bpf_sk_storage.c         | 2 +-
>  6 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 8157e8da61d40..f5d4159646a83 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -184,7 +184,7 @@ int bpf_local_storage_map_check_btf(struct bpf_map *map,
>  void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
>  				   struct bpf_local_storage_elem *selem);
>  
> -int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
>  
>  int bpf_selem_link_map(struct bpf_local_storage_map *smap,
>  		       struct bpf_local_storage *local_storage,
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index c2a2ead1f466d..853183eead2c2 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -89,7 +89,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
>  	if (!sdata)
>  		return -ENOENT;
>  
> -	return bpf_selem_unlink(SELEM(sdata));
> +	return bpf_selem_unlink(SELEM(sdata), false);
>  }
>  
>  static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> index e86734609f3d2..470f4b02c79ea 100644
> --- a/kernel/bpf/bpf_inode_storage.c
> +++ b/kernel/bpf/bpf_inode_storage.c
> @@ -110,7 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
>  	if (!sdata)
>  		return -ENOENT;
>  
> -	return bpf_selem_unlink(SELEM(sdata));
> +	return bpf_selem_unlink(SELEM(sdata), false);
>  }
>  
>  static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 9c96a4477f81a..caa1aa5bc17c7 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -385,7 +385,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
>   * Unlink an selem from map and local storage with lock held.
>   * This is the common path used by local storages to delete an selem.
>   */
> -int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>  {
>  	struct bpf_local_storage *local_storage;
>  	bool free_local_storage = false;
> @@ -419,10 +419,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
>  out:
>  	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
>  
> -	bpf_selem_free_list(&selem_free_list, false);
> +	bpf_selem_free_list(&selem_free_list, reuse_now);
>  
>  	if (free_local_storage)
> -		bpf_local_storage_free(local_storage, false);
> +		bpf_local_storage_free(local_storage, reuse_now);
>  
>  	return err;
>  }
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 605506792b5b4..0311e2cd3f3e6 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -134,7 +134,12 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
>  	if (!sdata)
>  		return -ENOENT;
>  
> -	return bpf_selem_unlink(SELEM(sdata));
> +	/*
> +	 * When the task is dead it won't run sleepable BPF again, so it is
> +	 * safe to reuse storage immediately.
> +	 */
> +	return bpf_selem_unlink(SELEM(sdata),
> +				READ_ONCE(task->__state) == TASK_DEAD);
>  }
>  
>  static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index f8338acebf077..d20b4b5c99ef7 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -40,7 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
>  	if (!sdata)
>  		return -ENOENT;
>  
> -	return bpf_selem_unlink(SELEM(sdata));
> +	return bpf_selem_unlink(SELEM(sdata), false);
>  }
>  
>  /* Called by __sk_destruct() & bpf_sk_storage_clone() */
> -- 
> 2.53.0
> 

I was able to reproduce the error on my end using the steps you 
provided earlier. After testing with this patch applied, the error
is resolved.

Tested-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Thanks,
Cheng-Yang
