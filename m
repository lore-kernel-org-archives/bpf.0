Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5F39EB58
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650936; cv=none; b=X0cXCdvxeVDxBEMC11gE2JVSAb/2lanxMCqBE1CM+uOn6Z8gHaHzNv2drK76wGLJVd6lhSn14+Qt0NTfLh1vGJX4OmnW3TXLE64H15+qn28sp7ADHmHYtwWHHYIi5pRYW8FLDXSDIG+NIEMQtPBn4775szPQq5/V7A+bLeN9lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650936; c=relaxed/simple;
	bh=00mEtE1fAiE1E/FcO+J11xDqBOO+T5tc/vvKNX/7JXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjiWp/0iRdeJ3+SEMKuUTm5CM2j46F8PYva4T6iKoF+l+2JNtQ6lkNUYA+T4uosHJaxSgNu6B7rUMaG8KH98qJpGRc2giFJC9p5PXvx1pxR2nZUsbYoJfRha2vf8EilSz/xcCk+lTjB5IPImHQTvu3qwIpWfe37xtKnrB4yYFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHjorSuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHjorSuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5D7C2BCB7;
	Wed, 13 May 2026 05:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650936;
	bh=00mEtE1fAiE1E/FcO+J11xDqBOO+T5tc/vvKNX/7JXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pHjorSuJIxUCVm1jbLeJIlhZ720hzPYIBnEP8tfwuAvTk1LnxdUzLZVf9d484r0KI
	 pX8ug3TUd6a1VQKVnp8b4/uDAZGFshSFouXfZfhHFPD5/y1DOSlgnmzTF3c4oJap4e
	 xIR/4MwnIZpoTpqNQSFeq07ObGIaZTSHxj0HbYz863NrXMjc6o6fnxd+Az4YlLFJSU
	 +9nw/53WPOqgzvb7QqHsinjtm8Ce024u1KS+JAfpBvk6boRa2vvvZXIULjwelx3s+X
	 p/CCJNl1ZU6+MTnAU3h9zW3Wx/ycF0ozLM2e3eMECZwq7TFRl8ijUq7DTvribMfu6E
	 WxPwvfQ2LgqCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 7/8] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511-tcp-dm-netkit-v4-7-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-7-841b78b99d74@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:42:15 +0000
Message-Id: <20260513054216.0B5D7C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Hardcoded little-endian byte order for BPF map updates corrupts =
variables on big-endian architectures.
--

commit 32b478cb3da65a3aa47ba2e69fc7eb3c3f2667d9
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv

This commit adds a BPF TC program to redirect non-ICMPv6 IPv6 traffic to a
physical device when sending from a namespace with a netkit leased queue. It
introduces the primary_rx_redirect parameter to NetDrvContEnv to attach
this program and update the physical ifindex via the .bss map.

> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> index 409b419222454..af8e1de8ed7b1 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py

[ ... ]

> @@ -505,3 +529,36 @@ class NetDrvContEnv(NetDrvEpEnv):
>          value =3D ipv6_bytes + ifindex_bytes
>          value_hex =3D ' '.join(f'{b:02x}' for b in value)
>          bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")
> +
> +    def _attach_primary_rx_redirect_bpf(self):

[ ... ]

> +        if redirect_prog_id is None:
> +            raise Exception("Failed to get primary RX redirect BPF prog =
ID")
> +
> +        bss_map_id =3D self._find_bss_map_id(redirect_prog_id)
> +        phys_ifindex_bytes =3D self.ifindex.to_bytes(4, byteorder=3D'lit=
tle')

Is it safe to hardcode the byte order to little-endian here?

Since BPF .bss maps are read by the BPF program using the host's native
endianness (as volatile __u32 phys_ifindex), this might result in a
swapped 32-bit integer on big-endian architectures like s390x.

For example, an ifindex of 2 could be read as 33554432, causing
bpf_redirect_neigh() to receive an invalid interface index.

Could this use sys.byteorder instead of 'little' to ensure portability?

> +        value_hex =3D ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
> +        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value h=
ex {value_hex}")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-tcp-dm-net=
kit-v4-0-841b78b99d74@meta.com?part=3D7
