Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42737186C
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704380; cv=pass; b=FIilTUZYe2FZBGsmqe6xEt63tShi9WPOBSKLBUTeBXZC3mCK2NBhUgL3F6mSTGOPIYDtj1t0PpVsXkBZThqAIknv24srGkMmT1j6/DvnRNjQSLTxnskBP9t1bEDQk+rbSQfQZoEWVlQgb06/8HXPE3nV6127ZuUCvjd4HONpEVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704380; c=relaxed/simple;
	bh=LUpdFr8nOZ8lx3r0F4s/5dNqsY4EtiZ0vGoDtM9n5pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV/t4RdM2ouUS+z4ZUIrH8h5IP/5guXy+sgqUohJ7j2zpaCSCkWUIY+iusPmqNzvwpxI8MFB84AELsADi/FOfK7ssu4tj0UHId/hx1ppa2GPKCt161t+pq5Ew0Oyg0VBLUqHJHJTHVJ0JudyoikqiFWgjYjnk72K1HArmSlFqR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCo198qa; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCo198qa"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43b4121c40aso1526231f8f.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773704377; cv=none;
        d=google.com; s=arc-20240605;
        b=FtjFxawgNeQwkV6hdCWloylgBFvBC3NJzBWzX0s4axLayXMyHcOB3nc+OvPu8X8ZaP
         QMjnLwBv4lXXWWAJn0iiClbtfKXpGs6jQFpxSsqM66CM6Dgtzdah7dEaJcJCPb/H5YjT
         73e59U1suLgghOCH6/UaPhW23HEyJa5DkuHzdMjxHTFlQ864TNOEk6dDwyazHHUPv3Vh
         QXDR/BYpWsRWCFFcEwevz4UBMmnj8c7ScDiiroX2OMP/WPidLBbV0c5eLA5eDngZGdRn
         wl/hK0yv8ia8F85AD+AlLiGp8kEa6bHOV/Pg9m4cw+052T4KcgZH+2j0gBuOkg2Q8UWB
         L0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qP4EcfO8blTbLu9B8ieQwix5cbr1SvW0uRiRyDgzQTQ=;
        fh=t/xt8nOnSSsDVKlHcO7LjCKKUeyArGNUXJg/utSjGHs=;
        b=YnlJomVOxrnzOb3mg7LhQdBdyhQyntQwtDv7rv5rziCljy9kztpMaFvTbh+8I3y6TM
         0u6nysJGeH53zcXupzsC/D5jvyAom/B4RuHTW7vWhuHDfjh4KXZpeTDr83HAxr0liYCZ
         ueIkHzJRo4DzmoYyMtvXiYNRqBkVQxGYQSt3OtauPgp8Ryvd1Z/8y+PtCpNYMxi8UWE9
         E5yW12b/GG/I2gAn7JjKDaYeu/FTpv60E0q6LLnUQPbEbnWagKNIZMJU5ISALZ/d4880
         CFqzq3J7TAPCGJTjW9bTIYpyHsc8Y4m+n4hSQY+YHtuanIZ3egNCUhO1XIHbD0gQ5PJo
         fxnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773704377; x=1774309177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qP4EcfO8blTbLu9B8ieQwix5cbr1SvW0uRiRyDgzQTQ=;
        b=SCo198qa3ivRrg9DFLNBzW8DIMnj5dEHzweq1pyhzDTd9Fgr8j/hW2e2wbsAU/tv9D
         KbfHwY4ztJl6RBU/XH56g8umbWVE4AyMXr2ZBdSN2cLPZ+cDZkIzbUr5JNFQm2wSSU+C
         KsemCq9ymHUQ3TIUdSdzA9c7u5uYZuMuXGngwRZTWblYCpDsrQ2fUtHopfLHNtw+TCjq
         X69GBP5qgzpUDai87xEHnQss3UFBerVhZzEJpiMBGv+2+NkZr9zEmqChabEhi/Bn0CWd
         mVZgE00Y7eqzAnPtqGE929lvapCTxu/ySvJy96ZpYARsC0VSA3uyPmc0gPDu7LOiypzf
         V3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773704377; x=1774309177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP4EcfO8blTbLu9B8ieQwix5cbr1SvW0uRiRyDgzQTQ=;
        b=N/SF0wbVYz60E0pDJiMzkiUdmfLOhZ/v8LVTJVo0AuQTLNbOHvmXMn+IIfWtyspXrR
         4Qb2i3011Lck4YRkL5EAsiN1Ep1NOaqVp5FZLvGhXCDeHCowPOpCC6Yce1SkZyPUGkRR
         ZA1OL55cRuPHOk5aseg7R8CCrH+zRUCp0Ra8sk5Y69ydMwR+gSdzjQpo2pRNRnvcUfFC
         GiDf6qrYTkUtgYgRYP/PKx3Uf1J4o8xnbSG9mvuB0qZDGM+2SrATxArZfF7JsuMGlsB7
         DhV+KQF9+7mA/zA/K7USKayv5GdTLsuKBPJJeEMMV17Y/Aqm1ezj1hBbjWxVn9HTbZbY
         5fww==
X-Forwarded-Encrypted: i=1; AJvYcCU7qGQ+GRZQay65QeydZYCiWIZPtBJxXB2jE9Bl6Rz4IVrGDsTJ+aBbbDy29hOo0dJRuIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzXT8Bg4goVK0ml0NARxbSCG0M+RRNf6s28FwpboBDq9qux6wj
	VdqhCzmS4hbY/Mltgvq2T0Nur/By1+CZ9ro3L7fHtuDngWBnJQaQaSgVgTFgeIen+tXS54LNswM
	x+hhIt/yRCz3POMr4H3OP35ZEjZ7QESU=
X-Gm-Gg: ATEYQzwOPIOmFmfVStCBDZLsxXGd8xYMVVsq+HwZOleViOhsGIr1tzu9Yb8YQbDrmMN
	+ExKmwbAmcNTfmRA245HlMu/6znSZh6FPVadTU3J6Yls4wanR7/t8O6RuxoBH2DlCMLpBuKGWOd
	l90rjwK6vD6LW2gZV9GfQ8ygiZ8aq0eBNjKPx+7sjBSzNB3gxNZykzTsNtZXqMVZ8Op3yJQ8f6C
	29qHnQEwGAIILyVW53KHbBRHD+HRIQVDCO1M+om2ZDcp2yX1kp1zr6ThP583gUcCcYGRPU+P5Hq
	UGUMXJ3FVJxHEmlWs8OtZMwCrfA44cvVBkLb74AD0R+mabx+hjyh8M1T1gY=
X-Received: by 2002:a05:6000:2f85:b0:43b:4352:1bd8 with SMTP id
 ffacd0b85a97d-43b43521dcfmr11092768f8f.53.1773704377224; Mon, 16 Mar 2026
 16:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222758.1558463-1-arighi@nvidia.com>
In-Reply-To: <20260316222758.1558463-1-arighi@nvidia.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 00:39:00 +0100
X-Gm-Features: AaiRm50QTIyuUJ_7soIEToEoeT5sSCTG2VivsOgvUWqhQsYvjGCB-NLOj-MT8JM
Message-ID: <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Always defer local storage free
To: Andrea Righi <arighi@nvidia.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 23:28, Andrea Righi <arighi@nvidia.com> wrote:
>
> bpf_task_storage_delete() can be invoked from contexts that hold a raw
> spinlock, such as sched_ext's ops.exit_task() callback, that is running
> with the rq lock held.
>
> The delete path eventually calls bpf_selem_unlink(), which frees the
> element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
> with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
> safe from raw spinlock context, triggering the following:
>

Paul posted [0] to fix it in SRCU. It was always safe to
call_rcu_tasks_trace() under raw spin lock, but became problematic on
RT with the recent conversion that uses SRCU underneath, please give
[0] a spin. While I couldn't reproduce the warning using scx_cosmos, I
verified that it goes away for me when calling the path from atomic
context.

  [0]: https://lore.kernel.org/rcu/841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop

>  =============================
>  [ BUG: Invalid wait context ]
>  7.0.0-rc1-virtme #1 Not tainted
>  -----------------------------
>  (udev-worker)/115 is trying to lock:
>  ffffffffa6970dd0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_ssp_contention+0x54/0x90
>  other info that might help us debug this:
>  context-{5:5}
>  3 locks held by (udev-worker)/115:
>   #0: ffff8e16c634ce58 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
>   #1: ffff8e16fbdbdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
>   #2: ffffffffa6971b60 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
>  ...
>  Sched_ext: cosmos_1.0.7_g780e898fc_dirty_x86_64_unknown_linux_gnu (enabled+all), task: runnable_at=-2ms
>  Call Trace:
>   dump_stack_lvl+0x6f/0xb0
>   __lock_acquire+0xf86/0x1de0
>   lock_acquire+0xcf/0x310
>   _raw_spin_lock_irqsave+0x39/0x60
>   spin_lock_irqsave_ssp_contention+0x54/0x90
>   srcu_gp_start_if_needed+0x2a7/0x490
>   bpf_selem_unlink+0x24b/0x590
>   bpf_task_storage_delete+0x3a/0x90
>   bpf_prog_3b623b4be76cfb86_scx_pmu_task_fini+0x26/0x2a
>   bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
>   bpf__sched_ext_ops_exit_task+0x4b/0xa7
>   __scx_disable_and_exit_task+0x10a/0x200
>   scx_disable_and_exit_task+0xe/0x60
>
> Fix by deferring memory deallocation to ensure it occurs outside the raw
> spinlock context.
>
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
> [...]
