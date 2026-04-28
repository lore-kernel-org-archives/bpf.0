Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2482C2349
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777339761; cv=none; b=m7J9fILuiwM1StWilugqiAOE1fCRCuOPrEk4t+WcGcxny75b04Il1eH9d6zwEaxPbf2MKUGkxbwGd48YwQW8+aWIqXBW2p4mJP0Lia7RC7OAesrT+PpOhFwNTcvNMHSQTqyxlmBDrZrJhbIe2lyKO5gMKGTJWUwQGS6Bdg070C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777339761; c=relaxed/simple;
	bh=14beozC31s/baRQ0t9dRo2SGntRlXj8+C9d7yQjDXi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X/wKLVF6t5OD4joq1Kf6P2gBurKtufCZU20cHVENAzdHr+4oERJwpablOV2gfHJEFObsSoYSUsWOxIfEtA5Z8xPhZd5cXHzCC9ujOVtPY8xwoCLqwdFkbLPd4VwtU+y2InpO9c4T5olu38TgoQYUWSaRQbxjv+UiwIq1K37HX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIb8sTD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIb8sTD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A1C19425;
	Tue, 28 Apr 2026 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777339760;
	bh=14beozC31s/baRQ0t9dRo2SGntRlXj8+C9d7yQjDXi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VIb8sTD3PPhOvNd2vmoZBlmYwk12goGvzu5b5pD6knRo+MsH7qGlPBPAAofsYr/O2
	 7wdJ3i5vkt9WPxBtbHfa9ppkrlxos9OnTl7qUEC5erLyqysoZblc0QtEJ/WlLSb1Ic
	 0qd2y0dQL0F6/SOxH33TiquckIBUEMy77k2lha1VqbM6X0mOXkM3zwZp33BTjhuoQv
	 YNzBGDyJApU80zMFmcikd4qutMOanMeAk2yiV1NphFY9tyA9NY2SfAEUhK/OJ5c1Zh
	 mr4X2qZo20Ti/xYnN2VG8UbEHMCvbo9POBFzGUX+WFFPA4wWquMmrxTWTvfZukdlCz
	 aX0bLZgNqDznA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add XDP load-balancer
 benchmark driver
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427232313.1582588-7-puranjay@kernel.org>
References: <20260427232313.1582588-7-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 01:29:20 +0000
Message-Id: <20260428012920.C90A1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Incorrect IPv4 checksum calculation for packets with IP options in =
test packet generator
--

commit cc1cb16090fdc833cb82a1c6a168d6cb11005220
Author: Puranjay Mohan <puranjay@kernel.org>
selftests/bpf: Add XDP load-balancer benchmark driver

This commit wires up the userspace side of the XDP load-balancer benchmark.
It covers 24 scenarios and validates correctness before benchmarking by
comparing the output packet byte-for-byte against an expected packet.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c b/tools/te=
sting/selftests/bpf/benchs/bench_xdp_lb.c
> new file mode 100644
> index 000000000000..0b6709a2b03c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
[ ... ]
> +static void build_packet(int idx)
> +{
[ ... ]
> +	if (sc->is_v6) {
[ ... ]
> +	} else {
> +		struct iphdr iph =3D {};
> +		__u32 ip_off =3D off;
> +
> +		iph.version  =3D 4;
> +		iph.ihl      =3D sc->set_ip_options ? 6 : 5;
> +		iph.ttl      =3D 64;
> +		iph.protocol =3D sc->ip_proto;
> +		iph.saddr    =3D htonl(sc->src_addr);
> +		iph.daddr    =3D htonl(sc->vip_addr);
> +		iph.frag_off =3D sc->set_frag ? htons(IP_MF) : 0;
> +		off +=3D sizeof(iph);
> +
> +		if (sc->set_ip_options) {
> +			/* NOP option padding (4 bytes =3D 1 word) */
> +			__u32 nop =3D htonl(0x01010101);
> +
> +			memcpy(p + off, &nop, sizeof(nop));
> +			off +=3D sizeof(nop);
> +		}
> +
> +		build_l4(sc, p, &off);
> +
> +		memcpy(p + off, "bench___payload!", 16);
> +		off +=3D 16;
> +
> +		iph.tot_len =3D htons(off - ip_off);
> +		iph.check   =3D ip_checksum(&iph, sizeof(iph));

Does this calculation exclude the appended IP options from the checksum?

When sc->set_ip_options is true, the header length is set to 6 words (24
bytes) and 4 bytes of NOP options are copied directly into the packet
buffer. However, ip_checksum() is only passed sizeof(iph), which is exactly
20 bytes, and computes the checksum over the local iph struct alone.

While this logically malformed packet might not cause the current tests
to fail because the BPF program validates iph->ihl =3D=3D 5 before verifying
the IP checksum, could this mask bugs or produce false test failures if
the BPF program is later modified to validate L3 checksums?

> +		memcpy(p + ip_off, &iph, sizeof(iph));
> +	}
> +
> +	pkt_len[idx] =3D off;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.1582=
588-1-puranjay@kernel.org?part=3D6
