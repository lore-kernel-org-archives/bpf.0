Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280865;
	b=b0BqThgGKj6Obyxbk+BFdy5N2sUQR3e1O6YbWiag20IXMKDIwWdP0KHFOzI8id3jlOz9
	 yQdmjYxsP8CeKERId10MEvVPtSkZmsTSeD7cM7GghPBm53YkK8GA+uve1z3iUsp9i6Vw1
	 i2fZPml+9UV0DL4GmLLFmFW88zrShQcsSz88cmiBbNFUMDarc4GMWsuW81MZ3gE488dpR
	 ujNlR1byOcnJXsTwWtJ7qlE4rXwPreEh4h/wss/NrSNKarN1iI4okCf+aBu9XLRe1GeyU
	 BSfTweugehpPGFrYD06qpmMXR1Ly1UiH6Nytu+vM1UJlgUGaQq94LLW56EgfhCc5boQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280865;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QQYq9UN0ymiPTQymz+UkJfbvfMGgvjzLlUXXSTgUt70=;
	b=i/rR7iy4obOrMRDa+8EBFsqnevI9hU6Gx/yOKFJlrosbURoe7enQd+5ZeSiU7R6zfz2v
	 XXT7Aj3jmbYgYYoRG/dkDbBrZ1SMYsx7G9XYyBbUzel2yeKVCGPgz/2h03CYYiQpZNr4f
	 2zjykN7/Jo3Yy4oGcpCSZIqQnOc4WlHpau6whTZ8ToJAQjSHdfNHzeLkfY75ueEk9hDKn
	 YZebTfHc1y4b3/oxu3R/EwT6Z5kuV5XrH9qWi9E1qbkZPk+riE+GCi6IIYPSaQ2AYZd1v
	 pSHm97D/TZe2eedVQwToOU2vO6VCHsWdQwlUfJ0/a8l+OIQcp3qMg8Vk6YJEh6pNS6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qlMRuqXO;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061F606A321;
	Tue, 10 Nov 2026 03:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B061F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qlMRuqXO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qlMRuqXOptJ17RYY0rNr1Zu1onjRr4pOhvNzWXVzO9BuNvGV02fm6fIyIZZ07tk3vzT6P3Ya2TwSX
	 Qd4w/O1w8SMEe+ZOAcf48R7Pz+QnaVwb7A4Ah825mv/AvJVAcWE+yl4khh+ajWBcgEwd+puhP6nufW
	 b9wDq3w4+FxWfSzM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af28d9b55e-c7ab6;
	Tue, 10 Nov 2026 11:21:00 +0800 (CST)
X-RM-TRANSID:2ee56af28d9b55e-c7ab6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af28d91c9a-a496c;
	Tue, 10 Nov 2026 11:21:00 +0800 (CST)
X-RM-TRANSID:2ee86af28d91c9a-a496c
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
Subject: Re: [PATCH net v2 2/3] virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
Date: Tue, 10 Nov 2026 20:20:47 +0900
Message-ID: <20261110112049.11228-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179422769501.994134.8613940611095428101@kernel.org>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com> <20261108193845.73621-3-yanhaishuang@cmss.chinamobile.com> <179422769501.994134.8613940611095428101@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 09, 2026 at 12:34:55PM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
>
> Is explicit XDP removal followed by closing the socket the only trigger?
>
> Ordinary netdev unregistration looks like it ends in the same failed
> disable. Examples are virtio-net hot-unplug, driver unbind and module
> unload.

[ ... ]

> The new max_queue_pairs bound fixes this path as well. The commit message
> only hints at it with "Removing XDP must not fail". Could the message
> also mention the unregister path?

Yes. Unbinding the device from virtio_net with XDP attached and a
socket bound to an XDP queue gives "Failed to disable zero-copy!"
without this patch and no warning with it. I'll mention that path in
the changelog.

> [Severity: Medium]
>
> How does this wider qid range interact with the restore fallback that a
> later patch in this series adds to this function?

[ ... ]

> Does this leak the xsk_dma_map, its dma_pages array and the DMA or IOMMU
> mappings of the umem pages?

It does, but only together with the restore fallback of patch 3, which
looks the pool up with xsk_get_pool_from_qid(). Patch 3 has other
problems for pools above curr_queue_pairs too, so I'll drop it from the
series and resend patches 1 and 2 as v3. The reworked patch 3 will keep
track of the pools in the driver instead of looking them up by queue
id.

pw-bot: cr


