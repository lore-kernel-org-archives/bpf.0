Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F5DDCD
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469521; cv=none; b=tKKxpi0Xu7RN5YVVlDB3IcYCYb2GlGFxmaIwMdBB0lKGMTlwYn5S0r9y6WPEgfKQzxFVaChRjVeXyrMHWCPZXy7HzsVdCKfSgyS3Ll3tePNeTvC8hqpu8+jdLrkYJudwV80K99zEySUHEDJA0gVsG53mukWKgpzu3IPtaB/OkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469521; c=relaxed/simple;
	bh=wmHGZbtZhA3zDwtHUMFrClCylU1oXErRKImVLduAEuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjVwruvvFS7SaHr1Qx66Wz0U7ReCTT3NhaI8I8ykVm7IZ9ys1doA3WYxjDg3muBkAO76rY2v4c05Bq4V2EZ7zz2zRshvUQ/cPQ+Ve9+aAOLQWyc57sEuVrdCJu91OvjFzS+u4/MOFH3YnGe1eWs9ojircz9dfAnq+bhthtvwqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aGgnXySY; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aGgnXySY"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-679f6ee3fb0so167723eaf.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469519; x=1775074319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmPU5vMVitRHM4EYIhiqbjNtUA7f2jGN0zWyXGHXwZs=;
        b=aGgnXySYZjwicM17acbqO0yGFi9ArzYmoCSNoLgy5Wfq30MKHCyFAl9vsS6e+MFb+q
         Dux53n3ybWegycoszKKTaKQL8KIFInfCE9reySS9dAZ3Q3LaCGPhwt1xd+pW1UT6WsU8
         t/ROq3ceq3CVwzj0xhYTfEqbzR6+5265yPj/2Yv2oDUy+kHPv8cZcbpUlixuFsr+O5BV
         8aae8LoOu7YHZ8HLk10TTMtf/A5XKhPGYDjZCuf5mZxL+zaDHc/6p7kLr/3MRL7MOgL9
         MBs9KGvahRSiVWjgquwrg+px2T84WUbheuHTHzSUgTNUO8qZkmtj/As2qFOJNoLMySD3
         qs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469519; x=1775074319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmPU5vMVitRHM4EYIhiqbjNtUA7f2jGN0zWyXGHXwZs=;
        b=Vkyt43gLkw3TKvaT/JgaPo1eoI9EJ3bgyf3FHKhalqUcKFsVdEJQdr1VbIUrXQ44zD
         Mmu45GNV8L25zgpSwapuIP/+x0j5VDNz9LVcIF0HWsJPoW2KuuFkfJHv3qDSEYaSFsXz
         wOrxdVsP6XghR02erePls7+nPuILqTzkVxOJBYaTfZMlrjrOuWZUAeqxWKZVzcWeKPY1
         PKHErzKH697CupsKH65BMkaQzQAMEMbP0fs9s+RXeHtMglXPn2YLeZxMTUia/yj3Zlj1
         FT/t/KmNnM+2vXsiVb46UuJWJaqz4Dkhsme0Hgp1eJZzE0wc3O73vK/aYC+nXfr0RXW3
         lK7w==
X-Forwarded-Encrypted: i=1; AJvYcCXuq5SOIEAb8uNIdP/P/lUVsnRn54lfCmxyARtHnfaDgWLtajvn3LDi6ZNHG9RSoQAx5ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cfp6sUMA7xU7CiEGWPoLlgTtsjIUahOKK7RupzRHfK3omuAh
	nDMVqzDuGq80CxgwOxJVMMmlNfzbR4e6H/7CQlxk7CmoOQfmQYs3WXOnujwcEQD/058=
X-Gm-Gg: ATEYQzzlHimcyjetHQI/+zwqsFOkUQlpqR5RSKvxxsO0SJwZ52AhqsvYKLKuXDzWZGx
	nrbtFgzWawsC749sWovwKUKByFt9MMSUZ0QuwbDTQ4mTOPBznwyn3ySK+RuqIdKDhtxM0ya28VY
	9WH1fPu3a7K4EVRFcmhXwyt9rAe6YuseQ4KsQtgJWiaE1YEsxb7aOgTX+A1JUqwV+nUVLrra9cu
	lXd3Zy8uNb0bAbqSCEy5uhHK0kCY5Mn4221tsVpSnFdq2WKjEA/fTOxdgqp34Vvmuc+Jog9DblI
	gDx2Ff1Ti5YCumQFDzVS8QinydmoW8IGWm/zdlzlCLwK4KOdDB7/MP/V1TYLhp4+SJ/qnMdDOlR
	C7+NxMm7EA5RVv8/tKGHC+fiwDul9IJSDaIjaJaR9Uephp91vB3sCCJymGeHF8vvvP5roYO18e3
	y1Sblpu6sGv/zhbrgxBi/IHL4=
X-Received: by 2002:a05:6820:4d0c:b0:67b:f209:bdb8 with SMTP id 006d021491bc7-67dff5324f3mr2310037eaf.47.1774469518707;
        Wed, 25 Mar 2026 13:11:58 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:58 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 5/6] selftests: net: move common xdp.py functions into lib
Date: Wed, 25 Mar 2026 15:09:51 -0500
Message-ID: <20260325201139.2501937-6-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves a few functions which can be useful to other python programs
that manipulate XDP programs. This also refactors xdp.py to use the
refactored functions.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v4: rebase only
v5: make format_hex_bytes private, remove redundant bpf_map_set
---
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +
 tools/testing/selftests/drivers/net/xdp.py    | 96 +++++--------------
 .../testing/selftests/net/lib/py/__init__.py  |  2 +
 tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
 4 files changed, 94 insertions(+), 74 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 374d4f08dd05..2b5ec0505672 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -24,6 +24,7 @@ try:
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wait_file
+    from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -37,6 +38,7 @@ try:
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file",
+               "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants", "KsftNamedVariant",
diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index e54df158dfe9..d86446569f89 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -16,7 +16,8 @@ from lib.py import KsftNamedVariant, ksft_variants
 from lib.py import KsftFailEx, NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
-from lib.py import ip, bpftool, defer
+from lib.py import ip, defer
+from lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 
 
 class TestConfig(Enum):
@@ -122,47 +123,11 @@ def _load_xdp_prog(cfg, bpf_info):
     xdp_info = ip(f"-d link show dev {cfg.ifname}", json=True)[0]
     prog_info["id"] = xdp_info["xdp"]["prog"]["id"]
     prog_info["name"] = xdp_info["xdp"]["prog"]["name"]
-    prog_id = prog_info["id"]
-
-    map_ids = bpftool(f"prog show id {prog_id}", json=True)["map_ids"]
-    prog_info["maps"] = {}
-    for map_id in map_ids:
-        name = bpftool(f"map show id {map_id}", json=True)["name"]
-        prog_info["maps"][name] = map_id
+    prog_info["maps"] = bpf_prog_map_ids(prog_info["id"])
 
     return prog_info
 
 
-def format_hex_bytes(value):
-    """
-    Helper function that converts an integer into a formatted hexadecimal byte string.
-
-    Args:
-        value: An integer representing the number to be converted.
-
-    Returns:
-        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
-    """
-    hex_str = value.to_bytes(4, byteorder='little', signed=True)
-    return ' '.join(f'{byte:02x}' for byte in hex_str)
-
-
-def _set_xdp_map(map_name, key, value):
-    """
-    Updates an XDP map with a given key-value pair using bpftool.
-
-    Args:
-        map_name: The name of the XDP map to update.
-        key: The key to update in the map, formatted as a hexadecimal string.
-        value: The value to associate with the key, formatted as a hexadecimal string.
-    """
-    key_formatted = format_hex_bytes(key)
-    value_formatted = format_hex_bytes(value)
-    bpftool(
-        f"map update name {map_name} key hex {key_formatted} value hex {value_formatted}"
-    )
-
-
 def _get_stats(xdp_map_id):
     """
     Retrieves and formats statistics from an XDP map.
@@ -177,25 +142,11 @@ def _get_stats(xdp_map_id):
     Raises:
         KsftFailEx: If the stats retrieval fails.
     """
-    stats_dump = bpftool(f"map dump id {xdp_map_id}", json=True)
-    if not stats_dump:
+    stats = bpf_map_dump(xdp_map_id)
+    if not stats:
         raise KsftFailEx(f"Failed to get stats for map {xdp_map_id}")
 
-    stats_formatted = {}
-    for key in range(0, 5):
-        val = stats_dump[key]["formatted"]["value"]
-        if stats_dump[key]["formatted"]["key"] == XDPStats.RX.value:
-            stats_formatted[XDPStats.RX.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.PASS.value:
-            stats_formatted[XDPStats.PASS.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.DROP.value:
-            stats_formatted[XDPStats.DROP.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.TX.value:
-            stats_formatted[XDPStats.TX.value] = val
-        elif stats_dump[key]["formatted"]["key"] == XDPStats.ABORT.value:
-            stats_formatted[XDPStats.ABORT.value] = val
-
-    return stats_formatted
+    return stats
 
 
 def _test_pass(cfg, bpf_info, msg_sz):
@@ -211,8 +162,8 @@ def _test_pass(cfg, bpf_info, msg_sz):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.PASS.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.PASS.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     ksft_eq(_test_udp(cfg, port, msg_sz), True, "UDP packet exchange failed")
     stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
@@ -258,8 +209,8 @@ def _test_drop(cfg, bpf_info, msg_sz):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.DROP.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.DROP.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     ksft_eq(_test_udp(cfg, port, msg_sz), False, "UDP packet exchange should fail")
     stats = _get_stats(prog_info["maps"]["map_xdp_stats"])
@@ -305,8 +256,8 @@ def _test_xdp_native_tx(cfg, bpf_info, payload_lens):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.TX.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     expected_pkts = 0
     for payload_len in payload_lens:
@@ -454,15 +405,15 @@ def _test_xdp_native_tail_adjst(cfg, pkt_sz_lst, offset_lst):
     prog_info = _load_xdp_prog(cfg, bpf_info)
 
     # Configure the XDP map for tail adjustment
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.TAIL_ADJST.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.TAIL_ADJST.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     for offset in offset_lst:
         tag = format(random.randint(65, 90), "02x")
 
-        _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+        bpf_map_set("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
         if offset > 0:
-            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
+            bpf_map_set("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
 
         for pkt_sz in pkt_sz_lst:
             test_str = "".join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
@@ -574,8 +525,8 @@ def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
     prog_info = _load_xdp_prog(cfg, BPFProgInfo(prog, "xdp_native.bpf.o", "xdp.frags", 9000))
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.HEAD_ADJST.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, XDPAction.HEAD_ADJST.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     hds_thresh = get_hds_thresh(cfg)
     for offset in offset_lst:
@@ -595,11 +546,8 @@ def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
             test_str = ''.join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
             tag = format(random.randint(65, 90), '02x')
 
-            _set_xdp_map("map_xdp_setup",
-                     TestConfig.ADJST_OFFSET.value,
-                     offset)
-            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
-            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+            bpf_map_set("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+            bpf_map_set("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
 
             recvd_str = _exchg_udp(cfg, port, test_str)
 
@@ -691,8 +639,8 @@ def test_xdp_native_qstats(cfg, act):
     prog_info = _load_xdp_prog(cfg, bpf_info)
     port = rand_port()
 
-    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, act.value)
-    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+    bpf_map_set("map_xdp_setup", TestConfig.MODE.value, act.value)
+    bpf_map_set("map_xdp_setup", TestConfig.PORT.value, port)
 
     # Discard the input, but we need a listener to avoid ICMP errors
     rx_udp = f"socat -{cfg.addr_ipver} -T 2 -u UDP-RECV:{port},reuseport " + \
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index e0c920041a58..7c81d86a7e97 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -15,6 +15,7 @@ from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     wait_file, tool
+from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
@@ -29,6 +30,7 @@ __all__ = ["KSRC",
            "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
            "wait_port_listen", "wait_file", "tool",
+           "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
diff --git a/tools/testing/selftests/net/lib/py/bpf.py b/tools/testing/selftests/net/lib/py/bpf.py
new file mode 100644
index 000000000000..beb6bf2896a8
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/bpf.py
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+BPF helper utilities for kernel selftests.
+
+Provides common operations for interacting with BPF maps and programs
+via bpftool, used by XDP and other BPF-based test files.
+"""
+
+from .utils import bpftool
+
+def _format_hex_bytes(value):
+    """
+    Helper function that converts an integer into a formatted hexadecimal byte string.
+
+    Args:
+        value: An integer representing the number to be converted.
+
+    Returns:
+        A string representing hexadecimal equivalent of value, with bytes separated by spaces.
+    """
+    hex_str = value.to_bytes(4, byteorder='little', signed=True)
+    return ' '.join(f'{byte:02x}' for byte in hex_str)
+
+
+def bpf_map_set(map_name, key, value):
+    """
+    Updates an XDP map with a given key-value pair using bpftool.
+
+    Args:
+        map_name: The name of the XDP map to update.
+        key: The key to update in the map, formatted as a hexadecimal string.
+        value: The value to associate with the key, formatted as a hexadecimal string.
+    """
+    key_formatted = _format_hex_bytes(key)
+    value_formatted = _format_hex_bytes(value)
+    bpftool(
+        f"map update name {map_name} key hex {key_formatted} value hex {value_formatted}"
+    )
+
+def bpf_map_dump(map_id):
+    """Dump all entries of a BPF array map.
+
+    Args:
+        map_id: Numeric map ID (as returned by bpftool prog show).
+
+    Returns:
+        A dict mapping formatted key (int) to formatted value (int).
+    """
+    raw = bpftool(f"map dump id {map_id}", json=True)
+    return {e["formatted"]["key"]: e["formatted"]["value"] for e in raw}
+
+
+def bpf_prog_map_ids(prog_id):
+    """Get the map name-to-ID mapping for a loaded BPF program.
+
+    Args:
+        prog_id: Numeric program ID.
+
+    Returns:
+        A dict mapping map name (str) to map ID (int).
+    """
+    map_ids = bpftool(f"prog show id {prog_id}", json=True)["map_ids"]
+    maps = {}
+    for mid in map_ids:
+        name = bpftool(f"map show id {mid}", json=True)["name"]
+        maps[name] = mid
+    return maps
-- 
2.43.0

