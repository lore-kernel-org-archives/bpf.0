Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B1363C50
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767516; cv=none; b=gggs1M4yy2VrV6rG5miSEGqbzwIkLQyGsNIwPzdpatLP1sVmouXHia0VW2s6wZVOUxWS9Ks8Pup0n5aCObtxf3Q4wLtWFqOy7Vr3aIUrmUzSD4Qz7lyEbz60QYRtTk1S2EgfJk0+vR8/5wXlyv1dP7Tea4asiZmwqrU/vOGUMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767516; c=relaxed/simple;
	bh=GUIjnxBDe2HhtwsBhND2B2QBGvG6qYppxji3qtxltmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lkdqNrGPJ+AHA5bJMwWJ7Dy1H0fSEqxxm9MmXwgwHkweThkqanABlbNzBTimr6PP4nTHyxOHohc4Vb2H/S7NB7OClV4vl/grqHfaLBkkQGrJncgeXYZdLsk7uH3JkZwkE8sU5tqGwcSYS7zYo9OFeyCuDGvXIVmzunhPOQeJ6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3UAgx2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3UAgx2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3331F000E9;
	Wed, 26 Aug 2026 18:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787767508;
	bh=W4cXZV7UhTPKKjNycBVUa8rTgcrFeptqYZgXWU40CvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3UAgx2IvZ3canqbCnE4S5U/pI9avqisQn6s5pG4g4tqMOyihJmLkr+/yLqYe/KDO
	 hqux89uLOcEYJQYUPAMUN/VSmMK3ls4qFj69pm3eybqTbbdaOLvjePbrHApRF0aVnE
	 O60QyPabTe2sJMnwy/aeNjEm7MOHjqErrW1fyNG667EYPcYhdL9EpvxBh9HKZ0SjNz
	 crPXC5sx8ZYYUI8RbNqwfnAoRxohZnrJUq0eEcJwE3kghFDqmvA9WajyMs0wtWieK/
	 mpm3o39CGHN69lVX37aL8Rk8n8FxKm+M34W8kb2t6QHrwf6PPBFKBah25bwzKzQo4G
	 mGFdqgx6JZ6hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4] xsk: Fix circular locking dependency
 between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
References: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:05:07 +0000
Message-Id: <20260826180508.3B3331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Queue-based iteration in xsk_notifier() using real_num_rx/tx_queue=
s misses stranded pools, leading to net_device refcount leaks and Use-After=
-Free.
- [High] O(N^2) list traversal in xsk_diag_dump() causes CPU soft lockups, =
exacerbated by skipping unbound sockets.
- [Medium] Netlink DUMP rule violation: missing NLM_F_DUMP_INTR flag when d=
ropping locks.

Pre-existing issues:
- [High] The circular locking dependency is not fully resolved because `xsk=
_notifier()` still acquires `&xs->mutex` while holding `&net->xdp.lock`.
--

commit 5d27bb72970d01c1b3fb96dd5f15dd2e0ec89bb0
Author: Khawar Ahemad <ahemadkhawar123@gmail.com>

xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, an=
d netdev_lock_ops

This commit attempts to fix a circular locking dependency involving
net->xdp.lock, port->pnodes_lock, netdev_lock_ops, and xs->mutex. It modifi=
es
xsk_diag_dump() to release net->xdp.lock temporarily and defers xp_clear_de=
v()
outside of the locks in xsk_notifier().

Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b64..e72344fccbf26 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2114,13 +2116,21 @@ static int xsk_notifier(struct notifier_block *th=
is,
>  					sk_error_report(sk);
> =20
>  				xsk_unbind_dev(xs);

[Severity: High]
This is a pre-existing issue, but does this code still preserve the circular
locking dependency?

The patch intended to fix a 4-lock circular dependency involving
port->pnodes_lock -> net->xdp.lock -> xs->mutex -> netdev_lock_ops.
However, xsk_notifier() still acquires &xs->mutex while holding
&net->xdp.lock (just prior to this xsk_unbind_dev() call).

Since xsk_bind() still fundamentally acquires netdev_lock_ops while holding
&xs->mutex, the exact lock dependency chain is preserved and lockdep will
continue to report the cycle.

>  			}
>  			mutex_unlock(&xs->mutex);
>  		}
>  		mutex_unlock(&net->xdp.lock);
> +
> +		/* Clear device references outside AF_XDP locks to avoid
> +		 * lock inversion with netdev_lock_ops().
> +		 */
> +		max_queues =3D max(dev->real_num_rx_queues, dev->real_num_tx_queues);
> +		for (qid =3D 0; qid < max_queues; qid++) {
> +			struct xsk_buff_pool *pool =3D xsk_get_pool_from_qid(dev, qid);
> +
> +			if (pool)
> +				xp_clear_dev(pool);
> +		}

[Severity: High]
Can this loop miss pools that were bound to queues which have since been
disabled?

If an unprivileged user binds an AF_XDP socket to a high queue index
(e.g., qid=3D3), and the interface's active queues are then reduced via
ethtool (e.g., rx 2), max_queues will be 2. When the device is unregistered,
this loop will only iterate up to max_queues and miss the pool on qid 3
because xsk_get_pool_from_qid() strictly enforces current queue counts.

Missing stranded pools during device unregistration fails to clear
pool->netdev, leaking the net_device reference. This causes an infinite
loop in netdev_wait_allrefs() upon device removal, freezing the network
stack. A subsequent socket close will trigger a Use-After-Free when
xp_clear_dev() dereferences the freed net_device.

>  		break;
>  	}
>  	return NOTIFY_DONE;

[ ... ]

> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 0170363eb542c..bad0b13064f8b 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -153,28 +156,48 @@ static int xsk_diag_dump(struct sk_buff *nlskb, str=
uct netlink_callback *cb)
>  	struct xdp_diag_req *req =3D nlmsg_data(cb->nlh);
>  	struct net *net =3D sock_net(nlskb->sk);
>  	int num =3D 0, s_num =3D cb->args[0];
> -	struct sock *sk;
> -
> -	mutex_lock(&net->xdp.lock);
> -
> -	sk_for_each(sk, &net->xdp.list) {
> -		if (!net_eq(sock_net(sk), net))
> -			continue;
> -		if (num++ < s_num)
> -			continue;
> -
> -		if (xsk_diag_fill(sk, nlskb, req,
> -				  sk_user_ns(NETLINK_CB(cb->skb).sk),
> -				  NETLINK_CB(cb->skb).portid,
> -				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
> -				  sock_i_ino(sk)) < 0) {
> -			num--;
> -			break;
> +	struct sock *sk, *target_sk;
> +	int err;
> +
> +	for (;;) {
> +		target_sk =3D NULL;
> +		num =3D 0;
> +
> +		mutex_lock(&net->xdp.lock);
> +		sk_for_each(sk, &net->xdp.list) {
> +			if (!net_eq(sock_net(sk), net))
> +				continue;
> +			if (num++ =3D=3D s_num) {
> +				sock_hold(sk);
> +				target_sk =3D sk;
> +				break;
> +			}
>  		}

[Severity: High]
Does this introduce an O(N^2) list traversal that could cause CPU soft
lockups?

By dropping locks and restarting the sk_for_each traversal from the list
head up to s_num on every iteration, this loop introduces an O(N^2) time
complexity.

Crucially, the loop never yields (e.g., via cond_resched()), and skipped
unbound sockets (-ENOENT) cause the loop to increment s_num and continue
without returning to userspace. If a user creates tens of thousands of
unbound AF_XDP sockets and triggers an xsk_diag_dump, the kernel will
execute billions of loop iterations within a single recvmsg syscall,
leading to severe lock contention on net->xdp.lock and CPU starvation.

> +		mutex_unlock(&net->xdp.lock);
> +
> +		if (!target_sk)
> +			break;

[Severity: Medium]
When dropping locks during a netlink dump iteration, should this set the
NLM_F_DUMP_INTR flag on the SKB?

Iterating over a list using an index while dropping locks allows concurrent
modifications to the list, which can cause the dump iteration to silently
skip elements or dump the same element multiple times.

The Netlink API contract mandates setting the NLM_F_DUMP_INTR flag when this
occurs so userspace is warned of the inconsistency.

> +
> +		err =3D xsk_diag_fill(target_sk, nlskb, req,
> +				    sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				    NETLINK_CB(cb->skb).portid,
> +				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				    sock_i_ino(target_sk));
> +		sock_put(target_sk);
> +
> +		/*
> +		 * xsk_diag_fill() returns:
> +		 *   0:         entry added successfully.
> +		 *   -ENOENT:   socket is unbound, skip it.
> +		 *   -EMSGSIZE: skb is full, retry this socket on the next dump callba=
ck.
> +		 */
> +		if (err =3D=3D -EMSGSIZE)
> +			break;
> +
> +		s_num++;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826174744.3394=
-1-ahemadkhawar123@gmail.com?part=3D1
