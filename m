Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7FE158535
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224434; cv=none; b=pkLgxNFPRVoq8EfCYJjUkMoCbRZiiBOs45JcjSeKv6AZE3Q+/tKNVUegjHl2ZBHUfzPCAyC+Nx/R3Vhs5lqqkXvpmFxd7MO2yIABdodZuD6PoIVH6vXzzj7GAJD8019FkXmKc/c3vDkCkn9Fw+cn5NzxELxcXJK7w6CuprRnvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224434; c=relaxed/simple;
	bh=GkaNrnRrqUsCu7vV3EBx129xga4u/4bQnGhq4sonkrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H9bh5+Lah1pZDJ4WQ92zmjq/J4KxlSaJx8mPtZBmZuh/hyEeU/4SULjJk9YFOXxlwGTd6uuEFpfOEGg3nHzuVsPZumnWdCWI9V3LXZioCebmF5ionoQ+dkREKzKMFx8ZvqrqjtVJp/TxriTWYsSV83AiAluLwYm62ax7yF8ikIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SET2UvYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SET2UvYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4977F1F000E9;
	Fri, 12 Jun 2026 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224433;
	bh=hVvvdkchIPgzehlwyaQOySHmTip6yr/RHqJR0v+9/QY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SET2UvYwl5fX4gvp+pByyP3NCoJkZoYFg9Qmg5J8m5i4ESYu8NLcxP46fB1RYiVWI
	 5UYFd+P8FEJuV6ze3MBYvF+f52HUzWtpQjrn1uXB2IbDg6huLgPivW9Et+MOmbnQzU
	 1Bb+zT5b+14LX6FCRoYS7O+y0PBGiXUBgW9PMW3Kea3KX9Ojb3CU/4W2d9auslLz/1
	 FUdp1jBKtomKdQgBnQXrp0O9qALKhyVdSzWPnld7ivWQIInSQgkhw8oAt73LFewbbi
	 QKi1R7KaN5tSq2SDlliQDxinQ2cBGPLpViwDer94OWLtxn0mjRETUhSFZuaXKt2lR9
	 /9ck8BeVwPYQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next/net 3/5] bpf: Add bpf_skb_set_hwtstamp().
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612001803.23341-4-kuniyu@google.com>
References: <20260612001803.23341-4-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:33:52 +0000
Message-Id: <20260612003353.4977F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsafe modification of shared SKB data (skb_shinfo) via insufficie=
nt uncloning
--

commit 96bf1885d42f4593da3e164388ab66653eb4e518
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: Add bpf_skb_set_hwtstamp().

Adds a kfunc to update skb_hwtstamps(skb)->hwtstamp at tc/ingress. This
allows transparent proxying of RX hardware timestamps via SCM_TIMESTAMPING =
to
socket applications.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index acdc66aa4f27c..ab7adef9c0159 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -12372,6 +12372,28 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(st=
ruct bpf_sock_ops_kern *skops,
>  	return 0;
>  }
> =20
> +__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> +				     struct bpf_hwtstamp *attrs, int attrs__sz)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)s;
> +
> +	if (attrs__sz !=3D sizeof(*attrs) || attrs->reserved)
> +		return -EINVAL;
> +
> +	if (!skb_at_tc_ingress(skb))
> +		return -EINVAL;
> +
> +	if (skb_header_unclone(skb, GFP_ATOMIC))
> +		return -ENOMEM;
> +
> +	skb_clear_tstamp(skb);
> +	skb_hwtstamps(skb)->hwtstamp =3D attrs->hwtstamp;

[Severity: High]
Does using skb_header_unclone() safely protect against modifying a shared
skb_shinfo(skb) here?

For TCP transmit clones, the header is released and skb->nohdr is set to 1.
This makes skb_header_cloned() return false, even though the data buffer and
skb_shinfo are still shared with the original packet in the TCP write queue.

When these packets loop back to TC ingress, such as via veth or loopback,
and are modified by the BPF program, skb_header_unclone() will skip
reallocation.

Could this lead to silent data corruption of the original socket buffer's
skb_shinfo? Would using skb_unclone() instead be necessary to prevent this?

> +
> +	bpf_compute_data_pointers(skb);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612001803.2334=
1-1-kuniyu@google.com?part=3D3
