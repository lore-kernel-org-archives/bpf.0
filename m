Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E2376A17;
	Mon,  8 Jun 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925508; cv=none; b=nFcjyILe8cjN21DzKx+5lUwX4DIrPvkuCmNzOqz4zuqOme/PX34+VzFAcJhMgIrU4IOgtK/ROg1KuZFEyjOvwL3vK3mt/lfiahz+zzUwzkbIXhUWHUyFNlTIeqcLgWGDjDjQ2B5C4Joaf96oCfO0L7/RkcKBLy10iqmafBW3ckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925508; c=relaxed/simple;
	bh=JFy0iMesCs1fLlDssLTKJrAOwVCLYFr7WTMgno0degI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NKWq8QXCEV0hYEJRRsBnToqWlKIgkWLEQwckJwCHH+koKbwWiW0WDi/AvLCqJ9B0R//6sdaF5+qWJfD3xJYMKhtfbKQpwBnN8gdYV5zCmHMbKHvehRddJVBEcTgIU3KrCbVujc8FxvE6f7D8sh7GKMtjFHTFmmpa+0jhB31cB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sse/N6Uz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sse/N6Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9819E1F00893;
	Mon,  8 Jun 2026 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925507;
	bh=eSDdP4tgfREZn/txwJ8wEN5USu6Zq86uelsFFw7+5gw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sse/N6UzxxLJXfvnYq0dv9QDTC9hGuC65wyU9H95K++taSCKL0+o3BFM16687YRYf
	 4DIY1vTh/PbOFsbJyrZF0WgQtWOxpCQlL/l51+rt43Mur60FRC21B6B8CpUWoTNnH2
	 WXqNcVcG3TLdUOfw9vWgSRCzg7pBXWwsme1Q3lbTA5XEliYeloFg2jcokjbNBEO5Kj
	 2bTl6AzQJPdJ2DFqTnd9XgyepkWSqcCaYZ8mP5S4P4Qx67w2B4OqcWplmT1P+MYrr0
	 8V340x6mCoDb37Ak3/79fv0nwgy1cl/6UOY/TYvDMEzAwxou+KL5PEPUg7DFK9SJeL
	 kWXoX0hlnhcLw==
Content-Type: multipart/mixed; boundary="===============6294924719200785139=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab7585da0a807e7a9c2e6dbc621a75132135d3812d273f2b23f0759426ac3843@mail.kernel.org>
In-Reply-To: <20260608125846.157004-2-jiayuan.chen@linux.dev>
References: <20260608125846.157004-2-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for BPF-assigned sockets
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,willemdebruijn.kernel@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,joe@wand.net.nz,kuniyu@google.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 13:31:46 +0000 (UTC)

--===============6294924719200785139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 5a9c826a7092..c2b8c6350b62 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h

[ ... ]

> @@ -103,6 +105,18 @@ static inline struct sock *skb_steal_sock(struct sk_buff *skb,
>
>  	*prefetched = skb_sk_is_prefetched(skb);
>  	if (*prefetched) {
> +		/* A non-full socket here is either a reqsk or a
> +		 * timewait sock, both only contain sock_common and
> +		 * lack sk_protocol. Since both can only be TCP,
> +		 * use IPPROTO_TCP as the protocol.
> +		 */
> +		if (unlikely(((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) != protocol))) {
                         ^^^

This isn't a bug, but there are extra parentheses around the expression
inside unlikely(). Kuniyuki Iwashima requested adding unlikely() in v7
review, but the v8 code has unlikely(((expression))) instead of
unlikely(expression).

Reference: https://lore.kernel.org/bpf/CAAVpQUA6z4bZVReNDMToRVL1V7xmYg4Tq2YMnWyU8AYXWoeB5A@mail.gmail.com/

> +			skb_orphan(skb);
> +			*prefetched = false;
> +			*refcounted = false;
> +			return NULL;
> +		}
> +
>  #if IS_ENABLED(CONFIG_SYN_COOKIES)
>  		if (sk->sk_state == TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie) {
>  			struct request_sock *req = inet_reqsk(sk);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27139886597
--===============6294924719200785139==--
