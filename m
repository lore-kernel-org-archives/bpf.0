Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429840DFD7
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334712; cv=none; b=jh3of9mN1Ey5Raho2HYFAyHGIcnxewKT+GA0nmxZfs2AjpDWjyHCHxt5gaHr0QHpn2f4U6omT+2b7UMfZrWobJFOLkk7XVVdm7PnZJe3oS0Yh/AyRybIHbunAkUSefXSfolX54yNK/rB2Gfp6lsbdH85f3bITB2t+dvwaz0U1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334712; c=relaxed/simple;
	bh=sKSTsYQriqy0EAUNU6OsOMjc9MEyUsONRnmuP91TTNA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m59HuoKLB4n3cXid0vRL8fY2dr4fva/x7QV0/Lbi3rqsHn6HSiHEvC8SGqiXbdpVj5mxR8xsV1qjvu5ZwYRBt4g4S6Toaau6naJCv+Guhm8+Qx7m/Qj+6dTebyogisXO8OPp/57jscquCjHtq+HU7jm/+RL2Xt8sqkkhoBzvASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di9TO6dx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di9TO6dx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785AEC19425;
	Tue, 28 Apr 2026 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334712;
	bh=sKSTsYQriqy0EAUNU6OsOMjc9MEyUsONRnmuP91TTNA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Di9TO6dx2w949BESdLFyZyY8Ioo/WoakcE1zwEgftOpRIPKXMtTiPAfqv1vZsJ2ap
	 Y47mPFVNocQJICauRxAtq9FH3CxO6r2OniOyhuhRy50m42yzbLfkhEarPzyMQERuZ9
	 2xfAsX6EG1Vv5Q4bkmRinq+o6uXW55ZXeG7m+YEbpXd95ABP/Idk7BW5gYxJB6uSvP
	 7d7QTFm+cCmHIb3g7ANXPVomdxhefzavKbiUsudJBeu4bfgoB3f2x+17km0Yrjr8+n
	 AN0vFI4l+aWBOzaTIg1+jtNBRH07KFZ621Qa9AJuw3ivxr4crVr/HV/+glazRtgWLJ
	 sOdxN/Kfo/cQA==
Content-Type: multipart/mixed; boundary="===============7496180196107845515=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <718b304e68b3910806cc3baa79197e52f218f1ffda1f4b0e1dbbd02c09d4fbcd@mail.kernel.org>
In-Reply-To: <20260427232313.1582588-5-puranjay@kernel.org>
References: <20260427232313.1582588-5-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: Add XDP load-balancer common definitions
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,feichen@meta.com,taragrawal@meta.com,ndixit@meta.com,tehnerd@tehnerd.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 00:05:12 +0000 (UTC)

--===============7496180196107845515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/xdp_lb_bench_common.h b/tools/testing/selftests/bpf/xdp_lb_bench_common.h
> new file mode 100644
> index 000000000000..aed20a963701
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/xdp_lb_bench_common.h
> @@ -0,0 +1,112 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#ifndef XDP_LB_BENCH_COMMON_H
> +#define XDP_LB_BENCH_COMMON_H

[ ... ]

> +#ifdef __BPF__
> +#define lb_htons(x)	bpf_htons(x)
> +#define LB_INLINE	static __always_inline
> +#else
> +#define lb_htons(x)	htons(x)
> +#define LB_INLINE	static inline
> +#endif
> +
> +LB_INLINE __be32 create_encap_ipv4_src(__u16 port, __be32 src)
> +{
> +	__u32 ip_suffix = lb_htons(port);
> +
> +	ip_suffix <<= 16;
> +	ip_suffix ^= src;
> +	return (0xFFFF0000 & ip_suffix) | IPIP_V4_PREFIX;
> +}

Does this mix host-endian arithmetic with network-order types?

Shifting and masking __be32 values using host operations modifies
different IP octets depending on the architecture.

Also, on big-endian systems, will the host-order constant IPIP_V4_PREFIX
(4268) map to 0.0.16.172 instead of 172.16.0.0?

This concern was raised in review of v1:

  https://lore.kernel.org/bpf/20260420132625.95C0AC2BCB9@smtp.kernel.org/

> +
> +LB_INLINE void create_encap_ipv6_src(__u16 port, __be32 src, __be32 *saddr)
> +{
> +	saddr[0] = IPIP_V6_PREFIX1;
> +	saddr[1] = IPIP_V6_PREFIX2;
> +	saddr[2] = IPIP_V6_PREFIX3;
> +	saddr[3] = src ^ port;
> +}

Are we mixing endianness here by applying a host-endian XOR operation
between a __be32 source and a __u16 port?

Looking at the parallel IPv4 version above, it converts port with
lb_htons(port) before the XOR operation. Shouldn't this be:

  saddr[3] = src ^ lb_htons(port);

to match the IPv4 version's byte order handling?

On little-endian architectures, when port=0x1234, the XOR will use
0x3412 (byte-swapped during 32-bit promotion) instead of the intended
value. This will cause packet validation failures and incorrect routing
behavior when these functions are eventually used.

This concern was raised in review of v1:

  https://lore.kernel.org/bpf/20260420132625.95C0AC2BCB9@smtp.kernel.org/

> +
> +struct flow_key {
> +	union {
> +		__be32 src;
> +		__be32 srcv6[4];
> +	};
> +	union {
> +		__be32 dst;
> +		__be32 dstv6[4];
> +	};
> +	union {
> +		__u32 ports;
> +		__u16 port16[2];
> +	};
> +	__u8 proto;
> +	__u8 pad[3];
> +};
> +
> +struct vip_definition {
> +	union {
> +		__be32 vip;
> +		__be32 vipv6[4];
> +	};
> +	__u16 port;
> +	__u8 proto;
> +	__u8 pad;
> +};

[ ... ]

> +struct real_definition {
> +	__be32 dst;
> +	__be32 dstv6[4];
> +	__u8   flags;
> +};

Should dst and dstv6 be wrapped in an anonymous union?

The other dual-stack IP structures in this header (flow_key and
vip_definition) use a union to save memory in BPF maps and maintain
structural layout.

Also, does this structure need explicit trailing padding? There are
currently 3 bytes of implicit trailing padding which might cause UAPI
ABI mismatch issues between 32-bit and 64-bit architectures.

These concerns were raised in review of v1:

  https://lore.kernel.org/bpf/20260420132625.95C0AC2BCB9@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25025533577
--===============7496180196107845515==--
