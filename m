Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D73D7D80;
	Wed, 15 Jul 2026 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151680; cv=none; b=MQlP2mcHocLehNs4RAwu/R8ED/S6btYEtPcb8p/AbJZ41f//iZcmBijqhK1vKzoP5uhrgViIWxzdpnoy6TQgZKhMDjptM09QDLjzI/LkEO7IKpUspzr/yNufLQExeWGvhXe2f2fKy/eL4CazUpc0RFD+9mMhWwnbC4srHwNo0SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151680; c=relaxed/simple;
	bh=neS5AS18/sfcMbhT99NMUdh7T8GCYo+XoAZjD9Yetog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLUW6Cc7Df3IA9PPMZ6tqzbmHs5MKQoI6ODI+R8QqkNaWKifdPmiVESVDDG2hlD9xXgYNzyNdfKK/6pUBGd5qjgerDHYvgpMnenn8EtjJlDM6VONLCJhc1l80B2N1ui4ucMeku5+Kfed57WVFSKQUFiBBADHcDzw3SqQ5nJVxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzVEo2Ha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzVEo2Ha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623011F000E9;
	Wed, 15 Jul 2026 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784151679;
	bh=dY7tXzrgldwISRDtQQktlci+sJJoVRVgS4ffcg7CQpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DzVEo2HaAwPs323HYaYE7y9mK5Ln7kJAocT/WeZwyMwpGvvt6lCZxFRMoAKNX5Jl6
	 6QeqrfyY4vnEyJiLqIIN5gQY1oMjxCiMDly6HdHvsb3QfEgapU+VGvqnpjEcnCRRjJ
	 zmgTO5LqVglNG+9Odm+bl98FiaSt7autfoxJFIvnaLhPQbJTrJoefgTU+mLDTptqbv
	 a9BN8eWpUlNKwLctaZI/EURs76OveTmeRjLFRxhNkHzLo2teiMJdnJ8mhmwk8wM3pe
	 hHjzm63MZQEiAzXD2SqSPZu1Q4TUUZXHFmSb9A8c7Q2S6BT9a5uumoSh0KY8Pq1NGV
	 XsJlgiGSjUNMg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jul 2026 23:39:48 +0200
Subject: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS skb
 checksum invalidation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Add a test that verifies skb->ip_summed is set to CHECKSUM_NONE
when a device running in XDP mode creates an skb from a xdp_buff
if the attached ebpf program returns an XDP_PASS.
The test attaches an XDP program returning XDP_PASS, and a TC
ingress program that runs the bpf_skb_rx_checksum() kfunc to
inspect the resulting skb. After XDP_PASS the driver must invalidate
any previously computed hardware RX checksum since XDP may have
modified the packet data.
The BPF program counts packets per checksum type in a map, and the
test runner verifies that after sending traffic the CHECKSUM_NONE
counter is non-zero while CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE
counters are zero.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/networking/xdp-rx-metadata.rst       |  5 ++
 .../selftests/drivers/net/hw/xdp_metadata.py       | 55 +++++++++++++++-
 .../selftests/net/lib/skb_metadata_csum.bpf.c      | 73 ++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index 93918b3769a3..7434ac98242a 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -90,6 +90,11 @@ conversion, and the XDP metadata is not used by the kernel when building
 ``skbs``. However, TC-BPF programs can access the XDP metadata area using
 the ``data_meta`` pointer.
 
+If a driver is running in XDP mode, any existing hardware RX checksum
+(``CHECKSUM_UNNECESSARY`` or ``CHECKSUM_COMPLETE``) must be invalidated
+by setting ``skb->ip_summed`` to ``CHECKSUM_NONE`` before passing the
+skb to the kernel, since XDP may have modified the packet data.
+
 In the future, we'd like to support a case where an XDP program
 can override some of the metadata used for building ``skbs``.
 
diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
old mode 100644
new mode 100755
index 33a1985356d9..8ccd34b776b4
--- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
+++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
@@ -8,12 +8,13 @@ These tests load device-bound XDP programs from xdp_metadata.bpf.o
 that call metadata kfuncs, send traffic, and verify the extracted
 metadata via BPF maps.
 """
+import json
 from lib.py import ksft_run, ksft_eq, ksft_exit, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import CmdExitFailure, KsftSkipEx, NetDrvEpEnv
 from lib.py import NetdevFamily
 from lib.py import bkg, cmd, rand_port, wait_port_listen
-from lib.py import ip, bpftool, defer
+from lib.py import ip, bpftool, defer, ethtool
 from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 
 
@@ -130,6 +131,57 @@ def test_xdp_rss_hash(cfg, proto):
             f"RSS hash type should include L4 for {proto.upper()} traffic")
 
 
+def test_xdp_pass_rx_csum(cfg):
+    """Test xdp_pass sets CHECKSUM_NONE on the resulting skb.
+
+    Attaches an XDP program that returns XDP_PASS and a TC ingress
+    program that checks skb->ip_summed via bpf_skb_rx_checksum().
+    Verifies the value is CHECKSUM_NONE.
+    """
+
+    bpf_obj = cfg.net_lib_dir / "skb_metadata_csum.bpf.o"
+    xdp_obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+
+    # GRO may overwrite skb->ip_summed after the driver sets it,
+    # so disable it to preserve the checksum set by the driver.
+    ethtool(f"-K {cfg.ifname} gro off")
+    defer(ethtool, f"-K {cfg.ifname} gro on")
+    ip(f"link set dev {cfg.ifname} xdp obj {xdp_obj} sec xdp")
+    defer(ip, f"link set dev {cfg.ifname} xdp off")
+
+    qdiscs = json.loads(cmd(f"tc -j qdisc show dev {cfg.ifname}").stdout)
+    if not any(q['kind'] == 'clsact' for q in qdiscs):
+        cmd(f"tc qdisc add dev {cfg.ifname} clsact")
+        defer(cmd, f"tc qdisc del dev {cfg.ifname} clsact")
+    cmd(f"tc filter add dev {cfg.ifname} ingress bpf da obj {bpf_obj} sec tc")
+
+    progs = bpftool("prog list", json=True)
+    tc_prog_id = None
+    for p in progs:
+        if p.get("name") == "tc_check_csum":
+            tc_prog_id = p["id"]
+            break
+
+    if tc_prog_id is None:
+        raise KsftSkipEx("Could not find tc_check_csum BPF program")
+
+    maps = bpf_prog_map_ids(tc_prog_id)
+    csum_map_id = maps.get("map_csum_result")
+    if csum_map_id is None:
+        raise KsftSkipEx("Could not find map_csum_result map")
+
+    for _ in range(10):
+        _send_probe(cfg, 12345, proto="udp")
+
+    result = bpf_map_dump(csum_map_id)
+    csum_none = result.get(0, 0)
+    csum_unnecessary = result.get(1, 0)
+    csum_complete = result.get(2, 0)
+    ksft_ge(csum_none, 1, "skb->ip_summed should be CHECKSUM_NONE after XDP_PASS")
+    ksft_eq(csum_unnecessary, 0, "CHECKSUM_UNNECESSARY should not be set")
+    ksft_eq(csum_complete, 0, "CHECKSUM_COMPLETE should not be set")
+
+
 def main():
     """Run XDP metadata kfunc tests against a real device."""
     with NetDrvEpEnv(__file__) as cfg:
@@ -137,6 +189,7 @@ def main():
         ksft_run(
             [
                 test_xdp_rss_hash,
+                test_xdp_pass_rx_csum,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/skb_metadata_csum.bpf.c b/tools/testing/selftests/net/lib/skb_metadata_csum.bpf.c
new file mode 100644
index 000000000000..6a953c4acfe7
--- /dev/null
+++ b/tools/testing/selftests/net/lib/skb_metadata_csum.bpf.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ipv6.h>
+#include <linux/pkt_cls.h>
+#include <linux/udp.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define UDP_PORT 12345
+
+enum skb_csum {
+	SKB_CSUM_NONE		= 0,
+	SKB_CSUM_UNNECESSARY	= 1,
+	SKB_CSUM_COMPLETE	= 2,
+	SKB_CSUM_PARTIAL	= 3,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, SKB_CSUM_PARTIAL);
+	__type(key, __u32);
+	__type(value, __u64);
+} map_csum_result SEC(".maps");
+
+extern int bpf_skb_rx_checksum(struct __sk_buff *skb, __u32 *ip_summed,
+				__u32 *csum_meta) __ksym;
+
+SEC("tc")
+int tc_check_csum(struct __sk_buff *skb)
+{
+	void *data_end = (void *)(long)skb->data_end;
+	void *data = (void *)(long)skb->data;
+	__u32 ip_summed, csum_meta;
+	struct ethhdr *eth = data;
+	struct ipv6hdr *ip6;
+	struct udphdr *udp;
+
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	ip6 = (void *)(eth + 1);
+	if ((void *)(ip6 + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (ip6->nexthdr != IPPROTO_UDP)
+		return TC_ACT_OK;
+
+	udp = (void *)(ip6 + 1);
+	if ((void *)(udp + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (udp->dest != bpf_htons(UDP_PORT))
+		return TC_ACT_OK;
+
+	bpf_skb_rx_checksum(skb, &ip_summed, &csum_meta);
+	if (ip_summed < SKB_CSUM_PARTIAL) {
+		__u64 *cnt;
+
+		cnt = bpf_map_lookup_elem(&map_csum_result, &ip_summed);
+		if (cnt)
+			__sync_fetch_and_add(cnt, 1);
+	}
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0

