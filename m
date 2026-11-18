Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020508;
	b=j1tZWdxJSf3wtUjjki61P7he5khTbiy05fiCBT9Dal4csMokaFAmzQk+/bWOj/qXrHtf
	 vjVzVN4rn+Pzbj3X6stmixxjOY4e6//no8WHwb5x7ekg43MoKQRwe85fXrsM0BhnSWyNY
	 beUCYGJvVeDhtMLs9NQhySms6Z4xx5DDC4KTxfzVOeuKQnqujYQgTZqonNqhsmflofKLM
	 i2OHhbihCwpHW0IZapttNw6QRc/tR2c6IVSG7jgwxQmGfEKusmFrvPRTrluujpTnGt2wx
	 7B7z9TXZkmnwUXxwveTZDBJ3knkW2HQgXzEHkuNulNk4n4nJgfWmw/qh2DPzhQ12l5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mOgLPSEvseGiM+lt3hVOzbVN2gaKU4CfAYEvT+plrto=;
	b=BnO63Ezf2rr2oldP5er3iVBxgpUnE2veu+VThOgqyjS7eMUZf1pSZ97Djr/ou1xcr9Fr
	 jq3xWoRMSLgkDJAFSIqiJxnFLD4tmfiEvdZAkzA400J/TjeVODs8SC3MalUQSZdwC1JcN
	 fwNbtvMt639+v6dz3enJGL8oaGopUioeAs6njvxvGGDo+slDECLqFPcqnpGCYGGDtchMB
	 8n3LX24Fx7fQDrluaJQ2BQ2cswaSATGIos0dVViFFmIqLLiIMvpQFkhG2u8ddwFLBmAdN
	 pVICHqHeNKVf1GMHh3OIe29yl05BVAgt1u7d9T95fHTyvmhlEhadROe2wijWK1y0IwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efpZk5bN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580D606A331
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efpZk5bN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2D31F000C8;
	Wed, 18 Nov 2026 16:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020508;
	bh=mOgLPSEvseGiM+lt3hVOzbVN2gaKU4CfAYEvT+plrto=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=efpZk5bNUcAErMqRaF01yRhcAUNUt/ZbfPgFgurk2BzdgbAS+1hA3yupq3Yz5u2rX
	 YnB2QaJl+dSUv3JXqlaADf6N31MXVQKszZ3Zwdbqs4Aa3W1f359NT/Eo4cr/R2kCDi
	 whkL+BZWHyGWEudapib0HxA34Vu8vYRN/9NuUbT42S3vJD4LpigyZJ8nqOQZEhLJ+i
	 p+tO8N6hle0XwMkNzxu8k+qcUp9NacuVt0a5OcXZMp0mp0T6y9GlF8HYB07VHQngZT
	 qX7onDUJUK6RZUDK4hyCfO5Gl+lTY4vLUo63V+w5o60dLzI5I4DgPGXI/FiADmJOwt
	 rp24Xlo21+tvw==
Message-ID: <sashiko-outbox-221556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/7] selftests: net: Test XDP with devmem
 bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261117164700.2157816-7-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-7-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:48:28 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests: net: devmem_xdp_check() fails instead of skipping
  without devmem
--

commit af2bb584e6a40d5bea937deb32aab6eee5f5687a
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

selftests: net: Test XDP with devmem bindings

This commit adds a selftest in nl_netdev.py verifying the attachment rules
for native and generic XDP programs alongside devmem RX bindings on
netdevsim.

> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/sel=
ftests/net/nl_netdev.py
> index dd0321c0b463a..15326fb663624 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
[ ... ]
> @@ -483,6 +484,54 @@ def devmem_bind_tx_unregister_check(_nf) -> None:
>      nf_priv.close()
> =20
> =20
> +def devmem_xdp_check(_nf) -> None:
[ ... ]
> +    # A generic program keeps the provider away
> +    ip(f"link set dev {dev} xdpgeneric obj {prog} sec xdp.frags")
> +    with ksft_raises(NlError) as cm:
> +        nf_priv.bind_rx({"ifindex": nsim.ifindex, "fd": dmabuf_fd,
> +                         "queues": [{"id": 1, "type": "rx"}]})
> +    ksft_eq(cm.exception.nl_msg.error, -errno.EEXIST)
> +    ip(f"link set dev {dev} xdpgeneric off")
> +
> +    # A native program first, then the provider
> +    ip(f"link set dev {dev} xdpdrv obj {prog} sec xdp.frags")
> +    _devmem_bind(nf_priv.bind_rx, {
> +        "ifindex": nsim.ifindex,
> +        "fd": dmabuf_fd,
> +        "queues": [{"id": 1, "type": "rx"}],
> +    })

[Severity: Low]
Does devmem_xdp_check() fail instead of skipping when CONFIG_NET_DEVMEM is
disabled?

In netdev_nl_bind_rx_doit(), net_devmem_bind_dmabuf() runs before
net_devmem_bind_dmabuf_to_queue() and returns -EOPNOTSUPP when
CONFIG_NET_DEVMEM is disabled.  Because the first nf_priv.bind_rx() call
does not go through _devmem_bind(), ksft_eq() compares -EOPNOTSUPP against
-EEXIST and sets KSFT_RESULT =3D False before the later _devmem_bind() call
raises KsftSkipEx, causing ksft_run() to report a failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117164700.2157=
816-1-bjorn@kernel.org?part=3D6
