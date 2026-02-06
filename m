Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832035BDDE
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370296; cv=none; b=E594VYezDaMH52J8DQnkDXbVRNHW8TJz5IgDgTIGE/2h+F1umkmrzkRfek9xpOx22idpN2e0QawEtEQ9T9f4F+TvHw84ed7ELFdUW67Zpd7lu733jY9yc5Yxml07yEzENNi2Scf3pCwibn1M9iY7V6LqdRdBanuTLYcYtHD0KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370296; c=relaxed/simple;
	bh=AZErRJuX4VSgdhM0SMFp4ZfOGqCP+e1gDUw6damSyQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NWGsn3Cci2Oieh19+YHaCCzpyMMDMDaIsvFlx2nv1iZDnexYdinJDn2KS7iZMXsG43WIGRJXRU5tfgBNBF1J16+6nnXm6/JayyRu73VOZ4ZJi9ZRKjZy59dwEMNZvjK9www8YV6kGHjYtCHOgn4TgThGFuGw46H/W2/kQbquAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZEDZlwo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpjaozEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZEDZlwo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpjaozEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770370295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m83qFJJ/01p5WS71hLn6ZqZlvQWtUzYkRVCrBOr7lc8=;
	b=XZEDZlwonLQDhkbVqhPQXF8URvpYNFvv6sHWyvKWVZyusKXP3D66orc1ug26S2+iOE89e/
	5FahkGG4K2CwLddwstuEh3DTwCkwGZBDJZ6aVf/71yLlH/5UhCoUwvriKXsZ2fFddAIaP0
	dtWopBVEZQ/wuYD0SDcweAKZ8YziQsA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-d9-XqM_JM_GwqbykU-LUoQ-1; Fri, 06 Feb 2026 04:31:33 -0500
X-MC-Unique: d9-XqM_JM_GwqbykU-LUoQ-1
X-Mimecast-MFC-AGG-ID: d9-XqM_JM_GwqbykU-LUoQ_1770370293
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso23062425e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770370292; x=1770975092; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m83qFJJ/01p5WS71hLn6ZqZlvQWtUzYkRVCrBOr7lc8=;
        b=WpjaozEYr5fkBm5qPzxlY4aXiZZdD3haaUBpOPQwTCdFzw1/PT9sOJwxK6FP8jC4m/
         UDq+b0X2Rum3TDyFeQST6bnFgKvkbpGTIjWGGysu5ZCDv3pR8q0ZdPs4J2+Rmu1yv+Zm
         1W7borB0B/AMcOoUsOd2t195yuAZBPIl6i/hDS3W0+ydjDPkRFfXoZc5a90fuBCux9lV
         4cGqL3x+5xtrW5Po1Pkg4MyAwhhubNh85vPg+Dhuk9oFFE+SYsKjrnYO1OM3J8mYcWwL
         h9EOsKw9YJa9jUpX0T4cyfH8qa64ZANwXkEEyU55pQnalF3DpFT86hkCxgW4/ptVmwKx
         32Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370292; x=1770975092;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m83qFJJ/01p5WS71hLn6ZqZlvQWtUzYkRVCrBOr7lc8=;
        b=HBehdDRopZRWRx6vW9nxVwMaMfLd7L78cmewfIMb36WvDpFO5mh5JM/1ADn2kwoWYk
         3sw0wPjpC5uHHX1YtM/Prz6hrxGPP9/bsNSBIdbprVApWY6n1gnzISFUuvgwCWXJdUQp
         ZQDXCcta950FxmkGEqGYuhIadnO+jfjPDZ/pprj/XkPRtzQ/4qWsEiLRyZR0+2JvGDDy
         LHtrcbYYSMi+3AMGg7fOwS/+yLuZX5YRf/DwPy4LMQLKt7wuN2MzjteO3GmgGqNVhI3a
         RB7Z2cD6mmEjm5sHTnvNtm9U1ZUALu0LEYkXNv6lpuMM5WeMex+fkchtHMOVuTIOugwq
         k7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVOF0qTsXRbhOdKRGG5a2sAQHhuGNV6GEXYBAceGix0x1v3tEU5ShZD0txe1HrGCuDWqaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFXM6/08kipj1sP+dw0WbkEab4H2r8Jf6h3zXb4pOOb2WMcPh
	pF9e0vlHk8jq23Kfy4iigEmpvitXhL+5BFFaw2RvMWTTCkyI29UrKrkzhmrkR7L6uzJWFz6/1R3
	spqfoN/pitcTtZ2Y2dYq3r68xoFVKvL1n3E37j7BaJIqRRTY5q2Z07Q==
X-Gm-Gg: AZuq6aLHn/24pfsaXO5tilsSqREUxkIEXOmNsmx6b744EViTF3KgNm5PSIPEy2m3pjs
	HALkMQPpCS9Icg5Iwbk/StNWFRAUS6g6oNsr5fcI6pWD5XRmYaz9fg5DSKbfJXvcCKyUHdA0m9S
	TvqQBeaxdRLnDwWFEK/G4dWh9uawGc4Gd2LlTjApoyXFwhmftgjnuXoAUG0UyuYhYhrl75Pi3kx
	MQndU9crbU0eIhi3dpU+AvCLqaGhkz7sA/XA2vWbgAmqfacS1zCTTP7BTgk7OdXd4GnsoR41i+D
	sZMvTJnrt4A7U2O1wPNjxnyLW5gBhzj9PqUpL1Y/vKfTCAO/eIm5QmNzpPUJkqXsSRkr9ZSyk+u
	lOvCv0zvaFzvOMJrZaOOsrthzQ2/2jcbo/w==
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4832021b572mr27051465e9.19.1770370292458;
        Fri, 06 Feb 2026 01:31:32 -0800 (PST)
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4832021b572mr27051125e9.19.1770370291959;
        Fri, 06 Feb 2026 01:31:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320728ac7sm36880205e9.13.2026.02.06.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:31:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 595AF4FE19A; Fri, 06 Feb 2026 10:31:30 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2 1/6] net: sched: introduce qdisc-specific
 drop reason tracing
In-Reply-To: <177032649028.1975497.12663177216553780756.stgit@firesoul>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
 <177032649028.1975497.12663177216553780756.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 06 Feb 2026 10:31:30 +0100
Message-ID: <87sebez099.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
>
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
>
> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
> infrastructure.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/dropreason-core.h  |   42 ++----------------
>  include/net/dropreason-qdisc.h |   94 ++++++++++++++++++++++++++++++++++++++++
>  include/net/dropreason.h       |    6 +++
>  include/net/sch_generic.h      |   36 ++++++++++-----
>  include/trace/events/qdisc.h   |   51 ++++++++++++++++++++++
>  net/core/dev.c                 |    8 ++-
>  net/sched/sch_cake.c           |    6 +--
>  net/sched/sch_codel.c          |    5 +-
>  net/sched/sch_dualpi2.c        |    8 +--
>  net/sched/sch_fq.c             |    7 +--
>  net/sched/sch_fq_codel.c       |    4 +-
>  net/sched/sch_fq_pie.c         |    4 +-
>  net/sched/sch_generic.c        |   22 +++++++++
>  net/sched/sch_gred.c           |    4 +-
>  net/sched/sch_pie.c            |    4 +-
>  net/sched/sch_red.c            |    4 +-
>  net/sched/sch_sfb.c            |    4 +-
>  17 files changed, 225 insertions(+), 84 deletions(-)
>  create mode 100644 include/net/dropreason-qdisc.h
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index a7b7abd66e21..3d8d284e05c8 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -68,12 +68,6 @@
>  	FN(SECURITY_HOOK)		\
>  	FN(QDISC_DROP)			\
>  	FN(QDISC_BURST_DROP)		\
> -	FN(QDISC_OVERLIMIT)		\
> -	FN(QDISC_CONGESTED)		\
> -	FN(CAKE_FLOOD)			\
> -	FN(FQ_BAND_LIMIT)		\
> -	FN(FQ_HORIZON_LIMIT)		\
> -	FN(FQ_FLOW_LIMIT)		\
>  	FN(CPU_BACKLOG)			\
>  	FN(XDP)				\
>  	FN(TC_INGRESS)			\
> @@ -371,8 +365,10 @@ enum skb_drop_reason {
>  	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
>  	SKB_DROP_REASON_SECURITY_HOOK,
>  	/**
> -	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
> -	 * failed to enqueue to current qdisc)
> +	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc during enqueue or
> +	 * dequeue. More specific drop reasons are available via the
> +	 * qdisc:qdisc_drop tracepoint, which also provides qdisc handle
> +	 * and name for identifying the source.

IIUC, this is not needed, see below:

[...]

> @@ -37,6 +37,24 @@
>  const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
>  EXPORT_SYMBOL(default_qdisc_ops);
>  
> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
> +			struct netdev_queue *txq,
> +			struct net_device *dev)
> +{
> +	while (unlikely(skb)) {
> +		struct sk_buff *next = skb->next;
> +		enum qdisc_drop_reason reason = tcf_get_qdisc_drop_reason(skb);
> +
> +		prefetch(next);
> +		/* Catch wrong enum: skb_drop_reason vs qdisc_drop_reason */
> +		WARN_ON_ONCE(reason && reason < __QDISC_DROP_REASON);
> +		trace_qdisc_drop(q, txq, dev, skb, reason);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);

AFAIU, the idea here is that you just pass the same 'reason' value to
kfree_skb_reason(). Because of the subsys shift and offset, these will
all be unique values, so anyone just watching the old tracepoint will
get QDISC_DROP_* reasons with no context, and if you want the context
you listen to the qdisc_drop tracepoint.

-Toke

