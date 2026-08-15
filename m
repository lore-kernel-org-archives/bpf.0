Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFA32692C
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760081; cv=none; b=sWW69XEaMofqQ6sbcnqbOnr78iFi5iUehjEHVXcLA9wEaEHEBQgvgAOhg1kggDyyn0EtHtlKPg7Y4nCMp9siALpN9m1H4mPJn/5rcsjCCrARJC022EXeGthsntP/DxrKxE51+obrgudJ6QcuEUjmf/1ECM1Z09IkOibGXlS92SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760081; c=relaxed/simple;
	bh=Sk99+XuFjak8A6VDfNsCzaMk+a0C68StzirFWAxegQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGyqXRX7B8kc5zg7ztdu198S3peS0w5V0ilzjTeIEPYtLLqT9DAvX8CErXq275U0Myc8HnKWnpzqhuhY8oQkOlw0Nh3LPKNlPVrgwF8sGXyiE9jVam6AUmFG1Ov2QIztyn3meknll/ZXMCNK9JdwPZA1ZVkt8devTw6mXUj8fVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik9sukvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik9sukvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43771F000E9;
	Sat, 15 Aug 2026 02:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760079;
	bh=uG0YK/x47s2eKuDsHHLt0DSNnw7uRce7uit55b1SZpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ik9sukvE9RL/9/dTPA1YUc1VjBAhJ6OAknJKDnW5buBLmEjIb/veHfdbvCNpPClKK
	 l2Zks5t1D83cdvnNFqcDx5uuoF2mQ4KT5C795d8KP5QTspzB74KXObZ7iVp14ijQq9
	 LIcyHfYUODAbIqq3RwCHhH646JiYO7wu0qHl5Oxbj/kc8y6y2PIxgAGOZ/wAMEgclT
	 blqRnbQIngld37Kxmwc3s90W5+7U7P0Mga5So1jxG1y/BkgmNmQaejbS+h1/GOW85C
	 57ZdptRSMrRV7WPHG+AFfhnuc5Xuu27I6iPgcks8DE+FtgLUQiJgc3rN/Np41S7VKI
	 Rc6p9JXP5ZkOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 02/15] gve: refactor initialization with
 helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-3-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-3-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:39 +0000
Message-Id: <20260815021439.A43771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Disabling XDP triggers an out-of-bounds array access due to th=
e old BPF program remaining active while the TX arrays are shrunk.
- [High] Device resets permanently break AF_XDP sockets because the driver =
zeroes the `xsk_pools` bitmask.
- [High] `gve_xsk_pool_enable` causes a data race by modifying the XDP memo=
ry model concurrently with the NAPI polling context.
--

--- Patch [2]: [PATCH net-next v4 02/15] gve: refactor initialization with =
helper functions ---
commit f4310d54d17a7a878691c693aea2b3ce23d39802
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: refactor initialization with helper functions

In the interest of commonizing code, refactor gve_probe()
and gve_init_priv() with a few helper functions that can
be expanded and utilized in upcoming patches that add the
mailbox ABI to the driver.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 30bf6df4ebc58..37e6205e2eefd 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2400,7 +2400,6 @@ static const struct xdp_metadata_ops gve_xdp_metada=
ta_ops =3D {
> =20
>  static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
>  {

[Severity: High]
This is a pre-existing issue, but could device resets permanently break AF_=
XDP
sockets because the driver zeroes the xsk_pools bitmask?

When a device reset occurs (e.g., due to timeout, adminq failure, or MTU
change), it triggers gve_teardown_priv_resources() which frees the bitmask:

    bitmap_free(priv->xsk_pools);
    priv->xsk_pools =3D NULL;

During recovery, the initialization path reallocates a fresh zeroed
xsk_pools bitmap (e.g., via priv->xsk_pools =3D bitmap_zalloc(...)),
permanently losing the previous state. Because the driver never restores the
xsk_pools state from the core net_device, AF_XDP sockets silently stop
working after a reset.

[Severity: Critical]
This is a pre-existing issue, but is there a risk of an out-of-bounds
array access when disabling XDP?

In gve_set_xdp(), the xdp_prog pointer is updated after the queues have been
restarted with a shrunken TX array:

    err =3D gve_configure_rings_xdp(priv, 0);
    if (err)
        goto out;

    WRITE_ONCE(priv->xdp_prog, prog);

If a local privileged user disables XDP, gve_set_xdp() calls
gve_configure_rings_xdp(priv, 0), which reallocates priv->tx without XDP
queues and restarts NAPI polling. Since priv->xdp_prog is updated only after
NAPI restarts, the active NAPI poll can execute the old BPF program. If the
program returns XDP_TX, it accesses priv->tx[tx_qid] where tx_qid exceeds
the new, smaller array size, leading to memory corruption.

[Severity: High]
This is a pre-existing issue, but does gve_xsk_pool_enable() cause a data
race by modifying the XDP memory model concurrently with the NAPI polling
context?

In gve_xsk_pool_enable(), it registers an AF_XDP pool by modifying the XDP
memory model and rx->xsk_pool without first disabling NAPI polling:

    err =3D xdp_rxq_info_reg_mem_model(&rx->xdp_rxq, MEM_TYPE_XSK_BUFF_POOL,
                                     pool);
    if (err) {
        ...
    }

    rx->xsk_pool =3D pool;

If NAPI receives a packet in the race window, it may initialize the XDP
buffer with MEM_TYPE_XSK_BUFF_POOL but allocate memory from the standard pa=
ge
pool because rx->xsk_pool was observed as NULL. When freed, xsk_buff_free()
would be incorrectly called on a standard page, causing type confusion and
memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D2
