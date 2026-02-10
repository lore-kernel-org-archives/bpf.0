Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AB3271EB
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724477; cv=none; b=dwdSzWESqgIUyRMq1UqPeJDgzPVBiPpfUnz7SOYxdUZebFhJ/+srkBnCOweg3q7+F52CtLqumwRJRLF8mBE8z1XYWHmxczVRt1n2nfEH+bT1RTPBhRPsyJVVJ0LybV4rO0syHC5nxnCic2/E1LH/VJkAa1BSIabp8jTCeJ+aF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724477; c=relaxed/simple;
	bh=V8S+bf/F66K8deOO2u9VcoAmmrQcaSvWUcOZQvCI4qM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiPYliJsMim9XWlSo6ROrTey2f9XBQNXIh0Q1gsRtYBUDJ9GXrHCdNGmadZYHYRqbWIB2cxLShMNjfmYDMjGvP6uvGErfFlK08DObMmGzvA3jczYuotY6t7DdeZrTMUz8xo1BbSQge/In8bNDvBujNEPHDlJDoph8zlrkQAApg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A45wwVYb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bd1C3MiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A45wwVYb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd1C3MiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ujBMXc2jefpwX552HAfe/z0MTFmV9RxghsSUrNeWh4=;
	b=A45wwVYbTa30lF9BY3aj+tDYbjIHTC4hESd4qXo69mmrvaq0cdTw4wSIAp4gS+BxaobdbE
	jzgkZfns7pYUUW/3AtLPMn0Abe6Xx4knyBIsCVaPJ9dyGfZacB6eJwT4hLplLfwkFdIeQa
	7mQqtcUdSCieXrt9gXjH64plvZtIgck=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-b5bb9PRKNfWnVKGyJN-e6Q-1; Tue, 10 Feb 2026 06:54:34 -0500
X-MC-Unique: b5bb9PRKNfWnVKGyJN-e6Q-1
X-Mimecast-MFC-AGG-ID: b5bb9PRKNfWnVKGyJN-e6Q_1770724473
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso34391675e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 03:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724473; x=1771329273; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ujBMXc2jefpwX552HAfe/z0MTFmV9RxghsSUrNeWh4=;
        b=Bd1C3MiLcYsQWKH+8dbql5kYWpYxacqklrLco/Gl1uzMVPsVNsoIAWiYKbqddPQdVQ
         G8WYkQOx9OG7txUFaVSwNA/eDcIazY8cYFahhO0lws47ezpPUrUgtyT9H67zMHgPthME
         tI4y9Iy8zcvKh0Dc7GC47uop10bETYYleMgoI6zuDVcFzpBnIB/9g2XTtbJNzTpSuBZr
         LbPkG8Gv9KVz6MACldrfXEcMaEhBodbWA7/9cvoVQELP5wUvMV/xhxiLIDIXWXnyLNdY
         1THbFEwQSt7GBImYX0YGwOhhsGxs5TT4xGmGMVoaMa5DHQjnh+8W+EiUuPATXXmHek01
         XITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724473; x=1771329273;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ujBMXc2jefpwX552HAfe/z0MTFmV9RxghsSUrNeWh4=;
        b=aYbXBLd4zCCxZ+7av10S1Q9VukpxYtyQWaazoxJ1petzxnMtNGBgOc6mjoFCgaoBPp
         aIj3PA/9+DMux/KziQ99K7x/P23pi873nxFBQ4n8kK079SITfSasgwCLq8x0zP4fVNKw
         3yEFeEXqFlyCI98MS0nME/0eGh1M1AhYQMzgxptnZDJxsrJFT8n5hsYQoYmh4btRKatm
         oROb+IlYSKo2FxP5b3RrUaxmApBHiXLhrZKOY1F52XR8DNOYHRSruF58PEAtwrQafEC0
         ZsgTPvlYZC/gIa6jYa+DES+Fgob7MAsbpkGWKbKahCgON91OrMKQgvGITvyGMxbR2NlF
         GZdw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+gry2aFbRYrsSNSRrkrtAMJVHgVMJkxOixrGNoFXYJJlZTQ6qK/LDbB4KNJOOGwB2qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPuk4TT/2Dbjf54qrVoRodQvscbChpJ9srwsnsv8XkVvE4+Apy
	gmpLSocN1+9ZmPclg37Zt9SsdX0ZA3gF1jHrFyYBezfBu9t780r1fkyT7cuZ7Gbkt8Y7OHQTjhR
	XeoHbj1wt3D9m8uZ8ciGE3NP+Abh7UqTvxjpHyyDwLR9AhncxFYPtvQ==
X-Gm-Gg: AZuq6aL9WXFen6RVgHOjPZRlHyhF24v3Z0Z9C/HnmeihUndt2wETGXDQZ6wirkEcyix
	jGksszBSqD7aRqGGYfitf1AY6aikuXYhu7pA0/wxdwmhXnbTbDjjC3jl+n+GsJNafNApleHy99w
	hg2UPGn6UGH547ADFINKfKUNnOZVSgYuetKSfah9P1lHvmNhwmCb1cqvnq5zeknMbSqANok6jvo
	iffUsgsfnqbhZTW6pEObu3ZikJs+4DhtGYLajhmamyaDTPW/KGxbO/qxcSkQGMeW/vEgEj1GZVC
	Bfu+KrNY4zmKjvkvz5fLdrkH5NOkqugJI9ye1mYIGX70lj3GXLwzHXrXlfxaWVD+Ga+IJQj8Vlb
	TC5I8OZfDfDhRlHF7+niiSY9leYKPoyNZQRQ524w0gX0AUQ==
X-Received: by 2002:a05:600d:6413:10b0:483:4807:20fd with SMTP id 5b1f17b1804b1-4834807226emr44644895e9.30.1770724472675;
        Tue, 10 Feb 2026 03:54:32 -0800 (PST)
X-Received: by 2002:a05:600d:6413:10b0:483:4807:20fd with SMTP id 5b1f17b1804b1-4834807226emr44644605e9.30.1770724472261;
        Tue, 10 Feb 2026 03:54:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d8f2csm83406055e9.1.2026.02.10.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:54:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B7F784FE89F; Tue, 10 Feb 2026 12:54:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 5/6] net: sched: rename QDISC_DROP_FQ_* to
 generic names
In-Reply-To: <177039508922.2258217.2724637003148631081.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039508922.2258217.2724637003148631081.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:54:29 +0100
Message-ID: <87seb8yft6.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Rename FQ-specific drop reasons to generic names:
> - QDISC_DROP_FQ_BAND_LIMIT -> QDISC_DROP_BAND_LIMIT
> - QDISC_DROP_FQ_HORIZON_LIMIT -> QDISC_DROP_HORIZON_LIMIT
>
> This follows the principle that drop reasons should describe the drop
> mechanism rather than being tied to a specific qdisc implementation.
> These concepts (priority band limits, timestamp horizon) could apply
> to other qdiscs as well.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/dropreason-qdisc.h |   21 +++++++++++----------
>  net/sched/sch_fq.c             |    2 +-
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
> index 2e2f4fc36e0d..8661797193b1 100644
> --- a/include/net/dropreason-qdisc.h
> +++ b/include/net/dropreason-qdisc.h
> @@ -12,8 +12,8 @@
>  	FN(FLOW_LIMIT)			\
>  	FN(MAXFLOWS)			\
>  	FN(FLOOD_PROTECTION)		\
> -	FN(FQ_BAND_LIMIT)		\
> -	FN(FQ_HORIZON_LIMIT)		\
> +	FN(BAND_LIMIT)			\
> +	FN(HORIZON_LIMIT)		\
>  	FNe(MAX)
>  
>  #undef FN
> @@ -82,17 +82,18 @@ enum qdisc_drop_reason {
>  	 */
>  	QDISC_DROP_FLOOD_PROTECTION,
>  	/**
> -	 * @QDISC_DROP_FQ_BAND_LIMIT: FQ (Fair Queue) dropped packet because
> -	 * the priority band's packet limit was reached. Each priority band
> -	 * in FQ has its own limit.
> +	 * @QDISC_DROP_BAND_LIMIT: packet dropped because the priority band's
> +	 * limit was reached. Used by qdiscs with priority bands that have
> +	 * per-band packet limits (e.g., FQ).
>  	 */
> -	QDISC_DROP_FQ_BAND_LIMIT,
> +	QDISC_DROP_BAND_LIMIT,
>  	/**
> -	 * @QDISC_DROP_FQ_HORIZON_LIMIT: FQ dropped packet because its
> -	 * timestamp is too far in the future (beyond horizon). This prevents
> -	 * packets with unreasonable future timestamps from blocking the queue.
> +	 * @QDISC_DROP_HORIZON_LIMIT: packet dropped because its timestamp
> +	 * is too far in the future (beyond horizon). This prevents packets
> +	 * with unreasonable future timestamps from occupying queue space.

Why change "blocking the queue" to "occupying queue space"? The former
seems worse, so worth calling out?

-Toke

