Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068947254C;
	Tue, 18 Aug 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059513; cv=none; b=eHCKWn4oR0xfX2WXohvqcxSM9XpUjZhumjr6OvLjg/Ym9VlhvmL9limkO5HS6fbsvNOIr7oM/ZJbcdd5CSGigSQESkHh6D8qO7cvZO6pblJGN4A2Y3FrAGnEj8B5JEVHqPYjYEYeggTxyQwIJHV+gViNL/U24G3mTlPlU2CLm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059513; c=relaxed/simple;
	bh=KJNKaEcIn212qV3W4yv49P+JJKlsYUtPPzC3G13RnR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ2XRr6EH9HV1VSxMrbdYKWusFSNBnKhW3G8JciEkKnHKQYivZ4ITKidgldGwQVswfnvIr34L/NilorxPAiADo+X63gNeH9Zc0YMjPVOZ70kAYosFqm8GIospoulsVvsxeSsWOavorGklwhpv8/ro5uC+eEgfxOwecC7y2doJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSCKo+x3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSCKo+x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE651F000E9;
	Tue, 18 Aug 2026 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787059511;
	bh=k7oH04TEdyYbBGWe8IKKtoZLo1n4vowgs8Xqtwy8+gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RSCKo+x3blTsy22ssz36sZiGAbtEx8OMZeL3aT/IW4rHCszjp7t7HTPDIujJpsDE8
	 BuvK2p010GyQhvEdblmxdSwc0RZzn3Oa3axWIWuz1f1F2vFXKa3dTr+sJBWyBkkx8m
	 /pCNPKBp+/f7/tdRFe9lx4cFuIulUD8j91VJWg7V+zYNzoWuRWWiD4sngor0ifj8gN
	 RVk1FY/r0KZKUzSZ2Hx6+BeAxadHFDNJIkxJEfuqg32sfeRW1KG99/OzMtT3ndo3rl
	 n2ma8AdVUZ99sk+oNUoacA+YAQVFYPw7g92RWGePX/HNR3TsWFd6+Gb3tG6/COh2No
	 yUbSePLbWB+Tg==
Date: Tue, 18 Aug 2026 14:25:05 +0100
From: Simon Horman <horms@kernel.org>
To: Subasri S <subasris1210@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] netdevsim: update rxq->napi pointer during queue reset
Message-ID: <20260818132505.GG265046@horms.kernel.org>
References: <20260815-net-netdevsim-v2-1-d6c85c5157a7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815-net-netdevsim-v2-1-d6c85c5157a7@gmail.com>

On Sat, Aug 15, 2026 at 08:19:32AM +0530, Subasri S wrote:
> In netdevsim, when queue reset is performed using debugfs, it triggers
> these sequence of operations: nsim_queue_stop() -> nsim_queue_start()
> -> nsim_queue_mem_free(). nsim_queue_mem_free() frees the old
> nsim_rq struct which embeds the napi_struct. But the rxq->napi pointer
> in the struct netdev_rx_queue still points to the old nsim_rq's embedded
> napi_struct. So, any subsequent xsk_bind() which reads rxq->napi->napi_id
> after a queue reset is a use-after-free.
> 
> Add netif_queue_set_napi() calls to nsim_queue_stop() and
> nsim_queue_start() which clears the rxq->napi during stop
> and sets it to the new napi instance during start.
> 
> KASAN report:
> 
> Call Trace:
>  kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
>  xsk_bind+0x1582/0x16c0 net/xdp/xsk.c:1758
>  __sys_bind_socket net/socket.c:1920 [inline]
>  __sys_bind_socket net/socket.c:1912 [inline]
>  __sys_bind+0x1a9/0x260 net/socket.c:1951
> 
> Allocated by task 5622:
>  nsim_queue_alloc+0x3c/0x140 drivers/net/netdevsim/netdev.c:715
>  nsim_queue_init drivers/net/netdevsim/netdev.c:1012 [inline]
>  nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1059 [inline]
>  nsim_create+0xb13/0x1420 drivers/net/netdevsim/netdev.c:1152
>  __nsim_dev_port_add+0x3ba/0x8f0 drivers/net/netdevsim/dev.c:1509
>  nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1570 [inline]
>  nsim_drv_probe+0xdbd/0x13a0 drivers/net/netdevsim/dev.c:1731
> 
> Freed by task 5659:
>  slab_free mm/slub.c:6377 [inline]
>  kfree+0x22b/0x6c0 mm/slub.c:6692
>  nsim_queue_mem_free+0xfe/0x190 drivers/net/netdevsim/netdev.c:796
>  netdev_rx_queue_reconfig+0x405/0x630 net/core/netdev_rx_queue.c:144
>  netdev_rx_queue_restart+0x8f/0xc0 net/core/netdev_rx_queue.c:183
>  nsim_qreset_write+0x2e3/0x410 drivers/net/netdevsim/netdev.c:887
> 
> Reported-by: syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c06674caba265dc61d46
> Fixes: 5bc8e8dbef27 ("netdevsim: add queue management API support")
> Tested-by: syzbot+c06674caba265dc61d46@syzkaller.appspotmail.com
> Signed-off-by: Subasri S <subasris1210@gmail.com>
> ---
> Changes in v2:
> - Restore rxq->napi when reset mode is 1
> - Link to v1: https://lore.kernel.org/r/20260812-net-netdevsim-v1-1-521a85e4fe91@gmail.com

This appears to be addressing the same issue as:

- [PATCH net] netdevsim: update queue NAPI association on queue reset
  https://lore.kernel.org/netdev/20260817082511.2300402-1-edumazet@google.com/
