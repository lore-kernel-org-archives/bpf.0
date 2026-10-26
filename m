Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987538;
	b=lCaytc7KMNiGIPzqCkd1emJTSqcrS0ArS53aiPhngCgqBYvjUCOqdDU7olv+0b3dmtJt
	 aHa5LTw6R597aY/2cGoMv+NXe2G/lQctmd+ycdNAU1jB9jP75Fhvz5bG8BcygmKkPW7r/
	 /682ipUzfaI3mMhv5AJ2XGGORVcALbJ0ZMYOP9zqRMzaboKT+w2H202Qm8V6gIe66Fw4Y
	 QKCwbexdfW2vFCBjMw7eIZOCW9zNbIIA7MECaynpFqAUvCu8G9zsYi+sy2G/IbOEfNKVs
	 ohPM13nPR2s6Adg3V/9OUgS1sWBrPxkuuAqCM/taIE0j+fh4sAVfPmqBWIZekvA1uZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tUuPljRkWjxEIRvOlnCsMG+Lo0xp61u0475DpTz6h/Y=;
	b=KnBS1gpjvxsgHvMF9jmRxlSaOqJOA9ehg+HXOtg6KiVLSWHtJTR9qPhUgAu69HWkCUUm
	 R8Y8vnrXRE0l8wP6+blNGTAnedIg03VBsrBv54FQ+1j51sQQujZkqQC+kydewv3bMzHmI
	 bJbdrtynYzr9jWcpH7dXQhKzael90BsXlXeYoongpPbOxgZCTzLhMY7WDn8Y40eBGMCCx
	 aawyLPrjUvgblnk5FEUD8td2p7cJrW9otPm/5KfmlIhOL52VJ6pcLBFLb+bx4PZilDhML
	 OE2vP5zBetQfEOvoADbq2za/D5BA/diFAmxAJlNTmAnMxiaHoxX/vPJCIhMjRiYLylg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiyiSokm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E18606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiyiSokm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACCC1F01828;
	Mon, 26 Oct 2026 04:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792987538;
	bh=tUuPljRkWjxEIRvOlnCsMG+Lo0xp61u0475DpTz6h/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiyiSokm0JiPwqH2HDeG5xRawjXevvJyeij77OEuGNeN3LSI5SuWVKWVS86NcmSYF
	 O2op4CHqRRlecQPcZXncSS59+l+zCX6IMHePEciz+3W6NIhOFneEyHmBZyYLI/FFd0
	 VMZpoTjVmcxLfSQrcGf5Atl7uk603KOSz/z1hZ+Cwa406w1PpEdky9fg9zzjyq0loM
	 DSpnhR6STMw0r2OjA2L0HNArdxUSJB4+PmsJVLdNPVQ9huxD3AugrgQzRNkwy31bHf
	 EGE/sUEvAq3qgmG5jWK/CXu3me7XQEno1CyQiMHQMd+bZdS73atc6LuKPfDEeyX/ga
	 y0dWxbHEswx9Q==
Message-ID: <sashiko-outbox-184613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: Make PSP skb extension survive packet
 scrubbing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <weiwan@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261025040523.678027-2-weiwan@google.com>
References: <20261025040523.678027-1-weiwan@google.com>
 <20261025040523.678027-2-weiwan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 04:05:37 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] net: skb_ext_scrub() on cloned skb causes xfrm/mctp UAF on COW=
 or ref leak
--

commit 1f02b0c0e2664a9f83f628b54130f3d1388bbb4a
Author: Wei Wang <weiwan@google.com>

net: Make PSP skb extension survive packet scrubbing

This commit introduces skb_ext_scrub() and uses it in skb_scrub_packet() in
place of skb_ext_reset() so that every skb extension except SKB_EXT_PSP is
deleted when a packet is scrubbed across tunnels or network namespaces.

Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b21e=
42180b0@cloudflare.com

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 48f6764117243..4269d91cf6078 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -7441,6 +7442,23 @@ void __skb_ext_put(struct skb_ext *ext)
>  	kmem_cache_free(skbuff_ext_cache, ext);
>  }
>  EXPORT_SYMBOL(__skb_ext_put);
> +
> +void skb_ext_scrub(struct sk_buff *skb)
> +{
> +	unsigned int id;
> +
> +	if (likely(!skb->active_extensions))
> +		return;
> +
> +	for (id =3D 0; id < SKB_EXT_NUM; id++) {
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +		if (id =3D=3D SKB_EXT_PSP)
> +			continue;
> +#endif
> +		skb_ext_del(skb, id);
> +	}
> +}

[Severity: Critical]
Can calling skb_ext_del() on SKB_EXT_SEC_PATH or SKB_EXT_MCTP when
SKB_EXT_PSP keeps skb->active_extensions non-zero cause a double-put or
reference leak on a cloned skb?

Suppose an skb has both SKB_EXT_PSP and a reference-counted extension
(SKB_EXT_SEC_PATH holding struct xfrm_state references or SKB_EXT_MCTP
holding a struct mctp_sk_key reference) and is cloned (for example via
dev_queue_xmit_nit(), tc mirred, or bpf_clone_redirect), so
skb->extensions (ext) has refcount_read(&ext->refcnt) > 1.

When skb_scrub_packet() -> skb_ext_scrub() calls skb_ext_del() ->
__skb_ext_del(), SKB_EXT_PSP keeps skb->active_extensions non-zero, and
because refcount_read(&ext->refcnt) > 1, __skb_ext_del() returns early after
only clearing the bit in skb->active_extensions:

net/core/skbuff.c:__skb_ext_del() {
	struct skb_ext *ext =3D skb->extensions;

	skb->active_extensions &=3D ~(1 << id);
	if (skb->active_extensions =3D=3D 0) {
		skb->extensions =3D NULL;
		__skb_ext_put(ext);
		return;
	}

	if (refcount_read(&ext->refcnt) > 1)
		return;
	...
}

This leaves skb pointing to the shared struct skb_ext with
ext->offset[SKB_EXT_SEC_PATH] or ext->offset[SKB_EXT_MCTP] still non-zero
and its payload still populated, while the corresponding bit in
skb->active_extensions is cleared. From that state, two regressions appear
possible:

1. If another extension is later added to the scrubbed skb via skb_ext_add()
while the clone is still alive (ext->refcnt > 1), skb_ext_add() calls
skb_ext_maybe_cow(old, skb->active_extensions):

net/core/skbuff.c:skb_ext_maybe_cow() {
	...
	memcpy(new, old, old->chunks * SKB_EXT_ALIGN_VALUE);
	refcount_set(&new->refcnt, 1);

#ifdef CONFIG_XFRM
	if (old_active & (1 << SKB_EXT_SEC_PATH)) {
		struct sec_path *sp =3D skb_ext_get_ptr(old, SKB_EXT_SEC_PATH);
		unsigned int i;

		for (i =3D 0; i < sp->len; i++)
			xfrm_state_hold(sp->xvec[i]);
	}
#endif
#ifdef CONFIG_MCTP_FLOWS
	if (old_active & (1 << SKB_EXT_MCTP)) {
		struct mctp_flow *flow =3D skb_ext_get_ptr(old, SKB_EXT_MCTP);

		if (flow->key)
			refcount_inc(&flow->key->refs);
	}
#endif
	__skb_ext_put(old);
	return new;
}

Because memcpy() copies old->offset[] and the extension payload into new,
__skb_ext_exist(new, id) is true for SKB_EXT_SEC_PATH or SKB_EXT_MCTP, but
because those bits are not set in old_active (skb->active_extensions),
skb_ext_maybe_cow() does not take additional references on sp->xvec[i] or
flow->key. When both old and new are eventually freed in __skb_ext_put(),
__skb_ext_put() checks __skb_ext_exist(ext, id) rather than
active_extensions:

net/core/skbuff.c:__skb_ext_put() {
	...
#ifdef CONFIG_XFRM
	if (__skb_ext_exist(ext, SKB_EXT_SEC_PATH))
		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
#endif
#ifdef CONFIG_MCTP_FLOWS
	if (__skb_ext_exist(ext, SKB_EXT_MCTP))
		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
#endif
	...
}

Wouldn't that call skb_ext_put_sp() or skb_ext_put_mctp() on both old and
new, dropping the struct xfrm_state or struct mctp_sk_key references twice
and causing a use-after-free?

2. Alternatively, if the clone is freed first, __skb_ext_put() decrements
ext->refcnt from 2 to 1 and returns, leaving the scrubbed skb as the sole
owner of ext with __skb_ext_exist(ext, id) still true and holding live
references for the deactivated extension. If secpath_set() (or
mctp_skb_set_flow()) is subsequently called on the scrubbed skb:

net/xfrm/xfrm_input.c:secpath_set() {
	struct sec_path *sp, *tmp =3D skb_ext_find(skb, SKB_EXT_SEC_PATH);

	sp =3D skb_ext_add(skb, SKB_EXT_SEC_PATH);
	if (!sp)
		return NULL;

	if (tmp) /* reused existing one (was COW'd if needed) */
		return sp;

	/* allocated new secpath */
	memset(sp->ovec, 0, sizeof(sp->ovec));
	sp->olen =3D 0;
	sp->len =3D 0;
	...
}

Here skb_ext_find() returns NULL because the active_extensions bit is clear,
while skb_ext_add() sees ext->refcnt =3D=3D 1 and __skb_ext_exist(new, id) =
=3D=3D
true and returns the existing chunk in-place without releasing its previous
references. Doesn't secpath_set() then see tmp =3D=3D NULL and overwrite
sp->len =3D 0 (and mctp_skb_set_flow() overwrite flow->key), leaking the
existing struct xfrm_state or struct mctp_sk_key references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040523.6780=
27-1-weiwan@google.com?part=3D1
