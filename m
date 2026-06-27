Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277AC8834
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579140; cv=none; b=u0tAD1fgHTtlIXWQzP/FPjHOaS+BZdpZriEwuHUBSF4zmDpAW9eu1/ZQtJkOblJTU2IiCqJe3MIs85jRNSZWlN6oeOsPlUeM+PZjMSyzVfrv/joycEcp7VMnDakMCWQvL8yRJw6Q+ToGUADQms30f9mG/1POWpRP7jkXjsAXHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579140; c=relaxed/simple;
	bh=ccElXFuckdeHsckfY/jGHwaWz8iMQhTpdzO73pSFodg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BztiaIwvuEJSRJmTsfkqV7SCqZxaHJoQfmlPrQzS5ZaZx5IClRxoB9Z+O0dGoZX1iA1b3k0Djt7ONlX3QUTZ5N9ehA5kIJdwm4ZosHZw9ocXHmNKNt+o9/ldEURnXZn5AH/32DSAVWIW+luR3Z9C4rwObcQX+t8swBNLdEtIvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiM4bW8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiM4bW8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959371F000E9;
	Sat, 27 Jun 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579138;
	bh=Z26RWF1Vp7Qjkx6DJGqyHBMUCAVE63f3RY75jOpJ5O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OiM4bW8v7W9sAuxoaeU0DrhLsk25yVj3kLO7Ho8fNrBUcm5Vu3/iTWGragILBHyKR
	 BefLgfrkfEKxoeoK5UpmovVPaPmMKOsPkNyInmrT+GFVY+9AvT4n0CsbtEHhyaSoyN
	 dNqzT0DXAscnvbhA5ErMBq4cVwt29IOn0/s3PH5UgdhzKrKERDKFMdH/6nc3DSSb3W
	 NwgQMtwPnyLxLfdcdf+eTYTYFfMuJne2VRDEAdHXffF9aP6R95ixmygwbRDypEpHrm
	 G6VBgpbWXdlp3Y9IuZMluG/mubZ/KjDOWX47ieEGOpEeyorEsBU1vk+qBjGp6B/uut
	 n+F2ZnsnTjJuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626165156.169012-2-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
 <20260626165156.169012-2-jhs@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 16:52:18 +0000
Message-Id: <20260627165218.959371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch moves `bpf_net_context` initialization to `__dev_queue_x=
mit()`, but fails to handle asynchronous qdisc enqueue operations (e.g., vi=
a `netem`'s `dequeue` function), leaving a NULL pointer dereference unaddre=
ssed when qevents execute during `net_tx_action()`.
--

commit 804facd8bc23cc276a2c5ce958a8503b7b036912
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net: Extend bpf_net_context lifetime to cover qdisc enqueue

This commit moves the bpf_net_context lifecycle management from
sch_handle_egress() to __dev_queue_xmit(). The intent is to cover the
qdisc enqueue phase so that a qevent filter returning TC_ACT_REDIRECT can
safely call skb_do_redirect() without triggering a NULL pointer dereference.

Closes: https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojata=
tu.com

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4b3d5cfdf6e00..8c214bfff8aa9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -4795,6 +4791,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct ne=
t_device *sb_dev)
>  	skb_update_prio(skb);
> =20
>  	tcx_set_ingress(skb, false);
> +#ifdef CONFIG_NET_XGRESS
> +	bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);
> +#endif

[Severity: High]
This is a pre-existing issue, but does this patch fully cover asynchronous
qdisc enqueue operations?

While this patch successfully covers synchronous enqueue via
__dev_queue_xmit(), the bpf_net_context might still be uninitialized during
asynchronous qdisc operations driven by the net_tx_action() softirq.

For example, if netem delays a packet, its dequeue function is called
asynchronously from net_tx_action() in net/core/dev.c, which runs
qdisc_run() without setting up a bpf_net_context. The netem_dequeue()
function then enqueues the packet to its child qdisc.

If that child qdisc evaluates a qevent and the attached BPF filter calls the
bpf_redirect() helper, the helper invokes bpf_net_ctx_get_ri() in
include/linux/filter.h:

struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();

if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {

Since net_tx_action() did not initialize the context, current->bpf_net_cont=
ext
is NULL, resulting in a kernel panic when accessing bpf_net_ctx->ri.

Although a later patch ("net/sched: Handle TC_ACT_REDIRECT from qdisc filter
chains") addresses the crash in skb_do_redirect(), does it prevent the crash
inside the bpf_redirect() helper itself during these asynchronous paths?

>  #ifdef CONFIG_NET_EGRESS
>  	if (static_branch_unlikely(&egress_needed_key)) {
>  		if (nf_hook_egress_active()) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.1690=
12-1-jhs@mojatatu.com?part=3D1
