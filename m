Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD702AD24
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334714; cv=none; b=bVeSKP43b+zftP8AXDK1ZyPPM6ed6pAnQuGayO6xdoEl58AJCGPQ1e30wHCvf7q7Mh14m/3nHbxZasm39YFe3ZxqxtoMLPfu2SS1gz9Te30fOAEvzFuod1Mmv5D+OTDxTprrVoXmXaqGWvXldn9sEYyzaV49N1uF4c8f8Vwqbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334714; c=relaxed/simple;
	bh=zextLOcf1K/7B+YZ5k138TjDM30IOiMD5UXCS09FXbY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XMvgETNAQBiHCDQXQWRyEsJaU6c7bOHYhtGGzFbnUDNFF6782ggKOnRpV6HA/Lwy6JTs9hR2UsbPSXkWwlCRsmEGbCCGyn1SwzjpExt6+S7Ui++DkShTxZA5BemrDPY+vJSFKqY2NWqgwSrramm8H0c6EIkelTe06cTskn7cfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyAwObl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyAwObl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EC6C19425;
	Tue, 28 Apr 2026 00:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334714;
	bh=zextLOcf1K/7B+YZ5k138TjDM30IOiMD5UXCS09FXbY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GyAwObl3CwwSW1pQbZWHYYr2YvBrvAuExr3F5wQOCUTvcFZfxkyBM1JRz3ZwHyWMa
	 9S9G7UprnfRrw5lP0Yz/z00SQl6i7mGW56H/VYozrhXTzdRk4cRQZJNoTyWLU9QokS
	 ml66Z0D/OdY1Lem8xRANLWdfDX7xLSUEITqO8phqT7y9kYfPUOgPcCRIyp+UB97mHt
	 Yam9b89/I/ReiDGgAGWwgrdOM2YH12UdJ/8xeNW0eV+DqLxeR0rxpDyNCl7wuZfsFV
	 0TEa4MZPV5vTMZ+REwQAWkE/2womt8RfWkRDKOB6PvSsYgbXnZECmHYh79jSSGL91z
	 KM/gnlmJyRDmA==
Content-Type: multipart/mixed; boundary="===============7474673564349497249=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <26d90d76f6523fb760921bde5d54e2cc87f3d2136d2c0dfdae6edf0de9117dda@mail.kernel.org>
In-Reply-To: <20260427232313.1582588-7-puranjay@kernel.org>
References: <20260427232313.1582588-7-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add XDP load-balancer benchmark driver
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,feichen@meta.com,taragrawal@meta.com,ndixit@meta.com,tehnerd@tehnerd.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 00:05:14 +0000 (UTC)

--===============7474673564349497249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
> new file mode 100644
> index 000000000000..0b6709a2b03c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c

[ ... ]

> +static void build_packet(int idx)
> +{
> +	const struct test_scenario *sc = &scenarios[idx];
> +	__u8 *p = pkt_buf[idx];
> +	struct ethhdr eth = {};
> +	__u16 proto;
> +	__u32 off = 0;

[ ... ]

> +	} else {
> +		struct iphdr iph = {};
> +		__u32 ip_off = off;
> +
> +		iph.version  = 4;
> +		iph.ihl      = sc->set_ip_options ? 6 : 5;
> +		iph.ttl      = 64;
> +		iph.protocol = sc->ip_proto;
> +		iph.saddr    = htonl(sc->src_addr);
> +		iph.daddr    = htonl(sc->vip_addr);
> +		iph.frag_off = sc->set_frag ? htons(IP_MF) : 0;
> +		off += sizeof(iph);
> +
> +		if (sc->set_ip_options) {
> +			/* NOP option padding (4 bytes = 1 word) */
> +			__u32 nop = htonl(0x01010101);
> +
> +			memcpy(p + off, &nop, sizeof(nop));
> +			off += sizeof(nop);
> +		}
> +
> +		build_l4(sc, p, &off);
> +
> +		memcpy(p + off, "bench___payload!", 16);
> +		off += 16;
> +
> +		iph.tot_len = htons(off - ip_off);
> +		iph.check   = ip_checksum(&iph, sizeof(iph));
> +		memcpy(p + ip_off, &iph, sizeof(iph));

Does the IP header checksum calculation exclude the IP options when
set_ip_options is true? Since ip_checksum(&iph, sizeof(iph)) only
computes over the 20-byte stack structure iph, and the 4 bytes of NOP
options are added separately to the packet buffer after the base header,
those option bytes are not covered by the checksum.

Could this cause the BPF program to see an invalid checksum and drop the
packet prematurely instead of processing the intended options logic?

This concern was raised by sashiko-bot@kernel.org in the RFC v1 thread
https://lore.kernel.org/bpf/20260420171123.CC789C19425@smtp.kernel.org/
and does not appear to have been addressed.

> +	}
> +
> +	pkt_len[idx] = off;
> +}

[ ... ]

> +static void populate_lru(const struct test_scenario *sc, __u32 real_idx)
> +{
> +	struct real_pos_lru lru = { .pos = real_idx };
> +	struct flow_key fk;
> +	int i, err;

When atime is not explicitly initialized, does this leave it at zero?
If the machine running the selftest has been up for more than 30 seconds
(LRU_UDP_TIMEOUT), would lookups against this pre-populated entry see
an age of bpf_ktime_get_ns() - 0 and immediately evict it?

This could lead to unintended LRU misses in UDP scenarios that expect
LRU hits (like S_UDP_V4_LRU_HIT, S_UDP_V6_LRU_HIT) and cause validation
failures.

This concern was raised by sashiko-bot@kernel.org in the RFC v1 thread
https://lore.kernel.org/bpf/20260420171123.CC789C19425@smtp.kernel.org/
and does not appear to have been addressed.

> +
> +	build_flow_key(&fk, sc);
> +
> +	/* Insert into every per-CPU inner LRU so the entry is found
> +	 * regardless of which CPU runs the BPF program.
> +	 */
> +	for (i = 0; i < nr_inner_maps; i++) {
> +		err = bpf_map_update_elem(lru_inner_fds[i], &fk, &lru, BPF_ANY);
> +		if (err) {
> +			fprintf(stderr, "lru_inner[%d] [%s]: %s\n", i, sc->name,
> +				strerror(errno));
> +			exit(1);
> +		}
> +	}
> +}

[ ... ]

> +static void build_expected_packet(int idx)
> +{
> +	const struct test_scenario *sc = &scenarios[idx];
> +	__u8 *p = expected_buf[idx];
> +	struct ethhdr eth = {};
> +	const __u8 *in = pkt_buf[idx];
> +	__u32 in_len = pkt_len[idx];
> +	__u32 off = 0;
> +	__u32 inner_len = in_len - sizeof(struct ethhdr);

[ ... ]

> +	if (sc->encap_v6_outer) {
> +		struct ipv6hdr ip6h = {};
> +		__u8 nexthdr = sc->is_v6 ? IPPROTO_IPV6 : IPPROTO_IPIP;
> +
> +		ip6h.version     = 6;
> +		ip6h.nexthdr     = nexthdr;
> +		ip6h.payload_len = htons(inner_len);
> +		ip6h.hop_limit   = 64;
> +
> +		create_encap_ipv6_src(htons(sc->src_port),
> +				      sc->is_v6 ? htonl(sc->src_addr_v6[0])
> +						: htonl(sc->src_addr),
> +				      (__be32 *)&ip6h.saddr);
> +		htonl_v6((__be32 *)&ip6h.daddr, sc->tunnel_dst_v6);
> +
> +		memcpy(p + off, &ip6h, sizeof(ip6h));
> +		off += sizeof(ip6h);
> +	} else {
> +		struct iphdr iph = {};
> +
> +		iph.version  = 4;
> +		iph.ihl      = sizeof(iph) >> 2;
> +		iph.protocol = IPPROTO_IPIP;
> +		iph.tot_len  = htons(inner_len + sizeof(iph));
> +		iph.ttl      = 64;
> +		iph.saddr    = create_encap_ipv4_src(htons(sc->src_port),
> +						     htonl(sc->src_addr));
> +		iph.daddr    = htonl(sc->tunnel_dst);
> +		iph.check    = ip_checksum(&iph, sizeof(iph));
> +
> +		memcpy(p + off, &iph, sizeof(iph));
> +		off += sizeof(iph);
> +	}

Are the port values being double byte-swapped here? The code passes
htons(sc->src_port) into create_encap_ipv6_src() and create_encap_ipv4_src(),
but looking at xdp_lb_bench_common.h, those functions internally call
lb_htons(port) again. On little-endian architectures, would this cause
the port to be swapped twice, ending up in host order instead of
network order?

Additionally, the encapsulation helpers use bitwise shifts and XORs on
host integers (like IPIP_V4_PREFIX) directly into network-order types.
On big-endian architectures, could this place the prefix in the wrong
bytes, altering the IP address semantics and causing validation failures?

This concern was raised by sashiko-bot@kernel.org in the RFC v1 thread
https://lore.kernel.org/bpf/20260420171123.CC789C19425@smtp.kernel.org/
and does not appear to have been addressed.

> +
> +	memcpy(p + off, in + sizeof(struct ethhdr), inner_len);
> +	off += inner_len;
> +
> +	expected_len[idx] = off;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25025533577
--===============7474673564349497249==--
