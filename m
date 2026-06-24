Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84E28D8D0
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338337; cv=none; b=HjkFpvI1vS9s01bsnSe1PX9c5JARpBEIj8VDsa89Gi9COPqDa7fPNCGbGMRpKKbF9ioD/BkeV9w1ENJWVkAMClFF2PAKQp5ndKW2ju0BviSWRfSnMQ2SbID0lHtsQ2Np5W06xzSPIdBmwi7GsqDub2N6yH2Jh/2bkHqmW5Y6UyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338337; c=relaxed/simple;
	bh=u6KB/aQRjtRyaDPBAhCjbndKCOsNWyShdAA5uAsRHNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkXbFU6K6Tkone+/FlPxZ7+Rp2uNGCCsstkrOanfO/Dnv6nnA3J4GWdyr0LbUETjFilvD7j+jjWVTkobkI/wRycTCGopmuOIruQaIvK4mm79iN5J4rwVvsNm9AkbG9JaI/vIYgHEPsFiljDn+YV5K07Gm0SP+j0wnBeribMV69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbCTZXP/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbCTZXP/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso16686285e9.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338334; x=1782943134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZBTGaYLCBIBUPlxKggwg9gC0pqSaTNynGlDCKqwrYI=;
        b=gbCTZXP/V8yXX1oaWoENgHYVJ9Ahq2ZZFPUfPXn+FKMKG3FaFidP34s4PCIi1mhWcc
         BNqMnCvxyzxTpQW9Ro/I+2d7huBQWIAKbS+ios6HpzCkl7VQV7SIzVD8aLNdw2qPAFmV
         Lo7B4BxSooDzP2rF7U6u2/hI1qElZulcWRWIKHwGTSA20cY11tWnNGVxCvcXhPtN7zKh
         5BBebvjdS8E7TZt/Ghb+H+pWqQlAT3QXlHL4U4Og3HUVZ+dd1ZIV21fjj0GvdicIqzEk
         ipMGsP5oKdUykcCrDNbgxOHe27AdQONvg6tAXA1wF7zxa1fz9e72u6O5Qxfc+g/rYlBD
         1NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338334; x=1782943134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZBTGaYLCBIBUPlxKggwg9gC0pqSaTNynGlDCKqwrYI=;
        b=CBe+gHZmTTfr/KQ9xmEOLB/9jeVcByM/8QeoRRPJoajRJL5CGEsOJYIQWsdKPjm8xw
         1KuiweU1lR3FmKF4gbHSKOOiWGdql4DuK6dzQ33KB3NOg1aQoO4dsYRjQskRneutwIZG
         jvCvBZpnbTmNYT8ryRyjMBXR6JL+VtJO606E+U16DmKt9Vd8ZGW8h5RdhIl1WL0CthDG
         7SnZD+/IlglnxJtTNPQfuU+WRebwuPsEQOLmhdyYjHvVt038fXbFByi6cMcUHchCeGYq
         X/DC79FsK4Lm/0yEtfHkVRuXRxe5FINq4fUed6Vb2rwaSrVPimxIEy6CX24iSmHTKh+U
         Lx0Q==
X-Gm-Message-State: AOJu0YzIjPLDGhX/0pEMQhStLO2GasCUxw1bmjgXnIprHKiFL+ZN4atf
	GSuxA6xdKbIBz/CJ8brWP+sXf5d98oFQrZxWmJokTkVkBkGxGjXe3Lil
X-Gm-Gg: AfdE7cnFKcsudd5H1Qr5KErx1orDDce2w08CXwiguIahe0ev/AxMi5R9FxIHeYDOdmO
	/zOI00aDEomwDGxV0NkezhkkKCeD+oQbsJDW8Tmju9qdJ2krYIcboEYwdVJ8mMu4J/tkGMpuuVC
	RnJPNNCre9nYVn2C+Bgg+jo4hzv1+NGgj4Gfmxwb5DFEaxRFKsWk2uhBo0wkPSrfDQ2neMYcV57
	KybEK7l5ZBq8jTpbmxa5j2NAsChWBfXeCkrA65PnE3fIe+ZHM2tzaJYBYIN+fFZh6tMuAfk+fvY
	l+igYEzcHserz9xS4uig5bUpXxMxm2ew0MRoiMn5yg+SRYFW0Oo+dGR4SC0NfDxBrwH3KM4lLa5
	2pr5UBj0wXf2UKKzQO8fVnPlevV+KbwkP+mYjlaSLQ+OfvxxTDW2Pr59fOOddfflZMBO+hgX04M
	Adf8d9yzAzdhYPj5yKCHPR0HxvrhmobaeMVggM0yHLFhtt4Eg2DxZSfuRhdCy7GWm7mnmw1cRqT
	fMYmDKZgIm5l6yV41gNtgHHS47H3J6MS9YpbriV8z0ImoSUb3SoIVnNjVkoq8cCa+st7ZYszjpM
	n+xkAwlqUbmzpurnPiWlnjQAdD6XBBec
X-Received: by 2002:a05:600c:1906:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-4926084aa9fmr73761465e9.3.1782338334090;
        Wed, 24 Jun 2026 14:58:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0046ffccb749d01d87.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:46ff:ccb7:49d0:1d87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee018e8sm10741158f8f.11.2026.06.24.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:58:53 -0700 (PDT)
Date: Wed, 24 Jun 2026 23:58:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support BPF_F_EGRESS with
 bpf_redirect_peer
Message-ID: <ajxTGwDo3VLnehWG@mail.gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618182035.43811-2-jordan@jrife.io>

On Thu, Jun 18, 2026 at 11:20:32AM -0700, Jordan Rife wrote:
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
> With this patch, the BPF_F_EGRESS flag tells bpf_redirect_peer to emit
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
>  |             | 5. bpf_redirect_peer(BPF_F_EGRESS)         |  +-------|
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
> bpf_redirect_peer(BPF_F_EGRESS).
> 
> As a bonus, since the skb doesn't have to go through the backlog queue
> it can take full advantage of netkit's performance benefits. I set up a
> test where outgoing iperf3 traffic is injected into the datapath of
> another pod using either bpf_redirect_peer(BPF_F_EGRESS) or
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
> TEST [bpf_redirect_peer(BPF_F_EGRESS)]
>   1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_EGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>               eth0
>   3. eth0        ==over network==>                             [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
> 
> In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

