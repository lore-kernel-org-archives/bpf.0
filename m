Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193AA3AF64F
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358814; cv=none; b=a5NlCMMPAR4o8y9nMcRtGCodJh+zeXhpMJC2jzEiQwLtiZa0Deh6JlJkgOPDjZOovd7aywe/ehQxvHCsFgCk+AnLidtPeC1yOTlq4fKiQkK7oeawNknBoOcqxkFkmMY9Wxfyq0VSjeNyG9lCmr9phIx3C2EvUc3GCQnzvV70ieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358814; c=relaxed/simple;
	bh=g7qWqVyY+iHjDRjtLMQRnNdNWq79ioRPbSLvXsnReaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU/uxGVKs1Ctzn/wi5B+m1+zrReZs70PznZrk3wN95LoX4fRMaECnVpUaKB9RaqUVsUnwpH+HoLpHXlAFv22pYLZNqdWsHwawHER3yZpWUpJincbbYU3HtMdV3K6BHN7i+R2u6fXnJQpwylnmqKQIdiqlOr2zBmEQ0DIPoF1xhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dINVRXiz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dINVRXiz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so16232545e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358811; x=1783963611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Qhyh669ZXxHpz8jMNLJsfrGWhAXNaBuHUx0OM+dLgc=;
        b=dINVRXizQnhe364x1rtCV19YvTTCKr2/TwBqMmX01EmhNWnm4gd9sNOOF5urYcE2lJ
         mq4D9eQ7VlErKs+TsUNtF8+9vHf3Vv6u/YzXHhYP3Jc8ZBEIn259fG+F1stp+zJPyi0W
         mtzLtHj3kLQQAFKIz3QOmGGZ2ahRjO6+a9O1xJgS0qKk9xNU5roOFbn1cMAME8PgF2zo
         gCmjKBWrBetud6Py8MghrqLd5vljdm9uVnOZcieV6ayc86GVW4mdVvj5xIw01hHbzt3/
         Hb4cGljF0H/WJh4AMJtujeC/l3nsn5/a2k22Q/PP0giApoqhwqAouQ0f37sne81Uo2+W
         YG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358811; x=1783963611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Qhyh669ZXxHpz8jMNLJsfrGWhAXNaBuHUx0OM+dLgc=;
        b=kzED8eli61tK/SV1IUMinpUEKwS8Bwh2mQ8CZYdUeuCiukheA8NHHNT/c+Km4rOE0G
         Yi4FlUkNInHn6tpWGHzP0+sC4q9th6QzvYr1lwMjQO7O8zmS3l/50sXVpxhM/aPJhQSB
         +QytzhLWmv/ORjek8rbJHcBGcczHXTuMrFS8unI26LBt3FxSZTiLwwXA6rXwGi0YNLzE
         4ubcIoFcfHiqRxUw6lJ37wn8uFNqEYCT3TJ/v67sVT3k0IZTbCqfi+57VHHlVmuAb0wb
         sudiwTbp3u/yyBcHd4aaHiqOEDZAXVWeU8QPb9EdJb+4I0btbWlGV83kwv4dSWPd1ykO
         uqGg==
X-Gm-Message-State: AOJu0YyYdfZzsE5VaJR5a46eyCMMDWqL5FzbBfR6xM4ZsdanQQSU4SBd
	dyPNEg0XPzlinzLdTZrYFRj+tDEceZZiw8pkcdJDTvip2Cf6GLqlMmtW
X-Gm-Gg: AfdE7clBIKoExSSiHE2TDi5FEOIl5aQHcSjDTp68blTkSwTuMuy1VBMCEKhyNCONF8M
	G9VBMb5kAauyc0VDKH4rsJpPOYl7L1ulPkVVPfK6RK2PMV9eliymayvma7VqlX+5WOpfiporPLf
	kgcR85vg+rW4fOc6FO2Dq4leaMagEuha99dX4v9S6NtBdi8wWiHiEuRlzPFKhspd8tb0IMiRIom
	a1e7ewUBn/gsgnoyr2xXtbWBinalQqd7jSX7VZrFlZo/1s3erHa4qJxKUpOrr/vOGlPQYS0YCbO
	dkDe/O1Csy34SIoG0iWEmXe5q5dP0Q61QJZYu4uXcQ9MzGm0jGvUxjOvP/eB4/QcQ85X+95uO32
	52s62SwG8xHPr0zdmROGVueASJ2Ervx4ZsaBxU7zc8k+5nffuf80YqVxJf9uQXF0e651ha82X4O
	70EGRF0xCiwjYkUbZKU+EwsWlg+mK2iZLnR98GTf5zsBb3SvzzpWS1FWQ=
X-Received: by 2002:a05:600c:8a1b:10b0:493:c1bc:79bd with SMTP id 5b1f17b1804b1-493df08c838mr14066975e9.20.1783358811347;
        Mon, 06 Jul 2026 10:26:51 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493df702209sm5264795e9.0.2026.07.06.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:26:50 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:26:48 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvlWB6AkP6kQ7xO@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>

On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> On 07/06, Mahe Tardy wrote:
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> > 
> > The API consists of six kfuncs:
> > 
> >   bpf_ksock_create()   - Create a socket (sleepable)
> 
> [..]
> 
> >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> 
> Since you're doing only UDP for now, maybe you don't need bind/connect? The
> kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).

Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
and mostly added the args checks. Another thing is that send is simpler
since only used on connected sockets, so you just pass the struct
bpf_ksock and data. So on one side it would simplify the current
UDP-only API for now by removing the kfuncs but we might need a more
complex send kfunc (something like sendto).

> 
> >   bpf_ksock_send()     - Send data through the socket (sleepable)
> >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> >   bpf_ksock_release()  - Release a reference (cleanup via
> >                          queue_rcu_work since sock_release sleeps)
> > 
> > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> > programs.
> > 
> > The implementation follows the established kfunc lifecycle pattern
> > (create/acquire/release with refcounting, kptr map storage, dtor
> > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> > may sleep.
> > 
> > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > specifically support AF_INET and AF_INET6 sockets.
> > 
> > The socket operations go through the expected LSM hooks instead of
> > by-passing them like many kernel sockets since those are created by BPF
> > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > exposed to LSM progs, has a re-entering protection to avoid recursion.
> > Also, because of the LSM checks, we prevent the use of the kfuncs from
> > asynchronous workqueue as the current value would then be invalid.
> 
> [..]
> 
> > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > kernel sockets that may exist in each network namespace. Out of
> > simplicity for now, the settings is host wide but the counters are per
> > network namespace.
> 
> What is this guarding against? Rogue bpf programs creating too many sockets?

Yes. AI review raised this because users are prevented from creating too
many sockets by bumping against the max number of fd and this would
allow them to create way more sockets. I kind of agreed that having "a
limit" on resource creation would make sense but maybe it doesn't and we
can simplify this!

