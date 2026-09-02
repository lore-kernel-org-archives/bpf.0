Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736801B6D08
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323693; cv=none; b=YIqbwkgW0KDeJ/Sa12SiyeXNPUhlDdEi1Jp6PKuwlI3QiaWcyyvHKYC+7EUmBF/149aFcM6Vbu3J2OeSJKcKDmFTNfch1QB8Umn3ZKIO5+o67y22XQW4djjyL4VSkLN8pQ9oQN/agsfDifTqAeg+kNf2WtcL3CwfYab97pvkUvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323693; c=relaxed/simple;
	bh=b8sdVe4lDstGgYqtlSPk97r/wj8Ikj2TFrQPqMzYjKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pMiU6+7md28DbW+vO05gwDoFm+EfAGaY/fwaUgBaDeIfkDBGagORNUIQRdGK2rw3c72M1T9tGeewxISGX+GbWea7i1SdOGM0U01Kurc68UpVmbavqDd5QH3AyQ87D9ounQMpW0omtteHr5xiNQ3JPreWX7gNtK6S3UpUcOo0t3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUiTyF3O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUiTyF3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E3B1F000E9;
	Wed,  2 Sep 2026 04:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788323692;
	bh=tRhhJiK0C9i4fQyLLkt4WmFAKkH/tMOHsbcPrp2DrAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kUiTyF3OD2ecXX7KZ1kofLzMo6rC8DTCORv9dd6SDuGhsUg9mEcS8X8HVuzvoVUMK
	 WxKDVJESzbjd2Opz+vgEwdnMys/QkXZYp5T7FNlvZoHebB1pkyHCoKMN2EbKqPGrkn
	 9uwOqoft5wPweFsKqj/mmkTcjxrdxJOfL7wGXkrs+O6V731til+GCtgQjJ/EaTOTOJ
	 2ghoYzikGSLrRAtiN6ymtBEA59ZO02Ztw57nTYSJW4D+a+sY3rL3+i1eO1UtfxX0NS
	 uzTXwrfw47AdHa8G3Vq/z0uuZ3fRBTXDNheU8MG8fO+DAykdDqDCdwfBWtkZbw2fXP
	 hzuGUp2o0UimA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5] xsk: Fix circular locking dependency
 between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902041257.58374-1-ahemadkhawar123@gmail.com>
References: <20260902041257.58374-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 04:34:51 +0000
Message-Id: <20260902043452.03E3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Use-After-Free on `xs->rx` and `xs->tx` in `xsk_diag_fill()` d=
ue to concurrent queue destruction in `xsk_release()`.
- [High] O(N^2) list traversal complexity in netlink dump callback `xsk_dia=
g_dump()` leading to severe CPU exhaustion.

Pre-existing issues:
- [High] The patch fails to fully break the circular locking dependency bec=
ause `xsk_notifier()` still acquires `&xs->mutex` while holding `&net->xdp.=
lock`.
--

commit a6c998e74f20de71db25e29eea82e09e6abce186
Author: Khawar Ahemad <ahemadkhawar123@gmail.com>
xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, an=
d netdev_lock_ops

This commit attempts to fix a circular locking dependency involving
net->xdp.lock, xs->mutex, and netdev_lock_ops(). It introduces a temporary
socket reference in xsk_diag_dump() to avoid holding net->xdp.lock during
xsk_diag_fill() and moves xp_clear_dev() outside the locks in xsk_notifier(=
).

Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..e51990fb9e0de 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
[ ... ]
> @@ -2123,7 +2123,9 @@ static int xsk_notifier(struct notifier_block *this,
[ ... ]
>  	case NETDEV_UNREGISTER:
>  		mutex_lock(&net->xdp.lock);
>  		sk_for_each(sk, &net->xdp.list) {
>  			struct xdp_sock *xs =3D xdp_sk(sk);
> =20
>  			mutex_lock(&xs->mutex);

[Severity: High]
This is a pre-existing issue, but does this actually break the circular loc=
king
dependency?

The original syzbot report highlighted a cycle involving net->xdp.lock and
xs->mutex. While the commit message mentions decoupling xsk_notifier(), it
appears we still hold net->xdp.lock here and then acquire xs->mutex just
below, keeping that part of the cycle intact.

Because xsk_bind() still establishes xs->mutex -> netdev_lock_ops(), and de=
vice
unregistration establishes netdev_lock_ops() -> port->pnodes_lock ->
net->xdp.lock, doesn't preserving this link leave the system vulnerable to =
the
same deadlock?

[ ... ]
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 0170363eb542c..bad0b13064f8b 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
[ ... ]
> @@ -153,28 +156,48 @@ static int xsk_diag_dump(struct sk_buff *nlskb, str=
uct netlink_callback *cb)
[ ... ]
> +	for (;;) {
> +		target_sk =3D NULL;
> +		num =3D 0;
> +
> +		mutex_lock(&net->xdp.lock);
> +		sk_for_each(sk, &net->xdp.list) {
> +			if (!net_eq(sock_net(sk), net))
> +				continue;
> +			if (num++ =3D=3D s_num) {

[Severity: High]
Does this new loop structure cause an O(N^2) list traversal complexity?

Because the loop starts num =3D 0 on every iteration and traverses the list=
 from
the beginning under net->xdp.lock, dumping a large number of sockets requir=
es
visiting elements repeatedly.

If there are many unbound sockets, xsk_diag_fill() returns -ENOENT, which
increments s_num but never hits -EMSGSIZE, causing it to iterate without
appending to the skb. This could traverse the entire list N times, potentia=
lly
leading to a local DoS due to CPU exhaustion and massive global lock conten=
tion.

> +				sock_hold(sk);
> +				target_sk =3D sk;
> +				break;
> +			}
>  		}
> +		mutex_unlock(&net->xdp.lock);
> +
> +		if (!target_sk)
> +			break;
> +
> +		err =3D xsk_diag_fill(target_sk, nlskb, req,
> +				    sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				    NETLINK_CB(cb->skb).portid,
> +				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				    sock_i_ino(target_sk));

[Severity: Critical]
Does dropping net->xdp.lock before calling xsk_diag_fill() expose a
use-after-free condition?

Since xsk_diag_fill() is now called without net->xdp.lock, xsk_release() ca=
n run
concurrently and remove the socket from net->xdp.list. If a socket was crea=
ted
and queues were allocated but it was never bound, xsk_unbind_dev() returns
immediately without setting xs->state to XSK_UNBOUND.

Then xsk_release() can proceed to call xskq_destroy() on xs->rx and xs->tx
outside of xs->mutex, freeing the queue memory without setting the pointers=
 to
NULL.

Concurrently, xsk_diag_fill() would acquire xs->mutex, see that
xs->state !=3D XSK_UNBOUND, and call xsk_diag_put_rings_cfg() or
xsk_diag_put_stats(), which would dereference the now-freed xs->rx and xs->=
tx
pointers.

> +		sock_put(target_sk);
> +
> +		/*
> +		 * xsk_diag_fill() returns:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902041257.5837=
4-1-ahemadkhawar123@gmail.com?part=3D1
