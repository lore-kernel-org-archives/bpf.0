Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2C1E511
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027347; cv=none; b=RfXrc+jjzyNSNiHzunHvnrNiduMNH6TQ8e2aGzMR/dUiU2Dam/swxxxjurtY0H8ech1JnQj78F9US88fNPvK4qZuBxJLi/0cbiJxLssPi7m2S1wMNN6K9v7jVHy9TlJiWB1XVWC4p1JHFKTZJMSkEYvBod8LKU68G2L2zeMh5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027347; c=relaxed/simple;
	bh=4ZgpZEZG2dd70diPlcs77dmGt83gQcQMnBRWwErxRJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=coSLU4PE1JVcY+rol1HpjMid6fHhZRwpdfwWui56AtN3kxUhLL3duN2X0Ec5rDL8il/Yv8xFYfMPcBIfgXzA1Ibyjbf0RqX8EJDV2XipyTS/adsJgHFAEQ7UDpMtDnTokPcoc0OIkE6DmhFAU+3sZgEh9pLtVSpT6JOxSYKIvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7Mz6Vl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7Mz6Vl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA08C2BCB4;
	Wed,  6 May 2026 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778027347;
	bh=4ZgpZEZG2dd70diPlcs77dmGt83gQcQMnBRWwErxRJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=r7Mz6Vl8cA9MPsi09hJLfJPt0ZAyj4aSkMlutdfTRjeKBp7mWlf7Zgz0jClPbfTql
	 W1AUSYnxB5BOzNZbQVfiX9gq0b7EuiiLovcZJPCiPuxCT0vK3YR5VdcQMsSwYLqFdS
	 P5fJpIrUh5Tj0vrbxcdjk7O6NGKXPEv8yY2e9/iRnEMuM58ZLgLgj7+OssFRWuAvwM
	 Dgdtw4S5ZEgigWQ34VdK/gb4PEF3T58wEeYHFEXWDT+1GjvdiXWytt/MXTbqA71k0d
	 j6fQT0aG9N3b74EYijkdAHVD+dMG1q0tdkA4UtMthYd4eRm2auLaWpPyPA7eQZf2kJ
	 kROSFl4J9I9/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/6] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-tcp-dm-netkit-v2-5-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-5-56d52ac72fd4@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 00:29:06 +0000
Message-Id: <20260506002907.4BA08C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoding `byteorder=3D'little'` when packing BPF map values br=
eaks the test on big-endian architectures.
--

commit 5fba7c06c7ed450ad321c1238af07a759467e25a
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv

When sending from a namespace that has access to a netkit device with a
leased queue, the nk primary in the host namespace needs to redirect its
RX to the physical device. This patch adds that redirection bpf program
and teaches the harness to install it.

> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> index 24ce122abd9c..d569d01ef791 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
[ ... ]
> @@ -505,3 +520,31 @@ class NetDrvContEnv(NetDrvEpEnv):
[ ... ]
> +    def _attach_primary_rx_redirect_bpf(self):
> +        """Attach BPF redirect program on the primary netkit ingress."""
[ ... ]
> +        bss_map_id =3D self._find_bss_map_id(redirect_prog_id)
> +        phys_ifindex_bytes =3D self.ifindex.to_bytes(4, byteorder=3D'lit=
tle')

Does hardcoding byteorder=3D'little' here break the test on big-endian
architectures?

Since .bss maps store integers in native byte order, and BPF programs execu=
te
using the host's native endianness, passing a 4-byte little-endian sequence
on a big-endian system (like s390x) will cause the kernel to interpret the
ifindex backwards.

For example, an ifindex of 1 (01 00 00 00) becomes 16777216 (0x01000000).
This would cause bpf_redirect_neigh() to fail because the byte-swapped ifin=
dex
does not exist on the system, silently dropping all packets.

While a similar pre-existing pattern exists in _attach_bpf(), this duplicat=
es
it into the newly added _attach_primary_rx_redirect_bpf() function.

Could this dynamically use byteorder=3Dsys.byteorder instead so the seriali=
zation
matches the host architecture's endianness?

> +        value_hex =3D ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
> +        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-tcp-dm-net=
kit-v2-0-56d52ac72fd4@meta.com?part=3D5
