Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E9349B0D
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502614; cv=none; b=bquxHmgJSVIvZuxt6xBtD3dSUk/gYqjMHdvh/+qY7mlP3zfb5PTxS6TAnJ7n5NnR07GCrzieW2Eow+0yBCC/8dGfezU3+cG1uMJAPRIDZ5dIPJ9AOSzqbt+mrZ6wE/sMkVxv66kqbMmeeJizVVaR7zdOOJkak1s/fph0u49oxjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502614; c=relaxed/simple;
	bh=Gr55erlf7eNfN4Oraclgyqbglyn/iuzC2DrxTUT6Y2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xnpc7BFkpzskfvnLTKvB9lXSl2NUpkKHF16jRUX9THY0lE89aqX2swM2fR2HJtI4w191oMOszKJ1xXWDbOu16dynyN6JY8g7QAJE3z39AtbtsoYU/1dEVgDjdJ+A6+2EEfT5wUrPh2bMIdSDHmEPFhp7DvF09FEphkswoiS/0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXQNXu8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXQNXu8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC9C19425;
	Wed, 29 Apr 2026 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777502613;
	bh=Gr55erlf7eNfN4Oraclgyqbglyn/iuzC2DrxTUT6Y2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VXQNXu8eNAWE93AjnQRfmM/8j/WqnGreVocha6sJiLRP+KO9q/HAOD8vKpl3kazMN
	 QnqzTirsqjiKIp1vZLaZfuikGXW4GRi4uDe1JyZBosbE8xV3XRjAPRIo9O2e6t5iie
	 JdEpQMVYa3x37qSllMU6qegLjkypZkgUrQCOzIVW8rKHUbsRBuYtD3XRrjNhid3lJ8
	 l4pDfJHfQltDcepcONdrfoLJqUX6HOo+EUAZ6xBMPcHiArt9/wVgRjRK+eWFRTkv78
	 E6ksGU559HnxrEetPfa2hld221OhPIu2kOlPgCydP5v+mtuS9ManqOO16jZJY1pS+q
	 IYAK9tYtZpzfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 10/11] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-tcp-dm-netkit-v1-10-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-10-719280eba4d2@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:43:32 +0000
Message-Id: <20260429224333.A2FC9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded little-endian byte order for BPF global variable map u=
pdate breaks the test on big-endian architectures.
--

commit 33211f25ad75b60103232678a2183e101cf2a050
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv

When sending from a namespace that has access to a netkit device with a
leased queue, the nk primary in the host namespace needs to redirect its
RX to the physical device. This patch adds that redirection bpf program
and teaches the harness to install it.

> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py

[ ... ]

> @@ -505,3 +520,31 @@ class NetDrvContEnv(NetDrvEpEnv):
> +    def _attach_primary_rx_redirect_bpf(self):

[ ... ]

> +        bss_map_id =3D self._find_bss_map_id(redirect_prog_id)
> +        phys_ifindex_bytes =3D self.ifindex.to_bytes(4, byteorder=3D'lit=
tle')

Will this cause the selftest to fail on big-endian architectures like s390x?

The test script hardcodes byteorder=3D'little' when serializing the physical
interface index to write to the BPF .bss map. However, the BPF program runs=
 in
native byte order and will read the little-endian map bytes as a byte-rever=
sed
32-bit integer on big-endian architectures.

This would result in an incorrect interface index being passed to
bpf_redirect_neigh(), causing it to fail silently.

> +        value_hex =3D ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
> +        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-tcp-dm-net=
kit-v1-0-719280eba4d2@meta.com?part=3D10
