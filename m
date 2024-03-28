Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831A04E1C3
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620619; cv=none; b=VMDcapoNw/Kr27l3Go5OiiUpA+2TgTE32+r4+RYfOvCk6ZAvd/qES0gaEUlCQooc2uOdbHGMMkmBL/IMqaZdu8QGaWL6kCt4aeRe+LTkSarZhO1f7mg/IPACy8jLOEFzdvIy4NBp5ZnSGGuSjQitcsLLIgfTz1Cw/k+OSoE3KKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620619; c=relaxed/simple;
	bh=vUPmsAlgXADMw+I4LeCOmPWp0BShK33t+qaX8e1GD9M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjR6BqNrbM2RnDkisKj4CXiLvpukR8RUKasee74bxoY4kKxaufGJgV4YeTY9I0RzH8spZ6LF0p385o7h1uLmoq6Nm/67S+RZ/9DvN1Klrk6T1heTaGH0hcmvayplFu5QGCoZYTjXeeadY/7Kpt328+8EhTErkqkJj6tI3NodFjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuulvcPd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuulvcPd"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso823885a12.2
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711620616; x=1712225416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEh/owVKAx9ogDaK9lXHFtQC3glGOXZV7pOyRsbAbgw=;
        b=WuulvcPdcCpOj4wrmuMswzHjtT9Yd+a2cQSc+lMT50eoCJt8CcDae6/4A1fANdkvsa
         FoD3UclBRwA9wst/geSKjw4wNwGCXQJJbs1o4FkdN3/t7kg/luvXSt5oUXWqOaeme8Nf
         bAfD3DA5CBHi8ItNYFjG1pRA0YjTxBlNgRrcO3Sh00Clf0RDG4CzNg5xPh84pN5R5bBh
         YP2hTke2aF8ZB9DP0O1NnaSFNh8SZ1nPtqQG6ouFcwXhkm4NIfDBmGatHuQbO76kUkqI
         TOH2ZNkvh+xJzNTxpRhAfJVHF5fzUEm6x1+b5iToRhbklNgs/7wrtggJrJS5eqW/KPK6
         H9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620616; x=1712225416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEh/owVKAx9ogDaK9lXHFtQC3glGOXZV7pOyRsbAbgw=;
        b=ODM805KUzgGZ5ot5+T0patbdri7qNOG1XpTlSnU3gg4lp9huTcjg5w+aBeyfsNc2Xf
         4xYoo93On7/jbZnkwSiba8D3kWhfiC2ZHRb09tHMw3siCr1amNyOVdc8xzdV/siic3NR
         tSqHDp6CkdW+G3F/qFNoZ6kyZIANVQQeblYqzHXFgEO75CVutqcPw3Zyx7qBj3fsZVS5
         Ur4dnEpyx2zT1EGYfQwiMRFy9GB8n9O/QqA66tdL42LHh4yymZc2KitEVpasBvdj05M7
         xAqGI9K3mX1phRWSI7OkTDb7exHPPxUAuyBVBwld4SM8PieQXOO7Sk3VdkQhygd0tNA7
         cAuQ==
X-Gm-Message-State: AOJu0Yz4jpbQNxdRrbEXFpEFVRJOr7HrFtMfxt1jhWcogddvCqf/cjcu
	MC25WFpH85qzYG40+cfyJ94HgkjgQuyTJCn0CojnMNpN4p45t7V2dexYpv4m
X-Google-Smtp-Source: AGHT+IH6fK44OhJUstSgyoFPWTmeNHsV23v85OQ/JIO5Nn49afXsg28or73v/0CvhuhwtGZBOKlZAA==
X-Received: by 2002:a50:d750:0:b0:565:e610:c358 with SMTP id i16-20020a50d750000000b00565e610c358mr1588380edj.38.1711620615482;
        Thu, 28 Mar 2024 03:10:15 -0700 (PDT)
Received: from krava (78-80-61-208.customers.tmcz.cz. [78.80.61.208])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b0056c0a3d91easm640629edb.12.2024.03.28.03.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:10:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 Mar 2024 11:10:13 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org,
	syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com,
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com,
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf 2/2] bpf: support deferring bpf_link dealloc to after
 RCU grace period
Message-ID: <ZgVCBRPqlHaNAQbv@krava>
References: <20240328052426.3042617-1-andrii@kernel.org>
 <20240328052426.3042617-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328052426.3042617-2-andrii@kernel.org>

On Wed, Mar 27, 2024 at 10:24:26PM -0700, Andrii Nakryiko wrote:
> BPF link for some program types is passed as a "context" which can be
> used by those BPF programs to look up additional information. E.g., for
> multi-kprobes and multi-uprobes, link is used to fetch BPF cookie values.
> 
> Because of this runtime dependency, when bpf_link refcnt drops to zero
> there could still be active BPF programs running accessing link data.
> 
> This patch adds generic support to defer bpf_link dealloc callback to
> after RCU GP, if requested. This is done by exposing two different
> deallocation callbacks, one synchronous and one deferred. If deferred
> one is provided, bpf_link_free() will schedule dealloc_deferred()
> callback to happen after RCU GP.
> 
> BPF is using two flavors of RCU: "classic" non-sleepable one and RCU
> tasks trace one. The latter is used when sleepable BPF programs are
> used. bpf_link_free() accommodates that by checking underlying BPF
> program's sleepable flag, and goes either through normal RCU GP only for
> non-sleepable, or through RCU tasks trace GP *and* then normal RCU GP
> (taking into account rcu_trace_implies_rcu_gp() optimization), if BPF
> program is sleepable.
> 
> We use this for multi-kprobe and multi-uprobe links, which dereference
> link during program run. We also preventively switch raw_tp link to use
> deferred dealloc callback, as upcoming changes in bpf-next tree expose
> raw_tp link data (specifically, cookie value) to BPF program at runtime
> as well.

nice catch.. I thought there'd be more link types accesing link
data in runtime.. but looks like it's just [ku]probe_multi

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h      | 16 +++++++++++++++-
>  kernel/bpf/syscall.c     | 35 ++++++++++++++++++++++++++++++++---
>  kernel/trace/bpf_trace.c |  4 ++--
>  3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4f20f62f9d63..890e152d553e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1574,12 +1574,26 @@ struct bpf_link {
>  	enum bpf_link_type type;
>  	const struct bpf_link_ops *ops;
>  	struct bpf_prog *prog;
> -	struct work_struct work;
> +	/* rcu is used before freeing, work can be used to schedule that
> +	 * RCU-based freeing before that, so they never overlap
> +	 */
> +	union {
> +		struct rcu_head rcu;
> +		struct work_struct work;
> +	};
>  };
>  
>  struct bpf_link_ops {
>  	void (*release)(struct bpf_link *link);
> +	/* deallocate link resources callback, called without RCU grace period
> +	 * waiting
> +	 */
>  	void (*dealloc)(struct bpf_link *link);
> +	/* deallocate link resources callback, called after RCU grace period;
> +	 * if underlying BPF program is sleepable we go through tasks trace
> +	 * RCU GP and then "classic" RCU GP
> +	 */
> +	void (*dealloc_deferred)(struct bpf_link *link);
>  	int (*detach)(struct bpf_link *link);
>  	int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_prog,
>  			   struct bpf_prog *old_prog);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ae2ff73bde7e..c287925471f6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3024,17 +3024,46 @@ void bpf_link_inc(struct bpf_link *link)
>  	atomic64_inc(&link->refcnt);
>  }
>  
> +static void bpf_link_defer_dealloc_rcu_gp(struct rcu_head *rcu)
> +{
> +	struct bpf_link *link = container_of(rcu, struct bpf_link, rcu);
> +
> +	/* free bpf_link and its containing memory */
> +	link->ops->dealloc_deferred(link);
> +}
> +
> +static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
> +{
> +	if (rcu_trace_implies_rcu_gp())
> +		bpf_link_defer_dealloc_rcu_gp(rcu);
> +	else
> +		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> +}
> +
>  /* bpf_link_free is guaranteed to be called from process context */
>  static void bpf_link_free(struct bpf_link *link)
>  {
> +	bool sleepable = false;
> +
>  	bpf_link_free_id(link->id);
>  	if (link->prog) {
> +		sleepable = link->prog->sleepable;
>  		/* detach BPF program, clean up used resources */
>  		link->ops->release(link);
>  		bpf_prog_put(link->prog);
>  	}
> -	/* free bpf_link and its containing memory */
> -	link->ops->dealloc(link);
> +	if (link->ops->dealloc_deferred) {
> +		/* schedule BPF link deallocation; if underlying BPF program
> +		 * is sleepable, we need to first wait for RCU tasks trace
> +		 * sync, then go through "classic" RCU grace period
> +		 */
> +		if (sleepable)
> +			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> +		else
> +			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> +	}
> +	if (link->ops->dealloc)
> +		link->ops->dealloc(link);
>  }
>  
>  static void bpf_link_put_deferred(struct work_struct *work)
> @@ -3544,7 +3573,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
>  
>  static const struct bpf_link_ops bpf_raw_tp_link_lops = {
>  	.release = bpf_raw_tp_link_release,
> -	.dealloc = bpf_raw_tp_link_dealloc,
> +	.dealloc_deferred = bpf_raw_tp_link_dealloc,
>  	.show_fdinfo = bpf_raw_tp_link_show_fdinfo,
>  	.fill_link_info = bpf_raw_tp_link_fill_link_info,
>  };
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0b73fe5f7206..9dc605f08a23 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2728,7 +2728,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>  	.release = bpf_kprobe_multi_link_release,
> -	.dealloc = bpf_kprobe_multi_link_dealloc,
> +	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
>  	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
>  };
>  
> @@ -3242,7 +3242,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  
>  static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
>  	.release = bpf_uprobe_multi_link_release,
> -	.dealloc = bpf_uprobe_multi_link_dealloc,
> +	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
>  	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
>  };
>  
> -- 
> 2.43.0
> 
