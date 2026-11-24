Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509592;
	b=yV4fu4rMjUFbX1bEdWh8FIiw+9t7K0Sxn8zhnngeiai1F+IQzT4Jw6AhxwdPyFOmcDL1
	 jzqFwanXOWO9ePL1MwdsLB+H4IEPp98hkwEBLhyOyronHbh3F4tAnxAsNcBsfO0100ivG
	 xU4CqDUrYH3RqP4CgsSpG7rMhtgYOdSOxrfu3BXR0vJolF6A4DhMY/GBNgXQ47Byxc0SR
	 tNsRvy+s5kJXW2c5c56w3xlo1Mp5Thqp6GoFr8AdmHdl8B+RzXP7Sb6MLJVc4pxKAfOfy
	 P3Kvt5K6q0fxzgypRcImn2BMS3tyzmao9nN3TGOgnqS3qB5jydEHn88DMgZHYR01wzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZrV3PsIVthQWvR94PJOjcLJ8y8KziKokZCXJS0PC7Ck=;
	b=rCtAMwJvAoI9uPxPjG3iQGq1dKRvlv5abzONZcGrwPybtHmkJzWhVmyhZR1hVdvl2RYa
	 IBivRoYh1YxtOk/96zbKsxfmEuPu3AvRARBj1vc5tqK/o75D1UZEdljm4WuDig4zxCRLU
	 Ayvw9kbAN8ZmeBzwpJ8InrMZYuxEpeOsYheOW6okG5EANo+V7qHOi1fXxLpvgJYpnTP7z
	 2NEVmPm3+hjtT7YnrDUh8Lfdypm29P59XqyZLjoDMTUigiPCLviDeh0fbvN4DakE8urYj
	 iQ9Y1QOr61aPFTBWEJcT1DNZ0Ra6GEZLQ++w6AKaDveD80TEXKg7rvlEZiS6AXViPKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YdT+6NAZ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4E606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 08:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE4E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=YdT+6NAZ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so4012356f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795509590; x=1796114390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZrV3PsIVthQWvR94PJOjcLJ8y8KziKokZCXJS0PC7Ck=;
        b=YdT+6NAZdu89kXGvVdYfI1paVgPLnZM/MDU4MbGkFqcJMCJDH2xOp8f+0Lrw5l7cq4
         +Ro+KhuJRmBjFpVNiWxfEWFi3tl9Z6mEZ/0Lhg2+eVCeftjZUjHs8tJ5381Ttg3Vo8iL
         f32MW6AAwDpO+c3Ib1Iy+sH+d7AfKhqRFGrwDPjjnimXGP/ZPQvq2bktZ1ZSNHrgkoHV
         0tjox3jufzNg3/ajK+oq/awp091RMYStiLBc0+zfbKRkJR/zkjiSgyu7/nrwmaTVBn/b
         MdfuY4QUKIYGm/ODGmKO7wAVKql1FpkSiK8dwlX0c4Bd66v3s+Q+2yOxE+qYZWkqAonv
         8thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509590; x=1796114390;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrV3PsIVthQWvR94PJOjcLJ8y8KziKokZCXJS0PC7Ck=;
        b=MFl7WWF0GOz/79q7SGS5deaR3ZsdiPfSEo2LF3F45DwqbG1/VnaEmiwowVUoQLEgei
         TEq4qi5yg/5cuVAb/ga/DHyA/I5Bjow84GjkbjwDpCqAyP0rANyhzPIJ9RxXSQqW4LUn
         CCLw+1C9McnReaWEEsRYqrpUx99NTtk3fv7J5XforXoN//4hEOIYjK+DDUf3UqES7xIm
         JAJBHb7bIJ20K672PaZX5QhXpQItrhX9MTLoSzKEjSDYg1P3kwct/AcU6nf1Ie+B7WTW
         OFMoUvurbP2nT25Hb7ffsLpV+t9KSD3TTl3loUdHAgqpgw7PFDge9ywNG4Ref+PBdHfP
         H46A==
X-Forwarded-Encrypted: i=1; AL+hErHkIIVvvr50Aor5nA7HHmvb5S2JbPOaqn1i++S7/OIXriaT9ApAtUTyXEKvkq29BizgDlA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HoezYDMNXhVMzjApxCLRBcFZJGTFTjLTdbCBlJNRdbzpzqMhl
	T9A2L+6WdaSmPLosdlT7GAV7dMNGUnXmfo9sh3nccKk5wGYpTXep1B9Q3ql6A7QXkRKyjdsoqig
	TL7k0UC7HAA==
X-Gm-Gg: AZFdTZft0kdG5aTCegq2dkvQtxBvgcs5VWAHibF29rmLFbfKhhK1FBPNreiKuKmX8r4
	NtsQsRbB35VJQcjEr4meuLqMj3qLnRDW9w2PJbwt8YjXuQ9H8ADNdzkZOm69RWk1d47fZhFg0/Y
	egCIFgEH2i6HfrQTo0AvX/QQC0ak2ibtANV3QBS/wv/w65UTxHv0OycdLTnREY9tM5Ea/Fj5TYH
	EdBDweotIyytPWKbYMnFhCBLOc+t0G6B/KuWkrcuk6dxc97BhpE4mftspy7BE33oG0cP0+0ZwM9
	4wPC3veBQS0NguHmYJfj1HK1Pq1WMRnJy+QujXw3WIp6q1Xx8ugnJMom1bz8hff7Bby+saMKOk/
	8aop11mh7W4LiTuB96U5rQUAIOxFlFOmfHuhnoGf75QO9JSEiYgfVgr+kPoB8jtHcVvM+g0eWQR
	7D5SGVJp2RZy5W/Kd63HzI6gbY1yhyCCmLtw/W90Zyhdp9VtzSvU7zsW3DoBZIyh1LnMDS/3FjY
	WgcklnAuKo4y0d9RrG/+PPsyXnsh3uvzi2M3oRxIhbVsjposFuMvqpOEiwoZUus3e6jbHhAYRpN
	0NMpL4bJMr7E8d0aWpMldDUe+tHFmhEGEfwUFAULa5cyYrGu4CXKvkMe1Ac=
X-Received: by 2002:a5d:64c9:0:b0:4b3:f000:1bdc with SMTP id ffacd0b85a97d-4b3f0001c13mr8456154f8f.45.1795509589524;
        Tue, 24 Nov 2026 00:39:49 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b9add26sm26878482f8f.44.2026.11.24.00.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 00:39:49 -0800 (PST)
Message-ID: <38460544-04f5-41e0-b267-39c155bb08bb@blackwall.org>
Date: Tue, 24 Nov 2026 10:39:47 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: keep skbs with a prefetched socket out of
 gro_cells gro
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 kafai@fb.com, joe@wand.net.nz, daniel@iogearbox.net, bpf@vger.kernel.org
References: <20261121160204.4024204-1-razor@blackwall.org>
 <179548941922.3135.9577858774980848901@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179548941922.3135.9577858774980848901@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/11/2026 05:03, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete.
> 
> --
> 
> net: keep skbs with a prefetched socket out of gro_cells gro
> 
> This patch makes gro_cells_receive() send skbs that carry a prefetched
> socket from bpf_sk_assign() to netif_rx() instead of the GRO cell. The
> goal is to stop GRO from clearing skb->sk and skb->destructor on merged
> skbs, which leaks one socket reference per merged skb.
> 
>> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
>> index 31352cac355ce..4e8b9c3cd7da0 100644
>> --- a/net/core/gro_cells.c
>> +++ b/net/core/gro_cells.c
> 
> [ ... ]
> 
>> @@ -26,7 +27,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>>   
>>   	skb_unset_transport_header(skb);
>>   
>> -	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
>> +	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev) ||
>> +	    unlikely(skb_sk_is_prefetched(skb))) {
> 
> [Severity: High]
> Is matching only skb->destructor == sock_pfree enough here? An skb that
> got its socket from bpf_sk_assign() can still reach gro_cells_receive()
> with a different destructor that owns one sk_refcnt reference per skb.
> 
> One path: bpf_sk_assign() at tc ingress attaches a non-refcounted socket,
> such as a TCP listener or a UDP socket. It sets sock_pfree and takes no
> reference. ip_rcv_core() keeps it. Then an NFQUEUE rule matches the outer
> ipip/gre/esp packet, and __nf_queue() converts it:
> 

Oh well the bot seems right even though it's a weird case, I'd suggest to change
the check and orphan on any skb->sk set, i.e.: || unlikely(skb->sk)
instead of unlikely(skb_sk_is_prefetched(skb)), that is cache hot too as
skb->dev is read before and will catch

Also tried asking an LLM if I'm missing something and the only case it could come up
that will not be aggregated is:
"the only correct aggregation that's lost is software ESP over veth or netdevsim in tunnel mode"
IMO that is ok.

What do you think?

> net/netfilter/nf_queue.c:__nf_queue() {
>      ...
> 	if (skb_sk_is_prefetched(skb)) {
> 		struct sock *sk = skb->sk;
> 
> 		if (!sk_is_refcounted(sk)) {
> 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
> 				return -ENOTCONN;
> 
> 			/* drop refcount on skb_orphan */
> 			skb->destructor = sock_edemux;
> 		}
> 	}
>      ...
> }
> 
> After an NF_ACCEPT reinject, the packet is decapsulated. With !xnet,
> skb_scrub_packet() does not orphan it, so the skb arrives here with
> skb->sk set and destructor == sock_edemux. skb_sk_is_prefetched() now
> returns false, and the skb is queued for GRO.
> 
> skb_gro_receive() then clears both fields on each merged skb without
> calling sock_edemux():
> 
> net/core/gro.c:skb_gro_receive() {
>      ...
> 	/* sk ownership - if any - completely transferred to the aggregated packet */
> 	skb->destructor = NULL;
> 	skb->sk = NULL;
>      ...
> }
> 
> The frag_list merge path in the same function does the same thing.
> gro_list_prepare() still allows the merge because p->sk == skb->sk.
> 
> Wouldn't each merged skb then leak the reference that __nf_queue() took?
> That is the same socket and netns teardown leak described in the commit
> message.
> 
> The tree already has a general rule for this in skb_prepare_for_gro():
> 
> include/net/sock.h:skb_prepare_for_gro() {
> 	if (skb->destructor != sock_wfree) {
> 		skb_orphan(skb);
> 		return;
> 	}
> 	skb->slow_gro = 1;
> }
> 
> veth_xdp_rcv_skb() calls it before napi_gro_receive(). Could
> gro_cells_receive() divert or orphan any skb that still has skb->sk set
> with a destructor other than sock_wfree, rather than checking for
> sock_pfree only? Checking skb->sk directly would be one way to do it.
> 
> Separately, the "sk ownership - if any - completely transferred to the
> aggregated packet" comments in skb_gro_receive() look wrong for
> destructors that hold one reference per skb (sock_pfree on refcounted
> sockets, sock_edemux, sock_efree).
> 
>>   		res = netif_rx(skb);
>>   		goto unlock;
>>   	}
> 

