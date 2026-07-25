Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90192F5487;
	Sat, 25 Jul 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785002914; cv=none; b=r6U4SQGzVnSqyQJqTxjolCWTzdTOZwJHgCUsEiVvoJ/yskKerOFuWTWg9PFK0OaO3N3DcnqJOR2dii6SDE6DFxVW1rUdqSIC5VFOK7vsR1Jd8+8wbU5l2afklt/wCH4snU31YC/V7zWqyrpMge8843DbjVQJJAcMYp8V1kIxQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785002914; c=relaxed/simple;
	bh=tEpU/DEvJ/ntQWXqWHulhY16XAu7Ry70hjLxZVNAOe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgRpBmpNL2eA8IwLeHID8T6VTnyirAgXHLl8eAq6KFfMGJuMoK1EwMGz6sSrBZdUCZc8ZzLTklynhn/UZ3pvUDvRd5lmGHIdP0hHaWy6AnJGvGQCAI0c+M/UqQwe0LP1NsA841qYD9oR/q4I0zqruA1TekagQnlR0g4tLwEz2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UDM4GUPt; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UDM4GUPt"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wngnD-00CMSP-Mt; Sat, 25 Jul 2026 20:08:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=2KYNlDtl58Qgh8rb02AfLzOu/UAS72qPiNqld44YtQs=; b=UDM4GUPt7z0xyznrVXZMinYjte
	uxcC8spvTs9WQiUXWmTAI196TkbgzaLR+UEMmUD2IqBXhcuZIKaY45eS3pNjjb+hFRhH94aBE7lUI
	4MBRKnilsMlAVyXwVzru7GV9Cg5VgcMMBRMRnym76t2NeSNtd3WLZ5jkX0NnIx2ut+GGyQzER7Vq3
	a6GobRv0f2WlTJ4Tuc3sDrE3U9aN+IJOuyzor6qpEAprFoocBRp2ha1CrYoHcfAPNqh436y9qSNve
	s7lND1H0N3c86QFprZdeQF2/8xwLIbtD5LXfz6OGsjY4u2+eHKGT9zZ7L+USaWXT+wpMqMlancKX/
	CMqAZVDg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wngnB-0004kH-Sv; Sat, 25 Jul 2026 20:08:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wngn0-00AXvH-1Y;
	Sat, 25 Jul 2026 20:07:58 +0200
Message-ID: <1b224fd7-0d3e-4baa-8426-4df370b3bc64@rbox.co>
Date: Sat, 25 Jul 2026 20:07:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/3] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
To: John Fastabend <john.fastabend@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Joe Stringer <joe@wand.net.nz>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>
 <amP8aYwtxo5qJUEb@john-p8>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <amP8aYwtxo5qJUEb@john-p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 02:00, John Fastabend wrote:
> On Thu, Jul 23, 2026 at 01:33:27PM +0200, Michal Luczaj wrote:
>> psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
>> queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
>> entry is unlinked and an RCU grace period elapses. Since the lookup runs
>> under RCU, a non-NULL result guarantees sk_refcnt >= 1:
>> refcount_inc_not_zero() can never fail here. Use sock_hold() instead.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> 
> Should bpf-next right? this is an optimization not a fix?

Right. Would you rather have it squashed with patch 3 or should I save it
for bpf-next?

>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 9efbd8ca7db8..ca49bc7f8687 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -392,8 +392,8 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
>> 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
>> 	if (!sk)
>> 		return NULL;
>> -	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
>> -		return NULL;
>> +	if (sk_is_refcounted(sk))
>> +		sock_hold(sk);
>> 	return sk;
>> }
>>
>> @@ -1218,8 +1218,8 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
>> 	sk = __sock_hash_lookup_elem(map, key);
>> 	if (!sk)
>> 		return NULL;
>> -	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
>> -		return NULL;
>> +	if (sk_is_refcounted(sk))
>> +		sock_hold(sk);
>> 	return sk;
>> }
