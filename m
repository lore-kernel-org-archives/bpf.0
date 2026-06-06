Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8D3A5448
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748108; cv=none; b=MN0pLIZepnb1n+F0ulCs31TX9GYVYjrNpqbDYqTeBYvNgH9QAehsMh+6kxdzMlAsgZgKnAsDGFX8ONcjFeCo1cR0QUhzpdjse/B0iKgoRE69cduQtc7VfG1ccSTgRyY28GPmN9hmlUHmkeHaSrhoa7bZzwv/4Xh9oJanqxLsg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748108; c=relaxed/simple;
	bh=so00rcBcwHl3rRPJxM9d6Juju0S/t+cdfACOsD5V6Gs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQCuGaMwD3PSX+k0g8+fcyyD+rk/E0d8xEc/r3GnIgAonK6oMY52YUkktYxMjVSOAj329RVITqtg182LZ2qF7r8XVZ5XCg8gXq/Pd1yqbNfHyiaJjFiG0s7HPC0R3TFsKLsE6lkvWPiki8OI7DmfDqtDX45xqPq6hTMefVlHAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNxyEHf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNxyEHf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDE31F00899;
	Sat,  6 Jun 2026 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748107;
	bh=8qrnrjWqC2I7bRJAqIRZnK4KUkl22Yd5FeALhwL5e8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NNxyEHf+bAW1E1CchrRIOh7bVh+Xm7dNZ6dEyPDzZ04XQ4zQssUwj1HJGgIeuobZc
	 +0nP3+WbVMR/KcFzr2rCVEYbebZ+PoLubsSmxl9pBrwngmcJKu70UKxjruAXRIJPj8
	 Xq8w0hqjVv41iOEz9x3FmV4uwxVLSybhMpMZ0Npo39akZHefUuLn8i5CS2JGLPhSjK
	 2vdAsC/FUMNu1orNZ0zRyL0QliMeBqHgJB/5JOP8rqRfEHGokwKqlcx4PxL68Ddzvp
	 DFaUqqcXOkL0fOmT1pERy2IfSDllx2EA8HoMQGvuGTJROcwBDOhisCXkMqE9h06QOn
	 QXZy5sf9Em4vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/4] net: mvpp2: build skb from XDP-adjusted data
 on XDP_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605121332.147397-5-mail@tk154.de>
References: <20260605121332.147397-5-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:15:06 +0000
Message-Id: <20260606121506.ABDE31F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Overwriting `rx_bytes` with the XDP-modified packet length causes =
a partial DMA sync on the SKB allocation error path, potentially corrupting=
 subsequent packets.

Pre-existing issues:
- [High] Hardware checksum offload is unconditionally applied even after XD=
P program modifications, potentially bypassing network stack checksum valid=
ation for corrupted packets.
--

commit 92e9744c23c0c27c625a826b0e44e159927ea85a
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

When an XDP program modifies packet geometry and returns XDP_PASS, mvpp2
currently discards these adjustments and builds the skb using fixed
offsets. This commit updates the offset and length variables to reflect
the XDP-adjusted data, ensuring the skb correctly represents the modified
packet.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 481daafdc1cbc..dd30674148aa4 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c

[ ... ]

> @@ -3999,6 +4000,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  				continue;
>  			}
> =20
> +			/* Update offset and length to reflect any XDP adjustments. */
> +			rx_offset =3D xdp.data     - data;
> +			rx_bytes  =3D xdp.data_end - xdp.data;
> +

[Severity: High]
If rx_bytes is updated to reflect the XDP-modified packet length here, what
happens if skb allocation fails later in mvpp2_rx()?

Looking at the error path:

mvpp2_rx() {
    ...
    if (!skb) {
        if (pp) {
            page_pool_put_page(pp, virt_to_head_page(data),
                               rx_bytes + MVPP2_MH_SIZE,
                               true);
    ...
}

If the XDP program truncated the packet, rx_bytes is smaller than the
original size synced to the CPU. Does this cause an incomplete DMA sync
back to the device, leaving dirty CPU cache lines in the remainder of the
buffer? Could this corrupt subsequent packets when the hardware reuses the
buffer?

>  			metasize =3D xdp.data - xdp.data_meta;
>  		}
> =20
> @@ -4041,7 +4046,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct=
 napi_struct *napi,
>  		ps.rx_packets++;
>  		ps.rx_bytes +=3D rx_bytes;
> =20
> -		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
> +		skb_reserve(skb, rx_offset);
>  		skb_put(skb, rx_bytes);
>  		if (metasize)
>  			skb_metadata_set(skb, metasize);

[Severity: High]
This isn't a bug introduced by this patch, but does unconditionally
applying the hardware checksum status to the skb here bypass software
validation for packets modified by XDP?

Looking at the code immediately following this block in mvpp2_rx():

    skb->ip_summed =3D mvpp2_rx_csum(port, rx_status);
   =20
Since XDP programs can modify packet headers or payloads, the
hardware-validated checksum might no longer be correct. If the hardware
reports CHECKSUM_UNNECESSARY, could this allow corrupted or improperly
modified packets to be incorrectly accepted by the network stack? Should
the hardware checksum be invalidated (e.g., set to CHECKSUM_NONE) if an
XDP program has been executed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121332.1473=
97-1-mail@tk154.de?part=3D4
