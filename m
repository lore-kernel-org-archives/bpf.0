Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52396369D4F
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666191; cv=none; b=cu+zwVfauvTEr4hln289BENvdJSD5Gz+gPfEPHL3bi2iS340/dCJEiSWR3so4msXZ+BUK5ihWlRjcpObuOTI/YBICawtqo2RXujqqzKuMT/m3f5wjnunAP1KUSpRL6diKNEi/mTsdBY8QRxBBhDY0b+dxJNGbPTJGa5EBglWcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666191; c=relaxed/simple;
	bh=v/XlPMN4fPBfmAxkgYIsWzQxkY2uLOFx2Hx425yLdCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rs3LPG8wnCPU3922ut9rMnwCnzqGgTA46BuPIzoBERjVtNvL4Sc8NERnX+BieIp/vn1328K4yR+2Ax3H3VSUhsZhQSHM95ARIvaGPDVorYFRMQxzjUfOgjsnyNXXL/8fOGjXq1Ze8cxbhLBjyRUST0EwMwJKzdW1x6Tm9a7mWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WzislntM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WzislntM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93e4e37788cso85194985a.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791666187; x=1792270987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jz2Hc1XYfp2QYZMfwSM35lC+Lb6h+/doZovOemukty0=;
        b=WzislntMaHvjSpMec8Vc4/i1wBjX75zqKLRZm8lu7uOqz+NWFO7XkasklP/+dZREZi
         uDbltHc4CpnJC5bQaR2Gppt6X4OPs7+AYqq5K02IdmxhRllw7n6h279iavp9ibm2MIg8
         NtSzaICuv3MnSEXaaIHBfkkcEVJ7SqfmA3SfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666187; x=1792270987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jz2Hc1XYfp2QYZMfwSM35lC+Lb6h+/doZovOemukty0=;
        b=ExInyhRKLiQCUx4SDJ0AuBLBBYmt0VroVBkI1DxD+sL3H6aWvxjyJV0RNQkfRSsXd7
         uwu9THj7VYGfS1LuiYAknw5+tBCQk4SszJH125bKeIM29JzGP05437epNHQ+iKLYhT4q
         8UE50eQj8bdpSaPjf29hC7p2OMWhPIY978tVycV+RJmIBkwfvkMzuoDuRxwlNrOp3dOt
         qDHU7Wehl2dHHaiw9gvjqs8cC28vUg35AOsoYXbUZmw1LWa48qTZSrfFDNyI/rH3se19
         r8PL11RFld35w6F14mPppF7IuP4HZgEkRH+tjQO+DmU0bLwMGTVS2DvvJZhehnhEKoL4
         AWCw==
X-Forwarded-Encrypted: i=1; AKwUvBwl6c2gfhlkIMhOickxIY4i3VyeUj4rbUgDXZJSEfNbMQyMvZEZ6Gug28NDIcD8niNkt74=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXMo1KQEdQCtLlagMFbwOkk4SQSg3uhHXmyQNiZ5wgAc4k5U2f
	zito2sliLKl0jCaZ0VDkQxoOT8YGYJyl/QQMsbcIWAIrUQc+GDZeLxhPW9ie/cGFBw==
X-Gm-Gg: AYBFou0XEicUvsOqk/WAK09e4tM8vTpA5jyGfObHBrh8wUvBwPrAPd8DrMeBBKl8Hv1
	zROnsfWwHBUY6aWUgGIWFB3LoEdnzyKD7Jr5/JmNU9Jr3bk1OkIerYPcAv69pQvRnue/Hgliv8i
	2HWjxwB5BxGjbbkY6l2YK4snsfDkUb/DacLjOen/dJSpZvmYRz4sUHbWuowR9o2Kx38fCQuVKIy
	dQ3f0k7g6tN4SDqcN1svWUwr6wDPie7jjOsmSolZAQ85gFxemYC8JJb7xYXjtWesDTOpbBV7LB7
	57CRU9i6v8n0AfOMWxIttHBzHGwjEal+qgi+fdIRWJGO+1oC8lFsNWa1OGwpSGcOU2wGDGNfn3X
	8WP9y1cKt5MPHgTneyxIANQ3RrN6d3Y5vgmQ4bqfGf6T9dRfjaMa4VHE/18mI2juzU0d04ezpJh
	AWl+n+KCkRtUi77UkValCSsVlUN7W/uu7Z8zRIiovK6IwOosQK8Pt0RXoMwioGu8GqxRcgs5Zbo
	nItXB5UyOcwI8Zwht8Y7RQ2OjF+RnIgHDX77frZIBtQ
X-Received: by 2002:a05:620a:17a0:b0:93e:c12c:f13b with SMTP id af79cd13be357-93ec12d085amr843885885a.69.1791666186988;
        Sat, 10 Oct 2026 14:03:06 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm498538085a.14.2026.10.10.14.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:03:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	bpf@vger.kernel.org,
	victor@mojatatu.com
Subject: [PATCH net v2 3/3] selftests: net: exercise dev-bound cls_bpf on shared blocks
Date: Sat, 10 Oct 2026 17:02:50 -0400
Message-Id: <QDISC-PYC7.v2.20261010165947-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
References: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
bpf_offload.py only exercises per-device ingress qdiscs today, so neither
the shared-block accept path nor the late-join replay is tested.

The Fix:
Add a test for a device-bound SCHED_CLS program attached through a shared
block.  It loads a dev-bound SCHED_CLS program for a netdevsim device and
checks:
  - the program attaches to a shared block owned by its device, and the
    filter teardown leaves the device unloaded;
  - a block that also holds an independently backed device rejects the
    attach, because the offload path broadcasts the program to all
    members;
  - an independently backed device that joins a populated block is not
    loaded by the bind/replay path, and the driver's extack is asserted;
  - a second port of the same netdevsim device (same offload device) is
    accepted together with the bound port.

The program is loaded from the existing sample_ret0.bpf.o with an explicit
`type classifier` override, so no new sample object is needed.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2 (v2 of an on-list patch; v1 posted 2026-10-04):

- New selftest: shared-block + late-join coverage in bpf_offload.py.
- Split the single v2 draft into three patches; this companion carries no
  Fixes: and no Cc: stable (a selftest is not backported; it depends on
  both code patches).
---
 tools/testing/selftests/net/bpf_offload.py | 139 +++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index c856d266c8f3..87e244d8ff05 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -452,6 +452,38 @@ class BpfNetdevSim(NetdevSim):
         self.tc_add_ingress()
         self.wait_for_flush(bound=bound, total=total)
 
+    def tc_add_block(self, block, fail=True, include_stderr=False):
+        return tc("qdisc add dev %s ingress_block %d clsact" %
+                  (self['ifname'], block), fail=fail,
+                  include_stderr=include_stderr)
+
+    def tc_del_block(self, block):
+        tc("qdisc del dev %s clsact" % (self['ifname']), fail=False)
+
+    def tc_add_block_filter(self, block, bpf, op="add", prio=None, handle=None,
+                            da=False, verbose=False, skip_sw=False,
+                            skip_hw=False, fail=True, include_stderr=False):
+        spec = ""
+        if prio is not None:
+            spec += " prio %d" % (prio)
+        if handle:
+            spec += " handle %s" % (handle)
+
+        params = ""
+        if da:
+            params += " da"
+        if verbose:
+            params += " verbose"
+        if skip_sw:
+            params += " skip_sw"
+        if skip_hw:
+            params += " skip_hw"
+
+        return tc("filter {op} block {block} {spec} bpf {bpf} {params}"
+                  .format(op=op, block=block, spec=spec, bpf=bpf,
+                          params=params),
+                  fail=fail, include_stderr=include_stderr)
+
     def tc_show_ingress(self, expected=None):
         # No JSON support, oh well...
         flags = ["skip_sw", "skip_hw", "in_hw"]
@@ -629,6 +661,111 @@ def test_spurios_extack(sim, obj, skip_hw, needle):
                             include_stderr=True)
     check_no_extack(res, needle)
 
+def test_tc_shared_block():
+    """
+    Device-bound cls_bpf program attached through a shared block.
+    """
+    # A shared block has no qdisc, so the target device is derived from the
+    # block's bound netdevs and the program must match every member, since
+    # the offload path broadcasts it to every callback on the block.  A
+    # netdev joining a populated block later is replayed the stored filter
+    # before it is inserted into block->ports, so the driver callback must
+    # enforce the device match as well.
+    simdev = BpfNetdevSimDev()
+    sim, = simdev.nsims
+    sim.set_ethtool_tc_offloads(True)
+
+    start_test("Test TC shared-block load dev-bound program...")
+    bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/tc_shared",
+                      prog_type="classifier", dev=sim['ifname'])
+
+    start_test("Test TC shared-block dev-bound attach...")
+    # The pinned program is dev-bound to this device; attaching it through
+    # a shared block must succeed even though block->q is NULL.
+    sim.tc_add_block(22)
+    # err is kept (include_stderr) for post-mortem value on a failure.
+    ret, _, err = sim.tc_add_block_filter(22, bpf_pinned("/sys/fs/bpf/tc_shared"),
+                                          da=True, skip_sw=True,
+                                          fail=False, include_stderr=True)
+    fail(ret != 0, "dev-bound program rejected on a matching shared block")
+    fail(sim.dfs_read("bpf_offloaded_id") == "0",
+         "dev-bound program not offloaded on a matching shared block")
+    sim.tc_del_block(22)
+
+    start_test("Test TC shared-block broadcast to a foreign member...")
+    # Add an independently backed device to the SAME block before the
+    # attach.  The program is bound to sim's device only, and the offload
+    # path fans it out to every member, so the attach must be rejected.
+    simdev2 = BpfNetdevSimDev()
+    sim2, = simdev2.nsims
+    sim2.set_ethtool_tc_offloads(True)
+    sim.tc_add_block(40)
+    sim2.tc_add_block(40)
+    ret, _, err = sim.tc_add_block_filter(40, bpf_pinned("/sys/fs/bpf/tc_shared"),
+                                          da=True, skip_sw=True,
+                                          fail=False, include_stderr=True)
+    fail(ret == 0, "dev-bound program broadcast to a foreign shared-block member")
+    check_extack(err, "Program is not bound to every device in the block.", args)
+    sim2.tc_del_block(40)
+    sim.tc_del_block(40)
+    simdev2.remove()
+
+    start_test("Test TC shared-block late join replay...")
+    # Build a block owned by sim's device with the matching program
+    # installed, then let an independently backed device join it.  The
+    # join replays the stored filter to the joining device's callback
+    # before the device is recorded in block->ports; the driver must
+    # reject the replay so the foreign device is never loaded.
+    # sim2 is created here (not inherited) so the TC-offload state it
+    # depends on is explicit.
+    simdev2 = BpfNetdevSimDev()
+    sim2, = simdev2.nsims
+    sim2.set_ethtool_tc_offloads(True)
+    sim.tc_add_block(30)
+    ret, _, err = sim.tc_add_block_filter(30, bpf_pinned("/sys/fs/bpf/tc_shared"),
+                                          da=True, skip_sw=True,
+                                          fail=False, include_stderr=True)
+    fail(ret != 0, "dev-bound program rejected on a matching shared block")
+    ret, _, err = sim2.tc_add_block(30, fail=False, include_stderr=True)
+    fail(ret == 0, "foreign device joined a populated dev-bound shared block")
+    check_extack_nsim(err, "program bound to a different device.", args)
+    fail(sim2.dfs_read("bpf_offloaded_id") != "0",
+         "replayed program loaded onto a foreign device")
+    # The add above was expected to fail, so the qdisc may not exist; the
+    # delete is harmless and only cleans up when it does.
+    sim2.tc_del_block(30)
+    sim.tc_del_block(30)
+    simdev2.remove()
+
+    start_test("Test TC shared-block same-offload-device member...")
+    # A second port of the same netdevsim device shares the offload device,
+    # so a program bound to one port may legitimately be offloaded to both.
+    simdev3 = BpfNetdevSimDev(2)
+    sim3, sim3b = simdev3.nsims
+    sim3.set_ethtool_tc_offloads(True)
+    sim3b.set_ethtool_tc_offloads(True)
+    bpftool_prog_load("sample_ret0.bpf.o", "/sys/fs/bpf/tc_shared_multi",
+                      prog_type="classifier", dev=sim3['ifname'])
+    sim3.tc_add_block(50)
+    sim3b.tc_add_block(50)
+    # err kept for post-mortem value on a failure.
+    ret, _, err = sim3.tc_add_block_filter(50, bpf_pinned("/sys/fs/bpf/tc_shared_multi"),
+                                           da=True, skip_sw=True,
+                                           fail=False, include_stderr=True)
+    fail(ret != 0, "same-offload-device member rejected on a shared block")
+    fail(sim3.dfs_read("bpf_offloaded_id") == "0",
+         "program not offloaded to the bound port")
+    fail(sim3b.dfs_read("bpf_offloaded_id") == "0",
+         "program not offloaded to the same-offload-device port")
+    sim3b.tc_del_block(50)
+    sim3.tc_del_block(50)
+
+    simdev3.remove()
+    simdev.remove()
+    rm("/sys/fs/bpf/tc_shared_multi")
+    rm("/sys/fs/bpf/tc_shared")
+    bpftool_prog_list_wait(expected=0)
+
 def test_multi_prog(simdev, sim, obj, modename, modeid):
     start_test("Test multi-attachment XDP - %s + offload..." %
                (modename or "default", ))
@@ -1349,6 +1486,8 @@ try:
     ret, out = bpftool("prog show %s" % (progB), fail=False)
     fail(ret != 0, "couldn't get information about orphaned program")
 
+    test_tc_shared_block()
+
     print("%s: OK" % (os.path.basename(__file__)))
 
 finally:
-- 
2.43.0

