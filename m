Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754F364043;
	Mon,  3 Aug 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750254; cv=none; b=ngp52RZmdKXSu2s/7iiljYZe6912I7yPpzjQd5+cjW2d8bl5l36qkXMeiDW/G4mNtowz1tYH7wzEtzEJjYZ6koaAOmcBNvqnuwTMivTkfHJ2XHMggnRNdBqMYIUk7UYE+HLjnvqeBzDPJZZC3wUtsr7ZP1EaoAa4G2FLvgLHDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750254; c=relaxed/simple;
	bh=8Jp90i5P6qCJvpiC+LoxGxRWSo110yPgOtFD2FTvFD0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aScJAyY0RWa5P7RhcLz1M3bjzmC4Cvw0UPAg5ZrEPiKiz37MPYLLiLGFxfmIr0biC+tTG02O4OGmjtvmLsGxXjFwFC9o/ksgbWwzZOqeZrnuIpY0hzA8/2inF8PqAWPB3RihYy1Zf3GcbqjenOngsAUIGFClFLrDV6evIOvQVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK0II1mH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK0II1mH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C21F000E9;
	Mon,  3 Aug 2026 09:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785750252;
	bh=g2yt5PVPdZJisc2EcEjvKomdU+Mn1lqjYdehP0zL6ec=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FK0II1mHyB8TEMrg5nhNOLL/IUF+mCP8fbVVCqdO/IuTPXKc2idEFCQUnh1Dyt0Bw
	 n64kDR1NVOeCH7U47dUQNcJ1pNHY/qhBcrF8IKa2nZ+tmEnOjg66w3RE4YMRiXzupI
	 9U7dfyjueiF5VaECNTXV4iIfJChPgbfT8Slg4cg7GOvhc3mt+wA8zJWi614xCpCmJX
	 NCrahE96r3gXAm+fi65TfuDy+uKBFJNCRnwY6PXF3F8/eBb1L/uFy5smP+If1ttAlt
	 /NGNG1ieL42rKf+a4bxSFcjc4wx6R2ZzVw0ceOza8V+kG4oiHnL8k7ISahMN6tCHfa
	 1JIszPFGQmv+w==
Content-Type: multipart/mixed; boundary="===============3124136976014052694=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43cad9ddcd7b1c7541a179444b27cd6b40fdf32f7aabfff2080c12bfc945dc94@mail.kernel.org>
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
References: <20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
Subject: Re: [PATCH bpf v2 1/2] bpf: Extract shared reqsk-to-listener upgrade
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,joe@wand.net.nz
Cc: mhal@rbox.co,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Aug 2026 09:44:10 +0000 (UTC)

--===============3124136976014052694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 11bb0d236822..fede810ef37f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7079,6 +7079,28 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
>  	return sk;
>  }
>
> +static struct sock *
> +bpf_sk_lookup_full_sk(struct sock *sk)
> +{

This isn't a bug, but since this helper only converts a reqsk to its
listener rather than performing a lookup, would a name outside the
bpf_sk_lookup_* family - say sk_lookup_full_sk() or
bpf_reqsk_to_listener() - read more clearly next to
bpf_sk_lookup_tcp()/bpf_sk_lookup_udp() and struct bpf_sk_lookup?

The bpf_sk_lookup_ prefix in this file already denotes the BPF helper family
(bpf_sk_lookup_tcp(), bpf_sk_lookup_udp(), bpf_sk_lookup_assign(),
bpf_sk_lookup_enabled) and the UAPI context type struct bpf_sk_lookup /
struct bpf_sk_lookup_kern. Sitting about 20 lines above bpf_sk_lookup()
itself, the name reads like another lookup entry point rather than a
reqsk-to-listener conversion.

> +	struct sock *sk2 = sk_to_full_sk(sk);
> +
> +	/*
> +	 * sk_to_full_sk() may return sk->rsk_listener, make sure the original
> +	 * sk sock refcnt is decremented to prevent a request_sock leak.
> +	 */
> +	if (sk2 != sk) {
> +		sock_gen_put(sk);
> +		/* Ensure there is no need to bump sk2 refcnt. */
> +		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
> +			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
> +			return NULL;
> +		}
> +		sk = sk2;
> +	}
> +
> +	return sk;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30800053349
--===============3124136976014052694==--
