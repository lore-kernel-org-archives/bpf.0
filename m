Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF242586F
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710516; cv=none; b=cqjFxMyJWkh/xgkbuFnMYMMNW84hOvq16jgH72W5ia3jXzliX0tBeVq3mfz4E7kQRfPzQ0WuAz89/1NsrrIIImfYXETV5YtLkGKt6cUaG6Z0gOcoso/NhEYib5J14Hs3Axx63/DidJrlr3hOr1oAAoli5+lQp2gF+1H3K2zy2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710516; c=relaxed/simple;
	bh=KfJ3/sXNS3O35xbyVXE0ZNVgCkNqsOBLqZi6o9FNwWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UYgXCZgj0HYfVcxYGVHIqT/sITrKOkb79PhK466r7jtxCwIRRVoxWad80e3hlQ6LQg9O9UQ93ZVR1c4+cBfYqA0TbL8GLX4XRYwUUChpXcwCa+E7jvsGHmIz02f/WyQsfdO4i/I+SrzH4QWFqLNo6tbe2Qesl2cns6Hw8r0n9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghY4uUcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghY4uUcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D38A1F000FF;
	Tue, 29 Sep 2026 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710515;
	bh=S66WoFEVaahfXoJFaTY3Kf8veMYAbNKlxhSb3/7JMIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ghY4uUcgiWvK0Ib8ZNHz7QE0qJb+xwBQykBb9rwg/ZrNBLstoE7kL++7RB+1YwdJJ
	 RYS4FTSRime5XDTBgQvReCaQn7FEoIJmKqLQnyh8cvnk8p9H2F6cEkuTfiCkvrvIZL
	 MrILIleqT4y0fv5sy1CKnKmw92HAZnsC6GKHiNRl11q4dkrTDBTDUuUVnqVaExjGJU
	 FMslz54ZcWM5jCgguJ2ZUbcr8qr8lTDS3KpG26vZS8cFwH+Bx1p0LaQpyV+M1BIG3b
	 rK+cqW6JHzkaJDWhv61PUYqvMuIJwPOR5DWghWRpECT44VSejBPBRRzRz7zCEISXp5
	 9jDtM8s5vCQlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 12/15] net: lan966x: add PCIe FDMA MTU
 change support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-lan966x-pci-fdma-v9-12-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
 <20260928-lan966x-pci-fdma-v9-12-a17caf60f89a@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:35:14 +0000
Message-Id: <20260929193515.0D38A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: lan966x: race condition between fdma_pci_init and mtu resize
--

commit 729515bac2cb6bfa764aa18fa01ab2ab548fd6be
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA MTU change support

This commit adds mtu change support for the PCIe FDMA path. On an mtu
change, the rx and tx buffers are reallocated to the new size. It also caps
the PCIe DCB ring size and defers resizing until initialization has built
the rings.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index f511e70613141..758554c951c52 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> @@ -428,9 +428,156 @@ static int lan966x_fdma_pci_init(struct lan966x *la=
n966x)

[ ... ]

> +static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
> +{
> +	int max_mtu;
> +
> +	/* Nothing to resize until fdma_pci_init() has built the rings; it
> +	 * sizes them from DEV_MAC_MAXLEN_CFG, which the caller already set.
> +	 */
> +	if (!lan966x->rx.lan966x)
> +		return 0;

[Severity: High]
Does this initialization guard safely prevent concurrent execution with
the driver probe?

In lan966x_fdma_pci_init(), the rx.lan966x pointer is assigned before the
actual memory allocations are completed:

lan966x_fdma_pci_init() {
        ...
        lan966x->rx.lan966x =3D lan966x;
        ...
        err =3D lan966x_fdma_pci_rx_alloc(&lan966x->rx);
        ...
}

Since the network device is registered and accessible before the probe
thread finishes calling lan966x_fdma_pci_init(), could a concurrent mtu
change via netlink pass the guard here while the rings are only partially
initialized?

If this race occurs, the reload operation might attempt to free
uninitialized or null memory via dma_free_coherent(), leading to potential
memory leaks, data races on dma structures, or a kernel panic.

> +
> +	max_mtu =3D lan966x_fdma_get_max_frame(lan966x);
> +	if (max_mtu =3D=3D lan966x->rx.max_mtu)
> +		return 0;
> +
> +	return __lan966x_fdma_pci_reload(lan966x, max_mtu);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-lan966x-pc=
i-fdma-v9-0-a17caf60f89a@microchip.com?part=3D12
