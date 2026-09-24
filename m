Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAD3368B8
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214276; cv=none; b=Sa4HdluJuZv+VSPz+h9qCk8FLV8xxy5J4DGFuU5NpFBXHnoborNNHuQb/7k06NCpRZMuDE8oGoHB49/OpvKDZVm7ojaJP/QFQiroGaC952l6QRnDaFpl6oFGE+N396EqWY8AjmSqmnX6hqwdNyEUupPN8fuN+3fGuBvGg7h4DyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214276; c=relaxed/simple;
	bh=ePoHxCvv/jpbmZmGA5MbFueK0rpKzFGZ9nt66g5nNg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GqM8xdeZI8WH5Rz2i7l2E7IRZQNGrHIL4b2ND5X3PwgLmO35wkel8clF/tU8B+xWAza9TcMubd9OERhSSlDfzAV1m324gbZxRdU7Mm0UPlZHI1oA7DOB8mqdUhAPbU56DcluQTRSlhp6ZawMY47C4dEzJBYp2TFerEKX0sb4FT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxdHTYKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxdHTYKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2781F00898;
	Thu, 24 Sep 2026 01:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214274;
	bh=258K8cjTRdPFYByc4zlrnqKZzYEpV55R1DqlHTfVwvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gxdHTYKjBoG92aqzzWCWVfuESwTRU8MCKjUH1fR+kja6h+DEOe3wBBtWrhDIB2yW0
	 GziS1aacvWz+ABw35k2snE3DcMgkQyjeRD7s+x8p4sPGJwgcDVvpZ5mMDD291CRhPW
	 PrM7GD6gWe7rYVdxnbdvqwTCUBD7yukkVRi9yBPtcufAmvdo+meGuX81HHvGQBNd9F
	 QIv55LmQXt1WpcnShxABXceoSJqMeio6pyeNP5VKhYQgPWzhyY+Q8yG/HsCvUvLx+v
	 Zj822f4+Y2+1CoKGjrd3uPGXYawyzer4E0sflsmUkGno0S57bWtVmBajj/UFWHCPCk
	 7Qk+HK0+4NW2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/8] eth: mpnic: add register init for the
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-linux-mpnic-v1-2-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
 <20260922-linux-mpnic-v1-2-236844f53072@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:44:34 +0000
Message-Id: <20260924014434.9A2781F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: missing pci_resource_len() check in mpnic_probe() allows OOB =
MMIO access
--

commit 647e9ec73143ec855da6fd69e03902213d836df8
Author: Mohsin Bashir <mohsin.bashr@gmail.com>

eth: mpnic: add register init for the device

This commit adds one-time register initialization for the mpnic device duri=
ng
the probe process. It covers static configurations and pulses for zeroizing
on-chip SRAMs.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_init.c
> new file mode 100644
> index 0000000000000..f8ebb19766731
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c

[ ... ]

> +static void mpnic_ro_init(struct mpnic_dev *mpd)
> +{
> +	u64 attr =3D mpd->relaxed_ord ? MPNIC_OB_ATTR_RO : 0;
> +
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_TDE_H, attr);
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_TDE_P, attr);
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_TDF, attr);
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_RBP_HPQ, attr);
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_RBP_PPQ, attr);
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_RDE_H, attr);
> +	mpnic_wr64(mpd, MPNIC_OB_ATTR_RDE_P, attr);

[Severity: High]
Can this write out of bounds of the mapped MMIO region if the PCI BAR is
unexpectedly small?

This function accesses MPNIC_OB_ATTR_RDE_P, which is at offset 0x2680068.
This requires the mapped region to be at least ~40MB.

Earlier in the initialization path, mpnic_probe() maps the PCI BAR via
pcim_iomap_region() without verifying if pci_resource_len() covers these
expected MMIO registers.

If a malicious or spoofed PCI device (e.g., connected via Thunderbolt)
advertises an artificially small BAR, the driver will map this short length
but unconditionally write to offsets far beyond the mapped boundary here.
This could cause an immediate page fault and system crash upon device
connection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-linux-mpni=
c-v1-0-236844f53072@gmail.com?part=3D2
