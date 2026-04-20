Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDA3FCB16
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691585; cv=none; b=B8/Hi14Pj97qAa1Z8XpEqByDU4jfcxaoYmaB1W81ubBOCsOWEBpNqX0dqdOn3IxW0KkA+hqQKAFyfT/qVmPdGAJmnGtwt4LG+bL5eSZOSyOwSoJiyLqgESRWfQuWyojrwpF4Cj2NRoIGVyyfVTgFFDiPZugljECD9BcQ7r5fQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691585; c=relaxed/simple;
	bh=6FkmanAG0L1+5KeEGwkUdhaj+rTzdXX2qc725gl+uPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XfcrE/VVZknr+lVi8pqCEWkUWQqTv4LoMqlYEBB5wNkXfxKYhvg8dGlx4md4/jyhswK2ZR3bkmRoAcYEqVGKbUQY6pPAgSA6BErNqrHGJy58/kUCNDJX8xQdb8S12xuvYIOGnmsXfKpOD3AAxY4EMiN5VDoP7c40KQrlaV8qpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWXPmHBo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWXPmHBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C0AC2BCB9;
	Mon, 20 Apr 2026 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691585;
	bh=6FkmanAG0L1+5KeEGwkUdhaj+rTzdXX2qc725gl+uPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PWXPmHBo2Vppn+6J52OvwAnK6wC0VwL/neSeE9jdKgx0f05OhFIK8gOZgi4E6u0nE
	 Yup6lU8ZzMP9N1eXPAb2zfLwzpvZo+s1/xZnOW/62aZ3q8DFbBRh73maLJErm5bvnt
	 IEpgH1fUA7iPLjmt0OMPpu/Cm6uk6Q9m5iyEVNqK7Jd+wbs3ghr6yjOlTz0NnZ/gcM
	 PnjnmN6VxeRrScQg0nSJ4D4RQLp0TYldpRQ/vHBIonzjjliTPEFD6yiAfdIu+yRZ2P
	 OqSmJ4Us2GOvxQsgEMYDas45i8QgEnLA15igXg1BO32rSuC/kR6ej63YUHI7YURXKv
	 ehVUoeMxW1JqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/bpf: Add XDP load-balancer
 common definitions
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420111726.2118636-4-puranjay@kernel.org>
References: <20260420111726.2118636-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 13:26:25 +0000
Message-Id: <20260420132625.95C0AC2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Endianness and byte-order bugs in encapsulation source-address h=
elpers.
- [Medium] Missing `union` in `struct real_definition` wastes memory and br=
eaks structural layout.
- [Medium] Implicit padding in UAPI-like shared data structures breaks 32-b=
it vs 64-bit ABI.
--

commit ca26f44639e166e57519b0a54055b04c057fc248
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add XDP load-balancer common definitions
   =20
This commit adds a shared header for the XDP load-balancer benchmark, defin=
ing
the data structures used by both the BPF program and userspace. It also
provides encapsulation source-address helpers.

> diff --git a/tools/testing/selftests/bpf/xdp_lb_bench_common.h b/tools/te=
sting/selftests/bpf/xdp_lb_bench_common.h
> new file mode 100644
> index 0000000000000..aed20a9637017
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

Does this mix host-endian arithmetic with network-order types?

Shifting and masking __be32 values using host operations modifies different=
 IP
octets depending on the architecture. Also, on big-endian systems, will the
host-order constant IPIP_V4_PREFIX (4268) map to 0.0.16.172 instead of
172.16.0.0?

> +LB_INLINE void create_encap_ipv6_src(__u16 port, __be32 src, __be32 *sad=
dr)
> +{
> +	saddr[0] =3D IPIP_V6_PREFIX1;
> +	saddr[1] =3D IPIP_V6_PREFIX2;
> +	saddr[2] =3D IPIP_V6_PREFIX3;
> +	saddr[3] =3D src ^ port;
> +}

Are we also mixing endianness here by applying a host-endian XOR operation
between a __be32 source and a __u16 port?

[ ... ]
> +struct real_pos_lru {
> +	__u32 pos;
> +	__u64 atime;
> +};

Could this struct layout cause mismatches between a 32-bit userspace binary
and a 64-bit BPF program?

Having a __u32 immediately followed by a __u64 introduces 4 bytes of implic=
it
padding on 64-bit architectures, but potentially no padding on 32-bit
architectures (where __u64 can be 4-byte aligned). Should explicit padding
be added here?

> +struct real_definition {
> +	__be32 dst;
> +	__be32 dstv6[4];
> +	__u8   flags;
> +};

Should dst and dstv6 be wrapped in an anonymous union?

The other dual-stack IP structures in this header (flow_key and
vip_definition) use a union to save memory in BPF maps and maintain structu=
ral
layout.

Also, does this structure need explicit trailing padding? There are current=
ly
3 bytes of implicit trailing padding which might cause the same UAPI ABI
mismatch issues mentioned above.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420111726.2118=
636-1-puranjay@kernel.org?part=3D3
