Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E84366DB9
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255641; cv=none; b=aTmn5nWeJ6hizZ/ZJ8056jQ2OPQMao+7KG1s/+xCFTtQe4uSAjRnSOjsNKTzmzGDr9ykJTOqKy9zI+xyaifPZusO7T5A6T8MuDxvIVlYszXEuGGns64f/DFtgiv7eza8MSyfEID7qcWnxV9WMA+51bzbb1imrZw7ac6pj1POjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255641; c=relaxed/simple;
	bh=QwbHdsv3kXNzQ5TCVyXC7Vyzx7YVom5hT//u52fkSBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oo2PoOPMVdd+oT2jcl1LXPFfrrs0GbR9jzgGKnlZo18bnXXtwCoGuZvc/gnRZRee9TFT7sL1cHxrlhGzIj+ShivTFl5e1QUTQKPGEvwvbG5rvhOfmQClvXM+FUAOc1JgMC6trrP87YL46aNeZ1lbqBubvYO3brbKwvn3QoSuawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq3umzPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq3umzPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6A21F000E9;
	Tue, 28 Jul 2026 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255639;
	bh=YN8ckXWAk+gRPnXWTYoE8nEep6GZo2ST/uWc1F+NNDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jq3umzPnwkzO+rID+Nsa/YXqqOC6WSwrWsM30eGWeoqVU733aZ9IrdTW6fiAEsp7q
	 IseqiwGNTgOk0pnpsEs6rw/aR7cY3xFYGDP1mfVeMDZY0aMxnXMNocolhiHXWPDocj
	 xvmO9K+DaUOhR9DASAZ+38pZfp4I2ydftYT8fKPki02LAT5BOs3kMe/FqmRQ8QKoYL
	 dnvkhE1Shc+1lGkyMSOygapAXAIjMikuUeUNLMx3cdkVEXLFdO0KPzXrvIRTQDWna/
	 zpQU+WEyYghJWkfKMJHzFRPLM++mmeS5CylADxrlU/CcodIihO+46it9GeKxBylmJq
	 h9tqeIjJ4BK9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/6] xsk: validate launch-time metadata size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727161959.885642-5-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-5-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:20:38 +0000
Message-Id: <20260728162039.4E6A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Time-of-Check to Time-of-Use (TOCTOU) race condition in zero-cop=
y TX metadata validation.

Pre-existing issues:
- [Critical] struct xsk_tx_metadata has a layout mismatch between 32-bit an=
d 64-bit architectures, breaking 32-bit userspace compatibility.
- [High] Calling `skb_checksum_help()` on an empty or fragmented SKB in AF_=
XDP zero-copy path drops packets.
--

--- Patch [4]: [PATCH net 4/6] xsk: validate launch-time metadata size ---
commit 812dce9383d33c01b8fe81b1fbbcc8371998ca62
Author: Stanislav Fomichev <sdf.kernel@gmail.com>

xsk: validate launch-time metadata size

This commit validates the launch-time metadata size by rejecting requests
when the registered metadata area does not contain the complete field. It
also snapshots the validated flags for the generic transmit path to avoid
inconsistent decisions if user space changes the flags concurrently.

> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 46797645a0c24..68a7876013572 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
[ ... ]
> @@ -260,21 +260,28 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *po=
ol, u64 addr)
>  	0)
> =20
>  static inline bool
> -xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
> +xsk_buff_valid_tx_metadata(const struct xsk_buff_pool *pool,
> +			   const struct xsk_tx_metadata *meta, u64 *flags)
>  {
> -	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
> +	*flags =3D READ_ONCE(meta->flags);
> +	if (*flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> +		if (pool->tx_metadata_len <
> +		    offsetofend(struct xsk_tx_metadata, request.launch_time))
> +			return false;

[Severity: Critical]
This is a pre-existing issue, but the UAPI struct definition in
include/uapi/linux/if_xdp.h has two __u16 fields followed by a __u64 field
without explicit padding.

64-bit kernels will read launch_time from offset 16, while 32-bit userspace
writes it to offset 12.

This newly added validation explicitly expects the 64-bit structure size,
which solidifies the layout incompatibility.

Does struct xsk_tx_metadata have a layout mismatch between 32-bit and 64-bit
architectures that prevents 32-bit userspace compatibility?

> +	return !(*flags & ~XDP_TXMD_FLAGS_VALID);
>  }
> =20
>  static inline struct xsk_tx_metadata *
>  __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
>  {
>  	struct xsk_tx_metadata *meta;
> +	u64 flags;
> =20
>  	if (!pool->tx_metadata_len)
>  		return NULL;
> =20
>  	meta =3D data - pool->tx_metadata_len;
> -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
>  		return NULL; /* no way to signal the error to the user */
> =20
>  	return meta;

[Severity: Medium]
The snapshotted flags are validated for size compliance in
xsk_buff_valid_tx_metadata() but then discarded, returning the
un-snapshotted user memory pointer (meta) to the driver.

Later in the zero-copy driver path, xsk_tx_metadata_request() re-reads
meta->flags directly from user memory:

include/net/xdp_sock.h:xsk_tx_metadata_request() {
    ...
    if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
        ops->tmo_request_launch_time(meta->request.launch_time, priv);
    ...
}

Does this create a Time-of-Check to Time-of-Use (TOCTOU) race condition in
the zero-copy TX metadata validation where userspace can concurrently enable
launch time after the size validation?

>  }
[ ... ]
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index fcc6f17f35760..7855ee09c4b64 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -967,15 +967,16 @@ static int xsk_skb_metadata(struct sk_buff *skb, vo=
id *buffer,
>  {
>  	struct xsk_tx_metadata *meta =3D NULL;
>  	u16 csum_start, csum_offset;
> +	u64 flags;
> =20
>  	if (unlikely(pool->tx_metadata_len =3D=3D 0))
>  		return -EINVAL;
> =20
>  	meta =3D buffer - pool->tx_metadata_len;
> -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
>  		return -EINVAL;
> =20
> -	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> +	if (flags & XDP_TXMD_FLAGS_CHECKSUM) {
>  		csum_start =3D READ_ONCE(meta->request.csum_start);
>  		csum_offset =3D READ_ONCE(meta->request.csum_offset);

[Severity: High]
This isn't a bug introduced by this patch, but for zero-copy SKB
construction (xsk_build_skb_zerocopy), the payload is populated strictly in
fragments, leaving skb_headlen(skb) =3D=3D 0.

When a user requests XDP TX metadata with checksum offload on a device
that uses software checksum fallback (pool->tx_sw_csum),
skb_checksum_help() fails immediately on such fragmented SKBs by returning
-EINVAL, which drops the packet.

Does calling skb_checksum_help() later in this checksum block incorrectly
assume the SKB has a linearized payload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161959.8856=
42-1-sdf@fomichev.me?part=3D4
