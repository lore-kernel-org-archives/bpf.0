Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD1432304
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558995; cv=none; b=NXjINKVWIJkdgFFFnIJS5AKQnELkdM4MWgCAIFqGmjOonTRRlU1lAeAu+LF96JOAYahQzJ2uQwArEklcmkV0crWX5TmH2+w8TEMRdi5kZEUxhfBgVkbybshY0pWmLzCS0VN7XPNuOJ47hUkS5oLIW6Hi6qB7UsoPtm62GA7N6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558995; c=relaxed/simple;
	bh=3JdXz46nMatUQfuwWtmRIICVBNhzvoTZk5tGJMdjJeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TOa7fHb4fkPRouS4W2FNlQ0VaVnoEO248ad3vz68iL4hBNYyoN0f6rwmziZ683bYrjSVAeqyvs2oEBVKBPCX+jOox0UD6szWo24fy/+GjanFERvoF1EHvUuRNHh920PWlbf3NZ9wKEWdGr/kttoFnLKiptE6xViWpW2GoDyi0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUhakuoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUhakuoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343001F00A3E;
	Fri,  4 Sep 2026 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558992;
	bh=5GUHV/UVZvri1+7R91qr0mzJzcTq3gXNw9Bzge3Fm3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUhakuoQbw0IDnDGcm1GJ6cJHFaeFpk6Wsx28zDOdlA/697lSO/B8ym60SbAKNa5/
	 07/z2RcCLn4aUi3npDchKl2Ww6+09u0GcjjWH0JRoikAXP0r3QGvAirhQaosvB1q2B
	 4ST+oxuK1PIFg0XF0pSXkNNTzu+F+ChEpA9/3iqEH9cAB8vM2DzuJ33lbtQzRxTri2
	 ObiUoHuhcGld68NQkBRoh273EsTzJ4FGhBYdGvzMRSY0IPbCP/mAO0sUwnSJJakw89
	 j2N68KyaVEvs6BDGfwMrbvjOZREumjOjyfM4khbSJTipweHVv+VtHb30eFSzekvSqL
	 +Wxp++RUJjMvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 06/12] gve: simplify reset logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903215606.31633-7-hramamurthy@google.com>
References: <20260903215606.31633-1-hramamurthy@google.com>
 <20260903215606.31633-7-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:56:31 +0000
Message-Id: <20260904215632.343001F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AF_XDP (XSK) pools configuration is silently dropped during device=
 reset, breaking the zero-copy datapath.
--

commit 5f54ed314a139ce612a748bc097cf6b6779ac055
Author: Joshua Washington <joshwash@google.com>
Subject: gve: simplify reset logic

This commit simplifies the GVE reset path by removing recursive resets,
removing resets during teardown, and decomposing the allocation and setup
of control plane systems. It delays freeing shared resources until after
a hardware reset completes if device deconfiguration fails.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 16ce55c6d74f6..acd09e9f416c1 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -590,7 +594,22 @@ static void gve_free_notify_blocks(struct gve_priv *=
priv)
[ ... ]
> +static void gve_free_control_plane_resources(struct gve_priv *priv)
> +{
> +	bitmap_free(priv->xsk_pools);
> +	priv->xsk_pools =3D NULL;
> +
[ ... ]
> +static int gve_alloc_control_plane_resources(struct gve_priv *priv)
> +{
[ ... ]
> +	priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);
> +	if (!priv->xsk_pools) {
> +		err =3D -ENOMEM;
> +		goto abort;
> +	}
> +
> +	return 0;

[Severity: High]
This is a pre-existing issue, but does unconditionally freeing and
reallocating the xsk_pools bitmap during a device reset drop the AF_XDP
pool configuration?

When gve_reset() is triggered (for example, by a TX timeout or an MTU
change), it calls gve_teardown_device() which leads to
gve_free_control_plane_resources() unconditionally freeing the bitmap.
During recovery, gve_alloc_control_plane_resources() allocates a fresh
zero-initialized bitmap.

If an application was actively using the XDP zero-copy datapath, wouldn't
gve_reg_xdp_info() subsequently find no registered pools and silently fall
back to standard page pools, breaking the application's zero-copy packet
flow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903215606.3163=
3-1-hramamurthy@google.com?part=3D6
