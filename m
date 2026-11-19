Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096180;
	b=rS/rEOYpMsZNaMWh1LkjL9vinOWkpt794l3s00K5CecG3BZFJDXSWZY1MGBO3w5Y8T8X
	 nqepKCoF2gOUNF46oUYK8dPLNnbIByVGK1NTfyjM3Od7UnYO678wVPvUnWel4o7WCzfYx
	 RJq1KlyegiY697miymmwfhvrnTS7FhxAK46CZrevk3nlGClcDFlnLKIEzeW87tLMhf0+t
	 meLgSlNpOQjkympZBp8tL9s7UEdeuba2Bn/aO6WQklS27F0DPiXXlOs2UI9w1rcKR46gi
	 KfiGcR+eUH6WZ1hjLWsGhZ9ZREeCK4pA4utIPb0DxFVTy2CRnH/FjbQTNRbagLE7AAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096180;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c3NEwYBUb2xMHBi3Kw6LINE0DZWywoT9CPX2LgjHARw=;
	b=FkKJA81SDoBJOqopvrlCCbnB0FeUWCDThDtEZGLP0krmc/B3cy8MV79gyCbFknKsY/hq
	 eeq+BHgglL8NqDbjTLlEe+LTFRbW+4wJCTrk/GOZCcR1FrsFAWgDrLKVtxEOZWvs5yHUU
	 zJdjrgMvvgjAnGY/ug+p+QfNisWbiXPTF+qDZq8CQbJjqTAk46pXYO5VXxeOqnpvKfG9V
	 BTjfe0TJndZvORkh6nna02Ra4UE0P78yoCyAeYTqldU1Z/Vdj1RqaB3+ztuTw2smT0vWU
	 kGRvxL8TbGEjKEhfu+t3Vr1+g/PNKmx6K9iqwf4TI2a87yY8yJVzRcKRqg+cCFOFupA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwOTCsEd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5D606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwOTCsEd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AC81F000C5;
	Thu, 19 Nov 2026 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096180;
	bh=c3NEwYBUb2xMHBi3Kw6LINE0DZWywoT9CPX2LgjHARw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwOTCsEdc/WmbcIHyxF8oVOe1Gd9youkH0qSshWxBazQLYa6SGoyvfEsDy2a6g9F8
	 dGU3OFKXse/vWJbLldp4jt6eJvGSeC7rpNa38LNdzxsrV/VWDkBRERZPLiR9lChXth
	 rgwgE4j47yLwpcilsUFzQT0P42gceU2+nuVbAvTqVpqZmzaNZ0i58SNZM2+t/gdKYP
	 fHlR7ZJDK8XA+a9PLh7CVhZTTu4GHE4jxzLR7Z6wPBmOD1b3WGOLwTBZAVw3MpuDK3
	 ckyjR2XVWzTQSEmVCJ5s5424R2dcP/t0xUg4sHk0j5U7yu6pDyzhwqZXqJRiX4BdhI
	 24eqT0O0AJiNw==
Message-ID: <sashiko-outbox-223211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 bpf 1/5] bpf: test_run: Use a private rxq info for
 XDP test runs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261119133032.2015656-2-sst@poczta.fm>
References: <20261119133032.2015656-1-sst@poczta.fm>
 <20261119133032.2015656-2-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:49:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] bpf: shared lo xdp_rxq.frag_size mutation in
  bpf_prog_test_run_xdp()
- [Low] bpf: non-standard multi-line comment style in
  bpf_prog_test_run_xdp()
- [Low] bpf: missing Fixes: trailer on commit marked for stable backport
--

commit 56f6fcd36def90ece50bcb79a3714bded7c3b347
Author: Slawomir Stepien <sst@poczta.fm>

> bpf: test_run: Use a private rxq info for XDP test runs
>
> bpf_prog_test_run_xdp() runs the program with xdp->rxq pointing to the
> xdp_rxq_info of a real device queue: queue 0 of the loopback device, or
> the queue given by ingress_ifindex and rx_queue_index in the context.
> The frags of a multi-buffer test packet come from alloc_page(), and when
> the program releases one with bpf_xdp_adjust_tail() or
> bpf_xdp_pull_data(), __xdp_return() frees it according to
> xdp->rxq->mem.type. This only works as long as nobody else changes the
> mem type of that shared queue.
>
> The next patch makes generic XDP set the mem type of the queue it runs
> on to MEM_TYPE_PAGE_POOL, since frags it hands to the program come from
> skb_pp_cow_data(). After any packet went through generic XDP on lo, a
> later test run would free its alloc_page() frags as page_pool pages:
>
>   WARNING: include/net/page_pool/helpers.h:305 at __xdp_return+0x828/0x9c0
>   Call Trace:
>    bpf_xdp_adjust_tail+0x8a0/0xd10
>    bpf_prog_..._xdp_adjust_tail_shrink+0xe1/0x101
>    bpf_test_run+0x31a/0xc30
>    bpf_prog_test_run_xdp+0x948/0x1740
>
> and leak the page. Restoring the mem type after generic XDP would not
> be enough, as generic XDP may run on the same queue on another CPU at
> the same time.
>
> Run the program on a private copy of the rxq info instead, with
> MEM_TYPE_PAGE_SHARED, which describes the memory test_run allocates.
> devmap and cpumap already do the same for the programs they run. The
> device and queue index stay the same, so the program sees the same
> ingress_ifindex and rx_queue_index, and xdp_convert_buff_to_md() still
> drops the device reference. Live frames mode does not allow frags and
> uses its own rxq info for the page_pool frames, so it is unaffected.
>
> The problem was found by Sashiko AI review and BPF CI in the review of
> v6 of this series.
>
> Link: https://lore.kernel.org/all/sashiko-outbox-197255@kernel.org/
> Cc: <stable@vger.kernel.org> # 6.4.x
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>

[Severity: Low]
Since this commit is tagged for stable backporting and fixes freeing of
alloc_page() fragments in bpf_prog_test_run_xdp(), should it include a
Fixes: tag?

  Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_x=
dp()")

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index d6c9dc62182ee..6761077586780 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1348,6 +1348,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, co=
nst union bpf_attr *kattr,
>  	u32 repeat =3D kattr->test.repeat;
>  	struct netdev_rx_queue *rxqueue;
>  	struct skb_shared_info *sinfo;
> +	struct xdp_rxq_info rxq;
>  	struct xdp_buff xdp =3D {};
>  	int i, ret =3D -EINVAL;
>  	struct xdp_md *ctx;
> @@ -1426,6 +1427,14 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, c=
onst union bpf_attr *kattr,
>  	if (ret)
>  		goto free_data;
> =20
> +	/* xdp.rxq points to the rxq info of a real device queue, which
> +	 * generic XDP updates for every packet it runs on. Use a private
> +	 * copy with the mem type of the frags allocated below.
> +	 */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a
multi-line comment on its own line, with the comment text starting on the
next line.

> +	rxq =3D *xdp.rxq;
> +	rxq.mem =3D (struct xdp_mem_info){ .type =3D MEM_TYPE_PAGE_SHARED };
> +	xdp.rxq =3D &rxq;

[Severity: High]
Should frag_size =3D PAGE_SIZE also be set on the private rxq copy here
instead of mutating the shared loopback queue's rxqueue->xdp_rxq.frag_size
earlier in bpf_prog_test_run_xdp()?

net/bpf/test_run.c:bpf_prog_test_run_xdp() {
	...
	rxqueue =3D __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0=
);
	rxqueue->xdp_rxq.frag_size =3D PAGE_SIZE;
	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
	sinfo =3D xdp_get_shared_info_from_buff(&xdp);

	ret =3D xdp_convert_md_to_buff(ctx, &xdp);
	...
}

When ctx->ingress_ifindex points to a device queue other than loopback
queue 0, xdp_convert_md_to_buff() switches xdp.rxq to that queue's
xdp_rxq_info, so rxq =3D *xdp.rxq inherits the target queue's frag_size
rather than PAGE_SIZE even though test_run allocates PAGE_SIZE pages via
alloc_page() below.  In bpf_xdp_frags_increase_tail(), a target queue with
frag_size =3D=3D 0 (such as veth or tun) or frag_size > PAGE_SIZE causes
tail expansion to fail with -EOPNOTSUPP, while 0 < frag_size < PAGE_SIZE
can compute a negative tailroom and trigger WARN_ON_ONCE(tailroom < 0).

In addition, writing PAGE_SIZE into the shared loopback queue 0
rxqueue->xdp_rxq.frag_size leaves lo with rxq->frag_size =3D=3D PAGE_SIZE f=
or
later generic XDP runs; if a non-linear skb passes through generic XDP on
lo, skb_pp_cow_data() can allocate sub-page fragments from a shared
page_pool page while bpf_xdp_frags_increase_tail() lets
bpf_xdp_adjust_tail() grow a sub-page fragment up to PAGE_SIZE and write
out of bounds into adjacent fragments.

Passing PAGE_SIZE directly to xdp_init_buff(&xdp, PAGE_SIZE,
&rxqueue->xdp_rxq) and setting rxq.frag_size =3D PAGE_SIZE on the private
rxq copy avoids mutating the shared loopback queue and keeps rxq.frag_size
consistent with the allocated fragment pages.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119133032.2015=
656-1-sst@poczta.fm?part=3D1
