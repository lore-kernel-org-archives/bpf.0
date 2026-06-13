Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567B25785D
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313174; cv=none; b=fxh21P+EwrrQXP9YdRA8hNi4fEAFg86V2/9uOQ3Bg3LBdwfN6CsJctg/XRbDQDNU3qdvwablMiIgenyoaRW7Z7yLWb76yCm+38KDnoarCI9b9CVQi5NCvRobzD8bGEciWE3o8VGwrfe+iXWBD27qy5WPnKwg4xWqRG7yLDEOXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313174; c=relaxed/simple;
	bh=BMIit8yNIkJ3H3NQ+CNvJyndX8TcvtRpt/CFuTngs+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XFN6/J5jB8zk6Wm6v05Izl7hEfxLIZlSlXao9UPHATTEmeMN78zX0l7hh5RLZ9vW37eC1A94A1nWQ6cLeZQvxISM1SXL7RlOIH6xSFwmpwu8m8ZRfqsYMa1iMd0pKfr6IgRBYkomEzIAs4MQFfA2LBWhL0Py7JknuGl4bK9+cDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQi0NqzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQi0NqzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA741F000E9;
	Sat, 13 Jun 2026 01:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781313173;
	bh=jMNXyeJZLF90+zIMNmGezjowP6KujpYtIpOJEVbkV1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQi0NqzQdwzg8AzYcPzTPkBxv9/SwPUcoyJU2FrY0HKH1yO/JDBkCX5LiWjnInXgG
	 14MKZzAlDVqz/OE08CTY4vnowqFx+XzjzdFrgoQoBdqH0uaGoFmZ/3yF/0toAPiYOf
	 1m9zO/R04/qX4lFuqsextXUJazq+ZwOe9lLFDp/rkyFYWJUXe6oX1JIxgdylC8jZaH
	 zEh4mIsd/NTDKpBC/vqLNBzBewLoFG2Ub9annHSNrFe12H7cGsjDnIA2IDdj2Mn0DA
	 elJPPWEZI4WVqBiTJBjcUJy7szxTIN3HfOHuQNNyXhLzOA7g7OnwsJYPxku0ili9SS
	 IN7L6XLoTGGbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next/net 3/5] bpf: Add bpf_skb_set_hwtstamp().
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613010039.1362312-4-kuniyu@google.com>
References: <20260613010039.1362312-4-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 01:12:52 +0000
Message-Id: <20260613011253.0CA741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Potential use-after-free read of `attrs->hwtstamp` if the BPF prog=
ram passes a pointer to the packet payload.
--

commit 41caec1764c831fb81388c5eab46d122318a01be
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: Add bpf_skb_set_hwtstamp().

This commit adds a new kfunc, bpf_skb_set_hwtstamp(), to allow BPF programs
at TC ingress to update the hardware timestamp of an skb. This enables user
space proxies to encapsulate and pass hardware timestamps to socket
applications bypassing the kernel networking stack.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index acdc66aa4f27c..bee1e7eee5eae 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -12372,6 +12372,30 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(st=
ruct bpf_sock_ops_kern *skops,
>  	return 0;
>  }
> =20
> +__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> +				     struct bpf_hwtstamp *attrs, int attrs__sz)
> +{
> +	int defined_sz =3D offsetofend(struct bpf_hwtstamp, hwtstamp);
> +	struct sk_buff *skb =3D (struct sk_buff *)s;
> +
> +	if (attrs__sz !=3D sizeof(*attrs) ||
> +	    memchr_inv((char *)attrs + defined_sz, 0, sizeof(u64)))
> +		return -EINVAL;
> +
> +	if (!skb_at_tc_ingress(skb))
> +		return -EINVAL;
> +
> +	if (skb_unclone(skb, GFP_ATOMIC))
> +		return -ENOMEM;
> +
> +	skb_clear_tstamp(skb);
> +	skb_hwtstamps(skb)->hwtstamp =3D attrs->hwtstamp;

[Severity: High]
Could this result in a use-after-free if the BPF program passes a pointer
to the packet payload as the attrs argument?

The BPF verifier allows passing a packet pointer to a kfunc argument that
has an associated size parameter (attrs__sz). If the attrs pointer points
into the packet's payload (skb->data) and the skb happens to be cloned,
skb_unclone() will invoke pskb_expand_head().

This reallocation frees the original packet buffer, meaning the attrs
pointer becomes dangling. The subsequent read of attrs->hwtstamp would then
dereference freed memory.

Would it be safer to read the attrs->hwtstamp value into a local variable
before calling skb_unclone()?

> +
> +	bpf_compute_data_pointers(skb);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613010039.1362=
312-1-kuniyu@google.com?part=3D3
