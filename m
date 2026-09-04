Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBF43F08A
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558998; cv=none; b=q4L3OOqbQ+/UUEu3KmDuFmw24SsYOC2yL+7IAt+gUY7nnjDNKPdf/ksKkfINbCTFDOzMKcvqDIMEBhg0wu+v+6vr8DrqnhWDByIi/4W2tUWtm04X0GdRq6+Obn9DKO0nEZ0w8ajyCgotmRCyA6ixP3qUQvLA8xoQpV7UOWqFaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558998; c=relaxed/simple;
	bh=rQvHARr2Lrl4ADy+XsamXOkE7+ntUPta/Q63WKax9lY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HGOwXoDE8TzjfSL5kncw2G69eT3zjeVAJBHCVNB6caCUrhuCKDPn+69cncqW2wS8LOQQ8TEpFmMAp9qDTt6hyadUQ5s+c+fUlzXOppu4OJFOVVAtoTNAqskCit4HtiOFt1XDRsYwLnouXyflpewWLITZjxRWmongV30VzE07e70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYZVxCFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYZVxCFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5331F00ACF;
	Fri,  4 Sep 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558995;
	bh=exKQ4R3Qfwq8UTZvppi1S0GiaB5JyffBG3FPE9ZK99E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nYZVxCFL3zUIXjf1wMK0sTTS9UdExezPM/0uql8z+Hs6iyBrxDCWTnkW0dezX9y6K
	 gP9Ki5BYdpLNtMjBpRIf0tkECZmm+HjztP0k2BLfVWBOf+m70NM7f77VaMEZy4RPhX
	 G4Knga1sSVljWN/uL36vRb8IdvU1VZspOM7NDKcE/shEsvE66sla/0+rrt0DAWcUT0
	 WYeDRkqUfLbYfwojc7npaWVQcleHS1OZdU9vdKoWAZKGOym+9Zl2F2w7jgHpXS4zM0
	 mvqX1/RG4huffZuGo/7V6AAAMqtW1ZeYt1/T2DfGX9998k3HHY78rJS+ogBr48ynYF
	 WKtNbtNdJzB3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 12/12] gve: add link status/speed ctrl ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903215606.31633-13-hramamurthy@google.com>
References: <20260903215606.31633-1-hramamurthy@google.com>
 <20260903215606.31633-13-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 21:56:34 +0000
Message-Id: <20260904215634.EC5331F00ACF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential DMA use-after-free when an admin queue command times out.
--

commit fd1cf5f7dd6ca7a5afb5900e7042fea37b95574b
Author: Joshua Washington <joshwash@google.com>

gve: add link status/speed ctrl ops

This patch refactors the link status check and link speed retrieval
to use new control plane operations. It adds report_link_status and
report_link_speed to gve_ctrl_ops to handle these tasks in AQ mode.

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index dd1c44fedc771..a3220c6514382 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device=
 *netdev,
>  	int err =3D 0;
> =20
>  	if (priv->link_speed =3D=3D 0)
> -		err =3D gve_adminq_report_link_speed(priv);
> +		err =3D priv->ctrl_ops->report_link_speed(priv);

[Severity: High]
This is a pre-existing issue, but is there a potential DMA use-after-free
when an admin queue command times out here?

In the implementation of gve_adminq_report_link_speed(), we allocate a DMA
buffer for the hardware to write into:

drivers/net/ethernet/google/gve/gve_adminq.c:gve_adminq_report_link_speed()=
 {
...
	link_speed_region =3D
		dma_alloc_coherent(&priv->pdev->dev,
				   sizeof(*link_speed_region),
				   &link_speed_region_bus, GFP_KERNEL);
...
	err =3D gve_adminq_execute_cmd(priv, &gvnic_cmd);

	priv->link_speed =3D be64_to_cpu(*link_speed_region);
	dma_free_coherent(&priv->pdev->dev, sizeof(*link_speed_region),
			  link_speed_region, link_speed_region_bus);
	return err;
}

If gve_adminq_execute_cmd() times out because the hardware is slow to
respond, it returns -ENOTRECOVERABLE. However, the driver unconditionally
frees the DMA buffer via dma_free_coherent().=20

If the hardware is not synchronously reset and eventually completes the
command, could it asynchronously write the 8-byte link speed to the freed
DMA address and corrupt memory?=20

Since this path can be reached by an unprivileged user reading
/sys/class/net/ethX/speed, could this cause remote memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903215606.3163=
3-1-hramamurthy@google.com?part=3D12
