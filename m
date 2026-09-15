Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AE47DD43;
	Tue, 15 Sep 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462001; cv=none; b=qMdoRTFJu/js0q5PrnSi7qwwTd8FKo5ADk99/UzoGm9wR3JrP4gEUoFjnpHO+givUn4n1ePY42Dbh5cAcFVc2wEF3Nx+4+OvoO1v3YKakAJOHTowQ+RVndW8mbRwXy1FU1BJCWR0RFvsi+2xMHt+YJcDMgZ0NAcsZaFJGcY2uYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462001; c=relaxed/simple;
	bh=U2krMe59EsC15c6J/59hPpXJY0KadgNNGmoRNlckwVI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Tl2Og3PtUa5SmYpEOGTkntnLXNNslJpzgpsisiz2E5bGY+17fyW04clcUOXmSBwNQn5w+RWDR4olWZMQZJaCVIhMX5WUXBCg9Pn3YTQiDyvFGbqZ+w7lvMj7E0XsgdZy28YhINCnmW+W3UZh/BcNtoT9OnODUlW2qMixsm5BFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpHLHK+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpHLHK+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5481F000FF;
	Tue, 15 Sep 2026 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462000;
	bh=TytNrS46T1t0R7A5C9IYc5jnBPcfnQfdjIySCgQwjss=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OpHLHK+pixnWMy/MApW0jUL237P9+RB9PGBsup9LcCZl/g87iBbIpv7bqsbL0Nthv
	 bREtzBwQ1A3deQnzHgTK90RZb7o+MKXjp3jAlS3NCz5/FCboq6f9H9gGleTQVYhmGa
	 mp3U+ZIQ3SlPKzBQ9qLIfZR3UuW4+ZpUvVe8MxNm6XpeMFD3AAVHa7B5859MfN9f0m
	 tyi2BDo7pJnXPembrGs75eZNCKolf6RojKBslWA4O5FThUMToq/YIOX/hW95+1Z8K9
	 AlU+IosOQdbGJaS0igYIo79FJ8+DEqEmmPqqDxy/RE1f5F3DSR9TocCL79Escrfdsh
	 bIKm/2m7zFj1Q==
Content-Type: multipart/mixed; boundary="===============0633404650045652649=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d10e522c569e205e0bf60b3b7bc9ef27fd7ed88a9cef88f6932d85ead26d7224@mail.kernel.org>
In-Reply-To: <20260915081023.7433-1-ahemadkhawar123@gmail.com>
References: <20260915081023.7433-1-ahemadkhawar123@gmail.com>
Subject: Re: [PATCH bpf-next v6] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
From: bot+bpf-ci@kernel.org
To: ahemadkhawar123@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,kuba@kernel.org,pabeni@redhat.com,edumazet@google.com,horms@kernel.org,syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 08:46:39 +0000 (UTC)

--===============0633404650045652649==
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
>
> -> #2 (&port->pnodes_lock):
>        ipvlan_device_event+0x85/0x4e0 drivers/net/ipvlan/ipvlan_main.c:795
>        notifier_call_chain+0xb5/0x410 kernel/notifier.c:85

Does the commit message accurately describe the #2 lock acquisition?

The syzbot report shows the #2 acquisition of pnodes_lock comes from the
bonding/features path (NETDEV_FEAT_CHANGE event triggering
netdev_compute_master_upper_features), not from device unregistration.
The #3 stack shows unregister calling into ipvlan_device_event, but
that's a different event path.

> The cycle exists through the following dependency chain:
> 1. xsk_bind() acquired netdev_lock_ops() while holding &xs->mutex (#1).
> 2. Device unregistration in ipvlan_device_event() acquired
>    &port->pnodes_lock (#2) and called xsk_notifier(), which acquired
>    &net->xdp.lock (#3).
> 3. Both xsk_diag_dump() and xsk_notifier() acquire &xs->mutex while
>    holding &net->xdp.lock (#0).

How does this enumeration form a cycle?

The enumerated items describe edges:
  #0 -> #1: xs->mutex -> netdev_lock
  #2 -> #3: pnodes_lock -> xdp.lock
  #3 -> #0: xdp.lock -> xs->mutex

To close the cycle, we need the netdev_lock -> pnodes_lock edge (#1 -> #2),
but this edge is never mentioned in the enumeration. Without that fourth
edge, the description doesn't actually describe a complete cycle. The syzbot
report does contain this edge (via the bonding/features path in frame #2),
but the commit message omits it from the enumeration.

Could the commit message be clarified to explicitly state all four edges
that form the cycle?

[ ... ]

> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682

Is it appropriate to use the Closes tag here?

The syzbot dashboard shows this bug was already fixed by commit a8455260b2e9
("ipvlan: unregister upper devices outside pnodes_lock"), which removed the
pnodes_lock -> net->xdp.lock edge on the ipvlan side. That commit is present
in this tree at drivers/net/ipvlan/ipvlan_main.c:899-902.

Using the Closes tag on a redundant patch may cause syzbot and patchwork to
misattribute the fix to this commit instead of the actual fix.

Additionally, Maciej Fijalkowski informed you in v5 that they had already
fixed the issue on the ipvlan side:

  https://lore.kernel.org/bpf/DM4PR11MB6117332DE5BD8408848E453D82B72@DM4PR11MB6117.namprd11.prod.outlook.com/

  "We went with fixing ipvlan side instead:
   https://lore.kernel.org/netdev/20260828164918.451364-1-maciej.fijalkowski@intel.com/

   Forgot to CC you, sorry about that."

Does this XSK patch still serve a purpose given the ipvlan fix has already
resolved the reported issue?

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..b7072092cc51 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1636,20 +1636,22 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  		return -EINVAL;
>
>  	rtnl_lock();
> +
> +	dev = dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
> +	if (dev)
> +		netdev_lock_ops(dev);
> +
>  	mutex_lock(&xs->mutex);

[ ... ]

> @@ -1786,18 +1788,20 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  	}
>
>  out_unlock:
> -	if (err) {
> -		dev_put(dev);
> -	} else {
> +	if (!err) {
>  		/* Matches smp_rmb() in bind() for shared umem
>  		 * sockets, and xsk_is_bound().
>  		 */
>  		smp_wmb();
>  		WRITE_ONCE(xs->state, XSK_BOUND);
>  	}
> -	netdev_unlock_ops(dev);
>  out_release:
>  	mutex_unlock(&xs->mutex);
> +	if (dev) {
> +		netdev_unlock_ops(dev);
> +		if (err)
> +			dev_put(dev);
> +	}
>  	rtnl_unlock();
>  	return err;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34946645726
--===============0633404650045652649==--
