Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0149A3D6;
	Mon, 28 Sep 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635014; cv=none; b=sQcFh77IS/+TiemXtKejO78alYCW90+Z6RxscLGgmYM6LUM7y2bYbrw22Iq0Fxo/G/TD4+rG2oeUyXxikEMo1IEZ3XTcJ1VlXq6hTfrcOrRFo8eqYooiNuvnqO0Ir6PzMjLoI4U/7dxm8AYTKzj2UqXoGG1FM/1ZYbuh4gaVrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635014; c=relaxed/simple;
	bh=CFgkAhQwEqccWgELEg/9JK2GKL5SpQfgGzA5vZ0YqHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo9Ld2xyP0oqqyz6rXVxrDcJhugS2lHCAPgvn0w0Tc+sOF9Exw/FnOtFEL8ShTjA1XWm33PiTiSr+qUuaG8uMVu4i2l7U1vZV7lBkNXySc0GM8ajKyj2b40buHxapigRnpSxPNsBRzy4DVsE+lAPVuLd/9VcxupP/TQq7hRD8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE6hrjtw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE6hrjtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239391F0089C;
	Mon, 28 Sep 2026 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635012;
	bh=7WMv94dmHQt/4IHOC7Zem7o5TU9iTHRnxfl7eBmQS3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VE6hrjtwsggVYnjlHNSYVBvUvLJbaC9BtLFDMJjQWNE77yyC6nte/gCMT6E9/qkDV
	 7J+hxoo6EuczjsKy4eTmh/EEN/DW0p+m5CnQISTCyBP0xZH5wEdTXc4ynt9pJBpxbX
	 I/umhkLd0+zup+vNuifIWnvwL/asOgvgz2/U+FVD67vny/cjJVXtwHFhLCpxtPGECp
	 HH5pOTRefwsiEsUtr9wSptRvEOBCOnSJec4RH9jg5oAXpojSW0hcZXfiCyvvXdzcfD
	 FjHpQ9e2Ji9cg50zRKSIkcdDP8KyXCljGovLApBI18J5KV87vK+wZag8Cu1kgjUyFq
	 fmLHs1sY0h8Cw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	emil@etsalapatis.com,
	liuhangbin@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] selftests: drv-net: check tcp-data-split against an already attached XDP
Date: Mon, 28 Sep 2026 15:36:46 -0700
Message-ID: <20260928223648.2739371-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223648.2739371-1-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hds.py only ever tested one direction of the rule: with header-data
split on, installing a single-buffer XDP program must fail. The other
direction was not covered at all, and that is the one which was broken
for a program an upper device pushed down - the device was running XDP
but nothing in the core knew, so enabling tcp-data-split underneath it
succeeded.

xdp_set_hds() covers the direct case, xdp_bond_set_hds() the propagated
one. The latter fails without the preceding fix.

The bond case is disruptive, it takes the device down to enslave it, and
skips on devices bonding will not take as an XDP slave.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/config |  1 +
 tools/testing/selftests/drivers/net/hds.py | 65 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index 4838adf27fa1..29293e41c3fa 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -1,3 +1,4 @@
+CONFIG_BONDING=m
 CONFIG_CONFIGFS_FS=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 606e26d75951..5fe82b98c1fb 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -6,6 +6,7 @@ import os
 import random
 from typing import Union
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
+from lib.py import ksft_disruptive
 from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import defer, ethtool, ip
@@ -28,6 +29,21 @@ from lib.py import defer, ethtool, ip
     ip("link set dev %s xdp off" % cfg.ifname)
 
 
+def _xdp_attach(cfg, ifname):
+    """Attach a single-buffer XDP program, detach it when the test ends."""
+    prog = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+    ip(f"link set dev {ifname} xdp obj {prog} sec xdp")
+    defer(ip, f"link set dev {ifname} xdp off")
+
+
+def _hds_enable_expect_fail(cfg, netnl):
+    """Enabling HDS must be refused while single-buffer XDP is attached."""
+    with ksft_raises(NlError) as e:
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled'})
+    ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
+
+
 def _ioctl_ringparam_modify(cfg, netnl) -> None:
     """
     Helper for performing a hopefully unimportant IOCTL SET.
@@ -240,6 +256,53 @@ from lib.py import defer, ethtool, ip
         _xdp_onoff(cfg)
 
 
+def xdp_set_hds(cfg, netnl) -> None:
+    """
+    Enable single-buffer XDP on the device, then try to enable HDS.
+    The mirror of enabled_set_xdp(): HDS must be refused.
+    """
+    mode = _get_hds_mode(cfg, netnl)
+    _defer_reset_hds(cfg, netnl)
+    if mode == 'enabled':
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'unknown'})
+
+    _xdp_attach(cfg, cfg.ifname)
+
+    _hds_enable_expect_fail(cfg, netnl)
+
+
+@ksft_disruptive
+def xdp_bond_set_hds(cfg, netnl) -> None:
+    """
+    Like xdp_set_hds(), but the program is installed on a bond and pushed
+    down to the device rather than attached to it directly. The device is
+    running it either way, so HDS must be refused all the same.
+    """
+    mode = _get_hds_mode(cfg, netnl)
+    _defer_reset_hds(cfg, netnl)
+    if mode == 'enabled':
+        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'unknown'})
+
+    ip("link add hds-bond type bond mode active-backup")
+    defer(ip, "link del hds-bond")
+
+    # bonding refuses to enslave a device which is up
+    ip(f"link set dev {cfg.ifname} down")
+    defer(ip, f"link set dev {cfg.ifname} up")
+    ip(f"link set dev {cfg.ifname} master hds-bond")
+    defer(ip, f"link set dev {cfg.ifname} nomaster")
+    ip("link set dev hds-bond up")
+
+    try:
+        _xdp_attach(cfg, "hds-bond")
+    except CmdExitFailure:
+        raise KsftSkipEx("device can't be an XDP bond slave")
+
+    _hds_enable_expect_fail(cfg, netnl)
+
+
 def ioctl(cfg, netnl) -> None:
     mode1 = _get_hds_mode(cfg, netnl)
     _ioctl_ringparam_modify(cfg, netnl)
@@ -290,6 +353,8 @@ from lib.py import defer, ethtool, ip
                   set_hds_thresh_gt,
                   set_xdp,
                   enabled_set_xdp,
+                  xdp_set_hds,
+                  xdp_bond_set_hds,
                   ioctl,
                   ioctl_set_xdp,
                   ioctl_enabled_set_xdp],
-- 
2.55.0

