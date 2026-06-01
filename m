Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9E3932F4
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306364; cv=none; b=YN3OQGqNOWpUrXnChBL+E6+T9fC/n8darpq2nZMQBxuhPTrDJLFynjKLUR6jk2P+Qt/uWzaMVN/V9NGsgp3LOk3lNi9b5YN3scu/A8gutKAIGSHJ8tRS8O7HgwWTLrG3WTtL2KY5NkpSmoATOjzl1T0DVrmGwkNPU+1lhnNVOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306364; c=relaxed/simple;
	bh=aeJX6dXJghL4L0k/98gZpCBvMgVIBHhvis8QU91lGB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tml+Z3ZzGYOC5uodUXqUJ+usiF3/YlzpIh9afyWZPa37YlMxtH4BIXqLEgX2thE54Ve5VuNgY5AFAIkTMep/rjneY33M2BLtceZh4bAgVphN52s/H2Ordlw/O7aV66KfB18A0nhDTWFyjKYwRpa8oY8g0ZDPT4RTip54e3sRHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVdGIgWe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=luSsgwMX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVdGIgWe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="luSsgwMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780306361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb+EE09b4g4IsWhIcNW7yc7MKt+xMeLe5twP9TbR3IA=;
	b=GVdGIgWeN3uR/IwA/HXsAtxCbt7sjxBqBk8om8PElyWCQ/isZ6j6pUSmTQ5YRq5uiiroLn
	n1SIfE0CbzuMyye14Hph68bEKGQDQL7KBbrRCavb91Jssawd/KR0NKKSzxNZHVIoIzc/2l
	jLv8enA16sugvjSIaEroMSZmjR8RAG0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-OsUJ2SLbNTis6Mx-qXIYPw-1; Mon, 01 Jun 2026 05:32:40 -0400
X-MC-Unique: OsUJ2SLbNTis6Mx-qXIYPw-1
X-Mimecast-MFC-AGG-ID: OsUJ2SLbNTis6Mx-qXIYPw_1780306359
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4903dcb32f8so85808165e9.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780306359; x=1780911159; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb+EE09b4g4IsWhIcNW7yc7MKt+xMeLe5twP9TbR3IA=;
        b=luSsgwMX9speKCd84obdSN5RefU9lMJ5Nflc62tE+aWO6MVrYSSi7fdL3E0wxSelaq
         PHGnnWctStid3EaKFBeJYzWVk5P1lO8H6CkHPg0APoCHcsr2xlqA7AF/zA0JsWe+jMS9
         FEnbqlMcY2yEimYpbk4huoDG/Eul8Fzmfog/o9+8cX3fMkpw0n4qzWKT+fJGdiNRZdlM
         I2f4wr3aXP2hdyyd0rxXP8MAar3yribNDJWFJAdWWVGFfcPnIXdIEkDMAP5tPuxQ86sf
         WJmYL682OzR1RKeNTLYR66FxcJsQyve1oZY0ayLmm/qRAc7LDH/+6cF6Y2qubNYJK0fr
         vvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306359; x=1780911159;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yb+EE09b4g4IsWhIcNW7yc7MKt+xMeLe5twP9TbR3IA=;
        b=gegaJVO9Gkre9C+t5j+csTF7pyXMz0ZSzsgo0aR0Qlzfi3IfmLnSQyFITU1PKnmPiW
         rK/et0TEpBZ8gZGg7zzHps4eGn9OjQPeifem6JK+JFICPqvhVA+7DpRbIlJEy4j5ctL3
         tY+6bZfBI/3NP5EEfDdrmVUS90o+uaLEbc6uDcZGNKXCiwfn+xttfjD1HJsVG34/0zqs
         GPN8mShRwrkc6ZBXkG/3iQ6XYOYPQqQ1V+fqdJWOLSs3jPGJyMhiHTw/Go8/SRS+PGdu
         Ie3tXBAkmbsIKTafPKNMQ6ucYj3vH/WXAsSutuSjqV1qwMr0/X6Rp7UwRhXa+qGlRxKA
         +uPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/op5s7q91j9qwV6ipJp6FYAwrsoK0fQuJlWSk2oAy6iqEmn+KZJunBwYoA7A3ZdXvjgvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBzlP9BviAd7twcNc7y3TQpoo8aQm6RObSL/gHGjHmQp+zG2a
	JfIRbk4BBlGTMATraHcD96tUZDqV96hIDuxfU17nIJKQ2Oqb8D/GMDg9Ry+kVF/ukGim2MLbLWG
	yxYmNaX1VaC+c2wHqbS8ChSOdVZF8xC0kFKNP3jf4qayQSsZpkrFpOg==
X-Gm-Gg: Acq92OGhSaAYvQS9npU3iHf7mAtjXy95stlhLT4ogceX+lsY/lVrAErLd9DhOPqqVlv
	HB6K6JsSHct8j8pJnBQ+7B0J3A/Uh9BzKxYL7ESpzz9yF2daRrjkp/Q0H9y9fPYZl5uXtkbwcrb
	eXUdokGJkqpVFyHGcgchhjqKKHNAwhyxR6UkKdi/VwQK/IODGVEBmPDO/yEdvlZx+GzIw/Vk1kJ
	cXkYhxwvQQMT5g56OTqeOWLoTEailnC1ll1e2QFe6DgVK0ZPmNoY+cB+CNyhu54Ygl5bofNFzC8
	/paQ4mqgEaHT6DUjLtNn6qwoQsXT1XI3fBVKKBFXP2W8IDp3zgb5IVSwMibaIMTlpvl+SVN6Krj
	KniCThyBmaOJEzfCKvWSTJ8sMWqrMxb3XAq2x5n5bYwiltKxa0mkJGwq3Qfw=
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr186919975e9.15.1780306359051;
        Mon, 01 Jun 2026 02:32:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490a29338a8mr186919585e9.15.1780306358692;
        Mon, 01 Jun 2026 02:32:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a04e2sm21727194f8f.1.2026.06.01.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:32:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 242C07BA6AF; Mon, 01 Jun 2026 11:32:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, yuantan098@gmail.com,
 zcliangcn@gmail.com, bird@lzu.edu.cn, zzhan461@ucr.edu, n05ec@lzu.edu.cn
Subject: Re: [PATCH bpf 1/1] bpf: devmap: reject cloning fragmented xdp frames
In-Reply-To: <4b596825bccc64d03e0c2e0db4dceb12c7f5cf47.1780176829.git.zzhan461@ucr.edu>
References: <cover.1780176829.git.zzhan461@ucr.edu>
 <4b596825bccc64d03e0c2e0db4dceb12c7f5cf47.1780176829.git.zzhan461@ucr.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 01 Jun 2026 11:32:37 +0200
Message-ID: <878q8y38sq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ren Wei <n05ec@lzu.edu.cn> writes:

> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone xdp_frame instances for all but the
> last destination. That clone path only copies the linear frame data,
> while fragmented XDP frames store skb_shared_info in tailroom outside
> the linear area.
>
> As a result, broadcasting a fragmented xdp_frame leaves the clone with
> XDP_FLAGS_HAS_FRAGS set but without valid frag metadata. The later free
> path then treats uninitialized tail data as skb_shared_info, leading to
> an out-of-bounds access during frame return.
>
> Reject fragmented frames in dev_map_enqueue_clone(). Devmap already uses
> -EOPNOTSUPP for unsupported XDP frag forwarding cases, and the current
> xdp_frame clone model cannot safely represent a cloned fragmented
> frame.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  kernel/bpf/devmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..2bfebded5329 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_netdev *obj,
>  {
>  	struct xdp_frame *nxdpf;
>  
> +	/* Frags live outside the linear frame and cannot be cloned safely. */
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		return -EOPNOTSUPP;
> +

I am OK with restricting this (the support can be restored when/if
someone has a need for it), but we should add the same restriction to
generic XDP (i.e., in dev_map_redirect_clone()), so the feature set
doesn't diverge.

-Toke

