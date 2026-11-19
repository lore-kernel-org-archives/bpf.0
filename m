Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052352;
	b=pC4HMAAFf1RqiEVr6FWWNocKhmIJRX76AGjdlbBsUg9Vstm9Nmv6wwsU3uqCI7D7FdJv
	 9CVHq79uaYQ3pF8qUpaYySp9vaTq9vzNxg4So57lm/qgaW96Y36F5snOckBQOmX9rIE27
	 OMGF2cVl+RbBoe7bN5dfc8yrtt7VfFnqgusLpZKfuVsLPkTNl++T6xkJnLRQDwHx9MOmR
	 h2ZdvVMUd8xSp6jSyzcJ24UudCZKkN6kmx4YDh8pjS7+d8yVXRrsumO8o5D7dmVmAaGNY
	 0mLSmJgg1krWFPhjoY2SACj4QJsugCE6zHBmRLdvKxqEP1gYiNE3fB9uM9s2c/HbRhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iBPC28pXNUc65LCOCKjuf1PqILruKyYBZIqYbx1Wulw=;
	b=ET1OsLqZPjBz5V+aZCck7UgsOh1zaPWNX32RhZ6ld88vOwnCzJ1vUYl4ilpGsyafyZuU
	 bx4fx5uePlcdGKzp4Q4Mn+NceSp/kAu4PZk2fbfdV4NMOuLsgXq9fHz7HnHoSeEGTnDkt
	 26kVRX7hHZU0pURO8p49Wy8QEhquuHr3YfO671wGxroZhmPszis7FsiyBCoLZiLqBM1VX
	 9LU3C8BHj9O81jVvJyLwHMhD7JNtrky1Nqbr0chxHVq7IUiGoYtwZR7wgKhjIGgVsrzTg
	 ymAiOVXbkRtK6lyv68pt3DrDvOySx8aXWaROk0fjlbB/35MRwzsDv+MNsSlqo5e6dZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MqbRm099;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228DC60A2622
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228DC60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MqbRm099
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso291703166b.3
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795052351; x=1795657151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBPC28pXNUc65LCOCKjuf1PqILruKyYBZIqYbx1Wulw=;
        b=MqbRm099WN/Cr7Dh4cVNZTyBKEIODRpZuiVj4miyHNlNXt7w87E9NnSDF/KI+KmnO4
         SWUxi+nalK1M9EEvGQy4XUiRNrP1TTxeWMavR2HtOoUo7geQHGgKEr3zB7f25OOWouRX
         AgNhTLOgRc7ygt8yLIoJpwucARceJcn1hjwoWDK2winZ30ockidP6knzrnYOTu/ZyZRP
         5u4KMTUh/YQTFu/WomnjY2nU4pxE964HIw3foRzZZQwdDww55a2q8gINydUxJcBFCvCq
         dRTnQ0zYQv2pkEqeTDqJLbCHOswflRuae8/r8NRRAJ15Pr2ak3iyrhxzQ0vv8KlcN9Ym
         ozoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052351; x=1795657151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBPC28pXNUc65LCOCKjuf1PqILruKyYBZIqYbx1Wulw=;
        b=tYDsBRjRPPe5mTf2vNYfit2xOp1FuqOQy0Vz9w8ChkOSFtxW9KpRKh/h13yQkHn4SG
         buffvg7otvoNdsUjcZSGYPvGaEXg7C7oVEli8EpAswkW8ZZOSBuCpAkIUu9CVuEjyrRW
         lpdKd6RWx/Kwy1soNlff0xGIc4TNOn+SleHFkVGqcrd+3h3xxfUipqID5MV8zatzhlTm
         GpRgLXdpBnX4zUwfGraH5U1nlYnM+VPO9M+KKRjJU0FW7MTL8aVbbeWvDRXUkkYuu5XG
         6PuUao40l6OIX0sB0reb+B1IYVwWJL5BneRd4v94XSbwJ5dJUCk3fkkMbkPfijJXEbMV
         nZhg==
X-Forwarded-Encrypted: i=1; AL+hErG/g7B0NavpmU52lPQ3m6fg2OvB8fo1B/8uh5OdjMgjLh490JG9qDmsB6pGLSE8thmRQkU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kg/yXvA0o65HIDv/1BLrFZfKY9VFsisieVO3rHJswvx4U/zCQ
	TM4ljk5CraJB9rrIbjyi+g/eNVgNk6ljy9vld9UOkTSMOrNEfVU2kBFEpiRiVRyakkQ=
X-Gm-Gg: AYBFou1mrBpz95ZhWZP5/Ycu3pfd2M29BtQCvd26QOJUKVonibWgx2PIQ8cSMDqRVpH
	OWUdlyzPBVAt1/u/u6K2alwYWwXzJInDxEGU8TFTYTUOCcG0PF9VlP714eAP4TO+jjiwnsuzlPZ
	2ZxktreY4CjVleW4IrTBMerupD9gNdaT8lXLmV4fowsywhKqD17vtww78kKktTWjPFA00fbHxLK
	WehjywUtu4jPzYYNPRxZnxYZbU6wREudEcP+GYvGV/aYNFGWDnQGb9+EUXH8PACiumusyi5JFyS
	WfKvlxWgPQoaHEjOhvtX2Rrx1OnvMSlhHv9tWMC+tshW+QW9WE2PcA7Lx9eYZ3DXzpUWi8owO6r
	1m5SqMHkRutDx1myzwxr9KtauDQAfWOs09AceV5z4tx4mpX1Vb/kO4uo1Tszkf46lZjRbHzUUNA
	Ty0uBhYA2sgR0bLLlVhwzVElpXS0qAB9CqWbhSsxAGJl5MWuAetNpt5jrwA7kG5Kv5VHBXMC6kM
	AfRIb5+AhZdD1qEn7cvqSkAtwoW2xJkHDkRRozdNcJkBpXqDPauCYZRkCLYY7oseZNW6Zs3wOYY
	EZinKEV13NIyoTAwz2MDxIMR3qQmNkukZzEy9KZ2xC9v+dXCN2yhhv30XA==
X-Received: by 2002:a17:907:9304:b0:c46:7462:6332 with SMTP id a640c23a62f3a-c510e4f9809mr385723066b.37.1795052350681;
        Wed, 18 Nov 2026 17:39:10 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51233c4080sm59785966b.16.2026.11.18.17.39.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 17:39:10 -0800 (PST)
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
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 11/11] selftests: net: tx_extra_headroom: test the veth attribute
Date: Thu, 19 Nov 2026 01:38:30 +0000
Message-ID: <20261119013830.36935-12-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119013830.36935-1-tianyi@cloudflare.com>
References: <20261119013830.36935-1-tianyi@cloudflare.com>
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
report 64, and that tx_extra_headroom of the sending end is 64. With XDP
on the peer it is 64 + 256, because the two values are added. Also check
that a value above 512 is rejected.

The helpers leave the RtnlFamily socket to garbage collection, as
link_netns.py does.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v2:
- Test VETH_INFO_TX_EXTRA_HEADROOM with YNL only (Jakub). The IFLA
  tests of v1 4/8 are gone, so the patch no longer carries
  David Keogh's sign-off.
- Drop the VLAN case of v1 4/8. In v2 no code copies
  tx_extra_headroom to a stacked device.
---
 .../selftests/net/tx_extra_headroom.py        | 61 +++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
index 122a1a1b5ca9..a4e4195179fa 100755
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
 
@@ -353,6 +380,30 @@ def test_tag_max() -> None:
     ksft_eq(bss["tx_extra_headroom"], TX_EXTRA_HEADROOM_MAX)
 
 
+def test_veth_info() -> None:
+    """Check that VETH_INFO_TX_EXTRA_HEADROOM adds to tx_extra_headroom."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns, tx_extra_headroom=64)
+        ksft_eq(_veth_tx_extra_headroom("veth0"), 64)
+        with NetNSEnter(str(peer_ns)):
+            ksft_eq(_veth_tx_extra_headroom("veth1"), 64)
+        map_id = _load_progs()
+        _attach_tcx("veth0", "egress", "record")
+        _send_udp4()
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
     ksft_run([test_peer_xdp,
@@ -365,7 +416,9 @@ def main() -> None:
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

