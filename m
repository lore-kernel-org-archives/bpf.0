Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0D3DB62E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106069; cv=none; b=gBYe+UM7jMb8dEjSm67hO9mpIoRxeUG/XmdX9rm558pqsHelFSgPZjSJl7i55CQ4dVs6hlLwaPbWS3eOna2eiCjhklFVVtkFd2Xeo1URo7yaAZDTj8bUIosqJW6gRcpXl31V157zmxtjm1biZ2ZtBRJuzNBv/VUa8jnuSa+h2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106069; c=relaxed/simple;
	bh=OKkSFDZ66YR/BNRsYcwZGA1tk/BaALY2ha4cYLaYDEI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eVgn8zc1oeLC26FiJnPhg2kb26jxiQS2bbh2awqVcKMKeeGVNNkWNeAM4qCtBPBz2ooiaUpNhPbpJ4lFVyDFTWnzWQzUtNPOBZJmIIgWdyr8yytMOzc8rtYC6hpr7YQdh8gNSykiEPk8uUpL2X9eyyD/egVHm0mM6ejo1e0KeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IpGr/5jE; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IpGr/5jE"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wjvUA-001cCN-1t; Wed, 15 Jul 2026 11:00:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=guZZaPUwV8kO1fHGpvyvmxQca3hz5bLgy1RkSNf6DpY=; b=IpGr/5jEbjDPm7tHUXl3JdRgvK
	FuCRGU0hUUi+n1eah11+jNewYEFlqhi9BETgiqZ4E8j51dQGexpScWH7LG5zq/HKF/nWUpyAwF5fk
	0YqRC7bpdZVPqZORF1vH/hXEBHf4aVfLUCtJBV72+lvBMADATG21dhexFB+G3MDSeQXWsco7THOan
	7MRVE9FsEQahBD1OeIZCc+fiPTLSm1KgI4RRhTbN4s6ncFF75fh6Dw2vkl+e4pI0jXyIMFteoAW/C
	jQLYN6WXTgS5VqbfPQaC7EmBEGl+iK5YjN7ot1f6c7bc4EaQ5dsSvorsnIbVcZ76nSWK3Ii7X3jAB
	yOA/VL0Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wjvU9-00039Z-BD; Wed, 15 Jul 2026 11:00:57 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wjvTr-000dkv-1s;
	Wed, 15 Jul 2026 11:00:39 +0200
Message-ID: <9312e5c3-e0dd-4b28-9455-75547b4f313f@rbox.co>
Date: Wed, 15 Jul 2026 11:00:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
 <20260707-sockmap-lookup-udp-leak-v4-2-f878346f27ab@rbox.co>
 <20260707045338.B30C41F00A3A@smtp.kernel.org>
 <DJZ0DOKOTZ5Q.45F1NZIM8WJX@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DJZ0DOKOTZ5Q.45F1NZIM8WJX@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/26 10:40, Kumar Kartikeya Dwivedi wrote:
> On Tue Jul 7, 2026 at 6:53 AM CEST, sashiko-bot wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The patch prevents a refcount leak for UDP sockets by rejecting unhashed sockets, but an identical reference count leak can be triggered for TCP sockets because `sk_is_refcounted()` relies on the mutable `SOCK_RCU_FREE` flag.
>> --
>>
>> --- Patch [2]: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets on sockmap update ---
>> commit efe688dfced966a49066087e860ab73696a8f75a
>> Author: Michal Luczaj <mhal@rbox.co>
>> Date:   Tue Jul 7 04:23:57 2026 +0000
>>
>> bpf, sockmap: Reject unhashed UDP sockets on sockmap update
>>
>> This patch addresses a socket reference count leak by preventing unhashed UDP
>> sockets from being updated in sockmaps. It removes the ability for BPF programs
>> to increment a refcount on an unbound socket that subsequently gets bound and
>> skips the refcount decrement upon release.
>>
>>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>>> --- a/net/core/sock_map.c
>>> +++ b/net/core/sock_map.c
>>> @@ -542,6 +542,8 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
>>>  {
>>>  	if (sk_is_tcp(sk))
>>>  		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
>>
>> [Severity: High]
>> This is a pre-existing issue, but can the exact same reference count leak
>> happen for TCP sockets because sk_is_refcounted() relies on the mutable
>> SOCK_RCU_FREE flag?
>>
>> If a user creates a TCP socket, connects it (entering TCP_ESTABLISHED), and
>> adds it to a sockmap, a BPF program can call bpf_map_lookup_elem() on the
>> sockmap. This increments the socket's refcount because SOCK_RCU_FREE is not
>> set on established sockets.
>>
>> If a user thread concurrently calls connect(AF_UNSPEC) to disconnect the
>> socket (moving it to TCP_CLOSE and removing it from the map), and then calls
>> listen() on the same socket, inet_hash() unconditionally sets the
>> SOCK_RCU_FREE flag.
>>
>> When the BPF program subsequently calls bpf_sk_release(sk):
>>
>> net/core/filter.c:bpf_sk_release() {
>>     ...
>>     if (sk && sk_is_refcounted(sk))
>>         sock_gen_put(sk);
>>     ...
>> }
>>
>> sk_is_refcounted(sk) will now return false because SOCK_RCU_FREE is set,
>> causing bpf_sk_release() to skip the decrement and permanently leak the
>> acquired reference.
>>
>> Could this sequence be abused to cause memory exhaustion, and is there a way
>> to safely track the acquired references without relying on a flag that might
>> change mid-flight?
> 
> Could sockmap/net experts comment on whether this case needs fixing too?

I'm not an expert, but I think Sashiko is right. Please see
https://lore.kernel.org/bpf/e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co/

I'll take care of it in a follow up series.

thanks,
Michal
