Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9B3BED16
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493082; cv=none; b=WSPSIn/OIqXfdj2c32fcX16Bmgik4PoQ8cSZsUBSEIdhZK/d53+9Cn/7hLnd1EWNuGEiqTmdh28cVFnv5oNJvu0MgeRAj+lsdyLVvhGim0Ztey4g7O3SC6fkc8bc33TPpgDBm9ki1L5/CPRqgMC2mPINEajgqSXM/5sZsfXLHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493082; c=relaxed/simple;
	bh=+QIsoNE6yvheKJ3K6KiPfu6tEOz1IKUcFg+aXiiO+XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IULZ1S3jhvFi63MhdZdY+4wgvIOMd1eIRcGYefMCLd379xNiggiUcg6/oVYii/KIYehv5p10IRnA8y/3uabinjun/Ro5/6I54ivpn2czkwof9ZV9vWGlH4A/XuWEfkiNOx9QCI6jUbh1gvB6AzNqAMgVprY0Jou5DTfIWBS7TPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiJ97XAC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiJ97XAC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so25117815e9.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778493079; x=1779097879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv2CL3J7yW1qadnwjPfuilkFN1KFrK0szn/ujRRFWjU=;
        b=XiJ97XACLKmvx3yc84YzoAXdowpdluc+30kZqepKeK2KhavdHgfXMcdxueZ9lNLi+B
         K2Jj2YC+yjlBXzOzi5CY3PonPYYDVvgvCH0E+vwYYteJMKxGMKXEh+YleYdjtdoAqqEY
         EY7UsKNkMKseMtcwVYYxhu1Abz9L5AmVRQ90sS/nLFN4nP7mDvaNU2WvSz1QMNymeQ7U
         ng5z+cEgFl/Stym5F8b/5L4t5UqGU3zHdmcnG5JX0QzV/Uil3a0cZXIQM6KSdlBeFMkt
         a34cDmAquIcS4ERICVut985Z4IeRXuAfeL5d1zTwZ+gOnNMFDnblqqwxP+wg4xe+TeUR
         xlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778493079; x=1779097879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv2CL3J7yW1qadnwjPfuilkFN1KFrK0szn/ujRRFWjU=;
        b=UPiLmdrMxNXS+/6mh04nLU9xPyhUsP7qKrvj43X7gy3ze5G8U3T1iCECngEOIVp+Wn
         snYrtpRQe9Qgf4CBYmvWhKMpxtseMOVpyuhQnx0yw4obTtEvZ+E1di5SYxDX5LmOfmDe
         CikXY7c7ezo4KQUHeFsdkc+6uJcZgpg10nOI50wxUOjcxrdNnGaKL61+helmT3u36u5K
         SuyysypoCGxLcciOsyrHkwtse37cDfHNMeUdoYkdOa46GdDSruhPfS+mD8KylnXWF48Y
         ysQQQ1jK0YbMxzClknmuZ80J1E8knPeEU14zv6POD8AyqKkom0US9KMU69GxTPv+gmWX
         peDQ==
X-Gm-Message-State: AOJu0YwQz+FSrP4SiDTyFjyK69MS1OeFyksGhsCgl9RaxHa2PVszrFx6
	n4AHe3KF8cA1dLFcNAkQvA7EZ1fc59Fw7fKZiXawL2HgS1OGkIUIvODM
X-Gm-Gg: Acq92OEidfiHI2S8uXyLctRfuvR54jK0Fq63EzkTwUWNk49qNyW/7ABD3GAlvN1j9AP
	WFtD7LxWgDDMC2KxL4v4jHVUrIAt3JGzhWr/6qXF23BsX8rhzmydR4aHuAVis/cybeZt5VeTA3X
	KPHEDEr6UWM3U15SuO6e2bLdR7HMP4YpWbuCFPlHwJGsL0JrkbR/foA6E6uNNaFJ4NfPHVRKeoT
	CyJM1f/5ual3MJc7HogJ0rqIQz8tnHVFFevYKs4hceDNhh6CmKqFbqCHvxvaduRxcYCbiZLgUBZ
	YYvDFKkHyNGJYqktVx1sre84ni3czDdrorQLNtQsTF6wKnn8OJJDKFL27fbj8jb7ZFvjoqi21ba
	h1zlpSaeFS3XgDeiBL8ZNZMZeR5Z06R1mBCBG99OpA89FNXrlSeLNqX9FLfBSellBDI7174ishW
	bml69x1e7iMK96xMx0vXCSnhIawJF+bO/VcZAhJ5jFMLwxjl57rhEW5BkxRIo7BvgCIw==
X-Received: by 2002:a05:600c:2d43:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48e51e166a3mr209737685e9.7.1778493079247;
        Mon, 11 May 2026 02:51:19 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm24882921f8f.26.2026.05.11.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:51:18 -0700 (PDT)
Date: Mon, 11 May 2026 11:51:16 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, martin.lau@linux.dev, pabeni@redhat.com,
	song@kernel.org, liamwisehart@meta.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <agGmlIqgqTX_w2l1@gmail.com>
References: <20260511085344.3302-2-mahe.tardy@gmail.com>
 <a310c8a6fbd8442e4976bb9b80156376bc6c1fe668ddcf94052822924835949c@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a310c8a6fbd8442e4976bb9b80156376bc6c1fe668ddcf94052822924835949c@mail.kernel.org>

On Mon, May 11, 2026 at 09:40:32AM +0000, bot+bpf-ci@kernel.org wrote:
> > The API consists of four kfuncs:
> >
> >   bpf_netpoll_create()   - Allocate and set up a netpoll context
> >                            (sleepable, SYSCALL prog type only)
> >   bpf_netpoll_acquire()  - Acquire a reference to a netpoll context
> >   bpf_netpoll_release()  - Release a reference (cleanup via
> >                            queue_rcu_work since netpoll_cleanup sleeps)
> >   bpf_netpoll_send_udp() - Send a UDP packet (any context, LSM prog
> >                            type only for now)
> 
> The commit message states bpf_netpoll_send_udp() is "LSM prog type only
> for now," but looking at the implementation in bpf_netpoll_kfunc_init(),
> the function registers netpoll_kfunc_set using BPF_PROG_TYPE_UNSPEC:
> 
> net/core/bpf_netpoll.c:bpf_netpoll_kfunc_init() {
>     ...
>     ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
>                                            &netpoll_kfunc_set);
>     ...
> }
> 
> Per bpf_prog_type_to_kfunc_hook() in kernel/bpf/btf.c, BPF_PROG_TYPE_UNSPEC
> maps to BTF_KFUNC_HOOK_COMMON, which makes the kfunc available to ALL BPF
> program types, not just LSM.
> 
> The check in btf_kfunc_is_allowed() tests BTF_KFUNC_HOOK_COMMON first and
> returns true if the kfunc is present there, so any program type (tracing,
> kprobe, XDP, sched-cls, etc.) can call bpf_netpoll_send_udp().
> 
> Is the commit message stale, or should the registration be
> BPF_PROG_TYPE_LSM instead of BPF_PROG_TYPE_UNSPEC to match the stated
> design?

Ah indeed, this a stale commit message, will fix in v2. The real
intention is to make it BPF_PROG_TYPE_UNSPEC. Will wait on some more
reviews before submitting.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25660780250

