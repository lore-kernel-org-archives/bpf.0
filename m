Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078052D949B
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764423; cv=none; b=g1Fc4+FIwPVg4JffAQpZDovEdhI1+1BCa9mEw7t8Cty4mHXXYbkRounR3CpzUDvWbJv1iq/dXwIxlnofFB8W8oU5Zc5bGSgCvtdgp8bwVvBMGK63YRw2axQYEEQiRo5i2+ZReN1Yf0Vf3fUt0UcJijiptEnZ5DGqa6wTTHEqi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764423; c=relaxed/simple;
	bh=bjoCFJztcLWxd4bFXdZHS77azbjHVnha9Sj7fM62CaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsUd+ZASisCVXRYeWy+fMJybubIcI7tRuwlq0E2DVOJLIZgWxCunqqFH0fA6G59EZqGJpMs9qXlBkZm13pG5jqA9leVMV0wB5S1g8r8UGRQZECgbavB9wwXyRu/aD1acsZF/X0xkwzF6yV+KZooBmMQU7ETf5eiP6TQzQYtS8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKcz5pO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKcz5pO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0EAC2BCB0;
	Tue, 21 Apr 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764422;
	bh=bjoCFJztcLWxd4bFXdZHS77azbjHVnha9Sj7fM62CaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qKcz5pO8UDvDAhJsTP8sit6JWJU1Xui4u443sFnhK3iMnm1I4uDj05JTjlKMuX0Zy
	 EYSlsl+U8gpZ1ejW+VC2kuDpO495Z0joYElf/MaXMGYzfvrSfMURnwVndflMICD3bc
	 ZvghtSEPhob7r4/eAeFb2V2XxFsh9IM563cGzq/Hi5Yhuvg1CeTksipQRIGgy7A334
	 5wLPeGMyWhTzGQ6LsvIu3nEaOJqvpU9esZ0DLLHsVBXcOiSPgGNCsYc3WVUJnom4pb
	 YehfMTKOPeTCDxmFRzDbjXmUzHzLhXDCBr4q1r5gSBx5tC+wOuKLL0B8pi65ONHkPl
	 9/GV7uikTNDVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
Reply-To: sashiko@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420082805.14844-2-kerneljasonxing@gmail.com>
References: <20260420082805.14844-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 09:40:21 +0000
Message-Id: <20260421094022.8D0EAC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch unconditionally rejects pool assignment for devices with=
 IFF_TX_SKB_NO_LINEAR if tx_sw_csum is enabled, which incorrectly breaks na=
tive Zero-Copy (ZC) setups on those devices.
--

commit 5beba1aaed8c200424f98af3c07472ab4da8d451
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices

This commit rejects UMEM bindings for devices that advertise
IFF_TX_SKB_NO_LINEAR when software checksumming (tx_sw_csum) is enabled.
This prevents a warning and panic in skb_checksum_help() which relies on a
linear skb head.

Link: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.or=
g/#t

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index cd7bc50872f6b..d981cfdd85357 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	if (force_zc && force_copy)
>  		return -EINVAL;
> =20
> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		return -EOPNOTSUPP;
> +

Does this unconditionally reject the pool assignment even for native
Zero-Copy (ZC) setups?

In native XDP_ZEROCOPY mode, AF_XDP descriptors are sent directly to the
hardware. No sk_buff is allocated, so skb_checksum_help() is never called,
making the tx_sw_csum flag irrelevant and safe to ignore.

By placing this check before determining if native ZC is available, does
this break ZC mode on drivers like virtio_net for applications that pass
the XDP_UMEM_TX_SW_CSUM flag as a fallback?

Should this check be deferred until we are certain we are using generic
copy mode, such as when force_copy is true or after native ZC setup fails?

>  	if (xsk_get_pool_from_qid(netdev, queue_id))
>  		return -EBUSY;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.1484=
4-1-kerneljasonxing@gmail.com?part=3D1
