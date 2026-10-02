Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8973E3C4F;
	Fri,  2 Oct 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967753; cv=none; b=KKiPFm8a988J6S6Cvdb+qWaotz2lZcpDmV6DfHA4mt0fJzHp9eawm0aM3TU42pehK0ktCAc0C9NlZn49phW5tv7IQpAffH4Z39QXTzBAR8zxRlez0NFRQ6QLDCpyBRadZ/aw28g2D/q2fnaoclsuppcnnNlgl5WhxZiwgRFZov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967753; c=relaxed/simple;
	bh=ep0gakqrWUNOkDkSCuiUiDCh8YBSa3WIuNLOuzbb0eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEP1cvJPeWVJ6l8BfKH5tnXMUm3KGOXVNN3g5eH6XaCEN3W4OKumsotqwUCOyv/+qGwCClelvTNIrvo/l44jjRj+ARJvEnfCzRQaKT095JW0tu3VVPDM8WU7seL3nRqmUsx6QbUVOOlS5xakv+hSXyjT6weUQ4EjRjcXHPPZ1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3kj6oe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3kj6oe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DBC1F000FF;
	Fri,  2 Oct 2026 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790967751;
	bh=iWcGFdgC9LNjco2uUW50o8hYtbySo0I9amNBjcQMnVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G3kj6oe3pXTypo/UOJ2V189bhrPf0OTBYsxFQl3s+s7E0Cw/SK28rEAJwfLnhcAUW
	 lHUJC0C1TONRC1VQCkQHKjyVYLPgW+YKFKcRfb9/hAOL/JbyGahyqjSTnVAusUUsqH
	 ZasMgwU5nNz2BzzHl0OkmCAs0JfVwq7KyLRtXatK4bFKphiUymCKObjq0vf5tRB8Ut
	 38nBMPUNGqjfbaUicOCSIOxgOCmQwIcID7fe5JbTwAPEibzMpt1GbUjwjx8pAMvq6u
	 5VOMh8R2wXrOIXiDVl3GwxxtrLMVPXZM+8r+yTz8Fpqml7fo2esOXn9XWW/I+2Aq4w
	 S+fb1D9vbibdw==
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
Subject: [RFC net-next 15/15] Documentation: xsk: Document page-pool zero copy
Date: Fri,  2 Oct 2026 21:00:16 +0200
Message-ID: <20261002190018.696925-16-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002190018.696925-1-bjorn@kernel.org>
References: <20261002190018.696925-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe AF_XDP zero copy on page-pool drivers: the aligned 4 KiB
UMEM requirement, how the headroom reaches the driver through the
queue configuration, the device-chosen offset in fragment
descriptors, the scatter-gather layout, buffer ownership, provider
locking, and the order in which a driver enables it.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 Documentation/networking/af_xdp.rst | 65 +++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index cc3f0d16b28f..bdf4029aedeb 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -346,6 +346,71 @@ Note that a UMEM can be shared between sockets on the same queue id
 and device, as well as between queues on the same device and between
 devices at the same time.
 
+Page-pool backed zero-copy
+--------------------------
+
+Drivers which use the queue management API can obtain UMEM frames through a
+page-pool memory provider. This is selected by the driver when zero-copy mode
+is requested and does not require a new userspace flag. The FILL ring remains
+the source of receive buffers and all normal AF_XDP ownership rules apply.
+Once installed, the driver remains an ordinary page-pool consumer: allocation,
+DMA synchronization, recycling, release, and refill use the normal page-pool
+interfaces, while provider callbacks hide the UMEM-specific operations.
+
+The initial provider requires 4 KiB base pages and aligned 4 KiB chunks.
+Unaligned chunks are rejected. Configured UMEM headroom is supported. The
+provider requests it through the queue configuration, and the driver includes
+it in the receive DMA offset; with multi-buffer packets it applies to the first
+descriptor as described below.
+
+Like the normal XSK buffer allocator, provider-backed page-pool allocation and
+recycling run in the receive queue's NAPI context. A queue restart prepares
+its replacement before it stops the current queue, so two page pools can use
+one provider for a short time. A provider lock serializes FILL-ring
+consumption and the provider's buffer stack. It is taken once per page-pool
+refill of up to 64 buffers, not per packet. Generic XDP cannot redirect to a
+provider-backed socket; its copy-mode receive path retains the existing XSK
+receive lock.
+
+UMEM frames retain the direct XSK ownership model. The provider does not add a
+per-frame reference count, generation, ownership bitmap, or quarantine state.
+A frame moves between the FILL ring, the owning NAPI context, and userspace;
+userspace must not publish a frame which it does not own. Page-pool teardown
+accounting protects the lifetime of the pool, not ownership of an individual
+UMEM frame.
+
+Provider-backed buffers do not leave that context as kernel-owned memory.
+``XDP_PASS`` copies the packet to kernel-backed skb storage before returning
+the UMEM buffers. Redirects other than a compatible XSKMAP target likewise
+copy to kernel memory. A compatible XSKMAP transfer publishes the UMEM
+descriptors directly to userspace; returning them through the FILL ring makes
+them available to the same queue context again.
+
+For multi-buffer packets, fragment descriptors are assembled in transient
+kernel-owned storage belonging to the RX queue. They are never stored in the
+user-writable UMEM, and are consumed before the NAPI context starts the next
+packet.
+
+The copy on ``XDP_PASS`` is intentional: an skb may outlive the receive NAPI
+poll, whereas a provider frame must be returned by the context which allocated
+it. Applications which expect most packets to pass to the network stack should
+therefore account for this copy when choosing page-pool backed zero-copy.
+
+Drivers may impose additional layout and queue requirements. The initial fbnic
+support accepts configured UMEM headroom from 0 through 256 bytes in 128-byte
+increments (up to 512 bytes including ``XDP_PACKET_HEADROOM``).
+Packets larger than its selected header-data-split threshold require an
+``XDP_USE_SG`` socket and an XDP program with fragment support. Their
+continuation descriptors start at offsets chosen by the device.
+When these restrictions are not met, a bind forced with ``XDP_ZEROCOPY``
+fails with an error; automatic mode may fall back to copy mode.
+
+On a running device, installing or removing the provider restarts the
+selected hardware queue.
+Applications should populate the FILL ring before binding when possible. If
+the ring is empty, the kernel schedules the queue once after installation;
+the usual ``XDP_USE_NEED_WAKEUP`` rules apply after that.
+
 XDP_USE_NEED_WAKEUP bind flag
 -----------------------------
 
-- 
2.55.0

