Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582400;
	b=oT291tEDATyYVDhefsOItyhtLYcjUIcOdyimjXRRrLzA/iYV5aYq4cFXrM3ccM8AlQQe
	 09WV8Vb3o0mnmyLLlVnLILdhDQtKlEC3kWmY02aHW1noXVOpvZaH2vcfGUKAhghTL6T3B
	 ztN6H9X7K0eUcOTyw2tps3l5pYG5xvOFbH6yABumlMAtMr2zCmupM6qzJNeMQSXMQU2Ps
	 6+VlbssXzss0ibllujZfj2Tf9JQYMSH9C16jnRYHFD+om021kZ8NsqddeSRFKiALGXwby
	 ccmkwWSG8fj27LVPNVfZHwRdLEVxECaaY8glTPvydRUQeZobwMSzFfeuQOJ4ncjVZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L98w9PEmqazjymAPg1K4CjcJ7948jQ40rylr2ZeVzas=;
	b=JwZVwEUMqM1HvR9MNoy5w9rGf57Zgmpr/d0CGCAF1JLOw0dAq4Hp+hLmTJ9cAQ4zkUNH
	 I+kq4zU4UIRyM2s3LUl0jvkQBrbfEYygyUZkkgSBJYH/9PPye/mpC8m3RitGLwle120z0
	 5YB9jyNEqsdBqUV+sIZVQTsB5Vot+OYEREWMiE5ToJD0RF2anh+QQbHV0H4PF2uwDzXxR
	 ffWmjtwZ4b2AWpWJjaQ/A5ybNif9Qq/gEwVyMirahD2ImylM1qO6soLpRMMcR3odhk0JN
	 gIWOWQyGffcTo5w2qkg3I6rn00R2K0elwEuaUSZEP8rYs9aVgCOES9nI3bqFKqPXZyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAnPSphs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032960A6F60
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAnPSphs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3481F000C7;
	Fri, 13 Nov 2026 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582400;
	bh=L98w9PEmqazjymAPg1K4CjcJ7948jQ40rylr2ZeVzas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAnPSphshCMl9boffR/x///O/FqAXpkLCbrVdpgTOmiuFyGFtnTc3SIlb2ra3McXu
	 oAIzgcDyMttv082QfQF+V3GVNRkMPcqxwjaJna/Ono+E0rM1KiltFRJ+iwkYV0ewRS
	 5q37Qf7w+KQPsCFtiM3x09i8x/oCUyUhEhiFlQJ5YH0Qjuqmwh1kfQXJuiRRFPGFi9
	 EM3a3tAdEOFqnNgAMYZLYSIzgj7xCZAXODswsj9gegjWgdiyOjl2YDh6Qi7XWS4VEo
	 dQTuI0Mc6/jd+cGkRl4AMzFVjXFNiVBvOdhnk+DeOzQ+w0zLnZ0SrYoF9paSIRZDcL
	 HtKjrsaRGjN9w==
Message-ID: <sashiko-outbox-213052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/3] tun: don't disable BHs for the XDP program
 check of every packet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261112150612.3866546-3-antonio@mandelbit.com>
References: <20261112150612.3866546-1-antonio@mandelbit.com>
 <20261112150612.3866546-3-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:06:39 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] tun: ubuf_info reference leak in tun_get_user() [1]
--

commit 1a1e58a937e3b55d0632ff554e804970bf806fab
Author: Antonio Quartulli <antonio@mandelbit.com>

tun: don't disable BHs for the XDP program check of every packet

This commit checks tun->xdp_prog with rcu_access_pointer() in
tun_build_skb() and tun_get_user() so packets on devices without an XDP
program avoid entering an RCU read-side critical section or disabling BHs.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9fc60a73fb963..395923651f312 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1702,13 +1702,12 @@ static struct sk_buff *tun_build_skb(struct tun_s=
truct *tun,
>  	int pad =3D TUN_RX_PAD;
>  	int metasize =3D 0;
>  	int err =3D 0;
> +	bool xdp;
> =20
> -	rcu_read_lock();
> -	xdp_prog =3D rcu_dereference(tun->xdp_prog);
> -	if (xdp_prog)
> +	xdp =3D rcu_access_pointer(tun->xdp_prog);
> +	if (xdp)
>  		pad +=3D XDP_PACKET_HEADROOM;
>  	buflen +=3D SKB_DATA_ALIGN(len + pad);
> -	rcu_read_unlock();
> =20
>  	alloc_frag->offset =3D ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
>  	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
> @@ -1725,7 +1724,7 @@ static struct sk_buff *tun_build_skb(struct tun_str=
uct *tun,
>  	 * of xdp_prog above, this should be rare and for simplicity
>  	 * we do XDP on skb in case the headroom is not enough.
>  	 */
> -	if (hdr->gso_type || !xdp_prog) {
> +	if (hdr->gso_type || !xdp) {
>  		*skb_xdp =3D 1;
>  		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
>  				       pad, metasize);
> @@ -1962,7 +1961,10 @@ static ssize_t tun_get_user(struct tun_struct *tun=
, struct tun_file *tfile,
>  	skb_reset_network_header(skb);
>  	skb_record_rx_queue(skb, tfile->queue_index);
> =20
> -	if (skb_xdp) {
> +	/* Only TAP devices can have an XDP program: don't disable BHs and
> +	 * enter an RCU section for every packet just to find out it's unset.
> +	 */
> +	if (skb_xdp && rcu_access_pointer(tun->xdp_prog)) {
>  		struct bpf_prog *xdp_prog;
>  		int ret;
> =20

[Severity: High]
This problem wasn't introduced by this patch, but does tun_get_user() leak
the msg_control ubuf_info reference when tun_build_skb() consumes the
packet via XDP [1]?

When msg_control is non-NULL but iov_iter_npages() exceeds MAX_SKB_FRAGS,
zerocopy stays false and tun_can_build_skb() can succeed:

drivers/net/tun.c:tun_get_user() {
    ...
	if (msg_control) {
		...
		if (iov_iter_npages(&i, INT_MAX) <=3D MAX_SKB_FRAGS)
			zerocopy =3D true;
	}

	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
		skb =3D tun_build_skb(tun, tfile, from, gso, len, &skb_xdp);
		err =3D PTR_ERR_OR_ZERO(skb);
		if (err)
			goto drop;
		if (!skb)
			return total_len;
	}
    ...
	if (zerocopy)
		skb_zcopy_init(skb, msg_control);
	else if (msg_control)
		net_zcopy_complete(NULL, msg_control, false);
}

If the XDP program in tun_build_skb() returns XDP_DROP, XDP_TX, or
XDP_REDIRECT, tun_build_skb() returns NULL and tun_get_user() returns
total_len without calling net_zcopy_complete().  That permanently leaks the
ubuf_info reference, which exhausts vhost_net virtqueue descriptors and
hangs vhost_net_ubuf_put_wait_and_free() on teardown.

[1] https://sashiko.dev/#/bug/linux-f9997fb6-303f-41d6-93e2-60c392b1856f

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112150612.3866=
546-1-antonio@mandelbit.com?part=3D2
