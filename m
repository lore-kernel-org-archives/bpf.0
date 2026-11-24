Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543184;
	b=lKL6umxuRVK+BENCW6PaLmMBFSked//lB4JA2g0y42b4paFVG6x71X/mDN9/JXxx+iE6
	 uFb0pyw30NV7SBex051/5d3xXOjqnMEWYCdfZK+clqSoCMxBK08+05MyJgwH/08tC5n+F
	 tWRmNmIAChaatCcBrf4S8oeJR+SVsHQvWwhfMRsM5dWDdrfkem/5pWeZoTg3eet9aPHIh
	 vVHlAU/IMET3rcTLQOCiYifQLqZ70TqSI6CBvafr0LtYD0uk3kao+OyKXvbx/kIk1eCOb
	 Gm0xAoIGCX+I7cmJfzRWOIoB8xqA701e7Jdi73T013L/Ld053hkw0TUn/PcV5fIdXrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Id3aruoTt9p41ov0UzfjZQHi+NKnHu/LyrCozIoZe8o=;
	b=y/mXh+bqnLAyWkkXZKqpo1OkdoNzxfXDe4yWOAIS+kWa6MEOHvJT++k5FXZ1qez6Ykk4
	 AAz2jn1PSGsmcwx5KBlqrInBgLM9iwqJNAkJNli4HueR9RAGmqW9FIe0rUIUnoFPyucRN
	 EA91eSjhoNDtich83gbo96+/JFPx4Gbth8FmYoI57PLQepbr+3HGzpW8v8qKudJdohjMH
	 QFEcVTkZNkKfd9yw+wy3Br+fws8EXCJSw69Od/F+W7L/Oh9mQp039vEXaBRczStHYmtvr
	 yqrCzZeJ+8ogkmV99PORr2Z9GoRe8kixdYUNWLWRdrOuNrsTX4N1lcz0sVsu726qmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QxTcKneD;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F3606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F2F3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QxTcKneD
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so6584108a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795543183; x=1796147983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Id3aruoTt9p41ov0UzfjZQHi+NKnHu/LyrCozIoZe8o=;
        b=QxTcKneDwvtdOC299tZn9xw97835cRZXmaZkQk24rVeZzk4RK3GSF9B7EOMZ3kEhoO
         671efgyHRPVjZXZ+A54xg7e9c4/anntqhSxPrZLviczRUjperlfAkuTQrXzSfptTxs+7
         7nnsfJyBHgRATtpRGt7HLHlIAI0ukVdn7RIgqXLaUXAESe/Zi01SMmzxPMd4lAg1/OLj
         TVinkAgOcMc9w45Z3I2NYyn+pXSMrO65ayYEv7snxF3UkwMl2Nn+VVBNqyNRMDRx6WGP
         QlIOepd0ewcKo9WNI3SVcLfrQxBhViEtlvY+OP+b7CPCx6Esl7eDPIBDfLb7jiwd4ZOJ
         ERrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543183; x=1796147983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Id3aruoTt9p41ov0UzfjZQHi+NKnHu/LyrCozIoZe8o=;
        b=OCcRmehfJ7n05CtqkTiisF0Y3zYU1XR6QM6sUqQ3WHAJMzmg5valPlVP4K5BMRcWjS
         225NknPBos3NwM8+lQrTC3nOSgjm21rDt+Q0BjHJYNOUzPNqkbRpy9hxJLnKi0Wpj8qE
         iS6yvptz5Uu3rezO2rkid47bSV36Y9qlTFeIW/rONO1d/yqo7D90qp2GvYxRB2sQi8Oy
         iO3ZAlV5nT68RTo4P9gpcgA/+FkgUiOS6xyEWWVUuCzwhL73oBv89dWBmrTlgHseApBb
         GvOquw6S5EXLfnBNO9FrJ4/Q5qG1tHr1Y+HKquqryR4PNkmH26CMOyYRwoz4lJppKplm
         HKBA==
X-Forwarded-Encrypted: i=1; AL+hErG6PIMj0rNBctSL1n1FqxE7Tw5bNb87IMhMuoi8Ef1zTl+WdCb4np7dwoB9dUUBA4fsniI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8usBAPqfmUQhFUpPePkC1w0BzgcnSGkbfj1+gkbWujanEo6jeK
	j3SB0yBlLBYt7y30WjFRMZMfvnFI+yKD9pGIKYNgYCbH3Dz3H69Nbl6bTTAiyc8p/Zs=
X-Gm-Gg: AZFdTZfZL8WUV6OowNEHxfC/2XE/pGvX8Zk37gR1SbiEPKYMNm+RBVXnxWAv6CXgk/5
	0CELLqFQmoYtUKoGBXj+ivEgYG5GysdIjJZn6rvkKBPHZPNe7uq32o3elnkcsgeItoVqfkrAZGL
	1rgbJqHhZDJgGL85viI1qDh/ON9sI5DvqS7378R1+wnfMCCb0WYJQ6gllD+qsbQ16Gn9MW4nhjk
	LglE3iVXv70iGr8LwppZtjFUYV6D2RAJT8mzogJsRfc1RN2t2CwKroupFNOCT8Eze6Uk3LEpBxx
	CqoTjn4vGIfTK5AKGx2VhirYB/6tp9b9WVj8BFSmtZADjVrvyHBFjZPLxVylIvxthw+4AGUUSRi
	pHs86e9GPIlkzUciiknBuMcO2P9elspGj3c7VejqbVoPIToa9WibH8moBlRbPf99XL4Qg0cG11B
	rMrPaQST5YBP6z1O+LBnCPEilYvkSYGJln+5PIdaaZ9F9xR1CYwEBEYAyQZ5Ymu2rhVk31QNQji
	H9Jr+2yzzIOlnBmmOa6jaxaFwKtrcMmdP54ffDfW3z6XdnZRqAtSkef5cEhn8Wbkyro/McWKxSR
	xJD6taLYJWzXoT321FCtmQrTyXAkD/N31+WER4HS+QSJRa4=
X-Received: by 2002:a05:6402:13d2:b0:6b7:e902:5e23 with SMTP id 4fb4d7f45d1cf-6ba37ea6d00mr12237778a12.33.1795543182884;
        Tue, 24 Nov 2026 09:59:42 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7205762a12.35.2026.11.24.09.59.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:59:42 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 11/11] selftests: net: tx_extra_headroom: test the veth attribute
Date: Tue, 24 Nov 2026 17:58:24 +0000
Message-ID: <20261124175824.60470-12-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124175824.60470-1-tianyi@cloudflare.com>
References: <20261124175824.60470-1-tianyi@cloudflare.com>
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

Create a veth pair with VETH_INFO_TX_EXTRA_HEADROOM set to 64 bytes
through YNL and move the peer to another netns. Check that both ends
report 64, and that tx_extra_headroom of the peer is 64. The test reads
it at tcx ingress, because an attach at tcx egress would recalculate
the value set at creation. Then check that tx_extra_headroom of the
sending end is 64. With XDP on the peer it is 64 + 256, because the two
values are added. Also check that a value above 512 is rejected.

The helpers leave the RtnlFamily socket to garbage collection, as
link_netns.py does.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v3:
- Check the value set at creation at tcx ingress of the peer (Sashiko).

v2:
- Test VETH_INFO_TX_EXTRA_HEADROOM with YNL only (Jakub). The IFLA
  tests of v1 4/8 are gone, so the patch no longer carries
  David Keogh's sign-off.
- Drop the VLAN case of v1 4/8. In v2 no code copies
  tx_extra_headroom to a stacked device.
---
 .../selftests/net/tx_extra_headroom.py        | 70 +++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
index 02ae509ae8c2..cc33c4fa60bb 100755
--- a/tools/testing/selftests/net/tx_extra_headroom.py
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -3,15 +3,17 @@
 
 """Tests for tx_extra_headroom."""
 
+import errno
 import socket
 import struct
 from pathlib import Path
 
-from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_gt
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_gt, ksft_raises
 from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import ksft_busy_wait, ksft_variants, KsftNamedVariant
 from lib.py import cmd, defer, ip, bpftool, bpf_prog_map_ids
 from lib.py import NetNS, NetNSEnter
+from lib.py import Netlink, NlError, RtnlFamily
 
 BPF_OBJ = Path(__file__).parent / "tx_extra_headroom.bpf.o"
 XDP_OBJ = Path(__file__).parent / "lib/xdp_dummy.bpf.o"
@@ -37,9 +39,34 @@ def _setup_addrs(peer_ns, dev, peer):
         ip(f"neigh replace {addr} lladdr {peer_mac} dev {dev} nud permanent")
 
 
-def _setup_veth(peer_ns):
+def _add_veth(tx_extra_headroom):
+    """Create veth0 and veth1 with VETH_INFO_TX_EXTRA_HEADROOM through YNL."""
+    # Without names, the peer is created first and becomes veth0.
+    rtnl = RtnlFamily()
+    rtnl.newlink(
+        {
+            "linkinfo": {
+                "kind": "veth",
+                "data": {"tx-extra-headroom": tx_extra_headroom},
+            },
+        },
+        flags=[Netlink.NLM_F_CREATE, Netlink.NLM_F_EXCL],
+    )
+
+
+def _veth_tx_extra_headroom(name):
+    """Return VETH_INFO_TX_EXTRA_HEADROOM of veth device name."""
+    rtnl = RtnlFamily()
+    link = rtnl.getlink({"ifname": name})
+    return link["linkinfo"]["data"]["tx-extra-headroom"]
+
+
+def _setup_veth(peer_ns, tx_extra_headroom=None):
     """Create veth0 in the current netns and its peer veth1 in peer_ns."""
-    ip("link add veth0 type veth peer name veth1")
+    if tx_extra_headroom is None:
+        ip("link add veth0 type veth peer name veth1")
+    else:
+        _add_veth(tx_extra_headroom)
     ip(f"link set veth1 netns {peer_ns}")
     _setup_addrs(peer_ns, "veth0", "veth1")
 
@@ -353,6 +380,39 @@ def test_tag_max() -> None:
     ksft_eq(bss["tx_extra_headroom"], TX_EXTRA_HEADROOM_MAX)
 
 
+def test_veth_info() -> None:
+    """Check that VETH_INFO_TX_EXTRA_HEADROOM adds to tx_extra_headroom."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns, tx_extra_headroom=64)
+        ksft_eq(_veth_tx_extra_headroom("veth0"), 64)
+        map_id = _load_progs()
+        # An attach at tcx egress recalculates tx_extra_headroom, so read
+        # the value set at creation at tcx ingress of the peer first.
+        with NetNSEnter(str(peer_ns)):
+            ksft_eq(_veth_tx_extra_headroom("veth1"), 64)
+            _attach_tcx("veth1", "ingress", "record")
+        _send_udp4()
+        ksft_busy_wait(lambda: _read_bss(map_id)["count"] == 1)
+        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], 64)
+        with NetNSEnter(str(peer_ns)):
+            bpftool("net detach tcx_ingress dev veth1")
+        _attach_tcx("veth0", "egress", "record")
+        _send_udp4()
+        ksft_busy_wait(lambda: _read_bss(map_id)["count"] == 2)
+        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], 64)
+        _attach_xdp(peer_ns)
+        _send_udp4()
+        ksft_eq(_read_bss(map_id)["tx_extra_headroom"],
+                64 + XDP_PACKET_HEADROOM)
+
+
+def test_veth_info_above_max() -> None:
+    """Check that a value above the maximum is rejected."""
+    with NetNS() as ns, NetNSEnter(str(ns)), ksft_raises(NlError) as cm:
+        _add_veth(TX_EXTRA_HEADROOM_MAX + 1)
+    ksft_eq(cm.exception.error, errno.ERANGE)
+
+
 def main() -> None:
     """Run all test cases."""
     if "/sys/fs/bpf type bpf" not in cmd("mount").stdout:
@@ -367,7 +427,9 @@ def main() -> None:
               test_push_detach,
               test_push_peer_xdp,
               test_push_two_progs,
-              test_tag_max])
+              test_tag_max,
+              test_veth_info,
+              test_veth_info_above_max])
     ksft_exit()
 
 
-- 
2.56.0

