Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AC3815F0
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705084; cv=none; b=GH20zFfiFxr+3r2YdvoE5M1W2ozF5dD/LQumqsfcQ/q4nz2CKS4sc+UOkoX/ZmYVRkpQNkt4qZ0wbh6bplWQ9dz2CX95lR6IA8NsoOPGOr/DpFDGLLIg9NC+pYMvOaFnEnvD13wPm05kQubQCHdSVvseLeUGII5unYBpyD0sgHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705084; c=relaxed/simple;
	bh=sIPHmCtKB62mVUbxWDBfqBe3ss3YtbJxmc08r4gty2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VzqEMKqJO8cuCMQ+SJgrrNSyLa9gBeYm6fbLk0KJvLnI5LlfHWwTchPymk8Dq9yeJch9GSojNsdNeGQ10fmbCse2wlRBUzPycxZPh+lVt9fuqyM7nzKnSjHQiu7nhYYJb0E/CLJ74KAIz8yEjOuVnhLyKAe8sjo/qvXXuUX2cLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1W/Btkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1W/Btkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC789C19425;
	Mon, 20 Apr 2026 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705083;
	bh=sIPHmCtKB62mVUbxWDBfqBe3ss3YtbJxmc08r4gty2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=p1W/BtkwEzbA1lP0TtRRyF/rJHUinDfOXtoVLwE4t89v9gsZjw8Hnq/AKpm+3m3K7
	 Qi2q4bP6iriqxyJxeRKVLS3z6ovsW2TkIrWm/A/S1mkp74T5NijNnYuVMqovJX0ekc
	 nHlmPbCGIN7XilgcHkI0VI1OsEwh3hiKcAkyXpnvToKu/BpODkzxp2tbpCcDaA++qS
	 pdtY/Wqu37sj+aESPoJseRU4AZv0pFSC0bGmApMUDInKj/alQoFDilLP4Z1Gcu3vVQ
	 b1kRkKvlduJyMyCVunujXvMPxreJKthWskpipEuLVKlWhwbW8j/Hlygd+QMIyuWjAx
	 9+ttbWkQWuI+w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 5/6] selftests/bpf: Add XDP load-balancer
 benchmark driver
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111726.2118636-6-puranjay@kernel.org>
References: <20260420111726.2118636-6-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 17:11:23 +0000
Message-Id: <20260420171123.CC789C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Double byte-swap and endian-unsafe bitwise arithmetic in IPv4/IPv6=
 encapsulation helpers.
- [High] Uninitialized `atime` during LRU pre-population causes immediate U=
DP cache eviction.
- [Medium] The computed IP header checksum explicitly ignores appended IP o=
ptions bytes.
--

commit 58cc34d2b388ed8d16360bc2fcd6b05fe083e6ef
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add XDP load-balancer benchmark driver

This commit adds a userspace driver for an XDP load-balancer benchmark.
It covers 24 scenarios testing various protocols, flags, and cache
patterns, and validates output packets and BPF map counters before
benchmarking.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c b/tools/te=
sting/selftests/bpf/benchs/bench_xdp_lb.c
> new file mode 100644
> index 0000000000000..f5c85b027d1c5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
[ ... ]
> +static void build_packet(int idx)
> +{
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

Does this checksum calculation exclude the IP options? Since iph is just
the 20-byte local stack structure, it seems the 4 bytes of options added to
the packet buffer are not covered by the checksum. This might cause the BPF
program to drop the packet prematurely due to an invalid checksum instead
of processing the intended options logic.

> +		memcpy(p + ip_off, &iph, sizeof(iph));
> +	}
> +
> +	pkt_len[idx] =3D off;
> +}
[ ... ]
> +static void populate_lru(const struct test_scenario *sc, __u32 real_idx)
> +{
> +	struct real_pos_lru lru =3D { .pos =3D real_idx };

Can this zero-initialized atime cause immediate UDP cache evictions? If the
machine running the selftest has an uptime greater than 30 seconds
(LRU_UDP_TIMEOUT), any lookups against this pre-populated entry might
see an age of bpf_ktime_get_ns() - 0 and immediately evict it. This could
lead to unintended LRU misses and validation failures.

> +	struct flow_key fk;
> +	int i, err;
[ ... ]
> +static void build_expected_packet(int idx)
> +{
[ ... ]
> +	if (sc->encap_v6_outer) {
> +		struct ipv6hdr ip6h =3D {};
> +		__u8 nexthdr =3D sc->is_v6 ? IPPROTO_IPV6 : IPPROTO_IPIP;
> +
> +		ip6h.version     =3D 6;
> +		ip6h.nexthdr     =3D nexthdr;
> +		ip6h.payload_len =3D htons(inner_len);
> +		ip6h.hop_limit   =3D 64;
> +
> +		create_encap_ipv6_src(htons(sc->src_port),

Since create_encap_ipv6_src() internally uses lb_htons(port), will passing
the port through htons() here cause a double byte-swap on little-endian
architectures? The same applies below for create_encap_ipv4_src().

Also, looking at the implementations of those encapsulation helpers, they
appear to use bitwise shifts and XORs on host integers (like IPIP_V4_PREFIX)
directly into network-order types. On big-endian architectures, could this
place the prefix in the lowest bytes instead of the highest, altering IP
semantics and causing validation failures?

> +				      sc->is_v6 ? htonl(sc->src_addr_v6[0])
> +						: htonl(sc->src_addr),
> +				      (__be32 *)&ip6h.saddr);
> +		htonl_v6((__be32 *)&ip6h.daddr, sc->tunnel_dst_v6);
> +
> +		memcpy(p + off, &ip6h, sizeof(ip6h));
> +		off +=3D sizeof(ip6h);
> +	} else {
> +		struct iphdr iph =3D {};
> +
> +		iph.version  =3D 4;
> +		iph.ihl      =3D sizeof(iph) >> 2;
> +		iph.protocol =3D IPPROTO_IPIP;
> +		iph.tot_len  =3D htons(inner_len + sizeof(iph));
> +		iph.ttl      =3D 64;
> +		iph.saddr    =3D create_encap_ipv4_src(htons(sc->src_port),
> +						     htonl(sc->src_addr));
> +		iph.daddr    =3D htonl(sc->tunnel_dst);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111726.2118=
636-1-puranjay@kernel.org?part=3D5
