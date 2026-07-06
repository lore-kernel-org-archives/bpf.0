Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176B438FF5
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371774; cv=none; b=Wbf/woz45IMrIJm+E+B5YmkrqUP2P++NJh6zUP+REMx0ZyS76pEP5xVTNOxXA7U5W2C0PSlAQJu/BhDPLU8/8/jP5ewDyLbQA5iign0d8g4JW86kYcMafJtmHczWSawAy78f/dvAu+Kim9X0aUZu1rIyX4kAW/xGUGJpElE4cPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371774; c=relaxed/simple;
	bh=yE4a2OoB2EdymvEnSgE8O740pw/Pct2sb0k04H4xwtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGAXoU2PcrrdItgGm3gg3kr34t2fe9NlCth81PEm2k9FDANOqFWIpki+d8j8NW8JKeqU0MYFo5DJ3IeMasNiZh2TqUlcwMYM9Yc0+O9hWLCJqm0KZw29OEJJWfNB8Ll9FUEgiGxyRsyMpv7uZvBpDPkIHfwSOE/mJ79Vv4xSwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUnL+QK+; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUnL+QK+"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc7ef596c6so4073945ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783371769; x=1783976569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jaY5gLMzPvaPKGXT1DU4u3duCOtyWyKV0VKOG5KOP6Y=;
        b=BUnL+QK+y7nL68DJnLndwf/KjxL3gziIxvuyk/4B9HkYXwTPnfp47puFL9PMSgBEhq
         BXm4jZ8VWEfEtkloORIxSyY+usTG+vMa8rkpxf+7DF1kTvy5EeM32VKOSaybwJV1mEkb
         G2pM8KKt/7EES/e3C6ZkLeFkVxt8GAgxGT/J9ALhS7O5qDU3RGAqnZFJbKq5+385mAn4
         x8EcVTnj0G8rokD8pMgtgFKq6yjvvKRoy368tl/EiRrkZI5UXqoimcgoUnDhj4SH+BYX
         OwOcFUXxsGAb6jVU2EhUfvt1VjZEwVb+X4pkyWl40khZGRVihWNcC3FFnGsNVLuBDM3g
         4pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371769; x=1783976569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jaY5gLMzPvaPKGXT1DU4u3duCOtyWyKV0VKOG5KOP6Y=;
        b=m0yK2eYfbLbEGXBN/GeTQcnxZHAEVckEgtphAKpLV3HnegqJnimygMATHgLYcq0a1i
         wWCV203vVpvHKRnnEbBgHx0Yh86q45beQ2jGZxTiYR7/ogPw2btuyurzLjF5QCHQhLtb
         EqWPAj5CLzwQ894knyKm8xAGxgjQ6lDZXbaJt4GU8V/2npRw5EUa8blggzDiB35sglH7
         yulfI7dWmcS+jOxNMr9Vb8kMKH55sRHt8SUAS5Q++DXqI6T14rmKk4HYs3oQcjWbKSWL
         8uxh+D+nJ4vS4n8DunkdS0xDsI2FHfDku9AlRs0JcuyVzw94hM8BmMXOIPvHLjbgqjTX
         9meg==
X-Gm-Message-State: AOJu0YzfaFr8oWTJYpoJs/wQCPcpbQ4hjCrZ/Cocn3b2hxduSk86lo7i
	WQf7XtlJj4OdAFm8t8v7Uoi96M3o5QYyTrhKzkL1WdJaoDqn4XW8UItE
X-Gm-Gg: AfdE7cmB1sajYFElcDR9XV6BYd/JvQcmjbfyO0TFeYvqIt2zRV++UFyz/y4TrABfpXV
	BTGz02MgIzNmTb76HwDUxqawwxbPEm4B2YR7YsoAQ+TNWumajwjVwtEUkDjru73knhfMGe+4zjL
	bbadeN3u40jNQ2Xj6WOOmZNks+6TxuxV+XV7x9JmZWX3xyWr2gNCqmFbvgbOQl84hODi0x+QpFm
	JmKaHC/oOsZ3Xj2eLJBE//VOg7S5siVBQi7M2uhToRycFded8iVXs7Ek0YnZdRN1cCdz/P17Lug
	Zk3NdVWNVbT19NiHz0jBmT7/dtmc3eX92CS5NHPb401WY9/ZXGJfWfMNThsQn9hadsmYbSOh2Q4
	8FyZYFuQ2IjreJnA2uF4ymcaBrfXhenyBMR8R1QosILxLyPyoOKpP5gWNHMZn41wUcRSpzr9+z6
	YN5iWMimHH5UAwt7s=
X-Received: by 2002:a17:902:ef48:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2ccbe50aa67mr23504705ad.6.1783371769111;
        Mon, 06 Jul 2026 14:02:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb7e9sm568745ad.10.2026.07.06.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:02:47 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:02:39 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akwTnnSGJpki9hAn@devvm7509.cco0.facebook.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
 <akvlWB6AkP6kQ7xO@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akvlWB6AkP6kQ7xO@gmail.com>

On 07/06, Mahe Tardy wrote:
> On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > On 07/06, Mahe Tardy wrote:
> > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > > sending data. This provides a mechanism for BPF programs to emit
> > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > socket types with IPPROTO_UDP protocol but could be easily extended to
> > > SOCK_STREAM and IPPROTO_TCP in the future.
> > > 
> > > The API consists of six kfuncs:
> > > 
> > >   bpf_ksock_create()   - Create a socket (sleepable)
> > 
> > [..]
> > 
> > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> > 
> > Since you're doing only UDP for now, maybe you don't need bind/connect? The
> > kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).
> 
> Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> and mostly added the args checks. Another thing is that send is simpler
> since only used on connected sockets, so you just pass the struct
> bpf_ksock and data. So on one side it would simplify the current
> UDP-only API for now by removing the kfuncs but we might need a more
> complex send kfunc (something like sendto).

Since you were targeting bpf_netpoll_send_udp originally, maybe sendto
is a better fit? You get the payload and the destination and you
bpf_sendto() it? We can later move to stateful bind/connect if needed.

(mostly coming from the pow of minimizing api exposure initially, but
not a strong preference)

> > 
> > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > >   bpf_ksock_release()  - Release a reference (cleanup via
> > >                          queue_rcu_work since sock_release sleeps)
> > > 
> > > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> > > programs.
> > > 
> > > The implementation follows the established kfunc lifecycle pattern
> > > (create/acquire/release with refcounting, kptr map storage, dtor
> > > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > > struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> > > may sleep.
> > > 
> > > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > > specifically support AF_INET and AF_INET6 sockets.
> > > 
> > > The socket operations go through the expected LSM hooks instead of
> > > by-passing them like many kernel sockets since those are created by BPF
> > > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > > exposed to LSM progs, has a re-entering protection to avoid recursion.
> > > Also, because of the LSM checks, we prevent the use of the kfuncs from
> > > asynchronous workqueue as the current value would then be invalid.
> > 
> > [..]
> > 
> > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > kernel sockets that may exist in each network namespace. Out of
> > > simplicity for now, the settings is host wide but the counters are per
> > > network namespace.
> > 
> > What is this guarding against? Rogue bpf programs creating too many sockets?
> 
> Yes. AI review raised this because users are prevented from creating too
> many sockets by bumping against the max number of fd and this would
> allow them to create way more sockets. I kind of agreed that having "a
> limit" on resource creation would make sense but maybe it doesn't and we
> can simplify this!

I believe even the kernel sockets go via lsm layer, so this enforcement
can be done in an lsm bpf program. Seems like that should be enough?
