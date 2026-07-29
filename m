Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D823C1D68
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340339; cv=none; b=lvZza/DQkTRNr0vmYY53pAr/yAwm8HMpmfXeEAAgJ684s5+q8rtpNZ8czBU7G1CsOpIEBk3i73tVi4GMsJM5PV1/cbHe2I+beJAhBx3pjF6filq6kkBjukFLdJlEXHdGi8qkrRe0tOgYurTtCBdWGA5S3b1ihV+kD+F5Z00e38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340339; c=relaxed/simple;
	bh=SXYX/A4MBRIGr4i17pLG0siLW+SDUdtybpwdFE1XW9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ApPQqDVlMK7h9CbLXEllyPOq7yp6OjP/XG91cuDtdhbBnjd//sP8PfTGQdkNZO1sSf6aysogHkVefXmmmByu0IbGO5huFR93Kg2IMArtFHWdZR5Wne/38zH+KVANC8Ygfoq8hwj5cTgZBieDyLDQSCw6LJDp/VsZ/nO3koHBj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwwA+wI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwwA+wI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A229E1F000E9;
	Wed, 29 Jul 2026 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340337;
	bh=5PyHTszMTJinUUKp5RH9KHUsK1cjbP3FJCC3vPEQR0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CwwA+wI13G08GA8dMtm/1H2tgCaCHkGqs9oXGfQpj/Om3GFbivhl0UbHglNYHqIti
	 MnwkOd0z4PCDp1z2sV9LQwGGs8g1R+IgnQ4a4sa7A2GIKRGxlHcyGVClMnEIz9bDJq
	 yb3+4C73LysXwHa97Jfsb8xaGqazZCYphhmow9bNBf7wUU4MygWB8hPvahVLZjWDnA
	 DVMNpCwbgivqtIDvv8I+XYImMVMbkZl5GzCXewKLnj8e6jfKWbJ5nChkBvSgSkcfA9
	 1HVksdpSM4MxFPzSMK5rTpSuClPNiEZpSg5suQbE1ai4osWk3WrOsC5H2oLDOKtNA2
	 XgtAojjOALOrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/15] media: rc: Fix use after free in bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Young" <sean@mess.org>
Cc: media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <4e85ac724e45244099b242747684529016c5ed83.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
 <4e85ac724e45244099b242747684529016c5ed83.1785338381.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:52:17 +0000
Message-Id: <20260729155217.A229E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `rc_register_device()` fails after making the LIRC cdev availab=
le, `dev->registered` is left as `true`. This allows a concurrent user hold=
ing an open file descriptor to bypass the registration check and trigger dr=
iver callbacks on freed private data.
--

--- Patch [15]: [PATCH v5 15/15] media: rc: Fix use after free in bpf progs=
 ---
commit 56728bdc06bc2bfe04a9a68caffbbf3e5379fc20
Author: Sean Young <sean@mess.org>

media: rc: Fix use after free in bpf progs

This commit fixes a potential use-after-free in BPF programs by checking
rcdev->registered instead of rcdev->raw during BPF attach, detach, and
query operations. It also updates the raw event handler cleanup logic
during device unregistration.

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

[Severity: High]
This is a pre-existing issue, but does relying on rcdev->registered complet=
ely
prevent use-after-free scenarios if the device registration fails?

Looking at rc_register_device() in drivers/media/rc/rc-main.c, if an error
occurs after making the LIRC cdev available, dev->registered is left as true
in the error unwind path:

drivers/media/rc/rc-main.c:rc_register_device() {
        ...
        dev->registered =3D true;
        ...
        if (error)
                goto out_rx;
        ...
out_rx:
        rc_free_rx_device(dev);
out_lirc:
        if (dev->allowed_protocols !=3D RC_PROTO_BIT_CEC)
                lirc_unregister(dev);
        ...
}

If a user-space process opens the newly registered /dev/lircX device before
rc_register_device() completes and fails, could it bypass this new check si=
nce
dev->registered remains true?

Similarly, could this cause issues in lirc_transmit() (in
drivers/media/rc/lirc_dev.c) where it also checks if (!dev->registered),
potentially allowing a freed driver's tx_ir callback to be invoked?

>  		ret =3D -ENODEV;
>  		goto unlock;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785338381.gi=
t.sean@mess.org?part=3D15
