Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100519;
	b=JbSUCOhmthl4PngFDLj39QSnvWtHdRP5B20a+nrI6MffPhoVAyBfovhE3XDUQo7bUWWh
	 1/m94oGTnxgBjMIaEEck0KS8ZsGbFf1VpXSGnFwF9J4r1IyHQ5L86qFE5dcrWeoMQELmB
	 hLp0IVzST6t5Ng8645plaX51prV22DLeS9F9/yTnNPZLW8/IUMfF5rJ5poXVC10Wf/xoG
	 jDoeHkMgLf26zjDjiIkMBeOpsVyNI/wfOXtS+Vj2z9KMlfRLmEj2zZeY/FLU3Hb6p7q3o
	 zTBu4/YYOEMD55JbJCxd7ihpg2oNv2wE+3fq3gnqgEV21dgIPfYrBbAVz8IeOtsB5Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ladJyEziELjuw48nt/OuAy/002cNOvh4ySWmI+DtB2E=;
	b=N0LBuKEAcL14SRFpe9hW8/FmOmDlxS0R1pt8+vFZ7msGlIt3e7sGCIYICyh2NS+36Kjw
	 z31kOgkQZ1gID1CY9hcQ07aHorbUXM7JYnwJuus671PkurawPVODm3mcw637JatZApg1L
	 COBgATV7zGd8a/QR/z3abWsaIB9UDseQVLHOCjt+kYBprNWkfAxKC4PxKpSJ8xOBYGxEk
	 yjbZ5szvZgtKSH0FRFalpflKP3uh9h+MH27kVIW8WocPgx8wL/tG/igRGPVsQpwKmrL5P
	 yNenWyoPCnYgrI9x01Q3I699NH+Daxf5IK1drLb1OdHvE+rzxIUCmPuMU0D9vtBxpFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=SkUU1AIt;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD39606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD39606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=SkUU1AIt
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c50933bdf4bso262121966b.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795100517; x=1795705317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ladJyEziELjuw48nt/OuAy/002cNOvh4ySWmI+DtB2E=;
        b=SkUU1AItItF/N6hiGBWQ7FphGuRE+NW3JxMHtGYbfsYyAM6qszrjT2Qmjc7EvOeNaQ
         V7xgM1BytlgvOSGTi0ijrxxxj5hUZrPQImqbOHJSEXA4GM0mo3SFhNtlNPIadNcgCs3C
         azIMZ4aLL8nEkUlgO8E9d6mtcYCEX4Ou6L6EQcyej1n09fLncnQO0YONJ32+6IzrDF4h
         Ey8habNg7jQKv2FrUGtX9yonLSPn1j7wFgvTQsNyHxc8aaTfu72Tlk1D/Zg+EeadWqt4
         ArnO7f3k9uBO6pb6Mq3sj3bO0GJfgsYzW51RL9BFptmCox1jfEgyK5DCx06176P7nauD
         46pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100517; x=1795705317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ladJyEziELjuw48nt/OuAy/002cNOvh4ySWmI+DtB2E=;
        b=QNzQFP8Ivzgjr1F57Q/89sX1Q220rmG7Xu7WYbfQq8C6xVjsOf6nMns0UeIq+o64ZT
         CAhiDZspYFPEzDpTwZVqqznZie47KQ64lxFFLa45RwF0v2ZiR/jrwZGz7/FzsKrxwXk/
         fauIKgNYqhiEv/DYjEYc0NUcctP639k3N4ummUGuYdFD0jfFixw4d636Gj5SEBm+GW2r
         +eS9ogYYpWG4ltWjcEYkghB3FrhVRHz3kswIbRrcQNGv8NJJyqfcJH8/gzw8g0V8mkKK
         GMcICNquFg9kVSJU68kjqIh31N5GHPRgjhlGHDjC9cPxL9mE91MbKG1xDYYRQ0cozhuK
         +U1A==
X-Forwarded-Encrypted: i=1; AL+hErHmYl9z/juvbVGEfZ5l2btym2iT2+KSaDX8eBlsAqlKwMy7vsFIdy8W4IeV317KHqFlay4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rcdu2oKPcphUo2Ku+uJNMejRf7g5rG0Vv9VHSSLe6OwVbZmov
	yEpwMOnXxzy1/DfqSjohXOAghjIupil00QR+wTNLU768CP2X05KnHUQm3RCVKH9HF+tJNZMhptU
	qQ25S0SR8wA==
X-Gm-Gg: AYBFou04m02dbROhV/9Iwnh8OLg0Yi/JocG4X8YyVhwddJtSu3fXO7VPdvkaOn0T5BG
	d53zLo40awbi1UtUHsBjrjvFHAToEsAaBkWRi9YtQoBkSYD18l4pdqvXISudQ0AnEGgqgXgnTX6
	LC9DRrxG8bNWPc4wUGwrDgZoPi1DZ0QM1XH4UT95pn1DiIOgZtm2sBs9wRks0jvqCFKoj1InziG
	INmrj8r+VoBnWrncKo81msnT0zBYHggWqJpIjFH7w3kGoRqD7RTigmqO5kxFZYpeMkJsreCs9x8
	16Tec5DPeQrHXalzVKxpZ0rjqL9XbEmZogki+HlSIgIUTyhBiNB5MAqQVvj2VSxbfpNMSaxasih
	ILhUWvzBrs82cLdDtd5ufX0WD73SY1RS7GNNID/Qz8dJJGkHWYrSF5Inzq+G60PELXMyNtt0ZXP
	Iadb69F3YGkN9l4KCmwIRDjhgHp2ASZk1bUQGYtFAQnKEW8Rp/8C8/Y3odBTRHZEEtBr6OqEjEE
	exHIvpDryDndJtBnK/2Q7yKd35K7v59yDqZQwNBiXMUeFSWJ4WFJH9MaOn3jPBvjkwbnSQx25vf
	VPbgIehcLjZmaajLeSXVBem94sKbrpk/+EB9rPeB0aozg2Pi/dZ4zqoIwRg=
X-Received: by 2002:a17:907:9816:b0:c25:4d9e:bb28 with SMTP id a640c23a62f3a-c5131586adbmr174375166b.3.1795100517293;
        Thu, 19 Nov 2026 07:01:57 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae68802sm5488666b.28.2026.11.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:01:56 -0800 (PST)
Message-ID: <7a94c586-b4e5-4b9f-9b6b-bce5345229b9@blackwall.org>
Date: Thu, 19 Nov 2026 17:01:55 +0200
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
Subject: Re: [PATCH bpf-next 1/8] bpf: Orphan prefetched sk on
 skb_do_redirect()
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261119142231.2612515-1-razor@blackwall.org>
 <20261119142231.2612515-2-razor@blackwall.org>
 <sashiko-outbox-223322@kernel.org>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <sashiko-outbox-223322@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/2026 16:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] bpf: unorphaned prefetched sk on peer-ingress redirect in
>    skb_do_redirect()
> --
> 
> commit 49a586a8c784f9d116bbf62d9fbeea56cd7faa45
> Author: Daniel Borkmann <daniel@iogearbox.net>
> 
> bpf: Orphan prefetched sk on skb_do_redirect()
> 
> This commit orphans prefetched sockets in skb_do_redirect() before
> redirects other than peer-ingress redirects, preventing RCU-borrowed
> listener sockets from outliving their RCU read-side critical section.
> 
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 946b07a17fcec..1ad57a3715343 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -2558,6 +2558,15 @@ int skb_do_redirect(struct sk_buff *skb)
>>   	ri->flags = 0;
>>   	if (unlikely(!dev))
>>   		goto out_drop;
>> +
>> +	/*
>> +	 * Prefetched sockets may borrow a listener under RCU. Orphan them
>> +	 * before redirects that can outlive this section. Peer ingress
>> +	 * stays in the same RCU section.
>> +	 */
>> +	if (skb_sk_is_prefetched(skb) &&
>> +	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
>> +		skb_orphan(skb);
>>   	if (flags & BPF_F_PEER) {
>>   		dev = skb_get_peer_dev(dev);
>>   		if (unlikely(!dev ||
> 
> [Severity: High]
> Should skb_orphan(skb) run unconditionally whenever
> skb_sk_is_prefetched(skb) is true, including for peer-ingress redirects
> (flags == BPF_F_PEER)?
> 
> The BPF_F_PEER path below requires the target peer device to be in a
> different network namespace (!net_eq(net, dev_net(dev))), whereas
> bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() require sock_net(sk) to
> match the pre-redirect device's namespace.  Skipping skb_orphan(skb) on
> peer ingress leaves the source namespace's prefetched socket attached to
> skb when skb_do_redirect() returns -EAGAIN to re-enter
> __netif_receive_skb_core() on the peer device:
> 
> - During another_round on the peer device, a TC ingress act_mirred
>    redirect (which sets dont_clone = true at TC ingress) or an rx_handler
>    such as a bridge port or macvlan/ipvlan can queue skb to an egress
>    qdisc, backlog, or workqueue without orphaning skb->sk.  An
>    unreferenced RCU-borrowed listener then outlives the RCU section,
>    leading to a use-after-free in sock_pfree() or skb_steal_sock().
> 
> - If the packet proceeds up the peer namespace's IP stack, ip_rcv_core()
>    and ip6_rcv_core() preserve prefetched skb->sk.  Packets routed for
>    forwarding in the peer namespace are then dropped by ip_forward() and
>    ip6_forward() at if (unlikely(skb->sk)) goto drop, while local
>    delivery via inet_steal_sock() steals skb->sk without checking
>    net_eq(sock_net(sk), net), delivering the packet to the socket in the
>    source namespace and caching a peer-namespace dst_entry in
>    sk->sk_rx_dst.
> 

Interesting, the find is correct and my local Sashiko run did not catch it, obvious as it is.
The fix is simple and as suggested by Sashiko:
   -     if (skb_sk_is_prefetched(skb) &&
   -         (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
   +     if (skb_sk_is_prefetched(skb))
                 skb_orphan(skb);

Will fix it up in v2 after I gather more feedback on the patchset.

Cheers,
  Nik

