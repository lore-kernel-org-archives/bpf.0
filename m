Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792937541;
	b=iOdmL3ym6DSuzd7oEvw5ieaWVdMttRlOYMK8mYt3zbhZvaw+gagUS9q5CyvJBWcHxvNj
	 wcHfwt/kKsuOaqBqu5I6YvIr0m860pqinUIqmk8prT33OsxOndb62jDl4CMoJlEJ40kOy
	 BEGF601GoLSeMem85HSnDX2jCAWHni131D4GpQvx8L+0wgfkHdy/ieM2x8sS6IEqBtNSQ
	 UaGWfUhBSIGwS5NmYutxEXqrAX8dZg3V/rv2FO9pgnGUYFC6ksUbaqygWraLZ846qRA+z
	 1cQkX8mXscTV9AuPkXdWnzM0lO9bYqHcKegohe2F03Hm5mhwygrGQDdnPfZIY3Im3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QMQsLrDZ7T3rmgAOpwrOfbBA7BZSGAqdIcIwDXcq8oM=;
	b=BLvFRmy1t0iti3aJw4SB17D3Erkg43aRsGpYyViSfrKUABMj6yw6qCCGnDms2s4hxA/7
	 Ab0MFeCx6x+6X0W2oXwqU9l/4uR5QGGbncNigZIoAWGhK0wU9Bz/qqXn7pf1wExDDCRw9
	 wd0d1jkKnAstVhpdoMM/5wM/TBD63IjPfPZ+o4qRRWBh8AjmeBr3bAeRXRLpmi9ZY5Qzt
	 g39YTbYqDg5COH3A77wrJz+JbR1jCHNua/N+2r2rg9IXo+t7ODoihwug8+Cv957SB/ypa
	 NP113ZhG/igGBxLUHMzJwAAFSyWvr3x1ADOA11nZYkQl2NDurtd5n3vejteGMyZpgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbxv8UeL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA68606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbxv8UeL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090371F01825;
	Sun, 25 Oct 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792937541;
	bh=QMQsLrDZ7T3rmgAOpwrOfbBA7BZSGAqdIcIwDXcq8oM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbxv8UeLG3eVN4P8mvhOoYpJZF0VRasodZPZ4ynL9E85k815vSKKphuGoGhmZrVMy
	 b+FAlv1XrRVSl7A3nTnPiJT7LRPkdT6HKgpbLqwoSe0m2/+nuEjVGBGgYTUW7l2f2o
	 2Oiuplc8Juwhrs+QKIXYrAMfWVqtnNDYp2bkUHPrgVrPcVNCx1zQ7x/H+MUBJxTq9u
	 LP2d5XSx+paU5gWucYJubSD2KlA22RnqYMDLiQahiTtdX75HHKGENAwy68xXFuc7Ha
	 FqZpl8Ko4v1eI5nTE5zWzU8YungGiYLRxXAs3JDGLttPwFXCAwwcJwrt6HzAujaE2k
	 yC0/eLHwa+/vg==
Message-ID: <sashiko-outbox-184244@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rongzheng Wang" <testwrzwrz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261024141157.59301-3-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
 <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-3-testwrzwrz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 14:12:20 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: generate_packet() copies ASCII MAC strings into e=
thhdr
--

commit 84305185f8b937f13eaa038de90ba93344b90447
Author: Rongzheng Wang <testwrzwrz@gmail.com>

selftests/bpf: cover AF_XDP multi-buffer TX software checksum

This commit extends test_xdp_metadata to send the test UDP packet both as a
single TX descriptor and split across two TX descriptors, verifying AF_XDP
metadata and software checksum calculation for both cases.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4c..1cf70fb800fba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
[ ... ]
> @@ -133,36 +135,36 @@ static void close_xsk(struct xsk *xsk)
>  	munmap(xsk->umem_area, UMEM_SIZE);
>  }
> =20
> -static int generate_packet(struct xsk *xsk, __u16 dst_port)
> +static int generate_packet(struct xsk *xsk, __u16 dst_port, u16 split_le=
n)
>  {
>  	struct xsk_tx_metadata *meta;
>  	struct xdp_desc *tx_desc;
>  	struct udphdr *udph;
>  	struct ethhdr *eth;
>  	struct iphdr *iph;
> +	u16 pkt_len;
> +	u32 num, addr;
>  	void *data;
>  	__u32 idx;
> +	u8 pkt[256];
>  	int ret;
> =20
> -	ret =3D xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> -	if (!ASSERT_EQ(ret, 1, "xsk_ring_prod__reserve"))
> +	pkt_len =3D sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + UDP_PAYLOAD_B=
YTES;
> +	if (!ASSERT_LT(split_len, pkt_len, "split_len"))
>  		return -1;
> =20
> -	tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
> -	tx_desc->addr =3D idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struc=
t xsk_tx_metadata);
> -	printf("%p: tx_desc[%u]->addr=3D%llx\n", xsk, idx, tx_desc->addr);
> -	data =3D xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> -
> -	meta =3D data - sizeof(struct xsk_tx_metadata);
> -	memset(meta, 0, sizeof(*meta));
> -	meta->flags =3D XDP_TXMD_FLAGS_TIMESTAMP;
> +	num =3D split_len ? 2 : 1;
> +	ret =3D xsk_ring_prod__reserve(&xsk->tx, num, &idx);
> +	if (!ASSERT_EQ(ret, num, "xsk_ring_prod__reserve"))
> +		return -1;
> =20
> -	eth =3D data;
> +	memset(pkt, 0, sizeof(pkt));
> +	eth =3D (void *)pkt;
>  	iph =3D (void *)(eth + 1);
>  	udph =3D (void *)(iph + 1);
> =20
> -	memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
> -	memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
> +	memcpy(eth->h_dest, RX_MAC, ETH_ALEN);
> +	memcpy(eth->h_source, TX_MAC, ETH_ALEN);

[Severity: Medium]
Does this populate eth->h_dest and eth->h_source with ASCII characters
instead of the binary MAC addresses?

In tools/testing/selftests/bpf/prog_tests/xdp_metadata.c, TX_MAC and RX_MAC
are defined as colon-separated ASCII strings for iproute2 commands:

#define TX_MAC "00:00:00:00:00:01"
#define RX_MAC "00:00:00:00:00:02"

When test_xdp_metadata() calls generate_packet(), copying ETH_ALEN (6)
bytes from RX_MAC and TX_MAC writes the literal string "00:00:"
(30:30:3a:30:30:3a) into both eth->h_dest and eth->h_source, rather than
the 6-byte binary MAC addresses "\x00\x00\x00\x00\x00\x02" and
"\x00\x00\x00\x00\x00\x01".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024141157.5930=
1-1-testwrzwrz@gmail.com?part=3D2
