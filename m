Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8F4F205
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287592; cv=none; b=TOB85i8KYSM0N6cEUOaUL3zG+NlKB4PbBvAQ2u3waeo4h+Xk1VzxlazzbSLGW9N91iUm7gx1twG8n26eaaSBukzsPIYxEwEhDNcLSlNKvi20pB7vgkgRwCCRefwEPG+6jNiaoqdzuzlHZmqACeXHeyMO/Xf3OmpFHkh6HE0eB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287592; c=relaxed/simple;
	bh=2Ql1pouZHlKg1FTlweC7vW/fpZtUlaBTyah42JkgvpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUPKPT3YmgQ3Z0pwggKdIJOgOByMU+dJJTdj62ergRfU6Ip9mrvnFCcqq69LEl64UL+zqf/81ZWL+MvoYlZsSMidOE8OvkKBDK0rWzf3nXKa+RE0BrA4piY+Tg5+8ZlnmoCpfOx1svO1EVkFnzOmkh7d6fhUtCgwxAjxQy+MO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ncLNkFzU; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ncLNkFzU"
Message-ID: <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710287587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLl+NDi9Pq4wqH+MIJSBbYaoK01Y8BsOP+TM5utTVpg=;
	b=ncLNkFzUrhOaHVCuetngKJyq2z+07yW3B+q9MY6A2QQI5gVMsmzHqfmeoinY2JTZJjFOli
	k3bhhs7QMPqrjJ+YRqQNMyPZbzf+Ji2ryUAFRRUJPzm0GCoDbu7yIh3ISYjTh2rFWfzBCj
	jRms52n2CL8fvPznonqB6DuFidhUx88=
Date: Tue, 12 Mar 2024 16:52:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/1/24 12:13 PM, Abhishek Chauhan wrote:
> Bridge driver today has no support to forward the userspace timestamp
> packets and ends up resetting the timestamp. ETF qdisc checks the
> packet coming from userspace and encounters to be 0 thereby dropping
> time sensitive packets. These changes will allow userspace timestamps
> packets to be forwarded from the bridge to NIC drivers.
> 
> Setting the same bit (mono_delivery_time) to avoid dropping of
> userspace tstamp packets in the forwarding path.
> 
> Existing functionality of mono_delivery_time remains unaltered here,
> instead just extended with userspace tstamp support for bridge
> forwarding path.

The patch currently broke the bpf selftest test_tc_dtime: 
https://github.com/kernel-patches/bpf/actions/runs/8242487344/job/22541746675

In particular, there is a uapi field __sk_buff->tstamp_type which currently has 
BPF_SKB_TSTAMP_DELIVERY_MONO to mean skb->tstamp has the MONO "delivery" time. 
BPF_SKB_TSTAMP_UNSPEC means everything else (this could be a rx timestamp at 
ingress or a delivery time set by user space).

__sk_buff->tstamp_type depends on skb->mono_delivery_time which does not 
necessarily mean mono after this patch. I thought about fixing it on the bpf 
side such that reading __sk_buff->tstamp_type only returns 
BPF_SKB_TSTAMP_DELIVERY_MONO when the skb->mono_delivery_time is set and skb->sk 
is IPPROTO_TCP. However, it won't work because of bpf_skb_set_tstamp().

There is a bpf helper, bpf_skb_set_tstamp(skb, tstamp, 
BPF_SKB_TSTAMP_DELIVERY_MONO). This helper changes both the skb->tstamp and the 
skb->mono_delivery_time. The expectation is this could change skb->tstamp in the 
ingress skb and redirect to egress sch_fq. It could also set a mono time to 
skb->tstamp where the udp sk->sk_clockid may not be necessary in mono and then 
bpf_redirect to egress sch_fq. When bpf_skb_set_tstamp(skb, tstamp, 
BPF_SKB_TSTAMP_DELIVERY_MONO) succeeds, reading __sk_buff->tstamp_type expects 
BPF_SKB_TSTAMP_DELIVERY_MONO also.

I ran out of idea to solve this uapi breakage.

I am afraid it may need to go back to v1 idea and use another bit 
(user_delivery_time) in the skb.

