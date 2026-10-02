Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE6223328;
	Fri,  2 Oct 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967634; cv=none; b=j8wrQ2B2Qr8rDztEHn+RPxt01QwHSTDB4JCkRBnCutA2rsadIt7px0iwOJs0F39M9Fa13cmRKOLKguFHfJOEZXdEIztqSQDASDg87TTBmJ5GfcM9+rkScUb7QTWNdB5kR1D0I/nUB+Z6+c/cL59G4RlTI5oliyiF3F/Kj9vUxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967634; c=relaxed/simple;
	bh=PEbJLvy7CrYN1hf9iYQ+ysoXfJ8bNcfDcQxuv4rB2lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yz3XI57f7p8zsGrD+Xu4G9CxjXyrvCkOeyrZL3yffQBSQqQD2zsOStEepnsC/KE8m2fM4Ivneilp5vs1+n3PvnfaQeBrKogXLc/3wng2f9ygHHTkXlQyolhGuazbENL29u44eD9Krwnge99krZb+autawRW+aTil1dqJw6ppxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxZ782g1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxZ782g1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01321F000FF;
	Fri,  2 Oct 2026 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967633;
	bh=Gcl/f7moFApWo3jqJXdkRteP30YDcjxwYvzQVuzmbj4=;
	h=From:To:Cc:Subject:Date;
	b=YxZ782g1CNQTsuUl9y3aigokBAb+oTzvb60oKfr9yAjE4mX7SFOmKq4MYxZOh4e9W
	 XVf9EzYxllCIsiSKqGctvl7kBgkFuey+xsOpzy8vcO2ibO5m32HmdT1M7R35jJR37e
	 w/Oba24+G+rSeVoESdLh8XsIgozwQGiTYb7a3E7XHNcrgDK5cylrWnpTOecgeJwP/P
	 DwgeQ/q6eTHXaXu5LJ+NHeeDtRtY8ub0BgB9Y099dw80D7KyPUdlslLBl8D+wsedPa
	 g1Kl5Y0wZrVCd9VkUdwRQibtxtJty4wK/t+s1I2SthgksK+ehtF+s2OquVE/eaOM9k
	 Zt4/aq5PlJlIw==
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
	io-uring@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC net-next 00/15] xsk: Zero copy through page-pool memory providers
Date: Fri,  2 Oct 2026 21:00:01 +0200
Message-ID: <20261002190018.696925-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Here's an RFC for you all to enjoy with your favorite Friday
$BEVERAGE.

AF_XDP zero copy needs a second receive allocator in every driver.
The driver takes xdp_buff_xsk objects from the XSK buffer pool beside
its page_pool path and owns their lifetime. Drivers built around
page_pool and the queue management API, which already support devmem
and io_uring zero-copy receive, have to duplicate their receive path.

This series makes UMEM a page-pool memory provider instead. Each
aligned 4 KiB chunk is a NET_IOV_XSK net_iov. Binding a zero-copy
socket installs the provider on the queue through the queue
management API. The driver keeps its page_pool allocation, DMA sync,
recycling and refill code. The provider consumes FILL, drops invalid
and repeated addresses, and owns RX need-wakeup.

An XSKMAP redirect publishes the UMEM address when every buffer of the
frame belongs to the socket's provider. XDP_PASS and other redirect
targets copy into page-backed memory first. TX is unchanged; drivers
read socket TX descriptors directly.

Core changes:

 - MP_CAP_READABLE and MP_CAP_FRAG. A readable provider may back
   header and regular pools, and XDP may run on its buffers. devmem
   and io_uring set MP_CAP_FRAG and keep their behavior.
 - Providers request RX headroom through the queue configuration.
 - Readable net_iov areas. netmem_address() resolves provider memory
   with a load and a shift, without an indirect call.
 - A refill-completion callback. The XSK provider keeps NAPI scheduled
   while FILL has entries, and sets NEED_WAKEUP when FILL is empty.
 - Batched page-pool release for objects handed to userspace.
 - xdp_buff carries the netmem and a pointer to kernel-owned shared
   info, so fragment metadata never lives in user-writable UMEM. It
   grows from 56 to 64 bytes on 64-bit.

Differences from classic zero copy:

 - 4 KiB pages and aligned 4 KiB chunks only. Other layouts fail to
   bind with -EOPNOTSUPP, but can be supported in the future.
 - Generic XDP and CPUMAP cannot deliver to a provider-backed socket.

Classic zero copy is unchanged. This does not propose converting
existing drivers; it is for page_pool drivers without zero copy.

fbnic is the only driver user, +640/-122 for RX and TX. I have bnxt
working with AF_XDP, plus some performance patches/fixes for the
AF_XDP core on top of this -- but let's start with these patches.

Patches 1-2 fix bugs in net-next that the series hits. They are
carried here so the series can be tested on its own.

 1. "xdp: Size zero-copy skb heads by their contents". XDP_PASS of a
    zero-copy buffer copies it into an skb whose head is sized by the
    XSK frame size, which leaves no room for skb_shared_info. A frame
    that fills its buffer overwrites skb_shared_info. Provider
    buffers take this path on XDP_PASS, which the usual AF_XDP
    program returns when no socket is bound to the queue. Reproduced
    on fbnic in QEMU.

 2. "eth: fbnic: Report the logical XDP RX queue". fbnic reports
    queue 0 in rx_queue_index for every queue. AF_XDP drops frames
    whose queue differs from the socket's, and the usual program
    looks up its socket by that index, so zero copy works on queue 0
    only.

Feedback wanted on:

 0. General thoughts on extending the page pool provider.
 1. Does refill_done belong in page_pool, or should finite providers
    keep NAPI scheduled some other way?
 2. PP_FLAG_ALLOW_UNREADABLE_NETMEM is how a pool picks up any
    provider, readable or not. A driver that only wants AF_XDP must
    set it, and then passes the core checks for devmem and io_uring
    too if it supports header split. Drivers that set the flag today
    may also split buffers, for example mlx5 through
    page_pool_fragment_netmem(). Only QCFG_RX_HEADROOM keeps the
    unsplittable XSK provider away from them. Split the flag, or let
    drivers declare support for unsplittable providers?
 3. Is growing xdp_buff by 8 bytes acceptable?
 4. How should userspace learn the chunk constraints before bind?

This is a way to move code from the drivers to the core, reducing the
work for driver developers.

I hope to see you at LPC next week! Particular the netdev and bpf MC,
and the AF_XDP BoF on Monday.


Björn

Björn Töpel (15):
  xdp: Size zero-copy skb heads by their contents
  eth: fbnic: Report the logical XDP RX queue
  net: Add memory provider capabilities
  net: Let memory providers set RX buffer headroom
  page_pool: Extend memory provider operations
  xdp: Track non-page netmem in receive buffers
  xsk: Keep the DMA mapping in the buffer pool
  xsk: Handle a detached FILL ring in RX wakeup
  xsk: Add a page-pool memory provider for UMEM
  xsk: Add RX helpers for page-pool drivers
  xdp: Copy provider buffers on pass and redirect
  xsk: Receive provider UMEM without copying
  eth: fbnic: Support AF_XDP zero-copy receive
  eth: fbnic: Support AF_XDP zero-copy transmit
  Documentation: xsk: Document page-pool zero copy

 Documentation/networking/af_xdp.rst           |  65 ++
 Documentation/networking/netmem.rst           |   7 +-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 164 ++++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 561 ++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  24 +
 include/net/netdev_queues.h                   |   6 +
 include/net/netmem.h                          |  32 +-
 include/net/page_pool/helpers.h               |  62 +-
 include/net/page_pool/memory_provider.h       |  39 +-
 include/net/page_pool/types.h                 |   8 +-
 include/net/xdp.h                             |  64 +-
 include/net/xdp_sock.h                        |  10 +
 include/net/xdp_sock_drv.h                    |  58 +-
 include/net/xsk_buff_pool.h                   |   7 +-
 io_uring/zcrx.c                               |   4 +-
 net/core/dev.c                                |   4 +-
 net/core/dev.h                                |   5 +
 net/core/devmem.c                             |   7 +-
 net/core/filter.c                             |  28 +-
 net/core/netdev_config.c                      |   2 +
 net/core/netdev_rx_queue.c                    |  61 +-
 net/core/page_pool.c                          |  72 +-
 net/core/xdp.c                                | 112 ++-
 net/ethtool/rings.c                           |  18 +-
 net/xdp/Kconfig                               |   1 +
 net/xdp/xsk.c                                 | 253 ++++++-
 net/xdp/xsk.h                                 |  58 ++
 net/xdp/xsk_buff_pool.c                       | 667 +++++++++++++++++-
 30 files changed, 2164 insertions(+), 244 deletions(-)


base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
-- 
2.55.0

