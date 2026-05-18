Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEE3F86FB
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114381; cv=none; b=WZL8/Kw0dXDBIyV4uudG/fIxvbeW6+30MWJbeZQ35lLSf4KD3ptV5ry+oovqPXA7jkvBNkW8ndqwsHy/Xzn03es2cpGbqDtw4WItQhmW2qH1PrY3IErqrFW3kVKxUYk/bEsL2htfO0Tfga9hjFec0u3a0vT0OUCU7vTlKWlzUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114381; c=relaxed/simple;
	bh=89I3dsEQmgvGzJ6RM/nLpu3C1uHMvEPGKm+69HVlElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esAbjsGubpQa6ZyxjJPLlVSDutaTvSt12JJrLp48B5Qfp1vMBiIspIqp+VWBChmDPXXG2tD2FxkCvgC0GmizMaByeFigvImgVVWek5/DGcV7NJbKS8bYTLCFl4y34W63HjfagzYiF4J5Klfgmq67Pah0nFPyxl4shRqbG/T3WOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1dr2xy9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1dr2xy9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso18465125e9.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114375; x=1779719175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUmc/2eFwDyPu288j7GDElCwP6ZQHTGou0nPfUDNu+s=;
        b=U1dr2xy92aSTrdsYmr2TFg4pVx/efpAlwGG+i0zi5cFK/HlJeQWtEet9mJKTzdnL1g
         21w2oo8rTau6NH21XXbMUxTge5HQPsEBwb7DmFnRqWyIiSdPJgHuPm/6c4coqyvWa1i9
         QhSKQUhBmHRZintfdmAZa9s9R0cnVyzxZ/Hea3YWjOjSbAGDncy9cYsKtlyk/aj17z5L
         96czrSppm8nZxvpNc2y3lVNXnq4adNSZH1W0BTY26M2nmDNzOLWbjcp4vxVtrXXie7gg
         PVVEhQviT+ul71hiQJqaRZvBK9Z9FvERWOOhCRjDccnaBd/PEPeLtPMIa4pRY7HSNgob
         xekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114375; x=1779719175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUmc/2eFwDyPu288j7GDElCwP6ZQHTGou0nPfUDNu+s=;
        b=Ytccq98ASKPnsN6r7Iaog6Xn1JUEPZ4Tg/Z+qxd8M8XfiqSnpORRvECT+nyIYNMimQ
         yU7hijTn4njiWRMIy6i6cXvxP5zXGTVAylnyg8LZSY97pSQELIjXewNk0pKNFngo/ZDU
         Onveta9yIHK4F3eVx/WHI7sZUtm7lco8XyB5vcEenJLYnrrspFanaa2fRPZB1nKoz7GY
         q1a831xvH/octsqJcxM1F5xpm0ZvF0kS6BfQbod8zyQVlBVwbk08DPJ/+q/hwrJHj2v2
         6xyhgKTNeK2QfytY4NQEN83KpJq3qvpFy1KTID19HUJ0FDp0Yf78oZzjv8bJRvtB6BaR
         CkgQ==
X-Gm-Message-State: AOJu0Yy0Fk2SfXp5dJq6t/k1/3UxUAfCePLJ0MoHXtz5AZSwtflhQ1aT
	Cy/XP89Obn/faNL6gDgL30kOzyI5llPdpG8s7U/FwaDyD87IN2CjqZTq
X-Gm-Gg: Acq92OF4uzCP+SKMqACXZwxJsEkHs0++NjayreDnWa3+2T8aHnFtzb0r7UeBJDRJEG8
	TUI76cs9c9KtA3rithqtHlfLiLCFOJkLgHFgvq1wMGs81KqqUVAnp07plQj0muTMwsk9SYwWomP
	7j7c+Pd9SMwRfvD4PFVZ8SuJRoe1NEQ+J0TXkbhCwlmBMhAw+cWjRSYT0Al1dmurmnG7mCzNeol
	socdFWqt0kRuX8bsV63xt13TDFDT53rUctX3gOueqv/xz+Yn1j+k4e60ZLRpNmzRYCO/CmiOAj1
	+XtuUqkdpWj1ET60tCdzHJnUECkbFeD6LH2xLzpUddHTRZU7Vmr6HJap5kXeuEk+y0BOOCS3zt0
	9CVpxnTCLnVbVI09M0go3AOv1qeQ8oNeAQtYaQlXewMOqiRiZ4vo2mpvMI3cxyzwpIzUuPv/zvY
	7jolQOhmlBnPg46BjEWVRTD5VwI40bzgfvYvbKRPKocK0Pcc8Heq2Tc/A=
X-Received: by 2002:a05:600c:c087:b0:48a:7b55:12a6 with SMTP id 5b1f17b1804b1-48fe5cb36aamr188849425e9.0.1779114375254;
        Mon, 18 May 2026 07:26:15 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm259037795e9.2.2026.05.18.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:26:14 -0700 (PDT)
Date: Mon, 18 May 2026 16:26:12 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Message-ID: <agshhAKrNWKG8cpa@gmail.com>
References: <20260518122842.218522-4-mahe.tardy@gmail.com>
 <dc63930101e50f36995ef7b487096c6580e7eaa75594ab083ff6e0bc28eeb046@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc63930101e50f36995ef7b487096c6580e7eaa75594ab083ff6e0bc28eeb046@mail.kernel.org>

On Mon, May 18, 2026 at 01:34:48PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 9590877b0714..843fa775596b 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> 
> [ ... ]
> 
> > @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> >  	return 0;
> >  }
> >
> > +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> > +
> > +/**
> > + * bpf_icmp_send - Send an ICMP control message
> > + * @skb_ctx: Packet that triggered the control message
> > + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> > + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> > + *
> > + * Sends an ICMP control message in response to the packet. The original packet
> > + * is cloned before sending the ICMP message, so the BPF program can still let
> > + * the packet pass if desired.
> > + *
> > + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> > + * supported.
> > + *
> > + * Recursion protection: If called from a context that would trigger recursion
> > + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> > + * re-entry.
> > + *
> > + * Return: 0 on success, negative error code on failure:
> > + *         -EINVAL: Invalid code parameter
> > + *         -EBADMSG: Packet too short or malformed
> > + *         -ENOMEM: Memory allocation failed
> > + *         -EBUSY: Recursion detected
> > + *         -EHOSTUNREACH: Routing failed
> > + *         -EPROTONOSUPPORT: Non-IP protocol
> > + *         -EOPNOTSUPP: Unsupported ICMP type
> > + */
> > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > +	struct sk_buff *nskb;
> > +	bool *in_progress;
> > +
> > +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> > +	if (*in_progress)
> > +		return -EBUSY;
> 
> Is the per-CPU recursion protection flag safe without disabling
> preemption or bottom-halves?
> 
> Since cgroup_skb egress programs execute in process context, they can be
> interrupted by network RX softirqs on the same CPU. If a task sets
> *in_progress to true and is immediately preempted by a softirq that runs a
> TC ingress program calling bpf_icmp_send(), it will read the same per-CPU
> flag and spuriously fail with -EBUSY.
> 
> This was raised in v5 by the Sashiko AI bot:
> 
>     Since cgroup_skb egress programs execute in process context, they can be
>     interrupted by network RX softirqs on the same CPU.
> 
>     If a task sets *in_progress to true and is immediately preempted by a
>     softirq that runs a TC ingress program calling bpf_icmp_send(), will it
>     read the same per-CPU flag and spuriously fail with -EBUSY?
> 
>     Does this critical section need to run with bottom-halves disabled?
> 
> https://lore.kernel.org/bpf/20260515202358.20252C2BCB0@smtp.kernel.org/
> 
> Would using two separate per-CPU flags (one for softirq context, one for
> process context) or disabling bottom-halves around the critical section
> address this race condition?
> 
> [ ... ]

I've replied on the v5: the race should be acceptable as it will fail
close with EBUSY, if we want to avoid this we might want two PER_CPU
in_progress flags, one for softirq and one for the process context. In
any case, what we want to prevent is recursion (the kfunc triggering
itself), so softirq interruption from process should be okay as it
should concern another packet.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312

