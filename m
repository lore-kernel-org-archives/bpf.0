Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD912D59E8
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395477; cv=none; b=qw7ZTh3zZ0zfVvl3ZmAKe733ook40Kfdt01omsBRaDO+kqvLoqdMU5XJN3fvBpwYh+B4J84Y5/5Srk5SKteLdiPIzvzvi52hTlsBRYrXh7MTQ7m9CuevmDklVtqmgoLMHiBK0gMX40chaY4Nk1oK4RYMHB/Dws77ofLAtehjmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395477; c=relaxed/simple;
	bh=Kz6VlKLGOivI2j8Zpd0GccMoSZbri7XMc/sAdgFnrdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2yRQAlnNtOC18ATYCvzekpEx0XmySjlwrP2ngQdJlR8DriS94irlaw7q3AX3dRnTF/jYJ3aSGOfvb2sQTxqzvqHUUD/4gUsSRv2mRjV6/IiSg7ek45+zko7I4XgXnT6Xh0LZtH3XZ6B9kVSbg3wkiMCgjr52LDu2oybxIdlB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlW5Ra0H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkoqS4ha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlW5Ra0H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkoqS4ha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770395476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SJLfwbv+tziNl+CajzkO+HCkJScusVZPIA6PyKKQWs=;
	b=XlW5Ra0HmgtZLeNHyquT58HoUmmYY+FwnzGrDjxt0ZFyG8xNFO/fj8TZw2nvDNb8tolTXZ
	S0/9Ds4RLzD/AE19YVMw0FpA+3KU1cxj4xmhsYbyQVz3dAMVL+Xv2V0YOWuBaDbhEeHYC+
	bjw+kBvazu+csSOZOmdYyU6oXbphUU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-lxZU_MxWNUukBv2AD7SRog-1; Fri, 06 Feb 2026 11:31:12 -0500
X-MC-Unique: lxZU_MxWNUukBv2AD7SRog-1
X-Mimecast-MFC-AGG-ID: lxZU_MxWNUukBv2AD7SRog_1770395471
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-482eec44485so19370145e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770395471; x=1771000271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SJLfwbv+tziNl+CajzkO+HCkJScusVZPIA6PyKKQWs=;
        b=XkoqS4hae2ubZqwP+LENoeREusddyKTVMTvEcMmHj55tIMVB5qDh90Udgfee4taB0I
         xh1snEAjdYNsWJ1HcLjAl5bHTK+ZZGU2cc1jnO9o+Yb8p9Z4rV8xYOIca0fYs7LFbVWk
         rvrL23qG+/JoVk0MzTCidE9BemEZpDCujXRhZbJJL68q9Rf+2y6ycr0paD4Uy8psXPcF
         m6Kth0/cO/5Q20U8m9CXZG0i3U2EWaniNEnu5Sc51c1Pp0J3j7DNmdWVsqm9egz1zTTd
         I3qXHXu1o8wJO89ZZIjZFuZgu1DkIs2+r7NHRcHMCxlj6TEEGsXBDud9pNv3Ini8KQIA
         oPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395471; x=1771000271;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+SJLfwbv+tziNl+CajzkO+HCkJScusVZPIA6PyKKQWs=;
        b=GAVbbFOCg8mYpSLYlIJaY8+gTH6ELm+ktE4NxOR77JMz0TwB+//M2N77ir58HuM+7l
         3v7/gbFoX6RtVIRfU24rMuC1GjmN4ZRMLF2sj18whaAOP8rfvkHMa22WP36WNz36fecu
         6km0a8whlP+HWEienKFAyYDQZ/bXyii01caJITSmZ/sg460pRP0BZQ9/q/zyx8Y0G9dE
         zkPGx+FJMfQTv0Q3so8/nT0MS9KZyq3QEGYFbWGcxioH+iBOcoAcN7sfUfL3F6k7B8C+
         0PdUM6L5PVvr2YaX2+wY+3LrSwWHUqsyFjdXhK/H9rpH+WJGMmWWrsIVzeviUy+wQygb
         yRTA==
X-Gm-Message-State: AOJu0YwFWfxDfKKAqe4NVHv5FN6lr32GNRvHEj39pFanBbCZlQQZ/9ZZ
	HSUL2gP4Ew+7mG23ELjPeeYQa6aJOphmdtTWYZkCuBLjPiH2Xfy85kpGo5Ra/PGO8r/syhTcORa
	GUQudtbM/UOoEt0qKH57KqDoKfJFjrwSJc9Q9GDRYUtk+UPDWovp1+w==
X-Gm-Gg: AZuq6aKCsEcRDKcK6x0V9vyLyb2qCV9TrxBRk3m9vLI+MXL0eqNzHy0mKJH+SWO+xac
	KuXutyl0l/eDgkNl+HlUfMR67T4+k2Rt/gaWyeOKKzgoluSWUHH3p8VLiBdIcGCSDLd6VgDGl3L
	k9LEEknoM0E5Q9RyP+rZpx6VZ+H+BRiiUJIhTvCXe+tKarmkg2ikEZ01Km9WsZO22yY4lzPT6Pk
	d9nHf+k0wlYDnQ9euhNIMWFClNONnHkiGTy7QUooWBVhc2Fi7XHh3TEO/tN5Tpo/wzNVjADhDI9
	d2d95NComLRTW01qm3oy73F4Dirw1AepHtofrlKzk6T8pbndOSkyJcDaxaWJvtrYxS/VuKgEK1j
	i9qNU/+Ez9zc4GvLhdSPQzt/UEPLp8aIwSZ7H
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-483201ee840mr45286025e9.14.1770395471122;
        Fri, 06 Feb 2026 08:31:11 -0800 (PST)
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-483201ee840mr45285655e9.14.1770395470671;
        Fri, 06 Feb 2026 08:31:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm7668591f8f.31.2026.02.06.08.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:31:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BAB954FE2B9; Fri, 06 Feb 2026 17:31:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, atenart@redhat.com,
 netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 1/6] net: sched: introduce qdisc-specific
 drop reason tracing
In-Reply-To: <26e54152-e576-4292-b6ba-d50cf7cc8aa2@kernel.org>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
 <177032649028.1975497.12663177216553780756.stgit@firesoul>
 <87sebez099.fsf@toke.dk> <26e54152-e576-4292-b6ba-d50cf7cc8aa2@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 06 Feb 2026 17:31:08 +0100
Message-ID: <87pl6hzveb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 06/02/2026 10.31, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>>=20
>>> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
>>> for qdisc layer drop diagnostics with direct qdisc context visibility.
>>>
>>> The new tracepoint includes qdisc handle, parent, kind (name), and
>>> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
>>> for backwards compatibility via kfree_skb_reason().
>>>
>>> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
>>> infrastructure.
>>>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> [...]
>>> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
>>> index a7b7abd66e21..3d8d284e05c8 100644
>>> --- a/include/net/dropreason-core.h
>>> +++ b/include/net/dropreason-core.h
>>> @@ -68,12 +68,6 @@
>>>   	FN(SECURITY_HOOK)		\
>>>   	FN(QDISC_DROP)			\
>>>   	FN(QDISC_BURST_DROP)		\
>>> -	FN(QDISC_OVERLIMIT)		\
>>> -	FN(QDISC_CONGESTED)		\
>>> -	FN(CAKE_FLOOD)			\
>>> -	FN(FQ_BAND_LIMIT)		\
>>> -	FN(FQ_HORIZON_LIMIT)		\
>>> -	FN(FQ_FLOW_LIMIT)		\
>>>   	FN(CPU_BACKLOG)			\
>>>   	FN(XDP)				\
>>>   	FN(TC_INGRESS)			\
>>> @@ -371,8 +365,10 @@ enum skb_drop_reason {
>>>   	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
>>>   	SKB_DROP_REASON_SECURITY_HOOK,
>>>   	/**
>>> -	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputti=
ng (
>>> -	 * failed to enqueue to current qdisc)
>>> +	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc during enqueue or
>>> +	 * dequeue. More specific drop reasons are available via the
>>> +	 * qdisc:qdisc_drop tracepoint, which also provides qdisc handle
>>> +	 * and name for identifying the source.
>>=20
>> IIUC, this is not needed, see below:
>>=20
>> [...]
>>=20
>>> @@ -37,6 +37,24 @@
>>>   const struct Qdisc_ops *default_qdisc_ops =3D &pfifo_fast_ops;
>>>   EXPORT_SYMBOL(default_qdisc_ops);
>>>=20=20=20
>>> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
>>> +			struct netdev_queue *txq,
>>> +			struct net_device *dev)
>>> +{
>>> +	while (unlikely(skb)) {
>>> +		struct sk_buff *next =3D skb->next;
>>> +		enum qdisc_drop_reason reason =3D tcf_get_qdisc_drop_reason(skb);
>>> +
>>> +		prefetch(next);
>>> +		/* Catch wrong enum: skb_drop_reason vs qdisc_drop_reason */
>>> +		WARN_ON_ONCE(reason && reason < __QDISC_DROP_REASON);
>>> +		trace_qdisc_drop(q, txq, dev, skb, reason);
>>> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
>>=20
>> AFAIU, the idea here is that you just pass the same 'reason' value to
>> kfree_skb_reason(). Because of the subsys shift and offset, these will
>> all be unique values, so anyone just watching the old tracepoint will
>> get QDISC_DROP_* reasons with no context, and if you want the context
>> you listen to the qdisc_drop tracepoint.
>
> I'm already changing this code in V3, as syzbot revealed that some
> existing skb_drop_reason's do arrive here, which is the TC filter drop
> reasons (SKB_DROP_REASON_TC_*).  We primarily need subsys encoding as
> we share the SKB->cb area.
>
> This is the new code, that pass 'reason' through:
>
>   /* TC classifier and qdisc share drop_reason storage.
>    * Check subsystem mask to identify qdisc drop reasons,
>    * else pass through skb_drop_reason set by TC classifier.
>    */
>   if ((reason & SKB_DROP_REASON_SUBSYS_MASK) =3D=3D __QDISC_DROP_REASON) {
>   	trace_qdisc_drop(q, txq, dev, skb, reason);
>   	skb_reason =3D SKB_DROP_REASON_QDISC_DROP;
>   } else {
>   	skb_reason =3D (enum skb_drop_reason)reason;
>   }
>   kfree_skb_reason(skb, skb_reason);
>
> I do realize that the reason is now a unique value, that in principle
> could be passed through, *BUT* that will break existing userspace
> tools.  E.g. the `perf trace -e skb:kfree_skb` cannot decode these to
> strings. (The net/core/drop_monitor.c also need special handling.)

Ah, that's a bit unfortunate. I assumed the tools would handle these
correctly automatically :(

> I actually want to give userspace a *single* SKB_DROP_REASON_QDISC_DROP
> reason (that existing tools already knows).
>
> Leaking extra qdisc drop reasons is not helpful to consume as it is not
> actionable without knowing the qdisc. A QDISC_DROP_OVERLIMIT from FQ is
> very different from one in CAKE - knowing just the reason without the
> qdisc type/config is insufficient for debugging. The trace_qdisc_drop
> tracepoint provides both the reason AND the qdisc context together

Depends; if you only have one of those installed on your system it'll do
just fine :)

In any case we're changing things here (removing reasons, or changing
them). I would lean towards having more information available (i.e.,
passing through the reason), but if common tools can't decode them,
that's a bit of a bummer.

I suppose it'll be too much churn to start out with the single reason,
then fix the tools to understand subsystem drop reasons, then change it
again?

-Toke

