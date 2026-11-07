Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022494;
	b=MA+M/Vp91UqRlqNWHg9Q80h1ayV3HQ23AX3hEQFf4zKwg7qzicclV3nABVz+MxTpPAJb
	 oXEXGon8do3pqbcGAXUGULXoI6QMPeEaT+kSNCKAi+z+sUDdx5eqzG3mwnPbjlteDJx3n
	 sDIyZm5IeH30CDLU6gWBd1VkBr8WcptHbQ7PZXCyVoIxKwChdIIxrUpa8WN4CDdToYJHu
	 vYjmxQq3azwAFb/dR4UnUjuLsbdWQcVvcNxI2tqovGP7puyodYfuh6DCFS8CJwNZLO3AD
	 YC/cp30QIRCLTEU/BHT26GlSbR30U0toeme/3A8cPZNEdC0D4Q3lXjZCIJ0UynVPiZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=g0aefWhpjurb7bMjicOLTpjMe0gGDF7YtBeBBI1yu6o=;
	b=Kd16HiAZ/SOpB7eDp/opbwbhHjt/r4o4gbgBLtp1b3QdQlMTkKM7kxKXE2zfz3AYdAdw
	 kWEP9cDEf9XEQKH87qxQKuYC/CfhNh3gt4AXWp2yYuGM7Du3IUGtyJW/zlxwFz5nhXQzO
	 4s+VQjirZZxnV6OzH9r3DaHCFWVbc2fnqn54Zm27uGuUKUBJr7SwsiJsWCA20xxmulF/2
	 F/RrPJ45cawBxpD8ASMTS+jX4XEjBZzcA5rhhvh443ZV8xTMuKcqdM8r7RozPPokhz8f3
	 Ip8bIobCV/6yK5mT+0e7J5019m5e/6tQepEjAm+lUMNHcR0WlNY8KXwotjZBUn+TY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=LSiFx2mf;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135DE606D803
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 135DE606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=LSiFx2mf
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2116800a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794022492; x=1794627292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0aefWhpjurb7bMjicOLTpjMe0gGDF7YtBeBBI1yu6o=;
        b=LSiFx2mfJQ4nOUXuxsl9D8mqYj/Wcfgaxk8VC5/okhQ0wM6nl+77v2YGsLENvoAVLT
         9vsA+FjgVzDINSPcqDooyexqF4DqFbI9Wh6rndmsYIZ7uzBY669wGcZBOrft41Sl5/I7
         dSB+np7b7EoasttF1taAonMjiFfJzHt8WMHBBrkTHJuPHKVzn1qkWLVBNN7dUvyDISJ3
         dWMbCcsYQ74Vm2hXUAHwGPRXyrvlVRaTre1i8ekDfXq2G7REC7531UkUXF7oZX+xteaM
         PlNKNcohmy7spcJy/m4vvNbIKV/m8tKBj1cydweXFifVxuvpspJYHbsR6+xfphSyYptS
         YgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022492; x=1794627292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0aefWhpjurb7bMjicOLTpjMe0gGDF7YtBeBBI1yu6o=;
        b=IxIKCL8y76g4NX6r5/8f5NhEau05AAZUIVmISN9RIgTCrmIrb816jnNoues0DhREIv
         3U6s9dOt3Ayecse96nfl90YPpliCA2TyBFnrmtzsfBh7Sju5JTj4j5TZIkDmVW1s03el
         R33S0Lfgw3OEQe3CrIGHZZDS3OJ1hFSaLYULIYrIl/euv5pKveom0GUCuCBlue5buqrb
         AUP3chZtVHVS3MgTaaY/YOfRoS0JALkCLOwzThS5qpqmaRKXqrdsA7D8704OkDA/NGys
         2HzvR9l1nK4D8mkz6pTJtI/QdNkzNUbbnvnYvkonmnJrfPBjpEUtYKMoy8wF0R+Tz4Bk
         ZIMQ==
X-Forwarded-Encrypted: i=1; AKwUvByxToPkFLNe81C1BFV8Ypzbu6ABGvY9aktfKg4GYOufBKp9Q6rCaYxh9hbwcUCU5o14UQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZZC0BFHVPhPE158jSp0B0u3jFqZStNRpEPddymUZexJhLPJ7c
	2yETWnVm/WOuShV/KB7H9AyJxRIHVF6BROCphNOzHZG91EsKW0VI2fEf/+OTV48CRgI=
X-Gm-Gg: AYBFou31TIw0Z1SYlPBgsNBataHawhQ5UlxA+DN/712gp6NefYosvTmuby7wAx5dMOY
	u++L7sGvvqZcRrz0Q/91txUsq8C1kFyrYS0TfIuQtkvw5Q6WJHqzxg1tGqjggmYq53to19GuhNV
	BKpK8FS5RMlynuolMItw0SkW9mWBmzLJT2FozzTRcQk5aPShItNrxCuZRLUaUGl3JuduzwNq9Hl
	+5LGnwF4qTHIjHDqg6RJTOwrs9H9h8YFWUGD3wYhiiOm63kqEnPI4ih2anZ5c5PknMZNB6BQN90
	LkApFM3cr9T1cNdKc6z5ibSRcJ7zYB0UeivbwqU4fgp72kogJk2S5tXt49mjyyexRlLVLXeMj9F
	zAKY1nb+fv6yJx5WTxq5e7CkIARy/4b9yYmto1y0hGQC0nLlMYMvx27C4Bvao5S1qmnYTia0NOU
	RnPA0CXnuD14dj2WkTeZAm8w/FSPyWrsGJk4khTNPPjLcKpr2DXAeWVeV2xWwS9c9BiEMo1Nibi
	ja1mn98F0lHBezpFXIu2zTgphusPLYXWEeXcsqgu3Qnzoamrx82/8daI+S+ehM3p01Tow39GJvd
	3jGwRaqolqrEZpxSDMaMzWSW1myPiVfvKTbzrjwcK2mU32nrRMFZpr+ZSBlB9BRx
X-Received: by 2002:a17:907:6e88:b0:c3f:153a:865f with SMTP id a640c23a62f3a-c4d355a0a05mr333984066b.40.1794022492465;
        Fri, 06 Nov 2026 19:34:52 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562e00dsm121104166b.21.2026.11.06.19.34.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:34:50 -0800 (PST)
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
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 5/8] selftests: net: tx_extra_headroom: test a push at TC egress
Date: Sat,  7 Nov 2026 03:34:24 +0000
Message-ID: <0bd964e34b198dd1b652f604042fdc930eb36993.1794020868.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
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

The tx_extra_headroom test only checks the IFLA_TX_EXTRA_HEADROOM
attribute itself. Add test cases for its effect on UDP over IPv4
packets.

tx_extra_headroom.bpf.c is a TC egress program. It matches the UDP test
packet by destination port and records its headroom. It then pushes 20
bytes after the MAC header with bpf_skb_adjust_room(). It records
whether skb->head changed. A changed skb->head means that
pskb_expand_head() reallocated the packet.

tx_extra_headroom.py is extended to create a veth pair. veth0 sends, and
its peer is in a second netns. The program runs at the TC egress of
veth0. Each case sets tx_extra_headroom on veth0, sends one UDP packet
and checks:

tx_extra_headroom  headroom  push reallocates
0                  2         yes
17                 18        yes
18                 34        no
256                258       no

The headroom is LL_ALLOC_SPACE() minus the 14-byte Ethernet header.
LL_ALLOC_SPACE() aligns to 16 bytes. So the headroom steps from 18 to 34
when tx_extra_headroom goes from 17 to 18. The test checks these exact
values. HH_DATA_MOD and the rounding in LL_RESERVED_SPACE() have not
changed since the beginning of git history (Linux 2.6.12-rc2, 2005).

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
The tc program follows tools/testing/selftests/bpf/progs/test_dst_clear.c.
---
 .../selftests/net/tx_extra_headroom.bpf.c     | 70 ++++++++++++++++++
 .../selftests/net/tx_extra_headroom.py        | 74 ++++++++++++++++++-
 2 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/tx_extra_headroom.bpf.c

diff --git a/tools/testing/selftests/net/tx_extra_headroom.bpf.c b/tools/testing/selftests/net/tx_extra_headroom.bpf.c
new file mode 100644
index 000000000000..e74f44afbe56
--- /dev/null
+++ b/tools/testing/selftests/net/tx_extra_headroom.bpf.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Record the headroom of a test packet and whether a push reallocates it. */
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/pkt_cls.h>
+#include <linux/udp.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#define UDP_TEST_PORT 9999
+#define PUSH_LEN 20
+
+struct sk_buff {
+	unsigned char *head;
+	unsigned char *data;
+} __attribute__((preserve_access_index));
+
+void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
+__u32 count;
+__u32 headroom;
+int err;
+bool reallocated;
+
+static bool is_test_packet(struct __sk_buff *skb)
+{
+	struct udphdr udph;
+	struct iphdr iph;
+
+	if (skb->protocol != bpf_htons(ETH_P_IP))
+		return false;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph, sizeof(iph)))
+		return false;
+
+	if (iph.protocol != IPPROTO_UDP)
+		return false;
+
+	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(iph), &udph,
+			       sizeof(udph)))
+		return false;
+
+	return udph.dest == bpf_htons(UDP_TEST_PORT);
+}
+
+SEC("tc/egress")
+int push(struct __sk_buff *skb)
+{
+	struct sk_buff *kskb;
+	unsigned char *head;
+
+	if (!is_test_packet(skb))
+		return TC_ACT_OK;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	count++;
+	headroom = kskb->data - kskb->head;
+
+	/* pskb_expand_head() always allocates a new skb->head. */
+	head = kskb->head;
+	err = bpf_skb_adjust_room(skb, PUSH_LEN, BPF_ADJ_ROOM_MAC, 0);
+	reallocated = kskb->head != head;
+
+	return TC_ACT_SHOT;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/net/tx_extra_headroom.py b/tools/testing/selftests/net/tx_extra_headroom.py
index 153384a1fb0d..a4db5aa7268b 100755
--- a/tools/testing/selftests/net/tx_extra_headroom.py
+++ b/tools/testing/selftests/net/tx_extra_headroom.py
@@ -3,13 +3,20 @@
 
 """Tests for the IFLA_TX_EXTRA_HEADROOM link attribute."""
 
+import socket
+from pathlib import Path
+
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
-from lib.py import ip
+from lib.py import ksft_variants, KsftNamedVariant
+from lib.py import ip, tc, bpftool, bpf_prog_map_ids
 from lib.py import NetNS, NetNSEnter
 from lib.py import Netlink, NlError, RtnlFamily
 
 ATTR = "tx-extra-headroom"
 MAX = 512
+BPF_OBJ = Path(__file__).parent / "tx_extra_headroom.bpf.o"
+PORT = 9999  # UDP_TEST_PORT in tx_extra_headroom.bpf.c
+PUSH = 20  # PUSH_LEN in tx_extra_headroom.bpf.c
 
 
 def ifindex(name):
@@ -131,6 +138,68 @@ def test_not_inherited() -> None:
                 4, "vlan needed_headroom")
 
 
+def setup_veth(peer_ns):
+    """Create veth0 in the current netns and its peer veth1 in peer_ns."""
+    ip("link add veth0 type veth peer name veth1")
+    ip(f"link set veth1 netns {peer_ns}")
+    ip("addr add 192.0.2.1/24 dev veth0")
+    ip("link set veth0 up")
+    ip("addr add 192.0.2.2/24 dev veth1", ns=peer_ns)
+    ip("link set veth1 up", ns=peer_ns)
+    peer_mac = ip("link show dev veth1", json=True, ns=peer_ns)[0]["address"]
+    ip(f"neigh replace 192.0.2.2 lladdr {peer_mac} dev veth0 nud permanent")
+
+
+def load_tc_prog(dev, direction):
+    """Attach the tc/<direction> program to dev, return its .bss map id."""
+    tc(f"qdisc add dev {dev} clsact")
+    tc(f"filter add dev {dev} {direction} bpf da obj {BPF_OBJ} "
+       f"sec tc/{direction}")
+    filters = tc(f"filter show dev {dev} {direction}", json=True)
+    prog_id = next(f["options"]["prog"]["id"] for f in filters
+                   if "options" in f)
+    return next(map_id for name, map_id in bpf_prog_map_ids(prog_id).items()
+                if name.endswith(".bss"))
+
+
+def read_bss(map_id):
+    """Return the global variables of the tc program as a dict."""
+    dump = bpftool(f"map dump id {map_id}", json=True)[0]
+    return {name: val for var in dump["formatted"]["value"][".bss"]
+            for name, val in var.items()}
+
+
+def send_udp4():
+    """Send one UDP packet from veth0 to veth1."""
+    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
+        s.sendto(b"x", ("192.0.2.2", PORT))
+
+
+# A local IPv4 UDP packet on veth gets LL_ALLOC_SPACE() =
+# ((14 + tx_extra_headroom) & ~15) + 16 bytes of headroom. The Ethernet
+# header takes 14 of them. The push reallocates if less than PUSH bytes are
+# left.
+@ksft_variants([
+    KsftNamedVariant("udp4_0", send_udp4, 0, 2),
+    KsftNamedVariant("udp4_17", send_udp4, 17, 18),
+    KsftNamedVariant("udp4_18", send_udp4, 18, 34),
+    KsftNamedVariant("udp4_256", send_udp4, 256, 258),
+])
+def test_push(send, hr, headroom) -> None:
+    """Check the headroom of one packet and whether a push reallocates it."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        setup_veth(peer_ns)
+        set_hr(RtnlFamily(), ifindex("veth0"), hr)
+        map_id = load_tc_prog("veth0", "egress")
+        send()
+        bss = read_bss(map_id)
+
+    ksft_eq(bss["count"], 1, "test packets seen")
+    ksft_eq(bss["headroom"], headroom, "headroom before the push")
+    ksft_eq(bss["err"], 0, "bpf_skb_adjust_room() return value")
+    ksft_eq(bss["reallocated"], headroom < PUSH, "push reallocated the head")
+
+
 def main() -> None:
     """Run all test cases."""
     ksft_run([test_default_and_set,
@@ -139,7 +208,8 @@ def main() -> None:
               test_notification,
               test_survives_down_up,
               test_survives_netns_move,
-              test_not_inherited])
+              test_not_inherited,
+              test_push])
     ksft_exit()
 
 
-- 
2.56.0

