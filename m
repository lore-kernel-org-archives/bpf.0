Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF3369D54
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781693; cv=none; b=SxDaZEYl1J/W+2/tHMpz4Z9h0zd27JhkM5dw7TifR/agQVZIJ1l3zLZepFDrs8iNzXveo/5bKSAWKIj23O8ydHRuIiZEkS45dU17GMSzL0HJXDQaFeX/b6mVJUVOL5yBHY53nR2SxXQ/ZiiXyuFhn3zjfBam7X+VgD1TwYmtNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781693; c=relaxed/simple;
	bh=YeAObbi1K/VCD2nIkQ7AfV08dix61of2VqYjxPW6Aw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIXc/Ddhyg02tjWwkRyS+RUg84GKBAcK2ctIwOGDv2f9GwKhrVRzqMWoxk3hgyxQ6IavSSG75jMr67ieGxQQwxr+aSKC+CPJJT38w2CKVRJrQL52+x/c+oIU7jzrrhYXVh0fCLPqrUn61QVcQePimOXUX8rOOy3sIZ+IU3+//VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt1z6qYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt1z6qYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB521F00A3E;
	Sat, 15 Aug 2026 08:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781692;
	bh=J1ElH1mS5dfnufo/dPKtLjATTUwFXie1ZTxL6Sx9u/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mt1z6qYRRx83VSAinE7nQR1DZQgOnm2vn14D5ut6+TZzXjFrSWbQgj2DOuCRNn9Y9
	 vB4HLIgsMizGmB9rZ+fCX6VCB0fA750272Qs/FZA8H/F5CeUqcDLsF3egH8FL5X79V
	 6ODesyMRfbku9A0CP4icCb9L/Kf2WlcQeVeCt7bcWJeDeeJpfQ6R5Hv6dMP8OEXyhY
	 eWIrrQbwrRwrAZ1lttju4wCFpJBJSG4WX8h72QktVsdynZUaH29EBhrIjqv7/rsPIB
	 OG6lbmIcpAO9mkjlYxwJ/tihZkni+ctLmxe9d7cL+HVsuNNhR9oMcBdiKMmhAQaxI1
	 rQVv1d7M38EuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-3-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-3-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:51 +0000
Message-Id: <20260815081452.0DB521F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Scrubbing and later re-adding SKB extensions breaks the `skb_e=
xt` bump allocator, leading to a slab out-of-bounds write.
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `__skb_e=
xt_scrub` causes a memory leak of inner SKB extension references (such as `=
sec_path` or `mctp_flow`).
--

--- Patch [3]: [PATCH net-next 03/14] bpf: Make BPF skb extension survive p=
acket scrubbing ---
commit 5b9486076275b0379f7c87d595b7fafe3fc1ef2a
Author: Jakub Sitnicki <jakub@cloudflare.com>

bpf: Make BPF skb extension survive packet scrubbing

skb_scrub_packet() drops all skb extensions unconditionally via
skb_ext_reset(), making it impossible for a BPF program to pass metadata
via bpf_skb_ext through a tunnel or across a netns boundary. Introduce
skb_ext_scrub() which consults each active extension before discarding it,
allowing extensions that request preservation to be kept. Update
udp_try_make_stateless() to use this new scrub method.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9947d2ed6635b..700bee045b5c5 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
[ ... ]
> @@ -7269,18 +7284,61 @@ void __skb_ext_put(struct skb_ext *ext)
[ ... ]
> +static int __skb_ext_scrub(struct sk_buff *skb, unsigned int keep)
> +{
> +	struct skb_ext *old =3D skb->extensions;
> +	struct skb_ext *ext;
> +	int i;
> +
> +	if (refcount_read(&old->refcnt) =3D=3D 1) {
> +		skb_ext_put_each(old, keep);
> +		ext =3D old;
> +	} else {
> +		ext =3D skb_ext_maybe_cow(old, keep);

[Severity: High]
Does this introduce a time-of-check to time-of-use (TOCTOU) race condition?

If an SKB with extensions is cloned, and one clone passes through
skb_ext_scrub() while another is concurrently freed, the refcount could drop
to 1 just before skb_ext_maybe_cow() is called.

Looking at skb_ext_maybe_cow():

	if (refcount_read(&old->refcnt) =3D=3D 1)
		return old;

If skb_ext_maybe_cow() returns the old extension directly, skb_ext_put_each=
()
is bypassed, meaning unkept inner references are not released. Furthermore,
since the offsets are subsequently zeroed out below, the final __skb_ext_pu=
t()
will also fail to discover and free those leaked resources.

This seems to permanently leak state references like xfrm_state.

> +		if (!ext)
> +			return -ENOMEM;
> +		skb->extensions =3D ext;
> +	}
> +
> +	for (i =3D 0; i < SKB_EXT_NUM; i++) {
> +		if (!(keep & (1 << i)))
> +			ext->offset[i] =3D 0;

[Severity: Critical]
Can this cause a slab out-of-bounds write due to how the skb_ext bump
allocator works?

By zeroing the offset here, we leave ext->chunks at its previous size, which
permanently consumes bump allocator space. If a packet retains one extension
and later re-acquires a scrubbed extension, skb_ext_add() will append it at
the end of the chunk space because it appears non-existent:

	if (__skb_ext_exist(new, id))
		goto set_active;

	newoff =3D new->chunks;
	...
	newlen =3D newoff + skb_ext_type_len[id];
	new->chunks =3D newlen;

Repeated scrub and add cycles (for instance, crossing netns boundaries into
IPsec) could cause new->chunks to exceed the skbuff_ext_cache slab object
bounds.

> +	}
> +	skb->active_extensions =3D keep;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D3
