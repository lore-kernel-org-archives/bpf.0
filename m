Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129875;
	b=cfXW3u9jMulZWL4juXtzF0mbq9+QQYLwTBFKVGqdXCgVf/XHNsQVIMOxD2ZYDYhQ7HX3
	 dTWUazDzoPCibX1a/JnZWGQ750ARPKgkMYcxJb/N6q6TC7+ODtrqc8rDyLqyDXzO+1xON
	 lsEB0Gz/c8c8Lq7XoT7/e83jGlGPlHfxgq74sfzk4+31dmohaUs0GGTvBxF9ujrN/MpZD
	 daBjOpOFBW4AEZANyysvLFgvOUxTV3kABBSLIAuEJoyhhaxOa/x4fGHYSGX4Uzzn3DbZ9
	 XHZ18YjnCBHUCM8YGFX9vfOZ4u571MsNFGMPTqA56H15Qe8EBg7LXi/Xfalsi+5HRww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129875;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j8rq9WD1PWSJfzNjdvpugwztGTtxU4BUg3rNiZ2tRAM=;
	b=HM3ftjnT7Clo+sb61zpD86IhyixSdSvbABFeam1p84uYQaZ6ysQHchZoLqNNoWs7T9Bc
	 oymAuRHKfN3n+ayfPnq478a1Y5/UuhKORt5PTMhd/VojIkxfQpEYWiNH3Bod6wfLr0ZRb
	 nr1jotW+gVZV03bYOpmEBKXzebIb8PUcwjrQTjOnZ21zpGkFJ/Bj/EeNt9+mtt8XCutVK
	 p53c2buVFuUCwb1Q79BMrzapowsfg0kiln5aUjPIlXZAH7gtJI6MJ9NX7tQU26eHsr4oB
	 sjWitzOYncwP/38ovKjzEape2V38dhvq+09wn0aGiMjUvq6jGCl2x3AGrUD3jX51AWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tK8QjT2N;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAA606A322;
	Sun,  8 Nov 2026 09:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DAA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=tK8QjT2N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=tK8QjT2NhGmyW4wmOO8RrBskFx5hXGRg9xwQtBhc/8hgQCR1MVmMHh7y3w2pikytdDaCu87d5ldS2
	 K8li6vmXmuoohPvT7aO4VNHVQntXl1cGSzPPX3dJBrmhnEPI6BG6G/KfxcJJrNZs6qau8mhhzK1yAV
	 jZxkiMqF6PnZxl1U=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af03fc6296-c043a;
	Sun, 08 Nov 2026 17:24:31 +0800 (CST)
X-RM-TRANSID:2ee96af03fc6296-c043a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af03fc1270-639ea;
	Sun, 08 Nov 2026 17:24:31 +0800 (CST)
X-RM-TRANSID:2ee76af03fc1270-639ea
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] virtio_net: Keep AF_XDP zero-copy pools bound across suspend
Date: Mon,  9 Nov 2026 02:23:55 +0900
Message-ID: <20261108172417.56607-2-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179411647719.994134.8428591729717130295@kernel.org>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com> <20261107125723.33547-3-yanhaishuang@cmss.chinamobile.com> <179411647719.994134.8428591729717130295@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Nov 08, 2026 at 05:41:17AM +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] virtnet_xsk_pools_unbind() calls virtnet_xsk_pool_disable() for
>   pools whose AF_XDP sockets are still XSK_BOUND.
> - [High] virtio_net: stale DMA addresses in free_list after unaligned XSK
>   pool rebind
> - [High] virtio_net: uninitialized xsk_hdr_dma_addr used in
>   virtnet_xsk_pool_enable()
> - [Medium] virtnet_xsk_pools_unbind()
>   (drivers/net/virtio_net.c:6063-6072) loops over max_queue_pairs and…

Thanks, I went through all four against the code and they all hold.

The three High ones come from the same mistake: the patch reuses
virtnet_xsk_pool_disable()/enable(), which assume the socket is
already unbound, while the sockets are still bound and the device is
still running. That opens the window against the RX path redirecting
to the socket, unmaps and remaps the pool behind buffers sitting on
its free_list, and lets TX NAPI run before xsk_hdr_dma_addr is set.

For v2 I'll stop unmapping and remapping the pool across suspend.
Freeze will keep the pool DMA mapping and only stash the driver's
per-queue xsk state after virtnet_freeze_down() has stopped NAPI, and
restore will attach it to the new queues before virtnet_open(). That
should remove all three problems instead of patching each one.

The Medium one is right too. A pool can be left bound on a queue at
or above curr_queue_pairs after native XDP is detached. As noted, that
comes from virtnet_xdp_set() not checking for bound pools, which
predates this patch. I'll fix it there as a separate patch in the
series, so suspend no longer has to handle that case.

v2 will be retested with KASAN for both aligned and unaligned pools.

pw-bot: cr


