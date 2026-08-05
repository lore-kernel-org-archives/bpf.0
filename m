Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652F3B47CA;
	Wed,  5 Aug 2026 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942049; cv=none; b=djXG9MvSdPT/Ll2Bjm2miMwCy/eq5+zDgSqnchvY3EC/Phw2QmAsuSV8a5FYmV7+Rm8YDPv6dG+yLvjYZL18JpwwDHp1be3ruhHxAeYzTe28+Vwrzm9IaEthMjwrgZ6T267yQ4Tsxp6sZmh6GIzwBrSKYVBVzfl+NLmIn6DWMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942049; c=relaxed/simple;
	bh=N3893h/r6Z0gF6m4miXNo0765GWN6vVESeutoQstSGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MpbzFW6TXvxB8RuANUGTV+vOMqCnacWAo6XyGIP91Ak9hJWi+Ook08XDP4i3kL2i4PrpJpfqSYmIOY5OC6B9K8EFS7moMq+PFz67jryHaPEOaJQaezf9e22wG+9Y8THxM4GPiEaerueaM5TeQcMY+yL+Ylh5h0zJSVuzrLvI1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BfK6zB90; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BfK6zB90"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wrd6Y-00ANjW-90; Wed, 05 Aug 2026 17:00:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=9trGoxeJgd1Trkehd6Bp7A7tXvcCGNPofiI3xG/mnmw=; b=BfK6zB90C0pHAHPdbm8eXeNA89
	t71xdpWOYpuIi69/yEojsfAoq1F+XUGiAW7bA1EvUKrRhtCGHHgJdQqTmC3W+AF12EvdV5QhJrZfa
	+cFA7RQyXC6TB0hfNVfATUG44MCO9VzixQq5OK6fivq+z/yAlS0MBL74i3eCx5IBf+ooTz3O3pKiG
	HZe2HzYm3c5vrA4TrF3XmbGje/Kz5Hh7+eqR6LsHYUoKBTy4EQd57fNH+eJ0OeV/lZ01DewrM2TFJ
	nP2ZxQ6JPeF24q41GHOk+89Qb9JBIXsUPN5px1QbcK1Xppn4Jv6AfoQyEbRdrA5xniXh2+7ZhOkrL
	6fj3WOAg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wrd6V-0006Zr-A0; Wed, 05 Aug 2026 17:00:23 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wrd6J-004B1a-2g;
	Wed, 05 Aug 2026 17:00:11 +0200
Message-ID: <244e1190-0621-4ef7-ba36-634540c2dfcc@rbox.co>
Date: Wed, 5 Aug 2026 17:00:09 +0200
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
Content-Language: pl-PL, en-GB
In-Reply-To: <CAAVpQUBKBfRm-XqqrMq0hGeOvWzZXLLmsBnDWKHhEEswmJoz+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/26 03:58, Kuniyuki Iwashima wrote:
> On Mon, Aug 3, 2026 at 2:01 AM Michal Luczaj <mhal@rbox.co> wrote:
>>
>> Lookup helpers gate whether to acquire a socket reference on
>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>> refcounted at acquire time can gain SOCK_RCU_FREE via
>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>> then reads sk_is_refcounted() == false and skips the put. The reference
>> leaks.
>>
>> Make acquire and release unconditional and symmetric: always take a
>> reference, always put it. Adapt sk_select_reuseport().
>>
>> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>> TC bpf_sk_assign() has the same issue; it takes a reference only when
>> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>> destructor it installs) re-checks sk_is_refcounted() independently at
>> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>> socket here too. I'd welcome suggestions on the right way to handle this.
> 
> The same class of issue was reported by listen() + shutdown() + connect().
> https://lore.kernel.org/netdev/20260804015349.2353056-1-kuniyu@google.com/
> 
> Can you test the diff in the thread ?

Yeah, it does fix it for sk/sockmap lookups. But bpf_sk_assign() still
leaks; LLM devised a testcase that puts skb into NFQUEUE. Another way of
escaping the RCU section could probably involve bpf_skb_set_tstamp().

