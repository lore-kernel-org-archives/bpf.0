Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AC2F5468
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760737; cv=none; b=uJvcjIKlWzJAx4ck9ytju3OQOjAoHcb6lbtvbk0GOu7cmZ+u+lJ22lTv9N83QbnJM+ShZQ2taW/nDQPrvHLtUzPsWuOSYoDtNkAXCzrYY6Swv1IeaenzduQnLnvYCmuVLERwxde6qOS4XomrxVIUmo/UAaW2gENjosf6kIfcWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760737; c=relaxed/simple;
	bh=Q+PPI1oCJwX5FROdLzIBjo4ZiX2q+xLJMYwdnR9Qcvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ACXod7Midlt8KhI5OjT/+B07vJgaI5C6VkXnEWDUeI04svunmo9c9+p90tacUBJsqe+OmR4Dhf4U/bHkHYBz70Ots8lLhZQEcNuYl/6zvoA1/9hJdxlVXidkw4Xeq52XoGaQreJr/L+wqZAKmpC5mx+2iJFcLwePpEPjifShl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEF+RpMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEF+RpMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D091F00893;
	Sat,  6 Jun 2026 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780760736;
	bh=Pqo3ruBtIbK215ALKQBFN7Somgb6PJjbkHULEsrxzNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEF+RpMHSTpwvZaUWKKPlIwOcjgHTH8KCEn9TZq5IB4Gl6YaM8LCjWt+kgb+EKKwV
	 +kEe4hgYV8HqnhjI8jIOHQq7+dc1hnJ54VbFG4FJrxRadoiKBZkhYWSxf9uaJIt8iV
	 JAvLZmfyVnPrC8jof7dU0Va75+q5w2Yy8LAc/PDjgKthAJO2BbFH6Z0k7AlstvCRKS
	 U0ELf2TxvFYnm8dTLuukRAZ8Ac5vltFckIMajE68HKiWXJhIOYxIsACBQVgo0yGFa2
	 cP59nvVw5DaTFQATpEZ7GJiFn/PtBRcT4SJFPZgShk1zR8l3xCZXdC0I9sja1KMfcj
	 T8iWvl5GCXBqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 4/4] net: mvpp2: build skb from XDP-adjusted data
 on XDP_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605154457.163304-5-mail@tk154.de>
References: <20260605154457.163304-5-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:45:35 +0000
Message-Id: <20260606154536.49D091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] DMA Cache Coherency / Data Corruption on SKB allocation failure
- [Medium] Inconsistent RX statistics accounting based on XDP verdict

Pre-existing issues:
- [High] Invalid Checksum Offload after XDP modifications
--

commit 0263440b3040a39c7d150dacdd56fed200308953
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

This commit updates rx_offset and rx_bytes from XDP data pointers for XDP_P=
ASS
verdicts. This allows the built SKB to reflect packet geometry changes made
by the XDP program before reaching the network stack.

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

[Severity: High]
Could this cause DMA cache coherency issues if SKB allocation fails?

If an XDP program shrinks the packet (for example, by calling
bpf_xdp_adjust_tail()), rx_bytes is reduced. If build_skb() then fails
shortly after this, the buffer is recycled via page_pool_put_page() using
the modified rx_bytes:

mvpp2_rx() {
    ...
    if (!skb) {
        netdev_warn(port->dev, "skb build failed\n");
        if (pp) {
            page_pool_put_page(pp, virt_to_head_page(data),
                               rx_bytes + MVPP2_MH_SIZE,
                               true);
    ...
}

Does this leave the trailing bytes of the original packet buffer unsynced
for the device, potentially causing data corruption for the next packet
received into this recycled page?

> +
>  			metasize =3D xdp.data - xdp.data_meta;
>  		}
> =20
> @@ -4041,7 +4046,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct=
 napi_struct *napi,
>  		ps.rx_packets++;
>  		ps.rx_bytes +=3D rx_bytes;

[Severity: Medium]
Will this result in inconsistent RX byte statistics?

If the XDP program returns a non-PASS verdict like XDP_DROP or XDP_TX, the
loop continues early and adds the original hardware descriptor length to
ps.rx_bytes. For an XDP_PASS verdict, it reaches this point and adds the
potentially smaller XDP-adjusted rx_bytes length.

Could this discrepancy lead to inconsistent interface statistics?

> =20
> -		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
> +		skb_reserve(skb, rx_offset);
>  		skb_put(skb, rx_bytes);
>  		if (metasize)
>  			skb_metadata_set(skb, metasize);
>  		skb->ip_summed =3D mvpp2_rx_csum(port, rx_status);

[Severity: High]
This is a pre-existing issue, but will applying the hardware checksum status
still be safe after XDP modifications?

If the XDP program alters the packet contents or geometry (for example,
decapsulation via bpf_xdp_adjust_head()), the hardware checksum validation
performed on the original wire packet is no longer valid.

Now that XDP geometry changes are allowed to reach the network stack via th=
is
patch, does the driver need to invalidate the hardware checksum status if X=
DP
might have modified the packet? Without doing so, corrupted packets might
bypass software checksum validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605154457.1633=
04-1-mail@tk154.de?part=3D4
