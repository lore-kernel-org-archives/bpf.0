Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598026;
	b=i/s97h//LX+BX6FkhccGvjopqU9oFuiINZ3i0Ap3hxCUc9jN70PKqUGXh/QjH/MR6MsS
	 gViUrGPC7QDj1ytiYhblL30k9BLqbTa4GMAhpomS9E85bZqEZvKdxzgEzUP1jJV+NXWwf
	 ++/O3uLXjlu5mRENOkRXF/W8SXTgrx6XVzl/nOetAPmmLOL39Fao2qojta6KrHymZazED
	 oFZUtHdB4nK3WMDD/YOT5Qr0z4MGYLF2AO0JJv+zzEdtGfek8SQ+7oYPUiQxpaoWSfgLH
	 oqKIHZRH8UsNf5cSpO/9DcJTm4gdodcM+BlUyuXZpGUuMbrje/Jb18oVh5RUkRFZmEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s3N7zSxxy3oFanC6LqbJJJs7873J+/xedsS3FSkPFf4=;
	b=fYwX+3hbMkomgLGC3h8J9XKuZWUm7aXc7o4AucDo6EulYRzgPvBY8fzn5zCkKLu3sK8/
	 MlrTaphriOyWTPTxQ+OnKo8m+sOCv363d4NSjoIuBmUXoOxZxsEK8OgRs7jl7l94uoHDI
	 Gn58qc1j2PLiyaGKplTzFKp9lY1Zjm3Flb/wrylqNqfIvlFDTQLum8nQ1TFXOzdCJPHz1
	 PUT3E3kBlaMzC2y6bCDHOHRBdxhkXZnjoZaCmU1/xZfJsPspv7HiavWKGJN3AhqXQ+cGj
	 zCbttx6n1D78PSYCC5k1I/kgxdEm03UiajC5rjiYNyiJ27E0mrqLxdIi5fB3SV2xbMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjzyQvBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B80606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjzyQvBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189FB1F000C1;
	Wed, 21 Oct 2026 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792598025;
	bh=s3N7zSxxy3oFanC6LqbJJJs7873J+/xedsS3FSkPFf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AjzyQvBoKgqCOpBkGydUEhyv/24LVJJL8e3uaa9J7uACANU4AS+dNsx9wJSzxI/tV
	 ePBsNcTgdXvaliI5LUpzc79cRLH7g7mnppwmFf2bKOmz9HCRR0HCDR+rtbeKtpyqXZ
	 B3vsJSc5VZ/8ogGAakz+sGphvRPAG9Fh07/7cw/dCcpb9yp8TtvOH6VZrOE7o8yWRv
	 srsAVlKKvy5D0/LljvTWcIXpFOigZoprUCH51jVuMHWy00ScoPUrdeM+I8ezEU0N2n
	 yUvFu8jBS26y11j6vDxGrFoBYmTGb5DYA+EctCs4y2x3MllkGnc/VqLkyElWP3lAG4
	 hrG9cujYD0Ivg==
Message-ID: <sashiko-outbox-180445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] net: gso: validate transport header before computing
 segment length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 15:53:44 +0000
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
- [High] net: gso: xfrm crypto offload tunnel TSO packets dropped in xfrm_o=
utput()
--

commit 2d1a1b977a36e13803c1238022fb971e13c956c9
Author: Michael S. Tsirkin <mst@redhat.com>

net: gso: validate transport header before computing segment length

This commit validates that the TCP transport header is set and lies within
the linear data area of the skb before reading it to compute GSO segment
lengths, returning an error so the caller treats the packet as not fitting
when the check fails.

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index d6894f463bf43..11c8b295bd260 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3041,6 +3041,13 @@ static inline bool skb_inner_network_header_was_se=
t(const struct sk_buff *skb)
>  	return skb->inner_network_header > 0;
>  }
> =20
> +static inline bool skb_inner_transport_header_was_set(const struct sk_bu=
ff *skb)
> +{
> +	typeof(skb->inner_transport_header) th =3D skb->inner_transport_header;
> +
> +	return th > 0 && th !=3D (typeof(th))~0U;
> +}
> +
>  static inline unsigned char *skb_inner_mac_header(const struct sk_buff *=
skb)
>  {
>  	return skb->head + skb->inner_mac_header;
> @@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const struc=
t sk_buff *skb)
>  	return skb_transport_header(skb) - skb->data;
>  }
> =20
> +/* Is the (inner) transport header, as specified by
> + * skb->transport_header/inner_transport_header, in the linear data?
> + */
> +static inline bool skb_transport_header_linear(const struct sk_buff *skb,
> +					       unsigned int hlen)
> +{
> +	int thoff;
> +
> +	if (!skb_transport_header_was_set(skb))
> +		return false;
> +
> +	if (skb->encapsulation) {
> +		if (!skb_inner_transport_header_was_set(skb))
> +			return false;
> +
> +		thoff =3D skb_inner_transport_offset(skb);
> +	} else {

[Severity: High]
Does requiring skb_inner_transport_header_was_set(skb) whenever
skb->encapsulation is set cause a regression for IPsec tunnel mode TSO
packets using hardware crypto offload (XFRM_DEV_OFFLOAD_CRYPTO), causing
them to fail MTU validation and be dropped with -EMSGSIZE?

When an unencapsulated TCP GSO packet (where skb->inner_protocol is 0 and
skb->inner_transport_header is 0) enters xfrm_output() for a tunnel-mode
state with hardware crypto offload, skb->encapsulation is set before the
inner headers are recorded:

net/xfrm/xfrm_output.c:xfrm_output() {
    ...
		xfrm_get_inner_ipproto(skb, x);
		skb->encapsulation =3D 1;

		if (skb_is_gso(skb)) {
			if (skb->inner_protocol && x->props.mode =3D=3D XFRM_MODE_TUNNEL)
				return xfrm_output_gso(net, sk, skb);

			skb_shinfo(skb)->gso_type |=3D SKB_GSO_ESP;
			goto out;
		}
    ...
}

From there, the call chain proceeds through:

  xfrm_output2()
    -> xfrm_output_resume()
      -> xfrm_output_one()
        -> xfrm_outer_mode_output()
          -> xfrm4_prepare_output() / xfrm6_prepare_output()

In xfrm4_prepare_output() (and similarly in xfrm6_prepare_output()),
xfrm_inner_extract_output() runs before xfrm4_tunnel_encap_add():

net/xfrm/xfrm_output.c:xfrm4_prepare_output() {
	int err;

	err =3D xfrm_inner_extract_output(x, skb);
	if (err)
		return err;

	IPCB(skb)->flags |=3D IPSKB_XFRM_TUNNEL_SIZE;
	skb->protocol =3D htons(ETH_P_IP);

	switch (x->props.mode) {
	case XFRM_MODE_BEET:
		return xfrm4_beet_encap_add(x, skb);
	case XFRM_MODE_TUNNEL:
		return xfrm4_tunnel_encap_add(x, skb);
	}
    ...
}

xfrm_inner_extract_output() invokes xfrm4_tunnel_check_size() (or
xfrm6_tunnel_check_size()), which calls skb_gso_validate_network_len():

net/xfrm/xfrm_output.c:xfrm4_tunnel_check_size() {
    ...
	if ((!skb_is_gso(skb) && skb->len > mtu) ||
	    (skb_is_gso(skb) &&
	     !skb_gso_validate_network_len(skb, ip_skb_dst_mtu(skb->sk, skb)))) {
		skb->protocol =3D htons(ETH_P_IP);

		if (skb->sk && sk_fullsock(skb->sk))
			xfrm_local_error(skb, mtu);
		else
			icmp_send(skb, ICMP_DEST_UNREACH,
				  ICMP_FRAG_NEEDED, htonl(mtu));
		ret =3D -EMSGSIZE;
	}
    ...
}

However, skb->inner_transport_header is only initialized afterwards in
xfrm4_tunnel_encap_add() (and xfrm6_tunnel_encap_add()):

net/xfrm/xfrm_output.c:xfrm4_tunnel_encap_add() {
    ...
	if (!skb->inner_protocol) {
		skb_set_inner_network_header(skb, skb_network_offset(skb));
		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
	}
    ...
}

Because skb->encapsulation is already 1 while skb->inner_transport_header
is still 0 during xfrm4_tunnel_check_size() and xfrm6_tunnel_check_size(),
won't skb_transport_header_linear() return false, causing
skb_gso_validate_network_len() to fail and dropping the packet with bogus
fragmentation needed / packet too big errors?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/52b8bfe4ee848aff8ac=
e47752352de486171d45f.1792596586.git.mst@redhat.com?part=3D1
