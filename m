Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280884;
	b=YHrSmJkEumF+9+JOVyM46PSK3p3WiZ5QUOxyq93MJBka8ns7xrpa+V6TCyDNg3+HQYLa
	 n78vuHNt4TRtVqEQj1yT3kEIiYX0KyCYtj9rZRT0pbCZBVf7UAcGvElqfV3qxvlvMB+8T
	 aZr72FAEVsWeK0EYp4NRs4ILIWYSEG9xjrbik6ztG10ZvhcMAcpUUNgCfucZKAl0Q60Zt
	 HYTyNhCVwgez7MAnFf7f8+9KyYOyS9Cc6RYqaEnSSG5KcXBZ0s1smFaBdTL9KsLPA9qHV
	 jIFxuVfQIJyLNjaSZQUW3jgurcd4wJCqeGt3zbcwIvvoFATrkKA9TtVh8P89X0PwAdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280884;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Iu/jo1GP6S2hOnbceCXpLkMdW9l1lBuKE6wK4rMGL7s=;
	b=qO9j0yWNrPaKNOzEmRrLDmpcwEu7K2G0UlXnFC+wfDfjDw4ISpVYf1XNZqWkE5GzYs7R
	 znkn+JbNeffYVu1SY+Y3emyexTfxe8ukt4qeWwsWshsb4fBYhL7gvCd7O+6iaR5gye4tO
	 FvYZLtzpHHV6el+kn45E/G33LAtEZIzq2XUB8iQWUkXZIHh5k33nXFrXTPxW+NRxmM3mD
	 59s4bbf0TMpLJmcspjeIfgWXtRkZYK6C6TihgNChoT0DR1raEu+RMcw3mdn987t5qxFi/
	 bSkJKxTRtSC5sF9f+QebvnFH47W5vdyFbEZcOrBV9yRpNR3OgQ1U7mBPTHXjj6l1NSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vtyrBxX3;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC4606A32E;
	Tue, 10 Nov 2026 03:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFAC4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vtyrBxX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vtyrBxX3nBUcwHfcB5JBkuwv5gtB/DTRDFKTqGUq6Gu/IU7LYPokXEW3Gb1RVDuuA+2LtkbJ2kDw6
	 w810ovi1LNhJlyje+jiO3TbThnEeQB0gHwDlukhHm0dpTD8bjy4U7p2oLtL73uyj7OkSFz2BKm7NXa
	 lqh1xjS0I6WonSuI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af28db102b-96bbc;
	Tue, 10 Nov 2026 11:21:21 +0800 (CST)
X-RM-TRANSID:2ee66af28db102b-96bbc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af28daaccd-a499f;
	Tue, 10 Nov 2026 11:21:21 +0800 (CST)
X-RM-TRANSID:2ee86af28daaccd-a499f
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
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
Subject: Re: [PATCH net v2 3/3] virtio_net: Keep AF_XDP zero-copy pools bound across suspend
Date: Tue, 10 Nov 2026 20:21:13 +0900
Message-ID: <20261110112114.11278-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179422769660.994134.7551261891585249565@kernel.org>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com> <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com> <179422769660.994134.7551261891585249565@kernel.org>
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

On Mon, Nov 09, 2026 at 12:34:56PM +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] virtnet_xsk_pools_release() unmaps the DMA of a zero-copy pool
>   sitting at a qid >= curr_queue_pairs (left there by removing XDP), but…
> - [Medium] When virtnet_xsk_pool_attach() fails on restore, the pool
>   stays DMA mapped while rq->xsk_pool stays NULL.
> - [Medium] If virtnet_xsk_pool_attach() fails during restore,
>   virtnet_xsk_pools_attach() only logs netdev_warn() and the resume…
> - [Medium] virtnet_xsk_pools_release() is a new writer of AF_XDP driver
>   state (rq->xsk_pool, sq->xsk_pool, rq->xsk_buffs, sq->xsk_hdr) that…
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it defeats the
>   patch's cleanup model on the failed-restore path.

Thanks, these all hold. sashiko-bot raised the same points in its
review of this patch.

The High one and the first Medium have the same cause: once the queues
are freed on freeze, the patch finds a pool again only through
xsk_get_pool_from_qid(), which depends on the current queue counts. A
pool on a queue above curr_queue_pairs can then be unmapped on freeze
and bound again unmapped later, or not found when it has to be
unmapped.

The second Medium is right as well: when the attach fails, the socket
stays bound but gets no traffic and no error. And the release on freeze
runs without RTNL, unlike every other writer of that state.

The failed-restore issue is older, as noted: after a failed
virtnet_restore_up(), vi->rq and vi->sq are freed while the netdev
stays registered, and virtnet_close() uses them too. I'd rather keep
that separate.

I'll drop this patch from the series, resend patches 1 and 2 as v3, and
rework it to keep track of the pools in the driver across suspend
instead of looking them up by queue id.

pw-bot: cr


