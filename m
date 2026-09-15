Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49A359A70
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460693; cv=none; b=iS0NMaxvmehHkOoiUUqjT4rYiqwOWNmRV6GXNyk+79v8/QZaOVegiXTwrESehWLtTjnrAVWGeRklhdkFA6/ewdJDRgtn1JTMqG+AwV+QasL+qUu5r/eYJh96iqFztH3ukzSQkmHuBLtlDe0L1EFFn/Xj/ROJhB18dA4MA4ZO13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460693; c=relaxed/simple;
	bh=+CKfqHcOLMvL7tIXrRDgssbO0MfguS/1n4uWo0zpNYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sbFwY14JFj85/772Ikx95B+kBJ1EI++wm4r9pJY2L9HjFZbEDr43il9bAnCROOS202rBiS+KUNRSAgHG9RQ7CQ6ZFI7ShHnwmjjFZEvfkkolqnaCqV0qewd6+3GGWvH5smBJ83oP7o/3E48FBObE95LeUTV/Eqaca16nLZ9AzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBwiM6ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBwiM6ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456E61F000FF;
	Tue, 15 Sep 2026 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460691;
	bh=p8pdSBg/MFKZPWyGxE6Yk7ybXJXco2Bb+iH6aqSzU64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBwiM6ijS5aAQx1Xtja63JXsaymwLtepnBrBDIxPZqM6tJgLaBVt6eZJGXTZoMa9O
	 OQRnRDQIvhtWgTO08CSmFWGEOucJEpAwdCisY4dsAVTj30AO4mIDpYdxofmdpcUEsp
	 VYhH/9HWyM4jtbVcBW2g5N0cpBLVijE6UhzCpQt7Bs6ixEuF09Bev+nRP5rELQZMAJ
	 8Ga/G0TlEzgwtoW7EPdPtN2KjEfkgLZ2DoN2XfijP2GKGph6LdqPGRNYXI4uAA//dH
	 TbvjhMNdpB07fatcg4yPwSo2R1zgQqItKzpv0UP6FkPUFWzLWGm7RCPIZ1tNjtlDCI
	 aHirgnSBENF1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6] xsk: Fix circular locking dependency
 between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915081023.7433-1-ahemadkhawar123@gmail.com>
References: <20260915081023.7433-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:24:50 +0000
Message-Id: <20260915082451.456E61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] xsk: direct AB-BA lock inversion between netdev_lock_ops and xs->m=
utex
--

commit fb0725dd07b52433e13678029edcd12b678195df
Author: Khawar Ahemad <ahemadkhawar123@gmail.com>

xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, an=
d netdev_lock_ops

This commit attempts to break a 4-lock circular dependency at its root in
xsk_bind(). It reorders the acquisition of netdev_lock_ops() and xs->mutex
with the goal of fully removing the xs->mutex -> netdev_lock_ops edge.

Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..b7072092cc51f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1636,20 +1636,22 @@ static int xsk_bind(struct socket *sock, struct s=
ockaddr_unsized *addr, int addr
>  		return -EINVAL;
> =20
>  	rtnl_lock();
> +
> +	dev =3D dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
> +	if (dev)
> +		netdev_lock_ops(dev);
> +
>  	mutex_lock(&xs->mutex);

[Severity: High]
Does this introduce a direct AB-BA lock inversion between netdev_lock_ops
and xs->mutex?

By moving the netdev_lock_ops() acquisition before mutex_lock(&xs->mutex)
in xsk_bind(), we establish a netdev_lock_ops -> xs->mutex dependency.

However, there is an existing, unmodified path in xsk_notifier() that takes
xs->mutex and then calls xp_clear_dev():

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

And xp_clear_dev() unconditionally acquires netdev_lock_ops():

net/xdp/xsk_buff_pool.c:xp_clear_dev() {
    ...
    netdev_lock_ops(netdev);
    xp_disable_drv_zc(pool);
    xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
    pool->netdev =3D NULL;
    netdev_unlock_ops(netdev);
}

This retains an xs->mutex -> netdev_lock_ops dependency during device
unregistration.

While both paths hold rtnl_lock() (preventing an actual runtime deadlock),
Lockdep tracks lock dependencies globally by class and will flag this as a
circular locking dependency. On systems with panic_on_warn enabled, this
can be triggered by an unprivileged user with CAP_NET_RAW by binding an
XDP socket and unregistering a network device.

Is there another way to resolve the original 4-lock cycle without inverting
the lock order here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915081023.7433=
-1-ahemadkhawar123@gmail.com?part=3D1
