Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934037;
	b=ptOxKPinqeyYJ1n81UZMEAYzV1gSv9Ijw8GqfzJJiaeH0StQphf3es1GcSn9Nj6T7bvk
	 gCnaw/CzrHLIRpVOtfoYMyu62Nt5lCV3pzpBkTzzxM1gZtA/SoqKfe+OKiWcphd/zy23d
	 AcNJ/BsN5VannXci95mrKqdqXiIMDuNKQwSmNQtpRHxy8K+zZ4lJ/y0XEZ3Dd880RcoLp
	 meUAVT/S+aQFp9tJ0cx+JCJEjlYZmIanQyKyNzu/mUdMcswfCC6tj1+DKYZRwcIyKc1bl
	 pOWuhCwFSQCnIbaXDkfNBSDJ8bLghFGqy82aJkTj3MQdfB3Fd4e/6DSHoXCmBqVaolg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Fco+UlnINs31RhLyhKfNSsZubf2jNgBWY6vfGvE0k4A=;
	b=e7zn3sEuiXisjbm5ozvwOtReeUigBYanjxC55AbhrJA1YsmdtZESClwTdE0EAlKZSpIi
	 f+UF7qDyH+DkQP376/zIVHZ5o6wgTWpCbKxMHj/qugEuMCllxbhkR82doJa4GO2Oq/5Zs
	 hwXo3V9Te9DLSl++ffbbUNIGIGxFdxKCirEUw+pCwctqZ9VTrAXSptzlPX0BZygO4YydO
	 vUfKfG4voe/tmBDINy84V8zjHV3ImCi4UVVySexKyHAZQM11fCFQ/gRcBNKP/Oq0TbMjj
	 0uKFUpeIwDyiUzlsYw9q3x0CwrvqAEL0Cw8Yizn1UJCh52mbWQnrtLCezXOKE6buKMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDPwpT4H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E223606A889;
	Tue, 17 Nov 2026 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDPwpT4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0541F000C5;
	Tue, 17 Nov 2026 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934036;
	bh=Fco+UlnINs31RhLyhKfNSsZubf2jNgBWY6vfGvE0k4A=;
	h=From:To:Cc:Subject:Date;
	b=iDPwpT4HdexXsiGZ4nqwW9ju6XomdL9Mw3q2pwnUf3nGxM5O4Tv2DqZO4tmlmEaky
	 gQxkzAocgG1wTOARZLMae7SolEpZ4NV2F4bf73cN07EAeIvWbwidolW6/gk4BVgmbZ
	 66KCxVsQJYoaTz8GqfyMWu/przkFfgCIdiz99eDosesQ+Sz9DFh6IbnOLk3y+aJhxe
	 EmZdZC9K5Ixc35fHjPlGDBqsyY4g16Foc4tw++GdO4H7aSQfQcC6gcucJqy8RwIJBF
	 00SL4BEcgYQvBMAVfG1i4EIIQSmbaRIjvEI8H6XfpS3+bff9pHdrU7rd0zOwU0dZep
	 1n2Dod1G6s7dA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 0/7] XDP with io_uring zero-copy RX and devmem
Date: Tue, 17 Nov 2026 17:46:51 +0100
Message-ID: <20261117164700.2157816-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
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

I had a long chat on page-pool providers with Magnus and Maciej
earlier this week, and the topic of "XDP on unreadable providers" came
up. Magnus suggested building on the xdp.frags mode, to support this.

Here goes...

Devmem and io_uring zero-copy RX place packet payload in memory that the
kernel cannot read through the normal packet APIs. Header split keeps
the headers in ordinary kernel memory. Today, the core rejects XDP and
these memory providers on the same device, in either attach order.

A program that checks headers should not need to copy the payload or
turn off zero-copy receive. Keep the payload in fragments and run a
native XDP program with frags support. Frags support means that the
program accepts a packet whose data_end does not cover the whole
packet. It does not give the program permission to read provider data.

Kuba added XDP_FLAGS_FRAGS_UNREADABLE, which already records this kind
of payload. xdp_buff_add_frag() sets it for net_iov fragments, and skb
construction copies it to skb->unreadable. Drivers use this path even
without an XDP program. The series uses the same flag to stop helpers
from reading or writing provider fragments. Header access still works.

XDP_PASS keeps the payload for the normal receive path. XDP_DROP frees
it without reading it. Frame redirects and AF_XDP copies reject a
buffer while the flag is set. The driver must also reject XDP_TX:
provider payload is mapped for receive, not transmit. Tail trimming
can remove the payload without reading it; after the last fragment is
removed, the remaining header buffer has no unreadable fragments.

Only drivers that declare xdp_unreadable support accept the combination.
fbnic is the real driver in this series. Its XDP_TX path drops packets
while unreadable fragments remain. netdevsim tests the attachment
rules, but it does not test packet access to provider memory.

Generic XDP remains rejected. Its receive path first copies or
linearizes nonlinear skbs, which fails when it reaches provider data.
Even if that step were skipped, skb-to-XDP conversion does not carry
the unreadable flag, and generic transmit and redirect use skb paths
outside the native driver's XDP_TX guard. Supporting generic XDP needs
separate handling; admitting it here would not be enough.


Björn

Björn Töpel (7):
  bpf: Keep XDP helpers within readable data
  xdp: Reject frames with unreadable fragments
  net: Admit native XDP on provider queues
  eth: fbnic: Run XDP on provider queues
  netdevsim: Run native XDP next to devmem
  selftests: net: Test XDP with devmem bindings
  selftests: net: Test XDP on io_uring RX

 Documentation/networking/netmem.rst           |   8 +
 MAINTAINERS                                   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   4 +-
 drivers/net/netdevsim/netdev.c                |   2 +
 include/linux/filter.h                        |   9 +-
 include/net/netdev_queues.h                   |   6 +
 include/net/xdp.h                             |  20 +-
 kernel/bpf/helpers.c                          |   4 +-
 net/core/dev.c                                |  28 +-
 net/core/dev.h                                |   1 +
 net/core/filter.c                             |  37 ++-
 net/core/netdev_rx_queue.c                    |   2 +-
 net/xdp/xsk.c                                 |   5 +
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |  10 +-
 tools/testing/selftests/drivers/net/hw/config |   5 +
 .../selftests/drivers/net/hw/iou-zcrx.c       | 242 +++++++++++++++++-
 .../selftests/drivers/net/hw/iou-zcrx.py      | 108 +++++++-
 .../selftests/drivers/net/hw/iou_zcrx.bpf.c   | 111 ++++++++
 .../selftests/drivers/net/hw/iou_zcrx.h       |  34 +++
 tools/testing/selftests/net/nl_netdev.py      |  54 +++-
 21 files changed, 646 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/iou_zcrx.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/iou_zcrx.h


base-commit: f23dcd8055612eb37c666c67fe0cfe38b3c65021
-- 
2.56.1

