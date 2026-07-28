Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE587372ECA
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255645; cv=none; b=Uw4yUjymD5mMb15ZLNMmwcigVZdKsNyQarJEzO/thDx12Pn9+qLWI8NtZExvLxBNXOVBz5eFUUPkG1fst9sKM2obo67Nt+ebdKvoex24MW5bztvN4YErzMdz13mYsvy0sKX8hFkrGpVNMvaZh5BMYQQO/ETmX9gD6THtVu9mdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255645; c=relaxed/simple;
	bh=uq2j+qu2Nmmhfz2gWcpAlvC3SAWtM3JVHIUh0RP+sLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PZ7mk5YgtGAgzLCTVtORy9v++73Pblfd2In6mBt5LGgGDiHQneG4V+LpZeU7Qs0SAh3gSSJL0ejXvDf/JXK8E/qOHKvMz/l67ePLiAKuQoKHYuDzQ1CfLf4UMcK6qgI2aBHcwRA7QAF/Q+SARemz42aHbAZgL5q7DYGsFlF/UFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0P1TRsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0P1TRsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D70B1F000E9;
	Tue, 28 Jul 2026 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255644;
	bh=3z9avFBIUDgPo2NYFk+JPAh422SK66SrW1bltFXAajg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G0P1TRscAwuVO21nOgujDuJ5T0QYmPiLJzGW4KlOFerIqzhaxINnG5xXjogYk0jlu
	 5Wih0pFSv3gnBLb7M4CqqXpo5m5CM9VLQCgUWDRSGlVoxkFNXgNyBcU4aRR3Q1Y3UV
	 IhBHeCQbKg94ezDPPyybQN3z3LeyIzd1QTrf+exNdOP4GZ1Niq1KRVFmqMPUnbBRSw
	 ToK6yyIv62daWieye07S+qj+VYnncmBI7q6rBOAgDdOsZktLrkjq+hr7DCuE2tA6fb
	 W1KwNxmOHkROlUxHCNN8IVQ1JXqdw54DuajI8DUTrjFYoK44m3ZmJD3XnwCz+ER1G2
	 VESuRr/lS/AMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/6] xsk: require at least 16 bytes of TX metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Fomichev" <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727161959.885642-2-sdf@fomichev.me>
References: <20260727161959.885642-1-sdf@fomichev.me>
 <20260727161959.885642-2-sdf@fomichev.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:20:43 +0000
Message-Id: <20260728162044.1D70B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete Fix / Out-of-Bounds Memory Read in TX Metadata
- [High] UAPI ABI Incompatibility between 32-bit and 64-bit architectures
--

--- Patch [1]: [PATCH net 1/6] xsk: require at least 16 bytes of TX metadat=
a ---
commit 8f587b21f2b30dd32c9e63e0817476297538dfb0
Author: Stanislav Fomichev <sdf.kernel@gmail.com>
xsk: require at least 16 bytes of TX metadata

AF_XDP accepts a TX metadata length as small as eight bytes. This commit
requires a minimum of 16 bytes of TX metadata to preserve compatibility with
applications that do not use launch-time metadata while addressing
out-of-bounds reads.

Link: https://lore.kernel.org/netdev/20260720155210.34229-1-blbllhy@gmail.c=
om/

> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index 58da2f4f4397a..cd8643360eb3a 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -210,6 +210,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct=
 xdp_umem_reg *mr)
>  	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
>  		if (mr->tx_metadata_len >=3D 256 || mr->tx_metadata_len % 8)
>  			return -EINVAL;
> +		if (mr->tx_metadata_len < 16)
> +			return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but is a 16-byte minimum sufficient when the
launch_time flag is requested?

If a userspace application sets XDP_TXMD_FLAGS_LAUNCH_TIME in the metadata
flags and provides a tx_metadata_len of 16, it appears we can still read out
of bounds. In include/net/xdp_sock.h:xsk_tx_metadata_request(), the code
reads the 8-byte launch_time field at offset 16 when the flag is set:

include/net/xdp_sock.h:xsk_tx_metadata_request() {
    ...
    ops->tmo_request_launch_time(meta->request.launch_time, priv);
    ...
}

If the descriptor addr is placed at the very end of the registered umem (for
example, desc->addr =3D umem_size - 1 with len =3D 1), reading 8 bytes at o=
ffset
16 extends beyond the umem bounds. Since xp_aligned_validate_desc() validat=
es
based on the chunk, does this allow reading into potentially unmapped memory
if the launch_time flag is set?

[Severity: High]
This isn't a bug introduced by this patch, but does this tx_metadata_len
validation correctly handle 32-bit applications running on a 64-bit kernel?

Looking at struct xsk_tx_metadata in include/uapi/linux/if_xdp.h, there is =
no
explicit padding between csum_offset and launch_time:

include/uapi/linux/if_xdp.h:struct xsk_tx_metadata {
    __u64 flags;
    union {
        struct {
            __u16 csum_start;
            __u16 csum_offset;
            __u64 launch_time;
        } request;
        ...
    };
};

On 32-bit x86, __u64 has a 4-byte alignment, which places launch_time at
offset 12 and makes the total structure size 20 bytes. On a 64-bit kernel,
__u64 is 8-byte aligned, placing launch_time at offset 16 with a 24-byte
structure size.

If a 32-bit application registers a 20-byte length, it would be rejected by
the tx_metadata_len % 8 check above. If it registers 24 bytes but populates
launch_time at its native offset 12, would the 64-bit kernel read unexpected
data from offset 16?

>  		umem->tx_metadata_len =3D mr->tx_metadata_len;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161959.8856=
42-1-sdf@fomichev.me?part=3D1
