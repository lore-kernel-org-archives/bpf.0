Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE02FD69A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672240; cv=none; b=RPf15iwj/GxN9t7tCR6eUDqh3iuG9Ohua9F+Bzd5klf1JV8bow7rQb0iHmYB8PjnY9E4M2b2d8EXUp6ijT/4NOxfLGUdmTpN2zlEqw5xugY/4dxUpMy2TYVnltA8uHIGlBNLNlYafCZzF9O358AW1GpoPEC/bWIF6IFEDupcqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672240; c=relaxed/simple;
	bh=R/9hpiXLjIX/GMQyhmngJBSvnVy5C1hgVDX6/HfbSpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KIjhWsHRVOtTcWn0lMgl9uyUanQrJQudSNsghjJjzOwDaASQyj1PK6huzlVfR5nJ+TviiEs96xERFm6YLUseDTG7hnkZq8DIV5FjXak6uPqvCkA5JMvY1avzpPd5q+fbkz9TJ7A7VA8uBKQ3dZrt1ljiX+mN0el7Z16sz+FqN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn4PP7Mb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn4PP7Mb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26161F000E9;
	Tue, 25 Aug 2026 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787672239;
	bh=3QtoWpMvq1/afr+gPpFJQQsxAoE07y3cQWCbykgXkNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kn4PP7MbxK3jKYxKEAK/0DLWF1Cjdl3xwrZ6BOGI262JkOxnaIVFLA2BKT8CUkNlG
	 rmHMe4c6CF8srwEkQEjavZEqHIzO8YyaYfi36+i4qpd2J/KxJPARBWjtynYPoktxtf
	 3FRnIYGgJK8uHPj/Pti0iidd4UWxkl40bZSDEECoAPjqeBMH268P8gxIe6zTKzMDI1
	 cRRt8Xt34M7paoTB4jk0b6b3nVdbJb63OGMymsrljAHw3gDxgIt0MT4pLrI7dAcn1F
	 qnNoZ4esWLYq5pCFH8qsQB9R1R6zWKY0iNZz5G3O7IPVunv36CTLC+CdU1wUaDQsy1
	 Qft8JR8Da9pnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] xsk: Fix circular locking dependency in
 xsk_bind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
References: <20260825152152.86092-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 15:37:18 +0000
Message-Id: <20260825153718.E26161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a direct ABBA lock inversion between `xs->mut=
ex` and `netdev_lock_ops(dev)` while failing to fix the original lockdep cy=
cle.
--

--- Patch [1]: [PATCH bpf-next] xsk: Fix circular locking dependency in xsk=
_bind ---
commit d56fb43288cd7168ec871fc7dae61dd873e064c7
Author: Khawar Ahemad <ahemadkhawar123@gmail.com>

    xsk: Fix circular locking dependency in xsk_bind

This commit attempts to fix a lockdep splat in xsk_bind() by acquiring
netdev_lock_ops(dev) before xs->mutex. It aims to align with the global lock
hierarchy.

Link: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b64..d2fbbeb7b6d77 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1612,19 +1612,18 @@ static int xsk_bind(struct socket *sock, struct s=
ockaddr_unsized *addr, int addr
>  		return -EINVAL;
> =20
>  	rtnl_lock();
> -	mutex_lock(&xs->mutex);
> -	if (xs->state !=3D XSK_READY) {
> -		err =3D -EBUSY;
> -		goto out_release;
> -	}
> -
>  	dev =3D dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
>  	if (!dev) {
>  		err =3D -ENODEV;
> -		goto out_release;
> +		goto out_rtnl_unlock;
>  	}
> =20
>  	netdev_lock_ops(dev);
> +	mutex_lock(&xs->mutex);

[Severity: High]
Does this change introduce a direct ABBA lock inversion between xs->mutex a=
nd
netdev_lock_ops(dev)?

While xsk_bind() now acquires netdev_lock_ops(dev) before xs->mutex,
xsk_notifier() still acquires xs->mutex before calling xp_clear_dev():

net/xdp/xsk.c:xsk_notifier() {
    ...
    mutex_lock(&xs->mutex);
    if (xs->dev =3D=3D dev) {
        ...
        xp_clear_dev(xs->pool);
    }
    mutex_unlock(&xs->mutex);
    ...
}

And xp_clear_dev() unconditionally acquires netdev_lock_ops(netdev):

net/xdp/xsk_buff_pool.c:xp_clear_dev() {
    ...
    netdev_lock_ops(netdev);
    xp_disable_drv_zc(pool);
    xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
    ...
}

Could this lead to a deadlock when xsk_bind() races with xsk_notifier()?

Since xsk_notifier() still acquires xs->mutex before netdev_lock_ops(), does
this mean the original lockdep cycle reported in the commit message is not
actually broken?

> +	if (xs->state !=3D XSK_READY) {
> +		err =3D -EBUSY;
> +		goto out_unlock;
> +	}
> =20
>  	if (!xs->rx && !xs->tx) {
>  		err =3D -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825152152.8609=
2-1-ahemadkhawar123@gmail.com?part=3D1
