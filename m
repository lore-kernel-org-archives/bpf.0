Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3730AD0A
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486341; cv=none; b=ii6B8j85HCZ1MVtIvZA+j50fsbZrXapmrwaPS1EAUXThQGzS1zhJ6TJVV891DhzxP0dDEO4rxyYwZrv3VXPmzO72uKogpAzclMCIumK5Yx596jc4KoL5+5oAPxCPnC8B5tT7E9K4eGA0d07r37IZ+FHipOc4ua1jSJOPWAwTnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486341; c=relaxed/simple;
	bh=sJgQ7j15FiGeFLGYaPxcbYVubeA+A46akO7Kgwm8ahU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=quXgLTk++oDLiAoya9W5Jx0hgoBnXgyw5rxexeFOPlTgN4rdVKcu7KsYiMd+rNBJ0wTvpffR/Qz1cn5PGh6q6r3qc4W8Xx+AehJftrCK50qTYsFfV83X9A0Fv5QZw1cugT8q4YgP7g7uMXgGTS06HbyAa9z60GOBIphHgOZudXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3OGgoe2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3OGgoe2"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79be0de8610so36891867b3.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775486339; x=1776091139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuowHuG4z4t8Msdv+NcEOvfj3g6Zl6j4N6hX0BAAi14=;
        b=f3OGgoe2E+Yy42kcnnoL3cIkyC553yluX34V6UXKEkEDDGUgT29cKjsNuPUjbD3iZB
         1pO7PupA2y+JZoOFqBjzjdR/3baYThD27p9td/SlPfOKg3YMX/O0DUOFnUxmRmJz9RDq
         G+kyO/t5ceXmRiL8bc147IK3RkHY5yUXv7q6LuFySfUu+oZawcnu7Ma13ayood/+YW/d
         Z0ZpdNEUHs3XYqT2JVaeuxa/bnvDLNW8M6L/RTKj22TC1X/HNjLMNdxosPNH9vZrZZ5y
         QOAwkslzPRVR0PVXXXukL1FsWs0uuKzelEgrrqwLfMKi2NqlZTpAzDRbBzwkufm3joTF
         yOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486339; x=1776091139;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuowHuG4z4t8Msdv+NcEOvfj3g6Zl6j4N6hX0BAAi14=;
        b=OHFuh+LwRnY918dVI5Hn2P5E+FRdScq04WBNXC2HyJmNFSLW2XfM03BgmVVPoQOTGB
         TCTMFJECFjQvuAKpRA0c0kHxsHLntGqK7oTDLdMwXkDScPBRAiSvRawy0mAcqol0iRnp
         B9bQq9yUUGu9i9/Pnf5mn+2HFIVa9hYJj8z1w73sMoRvENWWsYmAkKSaANBx2ZtLPAQO
         01C+gMFsHrKtdWiE/jhCFXd7NJaFuIxFeMYX27p8Wu9wt5C3tUBF2i7IS38nthTTcv25
         K5X9FhsmuHMsY6ddVl5XbU5cGvtHJ6s4rXSNXwnWsHZcMqTzKzNmwTNU9VqJygexqcP/
         eXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+p0hTGj4z/fCIWwbTeH1D48CJW0ryx8ANrvcip/QhVYYzAgEIr0G9worB4oadTtvOv1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjlLiGsZfHlkgVnSUTqotXw6I3FFYyLSRrFzFDCMvbyTmwsV0
	R8okbKjFMhuxEzIFNag21S6b/SzSRkcZ60D6GnTlAN+4wBDkGYJa4/4h
X-Gm-Gg: AeBDiev04MkIMHlEz3MkotJHBgwxXQ3ci4rzmvweiuD1jhncJq+63asTwnorGT+Ffry
	cJ4bJI4UITWW5uelsVrty2PLgBQmJfq32LWHZahxESZm+pNuaErQN85vvFv2MghLeGnZfErbH33
	fNf88/EqMEDeqZdx3KlJ7hpMQ9wA84P1SusAmp38SI67n5GNOYhDmRd9IVgPvMIz5GPJ46KZR1O
	28LCdSHfCQBeyyLYbJ8L4IRSLLPKhtcBaDHrRQtut53UCwwrRA8tlvId7OCkyo/Lh/K7S8otlgd
	ZhbHB0D6vIpSDHR/hHzgEg1w2j8JsgJcXbKFByG0Ppkalajf2L3OoWXvbyvzSc0yN3GBNB0kfTw
	qUOg4QlicwXAYTQgYFi9SsMXwUe7vh5szoiGhbLia4oLIktlUWjpO5fKmL/MSDhSr/xwkyNu3BE
	OCyWAcMvLEUcunnIpsa3RM8qT9vsMcs53MCm00MrJEJWpqr3TrWAGOq89h0d5YlmXGh8pmotsUR
	qRe
X-Received: by 2002:a05:690c:39b:b0:79c:c51c:7f41 with SMTP id 00721157ae682-7a4d556e135mr126147797b3.29.1775486339309;
        Mon, 06 Apr 2026 07:38:59 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370cf93d2sm53929207b3.35.2026.04.06.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:38:58 -0700 (PDT)
Date: Mon, 06 Apr 2026 10:38:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <willemdebruijn.kernel.1cbb439d5cc4@gmail.com>
In-Reply-To: <CAL+tcoDuSyQdR83C-07bUpJfYdnrkkcA8gO+0qKZM8PTbiFofA@mail.gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <willemdebruijn.kernel.2053d6bde1d3d@gmail.com>
 <CAL+tcoDuSyQdR83C-07bUpJfYdnrkkcA8gO+0qKZM8PTbiFofA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] bpf-timestamp: convert to push-level
 granularity
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Mon, Apr 6, 2026 at 10:17=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > 1. Design of send-level granularity
> > > Originally, socket timestamping was designed to support tracing eac=
h
> > > sendmsg instead of per packet because application needs to issue
> > > multiple extra recvmsg() calls to get the skbs carrying the timesta=
mp
> > > one by one if application chooses tag with different tags(SCHED/DRV=
/ACK).
> > > It's an obvious huge burden if the application expects to see a fin=
er
> > > grained behavior.
> > > Another point I mentioned a bit in Netdev 0x19[1], supposing the am=
ount of
> > > data that application tries to transfer at one time is split into 1=
00
> > > smaller packets, recording the last skb's timestamps (SCHED/DRV/HAR=
DWARE)
> > > is no longer meaningful because at the moment timestamping only rec=
ords
> > > 1/100 packets. In this case, only the delta between when to send an=
d when
> > > to ack matters.
> > >
> > > 2. Known missing tag issues in TCP
> > > A critically important thing is that we can miss tagging the last p=
acket
> > > in a few conditions as the patch 3/4 explains. That means we lose t=
rack
> > > of the send syscall. Digging into more into how tcp_sendmsg_locked =
works,
> > > I found it's not feasible to successfully identify the last skb bef=
ore
> > > push functions get called. With that said, if we want to make the f=
eature
> > > better to cover all of these cases, we inevitably needs to place
> > > tcp_bpf_tx_timestamp() function before each push function.
> > >
> > > 3. Practice at Tencent
> > > In production, we have a version that applies the packet basis poli=
cy to
> > > do the exhaustive profiling of each flow for months in order to:
> > > 1) 100% make sure to capture the jitter event. No sampling.
> > > 2) observe the performance, find the bottleneck and improve it.
> > > We're still collecting data and investigating how it helps us in al=
l the
> > > potential aspects before upstreaming. My personal perspective on th=
is is
> > > to replace tcpdump eventually. It's worth mentioning tcpdump no lon=
ger
> > > satisfies our micro observation in modern data center.
> > >
> > > 4. The tendency toward finer-grained observability
> > > As we're aware that there are already many various bpf scripts tryi=
ng to
> > > implement the fine grained monitor of the packets, it's an unstoppa=
ble
> > > tendency for the future observability. We're faced with so many lat=
ency
> > > reports (like jitter, perf degradation) on a daily basis. Getting t=
he
> > > root cause of each report is exactly what we pursue.
> > > After we know which request causes the problem, if it belongs to ke=
rnel,
> > > we will dig into the packet behavior with more useful information
> > > included. This is the process of tracing down the jitter problem.
> > > Likewise, in BPF timestamping that mitigates the impact of calling =
extra
> > > syscalls, breaking the coarse granularity into smaller ones is a fi=
rst
> > > good way to go. It shouldn't be the burden like before especially i=
t's
> > > independent of application.
> > >
> > > 5. Details of the series
> > > Now it's time to convert BPF timestamping feature into push-level
> > > granularity by only recording the last skb in each push function, w=
hich
> > > is quite similar to how we previously treat each send syscall.
> > > Regarding each push function as a whole, we only care about
> > > the last skb from each push since the skb can be chunked into diffe=
rent
> > > smaller packets. BPF scripts like progs/net_timestamping.c has the
> > > ability to trace each tagged skb and calculate the latency:
> > > 1) delta between send and each tagged skb in tcp_sendmsg_locked()
> > > 2) delta between SCHED/DRV/ACK. Three timestamps are also correlate=
d
> > >    with the sendmsg time.
> > >
> > > In conclusion, push-level is more of a compromise approach which co=
vers
> > > those corner cases and further enhances the capabilities (like a fi=
ner
> > > grained observation of jitter and performance issues).
> >
> > # push-level design
> >
> > It it significantly less intuitive than per-syscall, which is under
> > user control. Or even than per-packet. As a fix for missing timestamp=
s
> > I understand these two extensions, even with the unintended side
> > effect of reporting many unnecessary extra skbs in the common case.
> > As a model to advocate for, less so.
> =

> Thanks for your review!
> =

> Fair enough. One mode of our internal kernel module directly hijacks
> tcp_skb_entail() that handles the last skb of this skb if
> fragmentation happens.
> =

> >
> > Would it help if all skbs from the same sendmsg() can still be
> > identified as common from the same syscall? That allows the user
> =

> I have to add more comments about push level:
> the last skb from each push function will always be correlated with
> its own sendmsg. With the help of BPF_SOCK_OPS_TSTAMP_SENDMSG_CB, bpf
> script can do so.
> =

> > to discard all but the last one (if they wish)
> =

> Oh, I just replied with another reply. Let's start the discussion here.=

> =

> It would be great if we have a definite finer grained observability.
> =

> >
> >
> > # ABI changes
> >
> > For SO_TIMESTAMPING we would not be able to make this change
> > unconditionally as the behavior change would break existing
> > application expectations.
> =

> Right.
> =

> >
> > That is why historically we have guarded new behabvior behind new
> > TS options flags.
> >
> > The same may be true for BPF.
> =

> How about adding a socket option for a per packet mode, say,
> BPF_SOCK_OPS_TSTAMP_TCP_PACKET_CB around tcp_skb_entail() which works
> very similarly to
> BPF_SOCK_OPS_TSTAMP_SENDMSG_CB. After that, users have a standalone
> option to decide whether to trace all the skbs from the sendmsg.
> =

> If so, the origin BPF timestamping that works exactly like socket
> timestamping is the best effort (we don't 100% guarantee the timestampi=
ng
> feature captures every sendmsg call). With the new socket option
> involved, we provide a finer grained vision without harming users who
> favor the origin design with those two issues resolved.
> =

> A kind reminder is that if the skb is fragmented, for instance, due to
> TSO being disabled, only the last smaller/child one will be monitored.

See also my reply in the other thread. Yes, per-packet may be more
informative and understandable as policy than per-push.=
