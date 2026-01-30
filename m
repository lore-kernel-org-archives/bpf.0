Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA5334C3C
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762432; cv=none; b=f5BK72fGwTEfYIBmZV4l8qbLjQt7CMP3O9Wb4CPbVkluCB5iuA1Ie8xg27Jtb9y8qzdJlfgcG8z1rCZ1IXGrZEqlKoz9cmTdfR6VIg8egMW5GwGwhxXKkAORnZ9PfCRkdV9TQt2lK5y2pQ9YbEieQjWvPGYSu8TmnbSh6wbYFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762432; c=relaxed/simple;
	bh=n0jMgmG40z2H2jzTNOqElovXskshLnu1xJ/LSjnyAdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekJpPN8l0TE1CJb9LdFo5xtP8s3gXMVaO5OrxVTzIBfAIyMxnchqXKTdDlXQz6UHHAESh5mjM52a/dIMix++TYCAkjdSRDf4BMk5ei7Cg55T3qej0+p+85GTlp3khoGAE8xmBLCfW6Isd1PBfQUe62KEybSoDgDS50fwODhCCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYgd/7Nv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sdPG76Y+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYgd/7Nv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sdPG76Y+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769762430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AOMBl30iiqU2hb1KDZ3dhT/0NSn9OSG50CGfaIcYpoA=;
	b=aYgd/7NvepxZvOb8ba5U0wBpn9GcDoAPxp7sdRUz2dynSRuACAmXN4I2eBrO0kFbhqKBDU
	+IeE4x64s662xgbXRn76iUey/JZOc2bqOjYMgXhf3OBnIPn42jM9T0cO6GO/ScxSV/ndJE
	XJm6uuUH4dxjoDpRb9L5MYcHPEMK9MY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-6dqDNbliPpej7rY6r011-A-1; Fri, 30 Jan 2026 03:40:28 -0500
X-MC-Unique: 6dqDNbliPpej7rY6r011-A-1
X-Mimecast-MFC-AGG-ID: 6dqDNbliPpej7rY6r011-A_1769762427
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee1fe7b24so16090185e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 00:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769762427; x=1770367227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOMBl30iiqU2hb1KDZ3dhT/0NSn9OSG50CGfaIcYpoA=;
        b=sdPG76Y+dX1alSnDTMlGOzIuZfZ1M85L1/HphcpkaAMBxbYd7ETA6cRs/KktCYJsum
         AoB+xCwsSIjCZ4QasXCNJA9zXm1dvV58JwPer0HRl22rIQl4ncMXYwXFnlM5DZreB4NL
         BHBnXKD/XgRHhqp9WE8eOJSnPDagqd00LRzTxUVnYc8dpApXlYrOq7c0eSCMQC8qMxev
         mCCR5b3O8yMClD+V7QokDNlByI1cHTo0JZZLXx8UBd4BHTKbqgwvzmIwkWwUe3Y+A5HG
         8H1vxoDWXdjvkIxNI1cwSheyi28RVoRAju7lCXJOCICE+aQX2HkPtWE0ZXedIy0uSdrx
         mGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762427; x=1770367227;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AOMBl30iiqU2hb1KDZ3dhT/0NSn9OSG50CGfaIcYpoA=;
        b=vGPEooFgAkBYQUoiRdku3vUpLyRSYWbi8nDcwccOwrYF0b+vzhU0Fq7PZYUzGIQoiX
         Yt1wpUAxmPkFfLDrPVh2eYKKCEgglE6AdCKjI/kGEH60fx8yfl+f2uEwO5YbdCiALw2s
         GN6P5+H5z4ZNc7SIHxeTcQbGJtWnEeg+oRvTaJpQzvFbsQOlYhpu0fVLfo1HQ89Fve5F
         NSiIHJJGAWn1HtsnEx0VgXmb0BV4U7NpvcUy6pt7Yh1hB/wVdXVKC7pSyYkBXLgl3l0F
         2A8AS1o4qUIvyTHXRbi1R04wviZ8s8chvZFuZZ4eIIB2e2R6oA+PJeOh56HGbWOIVAeN
         v1/w==
X-Forwarded-Encrypted: i=1; AJvYcCWvLY+uI47o8NQhA6jINs+JJYXjswSWxdoVoBSxKOW3OHSyFYsqIDFKUie9/sZ0U2YZIFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo555hMvrtEV7079EJtL7YjZTO8AvTVrdewIprquFIfFdoiWs1
	mZ+uRS64sn+RGCchvVve89BtY5mYzKxWJdxADOq7lwMVM/0xXsau7x0eXFPWYLBxpTko1DL+D4t
	AfP3Fu7jQm1Kfrf4PD1I4RopAllR60jFT63kHRdFYfVPgETMiHZq14g==
X-Gm-Gg: AZuq6aKhHl5ltE6Ic3LH+sAzW4j6XXyRnOxNiLXGIIaVY+0HzPNEx2Mp89n9UIMIVYz
	UJ3oC0Y/WGsPkY2rUCSLcQVfwBXII9csXlh3DgTs4qnXyzcmvh21OTA0wHMWXhIn0pNbPMefcfp
	QSAZ/3aQRY8Fj9+Xs6Q8oYrTRAU+lW9ct4P0myNchiX4Clzs3Vvqtu5XJkRXtvs9b1PEWVjTzzI
	m7PY3j7h9tkco4M0NmdZRVBbqymEvzUrLkqt4leZJ5/D0L/e9qLQ5QffyHyOd7u+xffJW1kMEh3
	u+Q9lPGijF+MhULgZDXzAXvBx2ZjG+W7+R8JiUBVWbMbf7ofbeQYuygdw2v1bubH1A4Nqs2jyRl
	Mg/UtDCK690PpAHAeiYlZetozr6lSbPukxg==
X-Received: by 2002:a05:600c:474a:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-482db48e828mr21216725e9.27.1769762426681;
        Fri, 30 Jan 2026 00:40:26 -0800 (PST)
X-Received: by 2002:a05:600c:474a:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-482db48e828mr21216445e9.27.1769762426296;
        Fri, 30 Jan 2026 00:40:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e2545026sm7562755e9.11.2026.01.30.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:40:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 085C34D0734; Fri, 30 Jan 2026 09:40:25 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3] net: sched: sfq: add detailed drop reasons
 for monitoring
In-Reply-To: <176917072608.1186611.11185920960590396939.stgit@firesoul>
References: <176917072608.1186611.11185920960590396939.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 30 Jan 2026 09:40:24 +0100
Message-ID: <87zf5v3347.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Add specific drop reasons to SFQ qdisc to improve packet drop
> observability and monitoring capabilities. This change replaces
> generic qdisc_drop() calls with qdisc_drop_reason() to provide
> granular metrics about different drop scenarios in production
> environments.
>
> Two new drop reasons are introduced:
>
> - SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot
>   be created because the maximum number of flows (flows parameter)
>   has been reached and no free flow slots are available.
>
> - SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue
>   length exceeds the per-flow depth limit (depth parameter),
>   triggering either tail drop or head drop depending on headdrop
>   configuration.
>
> The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop()
> when the overall qdisc limit is exceeded and packets are dropped
> from the longest queue.
>
> The naming uses qdisc-specific drop reasons tied to SFQ tunables,
> following the pattern established by Eric's FQ commit 5765c7f6e317
> ("net_sched: sch_fq: add three drop_reason") which introduced
> FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.
>
> The new drop reasons are inserted in the middle of the enum after
> SKB_DROP_REASON_QDISC_CONGESTED to group all qdisc-related reasons
> together. While drop reason enum values are not UAPI, the enum
> names implicitly become UAPI as userspace tools rely on BTF to
> resolve names to values. This makes middle-insertion safe as long
> as names remain stable.
>
> These detailed drop reasons enable production monitoring systems
> to distinguish between different SFQ drop scenarios and generate
> specific metrics for:
> - Flow table exhaustion (flows exceeded)
> - Per-flow congestion (depth limit exceeded)
> - Global qdisc congestion (overall limit exceeded)
>
> This granular visibility allows operators to identify capacity
> planning needs, detect traffic patterns, and optimize SFQ
> configuration based on real-world drop patterns.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Okay, so I went looking for ways to get the information (which qdisc did
the drop come from) with a generic drop reason and... it's not exactly
trivial?

My thought was that you could get it from the location, but that ends up
being in the generic __dev_queue_xmit:

           ping-117101  [017] b.s2. 155651.231372: kfree_skb: skbaddr=3D000=
0000019495eb6 rx_sk=3D0000000000000000 protocol=3D34525 location=3D__dev_qu=
eue_xmit+0xcbd/0xee0 reason: QDISC_DROP

So you can't actually use the kfree_skb trace point to go backwards to
the qdisc.

Given that we have a sometimes-NULL socket parameter to the kfree_skb
tracepoint, I think it would make sense to augment it with a 'dev'
parameter as well, but that would require some restructuring of the drop
code, I guess.

Another option would be to add new stats members to sfq for each of
these drop reasons? Assuming you're only after the counts, that would
allow you to get those without adding new drop reasons to the core code?

OTOH, since we already have per-qdisc specific drop reasons for FQ and
CAKE, and adding more enums is cheap, I am also OK with adding these; so
with that in mind:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

