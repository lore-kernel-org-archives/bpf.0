Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF253DD53B;
	Wed, 24 Jun 2026 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323642; cv=none; b=fo9auIU0ozEquh5U8/plu7j4FalG8S/Wg+kqEkQ0QSXB4wXyn+2W/ltfsgr7pYx2RZ6MYH0Jgv1lBjtt6wO0uuNwPP9yCNgdYAbTTA/vum8bDFX0IgvunXnQ3LzlMBskybw84dICOyOwYKtmVd5VtPx9cWOD6vtjR4ibNk3f5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323642; c=relaxed/simple;
	bh=lzb8x3aWv1Ia99rUw2Kbf2lIRlZWgK9AkQlGR5zM2So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqNkqi9vxxMYCFVWfaqAdwUdfSYAxYKEzy4VeH/YvU2RCE8J0Uo2a1/8oNB0w2UOh6xtuVBa8hrYFHzaDiCnMjFAOpe2m2cFKNJTtmBHfLFmlHvyfFym3GSq2ULvK41f5WMtpanUDAW543EWJt4045MxK8zHqsXXmp1TTXl8Ujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FYV5/wbb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FYV5/wbb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zTtiTHPvq+207PbuFOrMvlu3JspgF5HOFyx68riruM0=; b=FYV5/wbbmKYg3sGdJEHDwWrcAr
	rrM8MqaemumDnV++FOEkcMA8ykytWnwMqO0sESO3CFoSHzlBOWZFDSdYRat0TvW6noTAiolio0mAV
	ZmfnrqukwmblnIT3Vp3OGWgET0Tf9lIzZcBw6FGPdrwDrvl/vDEe4qNGCTGU8Tdbel6ri9A6cBhov
	8Z1gx/JIYAGd/OSpWY2+eElUA0PBJnrCffRH+qf0YEpo8791UWQ7gqmwjcZSQ+rX/5TNZHbABynPK
	SDWvUy5xfbxkHEd4RAC4XHzLuG5UL/I5UTyKPDd63Kl17XbbXOTwDxl1koe4PxWdsPgkWq2ucG4R/
	vVV4Z2Kw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcRnO-000Odm-2c;
	Wed, 24 Jun 2026 19:53:54 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcRnO-0000FP-0C;
	Wed, 24 Jun 2026 19:53:54 +0200
Message-ID: <ca79d73d-a01c-407a-aef4-e41c931aed82@iogearbox.net>
Date: Wed, 24 Jun 2026 19:53:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support BPF_F_EGRESS with
 bpf_redirect_peer
To: Jordan Rife <jordan@jrife.io>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 Paul Chaignon <paul.chaignon@gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-2-jordan@jrife.io>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260618182035.43811-2-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28041/Wed Jun 24 08:24:54 2026)

On 6/18/26 8:20 PM, Jordan Rife wrote:
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
>     program twice for the same skb in cases where we want to pass that
>     traffic to the host stack.
> b) We're trying to keep the proxy redirection / traffic injection
>     systems as modular and separated from Cilium as possible, the system
>     that manages netkit setup and core eBPF programming.
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
>   +---------------------------------------------------------------------+
>   | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
>   | | pod (10.244.0.10)       |           ------------------------      |
>   | |                         |          |                        |     |
>   | |              +--------+ |          |      +---------+       |     |
>   | | 1. packet -->|        | |          |      |         |       |     |
>   | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
>   | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
>   | |           |  |        | |          |      |         |       |     |
>   | |           |  +--------+ |          |      +---------+       |     |
>   | |           |             |          | 2. bpf_redirect        v     |
>   | +-----------|-------------+          |___________________   +-------|
>   |             |                                            |  | eth0  |
>   |             | 5. bpf_redirect_peer(BPF_F_EGRESS)         |  +-------|
>   |             |________________________                    |          |
>   | +-------------------------+          |                   |          |
>   | | proxy (10.244.0.11)     |          |                   |          |
>   | | IP_TRANSPARENT          |          |                   |          |
>   | |              +--------+ |          |      +---------+  |          |
>   | | 3. packet <--|        | |          |      |         |<--          |
>   | |    enters    | netkit |<===========|======| netkit  |             |
>   | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
>   | | 4. packet -->|        | |                 |         |             |
>   | |    leaves    +--------+ |                 +---------+             |
>   | |    sip=10.244.0.10      |                                         |
>   | +-------------------------+                                         |
>   +---------------------------------------------------------------------+
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
>    (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
>     eBPF host routing mode)
> 
> BASELINE [bpf_redirect(BPF_F_INGRESS)]
>    1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
>    2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
>    3. eth0        ==over network==>                         [host b]
> 
>    [ ID] Interval           Transfer     Bitrate         Retr
>    [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
>    [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver
> 
> TEST [bpf_redirect_peer(BPF_F_EGRESS)]
>    1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_EGRESS)==> [pod b]
>    2. [pod b]     ==bpf_redirect_neigh([eth0])==>               eth0
>    3. eth0        ==over network==>                             [host b]
> 
>    [ ID] Interval           Transfer     Bitrate         Retr
>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
> 
> In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
