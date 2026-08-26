Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41250472558;
	Wed, 26 Aug 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769971; cv=none; b=CjUwaxMYhIZ2MAm7G25B/EzexPt/OgYNl/GqPwRs9eiCCM6vjuEgySkYI0f+g/JFFrCmyTXUpTVOG2A4XSx4x1YcXIax4kLy1punDwyxcGXzMPfV2Oi/+nGbfZXK57CLULtcOj/uM/ap3lj47tlAflfMCMkAB6BXrE3OsfZ5CwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769971; c=relaxed/simple;
	bh=AsepdhN1RsBaCUpz9eFfex8cNoi5pLH6AlU758Hn9vs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F8yFTveouHgmNbaFEXk0mSbAsNopXPi4MxfE5xEsNyxX92EelQG3GYsIlbdkgyAWKDITAonOIDgApreFvCmXEL99AzwfLOB51oKZ45gxepFO08xEZ7/NhIvbBIulPh8oCwKOc753iQU4OaosrfQuS8oLHj4Onk2rI8Z52Q8vKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFGaKigG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFGaKigG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4035F1F000E9;
	Wed, 26 Aug 2026 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769957;
	bh=sITK5OG7WYyPuuL5MRxyV2besFmgE210GaCLeGuIDfo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bFGaKigGKB3xaZsXPOzxPLQUdjVIPx2mCocJpGx41hBZmhb3pVKyEgCckTg0X/LCF
	 tHuE+cPqt+pGoKPN9xo6P8CAZHz7DOP2IU0i93f4NKfyZNwWw0SjxOlyWBEBQp3Jfo
	 HJyY2ARR44kGdKSAniVvL/1Agba8+MkpVHn1DqjPTDV0JLrlGwpy9fJDqmooow74BN
	 vWaeMScxNRftFXx8eRp31/tqUBbSg6uFyADwtxBiNpNAtiEKCLCc/8WCoAn7t7vEux
	 nR7B5x7KQHrNRjhCcYkqF0LqFGD7EPUj0mFwsixkqZkfUPAPR2EgYFAAPSaeqDYD/m
	 lUT8UtXw5zzeA==
Content-Type: multipart/mixed; boundary="===============5601978857442439063=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4489c39227135e5da2d0801bc811069b126f70d10f4b154f3083484c10759341@mail.kernel.org>
In-Reply-To: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
References: <20260826174744.3394-1-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next v4] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,kuba@kernel.org,pabeni@redhat.com,edumazet@google.com,horms@kernel.org,syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 18:45:57 +0000 (UTC)

--===============5601978857442439063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> syzbot reported a circular locking dependency involving &net->xdp.lock,
> &port->pnodes_lock, netdev_lock_ops(), and &xs->mutex:
>
> -> #3 (&net->xdp.lock):
>        xsk_notifier+0x3d/0x2c0 net/xdp/xsk.c:2106
>        ipvlan_device_event+0x310/0x4e0 drivers/net/ipvlan/ipvlan_main.c:834
>        unregister_netdevice_many_notify+0x808/0x18b0 net/core/dev.c:12518

The quoted lockdep trace has fabricated symbol offsets. The real syzbot
report (Message-ID 6a8c9fd9.dbb3a75c.7844.000c.GAE@google.com) shows
completely different offsets:

  xsk_notifier+0x89/0x230 (not +0x3d/0x2c0)
  ipvlan_device_event+0x310/0x4e0 becomes +0xf1f/0xfb0 (rx path) and +0x489/0xfb0 (tx path)
  unregister_netdevice_many_notify+0x17fa/0x2130 (not +0x808/0x18b0)

The function sizes were also altered: xsk_notifier is 0x230 bytes in the
real report, not 0x2c0; ipvlan_device_event is 0xfb0, not 0x4e0. Even
the function size cannot change when re-quoting the same lockdep report,
because lockdep emits addr2line output with consistent objdump-derived
function boundaries. Only xsk_bind+0x331/0x11d0 was copied verbatim from
the real report.

Can a quoted lockdep excerpt be paraphrased this way? A maintainer
reading this cannot verify the trace against the syzbot report without
noticing the discrepancy.

[ ... ]

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b64..e72344fccbf26 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

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
> +
> +			if (pool)
> +				xp_clear_dev(pool);
> +		}

Does this introduce a race on pool->netdev between the sweep and
xsk_diag_put_umem()? With a leased RX queue the pool sits in the
physical device's queue array while pool->netdev points to the leasee.
The physical device can reach NETDEV_UNREGISTER with the lease still
active (netdev_rx_queue_lease only holds a reference on the physical
device, not the leasee). The socket loop skips the socket (xs->dev ==
leasee != physical_dev), so the sweep finds the pool at
physical_dev->_rx[hw_qid] and calls xp_clear_dev(pool), which writes
pool->netdev = NULL and drops the leasee reference, even though the
socket is still bound and alive.

The old code held &xs->mutex across xp_clear_dev(), which serialised
the write against xsk_diag_put_umem(). After the patch xsk_notifier()
holds only RTNL, and xsk_diag_dump() takes neither RTNL nor
&net->xdp.lock around xsk_diag_fill(). That leaves this check-then-use
in xsk_diag_put_umem() (net/xdp/xsk_diag.c:62):

    du.ifindex = (pool && pool->netdev) ? pool->netdev->ifindex : 0;

racing with the sweep's pool->netdev = NULL; dev_put(netdev). The
XSK_UNBOUND check at the top of xsk_diag_fill() does not cover this,
because the socket was never unbound by the loop.

Can the reader pass the pool->netdev test, reload after the store, and
dereference NULL, or dereference pool->netdev->ifindex after the sweep
dropped the last device reference?

> diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> index 0170363eb542c..bad0b13064f8b 100644
> --- a/net/xdp/xsk_diag.c
> +++ b/net/xdp/xsk_diag.c
> @@ -111,8 +112,10 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
>  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
>
>  	mutex_lock(&xs->mutex);
> -	if (READ_ONCE(xs->state) == XSK_UNBOUND)
> +	if (READ_ONCE(xs->state) == XSK_UNBOUND) {
> +		err = -ENOENT;
>  		goto out_nlmsg_trim;
> +	}

[ ... ]

> @@ -153,28 +156,48 @@ static int xsk_diag_dump(struct sk_buff *nlskb, struct netlink_callback *cb)
>  	struct xdp_diag_req *req = nlmsg_data(cb->nlh);
>  	struct net *net = sock_net(nlskb->sk);
>  	int num = 0, s_num = cb->args[0];
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
> +		target_sk = NULL;
> +		num = 0;
> +
> +		mutex_lock(&net->xdp.lock);
> +		sk_for_each(sk, &net->xdp.list) {
> +			if (!net_eq(sock_net(sk), net))
> +				continue;
> +			if (num++ == s_num) {
> +				sock_hold(sk);
> +				target_sk = sk;
> +				break;
> +			}
>  		}
> +		mutex_unlock(&net->xdp.lock);
> +
> +		if (!target_sk)
> +			break;
> +
> +		err = xsk_diag_fill(target_sk, nlskb, req,
> +				    sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				    NETLINK_CB(cb->skb).portid,
> +				    cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				    sock_i_ino(target_sk));
> +		sock_put(target_sk);

Does sock_hold() protect xs->rx and xs->tx from being freed? Before the
patch xsk_diag_fill() ran with &net->xdp.lock held, which serialised it
against xsk_release() taking that lock before sk_del_node_init_rcu().
After the patch the lock is dropped before xsk_diag_fill().

xsk_release() calls xskq_destroy(xs->rx) and xskq_destroy(xs->tx)
outside &xs->mutex (net/xdp/xsk.c:1555-1556) and never clears the
pointers. For a socket that was never bound, xsk_unbind_dev() returns
early without changing xs->state (it checks xs->state != XSK_BOUND at
net/xdp/xsk.c:1474), so xs->state stays XSK_READY and the XSK_UNBOUND
check in xsk_diag_fill() does not take the new -ENOENT branch.

A socket created with socket(AF_XDP, SOCK_RAW, 0) starts at XSK_READY,
and setsockopt(XDP_RX_RING)/setsockopt(XDP_TX_RING) allocates xs->rx /
xs->tx while still XSK_READY. If close() runs concurrently with a dump:

  T1 (ss --xdp): finds sk, sock_hold(sk), mutex_unlock(&net->xdp.lock)
  T2 (close):    sk_del_node_init_rcu(); xsk_unbind_dev() (early return);
                 xskq_destroy(xs->rx); xskq_destroy(xs->tx);
  T1:            xsk_diag_fill(): READ_ONCE(xs->state) == XSK_READY,
                 xsk_diag_put_ring(xs->rx, ...) -> dr.entries = queue->nentries;

Can this dereference freed memory and leak the freed ring contents to
userspace in the netlink attributes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32997090240
--===============5601978857442439063==--
