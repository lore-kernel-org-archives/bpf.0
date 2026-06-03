Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98643DA2D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505721; cv=none; b=eyxL/cNjJScMnj79EimVb81uIPHDIVfqvOjb/suAphAswJu1XjdnOJe6Lf/2wUvBCsEPuWXacrfITMY/B96I5eH77TaWxhkVrNY7A//eveYc2hQ1Oq8F/Gro5jg4HjsmjSn/faccuZ9zeXBizK4Kl2NXby6HtLjMO35/JVNjJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505721; c=relaxed/simple;
	bh=UUhtvol+XMuud4WsKl6+fbwS42VQNKw+ukxCT+26+JM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZZYdIwuoUaICwTBxjhR3q374gF4kOltp1NFcPN+cZ+txyiiZUxksCiPy26F1oPRTz4tnJul1S7ynk7FFVlIMsA7RWBINh8NS81Wiw9DT/aiFQpJRN7rfaGGRCzrijIAbyoECld3sYJ8Da8ilLKjhIhlD928WTuvtX20kWqY1FvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjBXvLKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjBXvLKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F9D1F00893;
	Wed,  3 Jun 2026 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780505720;
	bh=cSa7Kuf1bxFYXNZ4A0prQ62LlZkTJW+Y+pv2BHrnvkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TjBXvLKLCFmQV/wiyO1fUf3WAbMMFV4/RL81Uuan/bZUgOOQSKKBb+G3QbD/noWGH
	 2WtqkTUSDUH297oB63ce5ZKwyGzlN2rWmqwfXXzeVuQEYBnCLXlSLIrTpuIUi+7EyE
	 3ud2zOzTlqt/UgJFDSkaGZ7y/vimt/tjGn3SIijx4VBU+Z2VUmgorQU9ugTDQ8ybhG
	 dNLgkOM+DqSq0OLvV9g+Xz4iBENlGLZw9OtCwVE3gy5D7tNuRyTC4o27xNAUxnLypi
	 0bLD65mpsR4IDlasxHigB3h/7R2acK4T0ZD8qb9lChsTZi/Fd9QrJykgvFkcx5qkrY
	 9YvpOxmtydChQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 4/4] net: mvpp2: build skb from XDP-adjusted data
 on XDP_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602164635.62517-5-mail@tk154.de>
References: <20260602164635.62517-5-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:55:20 +0000
Message-Id: <20260603165520.77F9D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware checksum status is incorrectly applied to XDP-modified pa=
ckets, bypassing network stack validation.
--

commit f1fdb866a6579f01cab52a8f590b1009e5b86b4d
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

This commit updates the skb creation logic in the mvpp2 driver to account
for packet geometry changes made by XDP programs. It updates rx_offset and
rx_bytes from xdp.data and xdp.data_end for XDP_PASS packets.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 397aa5ca4992c..844f433975edc 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c

[ ... ]

> @@ -4042,7 +4047,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct=
 napi_struct *napi,
>  		ps.rx_packets++;
>  		ps.rx_bytes +=3D rx_bytes;
> =20
> -		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
> +		skb_reserve(skb, rx_offset);
>  		skb_put(skb, rx_bytes);
>  		if (metasize)
>  			skb_metadata_set(skb, metasize);
>  		skb->ip_summed =3D mvpp2_rx_csum(port, rx_status);

[Severity: High]
If an XDP program modifies the packet (for example, by popping an
encapsulation header using bpf_xdp_adjust_head), is it safe to apply the
hardware's original checksum status to the modified skb here in mvpp2_rx?

The hardware validation of the outer L4 checksum might incorrectly be appli=
ed
to the inner packet, causing the network stack to inappropriately trust
CHECKSUM_UNNECESSARY. Should the driver clear the checksum status (for
example, setting it to CHECKSUM_NONE) if the XDP program modified the packe=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602164635.6251=
7-1-mail@tk154.de?part=3D4
