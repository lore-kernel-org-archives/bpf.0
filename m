Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38428303C9C
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667423; cv=none; b=AAlsP+x9gIX/xqy8uHI6TwuWincO2KG9hWVnLgdT5lexLX17aXm0LaZbWXyA/+5iBVIpNDZ30QoEl1pxluIpDVluowYr7xOEqtu9l5Bv2zoEvYHevQf5fkLAybQBiRgkP1MPHtMdYrFgmyROdbJXB58DqDzOOGUXar7HmtzB4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667423; c=relaxed/simple;
	bh=3CT2z620rf2EyjaSWmGg2tRgTSPfnmVmEtSzd5fK6cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTq8QEzG03BzQiCttkz1ch+Crye0OBv9X9LvT+QR165qqT1g9btR6QnIuylDupboLUqWi5ow9E3gVPQ9F48fdjZ+KxLvsUZoUUqY0hi5n5/TjmMmRkwDzMvS9KYI4egAJ8TUhOUACVNyOLQpDrSPfIlAQY9up1fcAJZDmFjQTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wdQ6v53i; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wdQ6v53i"
Message-ID: <9da94ca2-a479-42e2-8941-b38c1a08566b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781667419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2UPW9kkwGh5wpDgrLNe8OYP2oXRcB9R26cFMQbJWnA=;
	b=wdQ6v53i0T/kFiN5+0oK1L8fu4Q2DOzeMJsubj4iZDEAlsoKyCAH/A87B0MWUHdK2aBJX8
	6qxZlFkwAKumXbNTCel4Utnz7i0Gyb76E+czkksNiUm0AlSfXrjReIa+hIQiUyXIWwX8Rw
	9UqBA+NVCMXKxwgoLliAg/o9zHA09WE=
Date: Wed, 17 Jun 2026 11:36:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
To: Paul Chaignon <paul.chaignon@gmail.com>, Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>
References: <20260613183424.1198073-1-jordan@jrife.io>
 <ajAXF8Nvg91xU4f2@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <ajAXF8Nvg91xU4f2@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/15/26 11:15 PM, Paul Chaignon wrote:
> On Sat, Jun 13, 2026 at 11:34:04AM -0700, Jordan Rife wrote:
>> We have several use cases where a pod injects traffic into the datapath
>> of another so that the traffic appears to have originated from that
>> pod. One such use case is a synthetic flow generator which injects
>> synthetic traffic into a pod's datapath to enable dynamic probing and
>> debugging. Another is a transparent proxy where connections originating
>> from one pod are redirected towards another which proxies that
>> connection. The new connection is bound to the IP of the original pod
>> using IP_TRANSPARENT and its traffic is injected into that pod's
>> datapath and handled as if it had originated there. This can be used for
>> mTLS, etc.
>>
>> We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
>> flow generator, etc. towards the target pod, ensuring that eBPF programs
>> that are meant to intercept traffic leaving that pod are executed.
>> However, this doesn't work with netkit.
>>
>> With netkit, an ingress redirection from proxy to workload skips eBPF
>> programs that are meant to intercept traffic leaving the pod, since they
>> reside on the netkit peer device. One workaround is to attach the
>> same program to both the netkit peer device and the TCX ingress hook for
>> the netkit pair's primary interface, but
>>
>> a) This seems hacky and we need to be careful not to run the same
>>     program twice for the same skb in cases where we want to pass that
>>     traffic to the host stack.
>> b) We're trying to keep the proxy redirection / traffic injection
>>     systems as modular and separated from Cilium as possible, the system
>>     that manages netkit setup and core eBPF programming.
>>
>> It would be handy if instead we could redirect traffic directly from
>> one netkit peer device to another. This patch proposes an extension
>> to bpf_redirect_peer to allow us to do just that.
>>
>> With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
>> the skb in the egress direction of the target interface's peer device
>> While the main use case is netkit, I suppose you could also use this
>> mode with veth as well if, e.g., there were some eBPF programs attached
>> to that side of the veth pair that needed to intercept traffic.
>>
>>   +---------------------------------------------------------------------+
>>   | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
>>   | | pod (10.244.0.10)       |           ------------------------      |
>>   | |                         |          |                        |     |
>>   | |              +--------+ |          |      +---------+       |     |
>>   | | 1. packet -->|        | |          |      |         |       |     |
>>   | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
>>   | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
>>   | |           |  |        | |          |      |         |       |     |
>>   | |           |  +--------+ |          |      +---------+       |     |
>>   | |           |             |          | 2. bpf_redirect        v     |
>>   | +-----------|-------------+          |___________________   +-------|
>>   |             |                                            |  | eth0  |
>>   |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
>>   |             |________________________                    |          |
>>   | +-------------------------+          |                   |          |
>>   | | proxy (10.244.0.11)     |          |                   |          |
>>   | | IP_TRANSPARENT          |          |                   |          |
>>   | |              +--------+ |          |      +---------+  |          |
>>   | | 3. packet <--|        | |          |      |         |<--          |
>>   | |    enters    | netkit |<===========|======| netkit  |             |
>>   | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
>>   | | 4. packet -->|        | |                 |         |             |
>>   | |    leaves    +--------+ |                 +---------+             |
>>   | |    sip=10.244.0.10      |                                         |
>>   | +-------------------------+                                         |
>>   +---------------------------------------------------------------------+
>>
>> Using the proxy use case as an example, in step 5 we would redirect
>> traffic leaving the proxy towards the pod's peer device using
>> bpf_redirect_peer(BPF_F_INGRESS).
>>
>> As a bonus, since the skb doesn't have to go through the backlog queue
>> it can take full advantage of netkit's performance benefits. I set up a
> The motivation makes sense. Cilium could probably use this as well to
> avoid some of the hacks we have around proxy reinjection.
>
>> test where outgoing iperf3 traffic is injected into the datapath of
>> another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
>> bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
>> which skips the host stack and uses BPF redirect helpers to do all the
>> routing.
>>
>>    (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
>>     eBPF host routing mode)
>>
>> BASELINE [bpf_redirect(BPF_F_INGRESS)]
>>    1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
>>    2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
>>    3. eth0        ==over network==>                         [host b]
>>
>>    [ ID] Interval           Transfer     Bitrate         Retr
>>    [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
>>    [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver
>>
>> TEST [bpf_redirect_peer(BPF_F_INGRESS)]
>>    1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
>>    2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
>>    3. eth0        ==over network==>                              [host b]
>>
>>    [ ID] Interval           Transfer     Bitrate         Retr
>>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
>>
>> In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
>> [iperf pod] to [pod b] led to ~18% more throughput compared to
>> bpf_redirect(BPF_F_INGRESS).
>>
>> Note: I wasn't sure about the flag name. I can see where BPF_F_INGRESS
>>        might be confusing, since technically it's an egress redirection
>>        from the perspective of the peer device's namespace. But, I didn't
>>        want to add a BPF_F_EGRESS flag just for this and convinced myself
>>        it makes sense, because from the perspective of the caller the skb
>>        will be flowing towards the current namespace.
> IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
> can't have the same flag API between bpf_redirect() and
> bpf_redirect_peer(), but this is creating inconsistent semantics for
> the terms egress/ingress across the two helpers.


Agree.


For the existing bpf_redirect_peer(ifindex, 0), there are two ways to 
read what 0 means:

1. If we consider the operated object to be the peer of ifindex, then 0 
means the peer does ingress.
2. If we consider the operated object to be ifindex itself, then 0 means 
ifindex does egress
    (which results in its peer doing ingress).

This patch's new mode operates on the peer — on the host side, we want 
to "write" to the dev inside the pod to
make the packet look like it leaves the pod. That fits reading (1), where
the flag describes the peer's direction: 0 is peer ingress, and this new 
mode is peer egress.
So BPF_F_EGRESS would be the clearer name; reusing BPF_F_INGRESS for 
what is really a
peer-egress action is what creates the ambiguity.


