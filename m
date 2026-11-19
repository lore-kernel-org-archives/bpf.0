Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076961;
	b=Ox9IrLdMaMPXQOjfAQmBPWFN+A0CsoOy/qvtKZX/FyAVePhDKsl53pIFl03xfSCnFO2r
	 2DomQ17eAaEK5cwW7APP3N7alC3OW3ARK8okFBzR98X0kEe7pNwzJ4lh8I7y386zCwxo0
	 B1DyjatA5CyuWqRJ+V3IaC5JUqCB7GikgLZ3YWe9IIUFv/esRQr7hEZD6mVnQ61JuQ7yw
	 fNxAy8wgrLQWEHo9iy7gX6vEVmxqaeefmp3Riv9mi9FDMUKTV60Wn4UFkoleqJYukHN0e
	 nM8tPkTT4DiN/xVP3bhGcfT5Nsz/9h0pDFUjuyr7OCikuplLYf9KmQbzk1r9NnVcrBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5EhIH0GsNWo/xExkiXtvhKm+Q3j5FK0DSxcIP+QAZxE=;
	b=rTw7afurNFzHg5f1ZUSJtqMfERQcFP6zqrbwcOXQCrs4hV3FQc9qY1Zv6klJJISvrUU0
	 Xu6xx7FRzpehjo+/k7ZljDfGpk1zDln7pX5+N7+0c/7tzBJmIiIXy9gKrNkNOrrKolQ0k
	 PkLG9s+tzE3OkiqdGqZJNg3dHsGkN3RbnCJ6830yGvPC49EvUxraUiiPXM8hAn+RVm1Fl
	 xnnR/QrOvAKcwGyecTHojRAG3HbvanAgWvlLd2qjDBcaSPRaGjb+haVT+ARk9V9OP4G3L
	 zUq4cu1BLhpT47i9tikmaHCPSTyufT7PUjL+ni7wII/Q1mjlAaAnPI8GKxyXqhpx0Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=c4ME0Wnc;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13816606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13816606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=c4ME0Wnc
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb61185057so15332745e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795076959; x=1795681759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5EhIH0GsNWo/xExkiXtvhKm+Q3j5FK0DSxcIP+QAZxE=;
        b=c4ME0WnclT037ThSxk+9Tb9cIcxHjOWsPOSAfb0Lk7j0kVlrmJUJLAJqnjcp/j+TMY
         ZViyE1qZMvMri6c73N3ahODXCjzfEFtZvDdS6HeLoq4fpXrId1Hpgvc1CVuQtmJiQ0rh
         9vZCbcOsBi+OTWp7uqyT6IITGltlbUZuUOXBjmDr3EyRKEC2LXKEyBenBYu7olsXUl0R
         H9oYm/YTQSCf+XDHj0Yh9X3eqNnlS8gsnSi622Pt/zrbzdeAkNw7f/URrcfKnJSL47qO
         rCoK22FDhxDBq0opKOZjvX78Fc2EJoEil/AmzQCW+9knlAFdebM6PryQEBfJTXPTvDtK
         //Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076959; x=1795681759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EhIH0GsNWo/xExkiXtvhKm+Q3j5FK0DSxcIP+QAZxE=;
        b=zxwbimvdUI15pKA0uuL5NKHqGcYde0+zgiNtcZSRDdD/6AVun+5WIIz9bRz2cZw9PA
         +HU5UTQfJvZWBzqCTUIc/B8DDIVPQRMQxlU8X429v7D9uGg+5xUdpekapPTHPciqqaDe
         et/sRVdgJR/3Y+p9wL/uwJQpu7wnoLqJVCmuaBw2ZuBbnlwn4kLIWPJjeLsBjVRDXsXH
         t70St04fxZUoQ7aKcC1zT2S2g+dVmSmIDZoaLosIosWbDSyHqwQhfqQy7wOApvMUA1+a
         Z9LlfoJUWtNI+l61PM07rF4a9H2Bntq9OAONR5OdnFncQqtQnx3cAD4T5fE52u086yGs
         RW/w==
X-Forwarded-Encrypted: i=1; AL+hErFaux4oM20Xz1zcJmZSujJbTfgBpfnxm1l4OsAyGnd67cOVcND1/cbPK8oQVu2GuRR0/HU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nol0hV3tBA4f4egzm7Fee/HJVFHO0Lc/+Oh+fDQT/JArHhc8m
	jKRNMWVF6+NK6plC7fVZbgEYMB+jq0XdJ79vGw5t0J9wllfjnMOz7AZ+cmVm8bT4lMc=
X-Gm-Gg: AYBFou0B6QkpUPFt4Du/MrnuGNiph9vz9aQDg242rYRiSt+Mph2abyV6mUqO1T1z7VP
	RqoN3+n9fBulhNeZTOjCMoQq+ONCZhN19FMUsgKsn7peq8KwAHx1ftP28BpQEt42IDhqv+E023H
	+TCkOyontNEkF49QhvyuBxJ2jrYHVKlvcGPIt3rnsHVcZTzQ9YypXm8KYVABUrGZzcAlsj3rOl+
	gYZt/bttGto6nr3n/nyvu1shTOW16Gte11lyT0mxHLGeZk6qWM/pHatNuzwV/OA8etOm8nAO2tt
	bIwzrNoCXKXcQ/TiWRu03Ole3rQtt++oWibUUNQjQt6EswWBeqwMDuZi10vt0x5FzTLDq/9fXGi
	87byEnVdfGiFb0aCI12te36dVusYSZl6Hpppxf6qZ0juwO1G8V48QVCbLnLhuUKCiuaJX/8fFR+
	CyqwTqX22+mtsahMYP71W1oegkRFUAiUbtEi8htxWhcMmvMyAxHD2TFjANY/VUOmQCDJj4j2lFY
	ySYnKQsuRP/3Pogp6yfnGChBMN5flhb2k9A2dM8E8yUvd2fPmvF3jRDrWoSMOAFrPBItYxP1Vjc
	mviN61L8oAf8X03M9tBYh6dOv09VgXq6N+2mPO1Ujzk=
X-Received: by 2002:a05:600c:1d9c:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb7da21ffcmr108691355e9.7.1795076959257;
        Thu, 19 Nov 2026 00:29:19 -0800 (PST)
Received: from localhost (109-81-80-145.rct.o2.cz. [109.81.80.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e5edf5sm11159705e9.4.2026.11.19.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:29:18 -0800 (PST)
Date: Thu, 19 Nov 2026 09:29:17 +0100
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fork: clear p->mm when copy_process() fails
Message-ID: <av6zXTxe0fAaHrzb@tiehlicka>
References: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>

On Thu 19-11-26 09:04:58, David Hildenbrand wrote:
> From: Chris Mason <mason@kernel.org>
> 
> When copy_process() fails after copy_mm(), the error path drops the mm
> reference but leaves p->mm set. Perf and BPF can still reach the
> task, and take a reference on the already freed mm through get_task_mm()
> or bpf_find_vma(), resulting in a use-after-free:
> 
>     copy_process()               PERF_EVENT_IOC_SET_FILTER
>     ==============               =========================
>     perf_event_init_task(p)
>     copy_mm(p)
>     a later step fails
>     mmput(p->mm)
>       /* frees the mm */
>                                  perf_event_addr_filters_apply()
>                                    get_task_mm(p)
>                                      /* use-after-free */
> 
> Similarly, a BPF program on the task_free LSM hook can call bpf_find_vma(p)
> before the task is freed.
> 
> Fix it by clearing p->mm under task_lock() before dropping the reference,
> just like exit_mm() does.
> 
> Further, if copy_process() fails before copy_mm(), p->mm is still the
> parent's mm pointer copied by dup_task_struct(), without having taken a
> reference. While nobody can access it concurrently, there is the
> chance that it might get accessed later when a BPF program is attached
> to free_task().
> 
> With CONFIG_MEMCG the task is freed after an RCU grace period, so the
> parent might already be gone and p->mm in the child points at something
> that was already freed. So let's just clear p->mm before freeing the
> task. No lock is required as there cannot be concurrent access (and we
> might not even have the lock initialized yet).
> 
> This has medium urgency.
> 
> Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-180866@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description and comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> I can take this through my tree (rather soonish) unless someone else
> wants to pick this up.
> ---
>  kernel/fork.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5efceb8d58a78..77d6c8fc38c66 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2628,8 +2628,14 @@ __latent_entropy struct task_struct *copy_process(
>  bad_fork_cleanup_mm:
>  	sched_cache_fork_cleanup(p);
>  	if (p->mm) {
> -		mm_clear_owner(p->mm, p);
> -		mmput(p->mm);
> +		struct mm_struct *mm = p->mm;
> +
> +		/* Perf events and BPF programs can still reach p. */
> +		task_lock(p);
> +		p->mm = NULL;
> +		task_unlock(p);
> +		mm_clear_owner(mm, p);
> +		mmput(mm);
>  	}
>  bad_fork_cleanup_signal:
>  	if (!(clone_flags & CLONE_THREAD))
> @@ -2663,6 +2669,11 @@ __latent_entropy struct task_struct *copy_process(
>  	exit_cred_namespaces(p);
>  	exit_creds(p);
>  bad_fork_free:
> +	/*
> +	 * If set, p->mm points at the parent's mm without a reference. Nobody
> +	 * can access it concurrently anymore, but prevent later access.
> +	 */
> +	p->mm = NULL;
>  	WRITE_ONCE(p->__state, TASK_DEAD);
>  	exit_task_stack_account(p);
>  	put_task_stack(p);
> 
> ---
> base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
> change-id: 20261119-mm_failed_fork-a46141b503d0
> 
> Best regards,
> --  
> David Hildenbrand (Arm) <david@kernel.org>

-- 
Michal Hocko
SUSE Labs
