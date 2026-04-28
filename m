Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E630238D54
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336682; cv=none; b=u35St9JUCIEdoHxXjxUkRmlBPE9F05VlaT27ThN/1nggrQizF5LcXTosffgCMthzuunsdtSIPtvwEVe3Nfi7H7ie6oitv0P5o3E5Kbo1gUAKHKnt+pe/XBBvHAutnI0gfuoleX5H7xOZKrCshyrel4IF8nPloyhC+rUblJtElNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336682; c=relaxed/simple;
	bh=fHZub6ZXW6Bf7k9MRWLmWLhYpeM8z8ha/HoRWGE9ycs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yt1gAcA1TVJVpmFqFt4uvsmTKzBXqYhd2SmjXd/vQdxije+fQmC8KRSphNXFF+iTEuLKd68LgBTpj1fYKkgsQ5Iffw1TCThHf7waSBabQDeQI/zsFl3YfAJG0FLUMMAQ6zMVjrUSMTeYaMA2XzAfj21Tyq9E3LDfkKdapHrbqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5/qny/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5/qny/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1302C19425;
	Tue, 28 Apr 2026 00:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336681;
	bh=fHZub6ZXW6Bf7k9MRWLmWLhYpeM8z8ha/HoRWGE9ycs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n5/qny/JOnLRJkhAWLtHFhTydgKOE26KIzaDiBjJdEBl3cDIIZiPRChKaeG378oOC
	 XWvJt7CSeiLPtpTGOkBT4/EtdgG3nHNRSahwoz93+O4Jgcsc4L8wqQ2j1/hFJbAk4h
	 Bz9hWd9WynBCElhrkyYcKBPSB5GtvmGi1eIwJN1kUViQMHVqyia/mqblK8u8WecVSm
	 fU1xB6p+z3Oz5g/YzJoxZHesEVV3b8GVruuZV4hYZhWF/m02Iesu9eWzZB5iMCKyA4
	 2HdcjD+HJKJHsXh2J4JklQT1AT7Pcy1FaWfI3eGW/KHcBlTImIHreM3oG1zm0tnSPV
	 NA0vTzVPXVbNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/7] selftests/bpf: Add XDP load-balancer
 common definitions
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427232313.1582588-5-puranjay@kernel.org>
References: <20260427232313.1582588-5-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 00:38:01 +0000
Message-Id: <20260428003801.C1302C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Endianness bug and invalid arithmetic on network-order values in=
 IP encapsulation helpers.
- [Medium] Implicit compiler padding in shared BPF/userspace structures cau=
ses cross-architecture ABI breakage.
- [Low] Missing anonymous union for IPv4/IPv6 addresses in `struct real_def=
inition`.
--

commit 27405cc11d849dd578c45222803d3bbd40b0e500
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add XDP load-balancer common definitions

This commit adds the shared header for the XDP load-balancer benchmark.
It defines the data structures used by both the BPF program and userspace,
along with encapsulation source-address helpers.

> diff --git a/tools/testing/selftests/bpf/xdp_lb_bench_common.h b/tools/te=
sting/selftests/bpf/xdp_lb_bench_common.h
> new file mode 100644
> index 000000000000..aed20a963701
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/xdp_lb_bench_common.h

[ ... ]

> +LB_INLINE __be32 create_encap_ipv4_src(__u16 port, __be32 src)
> +{
> +	__u32 ip_suffix =3D lb_htons(port);
> +
> +	ip_suffix <<=3D 16;
> +	ip_suffix ^=3D src;
> +	return (0xFFFF0000 & ip_suffix) | IPIP_V4_PREFIX;
> +}

Is it safe to perform bitwise operations directly on network-order values
like this? Since lb_htons() returns a network-order port, left-shifting it
by 16 and masking with host-order constants like 0xFFFF0000 or combining
it with IPIP_V4_PREFIX (4268) seems to assume a little-endian architecture.
Could this generate corrupted packet headers on big-endian systems?

> +
> +LB_INLINE void create_encap_ipv6_src(__u16 port, __be32 src, __be32 *sad=
dr)
> +{
> +	saddr[0] =3D IPIP_V6_PREFIX1;
> +	saddr[1] =3D IPIP_V6_PREFIX2;
> +	saddr[2] =3D IPIP_V6_PREFIX3;
> +	saddr[3] =3D src ^ port;
> +}

Will saddr[0] evaluate to the correct prefix on all architectures? Because
IPIP_V6_PREFIX1 is defined as 1, it evaluates to 0100:: on little-endian
but ::1 on big-endian.

Also, is it intended to XOR the network-order __be32 src with the
host-order __u16 port without a prior byte-order conversion?

[ ... ]

> +struct real_pos_lru {
> +	__u32 pos;
> +	__u64 atime;
> +};

Could this shared structure cause ABI breakage between 32-bit userspace
and 64-bit BPF environments? In 64-bit environments, the compiler will
insert 4 bytes of padding after pos, but 32-bit environments only require
4-byte alignment for __u64. Should an explicit padding field be added to
ensure identical memory layout?

> +
> +struct real_definition {
> +	__be32 dst;
> +	__be32 dstv6[4];
> +	__u8   flags;
> +};

This isn't a bug, but earlier structures like flow_key and vip_definition
use an anonymous union to overlay their IPv4 and IPv6 addresses. Should
dst and dstv6 be placed in a union here as well to save memory and
maintain consistency?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427232313.1582=
588-1-puranjay@kernel.org?part=3D4
