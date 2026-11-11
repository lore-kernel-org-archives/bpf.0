Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392420;
	b=eeEWV37UuW/RW2C1Rlhx+WBiKcKpplH7/HPqwRbZpG4LFifJqF8NwyHk41LDlYGYRgcx
	 txTTnyWAkh3sRjzSLWfxheT0kX4CT0r4SxmHmGYvLyjvMpZBeKJD74ziYrkzHJdr3jmPQ
	 VXd3WvJnWS1aNegCCuawumXyfGWhGb3HpC10U+ypeS4ksy3rGuN5ftpOL5gL/vGq5Aadl
	 y+xZNpxnrQzVbK5Dvh82LgtKkzUEsedICLSjkNDb9c4jWN1tdQXAPAeaN5LsTLFSfBjXi
	 wyUmyZna0fCJ2Ul5i7A8dDeLjqFYxuHMV/GYUNF1tmAowX7ukcdgqkz/oM9BDS3lRJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=++G2VxxKbsRtJvdsjo1zyPWpF09kyZ+95WGkvwTf7xo=;
	b=GuBqQcIp59L/ec8+M3AX1BSqtxRew01kqTIIDx3uFJZUdOAdOmGseopicuSmP6T1isEs
	 7phhFC6muYs7Hv6cZIA2XVVik/yjR0PPrSsVLG8/IIRgsywHF3qSkPbuZNvC7ZkYZT519
	 5LuUQR8Ky+Cez4lAgo1Q/uYgsrNqLYPVFCvJndDpt0qjCmun9uWlj1+p1QroMkFmZX8HL
	 Efd/Fdon+brbtFCov/pJsbnxHmrZw12R/D5jl0zswe6Qteemecj2BkwR7d3rudsD95P59
	 e0ofSb/EKu244ndMSOFHUFMSSoWTYYgttJusTxsXGaRDwS8uTgfu2wHe3hd4lqTFM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew1KaAGW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C7606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ew1KaAGW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C6B1F00A06;
	Wed, 11 Nov 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392420;
	bh=++G2VxxKbsRtJvdsjo1zyPWpF09kyZ+95WGkvwTf7xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ew1KaAGWEDNWJtz3IDfWuSsEHzzUWV6x5cYjjbxwCWi/N87NfcL202r6oykE+ZXxt
	 lttR+zIAohYIRhvH5vHpfDBNwKYM2MinLgG3wIaJoRAjAZXpWqCUpJtk0GY49dwZ9C
	 j7Ufj1MFMrf5iMP8GbJpEoopEQYUWJuKP7SpYYQu0BC0+yi/2TXJpBbqywYs93eNG3
	 PopBWHDKw9BanMGW4u8xjqYxX+zsT5WVTHWVv9OUtUnCwFXymNxXOtVtrhcUroA3zI
	 mzeCmbbrJ8epxkDjgRYNAflCWMR5KktJbrQshhGLPaM/PrBCbexxqCZXgUQwLlcmgq
	 9SdECEDVK1kZg==
Message-ID: <sashiko-outbox-208777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next v2 3/4] xdp: split generic XDP skb handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110101941.1059662-4-sst@poczta.fm>
References: <20261110101941.1059662-1-sst@poczta.fm>
 <20261110101941.1059662-4-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:20:19 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] xdp: netif_skb_check_for_xdp() drops shared skbs in
  pskb_expand_head()
- [Medium] xdp: netif_receive_generic_xdp() mutates shared skb before
  CoW
--

commit 154810a21d3faf42403d1f38f7f61c4add271315
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

xdp: split generic XDP skb handling

This commit introduces __do_xdp_generic() and struct xdp_generic_ctx so
callers can supply their own xdp_buff, page_pool, and xdp_rxq_info, and
adds skb_shared(skb) to the generic XDP copy-on-write check via
skb_needs_xdp_cow().

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 12595f6b9eba7..81848e638173b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -5774,15 +5779,31 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb,=
 struct xdp_buff *xdp,
>  	return act;
>  }
> =20
> +u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> +			     const struct bpf_prog *xdp_prog)
> +{
> +	return __bpf_prog_run_generic_xdp(skb, xdp, xdp_prog, NULL);
> +}
> +
>  static int
> -netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *pr=
og)
> +netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *pr=
og,
> +			struct page_pool *page_pool)
>  {
>  	struct sk_buff *skb =3D *pskb;
>  	int err, hroom, troom;
> =20
> -	local_lock_nested_bh(&system_page_pool.bh_lock);
> -	err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb=
, prog);
> -	local_unlock_nested_bh(&system_page_pool.bh_lock);
> +	if (page_pool) {
> +		/* veth, the caller with its own page_pool, limits the MTU so
> +		 * that the copy is linear even for programs without frags
> +		 * support, and always copied into its page_pool.
> +		 */
> +		err =3D skb_pp_cow_data(page_pool, pskb, XDP_PACKET_HEADROOM);
> +	} else {
> +		local_lock_nested_bh(&system_page_pool.bh_lock);
> +		err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool),
> +					   pskb, prog);
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
> +	}
>  	if (!err)
>  		return 0;
> =20
> @@ -5800,9 +5821,22 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, con=
st struct bpf_prog *prog)
>  	return skb_linearize(skb);
>  }
> =20
> +/* Run the program on a private, page_pool-backed copy when it could oth=
erwise
> + * change data someone else sees (shared or cloned skb), when frags have=
 to be
> + * page_pool-backed so that XDP helpers can release them, or when the XDP
> + * headroom contract is not met. The head does not have to be a page fra=
g:
> + * skb-backed XDP never turns the head into an xdp_frame.
> + */
> +static bool skb_needs_xdp_cow(const struct sk_buff *skb)
> +{
> +	return skb_shared(skb) || skb_cloned(skb) || skb_is_nonlinear(skb) ||
> +	       skb_headroom(skb) < XDP_PACKET_HEADROOM;
> +}

[Severity: Medium]
Does adding skb_shared(skb) here cause do_xdp_generic() to warn and drop
shared skbs when running a non-frags XDP program?

When page_pool is NULL (as in do_xdp_generic()) and
!prog->aux->xdp_has_frags, skb_cow_data_for_xdp() returns -EINVAL without
copying the skb.  netif_skb_check_for_xdp() then falls back to
pskb_expand_head(skb, ...), which rejects shared skbs with
DEBUG_NET_WARN_ON_ONCE(1) and -EINVAL:

net/core/skbuff.c:pskb_expand_head() {
	...
	if (unlikely(skb_shared(skb))) {
		DEBUG_NET_WARN_ON_ONCE(1);
		return -EINVAL;
	}
	...
}

Any shared skb (for example from pktgen with F_SHARED or after a packet
tap takes a reference before an rx_handler returns RX_HANDLER_ANOTHER) is
then dropped at do_drop instead of being unshared.

>  static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>  				     struct xdp_buff *xdp,
> -				     const struct bpf_prog *xdp_prog)
> +				     const struct bpf_prog *xdp_prog,
> +				     struct xdp_generic_ctx *ctx)
>  {
>  	struct sk_buff *skb =3D *pskb;
>  	u32 mac_len, act =3D XDP_DROP;
> @@ -5820,15 +5854,17 @@ static u32 netif_receive_generic_xdp(struct sk_bu=
ff **pskb,
>  	mac_len =3D skb->data - skb_mac_header(skb);
>  	__skb_push(skb, mac_len);
> =20
> -	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> -		if (netif_skb_check_for_xdp(pskb, xdp_prog))
> +	if (skb_needs_xdp_cow(skb)) {
> +		if (netif_skb_check_for_xdp(pskb, xdp_prog, ctx->page_pool))
>  			goto do_drop;
>  	}
> =20
>  	__skb_pull(*pskb, mac_len);

[Severity: Medium]
Doesn't __skb_push(skb, mac_len) before skb_needs_xdp_cow() corrupt
skb->data and skb->len for other holders of a shared skb?

Unlike a cloned skb, a shared skb shares the struct sk_buff itself.  When
skb_pp_cow_data() replaces *pskb with a newly allocated nskb and calls
consume_skb(skb), the subsequent __skb_pull(*pskb, mac_len) only pulls
mac_len on nskb (and is skipped altogether on the goto do_drop path),
leaving the original shared skb with skb->data pushed back by mac_len and
skb->len increased by mac_len for any remaining reference holders.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110101941.1059=
662-1-sst@poczta.fm?part=3D3
