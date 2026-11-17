Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934053;
	b=U/TnqH5KsSt5SAqD3d62Ft/y1YVDU3dQ2lhDmo1gqkUKMsZoA+b52dnIPMcYCMzzM2/v
	 o72qHD/quSVdFpfh5q0KpVo223+W5iSZOH58iqDEHNIkb7DU69O07o8JKie22ChJ3vA9d
	 A2ENmCmFG52EFBvZqMzcE71wYvKVGgl5SDXO3hfErk4QSxqGBe/ypgkpl+B2UBtWXbkcz
	 IjquzIootBgAv6R4a75tj5GgWeXSM53zOXoyCVYirWBC9dyO/8LJemVDhf28tLDqvT78K
	 Nr+Muvh00DKfjhZzsHrjLjk0BVqFDMkX5xo6Yh7EZdl/x5IWl4LOgqWRttCo5jfhnxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eAhPzmXkPGj42IDKPqu4qUZnCioD1z4KT2fXXprwDJg=;
	b=VyrHUbjvX8Dcb/cVTNDXmKqYfb3Kjz/s+R2HEBJeWJhQlWt0h6xOMb3XpJcavdPO5jv8
	 2aDEP9kQ9iAOBWIcrkDZE9DYZKHG3lnnImc1W1rq70H9gFfJCn0zs4sivuxAEW3FTIX7E
	 BaSQ8S6gpIc39RIdFPP7N5e7Vmm3MO1+14qyWSriEfqvPa+8YZEdCwMvJj7XQ7vB5M12d
	 0Ob822yFYm1qNCQfAzBl9U8IiSgI4xeyM0PyM/FjdAGh2DJ1LtAPoEB+dqv7bO4LyRo2V
	 tZubFbli9i+XQkCKYJMne5lbgF0xUsLnlIYWLxinbXty6k8pNcEc2SOL9nUF8afvBmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/iTBNTC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B3606A883;
	Tue, 17 Nov 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/iTBNTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6115E1F000C5;
	Tue, 17 Nov 2026 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934052;
	bh=eAhPzmXkPGj42IDKPqu4qUZnCioD1z4KT2fXXprwDJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S/iTBNTCI44xuDy32KgXZwHS+T2FRx4BtAL/k10gvR7f0NAylOMjcgGKRWeEj2QdI
	 12Yct2y93O/F5M11vwlAeQrgVKRHL4OaxMnaVxIvaD6TAg2LoAPTYauEI5pvkJh2mr
	 iopBQdkDeaf+OKlDh3ejQEFipCPwpfDJi3Yrey9bDHwfI3HT6a3R9Dlp1aBNQgM8Ga
	 jt63WKmg1tkYSL+RVBs09R7aOsvaaSTyjWtActqvgRPi4srDiXQRPGwn/tRM7Y12cn
	 6srN+JmqdQp0kzdwA8hjMlYX+F8OPMiO7vhV3bZsXhRMq8b/vTST1iVZbXSQeSXmJ1
	 /m6SV1mBA5TgQ==
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
Subject: [PATCH net-next 2/7] xdp: Reject frames with unreadable fragments
Date: Tue, 17 Nov 2026 17:46:53 +0100
Message-ID: <20261117164700.2157816-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117164700.2157816-1-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
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

An xdp_frame can be sent to another device, processed on another CPU,
or copied into an AF_XDP socket. These paths do not support provider
fragments that the kernel cannot read or remap for transmit.

Reject conversion of such buffers to xdp_frame and reject AF_XDP
copies. A failed redirect leaves buffer ownership with the driver,
which drops and frees the packet.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 include/net/xdp.h | 3 +++
 net/xdp/xsk.c     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 16693cf9653e..20d173fe163c 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -432,6 +432,9 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 		return -ENOSPC;
 	}
 
+	if (unlikely(xdp_buff_is_frag_unreadable(xdp)))
+		return -EFAULT;
+
 	xdp_frame->data = xdp->data;
 	xdp_frame->len  = xdp->data_end - xdp->data;
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f22f9a2cdbbe..25b95ec19334 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -489,6 +489,11 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 		return xsk_rcv_zc(xs, xdp, len);
 	}
 
+	if (unlikely(xdp_buff_is_frag_unreadable(xdp))) {
+		xs->rx_dropped++;
+		return -EFAULT;
+	}
+
 	err = __xsk_rcv(xs, xdp, len);
 	if (!err)
 		xdp_return_buff(xdp);
-- 
2.56.1

