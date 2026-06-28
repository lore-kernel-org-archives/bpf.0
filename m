Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE283B8D40;
	Sun, 28 Jun 2026 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683983; cv=none; b=FxmM7d4XYXImiQ+UNM9OYM/wcSW17ckd1U6BT9qjpqrjzmb4az40rZsN8fWzle4lOIkjFlHJHCLmMVLuCWBn4zMNJ4xcp7qu4KWPYPbiMSIM22AYPtutbYOCxp/hRJ3IcpWaWzmtFDbrxh83SRdaHoF+mTx1wxAiZKm8Rn7Ffkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683983; c=relaxed/simple;
	bh=t2sMTNUbxD4BknlcrTMpWc4SMcLbIGXrma4CzOJVaWI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kWQg0vLYuXA4zjKfo2W0oooKusfqJfmh6LGRrLCuqbtdPo0wOvtsvlu7vcYfKJBSloVzx7krmS1advjVwI9d8iozoMRwbblxXVpmZEXSbdjiDGfLeHSDQ8Y13gdD6WUJuxct1tNYhY1Q5JayaIzV2ZMgOmwVnbpRsVNM47uxBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=RXCF0CAP; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="RXCF0CAP"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wdxXQ-001ZMg-30; Sun, 28 Jun 2026 23:59:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Huq7o+X/3/jMiP4VYmjn9/eydGCayTj3Mb+IM0OaK4w=; b=RXCF0CAPXKlGI5A4Yqx6tF0OlK
	ZCqFYbb77AJkJ2QolHT6+H0XB3DQ0PgwHhHluqMQfPHVviYa38xuACMeXEBcVWK5ijzyGu0iuHQx9
	uhAU0V/5gRFaXJSgj9lydtnRVHjOdXQCcvn3pvlmMokdsxgCPMX5fyaQqmEzr63S4gyVKxHZVZFJZ
	ejBtTVRRJhJ1Gw1FvvdnFq8k3xlZuqqq2SfJ9w3P0WZghuI5ss2cZhqhKJ01TjcYDOPcHN8wrS4Rx
	gVtWgkZV3VhJ8HZg9F3O3aXZCTt9EkUTLNxOqrVd1CECebyaJkfNM+7vIhHQQezkmRLqYE+0IadZb
	isqZb1gg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wdxXP-00060f-RW; Sun, 28 Jun 2026 23:59:39 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wdxXN-00DEJc-Qo;
	Sun, 28 Jun 2026 23:59:37 +0200
Message-ID: <e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co>
Date: Sun, 28 Jun 2026 23:59:37 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
 <20260626205814.BAC3C1F000E9@smtp.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20260626205814.BAC3C1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 22:58, sashiko-bot@kernel.org wrote:
> ...
> [Severity: High]
> This is a pre-existing issue, but does this leave TCP sockets susceptible to
> the exact same state-transition leak?
> 
> If a TCP socket is held by a BPF program in TCP_ESTABLISHED state and then
> transitions to TCP_LISTEN, inet_hash() unconditionally sets SOCK_RCU_FREE:
> 
> net/ipv4/inet_hashtables.c:inet_hash() {
>     ...
>     sock_set_flag(sk, SOCK_RCU_FREE);
>     ...
> }
> 
> This dynamic state change would cause bpf_sk_release() to evaluate
> sk_is_refcounted(sk) as false and skip the refcount decrement, leading to
> a memory leak similar to the UDP case.
> 
>> +	if (sk_is_udp(sk))
>> +		return sk_hashed(sk);

Right, TCP sockets can leak in a similar fashion.

unreferenced object 0xffff88810544b400 (size 3200):
  comm "softirq", pid 0, jiffies 4299372426
  hex dump (first 32 bytes):
    7f 00 00 01 7f 00 00 01 48 40 f2 e3 00 00 00 00  ........H@......
    02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace (crc 82faf8d5):
    kmem_cache_alloc_noprof+0x53e/0x640
    sk_prot_alloc+0x69/0x240
    sk_clone+0x79/0x1200
    inet_csk_clone_lock+0x30/0x760
    tcp_create_openreq_child+0x34/0x2740
    tcp_v4_syn_recv_sock+0x12e/0x1080
    tcp_check_req+0x447/0x2310
    tcp_v4_rcv+0x1026/0x3c90
    ip_protocol_deliver_rcu+0x93/0x340
    ip_local_deliver_finish+0x356/0x5c0
    ip_local_deliver+0x184/0x4a0
    ip_rcv+0x4f4/0x5b0
    __netif_receive_skb_one_core+0x153/0x1b0
    process_backlog+0x28d/0x1190
    __napi_poll+0xa7/0x520
    net_rx_action+0x3f0/0xca0

But I guess that's a material for a followup series?

> [Severity: High]
> Could a memory ordering regression here allow unbound UDP sockets to still
> bypass this check?
> 
> In udp_v4_get_port(), the flag and hash are set:
> 
> net/ipv4/udp.c:udp_v4_get_port() {
>     ...
>     sock_set_flag(sk, SOCK_RCU_FREE);
>     sk_add_node_rcu(sk, &hslot->head);
>     ...
> }
> 
> Because these stores lack a memory barrier between them, could sk_hashed(sk)
> return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
> the leak to still trigger?

I'd like to verify it on a weakly-ordered CPU; please give me a day or two.

thanks,
Michal

