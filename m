Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309280;
	b=YjMuI1myV6h/d+jBxr20DOoK/2LqQ/OHQNPbY5T6R7p77RSXRYF90aUYhliy6+UJFLJF
	 kl5TfOix1Vg+b46hFwfB9Zua+Wx8wm0uUO+tw2UZWWB0JNuNY/iBMtk4bnNCYNep0xX6E
	 uKAaPDSd0EkLCg7lTbl/p+FHUY/d2HbYIARtF6DoI39Tcxti+Xbj+s7VaLwhK0G3XkiBz
	 bw+VTVgfqr818BhkeesMCmknoriBAVVR/UZN4A94RPEAiYRPYueIQrb8SNhspo30MDccb
	 Sq+DgF5Unw5LBtrAM52Vxhhbki7Vv2spZo3/6WS5XvR7t89F6Na3mp0WVaiXu164TEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0KfEfmTKYVapY/XxDnS3jkDJG9L03MCRk+3zIwQKZXo=;
	b=VR4RfNVK3TnMFDksc88kwV8et5SzoGtEfzsIIDJAO5V7YMylTxO7XkfQ/b2KXCvC3yuh
	 ndNegwqk8QcCiiKWwvu74tF0Brk7RzCXfsj8MR7eKgoKmJe4yn4AWPGTYop4vDRQHuCoB
	 cmZ6f5CAPS1sBHaR1SubNzO/b2Dg4YLzn74nR9KcXMSn0u5AunP2Tiq68rfr2RJJHLwHT
	 TsRgLIBcywE5+oGr8wAQUZekJVe344/x2kIW2dEhunAblStRp0odQxVHoAdStEec9ALLL
	 IKJD3Cdf4JjqLlyZBy0CTrlZQkYHjoliqWYNJTPzK2/pPcoYQXzskhRea7hxTvn9lpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmWY0SP9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B913606A32A;
	Sun, 22 Nov 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmWY0SP9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CFF1F000CF;
	Sun, 22 Nov 2026 01:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309279;
	bh=0KfEfmTKYVapY/XxDnS3jkDJG9L03MCRk+3zIwQKZXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmWY0SP9KiOxy/Bua7M6XpPutN+Uv6pJDy4rFt5j0qMmEF8MfL1D7D5rIDHAbV0Bp
	 gC8VYItDZ6ihV8WTmMqbatcKnMDxDkk1gW3F0Q1nHPAcCaAsL01MZPxFH7NsC8IFQU
	 tdkhsScyf1RP+URtxZ1JWYukplwLxVqUWnrYQ4PrRfuCgeoXSMzT+GgKR5U8SW2mbX
	 f/M9ois8HcTOYFCiHQ5Rqdzn2Qi9qIoC5tl7DtrjMpP+Msq1sa919UudZkyrBLhXO2
	 OzbZayhe2XIAayoUJICg6rQUxk04ylPGyPLsmF4cqQpub+DjdiAksoh5kLcxS6Yq8+
	 /f82x4wPns5vg==
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
Subject: [PATCH net-next v2 3/9] selftests: drv-net: drop the generic XDP hack from the HW GRO setup
Date: Sat, 21 Nov 2026 17:01:06 -0800
Message-ID: <20261122010112.1471146-4-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122010112.1471146-1-kuba@kernel.org>
References: <20261122010112.1471146-1-kuba@kernel.org>
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
v2:
 - drop check=False in gro_stats.py too, now that it uses the shared
   helper (Willem)
v1: https://lore.kernel.org/20261118232315.3593731-3-kuba@kernel.org
---
 .../testing/selftests/drivers/net/gro_lib.py  | 21 +------------------
 .../selftests/drivers/net/hw/gro_stats.py     | 21 +------------------
 2 files changed, 2 insertions(+), 40 deletions(-)

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
index a413e6fed210..2cccab12f68c 100755
--- a/tools/testing/selftests/drivers/net/hw/gro_stats.py
+++ b/tools/testing/selftests/drivers/net/hw/gro_stats.py
@@ -145,26 +145,7 @@ def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
     set_ethtool_feat(cfg.ifname, feat,
                      {"generic-receive-offload": False,
                       "rx-gro-hw": True,
-                      "large-receive-offload": False},
-                     check=False)
-
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
-        set_ethtool_feat(cfg.ifname, feat,
-                         {"generic-receive-offload": True,
-                          "rx-gro-hw": True,
-                          "large-receive-offload": False})
+                      "large-receive-offload": False})
 
 
 def _check_gro_stats(cfg, test_queue, stats_before,
-- 
2.56.1

