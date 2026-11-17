Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934085;
	b=nkKwHPUkFEayv391EbO3VzRL9vA2vVu1ER+/Pr+IyqawB9sJrDKjbEvmh+JC0fBXyfSx
	 nanSNkC3oQKJxWcqHUo2sZygjoHsyePNE4ThXh2vjMJRYMu6r1hwNfwgtdEv/0x27WcbM
	 yxVo4F6Sc+McKON/Or3hVj8U62ZXIM5cGigwr3lzzNjGIpgfwdirX6bxni62zg9AGIW6u
	 7A+RdSzdmLnt5BGZ9LHSdzs6nBPDEvP56P8aH6ETD2s+KzNAb1zSiO5oGKPs5mgRLCdNo
	 lgymHfnUgY577VifRigeFHZ4KzGfCHwYDa7FkSJo2EFap9tFwhc22ri3UGRGMsMGsMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VbXKrQKq0kT3v+sZX5j8TvDREdq0v6Q82Hyvv20liuM=;
	b=HJDdLOxhbotenl8KjFV34W3OMSWtgA18Kv/iiZcskSoRxgs4xi1Jk0rdUN60NhagCgay
	 KH/ltmKMoqDa6xsHhzkTr8kEz+oDe+D+EGCmYaJZ40gHfcfvtKmUFvbxDCuTKjar7WC3D
	 o6ukiViM4FrzL77ovx1CbhcJB8NunGXwRN2ULLUWMRZLke9xk9DeKu+s7k79y4OWlNElt
	 OywP3bn2YZGmKKOQxihmEgZV6yEMlJGiMNTrPPMXXSkW3n4QsiiD+L8IaPqOfN4o8z8O9
	 OzCA4q53owd6EffGBsJfa3JQCaFNfD2qwc+81oAYtWbrj7InBUHiwDZD9dHXm4XhfJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I22sDu06;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9D606A884;
	Tue, 17 Nov 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I22sDu06
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB051F000C4;
	Tue, 17 Nov 2026 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934085;
	bh=VbXKrQKq0kT3v+sZX5j8TvDREdq0v6Q82Hyvv20liuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I22sDu06MENQAYlSnRI0soekbX5y5EJHNc+7vuv7N+asRZMX56++sAzcTR7Dv49FX
	 jqvSxopem6/+nDIcfhGgWWq6EawvkxYLnxcl41RdEKKbV2NGUK4cQH9oG+Lk4TfHu1
	 PWepBEfbTh/xdt7Azi42AHHGip2pebSWLFRnockYwh79st2BZjnEcQKF+JvOh8y5oN
	 OxRKKZxEsbOAPmmJ5gBNKYklKYFUbwoZ13QJk5UKqtdR1hnzqV8IcEUhnvDWHLy8ZQ
	 b6UCgv2KqM1G+8TfjdYDngmnQ0Yx5oFwgPLoAmNCI4Tn4c5p6dzaVWUBgcn3qK+2EQ
	 bCSaF8LeyL72g==
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
Subject: [PATCH net-next 6/7] selftests: net: Test XDP with devmem bindings
Date: Tue, 17 Nov 2026 17:46:57 +0100
Message-ID: <20261117164700.2157816-7-bjorn@kernel.org>
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

The XDP and devmem attachment rules must work in either order. A
native program with frags support should coexist with a devmem RX
binding; generic and single-buffer programs must remain rejected.

Test these rules on netdevsim with header split enabled. The test does
not send packets with provider fragments.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 tools/testing/selftests/net/nl_netdev.py | 54 +++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index dd0321c0b463..15326fb66362 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -13,7 +13,8 @@ import struct
 from os import system
 from lib.py import ksft_run, ksft_exit, KsftFailEx, KsftSkipEx
 from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
-from lib.py import EthtoolFamily, NetdevFamily, NetdevSimDev, NlError, defer, ip
+from lib.py import CmdExitFailure, EthtoolFamily, NetdevFamily, NetdevSimDev
+from lib.py import NlError, defer, ip
 
 
 def empty_check(nf) -> None:
@@ -483,6 +484,54 @@ def devmem_bind_tx_unregister_check(_nf) -> None:
     nf_priv.close()
 
 
+def devmem_xdp_check(_nf) -> None:
+    """Native XDP with frags runs next to a devmem binding, in either order."""
+    prog = os.path.join(os.path.dirname(os.path.abspath(__file__)),
+                        "lib", "xdp_dummy.bpf.o")
+    if not os.path.exists(prog):
+        raise KsftSkipEx(f"{prog} is not built")
+
+    dmabuf_fd = _create_udmabuf()
+    defer(os.close, dmabuf_fd)
+    nf_priv = NetdevFamily()
+    defer(nf_priv.close)
+    nsimdev = NetdevSimDev(queue_count=2)
+    defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+    dev = nsim.ifname
+
+    ip(f"link set dev {dev} up")
+    with EthtoolFamily() as ef:
+        ef.rings_set({"header": {"dev-index": nsim.ifindex},
+                      "tcp-data-split": "enabled"})
+
+    # A generic program keeps the provider away
+    ip(f"link set dev {dev} xdpgeneric obj {prog} sec xdp.frags")
+    with ksft_raises(NlError) as cm:
+        nf_priv.bind_rx({"ifindex": nsim.ifindex, "fd": dmabuf_fd,
+                         "queues": [{"id": 1, "type": "rx"}]})
+    ksft_eq(cm.exception.nl_msg.error, -errno.EEXIST)
+    ip(f"link set dev {dev} xdpgeneric off")
+
+    # A native program first, then the provider
+    ip(f"link set dev {dev} xdpdrv obj {prog} sec xdp.frags")
+    _devmem_bind(nf_priv.bind_rx, {
+        "ifindex": nsim.ifindex,
+        "fd": dmabuf_fd,
+        "queues": [{"id": 1, "type": "rx"}],
+    })
+    ip(f"link set dev {dev} xdpdrv off")
+
+    # The provider first: native programs with frags only. Header split
+    # already refuses single-buffer programs.
+    ip(f"link set dev {dev} xdpdrv obj {prog} sec xdp.frags")
+    ip(f"link set dev {dev} xdpdrv off")
+    with ksft_raises(CmdExitFailure):
+        ip(f"link set dev {dev} xdpdrv obj {prog} sec xdp")
+    with ksft_raises(CmdExitFailure):
+        ip(f"link set dev {dev} xdpgeneric obj {prog} sec xdp.frags")
+
+
 def main() -> None:
     """ Ksft boiler plate main """
     nf = NetdevFamily()
@@ -498,7 +547,8 @@ def main() -> None:
               page_pool_ifindex_leak_check,
               page_pool_stats_ifindex_check,
               devmem_bind_rx_unregister_check,
-              devmem_bind_tx_unregister_check
+              devmem_bind_tx_unregister_check,
+              devmem_xdp_check
               ],
              args=(nf, ))
     ksft_exit()
-- 
2.56.1

