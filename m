Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6637EFE7;
	Tue,  1 Sep 2026 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223915; cv=none; b=dh/iTx+kzKdcpTPSFrmq7CqxhD0O+6Ra6tytkeDGl32SPl+nZiaVLD8T9uxYCJYwWTcJkFEVqyLZdWqQtJJYUirCtJQp7/1IjrMUbdJVBhDM+JHEW9jnTJ/2bl3qeX007PgV7mpSYZZ2ygJH9LsRqAsfL3qUGgvV5K3uLeu6U9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223915; c=relaxed/simple;
	bh=jkzrYj8PJyPz96nMDh9g0buGOmxTZpqsD6UgMxBlmJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epzkLP0yIxuHPglp6qLCyMLXPqq1GDG3rHXfoEyZUE5pStK06kUBS/8DgimCngb0FXu6oURKolpYJyUuGhlaPdWhefJh0qIvP7bv9DbpdG/Zl0oFvKPwHJsziIAksxb8BtotqGcSta4aHdxnWDeiaV7sOQdojl/Dz2sBS97+Gy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA0dn3MD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA0dn3MD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B101F000E9;
	Tue,  1 Sep 2026 00:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223913;
	bh=3J24YzvMtZcbVkqO6v2h4dYWM+5So6cHobuVpr4vxEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mA0dn3MDZd9FsqLvQz78FkiFmHDKPMoF3QI8rHzbgUDdLhSNdTfp+A9yAZcZhRMMd
	 CE/A6VuiKEvSNGktWqHU8S6MIK8DpxkkfvDRzqMSs4qWd9kJoXDX+QXiH5spcXthRZ
	 tBzcdmizY7QS2A0eoFlpJxn7Mf3LD6G/CpiYh5Cu64eKnlAGi1JZI0dADGDlf++mw2
	 82M/CtpfZaFwxwoNMQzy28c1WZoEroQZ/Mh3zUyOQsMSd720GgjW1od+Bq3j7rh3NZ
	 6QocUfb/4HecZgXn5KUfoSV+HBEv223mFySl1yd4LNWlc54iKLI2JssuMjoYjTAnSr
	 0zXlUXXQn43ug==
Date: Mon, 31 Aug 2026 17:51:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Khawar Ahemad <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v4] xsk: Fix circular locking dependency
 between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Message-ID: <20260831175149.6a13c2a3@kernel.org>
In-Reply-To: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
References: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 23:17:44 +0530 Khawar Ahemad wrote:
> Subject: [PATCH bpf-next v4] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops

This patch got assigned to netdev in patchwork, which means it should
go via the networking trees. When reposting please tag it as 
[PATCH net v5] rather than bpf-next.

> syzbot reported a circular locking dependency involving &net->xdp.lock,
> &port->pnodes_lock, netdev_lock_ops(), and &xs->mutex:
> 
> -> #3 (&net->xdp.lock):  
>        xsk_notifier+0x3d/0x2c0 net/xdp/xsk.c:2106
>        ipvlan_device_event+0x310/0x4e0 drivers/net/ipvlan/ipvlan_main.c:834
>        unregister_netdevice_many_notify+0x808/0x18b0 net/core/dev.c:12518
> 
> -> #2 (&port->pnodes_lock):  
>        ipvlan_device_event+0x85/0x4e0 drivers/net/ipvlan/ipvlan_main.c:795
>        notifier_call_chain+0xb5/0x410 kernel/notifier.c:85
> 
> -> #1 (&dev_instance_lock_key / netdev_lock_ops):  
>        netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>        xsk_bind+0x331/0x11d0 net/xdp/xsk.c:1627
> 
> -> #0 (&xs->mutex):  
>        xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
>        xsk_diag_dump+0x2e0/0x4e0 net/xdp/xsk_diag.c:166
> 
> The cycle exists through the following dependency chain:
> 1. xsk_diag_dump() acquired &xs->mutex while holding &net->xdp.lock (#0).
> 2. xsk_bind() acquired netdev_lock_ops() while holding &xs->mutex (#1).
> 3. Device unregistration in ipvlan_device_event() acquired
>    &port->pnodes_lock (#2) and called xsk_notifier(), which acquired
>    &net->xdp.lock (#3).

This description is not super clear on what creates the cycle TBH.
Please clean this up.

> Break the circular dependency by decoupling the locking in xsk_diag_dump()
> and xsk_notifier():
> 
> 1. In xsk_diag_dump(), avoid holding &net->xdp.lock while calling
>    xsk_diag_fill(). Instead, locate the target socket under &net->xdp.lock,
>    take a temporary socket reference via sock_hold(), release
>    &net->xdp.lock, and call xsk_diag_fill() (which acquires &xs->mutex)
>    with sock_put().
>    To preserve dump continuation across buffer exhaustion, distinguish
>    -ENOENT (when an unbound socket is skipped) from -EMSGSIZE (when the
>    skb is full and the cursor must be retained for the next dump callback).

Why are you doing this? We still take the socket logs under the netns
in the notifier so does this actually fix anything?..

> 2. In xsk_notifier(), split device unregistration into two phases:
>    - First, unbind all matching sockets under &net->xdp.lock and
>      &xs->mutex.
>    - Then, release &net->xdp.lock and perform device queue teardown by
>      sweeping the device queues via xsk_get_pool_from_qid() and calling
>      xp_clear_dev(pool) outside all AF_XDP locks.

..IOW isn't fixing this enough? 

> Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")

Hallucination. Besides, if the problem in the netdev lock - pretty sure
it didn't exist when xsk was added.

> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
> Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4..e72344fccb 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2099,7 +2099,9 @@ static int xsk_notifier(struct notifier_block *this,
>  {
>  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>  	struct net *net = dev_net(dev);
> +	unsigned int max_queues;
>  	struct sock *sk;
> +	u16 qid;
>  
>  	switch (msg) {
>  	case NETDEV_UNREGISTER:
> @@ -2114,13 +2116,21 @@ static int xsk_notifier(struct notifier_block *this,
>  					sk_error_report(sk);
>  
>  				xsk_unbind_dev(xs);
> -
> -				/* Clear device references. */
> -				xp_clear_dev(xs->pool);
>  			}
>  			mutex_unlock(&xs->mutex);
>  		}
>  		mutex_unlock(&net->xdp.lock);
> +
> +		/* Clear device references outside AF_XDP locks to avoid
> +		 * lock inversion with netdev_lock_ops().
> +		 */
> +		max_queues = max(dev->real_num_rx_queues, dev->real_num_tx_queues);
> +		for (qid = 0; qid < max_queues; qid++) {
> +			struct xsk_buff_pool *pool = xsk_get_pool_from_qid(dev, qid);

This will not work for leased queues.
Just collect the sockets in the loop above and hold them like you did
on the diag side. Then you can walk the sockets and use xs->pool.

> +			if (pool)
> +				xp_clear_dev(pool);
> +		}
>  		break;
>  	}
>  	return NOTIFY_DONE;
> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 0170363eb5..bad0b13064 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -97,6 +97,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	struct xdp_sock *xs = xdp_sk(sk);
>  	struct xdp_diag_msg *msg;
>  	struct nlmsghdr *nlh;
> +	int err = -EMSGSIZE;
>  
>  	nlh = nlmsg_put(nlskb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*msg),
>  			flags);
> @@ -111,8 +112,10 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
>  
>  	mutex_lock(&xs->mutex);
> -	if (READ_ONCE(xs->state) == XSK_UNBOUND)
> +	if (READ_ONCE(xs->state) == XSK_UNBOUND) {
> +		err = -ENOENT;

If the caller has no special handling for this just return 0
but I'm not sure this is right. The socket is no longer listed
so we shouldn't count against the iterator.

>  		goto out_nlmsg_trim;
> +	}
>  
>  	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
>  		goto out_nlmsg_trim;
> @@ -145,7 +148,7 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  out_nlmsg_trim:
>  	mutex_unlock(&xs->mutex);
>  	nlmsg_cancel(nlskb, nlh);
> -	return -EMSGSIZE;
> +	return err;
>  }
-- 
pw-bot: cr
