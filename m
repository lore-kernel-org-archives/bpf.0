Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7864562A0
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543357; cv=none; b=dvXEGsL6qnZG9jvp/NU64MdgTCSp3KdVZV/t1ZZref3lavGAi3s1rrrZTlmpV3i+d1mLH3muaI5bL0lGBfF3XqWdekvG5hRftrWj9gSvAC49SGARcuX8a39s4zzz1EGlVq9UfeJgrHKIm+gKRPEkrFFp73c+tsDfXy5aSpeKrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543357; c=relaxed/simple;
	bh=gmW+FdlATL7G2EV0IG03ZxPxAIPqv84xzpEE4AAPqe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gq6s576IHoM6w13UMYxNWl/uHOOh4pM3Wke3jKbx4HoycEc2dewPCzR+nVb6H0ZjRVtfOzYWHSIbVxDLSItupAFryGlXmgEvrZvsc89u8GclHUpTUK3ab4xDp8i5IARzX+EldTN0QFnNkoezqdH1uuQJ7ukoUJxOyl5pPvwoo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBwIbgPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBwIbgPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC2B1F000E9;
	Wed, 12 Aug 2026 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543355;
	bh=3fEeFn2xUwuogNEZXtdK6zQUHPX5/TgCLCJPYhWu8pc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBwIbgPwfnAAoxUsuimunFdhH6EwO39ZmfxkXhKhYNvrYl8D4ddF2hf7uDDmVEhQu
	 OecCsuCdfOuUY88cfH47vKLaPzoZEPTS7Y7WY29K09gB8DbaoBlfawKRQr+VBmYt0e
	 Od8QqgZ1ux/tWXPPHzkGQx+ppEPe4CcZw96VasfGh2hlYKeIxJYPplqsC1KM5+FD9N
	 a57W+S+erTlld5JIvsWlnlSO4v82kYyI+p4HJtB9Ou2IYZRgk/TpSWs49HE7jz/kUZ
	 NUeUVXPY240DmGQTWUCzDxSOxQomtQDOzZA8cwVrHlT34uVK8JCbH2PzehOpWaXQyK
	 sjayw41Qq3c0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] netdevsim: update rxq->napi pointer during queue reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Subasri S" <subasris1210@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812-net-netdevsim-v1-1-521a85e4fe91@gmail.com>
References: <20260812-net-netdevsim-v1-1-521a85e4fe91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:02:35 +0000
Message-Id: <20260812140235.8AC2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch clears `rxq->napi` in `nsim_queue_stop()` but fails to=
 restore it in `nsim_queue_start()` when `rq_reset_mode =3D=3D 1`, breaking=
 NAPI-dependent features.
--

--- Patch [1]: [PATCH] netdevsim: update rxq->napi pointer during queue res=
et ---
commit a7e8e5d48bb567359bb7891a0b39d7f888c35d27
Author: Subasri S <subasris1210@gmail.com>

netdevsim: update rxq->napi pointer during queue reset

This commit addresses a use-after-free issue by properly clearing and setti=
ng
the rxq->napi pointer during a queue reset. It modifies nsim_queue_stop() to
clear the pointer and nsim_queue_start() to set it to the new napi instance.

Closes: https://syzkaller.appspot.com/bug?extid=3Dc06674caba265dc61d46

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 4e9d7e10b527e..c18f9f540084a 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c

[ ... ]

> @@ -826,6 +826,8 @@ nsim_queue_start(struct net_device *dev, struct netde=
v_queue_config *qcfg,
>  	}
> =20
>  	ns->rq[idx] =3D qmem->rq;
> +	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX,
> +			     &ns->rq[idx]->napi);

[Severity: Medium]
Will this leave rxq->napi as NULL when ns->rq_reset_mode =3D=3D 1?

Since nsim_queue_stop() now unconditionally sets the pointer to NULL:

drivers/net/netdevsim/netdev.c:nsim_queue_stop() {
	...
	netif_queue_set_napi(dev, idx, NETDEV_QUEUE_TYPE_RX, NULL);
	...
}

Earlier in this function (nsim_queue_start), there is an early return
for rq_reset_mode =3D=3D 1 that bypasses the new restoration code:

drivers/net/netdevsim/netdev.c:nsim_queue_start() {
	...
	if (ns->rq_reset_mode =3D=3D 1) {
		ns->rq[idx]->page_pool =3D qmem->pp;
		napi_enable_locked(&ns->rq[idx]->napi);
		return 0;
	}
	...
}

Does this skip restoring rxq->napi, leaving it NULL and preventing XSK busy
polling from working after a reset in mode 1?

>  	napi_enable_locked(&ns->rq[idx]->napi);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-net-netdev=
sim-v1-1-521a85e4fe91@gmail.com?part=3D1
