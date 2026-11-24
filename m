Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543160;
	b=04P20S6ziLb1K/qp5DcnG4n1NiRY/g+sZd4+AoamVrxpaXIK3/vY5CK203LDFYFoFe0p
	 Fbwe5nmu4cjZBcHRT991dmbygeiXcunZ+f3M4mGfM5vh4GYr/RAwCmltIFxD1+visnTum
	 6y0oHFhC8FlObuZWt7DtA6FF/xX2cPpRXc8Lpaa4ZU9gW7dn4YxL1jJDB8W6fYH+cCRyO
	 jbgFoxUFPVWB1zi9LtB7nCqPAnNo8ZdvwEI++gf+8sbM6NHCCTo1naW2ZDJnwp3fuxm+J
	 SKiWoJvW3ilpJVs5+IDXJQZphfy6qvpckR4VAlfsWTINqM98zorrR3VXas4+UcTpPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=I6CWNjzytqFO6xp4oK4sRQFEMC8juUinAICNfV+h+aY=;
	b=fAFl/mDh0aU4/Jrt92TtbkUZRMGfIHyTakjiuWXqKbJqNG6YhDnEwzWC0iwwi2t2EL9k
	 pPNCEBCfVqsrgfYhmNXHEE89sYLcVYnFXTsX/wHJLdwu8+MUXgd9KK5Ajoi9WKH3PknNg
	 xvnQc381+TBtblTqsJB0p1uCRDumCtxHJqCoqsh7VGeThdb8fhDVMN8WW5nYELsuOOZe9
	 6zn4K2kH9I5504aBV5D29mKoXZ7zezjJ9Fe3o1sYYITD1Mr2HPpAXgJoW3WNRNYTzpO/i
	 /ThEZ6FP1Xn9YnGtZ+MO00/U1WDkGvG2+I2U/Qx/coUzRRQI8nSJ+54HBhD7j/Z9/8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MyVfoGAW;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF950606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF950606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MyVfoGAW
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6bab10844b5so4276875a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795543157; x=1796147957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6CWNjzytqFO6xp4oK4sRQFEMC8juUinAICNfV+h+aY=;
        b=MyVfoGAWY7pDwibENpp54PQZ96hKrVeRjy87mhXDAdF3gDrDz6byidSoFE3sQJa/Yf
         YKKLOrklKZLngfXuNCvnSyR7wNw6uptr4nxUo7VkxhToUddsrZbdNqAJ+WwZV4ouJTwx
         99jxEB/eMtQn9OX2OsqNNsgenNx0gehCMw+dmn5+X3Md++fMySh0s+Y8vblH0/lzVnhE
         LVzt5JAvFDdhB/GXE0gm4k7fPEKOf0Yr0S1ytytpdUEvePAIqmYmGMfok5ytDu0NH5Yr
         p6aLrtVKZaPkK/sFf5k8g2XqIvYsdqtBCfVObWIubgTtPiPMZURI3Ty7Mesl03IifELI
         6k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543157; x=1796147957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6CWNjzytqFO6xp4oK4sRQFEMC8juUinAICNfV+h+aY=;
        b=lvDNNO2FsFqwyBJd2NmYbeaY2VfPWESRdaPBNJ++r848EBQj/iwfiQkQd2cDGpaKQA
         HMdRQl+XYk7iw2UmPgyZ5udTp2CeVm2igPjMCFy53Vn5MoXsOdGWgcU7iYc/k3Qa8siB
         oUwG0CXfO1LHuX/LS6X+lPoMxZANDHbbOf2b+WwNUj9p6JYkOhkKXj0pkhC9FR6vesVy
         jT/Fvushx8brSxx8mxgsZp87cp3cm2vra0zgf3PWy3mO6swYz2mlNkFv5gmRwXAXtnTx
         HyZJoGMe20+oxXRuT6IE8Bwe4FC80eBzNE7pjhD7YEJxjGhotpai1I9QydY4lYauysuZ
         PxKA==
X-Forwarded-Encrypted: i=1; AL+hErHGTv5XXcZIBfGUinOaLKLcfd7HYz4bceDkzNJo8rcfCYA4VE1t+CCxcHuu2vNGTxyYrpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tZ+PBXUdtdhc29QTii9AuCuaRs3rs9e6P0mTEgBdFAJApKjC/
	Oymuv5wrJyNrYpF/O3ScUVrzDHgYlLHZSOf08Dq8JcvXIlWbwC44eGLbgabRt80Wtds=
X-Gm-Gg: AZFdTZdIfKFsENk4CHGdO8Rnp9k5o5bV685VsV2puw56b78GsIEupHR9JlcZ2z38FB4
	MFgtHFXUtt9p5AOy4GOQSgacf0WCURHb74NFmCHx5kWQuARQmxaQecUwdCFlSM0ChFloeeEn9N3
	nbqLskCGms2KFgLAp4Gst/WkdfO5FKaJ4TxL6rg7BzhmbtN9Xo55ZzK362W1reO6dgyGsMOpXWP
	3PpTcH8KSEa4Mm33yRJ8KbbDcuDt1kEapaTUqG5rRm50iEqc07VTzF6IwBmSPJSQME3HXHOIJ3+
	Metzm2mvq4tU26DnxHfj0w1nLq50u0wRDM7RdlrLDU5OW921nTLi2vNlT8rLaCmV95pBe//UE6Z
	nD/cgKSh0ZbbBqPAJ45Qc3OIpWbkxTXhJl0nFRzJlJ/ltzia5gw7r9p/Ju2uwnXzrHu6Q3hfWkS
	PzDQePlrJ4R48WE0U28XPVGKKiuYfy7lgPQ5HG2HS8j7eI27fnRZh2GtMgiCYbrPN5g+4Jib5KU
	xXZZSFT4GhGDEGciWoR9HLNTGVulmKVuKTlvnwE+mGqJep6/YROvLhuglopxH8MVQEYgTXzpxaP
	QeQEvhFyoj6hnA5PUVhkyhO3pI3zIQb8xZey7+mHc5R/RRQ=
X-Received: by 2002:a05:6402:13d6:b0:6ba:a799:d9bb with SMTP id 4fb4d7f45d1cf-6baa799dc20mr5236322a12.9.1795543157028;
        Tue, 24 Nov 2026 09:59:17 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7205762a12.35.2026.11.24.09.59.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:59:16 -0800 (PST)
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
Subject: [PATCH net-next v3 07/11] selftests: net: tx_extra_headroom: test a push at TC egress
Date: Tue, 24 Nov 2026 17:58:20 +0000
Message-ID: <20261124175824.60470-8-tianyi@cloudflare.com>
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

Add test cases for the "tx_extra_headroom:<bytes>" decl tag on tcx
egress programs.

The new programs in tx_extra_headroom.bpf.c push 20 or 30 bytes after
the MAC header with bpf_skb_adjust_room() and record whether skb->head
changed. A new skb->head means that pskb_expand_head() reallocated the
packet. The record program from the previous patch runs first and
records tx_extra_headroom. The cases check that:

- a push without a tag reallocates and a push with a tag of 20 does not;
- tx_extra_headroom is 20 with the tagged program and 0 after it is
  detached;
- with XDP on the peer, tx_extra_headroom is 256 + 20;
- with tags of 20 and 30, tx_extra_headroom is 50 and neither push
  reallocates;
- with a tag of 512 and XDP on the peer, tx_extra_headroom is 512 and
  not 256 + 512.

The next patch tests the tags that the verifier rejects.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
The push program follows
tools/testing/selftests/bpf/progs/test_dst_clear.c.

Replacing a program with BPF_F_REPLACE or BPF_LINK_UPDATE is not
tested, because bpftool cannot do either.

v2:
- Built from v1 5/8. Attach with tcx and declare the headroom with
  a decl tag, instead of a tc filter and IFLA_TX_EXTRA_HEADROOM.
- Add the detach, peer XDP, two program and maximum cases.
---
 .../selftests/net/tx_extra_headroom.bpf.c     | 59 +++++++++++-
 .../selftests/net/tx_extra_headroom.py        | 92 ++++++++++++++++++-
 2 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/tx_extra_headroom.bpf.c b/tools/testing/selftests/net/tx_extra_headroom.bpf.c
index d80f4567873a..df6cf112af90 100644
--- a/tools/testing/selftests/net/tx_extra_headroom.bpf.c
+++ b/tools/testing/selftests/net/tx_extra_headroom.bpf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Record the headroom fields of a test packet. */
+/* Record the headroom fields of a test packet and push headers onto it. */
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
@@ -12,6 +12,8 @@
 #include <bpf/bpf_helpers.h>
 
 #define UDP_TEST_PORT 9999
+#define PUSH_LEN 20
+#define PUSH_MARK 0x1d
 
 struct net_device {
 	unsigned short needed_headroom;
@@ -20,6 +22,8 @@ struct net_device {
 
 struct sk_buff {
 	struct net_device *dev;
+	unsigned char *head;
+	unsigned char *data;
 	__u8 pp_recycle:1;
 } __attribute__((preserve_access_index));
 
@@ -29,6 +33,9 @@ __u32 count;
 __u32 needed_headroom;
 __u32 tx_extra_headroom;
 bool pp_recycle;
+__u32 pushes;
+__u32 headroom;
+bool reallocated;
 
 static bool is_test_packet(struct __sk_buff *skb)
 {
@@ -78,4 +85,54 @@ int record(struct __sk_buff *skb)
 	return TCX_NEXT;
 }
 
+static int push(struct __sk_buff *skb, int len)
+{
+	struct sk_buff *kskb;
+	unsigned char *head;
+
+	if (skb->mark != PUSH_MARK && !is_test_packet(skb))
+		return TCX_NEXT;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	headroom = kskb->data - kskb->head;
+
+	/* pskb_expand_head() always allocates a new skb->head. */
+	head = kskb->head;
+	if (!bpf_skb_adjust_room(skb, len, BPF_ADJ_ROOM_MAC, 0))
+		pushes++;
+	if (kskb->head != head)
+		reallocated = true;
+
+	/* The next program cannot parse the packet after the push. */
+	skb->mark = PUSH_MARK;
+	return TCX_NEXT;
+}
+
+SEC("tcx/egress")
+int push_untagged(struct __sk_buff *skb)
+{
+	return push(skb, PUSH_LEN);
+}
+
+SEC("tcx/egress")
+__attribute__((btf_decl_tag("tx_extra_headroom:20")))
+int push_tagged(struct __sk_buff *skb)
+{
+	return push(skb, PUSH_LEN);
+}
+
+SEC("tcx/egress")
+__attribute__((btf_decl_tag("tx_extra_headroom:30")))
+int push_tagged_30(struct __sk_buff *skb)
+{
+	return push(skb, 30);
+}
+
+SEC("tcx/egress")
+__attribute__((btf_decl_tag("tx_extra_headroom:512")))
+int tag_max(struct __sk_buff *skb)
+{
+	return TCX_NEXT;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
index 49a61ad17671..02ae509ae8c2 100755
--- a/tools/testing/selftests/net/tx_extra_headroom.py
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -7,7 +7,7 @@ import socket
 import struct
 from pathlib import Path
 
-from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_gt
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_gt
 from lib.py import KsftSkipEx, KsftFailEx
 from lib.py import ksft_busy_wait, ksft_variants, KsftNamedVariant
 from lib.py import cmd, defer, ip, bpftool, bpf_prog_map_ids
@@ -18,8 +18,10 @@ XDP_OBJ = Path(__file__).parent / "lib/xdp_dummy.bpf.o"
 XDP_HELPER = Path(__file__).parent / "lib/xdp_helper"
 PIN_DIR = Path("/sys/fs/bpf/tx_extra_headroom")
 PORT = 9999  # UDP_TEST_PORT in tx_extra_headroom.bpf.c
+PUSH_LEN = 20  # PUSH_LEN in tx_extra_headroom.bpf.c
 ETH_P_ALL = 0x0003
 XDP_PACKET_HEADROOM = 256
+TX_EXTRA_HEADROOM_MAX = 512  # NETDEV_TX_EXTRA_HEADROOM_MAX
 
 
 def _setup_addrs(peer_ns, dev, peer):
@@ -270,6 +272,87 @@ def test_bridge_vxlan() -> None:
             XDP_PACKET_HEADROOM)
 
 
+@ksft_variants([
+    KsftNamedVariant("untagged", "push_untagged", 0, True),
+    KsftNamedVariant("tagged", "push_tagged", PUSH_LEN, False),
+])
+def test_push(prog, tx_extra_headroom, reallocated) -> None:
+    """Check that the tag of a tcx program avoids a reallocation."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        map_id = _load_progs()
+        _attach_tcx("veth0", "egress", "record")
+        _attach_tcx("veth0", "egress", prog)
+        _send_udp4()
+        bss = _read_bss(map_id)
+
+    ksft_eq(bss["pushes"], 1)
+    ksft_eq(bss["tx_extra_headroom"], tx_extra_headroom)
+    ksft_eq(bss["reallocated"], reallocated)
+
+
+def test_push_detach() -> None:
+    """Check that detaching the tagged program clears tx_extra_headroom."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        map_id = _load_progs()
+        _attach_tcx("veth0", "egress", "record")
+        _attach_tcx("veth0", "egress", "push_tagged")
+        _send_udp4()
+        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], PUSH_LEN)
+        # Without a program argument, bpftool detaches the last program.
+        bpftool("net detach tcx_egress dev veth0")
+        _send_udp4()
+        ksft_eq(_read_bss(map_id)["tx_extra_headroom"], 0)
+
+
+def test_push_peer_xdp() -> None:
+    """Check that the tag adds to the headroom for XDP on the peer."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        map_id = _load_progs()
+        _attach_tcx("veth0", "egress", "record")
+        _attach_tcx("veth0", "egress", "push_tagged")
+        _attach_xdp(peer_ns)
+        _send_udp4()
+        bss = _read_bss(map_id)
+
+    ksft_eq(bss["pushes"], 1)
+    ksft_eq(bss["tx_extra_headroom"], XDP_PACKET_HEADROOM + PUSH_LEN)
+    ksft_ge(bss["headroom"] - PUSH_LEN, XDP_PACKET_HEADROOM,
+            "headroom left for XDP after the push")
+
+
+def test_push_two_progs() -> None:
+    """Check that the tags of two tcx programs add up."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        map_id = _load_progs()
+        _attach_tcx("veth0", "egress", "record")
+        _attach_tcx("veth0", "egress", "push_tagged")
+        _attach_tcx("veth0", "egress", "push_tagged_30")
+        _send_udp4()
+        bss = _read_bss(map_id)
+
+    ksft_eq(bss["pushes"], 2)
+    ksft_eq(bss["tx_extra_headroom"], PUSH_LEN + 30)
+    ksft_eq(bss["reallocated"], False, "a push reallocated the head")
+
+
+def test_tag_max() -> None:
+    """Check that the maximum tag is accepted and that the sum is capped."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        map_id = _load_progs()
+        _attach_tcx("veth0", "egress", "record")
+        _attach_tcx("veth0", "egress", "tag_max")
+        _attach_xdp(peer_ns)
+        _send_udp4()
+        bss = _read_bss(map_id)
+
+    ksft_eq(bss["tx_extra_headroom"], TX_EXTRA_HEADROOM_MAX)
+
+
 def main() -> None:
     """Run all test cases."""
     if "/sys/fs/bpf type bpf" not in cmd("mount").stdout:
@@ -279,7 +362,12 @@ def main() -> None:
               test_peer_xdp_netkit,
               test_detach,
               test_bond,
-              test_bridge_vxlan])
+              test_bridge_vxlan,
+              test_push,
+              test_push_detach,
+              test_push_peer_xdp,
+              test_push_two_progs,
+              test_tag_max])
     ksft_exit()
 
 
-- 
2.56.0

