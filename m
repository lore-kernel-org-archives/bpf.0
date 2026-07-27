Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989F3B47C9
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167046; cv=none; b=bFtSNHYZNIZucGWMreAL6CKxGig7BBk2uC9e2/hwxdadYr5aqA8yRdZ8yJKEGSjPUrMNjSK86GF1iHtlvAlFlJ7F246aIV21kfjoSBsAPyt0jJgiOzhNORAn7vWi2UHBHtnoUnLEEGeQDLpZbGWQhkvGW/Y32WKnOcQZGs7XRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167046; c=relaxed/simple;
	bh=MXhiS1cRQj6VlxHhmQ7h34ZrjktvKausBNjIwrrG2Oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QM2ulz7Rzp7rAPYKFVnOCra5CmQCiWmtfWNXJCCodswDLsKT9ewwvpwnzBPg73W2IC1Rt2F3MoBbC0CdTDiCEE0efoDkJpX+dNFdirMgklZ33BIMBQuG+ojSVHc3zoQIvh+HtgWztbWbcJe6QehXq74+29K6lEJM7eJTOv47h/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7T5zU+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7T5zU+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C81F000E9;
	Mon, 27 Jul 2026 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167044;
	bh=UKjOEHsuqbwwyjPdmuOiC4dW8Epku25GJuu+0t0dzEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H7T5zU+Bvtouq4NGILym2r+DXPTDf7NQ/QBrELJJD45/MToqf++t/AM1m4gYnwix4
	 5lE+Y4RJpKtXv16NtltueVdiUQOYOmLhXHkg4U3QClQahxMT0L3XHHa/I9+SFpm5hM
	 wqUwCkOuv/Xh+5vseqANddG0SZAVEoX+/aSYOmYeb8KADUGaDlDuO2oNAgSH0uujvk
	 CJCFcVm2/mBF2alJkrAHas0NVLmNoEJ31NJYgn25WyfMzHsIn3ZujhggJkMOTvGDQ8
	 VRqWr2kH3+dvQ3WQRuNdaf4ckY9V7/dLiTJmHtGmxpRQixy4OL3KRIfMVSF3XLdx9M
	 nPCkmGoX/ZBFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/15] media: rc: Fix use after free in bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Young" <sean@mess.org>
Cc: media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <dfacc746477c6b05da4a0b1479c93d33bc310c3b.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
 <dfacc746477c6b05da4a0b1479c93d33bc310c3b.1785158244.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:44:03 +0000
Message-Id: <20260727154404.558C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing the `!raw` check with `!rcdev->registered` introduces a =
reproducible NULL pointer dereference in `lirc_bpf_attach`, `lirc_bpf_detac=
h`, and `lirc_prog_query` during the `rc_register_device` error path.
--

--- Patch [12]: [PATCH v4 12/15] media: rc: Fix use after free in bpf progs=
 ---
commit 73b698ccc4730e811a156a8f7b37bb4afb95af66
Author: Sean Young <sean@mess.org>

media: rc: Fix use after free in bpf progs

This commit replaces the NULL check on rcdev->raw with a check on
rcdev->registered to address a potential use-after-free issue when
unregistering devices. It also moves lirc_bpf_free() inside the
ir_raw_handler_lock.

> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> index 2f7564f26445c..14ab611e74457 100644
> --- a/drivers/media/rc/bpf-lirc.c
> +++ b/drivers/media/rc/bpf-lirc.c
> @@ -148,12 +148,13 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, st=
ruct bpf_prog *prog)
>  	if (ret)
>  		return ret;
> =20
> -	raw =3D rcdev->raw;
> -	if (!raw) {
> +	if (!rcdev->registered) {
>  		ret =3D -ENODEV;
>  		goto unlock;
>  	}
> =20
> +	raw =3D rcdev->raw;
> +
>  	old_array =3D lirc_rcu_dereference(raw->progs);

[Severity: High]
Can replacing this !raw check with !rcdev->registered cause a NULL pointer
dereference?

In rc_register_device(), dev->registered is set to true. If lirc_register()
succeeds, the character device is created and can be opened by userspace. I=
f a
subsequent initialization step fails (e.g., ir_raw_event_register()), the e=
rror
path calls ir_raw_event_free(), which frees dev->raw and sets it to NULL.
However, the error path never sets dev->registered to false.

If a userspace process opens the device and races to call the bpf() syscall
during this failure, will !rcdev->registered incorrectly evaluate to false,
leading to a dereference of raw->progs when raw is NULL?

[ ... ]

> @@ -186,12 +187,13 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, st=
ruct bpf_prog *prog)
>  	if (ret)
>  		return ret;
> =20
> -	raw =3D rcdev->raw;
> -	if (!raw) {
> +	if (!rcdev->registered) {
>  		ret =3D -ENODEV;
>  		goto unlock;
>  	}
> =20
> +	raw =3D rcdev->raw;
> +
>  	old_array =3D lirc_rcu_dereference(raw->progs);

[Severity: High]
Does this face the same NULL pointer dereference issue during the=20
rc_register_device() error path as lirc_bpf_attach()?

[ ... ]

> @@ -316,6 +319,11 @@ int lirc_prog_query(const union bpf_attr *attr, unio=
n bpf_attr __user *uattr)
>  	if (ret)
>  		goto put;
> =20
> +	if (!rcdev->registered) {
> +		ret =3D -ENODEV;
> +		goto unlock;
> +	}
> +
>  	progs =3D lirc_rcu_dereference(rcdev->raw->progs);

[Severity: High]
Could lirc_prog_query() also crash here if rcdev->raw is NULL but
rcdev->registered remains true during a registration failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785158244.gi=
t.sean@mess.org?part=3D12
