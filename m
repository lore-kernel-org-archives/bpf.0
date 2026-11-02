Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584494;
	b=4Vmzq+htWgbpz6UQusk9nn7Ej7suCjBN0pMHO4+hQHN6/sqXuyKcCkOuqygsY30/KZUe
	 HpmJTodc67jtGVxXHna7AtcltCJ8xlSynk+yBYqG+aQbFQega8ADiP1Dy/PXO55yws3dQ
	 v0nocmilOweLFrGU4Am2oUf8XFg/4ZuyDbD/4Ihzv+f8bOmSf0MjaTyCsMajyKU1hxloP
	 POQPquNdXTI1HgbJ4cynJlTa5mqcKydeyAvgFZIcGC0pLmdgSghX2xNoT60IXym+NJksL
	 +E3bDpK1OsSb0jFOjtrxccZeS8AbZK3Dqmt3hV4GtFE02fDcd1rjZtMFcRY1e4vKRgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584494;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=FkNyargHG2bEuZUpFFoq++5LOK0pA8Se5x5WD9zD53k=;
	b=W6ZOCnrhuLFKgj0ZX9xMVu2tbEmE0LERo0kpAyruh+1SxOnEmpikUfGY3xZ6N6r4MDs7
	 5FcxPrJ2glOJIj6IEEgsTW2M4sYzPgJO6NJEiWUOKL5z3f5HuWmuJEyrRXXSkz3q5vtQT
	 R80EwdjSWc5c7dJqT518i2PYZtL9RSGKzsXp5nSFankcjwq0IThLaUdaLcEajNRYK+qI0
	 wHWEmpenUgxJJB+9G/WNksOmcuTF1bzM8cRcBGan6Dp8Hc9yDJHUNipHMqBv8Ui0PQOfl
	 tERI9bx5upj3/bhgbSYWmC2jSJc5uWvsFTn5Gw5DgcnoJGOPYIuGVVYiroHnUpR/XlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jisQ0P2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9B606A324;
	Mon,  2 Nov 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jisQ0P2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA6F1F000C1;
	Mon,  2 Nov 2026 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793584493;
	bh=FkNyargHG2bEuZUpFFoq++5LOK0pA8Se5x5WD9zD53k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jisQ0P2s/H+apHIs28vCm0eAQgc052oliY6lplQs1zJrWCJj7e4Z+3tLAxhsXXjFG
	 ZYOzxpCP4aIobqVbUjNog1/1tAj8PNPwhu5slE7UOiuE2yA0MJELdPbvLsS1bESWhS
	 G0p0m6EOTML7esLYVoVMMpe17KqDB6/KRVbvGGbZfHXzNDU1Bb700P6P/uOUhmh269
	 od+/SEOc25cLc0vYfsLmEvopWoCzGZg26THuY9TYK+5wtuKlQp9+wV4hNf/eP6CnN/
	 cdhd42KUHZ/0xL8qeRZ9th8Mnuyr39M+wcnGnCIvAEZcxTmd0oYKXmIP15LlQLUl8l
	 T2KKpwePRUEgQ==
Content-Type: multipart/mixed; boundary="===============7763485647564090835=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9acb1683771c3b7bf443773e66599273156e155d25fbabd78596bcf2ca8eda18@mail.kernel.org>
In-Reply-To: <20261102-sockmap-update-limit-iter-v2-2-e96a63c43b39@rbox.co>
References: <20261102-sockmap-update-limit-iter-v2-2-e96a63c43b39@rbox.co>
Subject: Re: [PATCH RFC v2 2/4] bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,john.fastabend@gmail.com,lmb@cloudflare.com,edumazet@kernel.org,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,mhal@rbox.co,netdev@vger.kernel.org,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 01:54:53 +0000 (UTC)

--===============7763485647564090835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap

TL;DR: Unresolved question: tracing_iter_filter() still allows
bpf_sock_destroy() from iter/sockmap, so tcp_abort() may run on a socket whose
lock isn't held. Should it be limited to iter/tcp and iter/udp?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1b6c0674ff6a..4dadfe9505a2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10497,7 +10498,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
>  	 */
>  	switch (type) {
>  	case BPF_PROG_TYPE_TRACING:
> -		if (eatype == BPF_TRACE_ITER)
> +		if (eatype == BPF_TRACE_ITER &&
> +		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
>  			return true;
>  		break;
>  	case BPF_PROG_TYPE_SOCK_OPS:

Was the request to also restrict tracing_iter_filter() to iter/tcp and
iter/udp ever resolved?

In the v1 thread Alexei Starovoitov wrote:

  Pls send the PTR_TRUSTED part in v2. I'd also limit tracing_iter_filter()
  to iter/tcp and iter/udp.

The reply to that was that once bpf_iter__sockmap::sk is PTR_TRUSTED,
iter/sockmap could call bpf_sock_destroy() on an unlocked sk.  The v2 series
adds the PTR_TRUSTED marking but does not touch tracing_iter_filter(), and I
could not find a follow-up on the v2 thread:

net/core/filter.c:tracing_iter_filter() {
	if (btf_id_set8_contains(&bpf_sk_iter_kfunc_ids, kfunc_id) &&
	    prog->expected_attach_type != BPF_TRACE_ITER)
		return -EACCES;
	...
}

This still allows bpf_sock_destroy() from any BPF_TRACE_ITER program,
including iter/sockmap.

sock_map_seq_show() holds only the RCU read lock, and tcp_abort() skips
lock_sock() when called from a BPF context.  Can an iter/sockmap program
now reach tcp_abort() through bpf_sock_destroy() on a socket whose lock is
not held?

If so, should tracing_iter_filter() be limited to iter/tcp and iter/udp as
requested, or is there a reason it can stay as it is?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41373332573
--===============7763485647564090835==--
