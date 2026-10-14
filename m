Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4856E041;
	Wed, 14 Oct 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003594; cv=none; b=L4fSWkVbVL5yqrqrck0y47Ydei1WfcY0TztXXhr8afqCnUxm3NmBgCJKkFfUTTi27BO4VFMV8ZKPOBLRNEKDOFs+oXEI6n6iPRDgki3NWTi0dbXrfZidpKN83Dm9mPY4yyagiXCLM39BCtv+pEj0ysTDJcaUwNgV6ycDINtnEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003594; c=relaxed/simple;
	bh=mdthdzhcdHrPqfFloSKRgMKcHA30mZtwG4tg9oxQRyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r8jOLCsAG0jSmdrxVipnStYsbqdnYwmS1vK3h5p5bxQPiARIKjGpAZIRJmeKJZLFUDuwP+ZjrHj3g44zkDWnld3XvzWjlpSezcFltades2aZpctfrTYrBRnejTDxQkbtgELIjWj0ec4p95T5WwXX1bGGalf0LOn1tc6QSE4oR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxPlu/Jb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxPlu/Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003593; x=1823539593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdthdzhcdHrPqfFloSKRgMKcHA30mZtwG4tg9oxQRyI=;
  b=fxPlu/JbrRyA8BiPUwSjNfW9EbWOw9sLLO/pwfQpAfaxxQSm8Z9SFq2J
   VDZl/BKK9U0Yj3AFSZHAEEQM+zpQCASaimFYIHZDJY1UeZiZsj2dntyVu
   xbrsnk80dPFoGksrjMIQZhhOrDRujgU4Y72/j48UG3EIsR/9IqYt63j2p
   csvcJJzCG+hyKLymyD7KDbJa0T1NHYdD/n1zb3AfWkLaouTmQOeUWwE9A
   yzu5jRdRwuXEqNU7hXkibS/T9J6XXYLjAsKbU3M370oE2/3Z2wtVIyo73
   nrqacJrGJEuYdfkQL6HO78QlpKd5GPz6vbzFhh4NJpb3OSotK/z3xj4Hr
   g==;
X-CSE-ConnectionGUID: QALDTFW+Rfm+tWvSsP8eXw==
X-CSE-MsgGUID: 7iNBE7BeT72o5RDL6HlUng==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767413"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:33 -0700
X-CSE-ConnectionGUID: 4l4HJvcOTg+YwWCjulBvpA==
X-CSE-MsgGUID: pOsBKKpUQWaEFv0oCPYrxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420860"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:31 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net-next 15/15] selftests: xsk: document generic and hardware endpoint runs
Date: Wed, 14 Oct 2026 20:45:39 +0200
Message-Id: <20261014184539.774708-16-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the per-case veth runner and the two-host hardware setup with
a zero-copy DUT and an SKB-mode remote: how each runner drives the
endpoints, what the hardware runner sets up and restores, what both
hosts need and how to run the cases. Point the xskxceiver header
comment to the new README.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/README.rst  | 166 ++++++++++++++++++
 .../selftests/net/lib/xsk/xskxceiver.c        |   2 +
 2 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst

diff --git a/tools/testing/selftests/net/lib/xsk/README.rst b/tools/testing/selftests/net/lib/xsk/README.rst
new file mode 100644
index 000000000000..2bbd11711cee
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/README.rst
@@ -0,0 +1,166 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+xskxceiver
+==========
+
+The AF_XDP engine in ``net/lib/xsk`` is built as ``net/lib/xskxceiver``.
+The generic ``net/test_xsk.py`` test runs SKB and DRV modes over veth.
+
+Generic veth test
+=================
+
+Two ``xskxceiver`` processes own the TX and RX veth interfaces. The TX
+process listens on a TCP control port and the RX process connects. The
+Python runner starts a fresh process pair for each mode and case. A small
+control channel reports readiness, packet progress, and aborts. For example::
+
+  make -C tools/testing/selftests/net/lib
+  cd tools/testing/selftests/net
+  sudo ./test_xsk.py
+
+Each case creates its own veth pair and picks a random control port.
+``test_xsk`` runs each case that ``xskxceiver -l`` lists in SKB and DRV
+mode, and ``test_xsk_busy_poll`` runs them again with busy polling.
+``XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF`` is left out, as it leaks page_pool
+pages on veth, and so is ``XDP_ADJUST_TAIL_GROW``, as veth leaves no room
+to grow most frames. The runner reserves 32 huge pages for the UNALIGNED
+cases and restores the count when it ends, and leaves those cases out when
+it cannot reserve them.
+``-t`` selects cases, e.g. ``-t 'test_xsk.drv_*'``. ``-l`` and ``-h`` are
+not supported, as the runner would exit on them before it restores the
+huge-page count. The generic frame format is unchanged.
+
+Hardware zero-copy test
+=======================
+
+``drivers/net/hw/xsk.py`` runs each case that ``xskxceiver -L`` lists, in
+each DUT direction listed with it, and owns the TAP results.
+``test_xsk.h`` groups the cases by the DUT directions in which they run.
+
+It starts one ``xskxceiver`` process on each host for each case. The DUT
+runs in ZC mode; the remote runs in SKB mode and does not need zero-copy.
+RX and TX cases are named separately in TAP, e.g.
+``test_xsk.rx_SEND_RECEIVE`` and ``test_xsk.tx_SEND_RECEIVE``. The
+hardware runner skips a DUT that does not advertise AF_XDP zero-copy. The
+DUT endpoint binds with ``XDP_ZEROCOPY``, which fails instead of falling
+back to copy mode, so an advertised device that cannot bind or run a case
+fails it.
+
+``xsk.py`` starts the remote XSK endpoint first. It listens on a TCP
+control port on ``REMOTE_V4``, and the DUT endpoint connects to it over
+the tested link. The listener prints a line on stderr once it listens, so
+``xsk.py`` starts the DUT endpoint without polling the remote for the
+port. The listener waits 30 seconds for its peer, and ``xsk.py`` as long
+for that line. The small per-case channel reports readiness, packet
+progress, and aborts. It has no capabilities or verdict handshake.
+``xsk.py`` chooses the case, sets the timeout, and reports the result
+from both process exit codes. Each endpoint sees only its own device and
+mode, so a case that either endpoint skips is reported as skipped. Killing
+an SSH client does not stop the command it runs, so the remote endpoint
+runs under ``timeout(1)``, and ``xsk.py`` waits for it to exit before the
+case ends.
+
+Both XSK endpoints generate and validate raw IPv4/UDP frames with one UDP
+port, which ``xsk.py`` picks at random for the run, so ntuple rules can
+steer the test flow. They do not use AF_INET sockets. ``xsk.py`` takes
+the last DUT queue that has both an RX and a TX ring out of RSS and binds
+the DUT endpoint to it. For DUT RX cases it steers the test flow to that
+queue, and for DUT TX cases to queue 0 on the remote receiver. A TX-only
+zero-copy socket fills no RX buffers, so its queue drops what it
+receives, and TX cases keep that queue out of RSS as well.
+The XDP programs redirect only the test flow and pass all other traffic,
+the control connection included, to the stack, so the tested link does
+not have to be otherwise idle.
+
+``xsk.py`` sets up the queue, the ntuple rules and huge pages for the
+UNALIGNED cases once, before the cases run, and undoes them when the run
+ends. The run is skipped when either host has no ntuple support,
+and the UNALIGNED cases are left out when either host cannot
+reserve the huge pages. Each endpoint detaches its XDP program and
+restores any changed ring sizes and the MTU before it exits. Cases that
+do not need larger frames default to an MTU of 1500 (``ETH_DATA_LEN``),
+and the SKB-mode remote endpoint only raises its MTU when a case needs a
+larger one, as changing the MTU can reset the NIC. Once both endpoints
+are ready, each waits for its link before sending, as such a reset can
+take the link down on both hosts. The runner gives the queue back to RSS
+with ``ethtool -X default`` and restores the ntuple setting and the
+huge-page count. After an endpoint fails or is killed, the runner also
+detaches the XDP program and restores the MTU. The runner does not change
+channel counts. A DUT with fewer than two queues that have both rings
+skips all cases, as it has no queue to take out of RSS.
+
+The remote is either another host (``REMOTE_TYPE=ssh``) or the peer port
+of the same host moved to a network namespace (``REMOTE_TYPE=netns``).
+The framework runs the remote commands for either backend. Both endpoints
+run as root.
+
+Setup
+-----
+
+Build the engine on the DUT::
+
+  make -C tools/testing/selftests/net/lib
+
+A top-level selftests build with ``TARGETS=drivers/net/hw`` includes
+``net/lib`` as well.
+
+Configure the usual driver test variables in
+``tools/testing/selftests/drivers/net/hw/net.config`` or the environment::
+
+  NETIF=eth0
+  LOCAL_V4=192.0.2.1
+  REMOTE_V4=192.0.2.2
+  REMOTE_TYPE=netns
+  REMOTE_ARGS=xsk-peer
+
+``REMOTE_ARGS`` names the namespace that holds the peer port. With eth0
+connected back to back to eth1 of the same host, set it up as root::
+
+  ip netns add xsk-peer
+  ip link set eth1 netns xsk-peer
+  ip -n xsk-peer link set lo up
+  ip -n xsk-peer addr add 192.0.2.2/24 dev eth1
+  ip -n xsk-peer link set eth1 up
+  ip addr add 192.0.2.1/24 dev eth0
+  ip link set eth0 up
+
+Run as root on the DUT::
+
+  cd tools/testing/selftests/drivers/net/hw
+  sudo ./xsk.py -t test_xsk.rx_SEND_RECEIVE
+
+``xskxceiver -L`` lists the cases. ``xsk.py`` does not support ``-l`` and
+``-h``, as it would exit on them before it undoes the setup of both hosts.
+Omit ``-t`` to run all cases.
+Set the variables in ``net.config`` when using ``sudo`` so they are
+available to the test process.
+
+``test_xsk`` runs each case with the DUT endpoint driven by interrupts.
+``test_xsk_busy_poll`` runs the same cases again with the DUT endpoint
+busy polling as in the busy-poll pass of ``test_xsk.py``, e.g.
+``-t 'test_xsk_busy_poll.*'``. Each of its cases sets
+``napi_defer_hard_irqs`` and ``gro_flush_timeout`` on the DUT to the
+values ``test_xsk.py`` uses on veth and restores them when it ends. The
+remote endpoint does not busy poll.
+
+With SSH, each case starts its remote endpoint over SSH. SSH connection
+sharing for the remote host (``ControlMaster``, ``ControlPath`` and
+``ControlPersist`` in ssh_config(5)) avoids a new SSH login for each remote
+command. With ``sudo``, that is root's SSH configuration.
+
+The remote host needs AF_XDP in SKB mode, BPF and ``timeout(1)``. In a
+namespace, the remote endpoint runs the DUT's ``xskxceiver`` binary. With
+SSH, ``xsk.py`` copies that binary to the remote, so both hosts must have
+compatible architectures and libraries. The DUT needs RSS support, and
+both hosts need ntuple support. The test uses ``NetDrvEpEnv`` and the
+networking selftest Python helpers for setup and rollback.
+
+The hardware list covers baseline traffic, 2K frames, single packets,
+poll, headroom, invalid TX descriptors, socket statistics, XDP program
+cleanup, XDP drop, metadata, tail adjustment, multi-buffer, 9K,
+unaligned traffic, HW ring sizes, and socket teardown.
+For ``TOO_MANY_FRAGS``, the runner reads the DUT's ``xdp-zc-max-segs``
+value and passes it to both endpoint processes so the SKB peer validates
+the same packet stream without a capabilities exchange. A DUT without
+multi-buffer zero-copy does not list the case.
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 7705a9f2b7a1..1d740d7a5e7e 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -9,6 +9,8 @@
  * See test_xsk.py for detailed information on test topology
  * and prerequisite network setup.
  *
+ * See README.rst for the generic and hardware test setup.
+ *
  * Each instance of this test program runs one endpoint, Tx or Rx, with a
  * single socket and a unique UMEM. Two instances validate in-order packet
  * delivery and packet content by sending packets to each other.
-- 
2.43.0

