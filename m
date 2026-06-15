Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07C40243D
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536543; cv=none; b=fW3Zc7p81kmliR0NyxQvf06fmaRa7iYPvaqJT/0dYv/jCq3cN8Uz+/HXpUmL6dexqGEmEn+slD3nVPOC1pLPbenA3G/GX8btA8jIoeWZrStl5EZeQmYGOcO0eOJGdPUGjTVYyCXzvSc7yw8bAYiS89gQVGHeGZ9e7iU2RLT7BVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536543; c=relaxed/simple;
	bh=L4pAGtHfLq3VAcz6DEuvZqfESh3HFAcYxo5zdcfmsOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy7P8qVG/d8+koaR5sozbFiq4NBzAoO6wXJGCKQPwB57LZY254QQq6zbUkUyYzDuweKIYSCsw2Qf/dzU7kQimc+HobuQCFV9P7hximDUWhhHSsHlQQRQdsoCjkyi/TNTkMTV3ZZIxQakC5yTft31ETLcnFGnE/g3qd5upGVB3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPPL6peT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPPL6peT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b9318997so25139565e9.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536538; x=1782141338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFEbBl2In0eA69OX+ycS9WcHidui4es5vXgLSbxb9jc=;
        b=FPPL6peTeSWqt0OVku3yve2nUvwoa3JMMMh/aZKPoJezsbAu7dE0ZFcp8AcB05gUQy
         kD9xcijd2V4bIMFgDGg8BKyzxBQtMZ24/ZB+ZZpEi7iTHWaL8mS44tTOtn4hCt/hFVWL
         XG5Ma/ghrDw6t6w2qcoM6Na9uiyBNIcyTV7DEwlQ3CetI81enD7k7cK+/eEwUe5ObxDh
         A4itPiY6MZMUtJnC+rs9q/vYoaRZqw9qyxA5cv5JVfFDK6WVRzLx4l55hdMXk1sKtk1u
         /1K/2OyJ1DBQlDheoH0DaV3hPiM83LgCqhs1q/LeYvaIs9JDYQ7nVMgQA81uBiljH2w+
         CEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536538; x=1782141338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFEbBl2In0eA69OX+ycS9WcHidui4es5vXgLSbxb9jc=;
        b=aL8i8vVzgkHYWvOtc6FXgq6Acj9wcF/oLCchgGo5YkhXyDtlTX9bEZLZxAfEvg3xzc
         h/nhAFhTVVcB2kONhqKfqyMy15Ppt+CT2ILHVDrljd5fjLX0KEwGI5Y7AACFJaKwyC8m
         yaa5NMZAMpbSkLjw1MliC6gDw9BifPssWj1Itc+LfGVqX0B72zpt4gt36c6R/R+Rf0XT
         nWNExi27rBX3VApaf36boPEu2PuWt20kDConBklef95+J3AwlsCUulA94MN/cym9/Nlh
         wdtOoEJEP23+lwOw+j5e+bPlxLQuHaYCjMEQsK4tZTcLNmauoH7UDJT1ocumJP0VSnqQ
         Zdfw==
X-Gm-Message-State: AOJu0Yy7oM5JIvL/DLQ1+4cdjhIZLAc9FfT+fWEjtSAMh0gCfJTm5V1u
	K0A8m4lOMuWV1zhr/TvAJ9nFYNy+4A8zaOOpD+hN71yRGCkIg2sLZuMF+bnBKpAt
X-Gm-Gg: Acq92OHCur/JvQA2re7Z4SEjB8/O4GHFzGOCPYYFFodJqHwfLieDogs1LilGMRmgirD
	f+iU7qfkk1CihkXbK4p70LePWSMV/E1Yw80k/aw89yvNakrWBtm9s2eSvv5xl4BDPxMRdRdv4Tz
	DO6yughJNq/fOWT5ySI/8rDMDtxwYBinWIlmdYOz6ejcGsmY7X2LlCn6v8ZKaq6NRkXW9FIIadn
	852+SEezPS2VYlAfL3KneCVkA0Amefm6o/48lskOqaWP6K7s1J9Atob2AVOY7RlGeeNxZgTBI41
	PWG9TosNjHnf4ma198uZMu7JYtyMLF/E/XRfWbU3qMg8OjLOKO+WNxxddL7PXEJ0eHVPwmyI0xP
	8/U9qQD2hXANFXHmMMd9yRlSQPmDLPrrvTvrikCVof49INOcg4HVl/MCWXMISEUxXgAPOH72um2
	0cQgVSjGQuZHv2y3XZXI4tsrwJ87BoK15YXRIOHSQmfRgSr4z40i7IR+7YkZ2zVf6hx0JbbQdcY
	n+3faYb4siCKKs8uYHujxLS3XQLU4/hXV7ndvUvW9Li5nC3BVANkHVn5rsL9TJ5bLY2zU+vEQFb
	M4RzwXq0OerpNYq2d2DKdcsHylHVM8/4Xq1zt0NquH8=
X-Received: by 2002:a05:600c:1392:b0:490:a646:9d75 with SMTP id 5b1f17b1804b1-49220091dbemr131573105e9.9.1781536537951;
        Mon, 15 Jun 2026 08:15:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm197508155e9.2.2026.06.15.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:15:37 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:15:35 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Message-ID: <ajAXF8Nvg91xU4f2@mail.gmail.com>
References: <20260613183424.1198073-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613183424.1198073-1-jordan@jrife.io>

On Sat, Jun 13, 2026 at 11:34:04AM -0700, Jordan Rife wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
> 
> We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
> flow generator, etc. towards the target pod, ensuring that eBPF programs
> that are meant to intercept traffic leaving that pod are executed.
> However, this doesn't work with netkit.
> 
> With netkit, an ingress redirection from proxy to workload skips eBPF
> programs that are meant to intercept traffic leaving the pod, since they
> reside on the netkit peer device. One workaround is to attach the
> same program to both the netkit peer device and the TCX ingress hook for
> the netkit pair's primary interface, but
> 
> a) This seems hacky and we need to be careful not to run the same
>    program twice for the same skb in cases where we want to pass that
>    traffic to the host stack.
> b) We're trying to keep the proxy redirection / traffic injection
>    systems as modular and separated from Cilium as possible, the system
>    that manages netkit setup and core eBPF programming.
> 
> It would be handy if instead we could redirect traffic directly from
> one netkit peer device to another. This patch proposes an extension
> to bpf_redirect_peer to allow us to do just that.
> 
> With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
> the skb in the egress direction of the target interface's peer device
> While the main use case is netkit, I suppose you could also use this
> mode with veth as well if, e.g., there were some eBPF programs attached
> to that side of the veth pair that needed to intercept traffic.
> 
>  +---------------------------------------------------------------------+
>  | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
>  | | pod (10.244.0.10)       |           ------------------------      |
>  | |                         |          |                        |     |
>  | |              +--------+ |          |      +---------+       |     |
>  | | 1. packet -->|        | |          |      |         |       |     |
>  | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
>  | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
>  | |           |  |        | |          |      |         |       |     |
>  | |           |  +--------+ |          |      +---------+       |     |
>  | |           |             |          | 2. bpf_redirect        v     |
>  | +-----------|-------------+          |___________________   +-------|
>  |             |                                            |  | eth0  |
>  |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
>  |             |________________________                    |          |
>  | +-------------------------+          |                   |          |
>  | | proxy (10.244.0.11)     |          |                   |          |
>  | | IP_TRANSPARENT          |          |                   |          |
>  | |              +--------+ |          |      +---------+  |          |
>  | | 3. packet <--|        | |          |      |         |<--          |
>  | |    enters    | netkit |<===========|======| netkit  |             |
>  | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
>  | | 4. packet -->|        | |                 |         |             |
>  | |    leaves    +--------+ |                 +---------+             |
>  | |    sip=10.244.0.10      |                                         |
>  | +-------------------------+                                         |
>  +---------------------------------------------------------------------+
> 
> Using the proxy use case as an example, in step 5 we would redirect
> traffic leaving the proxy towards the pod's peer device using
> bpf_redirect_peer(BPF_F_INGRESS).
> 
> As a bonus, since the skb doesn't have to go through the backlog queue
> it can take full advantage of netkit's performance benefits. I set up a

The motivation makes sense. Cilium could probably use this as well to
avoid some of the hacks we have around proxy reinjection.

> test where outgoing iperf3 traffic is injected into the datapath of
> another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
> bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
> which skips the host stack and uses BPF redirect helpers to do all the
> routing.
> 
>   (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
>    eBPF host routing mode)
> 
> BASELINE [bpf_redirect(BPF_F_INGRESS)]
>   1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
>   3. eth0        ==over network==>                         [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
>   [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver
> 
> TEST [bpf_redirect_peer(BPF_F_INGRESS)]
>   1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
>   3. eth0        ==over network==>                              [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
> 
> In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
> 
> Note: I wasn't sure about the flag name. I can see where BPF_F_INGRESS
>       might be confusing, since technically it's an egress redirection
>       from the perspective of the peer device's namespace. But, I didn't
>       want to add a BPF_F_EGRESS flag just for this and convinced myself
>       it makes sense, because from the perspective of the caller the skb
>       will be flowing towards the current namespace.

IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
can't have the same flag API between bpf_redirect() and
bpf_redirect_peer(), but this is creating inconsistent semantics for
the terms egress/ingress across the two helpers.

> 
> Jordan Rife (2):
>   bpf: Support BPF_F_INGRESS with bpf_redirect_peer
>   selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_INGRESS
> 
>  include/uapi/linux/bpf.h                      | 16 +++--
>  net/core/filter.c                             | 14 ++--
>  tools/include/uapi/linux/bpf.h                | 16 +++--
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
>  .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
>  5 files changed, 116 insertions(+), 20 deletions(-)
> 
> -- 
> 2.43.0
> 
> 
