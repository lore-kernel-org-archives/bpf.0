Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF22253B0
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937610; cv=none; b=tFFR8UjJr+nZzA5nSc7SvkoouvlSaB8/GCISSLn8NEw9vPGWDtwQ7ack3JatgEvI2SaOSq9KA1Q99O9ZZ93hTO/t2ZVXvPOzsnLBBog2F+T5MjGGAJhEf7y9S+KiqghOrGE5bdh2hCuaygZlCCGdxBi8clZaEnuHgdhpVZDr/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937610; c=relaxed/simple;
	bh=wqzcR2Vb3YK2LAiR+yOwfa+Qq5E5XeCpf8ZN6x3EZZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XALzwBO4nnYbIdfy0AQiqFqqFkYSuTD3GiKCN/5ZhWORzJbE6ktDz1RTf3ubPNAAYerTqe3tIMcLVdHoh5TQyRnO7Yq/r3fJgjypjUzbd+emrQjROmjKpT6yO4tdhE7FRkHY/nU9suWRBgsMj+gxkCaA6tOb7FJJNL/n4+O6xpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqvmOCDB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqvmOCDB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e27035206so934446b3a.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784937608; x=1785542408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RcfP1cCpEbGNIQWuA4I35j/s62A27Am7wlHhwJwCgdA=;
        b=SqvmOCDBUFNxIXmlz55nKwKkV8F7azt4a2KqNZyFDCJCxz4Vm3yalP4T/tLmah9Fqr
         xNjmRhUE52Ri50JePHkkHqKGEKFpdrX+RT0BHje6e0gN3WviacvC7Q5WLMrqSsVhIcow
         o0+097TyCt+/0D5iAmvCSgpy+TSS8CUEc4HBxwtUFHlXm8OLdjzVHQoxlTtqYr0R0HlC
         34vRbCtsWNDf8ratET2IjRPziFNNXN5HEsLiz90NKIjmBKHmjF9s/qJ0wZwTTW0XqaB5
         kdms7R07w8MmZ2+RWPAdWPFU9fioxVNW2oWvqjoG5hPQRbUg1hkPVrOAItd5wlXWETdF
         nRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784937608; x=1785542408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcfP1cCpEbGNIQWuA4I35j/s62A27Am7wlHhwJwCgdA=;
        b=pFFlr036B/wJK+cSb0PMfaZF4xx2EbhMeGYq/6MHHt7v2QxAXX+DFFGQ/KzELbM/I/
         4SmgWDh3sdP43WPtfeeqoAP5RtIUox3iqDfujuE92tWU9ZwSTKmbKW6kQ6pOh6EgBvlO
         iq3Xgqg72BAkek3aEuxUcTJooPAuhGf+KIbNgBE+aX9K4mtYpcIA+5GfqcCdfFwDthzA
         Kd9HQLyfsGZwhT5l86PmyiA8X/aM5ITI31PA84Ae11MMyN/LbwQgN3oHMYDQxNaaKSU+
         PRU6LqxzQ2b6Q2u4uV7B0THi4cCFFnDWrUJ1wgXhBG8+fQU6RBVreLbkMG9g1CBDexet
         sIpg==
X-Forwarded-Encrypted: i=1; AHgh+RqmyQWXvFA7FwEHBChsdRG2kyZsJsPbdWqdlnPqNP0g7vucPhwEgt++9qYYRMENhKvFA/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNMjNxB0IVj264vjpctaHlTktgxB4CdhU9ggQ8wMjcI/R3rgk
	vtHAjktRbgRusIUTlRn0TwVBMyjP81OaxxQS9YIVPWZOOXwIuGnmX3Ik
X-Gm-Gg: AR+sD13gqsZZL36Lmv81Or3h1elYVsrxX3HIWRCu8TpCDnbhU7cGYPpUJT2yKtMDH3C
	Q5lzQnd1m2LZO871V7oUARted0Qx47YycBL/m7PywnnPpj7xHxpmFhMwApGrk/pmTT0/KHHjeFC
	/+JkjLDapkVJZ4Sd1AC60KIY7bHHgbnx13TXrSNTm+TkP8d2/wGosqsG+6OaaO8xN6WJktSLbpD
	EsJxZtDICttSNA+MzkObZlkzCsbP5X8xu827ZyyQkl0IX+o4P5ZarvPWaGkq0jhNvxwuEz3nUPx
	QTFClYjK56cjcgfGqS/vWH3tX0T0VscrPXM+/IISp/22svfYIAHG0fGhgufyKK1VuEDTGngaQES
	BVVf7qg6xUxb4IC70Lf98c3aiRxNMOedA5TifGN2oB5ehAZKAcW1M40wiuXFo+fBMwD62vmaa2a
	xz
X-Received: by 2002:aa7:8896:0:b0:847:9745:2f83 with SMTP id d2e1a72fcca58-84e59435becmr296556b3a.18.1784937608025;
        Fri, 24 Jul 2026 17:00:08 -0700 (PDT)
Received: from john-p8 ([98.97.42.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f22fsm535936b3a.13.2026.07.24.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:00:07 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:00:05 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Joe Stringer <joe@wand.net.nz>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/3] bpf, sockmap: Use sock_hold() instead of
 refcount_inc_not_zero() in lookup
Message-ID: <amP8aYwtxo5qJUEb@john-p8>
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-1-1bbdc58ce514@rbox.co>

On Thu, Jul 23, 2026 at 01:33:27PM +0200, Michal Luczaj wrote:
>psock's hold on the looked up socket isn't dropped until sk_psock_drop() ->
>queue_rcu_work() -> sk_psock_destroy() runs, which happens only after the
>entry is unlinked and an RCU grace period elapses. Since the lookup runs
>under RCU, a non-NULL result guarantees sk_refcnt >= 1:
>refcount_inc_not_zero() can never fail here. Use sock_hold() instead.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---

Should bpf-next right? this is an optimization not a fix?

> net/core/sock_map.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>index 9efbd8ca7db8..ca49bc7f8687 100644
>--- a/net/core/sock_map.c
>+++ b/net/core/sock_map.c
>@@ -392,8 +392,8 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
> 	sk = __sock_map_lookup_elem(map, *(u32 *)key);
> 	if (!sk)
> 		return NULL;
>-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
>-		return NULL;
>+	if (sk_is_refcounted(sk))
>+		sock_hold(sk);
> 	return sk;
> }
>
>@@ -1218,8 +1218,8 @@ static void *sock_hash_lookup(struct bpf_map *map, void *key)
> 	sk = __sock_hash_lookup_elem(map, key);
> 	if (!sk)
> 		return NULL;
>-	if (sk_is_refcounted(sk) && !refcount_inc_not_zero(&sk->sk_refcnt))
>-		return NULL;
>+	if (sk_is_refcounted(sk))
>+		sock_hold(sk);
> 	return sk;
> }
>
>
>-- 
>2.55.0
>
