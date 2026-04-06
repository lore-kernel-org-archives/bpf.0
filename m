Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3B12D21B
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775441865; cv=none; b=mmC2bas6cx3Mc9C8x5jMEnLpeYLD51BwPtv9HU6euxFxYpMC7FjGCdrU80iCmek/1YJhmnud+S9wuY0e42laLGfHdmjLe/N8+Yx0m+/GJEomJhBLq9iWkjrD1fqCxj3s52Qmos6J2NywmorHuurbANgFRJe10nDLh3AUP8t1EQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775441865; c=relaxed/simple;
	bh=iCB6IL77/Q/NTqAH02gKN3gak597hAOB08vjLYzyg9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WcrGgYRHU6INMqRNiCK+sLpoPoZUY+v6gDpDwYyj53JYydhbgomGiqETuZybfHiZqprV17tQoRK+J6qWn0aFa+iXa7DTlMK+k63mCAxJFkIIB0S0VKoNa5EvStJvF4smyPXlAzpaS1Bn7278JKUwIY1BxrRaev7lJfuRBCtKVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjpcCLf5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjpcCLf5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7a299d84b7dso23886397b3.0
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 19:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775441863; x=1776046663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EioxQ3NC1zrSrJKRc0dY7WjMA5THNc63GtRU8/xWe2I=;
        b=LjpcCLf5bBEmW2C2hr37dkYQMvYJjYsRiWds4bG+tu1r5VdVXrNXA/WMUbRug9Z2uw
         xAt59XdOTfJTFPLxPHcDO4aoJSEjrqiDl7txzzZZwrqGgSTHZBI/Eq5tg558uL/rVcOx
         48+qPaxPa6WgCP/f0hNHj2x7wD5yA9Xlz9T67hGI9C78G/1h6oLKk0F6Ys3EhMb3w4Ca
         i9aoiDauYdZM0RECaZLKdhj/xPV4Gn6NezQJ+i9gU7JP9Xf+Rl3xxto2PJ+DP9JMfZbj
         Z6n8PXCecjMwbyy/mOu8hprTMoAV305T+pqzFMUu8pqHvGqGnTLRUjkIjYucuZYfsXNG
         2mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775441863; x=1776046663;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EioxQ3NC1zrSrJKRc0dY7WjMA5THNc63GtRU8/xWe2I=;
        b=fWresMc6754JlNTUgMsGDlz7ZQfioxXck4ifM1ax3Rj2cNx6WaAM+Do8xgPBqQAL8e
         BTqmpk74vj/RJNM+gw+Iu9g4xnKE16XH9Q9ovPYdhIhpLN5PuwWWyZNoqI3WZckfT1Ff
         rdlUKga3FkCNTrUaUGXm/kQnqTK4f4TOB8rQM9dPOhNABqkLVYuLJK9Zvg4cE3vF8kBG
         p1gdQYHg+pIuA58PAHbC0Yr21INM/BzfSH2eRHYFzYUn24ZHo9ha9ff7Ka9Zn6XpHOXD
         c3WEYpJ13TJHtWLJNpjpRdkuhIwor3Rrlh+dR2ZVJdND+3/CB4bRzVeynfx5QSI1u/7l
         SPIg==
X-Forwarded-Encrypted: i=1; AJvYcCWp/ixNTn8XMVy/g4a+Ef2uUDOpoDJ7yUwDUgbiY3cOMdk7hKNZ4xBNkyjWABKwLt/z60o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3f6zhM3mXYSROg7jZ8OJ59cjnANxBo+O+1b83EAWpxU2zgILw
	IO0xPHeHltqLW+I+cuUgsS/VGhvc4rd1mKzd+yojBjVMxze1jzKKQxGM
X-Gm-Gg: AeBDiesnQ8lGrEr3S/vHS4/KgA07qZ4tXWYmBspw40TSIp+eGLos4MqLMg74tse5TTe
	R2cXuHrmU8P1EQ32wBKPfTcYb1t8fgViqoXB0nG4wR6OoXwz0k1vAs+h71HqIhggk2ioX7ZuBeL
	Qr7880rpj59YksZVhQ1s4PTp2UO7uF1AH4Hsi4h2TOcllMGJlVqBa6S8BoUnfGPds5UwyDGYAx9
	CtP5E8nTvSzclUBESOXUerNu3aZ/Qg9Ju6KDoc6XY1iJGuKVxOFTnibNm6JOwgDp0Z1sCn0clki
	Jx+JtJMq5G42eb9A4JZVoByjKM+Sm3/uaPh57pyV2TlyLWtL0Lsp9rX12rfJlYQWUR1XhsJjv9x
	v/d/1sXL1yuYYJzxDrQcaOqsCcC5F4yV8lUclbFkPQwEJjCunSWadjJoiO1GPODdfPBUBB0dUJD
	BdOLIoe1YSndsPiGcnPkB214FKL/bbtJg7DtlbUbRVEgnQOehPDTzLiXKyC/uVysVS9vTmvX1cr
	yguIyFlXpQVIOQ=
X-Received: by 2002:a05:690c:64c2:b0:798:6c28:dd58 with SMTP id 00721157ae682-7a4d3ec620bmr115452897b3.24.1775441863150;
        Sun, 05 Apr 2026 19:17:43 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff26sm49118657b3.9.2026.04.05.19.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 19:17:42 -0700 (PDT)
Date: Sun, 05 Apr 2026 22:17:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 martin.lau@kernel.org
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <willemdebruijn.kernel.2053d6bde1d3d@gmail.com>
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
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
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> 1. Design of send-level granularity
> Originally, socket timestamping was designed to support tracing each
> sendmsg instead of per packet because application needs to issue
> multiple extra recvmsg() calls to get the skbs carrying the timestamp
> one by one if application chooses tag with different tags(SCHED/DRV/ACK).
> It's an obvious huge burden if the application expects to see a finer
> grained behavior.
> Another point I mentioned a bit in Netdev 0x19[1], supposing the amount of
> data that application tries to transfer at one time is split into 100
> smaller packets, recording the last skb's timestamps (SCHED/DRV/HARDWARE)
> is no longer meaningful because at the moment timestamping only records
> 1/100 packets. In this case, only the delta between when to send and when
> to ack matters.
> 
> 2. Known missing tag issues in TCP
> A critically important thing is that we can miss tagging the last packet
> in a few conditions as the patch 3/4 explains. That means we lose track
> of the send syscall. Digging into more into how tcp_sendmsg_locked works,
> I found it's not feasible to successfully identify the last skb before
> push functions get called. With that said, if we want to make the feature
> better to cover all of these cases, we inevitably needs to place
> tcp_bpf_tx_timestamp() function before each push function.
> 
> 3. Practice at Tencent
> In production, we have a version that applies the packet basis policy to
> do the exhaustive profiling of each flow for months in order to:
> 1) 100% make sure to capture the jitter event. No sampling.
> 2) observe the performance, find the bottleneck and improve it.
> We're still collecting data and investigating how it helps us in all the
> potential aspects before upstreaming. My personal perspective on this is
> to replace tcpdump eventually. It's worth mentioning tcpdump no longer
> satisfies our micro observation in modern data center.
> 
> 4. The tendency toward finer-grained observability
> As we're aware that there are already many various bpf scripts trying to
> implement the fine grained monitor of the packets, it's an unstoppable
> tendency for the future observability. We're faced with so many latency
> reports (like jitter, perf degradation) on a daily basis. Getting the
> root cause of each report is exactly what we pursue.
> After we know which request causes the problem, if it belongs to kernel,
> we will dig into the packet behavior with more useful information
> included. This is the process of tracing down the jitter problem.
> Likewise, in BPF timestamping that mitigates the impact of calling extra
> syscalls, breaking the coarse granularity into smaller ones is a first
> good way to go. It shouldn't be the burden like before especially it's
> independent of application.
> 
> 5. Details of the series
> Now it's time to convert BPF timestamping feature into push-level
> granularity by only recording the last skb in each push function, which
> is quite similar to how we previously treat each send syscall.
> Regarding each push function as a whole, we only care about
> the last skb from each push since the skb can be chunked into different
> smaller packets. BPF scripts like progs/net_timestamping.c has the
> ability to trace each tagged skb and calculate the latency:
> 1) delta between send and each tagged skb in tcp_sendmsg_locked()
> 2) delta between SCHED/DRV/ACK. Three timestamps are also correlated
>    with the sendmsg time.
> 
> In conclusion, push-level is more of a compromise approach which covers
> those corner cases and further enhances the capabilities (like a finer
> grained observation of jitter and performance issues).

# push-level design

It it significantly less intuitive than per-syscall, which is under
user control. Or even than per-packet. As a fix for missing timestamps
I understand these two extensions, even with the unintended side
effect of reporting many unnecessary extra skbs in the common case.
As a model to advocate for, less so.

Would it help if all skbs from the same sendmsg() can still be
identified as common from the same syscall? That allows the user
to discard all but the last one (if they wish)


# ABI changes

For SO_TIMESTAMPING we would not be able to make this change
unconditionally as the behavior change would break existing
application expectations.

That is why historically we have guarded new behabvior behind new
TS options flags.

The same may be true for BPF.


# SO_TIMESTAMPING and BPF timestamping differences

A related point is that this breaks the 1:1 relationship between
SO_TIMESTAMPING and BPF timestamping. As said before, I think that
is fine as BPF timestamping can be cheaper. But we should avoid the
two forking in incompatible ways. I suggest that BPF timestamping
becomes a superset of SO_TIMESTAMPING: it must have all features
of SO_TIMESTAMPING, and may offer more.


# Documentation and testing

Please also expand Documentation and include a test.



 
> [1]: Page 29 of the slides demonstrates the picture of skb-level granularity
> https://netdevconf.info/0x19/sessions/talk/the-future-of-so_timestamping.html
> 
> ---
> V2
> Link: https://lore.kernel.org/all/20260402085831.36983-1-kerneljasonxing@gmail.com/
> 1. only handle BPF timestamping feature to cover those issues (Eric, Willem)
> 2. keep timestamping functions inline in send process (Eric)
> 
> 
> Jason Xing (4):
>   tcp: separate BPF timestamping from tcp_tx_timestamp
>   tcp: advance the tsflags check to save cycles
>   bpf-timestamp: keep track of the skb when wait_for_space occurs
>   bpf-timestamp: complete tracing the skb from each push in sendmsg
> 
>  include/net/tcp.h | 20 ++++++++++++++++++++
>  net/ipv4/tcp.c    | 23 +++++++++++++----------
>  2 files changed, 33 insertions(+), 10 deletions(-)
> 
> -- 
> 2.41.3
> 


