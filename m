Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789745D1B5;
	Thu, 23 Jul 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820335; cv=none; b=O025aLgcgNUNFE2qNb+BzJiqkJYLwqpCH2HzmN7FCw5Nyk3h5nGnrAELpoL4YE8StM28TmUygRk1qQosyuc0KTpZe/890NtPydv8r0y7h4pcaIEnicJwnuU4CnFN5CgEWcol1+6LvyWZ5nSBY4Ag55DNw5h8FoJHekbf6pMpG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820335; c=relaxed/simple;
	bh=IZqZx1cm+KLT1HA3GZYkzGFwwH8dcV9HhusSswW3hCE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EIWp6aiC9Y0UipKswBl64LO7KGRBQrRZFlygm7BICa2uCbn1l+gzoe/C8cOM9+ykFQ6KUZlsOn8OemQla52VjXc3d4IMYN8j/mriLyYlrQtUUtRyW5+3W9bPbdZp7pMBX1Lfb7nULfClOs3YVkqHRrMsZzp1C5lWK7R5JeRmNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWwtVpDM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWwtVpDM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827DB1F00A3A;
	Thu, 23 Jul 2026 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784820333;
	bh=sO5eI7KvFIdN3ilwtmjIJQv0l0USR2hOkOJFvcL9u4U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fWwtVpDMqj6ZFdyZg6V0rcahAYz1Huk7C6+xHReKFwcasWOSw97KY0rVDn4sYXocD
	 kYW8UuUJK3MtiZvYSVxPTuGIcJ5USbtuadKInF0IQ78RDD+7H2nCylgaEvknMIxuVn
	 mWmc33d+K+TVEX/h+rc+tl3ycsxJbRipXhrBBqPDKukdHwVLOqy2iuYz1eTKuwcHEc
	 iaMu1zTajZbYAnL6rxNAE9a8pwpgQwMWDExiDewUp+jU8CBL7ebmyoamkDf6KWgiG2
	 Puu1r/z/QUfqNtfAoX8H2IssHAYAzpilIMJ16IxOCgp5JAD6JwpaEh5mHb4LnzhgvY
	 E3n6GZuMKxRuQ==
Content-Type: multipart/mixed; boundary="===============2073702956910006606=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65b8f11245f3ec3b3444f701a84f749d8172b5cfcc0afb3c1f1f3ad6340f7a97@mail.kernel.org>
In-Reply-To: <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
References: <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in lookup helpers
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,edumazet@google.com,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,daniel@iogearbox.net,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,joe@wand.net.nz
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,mhal@rbox.co,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 15:25:31 +0000 (UTC)

--===============2073702956910006606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 403aba3ce891..4bc0b59668fa 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7027,6 +7027,13 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
>  		WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
>  		sk = NULL;
>  	}
> +
> +	/* Always take a reference, even if the lookup skipped one;
> +	 * bpf_sk_release() always puts one.
> +	 */
> +	if (sk && !refcounted && !refcount_inc_not_zero(&sk->sk_refcnt))
> +		sk = NULL;
> +
>  	return sk;
>  }

The BPF subsystem guide specifies that multi-line comments under
net/core/filter.c should have the opening '/*' on its own line. Could these
comments follow that format?

[ ... ]

> @@ -7084,11 +7091,15 @@ bpf_sk_lookup_full_sk(struct sock *sk)
>  	 */
>  	if (sk2 != sk) {
>  		sock_gen_put(sk);
> -		/* Ensure there is no need to bump sk2 refcnt. */
>  		if (unlikely(sk2 && !sock_flag(sk2, SOCK_RCU_FREE))) {
>  			WARN_ONCE(1, "Found non-RCU, unreferenced socket!");
>  			return NULL;
>  		}
> +		/* sk2 is RCU-free, but take a reference anyway;
> +		 * bpf_sk_release() puts.
> +		 */
> +		if (sk2 && !refcount_inc_not_zero(&sk2->sk_refcnt))
> +			sk2 = NULL;
>  		sk = sk2;
>  	}

The same multi-line comment style appears here as well.

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30016591832
--===============2073702956910006606==--
