Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA733C13F9
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259079; cv=none; b=pKz78PGBDGoaPsvyyepLpoW95nM0tBlqSI9vo1hlNoWAfkgnkxskuterTG18UllmQq/SX5yr7i/tSahPM4Eu7HPQMlD/gxFEkqZN8jYg47h3BAAaFBW0B7It8e4oMVgHSdKbzRfniTGG0YCHWWd/m9ql4nIGYVH3co3R3lhOPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259079; c=relaxed/simple;
	bh=5cYs5Rjrw6OzcbxA+PvWzdy+IR1Jgq8mhX3sgrZg1aY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z/SLII29vVQvHbU7kP1AM6Ia7qHXIYrHC5kiJpAxWQSdy3cBfKPCkYOZqWhfV4SXCSFDqoeztbk9aGqxWEFsIbnVonVChI967VCDOIR+onfPeytahe7xL0jLEiR35X8Cr7S/EYFyZYwbShWC4WRjytKDaqQxIWJyl1e5vENvCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxaKyGS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxaKyGS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89061F000C8;
	Sat, 17 Oct 2026 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792259077;
	bh=Sj+zUs1zg5gzl1E8ocWD/bqR5vV2N2vm+J8Ri/RMaDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OxaKyGS3UXmLrJkAA2wDJtK1EG/8PhSTbgeN4xjgbzc4D2Gx9Mjx1sipkoxz2uyi/
	 c8ujJgx6CVW/g3On9zZaAbzrbL+YxWYqYQZaOYJdWaAVYXCdPjKjdsIp2PvSuwyITD
	 bizGFfTXtLY52xMQ1h0eVfJ77npRO1qxv4K8WOzfXwGmgSAdMWR5Fzm9v4eDyJ5N1i
	 WXiK1sTfyowGiL9CdMrHx4AB8pYvo5nRDe4cD1+7D7UfzoGPthJy8HpdL2pdAG2uiI
	 rB5CorDnEJnQq0WhLR1TkNjtRLNxRaYIa8Ch/ViPvrzQw3KiELC2qu8nFH2TfiehkE
	 oRo3SLx4U1NZA==
Message-ID: <sashiko-outbox-175725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 net-next 11/15] selftests: xsk: send UDP over IPv4 or
 IPv6 between the interface MACs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016174338.787135-12-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
 <20261016174338.787135-12-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:44:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation
--

commit c93ec22f2ead9dd358b23391b62cb4c9037e31b7
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

    selftests: xsk: send UDP over IPv4 or IPv6 between the interface MACs
   =20
    xskxceiver sends frames of the loopback ethertype between made-up MAC
    addresses, and its XDP programs redirect every frame to the XSKMAP.
    That suits a veth pair that carries nothing else, but not a physical
    link, where the peer NIC filters out the made-up addresses and the
    programs take neighbour discovery, LLDP or SSH away from the stack.
   =20
    Send the test packets as UDP between the MAC addresses of the two
    interfaces on any link. Each endpoint takes the IPv4 or IPv6 addresses
    of the flow (--src-ip, --dst-ip), the MAC address of its peer
    (--dst-mac) and the UDP port (--udp-port), and reads its own MAC
    address from the interface. Over IPv4 the UDP checksum is left at zero,
    as IPv4 allows; over IPv6 it is computed from the known payload.
    PKT_HDR_SIZE and MIN_PKT_SIZE now stand for variables that
    xsk_set_flow() sets, so the smallest packet grows with the headers to
    64 bytes over IPv4 and 88 over IPv6, and a verbatim stream adds up the
    descriptors of a packet for its IP and UDP lengths.

> diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/to=
ols/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> index 023d8befd4cab..2b55dbaf13b24 100644
> --- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> @@ -15,12 +23,64 @@ struct {
>  	__uint(value_size, sizeof(int));
>  } xsk SEC(".maps");
> =20
> -static unsigned int idx;
>  int adjust_value =3D 0;
>  int count =3D 0;
> +/* UDP destination port of the test flow, other traffic goes to the stac=
k */
> +__u16 test_port;
> +
> +/* Return the UDP header of a test packet, and in hdr_len the size of the
> + * headers in front of its payload, or NULL for any other packet.
> + */

[Severity: Low]
This is a minor coding style observation. The BPF subsystem prefers the
opening of multi-line comments to be on its own line. Should this be
formatted as follows?

/*
 * Return the UDP header of a test packet, and in hdr_len the size of the
 * headers in front of its payload, or NULL for any other packet.
 */

> +static __always_inline struct udphdr *test_udp_hdr(struct xdp_md *xdp,
> +						   __u32 *hdr_len)
> +{
> +	void *data_end =3D (void *)(long)xdp->data_end;
> +	void *data =3D (void *)(long)xdp->data;
> +	struct ethhdr *eth =3D data;
> +	struct ipv6hdr *ip6;
> +	struct udphdr *udp;
> +	struct iphdr *ip;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016174338.7871=
35-1-maciej.fijalkowski@intel.com?part=3D11
