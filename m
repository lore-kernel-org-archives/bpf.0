Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890914BF92
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781958663; cv=none; b=d+mPab0xMdqRIX6izWmyLvolL556dAIN7UQKSf+6nocl507dxTCFlbn4FqDxdvo4vGCxSY0EV4tuLUFVbNccv6ZZX8m7shcmBRXmGfw0CRmGi3JpiIcjag6sNALOdqSinY8MxgITtq4ZlIiGCktFIdpaHK5GbYlQLsyG3A3U4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781958663; c=relaxed/simple;
	bh=haSHfzm3mu15Uw3ds1HN5ftXE6i3IZD+XBUTI8x2V7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mp5WnFXkgI3V9gzdYf3OSQQ0cLi/HW7wydJLndJzdhQDdUopiK5EKP89xsE4ehC9d+1dIVbur2G2RbVu9kmk85G0a9M+C9nZCcx+WNrD+HSJexvbNQ9H/w4mjYftjB73s6aw7zjD1A5v/CvwpRv86YhxsY+TmwmSXGbJs9+ym1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfMTd+Vi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfMTd+Vi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC651F000E9;
	Sat, 20 Jun 2026 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781958661;
	bh=TqMEAXJK3T/5u/KjokGP/7RtoQFgb4yWvF8IUjn97Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BfMTd+Vi5cj7EV2hMzYdoZcEnAeLNjWvRJ7ORQf3z+SiX2+SzLwJcmQ+oXPmWC9KJ
	 uz3KnOWyg+2myUGEUKYH0sWZr5w8y6BrjdC6O4PfpKo8L8oUS65Hfblsiqq1lQ6VQC
	 Wwi4GbquPfb8FJfG9YKHJJ8jXKpjZEABJvhrs+MGTXgvoRUZvgdAyZcKTLinv0LiEN
	 qqjt4eIOLrL04dT/2FIbmkKx7WkxbSU3O7NiLf2kpsdpX2hw8BBEh2xsMJGCVLoqnA
	 VgXpawAA4ZY2LAgojHsAjaQny5hOhKnfqiDvbNfKhlRlS24Q3B/X5fr67vMecjlinx
	 G571r6JBADABg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth C" <siddharthcibi@icloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620121321.45227-2-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
 <20260620121321.45227-2-siddharthcibi@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 12:31:01 +0000
Message-Id: <20260620123101.AEC651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized `rx_queue_index` in `struct xdp_frame` constructed b=
y the BPF testing framework causes a kernel memory information leak.
--

commit f1285cd92bd58ea552eb0b340894db477870968e
Author: Siddharth C <siddharthcibi@icloud.com>
Date:   Sat Jun 20 12:13:13 2026 +0000

    bpf: preserve rx_queue_index across XDP redirects
   =20
    Store rx_queue_index in struct xdp_frame during xdp_buff to
    xdp_frame conversion and restore it when rebuilding xdp_rxq_info
    for cpumap and devmap execution paths.
   =20
    This preserves ingress RX queue information for XDP programs
    executed after redirect, allowing access to the original
    rx_queue_index instead of losing queue context.
   =20
    Also propagate rx_queue_index for zero-copy XDP frame conversion.
   =20
    Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>

> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 5e59ab896f058..8f2d7013620f7 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_ma=
p_entry *rcpu,
> =20
>  		rxq.dev =3D xdpf->dev_rx;
>  		rxq.mem.type =3D xdpf->mem_type;
> -		/* TODO: report queue_index to xdp_rxq_info */
> +		rxq.queue_index =3D xdpf->rx_queue_index;

[Severity: High]
Can this leak uninitialized kernel page memory via ctx->rx_queue_index when
using BPF_PROG_TEST_RUN?

The BPF testing framework uses xdp_update_frame_from_buff() to initialize
mock frames in net/bpf/test_run.c. Because xdp_update_frame_from_buff()=20
only copies sizes and pointers, test_run manually copies mem_type but was
not updated by this patch to initialize rx_queue_index:

net/bpf/test_run.c:xdp_test_run_init_page() {
    ...
    xdp_update_frame_from_buff(new_ctx, frm);
    frm->mem_type =3D new_ctx->rxq->mem.type;
    /* Missing: frm->rx_queue_index =3D new_ctx->rxq->queue_index; */
    ...
}

It is also missed in the context reset path:

net/bpf/test_run.c:reset_ctx() {
    ...
    xdp_update_frame_from_buff(&head->ctx, head->frame);
    head->frame->mem_type =3D head->orig_ctx.rxq->mem.type;
    /* Missing: head->frame->rx_queue_index =3D head->orig_ctx.rxq->queue_i=
ndex; */
}

If a tested BPF program returns XDP_REDIRECT to a cpumap or devmap, the
map execution reconstructs the xdp_rxq_info using the uninitialized
xdpf->rx_queue_index field. A chained BPF program executing on the map
could then read ctx->rx_queue_index, exposing 4 bytes of uninitialized
kernel page memory.

Should net/bpf/test_run.c be updated to initialize rx_queue_index?

> =20
>  		xdp_convert_frame_to_buff(xdpf, &xdp);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620121321.4522=
7-1-siddharthcibi@icloud.com?part=3D1
