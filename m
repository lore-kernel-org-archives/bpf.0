Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306053;
	b=uwjyIAJcOD8cVuOF0+yI41JVBcp4CzV6xXxkeOVgMCPMdv+MrKHI799XJi109MTlF5wV
	 LRXtURkYinHSt1BI4ZfDfGjxp1996YlqoTGBk4QyD6DjwfAtvYOYZY/m6RhxMADIC9LrI
	 BKTOHtewBhaJ9IXTu7+efcWa0lrF+9r4C9XxPEBIV51+0gb8NsXG40V9JRVGauhToyLWy
	 iyC4rxCmRUSr5ViX6Ag2bno7XviNRVUhgnyNc1EUYMGGtVOekX68jqQ52+ccriQAS2s3a
	 OfL5fod0JbXDNyMZBHWnC+rfhKCul1y3z/gPuJyi8M4fzXK23O+xGbEP6cxRXaZhvLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c9KZOOlQl6qoBWzMF7UQu9vA138+Dc2lR4A556fdMAU=;
	b=hat086sg3emnfdJFoND7hyv8wNmpeYb6MG/z+9KiGExj78iSTNDk/5AvVTBI44ek4ACN
	 UsYrCW+MwU+Yos/nIhJd6UhzwL2UoWGCTm3eEiRjkNjYe5Y8k4Ow+UIUmOuAA20VypUCa
	 IE1xxdOO3RsFS9lmMazl2yVVHzeJ24COJ+BkBHTvvZVrPnyp94jiZ8pSkhJTXdG3/Zn3v
	 FNfog1vkF49E2Q2BJLrSI8M2WKim3Y908eCnsKPMteYocf2dVYSqBrzBGAfbS4GOLmFJE
	 4pgCXPrmCnb8gOfMOB5A/iccd7J05iH7HoLFBF+bpZ5DdaUWWtUAbPWBHj7Q9TRJjVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vi5ArS3h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28C60A2613;
	Tue, 10 Nov 2026 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vi5ArS3h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78A21F0089F;
	Tue, 10 Nov 2026 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794306052;
	bh=c9KZOOlQl6qoBWzMF7UQu9vA138+Dc2lR4A556fdMAU=;
	h=From:To:Cc:Subject:Date;
	b=Vi5ArS3hrPyQ6GJ8eHeCYKDcck/GroBRyEKTaxyzg46+/y5rTiXWq4DZrUhgxVFYQ
	 UPEDHSJ5j8sJiVUtuYbBBl1pAqGQsrdL3XXnzH3s3Pgqsf2uOBcm3i4BZ+1Hkqkyaz
	 kmahXtM3dVUSDGyDkLsaXUos4pVrTQyFOBBXWVW/MGUwWtAMcG9wSiN/VJ52JTHedK
	 9/L6WRqcvbm9G/dEbAxMwmfudLAfniQmBZ5khb3Yn+iaVODkvfNa4zQx+UOM85KHOP
	 sl+DwLFQWF44s9m1cw8ovNwNiGCkD3f9DXocFJrNlVU6kXpSvXpU3gMJnH3HJlM3vR
	 xbrOAWFGLmBYg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stuart Clark <stuclar@meta.com>
Subject: [PATCH net-next v1 00/11] xsk: Zero copy through page-pool memory providers
Date: Tue, 10 Nov 2026 11:20:21 +0100
Message-ID: <20261110102039.1002605-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Hi!

AF_XDP zero copy needs a second RX allocator in every driver. This
series makes UMEM a page-pool memory provider instead: a page_pool
driver opts in, and keeps its refill, recycling and DMA sync code.
fbnic is the first user. Patches 1-7 are core, 8-11 fbnic.

Since the RFC [RFC], net_iov is a first class netmem, the core owns
AF_XDP setup, and a refill contract replaces the NAPI kicks. The fixes
are out.

Changes since the RFC:

 - A readable net_iov has an address. netmem_address() and
   skb_frag_address() find it through struct net_iov_area, which now
   holds niov_shift. xdp_frag_address() is gone. (Mina, Stanislav)
 - PP_FLAG_ALLOW_UNREADABLE_NETMEM keeps its meaning. A pool takes a
   readable provider only with the new PP_FLAG_MEM_PROVIDER. (Mina)
 - The core installs the provider at bind, through the queue API, as
   for devmem and io_uring. A driver sets
   netdev_queue_mgmt_ops.xsk_page_pool, and checks chunk size,
   headroom and multi-buffer mode in XDP_VALIDATE_XSK_POOL. MTU and
   XDP program changes of a bound device get the same check.
   (Stanislav)
 - No NAPI kicks. Drivers report the end of each refill with
   page_pool_refill_done(), and the core publishes the queue's NAPI
   for provider and socket wakeups, so no ndo_xsk_wakeup. (Mina)
 - Page pools declare the RX buffers they supply, header or payload.
   A per-queue generation tells new pools from old ones in the restart
   check.
 - MP_CAP_RETAIN says whether the stack may keep provider buffers.
   The stack copies the others on XDP_PASS, frame conversion and
   non-XSKMAP redirects. Frame copies are linear, so multi-buffer
   frames to devmap and cpumap are dropped.
 - xdp_buff does not grow. The head netmem and shared info live in
   driver memory, reached through a union with txq.
 - The buffer pool allocates xdp_buff_xsk only for copy mode and
   driver zero copy: 128 bytes less per chunk. (Stanislav)
 - With XDP_USE_NEED_WAKEUP the FILL flag stays set. Setting it only
   when starved races with userspace.
 - fbnic is split in four: XDP redirect, netmem heads and XDP_TX,
   unsplittable buffers, zero copy.
 - The RFC's fixes are out. The fbnic one is upstream, and the skb
   head sizing is Clement's fix [1]. Other fixes found on the way go
   to net separately. (Stanislav, Maciej)

Unchanged: aligned chunks only (4 KiB on fbnic), and generic XDP and
CPUMAP cannot feed a provider socket.

fbnic, one queue, 66-byte packets: XSK RX 21.2 Mpps (17.0 with epoll),
XSK TX 28.9 Mpps, XDP_DROP costs 1.9%, 30 instructions per packet,
against net-next. Tested on fbnic hardware and the fbnic QEMU model.

Still open from the RFC: how should userspace learn the chunk
constraints before bind?

netkit queue leases and bnxt come later.


Björn

[RFC] https://lore.kernel.org/netdev/20261002190018.696925-1-bjorn@kernel.org/
[1] https://lore.kernel.org/bpf/20260629072300.1664622-1-clecigne@google.com/

Björn Töpel (11):
  net: Get skb fragment addresses through netmem
  net: Add memory provider capabilities
  xdp: Copy buffers with restricted lifetime
  xsk: Allocate UMEM chunks through page_pool
  xsk: Install UMEM page pool providers in the core
  page_pool: Coordinate refill with memory providers
  xsk: Deliver provider chunks without copying
  eth: fbnic: Support XDP redirect
  eth: fbnic: Use netmem for RX headers and XDP_TX
  eth: fbnic: Support RX buffers it cannot split
  eth: fbnic: Support AF_XDP page pool zero copy

 Documentation/networking/af_xdp.rst           |  64 +-
 Documentation/networking/netmem.rst           |  15 +
 Documentation/networking/xsk-tx-metadata.rst  |   3 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  22 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 601 ++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  28 +
 drivers/net/netkit.c                          |   3 +-
 include/linux/netdevice.h                     |   8 +
 include/linux/skbuff.h                        |  22 +-
 include/net/netdev_queues.h                   |  12 +
 include/net/netdev_rx_queue.h                 |   8 +
 include/net/netmem.h                          |  41 +-
 include/net/page_pool/helpers.h               |  38 +-
 include/net/page_pool/memory_provider.h       |  21 +
 include/net/page_pool/types.h                 |  33 +-
 include/net/xdp.h                             |  94 ++-
 include/net/xdp_sock.h                        |   4 +
 include/net/xdp_sock_drv.h                    |  45 ++
 include/net/xsk_buff_pool.h                   |   3 +
 io_uring/zcrx.c                               |   2 +
 net/core/dev.c                                |  30 +-
 net/core/dev.h                                |   8 +
 net/core/devmem.c                             |   9 +-
 net/core/devmem.h                             |   4 +-
 net/core/filter.c                             |  20 +-
 net/core/netdev_config.c                      |   2 +
 net/core/netdev_rx_queue.c                    | 143 +++-
 net/core/page_pool.c                          | 100 ++-
 net/core/page_pool_user.c                     |  25 +-
 net/core/xdp.c                                |  78 +-
 net/ethtool/rings.c                           |   7 +-
 net/xdp/Kconfig                               |   1 +
 net/xdp/Makefile                              |   2 +-
 net/xdp/xsk.c                                 |  86 ++-
 net/xdp/xsk.h                                 |  15 +
 net/xdp/xsk_buff_pool.c                       |  72 +-
 net/xdp/xsk_pp.c                              | 697 ++++++++++++++++++
 net/xdp/xsk_queue.h                           |  18 +-
 38 files changed, 2159 insertions(+), 225 deletions(-)
 create mode 100644 net/xdp/xsk_pp.c


base-commit: 2d916a8c307c31b433318509bf0311d52d509f09
-- 
2.56.0

