Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596737E317
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021282; cv=none; b=MVUtyak22u9qxlG/0Lt9JDmwjIb22wmMOy1n1H1IuhMWfXOZCa8BP43MBKkCUuryKCp3oyKq+b+s4vgcM0sqzxuFlGrrf5Tt3oOzd47nYqgczYJCh/n0hQGVrtjsEvHNMEr8cI0pLDj/7SJ///WOqwVMygDiHW2ZE/7cudJUX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021282; c=relaxed/simple;
	bh=VD/BrkY+P9EZvzyKieGsPzn58utPMgfLt7RRVf8OBvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfAz7tziUlIjreD70MR3e3HwhAetavJ5RWNMvaBMi395QPP1WjPoy0KUQ5UU801Ni9ABsBmsTe4ZwMTuM674ThxBxWrguVJHYv/32bCofrJpzYJqx+T2AQHUGCd+tc/761j+TrvCT74w/J98lbcDDMEw4Gw9E6CiKr1scyn9Mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ktMLcu5X; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ktMLcu5X"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2721820a12.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1775021280; x=1775626080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dtnjV/UQsHz5i0eYil7AmCFv4jaBC0RE9vTuxD9kdg=;
        b=ktMLcu5XPuPdlQoZ+w0ftcniQbvv+JariVNU6Q9c+4hnjfd7qsJzH4VG244gD0CNzD
         80QtsygCSL1rH9gUYEBMBLGasR5zc9FYK7SlsZfopXTJYlLwfWqOU/VeD1fr0PX3VuwC
         MwZq4Au2bOlLY4zxyEZAlnni5KIPcowzd9pDrBqB1jD93YldM35jpzbTazxnRasJMFDk
         628k6FP+hlHSZJxkOMGFcxreOrW/CEMv77zwtrwv7MCJ/ofnuUaJcRSeFBUcUK5GZucA
         T9AjwI6BjhSCTzGwjUj1Fkq9Q4t+6Vr2hJHi7QxTsCqqHSm91pB1pxFgk5bDs/Q6AbRF
         Dsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021280; x=1775626080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dtnjV/UQsHz5i0eYil7AmCFv4jaBC0RE9vTuxD9kdg=;
        b=mczvXSTdmCJlw0fcDW1GkHRsXdakBL5FFj5lkk9JxRxXE2NRDiPq0RoXqdlWu8t47w
         mreSLiZ9jJ6fHnSs90gTyOM2KJ+arPOmtPwrUUipqdeolX98TODoRgC3KsGS64wQ8wm1
         uoZSclzWDTprlvsWav3x4oGTtBIiMJBAVOvTN3zN5MFEAci8J17CoKl14iCPXjBsO5qx
         Msp7ltMdM+hHlJW7QB8uFSETKBvJm57mDVfFmZL+AvhasIfiDANCDn7PSmRhVD+pE1R1
         kxmH+YtWI7c7hYCoUnXe0aGRZ3bZXItUh9/m1xs0yDgJJNB7tB5NRnPtk0W4dPl0vbGP
         O/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUh6pcnBurtyulp0OEZdHj/VfyEGoh/doqWSE5mrheN/PugJRAe4nGiDL1/ZaKIhQIuI18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCmf2CZ5s7Pw04pZMpWSOvt51QF4y6R24BbE5mI4nCov+ID80
	fqpEs+wJ1/YasXhg5NKtDeWV8tSauoxJEknCYOd67UYP3R2MjmOtnAFWve8ZJmpODdg=
X-Gm-Gg: ATEYQzz/cnRT65RQ1iqGTMlNQhuFVRQ1DLwLEGYIjsfT8tOU3Stxn/YDiMIxOYDbtSC
	kqB5fAV+Y8sPROiKq3NthEH/Xow5l813h9ljqNgDwXIlvPTuT35+F0x1vds2AjudZVhYXZQfzS3
	r0IKA28ibACVUkZiplJPt63mDHQ5rW5iH3BiWecNJGWZps117rWqVFOaC9BgxUHtKa4sdqJF4iR
	lk8nj7bi6x4/KSl4QmuevY6m9FP4xY5KXSfbmlrvopYLAOrRYz18BcWFtQc4gF91QQyhrO/gmd8
	zbwKlnY1cwXP4MgPC7+VNPfx1YJ+f8vPxRtHqyhdBR2iraPESONywx+3tIELfDB9V7dU+T82hkB
	QboCXTdN8p2QjeQyMroTKvvPB9RdnuhNn2JCRY3spsZjc9KtXJtqrFO+qNyhO3TZ4Mz2DyN2QJv
	Dfs/gYDP7ZFKaNWj79Hzo6vq3qCNMKl7/VYI/1zx92JnbstCKNnw==
X-Received: by 2002:a17:902:f708:b0:2b2:6cab:313c with SMTP id d9443c01a7336-2b26cab38b2mr12456065ad.20.1775021280346;
        Tue, 31 Mar 2026 22:28:00 -0700 (PDT)
Received: from bms-ytl-d1-app-10-251-178-27 ([147.136.157.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266b92fsm134019025ad.23.2026.03.31.22.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:27:59 -0700 (PDT)
From: Leon Hwang <leon.huangfu@shopee.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>
Subject: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Date: Wed,  1 Apr 2026 13:27:46 +0800
Message-ID: <20260401052746.314667-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "bpf: Disallow freplace on XDP with mismatched xdp_has_frags values" [1],
these two XDP tests are suggested to add to xdp.py.

1. Verify the failure of attaching non-frag-capable prog to mtu=9k driver.
2. Verify the failure of updating frag-capable prog with non-frag-capable
   prog, when the frag-capable prog attaches to mtu=9k driver.

They have been verified against Mellanox CX6 and Intel 82599ES NICs.

With dropping other tests, here are the test logs.

 # ethtool -i eth0
 driver: mlx5_core
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..2
 ok 1 xdp.test_xdp_native_attach_sb_to_mb
 ok 2 xdp.test_xdp_native_update_mb_to_sb
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

 # ethtool -i eth0
 driver: ixgbe
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..2
 ok 1 xdp.test_xdp_native_attach_sb_to_mb # SKIP RTNETLINK answers: Invalid argument
 ok 2 xdp.test_xdp_native_update_mb_to_sb # SKIP RTNETLINK answers: Invalid argument
 # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:2 error:0

Links:
[1] https://lore.kernel.org/bpf/20260326124205.1a3bb825@kernel.org/

Signed-off-by: Leon Hwang <leon.huangfu@shopee.com>
---
 tools/testing/selftests/drivers/net/xdp.py | 53 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index d86446569f89..fe34b491778b 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -13,7 +13,7 @@ from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
-from lib.py import KsftFailEx, NetDrvEpEnv
+from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
 from lib.py import ip, defer
@@ -693,6 +693,55 @@ def test_xdp_native_qstats(cfg, act):
             ksft_ge(after['tx-packets'], before['tx-packets'])
 
 
+def _set_jumbo_mtu(cfg, mtu):
+    ip(f"link set dev {cfg.ifname} mtu {mtu}")
+    defer(ip, f"link set dev {cfg.ifname} mtu 1500")
+
+
+def _exec_cmd(cfg, obj, sec, ip_opts=""):
+    return cmd(f"ip {ip_opts} link set dev {cfg.ifname} xdpdrv obj {obj} sec {sec}", shell=True, fail=False)
+
+
+def test_xdp_native_attach_sb_to_mb(cfg):
+    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+    mtu = 9000
+
+    _set_jumbo_mtu(cfg, mtu)
+
+    probe = _exec_cmd(cfg, obj, "xdp.frags")
+    if probe.ret != 0:
+        output = probe.stderr.strip() or probe.stdout.strip()
+        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
+
+    ip(f"link set dev {cfg.ifname} xdpdrv off")
+
+    probe = _exec_cmd(cfg, obj, "xdp")
+    if probe.ret == 0:
+        ip(f"link set dev {cfg.ifname} xdpdrv off")
+        raise KsftFailEx(f"driver unexpectedly allows non-multi-buffer XDP at MTU {mtu}")
+
+
+def test_xdp_native_update_mb_to_sb(cfg):
+    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+
+    _set_jumbo_mtu(cfg, 9000)
+
+    attach = _exec_cmd(cfg, obj, "xdp.frags")
+    if attach.ret != 0:
+        output = attach.stderr.strip() or attach.stdout.strip()
+        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
+
+    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
+
+    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
+    if update1.ret != 0:
+        raise KsftFailEx("device fails to update multi-buffer XDP")
+
+    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
+    if update2.ret == 0:
+        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -718,6 +767,8 @@ def main():
                 test_xdp_native_adjst_head_grow_data,
                 test_xdp_native_adjst_head_shrnk_data,
                 test_xdp_native_qstats,
+                test_xdp_native_attach_sb_to_mb,
+                test_xdp_native_update_mb_to_sb,
             ],
             args=(cfg,))
     ksft_exit()
-- 
2.53.0

