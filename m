Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24446AECF
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054206; cv=none; b=OLTNJHuqOhj4i0iiXCMZbfyf26Q8vXWBfSNrdzTdnO2Zz0CXsCAOxOQgQ5rqjivu0dfzOfmfwatdmPOx6Y5uWwr8E9NNLqHeuHzP6Y0ZLn0ffIhWOTPgJXXR3UUZS8u7X9z24hKF9mWCpg950WxeKaMdtx2uqem+m4mBqs/RzdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054206; c=relaxed/simple;
	bh=fs6qawgZcjhJ9ULT4KPfMbUsDYgmZe86k0SV9FOqReI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bwcQUjm/IGJy6Y3qdP4YxUj1ofYRco1rXPZQFcuqOcfOBanuR/79B5CyCXC8LnIu747GoXeDirQV0UKv1mCSJSMxXf48u2HfMUwO+HAz7Z75fk3CtxylFd1nt8/IguScc68e+TFY/HpIZvUT2KkJxeFbmOAnDqEbeFzN93o6d4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=WzMzx27y; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="WzMzx27y"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wwIQh-0009m1-Lr; Tue, 18 Aug 2026 13:56:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=rRAGHO3n5Eo7cCOnusX/8BilKkyDJOi5cq2soSk/fU8=; b=WzMzx27y+3lW1As7NYdA1aTzGl
	5tkSSTkN0Z3E374Y0L9fB8Ayy2WeSfj+x2SQ/50dImZoK8Xwc3g8KlmVgFHdHD+SOSO/xD2J/oUUs
	zmLRNU3qZ4yKlV0BV7iN/GC0frciLb4zReTCBDObQVoU/MyyHJJerOgMorn0rs0ND4BnKqL7jVgjX
	3BHeOSKyHfBvd097nd2qt2m8X8cQpCFeNqqOIVv1ZMbvDOBRv67gunbONHHBCWeO7bXGZQX36IaXC
	+5zY4UGCt7zcm87b7mHw2hYL3HmGykoncyF6iSzEwQSAhL7LAZH7dgjc/UhbIC62IwyKDEMLORHib
	VzvWii6g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wwIQS-0003m6-Bc; Tue, 18 Aug 2026 13:56:16 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wwIQH-00EMd2-Pt;
	Tue, 18 Aug 2026 13:56:05 +0200
Message-ID: <113e1abe-32f3-4a7c-825f-4053b54725ae@rbox.co>
Date: Tue, 18 Aug 2026 13:56:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
 <CAAVpQUBKBfRm-XqqrMq0hGeOvWzZXLLmsBnDWKHhEEswmJoz+A@mail.gmail.com>
 <244e1190-0621-4ef7-ba36-634540c2dfcc@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <244e1190-0621-4ef7-ba36-634540c2dfcc@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/26 17:00, Michal Luczaj wrote:
> On 8/4/26 03:58, Kuniyuki Iwashima wrote:
>> On Mon, Aug 3, 2026 at 2:01 AM Michal Luczaj <mhal@rbox.co> wrote:
>>>
>>> Lookup helpers gate whether to acquire a socket reference on
>>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>>> refcounted at acquire time can gain SOCK_RCU_FREE via
>>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>>> then reads sk_is_refcounted() == false and skips the put. The reference
>>> leaks.
>>>
>>> Make acquire and release unconditional and symmetric: always take a
>>> reference, always put it. Adapt sk_select_reuseport().
>>>
>>> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>>> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>> ---
>>> TC bpf_sk_assign() has the same issue; it takes a reference only when
>>> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>>> destructor it installs) re-checks sk_is_refcounted() independently at
>>> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>>> socket here too. I'd welcome suggestions on the right way to handle this.
>>
>> The same class of issue was reported by listen() + shutdown() + connect().
>> https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com/
>>
>> Can you test the diff in the thread ?
> 
> Yeah, it does fix it for sk/sockmap lookups. But bpf_sk_assign() still
> leaks; LLM devised a testcase that puts skb into NFQUEUE. Another way of
> escaping the RCU section could probably involve bpf_skb_set_tstamp().

Ugh, I was wrong. It doesn't fix sockmap lookups, it just made the race
window smaller:

listen():
  inet_hash()
    unhashed_state != TCP_LISTEN
      synchronize_rcu()
                                     sock_map_lookup():
                                       rcu_read_lock()
                                       sock_map_lookup()
                                         sk_is_refcounted() == true
                                         refcount_inc_not_zero()
    sock_set_flag(SOCK_RCU_FREE)
                                       bpf_sk_release()
                                         sk_is_refcounted() == false
                                         put skipped, sock leaked
