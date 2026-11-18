Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044270;
	b=W20zcaK/M1nFo38uDo7Pahj1ffYcspoMWePFgQLka1BrGwhFMv8eXLAX4R/J4Hw6AIEd
	 FEnmVhqbCJjSkvQWY1ZsoErG0cKDT28I3y9x5c5sJuHeYOKUjJ6+lDTXS7y3AHM/pAmxR
	 qORe+S9N6NDmNL4J0LgSVHfdGPTGFV7D8X1WyFulLvSY/3UN/QwhQRVV5paZRnFraq4F2
	 GStxzwIxmVl599QVF/ew9y8AS4CGdln3CfYIRd9RXCpQA2us3nxM7ZnFw6PLHAmbkHryl
	 LJROSozyL7tyYgGl2+QUvJWrZMQvDBqQuZ7lwsASuwXeMLqmuaw34DrPsTFLlX0B0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=16EfIIHV3SinIjErQNoIN26xXbHmz7jMom6Zh+p2ulY=;
	b=FktCzMSzL2sGcBVhAQjwa7D2ITyCuTVMX5oazNcIFUQF6MJZr5wWbeKkmY/BujgcpHcQ
	 PAgBpELgPGvJyBoXsUiKyDFMNCzOy927KaaG3zV82hzlRvwIojXU0Idn1aBWld4me+ncB
	 vcAHyMISMq1A2wQsdaL2cN3CnwjSn9/FTG0uPW/eu4DQ6/4wvrbOt6uZevpCGzQoi/Moa
	 y3RdduT5HMU+Zgmgm22wMcxmGFXDmdloxtU3nrLI8SHm07QJtCpBhmQuxIHNvczMDL3BU
	 vtpO0nh+lLIpcbTJ5EunG84xjVr5zZrVADebeHMYsLRPVl2+vuTmhn3XBPOAcotpZSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsXoXNrK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DC60A2602;
	Wed, 18 Nov 2026 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsXoXNrK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467741F000C5;
	Wed, 18 Nov 2026 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044269;
	bh=16EfIIHV3SinIjErQNoIN26xXbHmz7jMom6Zh+p2ulY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsXoXNrKyFfzCKUPGyLtKYlLMkEWEUmP4tjIdDNkjULu8X+WclVns+NpOpESmUP5Q
	 GbKtwdD9/Zc+bj44fY5cJOK3/tOpBN6NYLxNp5rz54pvkGLlYK0ixcwW5OQGk6pHTx
	 dy+I9CSGy8MfTxc5AwLjEdJpkSyd/xLmJllJC4KMin2uGgMzfqKsciaeCbj0VcKjfG
	 uK41yH43WkXE3/MC+izT8+caR21Q6DNT3r1688aTr3Kos4ZYczYb6AvHttHLNebBhJ
	 M2+EiubRAvsD4L4DZOoHlOSkSETtCXDCcbRjkD7Dh3nc6BEGqJPtyk7qC9kca/RxnW
	 BZGj0CJdwhNDw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	manishc@marvell.com,
	joshwash@google.com,
	hramamurthy@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	daniel@iogearbox.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	przemyslaw.kitszel@intel.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/8] selftests: drv-net: drop the generic XDP hack from the HW GRO setup
Date: Wed, 18 Nov 2026 15:23:09 -0800
Message-ID: <20261118232315.3593731-3-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118232315.3593731-1-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
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

The HW GRO tests want SW GRO out of the way so that what they observe
can only have come from the device. On drivers which keyed HW GRO off
NETIF_F_GRO that was not expressible with ethtool alone, so the setup
fell back to attaching a generic XDP program, which suppresses SW GRO
as a side effect.

Those drivers no longer tie the two features together, so ask for the
feature combination directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../testing/selftests/drivers/net/gro_lib.py  | 21 +------------------
 .../selftests/drivers/net/hw/gro_stats.py     | 18 ----------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro_lib.py b/tools/testing/selftests/drivers/net/gro_lib.py
index 875a715b2ae1..6eff19db3541 100644
--- a/tools/testing/selftests/drivers/net/gro_lib.py
+++ b/tools/testing/selftests/drivers/net/gro_lib.py
@@ -263,26 +263,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
         set_ethtool_feat(cfg.ifname, cfg.feat,
                          {"generic-receive-offload": False,
                           "rx-gro-hw": True,
-                          "large-receive-offload": False},
-                          check=False)
-
-        # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
-        # will also clear HW GRO. Use a hack of installing XDP generic
-        # to skip SW GRO, even when enabled.
-        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
-        if not feat["rx-gro-hw"]["active"]:
-            ksft_pr("Driver clears HW GRO and SW GRO is cleared, using generic XDP workaround")
-            prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-            ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
-            defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
-
-            # Attaching XDP may change features, fetch the latest state
-            feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
-
-            set_ethtool_feat(cfg.ifname, feat,
-                             {"generic-receive-offload": True,
-                              "rx-gro-hw": True,
-                              "large-receive-offload": False})
+                          "large-receive-offload": False})
     elif mode == "lro":
         # netdevsim advertises LRO for feature inheritance testing with
         # bonding/team tests but it doesn't actually perform the offload
diff --git a/tools/testing/selftests/drivers/net/hw/gro_stats.py b/tools/testing/selftests/drivers/net/hw/gro_stats.py
index 70e76e3888bd..569ca81368e6 100755
--- a/tools/testing/selftests/drivers/net/hw/gro_stats.py
+++ b/tools/testing/selftests/drivers/net/hw/gro_stats.py
@@ -173,24 +173,6 @@ def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
                        "rx-gro-hw": True,
                        "large-receive-offload": False})
 
-    # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
-    # will also clear HW GRO. Use a hack of installing XDP generic
-    # to skip SW GRO, even when enabled.
-    feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
-    if not feat["rx-gro-hw"]["active"]:
-        ksft_pr("Driver clears HW GRO when SW GRO is cleared, using generic XDP workaround")
-        prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
-        ip(f"link set dev {cfg.ifname} xdpgeneric obj {prog} sec xdp")
-        defer(ip, f"link set dev {cfg.ifname} xdpgeneric off")
-
-        # Attaching XDP may change features, fetch the latest state
-        feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
-
-        _set_ethtool_feat(cfg, feat,
-                          {"generic-receive-offload": True,
-                           "rx-gro-hw": True,
-                           "large-receive-offload": False})
-
 
 def _check_gro_stats(cfg, test_queue, stats_before,
                      expect_rx, expect_gro, expect_wire):
-- 
2.56.1

