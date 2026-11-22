Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309279;
	b=wR35A1+VYtDRcSp4APCH+jUKdjcrQBJKpH1OlA6Of+gnjd/jsfrKkCldOhrrPdH3VSTk
	 1ymM4p+WVmkZguwTdj5G3GzkVjoOyJu5gaRHXytR/Is485gKIBFn297cKdfw4ZwyzvmQs
	 rXckbhI8+kr74wWZNh6SIMwtByYJr/nRVoWBnp+D5icEK+XwaonbbQDr0KRqkjgdgA7Iu
	 5i1NV3bUTYWwAEmz+VHKC5VilPp6ReSGkJDnmUTxVNtl/ZUThMiq3W/WZS3RODAb9/v6N
	 MztrUjxXfcJgSW6SuQWU+zxznC3Mk14UfmVFa922+7HAEW3/p6KwL4MGVbJbnujebBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jMnRJm6MI0mjGv2h9+ky9jm0gmL/BN1SDUzApkKFpdg=;
	b=VSbnRtRy/u1BLdL17qn2L2yOoBq1U0nDlR3IzzTZKNTMy2di2+2MdJ9BGY6AM2DYjrUo
	 H4Og77U1gkrgCg+NH1WHivRSoKa3yf4DxGdwnS08WQFkDx2drfCQ4vtTlrvNjqTpFC7Cg
	 tPJa5w8uIrjLiiVzoQ0nQxkscFGduc+Op46ef2bLq42lsfE6Q6jk0rcu4SbcMtPIc65Mq
	 8nGs7C3R1TEahaqLqNGz34bhU+17Mb93tV7OD8UNylwmP/eSV+Qo2TtJmfFKAPmKUBMFk
	 Tvh2AIppIjr5NyP85UQvtqc3lJqqSJ4pI3Tc/IlgwSKJIXfcAwmMFBLTSjvB1uUcXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="en/gmU+R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99469606A684;
	Sun, 22 Nov 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=en/gmU+R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8081F000C4;
	Sun, 22 Nov 2026 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309279;
	bh=jMnRJm6MI0mjGv2h9+ky9jm0gmL/BN1SDUzApkKFpdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=en/gmU+RfKmUNC+SLqnUCNT4g62Bu3y+fghmFivWwrUs3S0CaBEtm7HSXdA3vEc+o
	 vHyGIjUwCzUQEqBiPCv2vBZ9T4WYv03WhwjK9sH1NI0ULW39fOpHta3Aqp+J+rNfDf
	 9eXSBWcbnMqX0WYBy/cG4yqQx24H/2xA4oyRo0wI6rVSRRWbe8/70YOHHvr61nadEK
	 03TcyxeXz+13oQQ+Dykeek68IqBLMCjwDXmUDzkr0OsEt2glMXmfYhaftkktN4uKTt
	 WrjcMn28QqG8uw+Hlf4doCVZNhWzefYQknnRKZKdCa6SsfmPG5zKWx0BLZ8QMOGsWE
	 CGFpFYqkAocsQ==
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
Subject: [PATCH net-next v2 2/9] selftests: drv-net: gro_stats: use the shared set_ethtool_feat()
Date: Sat, 21 Nov 2026 17:01:05 -0800
Message-ID: <20261122010112.1471146-3-kuba@kernel.org>
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

gro_stats.py carries its own copy of set_ethtool_feat(), which never
reads the features back. The only check whether HW GRO really ended up
enabled is the one guarding the generic XDP workaround, which is about
to go away. Use the shared helper, so that the test can ask for that
check like gro_lib.py does.

A fixed feature now results in an XFAIL rather than a SKIP, same as
in gro_lib.py.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new patch
---
 .../selftests/drivers/net/hw/gro_stats.py     | 45 +++++--------------
 1 file changed, 10 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/gro_stats.py b/tools/testing/selftests/drivers/net/hw/gro_stats.py
index 70e76e3888bd..a413e6fed210 100755
--- a/tools/testing/selftests/drivers/net/hw/gro_stats.py
+++ b/tools/testing/selftests/drivers/net/hw/gro_stats.py
@@ -13,7 +13,7 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
 from lib.py import ksft_eq, ksft_ge, ksft_variants
 from lib.py import NetDrvEpEnv, NetdevFamily
 from lib.py import KsftSkipEx
-from lib.py import bkg, cmd, defer, ethtool, ip
+from lib.py import bkg, cmd, defer, ethtool, ip, set_ethtool_feat
 
 
 # gro.c uses hardcoded DPORT=8000
@@ -137,41 +137,16 @@ def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
             raise KsftSkipEx(f"Driver does not report '{stat}' via qstats")
 
 
-def _set_ethtool_feat(cfg, current, feats):
-    """Set ethtool features with defer to restore original state."""
-    s2n = {True: "on", False: "off"}
-
-    new = ["-K", cfg.ifname]
-    old = ["-K", cfg.ifname]
-    no_change = True
-    for name, state in feats.items():
-        new += [name, s2n[state]]
-        old += [name, s2n[current[name]["active"]]]
-
-        if current[name]["active"] != state:
-            no_change = False
-            if current[name]["fixed"]:
-                raise KsftSkipEx(f"Device does not support {name}")
-    if no_change:
-        return
-
-    eth_cmd = ethtool(" ".join(new))
-    defer(ethtool, " ".join(old))
-
-    # If ethtool printed something kernel must have modified some features
-    if eth_cmd.stdout:
-        ksft_pr(eth_cmd)
-
-
 def _setup_hw_gro(cfg):
     """Enable HW GRO on the device, disabling SW GRO."""
     feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
 
     # Try to disable SW GRO and enable HW GRO
-    _set_ethtool_feat(cfg, feat,
-                      {"generic-receive-offload": False,
-                       "rx-gro-hw": True,
-                       "large-receive-offload": False})
+    set_ethtool_feat(cfg.ifname, feat,
+                     {"generic-receive-offload": False,
+                      "rx-gro-hw": True,
+                      "large-receive-offload": False},
+                     check=False)
 
     # Some NICs treat HW GRO as a GRO sub-feature so disabling GRO
     # will also clear HW GRO. Use a hack of installing XDP generic
@@ -186,10 +161,10 @@ def _run_gro_test(cfg, test_name, num_flows=None, ignore_fail=False,
         # Attaching XDP may change features, fetch the latest state
         feat = ethtool(f"-k {cfg.ifname}", json=True)[0]
 
-        _set_ethtool_feat(cfg, feat,
-                          {"generic-receive-offload": True,
-                           "rx-gro-hw": True,
-                           "large-receive-offload": False})
+        set_ethtool_feat(cfg.ifname, feat,
+                         {"generic-receive-offload": True,
+                          "rx-gro-hw": True,
+                          "large-receive-offload": False})
 
 
 def _check_gro_stats(cfg, test_queue, stats_before,
-- 
2.56.1

