Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85BA1E32CF
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777095632; cv=none; b=F3uyIiteuCcnRcLBvmDlxesEjVgrBrUZdtn0dkgSyaGKC4tiL9Gqymz2dlgZut8HtRoHjzJfu7t0SnOZKosYVn85NvSs9esPZkaSWh8BQkFnwgLwYEqYvvVvx2kbgCD7mD6pWeWPuRHpr6BRQzq2/PcZV118grdPeLTziFiFJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777095632; c=relaxed/simple;
	bh=s1LbMZFvwhntcV5fhtonQ9IwzHmO0YQHqZpOoPHDSXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DBoMsGrodbfTqdaZE4RjG2hh+le3jeRqw93wDyoLao09HQtDc6oPX6NWLsMRsNdiCTE2giRqdyrxSvNzd/KbQaVlHiXg4NRbS+SkbMDnFDKAyJGGmEOKyELv12TZGvo0FHEeUkOKmvpYHay6QTP7dTL27DtenfHyQ1gvq25svo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrSfccUw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrSfccUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A27C2BCB2;
	Sat, 25 Apr 2026 05:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777095632;
	bh=s1LbMZFvwhntcV5fhtonQ9IwzHmO0YQHqZpOoPHDSXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QrSfccUwQMepnKEHErB9uAdozjp12vV+mBDHOHoNuwBpHrfI+cTqA+rkXSVE65flQ
	 hv+Of1PVjr6AuuIEdQPhfQR1wvo8XyD95iX/Ul4YU+rmBiN7YkxivEq0/bSrloccEe
	 QWua1v1YDq62xCdN+iveGBZv0dilP2q2bZG0gnACLbmUPwDN1PUYYRiV9bQKgGOQ2K
	 G0EEucfxSZbJRq+dlWlzhkE7aAo6p69xIVwcWoUerCWDt+eDSLK9G6gVfqdZTr8CSq
	 2JGJVRGvMPcEG7/bY+7ouLOu6pBVDh1gHY5Kdv84tVx5DnMT0oXhH6lrAZ5rwrvOUi
	 QwU8APSI2HBLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424053816.27965-2-kerneljasonxing@gmail.com>
References: <20260424053816.27965-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 05:40:31 +0000
Message-Id: <20260425054032.28A27C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch incompletely fixes the WARN_ON_ONCE in skb_checksum_help=
() triggered by pure-fragment SKBs. It successfully prevents the explicit f=
allback in xsk_skb_metadata() (which wedged the TX ring), but leaves the im=
plicit generic network stack fallback vulnerable. If a user sets XDP_TXMD_F=
LAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device and the hardware checksum o=
ffload is disabled at runtime (e.g., via `ethtool -K eth0 tx off`), the cor=
e stack's validate_xmit_skb() takes over. Because NETIF_F_SG is allowed to =
remain active even without checksum features, skb_needs_linearize() evaluat=
es to false, leaving the SKB unlinearized. The SKB is then passed to skb_cs=
um_hwoffload_help() -> skb_checksum_help(), which hits the exact same WARN_=
ON_ONCE(offset >=3D skb_headlen(skb)) because skb_headlen is 0.
--

commit 86ab0a4900aa60bee0c3df7393a2846b5ff74ccb
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices

This commit attempts to fix a warning triggered in skb_checksum_help()
by AF_XDP pure-fragment SKBs. It rejects sw-csum UMEM binding for
drivers advertising IFF_TX_SKB_NO_LINEAR at setup time.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.=
org/#t
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate fun=
ction")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index cd7bc50872f6b5..d981cfdd853578 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
> =20
> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		return -EOPNOTSUPP;
> +

Does this still leave a path for the warning in skb_checksum_help() to
trigger if hardware checksum offloading is disabled at runtime?

If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device,
and hardware checksum offload is later disabled (e.g., via ethtool -K
eth0 tx off), the core stack's validate_xmit_skb() will take over.

Because NETIF_F_SG can remain active even without checksum features,
skb_needs_linearize() evaluates to false, leaving the SKB unlinearized.

The SKB is then passed to skb_csum_hwoffload_help() which falls back to
skb_checksum_help(). Since the pure-fragment SKB still has a headlen of 0,
won't this hit the exact same WARN_ON_ONCE(offset >=3D skb_headlen(skb))
warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424053816.2796=
5-1-kerneljasonxing@gmail.com?part=3D1
