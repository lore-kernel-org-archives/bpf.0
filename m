Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283086;
	b=S03+bXiaQ/6FgKoz/Mx7RyI3TNWe4mJyoV58EXd1w5rGE8QwEtWLkamTqDwfSnKe7ISg
	 PqwheuFCuTRPN24ZpdK8+sca7Q3qdNqpxD7CW4cNgSxdvI1pVo8gwYwk5RtCKJjOCuDGV
	 R3Mr1EpIlVKv8iEKBDJT3IPQP8lUfcvpomWviLsum61ecmFUDkN9jzhUkw0GNWykyzt27
	 TxQ9cTamB6H+1T9v134cuzdrWDNBsal1fh+D5jcpGxKbU3fBZWH3QHY7yGcZK/L1BpKSG
	 eREXS4VEPpD9Qh19stLkuXKJjlSNTyuGmXDJW/gUSld8AsiCo4j74sbRbUSUnEECYrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4rDrfzTKAn5JJUV2U4EsYB5rN4eyfS8pXIocCOrWwmg=;
	b=FrgsUTW8u3iSLTbixBYL2RV70z7htd/IVpU2OiJOS4OsQ+3UZHbwGXUv2Da8nRO8i8E6
	 RBFZ8E5QmsuFyLZPe96/Y+5wVeToi7nYECyagASLoHpoiCasRaMl/Kp7MBZhXx1m0QmYk
	 ilNjEYjSlLrB0nw7rO/VmfOFGmRJSjHLPkGUSjcs+OVsYwRm2Qc3xzIMk+KfXyXLVMWVn
	 vyaw6l8fhIPGb0ichHd/Wim4DFJIxTvPiDNnV+ogDeZK0QgK9ks9PQYb4uqrkX1cJ09Qq
	 KFNRSEFcdnZMFIAnFQRaEZMLCe1QZ5ydPpaZTW5zRfm5W+ZvfRgBZ6YQwZHzCperFOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="YlJhP/fy";
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40317606A33F
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40317606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=YlJhP/fy
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so1928082a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283084; x=1794887884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rDrfzTKAn5JJUV2U4EsYB5rN4eyfS8pXIocCOrWwmg=;
        b=YlJhP/fyr5bJQ6zCHtIl2ekox8FEumdIGMmeYidw2KIV+4dznM75wdivfSMxqNWIG4
         t4r3iNHf3U8xKalsbqngniyaoMA3n5ioc2Q0mD+QgUzqTmQnMURaE6//VayZDjCw2y3C
         iwbqD/7mN0/OFhZ6ZyCmTHV8Uvik445ZFmpIp33aiS79MOQhuGbFAa+w3DoFc1Kj7q27
         hVWdxbU3pBlb7rGoXvsMuAYPkKW7hBY/ELPkJ/YUIXAfZGrrEG9417NGo9Q20pSDWRqF
         PMTvHiVJIDrIUX4OuMz0nmi7h95z9HvJT8+BgG3Gm9VfgMfjMhRzYN9k5lwiuIQgZDMI
         985A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283084; x=1794887884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rDrfzTKAn5JJUV2U4EsYB5rN4eyfS8pXIocCOrWwmg=;
        b=CI4CDkahlMNDjjmGo/BV9TimZdfaKng7f+1cBwCYrIHfvVbMNUFBRWkWUtq/AK+qII
         MdoicCzhVMgS+q7THa1Y4dqfhEGso9gCeXkWvwGIPGBaByXjhcTJ1KuabPMQyNIAVxdp
         r71YiJmkM6OzjcPTptjyQJMziStijl0s/bwcIRmR3sXm13fAM1CLnebHT7/8cV9Suoo+
         NXch1AToi6X5/4V1q8MMy/+gLC8PMb583y8xSiqKUPjhp9F+ELRCwN24j4I5azMkzy3E
         KCmxPpX8zv2s527UeL3EHfsH36Ajn/fsuP+4LQO9EK+tJfhLfg6+DdUz9pKLXiqjtLby
         OwaA==
X-Gm-Message-State: APuU4Z84wxKxLnNJ45b7z8mLKEtxf47Xs1P9gByC7BdP64e9NHs0j1IQ
	E8HxH3kDQl2NtcfOs7JOKAhxY8XanrNpmY7iNGuu3hfocl70Up9Z7IaPyJJs19942y6EJ7SiA2B
	yiqB28k4=
X-Gm-Gg: AYBFou1REacIRpwLxts0iVxuwziZQaiQKUpcDvxRC99uPHml8H5RJYQ+M5ubZWqHEfi
	a3nxC7pOdcmR0KDVI25RdCPORLd3xHv/bpbJfr5nvhXaVHPtxGssaVjE1E70q4qI633KWgUBL+K
	3wtxszXhYYSEGMvHsJ160+MKgsaE7wx5/IKZkhZkCN+5K/16qXSbClS2fuTikicUctqrQvpuOId
	PXs/OV1z2e0qUoxtUe10etceSGOAYsX0CO59Ik4bbBuUxoxThh2PA8bk+spu/1WDlz10XRLsPyQ
	SrwLeJVYaQ04a0TWyu7Uqi0PTOiMuUX1BKZsvkb0rtcBJW17YLuIZ+x98OJTtvZiQh2W613Cgjw
	sYP1LbsoYo0uRMZVmETe+KK8YKzONHSUVrF701iJZaTrsZq26xLerX1AdfS5Lbeb4/2JUinCM8h
	RQdhK5r+xNAiZyCBgXXsbKGY75pK5rPZxspISP0LyDfh6VMq3B5fwwTIv9NWwi88ElM9Vyat4Ts
	YadCBmOJXKOJvbdFRrSZAeozoWtZfG4A4w939kO8zRKKImECCx4dEugdSBc4gAc0TGH6xMAwMke
	o4gXZo4CVtX3QwsDXxf7OS9X6+rTju4CQv4PFVtCBjW3LW6tFbj5yrea5phvOHU=
X-Received: by 2002:a05:6402:a3d9:b0:6b4:c971:589d with SMTP id 4fb4d7f45d1cf-6b7568d8082mr801558a12.13.1794283083619;
        Mon, 09 Nov 2026 19:58:03 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.58.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:58:02 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 12/15] selftests: drv-net: xdp: test the stored RX metadata on XDP_PASS
Date: Tue, 10 Nov 2026 03:57:10 +0000
Message-ID: <ecf282c14030e86f32ca4e3862baede3e5053142.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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

Add a drv-net test for the skb core extension area. An XDP program
stores an RX hash, a VLAN tag and a checksum status. A tc program on
ingress reads the skb fields, and the test compares them with the
stored values.

The stored hash and VLAN tag are values that the NIC does not report:
hash 0x12345678 and an 802.1ad tag with VID 0xabc. The checksum status
is tested as CHECKSUM_NONE and as CHECKSUM_UNNECESSARY with csum_level
1. The NIC reports only one of them, so a driver that ignores the
stored values fails at least one case.

The test runs only on devices with the skb-ext-pass XDP feature. GRO is
off, because it can change ip_summed before the tc program runs. Like
test_xdp_rss_hash, the test sets its config map by name with
bpf_map_set().

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
veth has the skb-ext-pass feature, but in drv-net the test packet reaches
veth as an skb. The stored values are then lost, so the test fails on
veth. NIPA runs drv-net on netdevsim, where the test skips, and on real
NICs.
---
 .../drivers/net/hw/lib/py/__init__.py         |   3 +-
 .../selftests/drivers/net/hw/xdp_metadata.py  | 118 ++++++++++++-
 .../drivers/net/hw/xdp_skb_ext.bpf.c          | 166 ++++++++++++++++++
 3 files changed, 285 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_skb_ext.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 4077f5f1a1be..8a6702abcdbe 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -24,7 +24,7 @@ try:
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
-        wait_file, ctl_file_write, tool
+        wait_file, ctl_file_write, tool, tc
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
@@ -42,6 +42,7 @@ try:
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file", "ctl_file_write", "tool",
+               "tc",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
index 33a1985356d9..88b242964cff 100644
--- a/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
+++ b/tools/testing/selftests/drivers/net/hw/xdp_metadata.py
@@ -7,13 +7,18 @@ Tests for XDP metadata kfuncs (e.g. bpf_xdp_metadata_rx_hash).
 These tests load device-bound XDP programs from xdp_metadata.bpf.o
 that call metadata kfuncs, send traffic, and verify the extracted
 metadata via BPF maps.
+
+The skb core extension test loads xdp_skb_ext.bpf.o: an XDP program
+stores RX metadata and a tc program checks it on the skb.
 """
+import socket
+
 from lib.py import ksft_run, ksft_eq, ksft_exit, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import CmdExitFailure, KsftSkipEx, NetDrvEpEnv
 from lib.py import NetdevFamily
 from lib.py import bkg, cmd, rand_port, wait_port_listen
-from lib.py import ip, bpftool, defer
+from lib.py import ip, bpftool, defer, ethtool, tc, set_ethtool_feat
 from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 
 
@@ -130,6 +135,116 @@ def test_xdp_rss_hash(cfg, proto):
             f"RSS hash type should include L4 for {proto.upper()} traffic")
 
 
+# BPF map keys matching the enums in xdp_skb_ext.bpf.c
+_CFG_PORT = 0
+_CFG_HASH = 1
+_CFG_VLAN_PROTO = 2
+_CFG_VLAN_TCI = 3
+_CFG_IP_SUMMED = 4
+_CFG_CSUM_LEVEL = 5
+
+_RES_PKT_CNT = 0
+_RES_STORE_ERR = 1
+_RES_HASH = 2
+_RES_L4_HASH = 3
+_RES_VLAN_PROTO = 4
+_RES_VLAN_TCI = 5
+_RES_IP_SUMMED = 6
+_RES_CSUM_LEVEL = 7
+
+ETH_P_8021AD = 0x88a8
+VLAN_PRIO_SHIFT = 13
+
+# Magic numbers the NIC does not report
+TEST_RX_HASH = 0x12345678
+TEST_VLAN_PCP = 5
+TEST_VLAN_VID = 0xabc
+TEST_VLAN_TCI = TEST_VLAN_PCP << VLAN_PRIO_SHIFT | TEST_VLAN_VID
+
+XDP_CHECKSUM_NONE = 1 << 0
+XDP_CHECKSUM_UNNECESSARY = 1 << 1
+CHECKSUM_NONE = 0
+CHECKSUM_UNNECESSARY = 1
+
+
+def _load_skb_ext_progs(cfg):
+    """Attach the store program to XDP and the check program to tc ingress.
+
+    Returns:
+        A dict mapping map name to map ID.
+    """
+    abs_path = cfg.test_dir / "xdp_skb_ext.bpf.o"
+    pin_dir = "/sys/fs/bpf/xdp_skb_ext_test"
+
+    cmd(f"rm -rf {pin_dir}", shell=True, fail=False)
+    cmd(f"mkdir -p {pin_dir}", shell=True)
+    defer(cmd, f"rm -rf {pin_dir}", shell=True, fail=False)
+
+    bpftool(f"prog loadall {abs_path} {pin_dir}")
+    ip(f"link set dev {cfg.ifname} xdpdrv pinned {pin_dir}/xdp_store")
+    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
+
+    qdiscs = tc(f"qdisc show dev {cfg.ifname}", json=True)
+    if not any(q["kind"] == "clsact" for q in qdiscs):
+        tc(f"qdisc add dev {cfg.ifname} clsact")
+        defer(tc, f"qdisc del dev {cfg.ifname} clsact")
+
+    tc(f"filter add dev {cfg.ifname} ingress bpf "
+       f"object-pinned {pin_dir}/tc_check direct-action")
+    prog_id = bpftool(f"prog show pinned {pin_dir}/tc_check", json=True)["id"]
+    for f in tc(f"filter show dev {cfg.ifname} ingress", json=True):
+        if f.get("options", {}).get("prog", {}).get("id") == prog_id:
+            defer(tc, f"filter del dev {cfg.ifname} ingress pref {f['pref']}")
+
+    return bpf_prog_map_ids(prog_id)
+
+
+@ksft_variants([
+    KsftNamedVariant("csum_none", XDP_CHECKSUM_NONE, 0, CHECKSUM_NONE),
+    KsftNamedVariant("csum_unnecessary", XDP_CHECKSUM_UNNECESSARY, 1,
+                     CHECKSUM_UNNECESSARY),
+])
+def test_xdp_skb_ext(cfg, xdp_csum, csum_level, ip_summed):
+    """Test that the skb gets the RX metadata stored on XDP_PASS.
+
+    The XDP program stores a hash, a VLAN tag and a checksum status that
+    differ from what the NIC reports. The tc program reads them from the
+    skb.
+    """
+    dev_info = cfg.netnl.dev_get({"ifindex": cfg.ifindex})
+    if "skb-ext-pass" not in dev_info.get("xdp-features", []):
+        raise KsftSkipEx("device does not support skb-ext-pass")
+
+    maps = _load_skb_ext_progs(cfg)
+
+    # GRO can change ip_summed before tc ingress
+    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    set_ethtool_feat(cfg.ifname, feat, {"generic-receive-offload": False})
+
+    cfg_map = "map_store_cfg"
+    bpf_map_set(cfg_map, _CFG_HASH, TEST_RX_HASH)
+    bpf_map_set(cfg_map, _CFG_VLAN_PROTO, ETH_P_8021AD)
+    bpf_map_set(cfg_map, _CFG_VLAN_TCI, TEST_VLAN_TCI)
+    bpf_map_set(cfg_map, _CFG_IP_SUMMED, xdp_csum)
+    bpf_map_set(cfg_map, _CFG_CSUM_LEVEL, csum_level)
+    # The port goes last: it enables the store for the test packets
+    port = rand_port(socket.SOCK_DGRAM)
+    bpf_map_set(cfg_map, _CFG_PORT, port)
+
+    _send_probe(cfg, port, proto="udp")
+
+    res = bpf_map_dump(maps["map_store_res"])
+    ksft_ge(res.get(_RES_PKT_CNT, 0), 1, "tc saw the test packet")
+    ksft_eq(res.get(_RES_STORE_ERR, 0), 0, "store kfunc errors")
+
+    ksft_eq(res.get(_RES_HASH, 0), TEST_RX_HASH, "skb->hash")
+    ksft_eq(res.get(_RES_L4_HASH, 0), 1, "skb->l4_hash")
+    ksft_eq(res.get(_RES_VLAN_PROTO, 0), ETH_P_8021AD, "skb->vlan_proto")
+    ksft_eq(res.get(_RES_VLAN_TCI, 0), TEST_VLAN_TCI, "skb->vlan_tci")
+    ksft_eq(res.get(_RES_IP_SUMMED, 0), ip_summed, "skb->ip_summed")
+    ksft_eq(res.get(_RES_CSUM_LEVEL, 0), csum_level, "skb->csum_level")
+
+
 def main():
     """Run XDP metadata kfunc tests against a real device."""
     with NetDrvEpEnv(__file__) as cfg:
@@ -137,6 +252,7 @@ def main():
         ksft_run(
             [
                 test_xdp_rss_hash,
+                test_xdp_skb_ext,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/drivers/net/hw/xdp_skb_ext.bpf.c b/tools/testing/selftests/drivers/net/hw/xdp_skb_ext.bpf.c
new file mode 100644
index 000000000000..b186bc1f7947
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xdp_skb_ext.bpf.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/pkt_cls.h>
+#include <linux/udp.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+enum {
+	CFG_PORT,
+	CFG_HASH,
+	CFG_VLAN_PROTO,
+	CFG_VLAN_TCI,
+	CFG_IP_SUMMED,
+	CFG_CSUM_LEVEL,
+	CFG_MAX,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CFG_MAX);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_store_cfg SEC(".maps");
+
+enum {
+	RES_PKT_CNT,
+	RES_STORE_ERR,
+	RES_HASH,
+	RES_L4_HASH,
+	RES_VLAN_PROTO,
+	RES_VLAN_TCI,
+	RES_IP_SUMMED,
+	RES_CSUM_LEVEL,
+	RES_MAX,
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, RES_MAX);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_store_res SEC(".maps");
+
+/* Mirrors of include/net/xdp.h, not part of UAPI */
+enum xdp_rss_hash_type {
+	XDP_RSS_L4 = 1U << 3,
+};
+
+enum xdp_checksum {
+	XDP_CHECKSUM_NONE = 1U << 0,
+	XDP_CHECKSUM_UNNECESSARY = 1U << 1,
+};
+
+struct sk_buff {
+	__u8 ip_summed:2;
+	__u8 csum_level:2;
+	__u8 l4_hash:1;
+} __attribute__((preserve_access_index));
+
+extern int bpf_xdp_skb_ext_store_rx_hash(struct xdp_md *, __u32,
+					 enum xdp_rss_hash_type) __ksym;
+extern int bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *, __be16,
+					 __u16) __ksym;
+extern int bpf_xdp_skb_ext_store_rx_csum(struct xdp_md *, enum xdp_checksum,
+					 __u8) __ksym;
+extern void *bpf_cast_to_kern_ctx(void *obj) __ksym;
+
+static __u32 cfg_get(__u32 key)
+{
+	__u32 *val = bpf_map_lookup_elem(&map_store_cfg, &key);
+
+	return val ? *val : 0;
+}
+
+static void res_set(__u32 key, __u32 val)
+{
+	bpf_map_update_elem(&map_store_res, &key, &val, BPF_ANY);
+}
+
+static void res_inc(__u32 key)
+{
+	__u32 *cnt = bpf_map_lookup_elem(&map_store_res, &key);
+
+	if (cnt)
+		__sync_fetch_and_add(cnt, 1);
+}
+
+static bool is_test_pkt(void *data, void *data_end)
+{
+	struct ethhdr *eth = data;
+	struct udphdr *udp;
+
+	if ((void *)(eth + 1) > data_end)
+		return false;
+
+	if (eth->h_proto == bpf_htons(ETH_P_IP)) {
+		struct iphdr *iph = (void *)(eth + 1);
+
+		if ((void *)(iph + 1) > data_end ||
+		    iph->protocol != IPPROTO_UDP)
+			return false;
+		udp = (void *)(iph + 1);
+	} else if (eth->h_proto == bpf_htons(ETH_P_IPV6)) {
+		struct ipv6hdr *ip6h = (void *)(eth + 1);
+
+		if ((void *)(ip6h + 1) > data_end ||
+		    ip6h->nexthdr != IPPROTO_UDP)
+			return false;
+		udp = (void *)(ip6h + 1);
+	} else {
+		return false;
+	}
+
+	if ((void *)(udp + 1) > data_end)
+		return false;
+
+	return bpf_ntohs(udp->dest) == cfg_get(CFG_PORT);
+}
+
+SEC("xdp")
+int xdp_store(struct xdp_md *ctx)
+{
+	if (!is_test_pkt((void *)(long)ctx->data, (void *)(long)ctx->data_end))
+		return XDP_PASS;
+
+	if (bpf_xdp_skb_ext_store_rx_hash(ctx, cfg_get(CFG_HASH), XDP_RSS_L4) ||
+	    bpf_xdp_skb_ext_store_rx_vlan(ctx,
+					  bpf_htons(cfg_get(CFG_VLAN_PROTO)),
+					  cfg_get(CFG_VLAN_TCI)) ||
+	    bpf_xdp_skb_ext_store_rx_csum(ctx, cfg_get(CFG_IP_SUMMED),
+					  cfg_get(CFG_CSUM_LEVEL)))
+		res_inc(RES_STORE_ERR);
+
+	return XDP_PASS;
+}
+
+SEC("tc")
+int tc_check(struct __sk_buff *skb)
+{
+	struct sk_buff *kskb;
+
+	if (!is_test_pkt((void *)(long)skb->data, (void *)(long)skb->data_end))
+		return TC_ACT_UNSPEC;
+
+	kskb = bpf_cast_to_kern_ctx(skb);
+	res_set(RES_HASH, skb->hash);
+	res_set(RES_L4_HASH, BPF_CORE_READ_BITFIELD(kskb, l4_hash));
+	if (skb->vlan_present) {
+		res_set(RES_VLAN_PROTO, bpf_ntohs(skb->vlan_proto));
+		res_set(RES_VLAN_TCI, skb->vlan_tci);
+	}
+	res_set(RES_IP_SUMMED, BPF_CORE_READ_BITFIELD(kskb, ip_summed));
+	res_set(RES_CSUM_LEVEL, BPF_CORE_READ_BITFIELD(kskb, csum_level));
+	res_inc(RES_PKT_CNT);
+
+	return TC_ACT_UNSPEC;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0

