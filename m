Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C02C0294
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838964; cv=none; b=vDkuwTQ/nEV0y2shAzFqH9otMX5KrcqXt4vJdNNP/ZJCB3GV5bPwgEd9Gi7aHTEOryQAwU9BSsSfL7ILqiBAZqgpSOtWzQ04AajEmqfbwL7PAmTz28I/B2Xb0J2uqSG/FdS1sVFdG0tyA4xzUrcj+cPP8/4bhpZLZHu2QF6AhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838964; c=relaxed/simple;
	bh=jvpux491xKYvvTTvdUAMdQ2UuA2u8uQgDKI7PF8iLJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdzHjit8Nj8WqEfm87nWghWIFjdjsDG0TjOE22vwWDNyvHD+xiVaFbPqFHWjcim58IU7OXCgc8WVuJ6c2DzGldq5wnXIAZ6h5Kl/+RK+fCmUsynoKj3v6vDsyNVB8l89gshSkzWgA01FqXV7WSz/j/d+JhlWeJZbBAecsnIMK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/gBggBt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/gBggBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7665EC2BCB4;
	Sun,  3 May 2026 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777838963;
	bh=jvpux491xKYvvTTvdUAMdQ2UuA2u8uQgDKI7PF8iLJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e/gBggBteXIZvNoGkmrHo6+F9PXEFZxzvOZInWbFFYieQ988w6m6zBn8bpkUtRvBN
	 Ta7rDDBF9PBd1PweiLtEuKXBmdGw4wmbhvUuPXe5GVvIRv//x5hKFIUyZiGdFhT2Ac
	 VWgKfA3iuhIGc2BZkJxk+CvPr84Jq0IBLmiGTEd7uyYo5RNWLEIWucLUvNhJNF6/6i
	 Av9t7spSXgUJK0pFszD4pl5ej5SnXI9jAubo3V1U4U/z+CyjNlz9/+vksagTbUbf/o
	 ig6v5fign2flr4jYcz/G/JCEu+R7hhp/3FdJpQ2YN5FmV2X49WZ3FwAA4BRimmOQdG
	 6QtyNGiIdhPFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260502200722.53960-2-kerneljasonxing@gmail.com>
References: <20260502200722.53960-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 20:09:22 +0000
Message-Id: <20260503200923.7665EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional rejection of `XDP_UMEM_TX_SW_CSUM` breaks valid nati=
ve zero-copy configurations.
- [High] The root cause of the 'wedged TX ring' remains unaddressed, allowi=
ng trivial userspace triggers.
--

commit a1862dee263d88bc3b6ca0898f858a88e2e37fce
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices

This commit attempts to prevent silent per-packet failures and wedged TX
rings when using sw-csum with drivers advertising IFF_TX_SKB_NO_LINEAR.
It does so by rejecting the bind operation with -EOPNOTSUPP during setup.

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.=
org/#t
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate fun=
ction")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>

> Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> XDP_TXMD_FLAGS_CHECKSUM' produces:
> 1) a WARN_ONCE "offset (N) >=3D skb_headlen() (0)" from skb_checksum_help=
(),
> 2) sendmsg() returning -EINVAL without consuming the descriptor
>    (invalid_descs is not incremented),
> 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
>     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
>     the same descriptor and re-hits the same WARN until the socket
>     is closed.

Does this completely resolve the wedged TX ring issue? While this patch
prevents skb_checksum_help() from returning -EINVAL, xsk_skb_metadata()
can still return -EINVAL for other reasons, such as an out-of-bounds
csum_start or csum_offset provided by userspace.

If xsk_build_skb() returns -EINVAL, wouldn't __xsk_generic_xmit() still
evaluate if (err !=3D -EOVERFLOW) goto out; and break its loop without
consuming the descriptor? Might the generic transmit path need to be
updated to consume the descriptor and drop the packet on terminal errors
like -EINVAL to fully prevent userspace from wedging the ring?

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index cd7bc50872f6..d981cfdd8535 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
> =20
> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		return -EOPNOTSUPP;
> +

Will this check unconditionally reject valid native zero-copy configuration=
s?

In native zero-copy mode (when force_zc is set), the transmission path
bypasses __xsk_generic_xmit() entirely and processes descriptors natively,
meaning it does not use xsk_build_skb_zerocopy() or invoke
skb_checksum_help().

If a UMEM legitimately has the XDP_UMEM_TX_SW_CSUM flag set (for example,
when shared across multiple devices), it appears this will now return
-EOPNOTSUPP. Should this check be restricted to only apply when using the
generic datapath?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.5396=
0-1-kerneljasonxing@gmail.com?part=3D1
