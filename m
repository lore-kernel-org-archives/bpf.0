Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283821;
	b=DCcSln2YHvgbk5KYlUA1whyVOQaOpsEw2eQgsgD3y5ttUohTGYO7QA6ry/vEziavvaI1
	 xHLAmjxnTENXqn0nIRQs4J07m06y5MDgbCOzwzIMLnDx8aGf/aEDZkQkJ5Db3SqI0Es30
	 YbYb17O2RggOYAl9pX6Kgc2B7KxpbxNrZPJITq1lGhEISGn+mM0daP4LJfRjmkoUOjfYe
	 Ys7gswLw0cmAi5O27UyohrI6EEM8WB6i009kgOidm4iee04S9Sew73fGxsjqdSIAc5hw5
	 /TTJ8EVPeiCwzKaTMdTi2kRzm+WB5dWiHiN4a5ajz3XThWJrqBbyY2qvKzCTx7+hylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283821;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=miTH91FU73AzmU2Fuek8eqWk6PC6BVPMe1SNLQf3Dv0=;
	b=iG4JOPJ6uR+ar9W7lfcxmPtslw/OCzhDuQsF15C/4Cq8K103m8RTCelrLws7L1T/c4Ur
	 xIEFvtLXOIBLIEPKXZZaJLhfmFozRy8pAttZvHTSerhKXNuu5wHtQ3lvNdHF8eNAZ8pG6
	 stszOjCnxt1YyE5hD2/D344oKJHCwtqtzN6yRslaqiKzZpcmVH/NJSXuO10LTJbwRTACE
	 44B+4OVnu1PCif63a9KN+hyiQNqOSO5jjTyCQB5IVOLhUm4bpA9dGiCLouHgWibr9nktu
	 RGIP764mQKNe70UdMNjF63DY9g84WtChKhKlolKPw7kvYpsGdfumoz0m8XvG4sIIS3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIDb4p9A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3D606CF08
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIDb4p9A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AC81F00921;
	Tue, 10 Nov 2026 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283820;
	bh=miTH91FU73AzmU2Fuek8eqWk6PC6BVPMe1SNLQf3Dv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IIDb4p9ABoTBZlbesk2GEWzOSmQ4ZaquEP1t1jtKRawps/67ga0LA0aVwBlgpQfY1
	 UwjCGKK0cXP4A8OcLzOkjttq+sOS9r2rG1ovZCdVl5SkpWv99hZJUwRtNfqqwKEiIL
	 BxoOse/Sfc43T0E9Xa++2FbQ39TbxPgaamM6Rk8iA4hxlqtn2wy4h30BYourN0zkUc
	 5n49vUSBbKhdML3ZPXhSaVGSTMMI4LYsTaNcigDrCdM5KSm1a1jrDE6wZ3vbB7O6yX
	 m8Bb2eKcH3ViaCQL5DV9jury7RLI5kyIvOzPuPbQk4um4ehwDkJVRJZRdB8PeyfgTc
	 w9tEr1PEBp1LA==
Message-ID: <sashiko-outbox-206173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/15] xdp: warn on XDP_PASS with stored values
 when XDP runs on an skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Gao" <tianyi@cloudflare.com>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <15f830924c4d06d3d8c7e41fb8a9f8c29b63d9a7.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:10:19 +0000
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
- [Critical] veth: race on rq->xdp_rxq in veth_disable_xdp() [1]
--

commit 7b602275436247ecf1d76650c01ef17cdab5904b
Author: Tianyi Gao <tianyi@cloudflare.com>

xdp: warn on XDP_PASS with stored values when XDP runs on an skb

This commit adds xdp_skb_ext_warn_skb() to warn when an XDP program running
on an existing skb returns XDP_PASS after storing skb extension metadata,
and skips generic XDP in xdp_skb_ext_warn_pass() to avoid warning twice.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index b402f8ed50966..f0d279e2da6a4 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -826,6 +826,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_r=
q *rq,
> =20
>  	switch (act) {
>  	case XDP_PASS:
> +		if (unlikely(xdp_buff_has_skb_ext(xdp)))
> +			xdp_skb_ext_warn_skb(xdp_prog, xdp);
>  		break;
>  	case XDP_TX:
>  		veth_xdp_get(xdp);

[Severity: Critical]
This problem wasn't introduced by this patch, but can veth_disable_xdp()
unregister rq->xdp_rxq [1] while veth_xdp_rcv_skb() or
veth_xdp_rcv_one() is still using it?

drivers/net/veth.c:veth_disable_xdp() {
	for (i =3D 0; i < dev->real_num_rx_queues; i++)
		rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);

	if (!netif_running(dev) || !veth_gro_requested(dev))
		veth_napi_del(dev);

	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
}

When detaching an XDP program on a running veth device with GRO enabled,
veth_disable_xdp() skips veth_napi_del(), so neither napi_disable() nor
synchronize_net() runs after clearing rq->xdp_prog:

CPU0                                CPU1 (NAPI)
veth_disable_xdp()                  veth_xdp_rcv_skb()
                                      rcu_read_lock()
                                      xdp_prog =3D rcu_dereference(rq->xdp_=
prog)
  rcu_assign_pointer(rq->xdp_prog, NULL)
  veth_disable_xdp_range()
    rq->xdp_rxq.mem =3D rq->xdp_mem
    xdp_rxq_info_unreg(&rq->xdp_rxq)
                                      bpf_prog_run_xdp(xdp_prog, xdp)
                                      xdp_skb_ext_warn_skb(xdp_prog, xdp)
                                        xdp->rxq->dev->name <-- NULL deref

xdp_rxq_info_unreg() clears rq->xdp_rxq.dev to NULL and resets
rq->xdp_rxq.mem.type while the NAPI poll is still running with xdp->rxq
pointing to rq->xdp_rxq.  Beyond the NULL pointer dereference on
xdp->rxq->dev (here or when the BPF program reads ingress_ifindex), this
also causes page_pool leaks or use-after-free when frames are redirected,
transmitted, or freed.

[1] https://sashiko.dev/#/bug/linux-717ec225-ebb9-408c-a2e0-a2698846ef4a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.gi=
t.tianyi@cloudflare.com?part=3D10
