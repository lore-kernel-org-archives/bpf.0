Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C1B7BB06
	for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620625; cv=none; b=k7OdpcaOEKn9udTASnHQ72PhnOaRejCX5iOt6hhYhVEe4OxgbWkmLxhSBPHrVlov/Yt7IVyZPKVMpYP0TiQiAOX675gMhZCsXmsyKYN34PUT5JCfRO4kheuvxJDg0DHEIC5Ouo7vj+JaE+AESTENbEUYa5bg7dFpgIQhn6F8Ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620625; c=relaxed/simple;
	bh=hRnLCWCAe9cG1RasyICJoyEvEYXT3tc59qG/FuyedgE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULJtNciTbZwTKt68RZSO1Cv6mIS8NPf4TBrWPmnXevEQCTAxBgO4GuRCeabba4kCghnN826ug2W9PRZQF+yC8yyVxx4tpuXpuN3ztM4QfI/zzhzpQw5hHMlbpPYr/digCC96pAbS+Nd8Jb7XYMJK8yDehyc4Wmdzbsu85I5BKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mexvwBXi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mexvwBXi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4644bde1d4so93109866b.3
        for <bpf@vger.kernel.org>; Thu, 28 Mar 2024 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711620622; x=1712225422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViD5xYPsbXk/vj3ESwixIm1mvY26l/EkB35LYn02HUQ=;
        b=mexvwBXi93bvfkPBGIYzRioi6Q0RRx6hKTYg+ilMqeEHnp4bccDzQhHhTXNjO0Clqo
         doysE7y3DjXgc3lj6mKVGF8Brf2jZG/KilVQO6xPHsBRiBsyf/w3o33VBTQlMgCdf4Kw
         NNUHX+bdD2pyJd5flON5F05Vbge1z6EfVjl0aV9ratVYDvt8/vZ9FxvL7U5Mq2JimFny
         wrGYFFysnkroYB4qwCVYfqUNcwOA85/PoEm5ZAGQdfHr9fzdDVz4O9QjtiBEhLz7YVVM
         FxF+4MeFfaco8qQ22e0iJk4xI86sB7lPPuwsm7fFXUuqJppij+Zb5ITGXmRxG8/Yu9uG
         zR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620622; x=1712225422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViD5xYPsbXk/vj3ESwixIm1mvY26l/EkB35LYn02HUQ=;
        b=bca4MJTFxcZ0ghe/vthKIJnMcL0CZqVL8iQixCpd1//moX9nle99+dgwPUUNiZIyXE
         DG+9/svcHXiiJ6BuiogLfSL6UrutWlIiz9USdEdmfY7znzuDqJtQrHks/NDkxNKi+KUw
         rQyYqgzIbOMw5QUZvQ0AZ0hAUXAYrzyPYsqm6VYHJMr9nKSW8rDShbxMSUclxGW2R9my
         BAVEr+QZL7NmRRAV2F0OuL5v2s/3Q9Wj6a5GmtAJd2or1Gvip4phZPK3W3a1x1C2zIDm
         n4sOvlS6b/C+6IcxOLuc6Ll5qUsYlAER70S31xMS9Uf6nnYZ1DFpZ64aJmROxo/d0wNl
         DnLg==
X-Gm-Message-State: AOJu0YxaESDege49WN5MiyUGBCvudAK6eVAZAZ9qkXdUVLsqA0IqRAUi
	TdHfE0qCKE0lSU0F5HQJZqE+LP9LtX1QunCEc0X4MeNsY4vtC3Nn
X-Google-Smtp-Source: AGHT+IF2YpbBL8r6qzcMcF0EAIXKwlXzztc3/gxmXDx2SIRc2MG4vqhGPzRT14c//Ze2mnB+U1QDLA==
X-Received: by 2002:a17:906:f744:b0:a4a:33e4:bcae with SMTP id jp4-20020a170906f74400b00a4a33e4bcaemr1357838ejb.30.1711620621700;
        Thu, 28 Mar 2024 03:10:21 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b00a47459e7371sm570605ejc.79.2024.03.28.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:10:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 Mar 2024 11:10:19 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com,
	syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com,
	syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next] bpf: support deferring bpf_link dealloc to
 after RCU grace period
Message-ID: <ZgVCC65T929J6yhW@krava>
References: <20240326211427.1156080-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326211427.1156080-1-andrii@kernel.org>

On Tue, Mar 26, 2024 at 02:14:27PM -0700, Andrii Nakryiko wrote:
> BPF link for some program types is passed as a "context" which can be
> used by those BPF programs to look up additional information. E.g., for
> BPF raw tracepoints, link is used to fetch BPF cookie value, similarly
> for BPF multi-kprobes and multi-uprobes.
> 
> Because of this runtime dependency, when bpf_link refcnt drops to zero
> there could still be active BPF programs running accessing link data
> (cookie, program pointer, etc).
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
> We use this for raw tracepoint, multi-kprobe, and multi-uprobe links,
> all of which dereference link during program run.
> 
> Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> Reported-by: syzbot+2cb5a6c573e98db598cc@syzkaller.appspotmail.com
> Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/linux/bpf.h      | 16 +++++++++++++++-
>  kernel/bpf/syscall.c     | 35 ++++++++++++++++++++++++++++++++---
>  kernel/trace/bpf_trace.c |  4 ++--
>  3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 62762390c93d..e52d5b3ee45e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1573,12 +1573,26 @@ struct bpf_link {
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
> index e44c276e8617..c0f2f052a02c 100644
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
> @@ -3539,7 +3568,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
>  
>  static const struct bpf_link_ops bpf_raw_tp_link_lops = {
>  	.release = bpf_raw_tp_link_release,
> -	.dealloc = bpf_raw_tp_link_dealloc,
> +	.dealloc_deferred = bpf_raw_tp_link_dealloc,
>  	.show_fdinfo = bpf_raw_tp_link_show_fdinfo,
>  	.fill_link_info = bpf_raw_tp_link_fill_link_info,
>  };
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6d0c95638e1b..98eacfacb73a 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2740,7 +2740,7 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>  	.release = bpf_kprobe_multi_link_release,
> -	.dealloc = bpf_kprobe_multi_link_dealloc,
> +	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
>  	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
>  };
>  
> @@ -3254,7 +3254,7 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
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
> 
