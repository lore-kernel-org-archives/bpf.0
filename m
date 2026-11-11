Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392564;
	b=xQr90SYLEfOMCTIIDQzwcAAZ5L7ATsS0dFQSVlmm37SH7gV29l91DYoXM0o7D6dIJQfO
	 i57aF9l+PM2nwW+hiQpd9e9hKUdkQsxzuaEMNk8kJucSwNtoGi/2LecTd3p+l6i5bE5f0
	 UKIDfSFvZcnrq+4kjePyCX5LwJfOVmtN4LdxTG4ZSwcxD2N23ye8gTNxa5IPwyTw3IYLg
	 Z4eArOp95+aQzdIQnWlzch5nPO9NdIr2WABSm8VuuYSNG93fCn2RaUmSs92eAOX6pgaaD
	 sDy8oweogHnuHiWkXwrQekMk2khaP3/pz79Wp/lYzWE+KEdF645RJQaAec74DoisbIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WjrZIxf0N4M/+nww3k9PiDCVC/m4XNu1JuSUDw7XJAw=;
	b=Hd9kt958yG487vWb07hR3CnD1KqfZfZW7JPl2Yth5Jt2jbzORVCJPCB5V7yn8ashqR2x
	 jVuxld1HvNewpiswELKmWwm7Eb0y0ggr279aYKRrrLoa4/XRKbRP7aB/K3h8kTt6SnYRf
	 lVjEnIfJ3FYOZZis+2ZEaf/VcmdQ8/cB+Tu0DCqb/k+u7cjbhvfC08KbJncKHFpyGLjYl
	 UfY0T8PYUNg0g51U8f5irzTJRos7e+o4n9RrtkUkV1MF/N8Rzi+5Leot2MHb9CO8wEwid
	 /JeBxV9oQkMkR5eM6TMQh2PfwLn5vX3CMkZD5J18zv8Uc4d8d2/iR3RbDFyn3MCLKog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDEyGT8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81B606A32E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDEyGT8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313E11F00A06;
	Wed, 11 Nov 2026 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392564;
	bh=WjrZIxf0N4M/+nww3k9PiDCVC/m4XNu1JuSUDw7XJAw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jDEyGT8aRgPCm5X2meBxRaEFsdcJkD6fEVAcG3ojrZBQYLTSo/fYN7gZQLedjwRsL
	 +h24KKnOQgPC6m+vcOJRfDT0j5w9PDoe9ZZw9EDCHG/XzFP+j2dybzIAvVl+n4n5dK
	 I3owFMHvT0vo0SZMzf44QlveLFlDDklSxnYjBDw1+NOH9Q5Fau4PD2eHoL0BNoa3Q7
	 Sq99JA9thUSF0UFTkLM0SoOlNnaKbi9qps1/ZR6GdrBk1PiiU1qExqHHnbtwx5FzaL
	 UJsBQA8zElKQEtthrPlIdOLDZKNJGZjFOfrko1+a++kvwFcyD/DwWOekOWgZE+TSdT
	 0aZY7Jje7lwpg==
Message-ID: <sashiko-outbox-208786@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-4-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-4-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:43 +0000
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
- [High] xdp: missing xdp_data_meta_unsupported() check in
  xdp_build_skb_from_zc()
- [High] xdp: skb_shared_info overwrite in xdp_build_skb_from_zc() via
  aligned memcpy
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [Critical] bpf: double free and memory leak in xdp_do_redirect() [1]
- [Critical] xdp: double-free in xdp_return_buff() [2]
--

commit b80d3a81c03c102ec5d4e46044e260ec432b9137
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

xdp: Copy buffers with restricted lifetime

This commit adds the MP_CAP_RETAIN memory provider capability and copies XDP
buffers from providers without MP_CAP_RETAIN when building an skb, converti=
ng
to an xdp_frame, or redirecting outside XSKMAP.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 80380f89adf90..f93839b493b25 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4774,12 +4774,28 @@ int xdp_do_redirect(struct net_device *dev, struc=
t xdp_buff *xdp,
>  {
>  	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
>  	enum bpf_map_type map_type =3D ri->map_type;
> +	struct xdp_frame *xdpf;
> +	int err;
> =20
>  	if (map_type =3D=3D BPF_MAP_TYPE_XSKMAP)
>  		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
> =20
> -	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
> -				       xdp_prog);
> +	if (likely(!xdp_buff_needs_copy(xdp)))
> +		return __xdp_do_redirect_frame(ri, dev,
> +					       xdp_convert_buff_to_frame(xdp),
> +					       xdp_prog);
> +
> +	/* Release the source only after the target took the copy. */
> +	xdpf =3D xdp_copy_buff_to_frame(xdp);
> +	err =3D __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);

[Severity: Critical]
This problem wasn't introduced by this patch, but can redirecting a
MEM_TYPE_XSK_BUFF_POOL buffer still double free xdp and leak xdpf [1]
when __xdp_do_redirect_frame() fails?

For MEM_TYPE_XSK_BUFF_POOL buffers, xdp_buff_needs_copy(xdp) is false, so
xdp_do_redirect() takes the xdp_convert_buff_to_frame() ->
xdp_convert_zc_to_xdp_frame() path, which frees xdp via xsk_buff_free() bef=
ore
__xdp_do_redirect_frame() runs.  If __xdp_do_redirect_frame() returns an
error, the allocated xdpf is leaked and the caller frees xdp a second time =
on
its error path.

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 1d679e8fd6493..0cf46d492d91b 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -559,10 +561,41 @@ void xdp_return_buff(struct xdp_buff *xdp)
>  			     xdp->rxq->mem.type, true, xdp);
> =20
>  out:
> -	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
> +	__xdp_return(xdp_buff_head_netmem(xdp), xdp->rxq->mem.type, true, xdp);
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but does xdp_return_buff() ca=
ll
xsk_buff_free(xdp) once per fragment [2] on multi-fragment
MEM_TYPE_XSK_BUFF_POOL buffers?

When xdp->rxq->mem.type is MEM_TYPE_XSK_BUFF_POOL, __xdp_return() ignores t=
he
netmem argument and calls xsk_buff_free(xdp), which frees the head buffer a=
nd
all attached fragments at once.  Looping over sinfo->nr_frags before the fi=
nal
__xdp_return() frees the same xdp_buff 1 + nr_frags times, corrupting the X=
SK
buffer pool.

[ ... ]

> @@ -638,6 +689,9 @@ struct sk_buff *xdp_build_skb_from_buff(const struct =
xdp_buff *xdp)
>  	u32 nr_frags =3D 0;
>  	int metalen;
> =20
> +	if (unlikely(xdp_buff_needs_copy(xdp)))
> +		return xdp_build_skb_from_zc(xdp);

[Severity: High]
Does delegating to xdp_build_skb_from_zc() drop the first byte of the packet
when xdp_data_meta_unsupported(xdp) is true?

When a driver passes meta_valid =3D=3D false to xdp_prepare_buff(), or calls
xdp_set_data_meta_invalid(), xdp->data_meta is set to xdp->data + 1.  Unlike
xdp_copy_buff_to_frame(), xdp_build_skb_from_zc() does not check
xdp_data_meta_unsupported(xdp):

net/core/xdp.c:xdp_build_skb_from_zc() {
	const struct xdp_rxq_info *rxq =3D xdp->rxq;
	u32 len =3D xdp->data_end - xdp->data_meta;
	...
	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);

	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));

	metalen =3D xdp->data - xdp->data_meta;
	if (metalen > 0) {
		skb_metadata_set(skb, metalen);
		__skb_pull(skb, metalen);
	}
}

With xdp->data_meta =3D=3D xdp->data + 1, this copies from xdp->data + 1, s=
ets
skb->len one byte short, and skips __skb_pull() because metalen is -1,
corrupting the packet header on XDP_PASS.

[ ... ]

> @@ -781,7 +835,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
>  		goto out;
>  	}
> =20
> -	xsk_buff_free(xdp);
> +	xdp_release_copied(xdp);

[Severity: High]
Can the LARGEST_ALIGN(len) memcpy in xdp_build_skb_from_zc() overwrite
skb_shinfo(skb) when copying a buffer that reaches xdp_data_hard_end(xdp)?

In xdp_build_skb_from_zc(), napi_build_skb(data, truesize) initializes
skb_shinfo(skb) at data + truesize - SKB_DATA_ALIGN(sizeof(struct
skb_shared_info)), and then:

	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);

	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));

When truesize equals xdp->frame_sz, skb->end is at the same offset from data
as xdp_data_hard_end(xdp) is from xdp->data_hard_start.  If an XDP program
adjusts xdp->data or xdp->data_meta to an offset that is not 16-byte aligned
and the head buffer is full up to xdp_data_hard_end(xdp), LARGEST_ALIGN(len)
extends up to 15 bytes past skb->end and overwrites skb_shinfo(skb) (includ=
ing
nr_frags and frag_list) with bytes from xdp->data_end.

[1] https://sashiko.dev/#/bug/linux-c51b4a6d-8f07-471a-858e-04053743c6d2
[2] https://sashiko.dev/#/bug/linux-ad1513d6-3423-4560-95ce-a92871813ba4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D3
