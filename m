Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23753B6C1D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391069; cv=none; b=K/np2MxwTpuESVfW02V8J5A9JlhiFrR//TDY/uwv3OibDclcL8kQqC4CvVhPNNuwWMRRWSZrcdDSnfBLjkHnmJU39aoP9pNb80BZwM+5ifcwxI97h1CusRYHHZLvlWoKClMFg17mesYZ7GYFMiGITy3+u420BlWzLzAevmEU9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391069; c=relaxed/simple;
	bh=01pCEbFp+CrhwP1KLJGRR5UFmKYBa4f46fpjaUMk+2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sL3BiHiQRtcTJKi5VXZBGjw2GmyX2uTIKG5rQ3BmOWKAdofEPuZTXatlvjILDdTlPiIfXSJjcG61g8LDrmgxdOsUI0k8SLDiEeirKxPlCsqh1F3hp06UzQn4LfmsMezPc2+u15Vr1n6xrgrlGw5oEyD+7NqKjdy5CYWrBzpfthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/IDdV5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/IDdV5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1CC1F00898;
	Tue,  2 Jun 2026 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780391068;
	bh=+YcC4AxAWc26/iLcpXUoum8u6sWDQU5JK8/HLH8+myI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/IDdV5tveGbOKj5RQ9y7p63vhjm8wHKADBUvKxDU5wmZEWoUbXhPiXCamRf4wbZm
	 E6CLkMXreztTBG21uJBPNCqiYz2ulBYhDdgy27SAlYycsnqF6o8+UNoq2oaW88pVuV
	 pjeyUoloJ0T2Pc3/BoawtAcaMHAMRKHU4sFrGADe067P7TZsRUj+T6eEwmv8oBsrWe
	 c3EZmOV3Dup7QbVBxGYeQo3D8K4S+dTeAJVc2GslwvL3WTLf8UzcZHE2uD8NprzkAT
	 dkH/gqk7ErakYeBs1CLgaL4s8U1PiwKoAWqlEMdkVkm5qkpp2dm8ML1z4OFGCaIAs+
	 /iDiXtleknMLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based broadcasts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <n05ec@lzu.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
References: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 09:04:28 +0000
Message-Id: <20260602090428.8D1CC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Generic XDP devmap broadcast executes eBPF programs on cloned SKBs=
 without unsharing the data buffer, causing silent data corruption across d=
estinations.
--

commit aa9501e9eb38c9d016ad75d6259b7ed07d668fb0
Author: Zhao Zhang <zzhan461@ucr.edu>
Subject: bpf: devmap: reject fragmented frames in clone-based broadcasts

This commit rejects fragmented native and generic XDP frames in clone-based=
=20
broadcasts. By adding checks in the generic and native clone paths, it=20
prevents potential out-of-bounds access.

> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b9..5b9eac5342a90 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c

[ ... ]

> @@ -726,6 +730,9 @@ static int dev_map_redirect_clone(struct bpf_dtab_net=
dev *dst,
>  	struct sk_buff *nskb;
>  	int err;
> =20
> +	if (unlikely(skb_is_nonlinear(skb)))
> +		return -EOPNOTSUPP;
> +
>  	nskb =3D skb_clone(skb, GFP_ATOMIC);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to use skb_clone=
=20
here without unsharing the buffer before executing the eBPF program?

Since nskb is passed to dev_map_generic_redirect, which eventually calls=20
dev_map_bpf_prog_run_skb to execute the destination's eBPF program:

dev_map_bpf_prog_run_skb()
    ...
    act =3D bpf_prog_run_generic_xdp(skb, &xdp, dst->xdp_prog);

Does this grant the XDP program direct write access to the cloned SKB=20
payload? If the data buffer is shared and never unshared, could modificatio=
ns=20
made by the eBPF program for one destination silently corrupt the packet=20
data for the original SKB and all other clones in the broadcast loop?

>  	if (!nskb)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/21c2d153dd25603d359=
069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu?part=3D1
