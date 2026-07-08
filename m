Received: from outbound.qs.icloud.com (qs-2005f-snip4-4.eps.apple.com [57.103.86.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1D31CA4E
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542922; cv=none; b=pQETu6ndpwdXwTIOvG8l5Oy7ncdVAvrhB07utto2usgK/U6xo8ewQPIJ488eWXC3TJseJ5M/jGc63EursWh0wuwyImRVcr9tMv00Pk6M2OQexM0aads5tTw0GgV7sg0y8www9Fww8sgRrnE0rvcJKa6PeYTuk0LvzxRYOlSvB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542922; c=relaxed/simple;
	bh=z/CgzwcPBbOSyjW2/ggTUepc5FVeM1tCtziqOzNK7gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFV3WshDrDRagSRtrpmsUM2/ntgZ5i/b92T3ZUIafElAl/PhSshD8abITjx1oKuHQWnvB+3EEPZJ735iN9yI2aZT4Rh+lPniEVVIJtcKtP0cz1rTbi0GoTxsV7EcSwF9YSyfj6iFQaR4o+TM4OUNoeKLkiQG0oOPhQ1N6l1jDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=il+Cobxd; arc=none smtp.client-ip=57.103.86.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="il+Cobxd"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id BC03030000A3;
	Wed, 08 Jul 2026 20:35:15 +0000 (UTC)
X-ICL-RepId: 019f4371-226b-7a27-8744-4bf09211985f
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGlwfFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783542919; x=1786134919; bh=au4REDALGPbRd4qyDPkjSmLLWroBmZZ1WT6/m3cMYNs=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=il+CobxdjWqcBnKnWfjzAcHqy9/yEj6NeMoRZgrHoJ/veiQ/h8QeFIp7WCfOmkFwscUacm01Vux0cOJWlb/sMieaGfBvJtG5cgZnIChsfykUeBg4RoGWHfeCX3VBH1zqkx43FzGGcbNtVetC9jgo6Mz9iSTr4oaP6ZEj5xT528N9MvVd4pUVXbI463VVPi1g/a7TRzURTt4z/pSc7/YncTOKeYtaxTRc/tw0hwdNFf1BrgFDBrFBJiAKKoq8RunUxDP28OCGmkqF96QWF6/irHcbPONAOUj3/kKy+gbvtUlKfBmaVE+AL+TjeU1dXABaY2KjItrIqoOageghFEfL1w==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id D6FB33001133;
	Wed, 08 Jul 2026 20:35:09 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next v4 6/6] selftests: drv-net: add XDP RX checksum metadata tests
Date: Wed,  8 Jul 2026 23:34:10 +0300
Message-ID: <20260708203410.45121-7-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX5DLLJJfIo833
 mlI4XeWHxNp1CUh17CwXchncUfu5QCYc24ImhIyw8NZgQJ7219CRguKNXVbpQHPL3+OrL/K6O2+
 BhPfQtQR8MGoInIIqXlJ4Gpa0qEWkiRZ1dD2dm6hd/dsURY6ZLW4n4vRTf0OP8poMPaI9lY/iiV
 0PJ+fDvGc4ukudW8zYTRSh14tS0wbikbpA6ROmD3k5gA7gugxI2HCT5yqL1Tv7GpNcaY/3gEQYO
 QM0uZtRk4poDbhETTcIg0qoMoHN3Ij4/tuGxcPbsWwrEZTc4oqyNDux6VOgoirUa8m0JDAM5mmZ
 Mg435n5jSuNgyoMXPdw
X-Proofpoint-ORIG-GUID: sLYEc1WpMdFxjTRWa13G-6KjpVxsQjjP
X-Proofpoint-GUID: sLYEc1WpMdFxjTRWa13G-6KjpVxsQjjP

Extend the xdp_metadata.py driver test with coverage for
bpf_xdp_metadata_rx_checksum().

Add an xdp_rx_csum program to xdp_metadata.bpf.o that reads the RX
checksum verdict and stores the ip_summed bitmask, the hw checksum
value and the checksum level into a map.  The L4 port/protocol filter
is the same as in the existing xdp_rss_hash program, so move it into a
common helper.

The new cases only run on devices whose driver implements the
xmo_rx_checksum callback, detected through the "checksum" bit of the
xdp-rx-metadata-features netlink attribute; on other devices they
report SKIP:

 - xdp_rx_csum_valid (tcp/udp variants): traffic with a correct
   checksum sent from the remote endpoint must be reported with a
   usable verdict, i.e. CHECKSUM_UNNECESSARY and/or CHECKSUM_COMPLETE.
   CHECKSUM_NONE is a legitimate verdict for a device that does not
   verify the packets (e.g. veth reports it for locally generated
   CHECKSUM_PARTIAL traffic), so it results in SKIP rather than in a
   failure;

 - xdp_rx_csum_invalid: UDP packets with a corrupted L4 checksum
   (sent with the net/lib csum tool) must not be reported as
   CHECKSUM_UNNECESSARY.

Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 .../selftests/drivers/net/hw/xdp_metadata.py  | 110 +++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++++--
 2 files changed, 209 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
index 33a1985356d9..1a623771477b 100644
--- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
+++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
@@ -8,6 +8,8 @@ These tests load device-bound XDP programs from xdp_metadata.bpf.o
 that call metadata kfuncs, send traffic, and verify the extracted
 metadata via BPF maps.
 """
+import time
+
 from lib.py import ksft_run, ksft_eq, ksft_exit, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import CmdExitFailure, KsftSkipEx, NetDrvEpEnv
@@ -81,8 +83,22 @@ _RSS_KEY_TYPE = 1
 _RSS_KEY_PKT_CNT = 2
 _RSS_KEY_ERR_CNT = 3
 
+_CSUM_KEY_IP_SUMMED = 0
+_CSUM_KEY_CKSUM = 1
+_CSUM_KEY_LEVEL = 2
+_CSUM_KEY_PKT_CNT = 3
+_CSUM_KEY_ERR_CNT = 4
+
 XDP_RSS_L4 = 0x8  # BIT(3) from enum xdp_rss_hash_type
 
+# Mirror of enum xdp_checksum from include/net/xdp.h
+XDP_CHECKSUM_NONE = 0x1
+XDP_CHECKSUM_UNNECESSARY = 0x2
+XDP_CHECKSUM_COMPLETE = 0x4
+
+# Fixed destination port of the net/lib csum tool
+_CSUM_TOOL_PORT = 34000
+
 
 @ksft_variants([
     KsftNamedVariant("tcp", "tcp"),
@@ -130,6 +146,98 @@ def test_xdp_rss_hash(cfg, proto):
             f"RSS hash type should include L4 for {proto.upper()} traffic")
 
 
+def _require_rx_csum_meta(cfg):
+    """Skip unless the device exposes XDP RX checksum metadata."""
+    dev_info = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
+    rx_meta = dev_info.get("xdp-rx-metadata-features", [])
+    if "checksum" not in rx_meta:
+        raise KsftSkipEx("device does not support XDP rx checksum metadata")
+
+
+@ksft_variants([
+    KsftNamedVariant("tcp", "tcp"),
+    KsftNamedVariant("udp", "udp"),
+])
+def test_xdp_rx_csum_valid(cfg, proto):
+    """Test RX checksum metadata for packets with a correct checksum.
+
+    Loads the xdp_rx_csum program, sends traffic with a valid L4 checksum
+    from the remote endpoint, and verifies that the checksum verdict
+    reported via bpf_xdp_metadata_rx_checksum() is usable
+    (CHECKSUM_UNNECESSARY and/or a CHECKSUM_COMPLETE value).
+
+    CHECKSUM_NONE is a valid verdict for a device that did not verify
+    the packets (e.g. veth reports it for locally generated traffic,
+    which is CHECKSUM_PARTIAL on the skb), so it results in SKIP, not
+    in a failure.
+    """
+    _require_rx_csum_meta(cfg)
+
+    prog_info = _load_xdp_metadata_prog(cfg, "xdp_rx_csum")
+
+    port = rand_port()
+    bpf_map_set("map_xdp_setup", _SETUP_KEY_PORT, port)
+
+    csum_map_id = prog_info["maps"]["map_csum"]
+
+    _send_probe(cfg, port, proto=proto)
+
+    csum = bpf_map_dump(csum_map_id)
+
+    pkt_cnt = csum.get(_CSUM_KEY_PKT_CNT, 0)
+    err_cnt = csum.get(_CSUM_KEY_ERR_CNT, 0)
+    ip_summed = csum.get(_CSUM_KEY_IP_SUMMED, 0)
+
+    ksft_ge(pkt_cnt, 1, comment="should have received at least one packet")
+    ksft_eq(err_cnt, 0, comment=f"RX checksum error count: {err_cnt}")
+
+    ksft_pr(f"  ip_summed: {ip_summed:#x} cksum: "
+            f"{csum.get(_CSUM_KEY_CKSUM, 0):#010x} "
+            f"level: {csum.get(_CSUM_KEY_LEVEL, 0)}")
+    ksft_ne(ip_summed, 0, "the program should have stored a checksum verdict")
+    if not ip_summed & (XDP_CHECKSUM_UNNECESSARY | XDP_CHECKSUM_COMPLETE):
+        raise KsftSkipEx("device did not verify the packet checksum "
+                         "(CHECKSUM_NONE)")
+
+
+def test_xdp_rx_csum_invalid(cfg):
+    """Test RX checksum metadata for packets with a corrupted checksum.
+
+    Sends UDP packets with an intentionally bad L4 checksum using the
+    net/lib csum tool and verifies the device does not claim it validated
+    them: the CHECKSUM_UNNECESSARY bit must not be set.
+    """
+    _require_rx_csum_meta(cfg)
+
+    ipver = cfg.addr_ipver
+    bin_remote = cfg.remote.deploy(cfg.net_lib_dir / "csum")
+
+    prog_info = _load_xdp_metadata_prog(cfg, "xdp_rx_csum")
+
+    bpf_map_set("map_xdp_setup", _SETUP_KEY_PORT, _CSUM_TOOL_PORT)
+
+    csum_map_id = prog_info["maps"]["map_csum"]
+
+    cmd(f"{bin_remote} -i {cfg.remote_ifname} -n 20 -{ipver} "
+        f"-S {cfg.remote_addr} -D {cfg.addr} -r 1 -T -E",
+        host=cfg.remote)
+
+    # no receiver to synchronize against; let NAPI drain the last packets
+    time.sleep(1)
+
+    csum = bpf_map_dump(csum_map_id)
+
+    pkt_cnt = csum.get(_CSUM_KEY_PKT_CNT, 0)
+    ip_summed = csum.get(_CSUM_KEY_IP_SUMMED, 0)
+
+    ksft_ge(pkt_cnt, 1, comment="should have received at least one packet")
+
+    ksft_pr(f"  ip_summed: {ip_summed:#x}")
+    ksft_eq(ip_summed & XDP_CHECKSUM_UNNECESSARY, 0,
+            "device must not report CHECKSUM_UNNECESSARY for a corrupted "
+            "checksum")
+
+
 def main():
     """Run XDP metadata kfunc tests against a real device."""
     with NetDrvEpEnv(__file__) as cfg:
@@ -137,6 +245,8 @@ def main():
         ksft_run(
             [
                 test_xdp_rss_hash,
+                test_xdp_rx_csum_valid,
+                test_xdp_rx_csum_invalid,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
index f71f59215239..70decae0a663 100644
--- a/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_metadata.bpf.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <stddef.h>
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/if_ether.h>
@@ -40,6 +41,24 @@ struct {
 	__uint(max_entries, 4);
 } map_rss SEC(".maps");
 
+/* RX checksum results: key 0 = ip_summed bitmask, key 1 = hw cksum value,
+ * key 2 = cksum level, key 3 = packet count, key 4 = error count.
+ */
+enum {
+	CSUM_KEY_IP_SUMMED = 0,
+	CSUM_KEY_CKSUM = 1,
+	CSUM_KEY_LEVEL = 2,
+	CSUM_KEY_PKT_CNT = 3,
+	CSUM_KEY_ERR_CNT = 4,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 5);
+} map_csum SEC(".maps");
+
 /* Mirror of enum xdp_rss_hash_type from include/net/xdp.h.
  * Needed because the enum is not part of UAPI headers.
  */
@@ -55,8 +74,20 @@ enum xdp_rss_hash_type {
 	XDP_RSS_L4_ICMP = 1U << 8,
 };
 
+/* Mirror of enum xdp_checksum from include/net/xdp.h.
+ * Needed because the enum is not part of UAPI headers.
+ */
+enum xdp_checksum {
+	XDP_CHECKSUM_NONE = 1U << 0,
+	XDP_CHECKSUM_UNNECESSARY = 1U << 1,
+	XDP_CHECKSUM_COMPLETE = 1U << 2,
+};
+
 extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
 				    enum xdp_rss_hash_type *rss_type) __ksym;
+extern int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
+					enum xdp_checksum *ip_summed,
+					__u32 *cksum, __u8 *cksum_level) __ksym;
 
 static __always_inline __u16 get_dest_port(void *l4, void *data_end,
 					   __u8 protocol)
@@ -78,41 +109,39 @@ static __always_inline __u16 get_dest_port(void *l4, void *data_end,
 	return 0;
 }
 
-SEC("xdp")
-int xdp_rss_hash(struct xdp_md *ctx)
+/* Return true when the packet matches the L4 protocol and destination
+ * port configured in map_xdp_setup (zero/unset filters match anything).
+ */
+static __always_inline bool xdp_match_setup(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data = (void *)(long)ctx->data;
-	enum xdp_rss_hash_type rss_type = 0;
 	struct ethhdr *eth = data;
 	__u8 l4_proto = 0;
-	__u32 hash = 0;
-	__u32 key, val;
 	void *l4 = NULL;
-	__u32 *cnt;
-	int ret;
+	__u32 key;
 
 	if ((void *)(eth + 1) > data_end)
-		return XDP_PASS;
+		return false;
 
 	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
 		struct iphdr *iph = (void *)(eth + 1);
 
 		if ((void *)(iph + 1) > data_end)
-			return XDP_PASS;
+			return false;
 		l4_proto = iph->protocol;
 		l4 = (void *)(iph + 1);
 	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
 		struct ipv6hdr *ip6h = (void *)(eth + 1);
 
 		if ((void *)(ip6h + 1) > data_end)
-			return XDP_PASS;
+			return false;
 		l4_proto = ip6h->nexthdr;
 		l4 = (void *)(ip6h + 1);
 	}
 
 	if (!l4)
-		return XDP_PASS;
+		return false;
 
 	/* Filter on the configured protocol (map_xdp_setup key XDP_PROTO).
 	 * When set, only process packets matching the requested L4 protocol.
@@ -121,7 +150,7 @@ int xdp_rss_hash(struct xdp_md *ctx)
 	__s32 *proto_cfg = bpf_map_lookup_elem(&map_xdp_setup, &key);
 
 	if (proto_cfg && *proto_cfg != 0 && l4_proto != (__u8)*proto_cfg)
-		return XDP_PASS;
+		return false;
 
 	/* Filter on the configured port (map_xdp_setup key XDP_PORT).
 	 * Only applies to protocols with ports (UDP, TCP).
@@ -133,9 +162,24 @@ int xdp_rss_hash(struct xdp_md *ctx)
 		__u16 dest = get_dest_port(l4, data_end, l4_proto);
 
 		if (!dest || bpf_ntohs(dest) != (__u16)*port_cfg)
-			return XDP_PASS;
+			return false;
 	}
 
+	return true;
+}
+
+SEC("xdp")
+int xdp_rss_hash(struct xdp_md *ctx)
+{
+	enum xdp_rss_hash_type rss_type = 0;
+	__u32 hash = 0;
+	__u32 key, val;
+	__u32 *cnt;
+	int ret;
+
+	if (!xdp_match_setup(ctx))
+		return XDP_PASS;
+
 	ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
 	if (ret < 0) {
 		key = RSS_KEY_ERR_CNT;
@@ -160,4 +204,46 @@ int xdp_rss_hash(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
+SEC("xdp")
+int xdp_rx_csum(struct xdp_md *ctx)
+{
+	enum xdp_checksum ip_summed = 0;
+	__u8 cksum_level = 0;
+	__u32 cksum = 0;
+	__u32 key, val;
+	__u32 *cnt;
+	int ret;
+
+	if (!xdp_match_setup(ctx))
+		return XDP_PASS;
+
+	ret = bpf_xdp_metadata_rx_checksum(ctx, &ip_summed, &cksum,
+					   &cksum_level);
+	if (ret < 0) {
+		key = CSUM_KEY_ERR_CNT;
+		cnt = bpf_map_lookup_elem(&map_csum, &key);
+		if (cnt)
+			__sync_fetch_and_add(cnt, 1);
+		return XDP_PASS;
+	}
+
+	key = CSUM_KEY_IP_SUMMED;
+	val = (__u32)ip_summed;
+	bpf_map_update_elem(&map_csum, &key, &val, BPF_ANY);
+
+	key = CSUM_KEY_CKSUM;
+	bpf_map_update_elem(&map_csum, &key, &cksum, BPF_ANY);
+
+	key = CSUM_KEY_LEVEL;
+	val = cksum_level;
+	bpf_map_update_elem(&map_csum, &key, &val, BPF_ANY);
+
+	key = CSUM_KEY_PKT_CNT;
+	cnt = bpf_map_lookup_elem(&map_csum, &key);
+	if (cnt)
+		__sync_fetch_and_add(cnt, 1);
+
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.0

