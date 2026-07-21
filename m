Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B446C4AE
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649145; cv=none; b=bXH3ODgYBkr8t5EvPX1nRsAeW3OJFYQg6CrldvKYlISVoO6BePWA2pLiYnqOLOpfgBFOqBp1O45dpXr0L+tvWrU1MJp0ZdAO73fdI7i+gBcFJuE8eELKhlflEc7KSS/iCrOMrJhOANWd5Yua3OUmMW7uGcQdRcWSB8Bo+pcuL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649145; c=relaxed/simple;
	bh=PpGCuhkgFcxEF+V+rs9HuKFgq6WduBXzqf6PS6HITLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SUO/bk5yV/XCsWYXdzXkUDUBp0JfXu6TyWMG6bPOAAv+3mWGFj7FTQTaEgMKgDK2Rlo5ezykn4IW7KE+ebMW99VsZOJ1mSStRdkkx9TnN9geaEsep0gTOu5WcPPrmgMkcnAXNQ50dd4vjNam5Mmos3IgJfG+zg4OYAIG2FZKIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFogzE5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFogzE5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6974B1F00A3D;
	Tue, 21 Jul 2026 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649144;
	bh=X7TaBakCKbMsgpToenhYnvet42puqC+RNWFh/NhNJVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFogzE5FPRUAcFxDvGC+7R24hzwONY+8nXZcZzlT3UibqFaKPrq1ftSledGS0sA2q
	 7WjRyFGR2f7RNLvEBUvWdVoyKIl1u5BHYiGAxLimilQwXEkuZb+VjoII6vmuKe2usH
	 AJHpqSzJ3hrVlc9lJSzVJCZPIeRPlW1L1hcMYCtulv/KGdjWSbGG9/rKvfOZ34SG8R
	 qYtyHsnhEhYQ5R1+5NDMn3WQJXiYpPw4pBup0VxaeyabIOuhH2kwiTfdEAThRCbkIe
	 vzcTgBcM6uxtQ47hbhJqttNKwjOHbytnxeNSGB0zwbjaLpBhf4u7fD1lXQY+HSJgEe
	 ITGR7TOzpv8YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] xsk: reject tx_metadata_len smaller than struct
 xsk_tx_metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720155210.34229-1-blbllhy@gmail.com>
References: <20260720155210.34229-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 15:52:24 +0000
Message-Id: <20260721155224.6974B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] UAPI Backward Compatibility Breakage

Pre-existing issues:
- [High] UAPI ABI Compatibility Mismatch in struct xsk_tx_metadata
--

--- Patch [1]: [PATCH net] xsk: reject tx_metadata_len smaller than struct =
xsk_tx_metadata ---
commit a89522120661c494f685c71309affa610fc7ca08
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

xsk: reject tx_metadata_len smaller than struct xsk_tx_metadata

xdp_umem_reg() validates tx_metadata_len for upper bound (<256) and
alignment (%8) but not a lower bound. xsk_skb_metadata() computes
meta =3D buffer - pool->tx_metadata_len then unconditionally accesses
the full 24-byte struct xsk_tx_metadata, so any value less than
sizeof(struct xsk_tx_metadata) allows an out-of-bounds read. This adds
a lower-bound check in xdp_umem_reg() to reject tx_metadata_len
values that cannot cover the full metadata struct.

> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 58da2f4f4397a..d16ad9d8f9197 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -208,7 +208,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct=
 xdp_umem_reg *mr)
>  		return -EINVAL;
> =20
>  	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
> -		if (mr->tx_metadata_len >=3D 256 || mr->tx_metadata_len % 8)
> +		if (mr->tx_metadata_len < sizeof(struct xsk_tx_metadata) ||
> +		    mr->tx_metadata_len >=3D 256 || mr->tx_metadata_len % 8)

[Severity: Critical]
Does this strict size check in xdp_umem_reg() break backward compatibility
with older userspace applications?

Older applications compiled against earlier kernel headers (where
struct xsk_tx_metadata was 16 bytes, prior to the addition of the
launch_time field) will legitimately request a tx_metadata_len of 16.
This check evaluates to 16 < 24 and unconditionally rejects these
valid requests with -EINVAL, causing registration to fail.

To safely fix the underlying KASAN out-of-bounds read, should the kernel
instead dynamically validate that pool->tx_metadata_len is large enough to
cover the fields actually requested by meta->flags at runtime in
xsk_skb_metadata(), rather than enforcing a global minimum size here?

>  			return -EINVAL;
>  		umem->tx_metadata_len =3D mr->tx_metadata_len;
>  	}

[Severity: High]
This is a pre-existing issue, but does struct xsk_tx_metadata have an ABI
compatibility mismatch between 32-bit and 64-bit architectures?

Because __u64 has a 4-byte alignment requirement on 32-bit x86 but an 8-byte
alignment requirement on 64-bit x86, the compiler introduces 4 bytes of
implicit padding on 64-bit architectures before the launch_time field.

If a 32-bit userspace program runs on a 64-bit kernel in compat mode, it
writes launch_time to offset 12, but the 64-bit kernel reads it from offset
16 in xsk_skb_metadata(), resulting in garbage values being used for packet
transmission scheduling.

include/uapi/linux/if_xdp.h:struct xsk_tx_metadata {
        ...
        struct {
                ...
                __u16 csum_offset;

                /* XDP_TXMD_FLAGS_LAUNCH_TIME */
                /* Launch time in nanosecond against the PTP HW Clock */
                __u64 launch_time;
        } request;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720155210.3422=
9-1-blbllhy@gmail.com?part=3D1
