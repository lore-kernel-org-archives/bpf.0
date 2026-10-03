Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7813381E8B
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991236; cv=none; b=MfNJiqZAm82UClBeaPpEeT4U3u6JPOFIiSBs/vZkDtoiZN2eqpqSb/mbjsCA8fHaA3DuOc1MoL0dzQnzGAi4vRbySB5gF81yN2NE4VTWRkTx1P/OLNIie5h7QAKZZvODOvVY/FqOSdL2HJYbteSayMfybjLtsG92iPChTTa8yEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991236; c=relaxed/simple;
	bh=sWYpgc4uc8VjyXA5HaXGC12CBtu80G/x3WW8qgpFl2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JtoYPv4xqVK27PYXr9HoUY6lpU5ufE1YDbJASvLlDFiFvLD4oWX+T1J1tog4Rmse9O4E3+GbwxoPyXQWoi/ojz/cdCZeCe5WBDk24b1GdYQHkw53VDUoWAasB9n1IOsT+uohh5hnvnigz9WxtqDf8zIPPpd4HLSxrSxqs1jkxaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D17KRLEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D17KRLEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8333E1F000FF;
	Sat,  3 Oct 2026 01:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991235;
	bh=Maly/v3UQ4EhNReyim4hzeGfP8c1MaUjTXNWMpo9Fdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D17KRLEM4OcB7EKYHNZIexrxAhR78AmXpZFG6ApswoW3ZSs29ggmu8GNsiNcLOajH
	 hCT/r+qZlKB7//kBM0nrVpO5t2QizK0Q9reXfsefL33ku+IHXo5yo+m20azYpPnC52
	 uJ/pqY0wveWL+gHidxfWiKDrjn6Gta0eUKA6xsz6WwQf5PZDcsB8TMAOE2/UQLoM0u
	 VpyGDkfV5/kKPUuXoEoBP1aUppiLLUn/wb8PIFyDHWdO1oYweNtcmghDDDXnxiHgfV
	 atmx1JuUm0nLqG7ZkolgpyfAEy/HBV0VjwslXp5Fa+/vWpT7n0kHe+0a2o5lAQR5l/
	 B6u8XU+5CYkBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 10/13] selftests: xsk: add a hardware mode to
 xskxceiver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001202124.692591-11-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <20261001202124.692591-11-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:55 +0000
Message-Id: <20261003013355.8333E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/xsk: malformed IP/UDP headers for multi-fragment verba=
tim packets in hw mode
--

commit 13a458bdc3c40c143ae3519294c27c39c89b28b0
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

selftests: xsk: add a hardware mode to xskxceiver

This commit introduces a hardware mode (--hw) to xskxceiver for running
AF_XDP tests over a physical link. It wraps packets in UDP/IPv4 headers and
adds new command line options to configure hardware runs.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testi=
ng/selftests/net/lib/xsk/test_xsk.c
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
[ ... ]
> @@ -1268,8 +1366,8 @@ static int __send_pkts(struct ifobject *ifobject, s=
truct xsk_socket_info *xsk,
>  				tx_desc->options =3D 0;
>  			}
>  			if (pkt->valid)
> -				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->pkt_nb,
> -					     bytes_written);
> +				pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, pkt->len,
> +					     pkt->pkt_nb, bytes_written);

[Severity: Medium]
When generating multi-fragment verbatim packets in hardware mode, does this
pass the incorrect length to pkt_generate()?

If pkt_stream->verbatim is true, pkt->len represents only the length of the
current fragment, not the entire logical packet. Passing it as total_len he=
re
propagates to gen_pkt_hdr(), where it truncates the UDP and IPv4 length fie=
lds:

tools/testing/selftests/net/lib/xsk/test_xsk.c:gen_pkt_hdr() {
    ...
    struct udphdr udp =3D {
        ...
        .len =3D htons(total_len - sizeof(*eth_hdr) - sizeof(struct iphdr)),
    };
    struct iphdr ip =3D {
        ...
        .tot_len =3D htons(total_len - sizeof(*eth_hdr)),
    };
    ...
}

This causes malformed packets with truncated L3/L4 lengths while the physic=
al
frame contains all fragments, which might be dropped by NIC parsers or
switches and lead to spurious hardware test failures (for example, in
testapp_too_many_frags).

Could the total logical packet length be passed here instead of just the
fragment length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202124.6925=
91-1-maciej.fijalkowski@intel.com?part=3D10
