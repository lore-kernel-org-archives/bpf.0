Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DF59B666;
	Fri, 16 Oct 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172672; cv=none; b=nBaEzmgI5bpapGfFi0n1AHLt00Ov5ZF52vyz4usbJ4DfoWHgS9onEpS+3lr5MpWztjAi5KMHFomst7gk6DMUE690RJQJ0uyZZn8ooTqyyUvy5MYHPsWzfAWkxgzNGUxHH6EieQ6tGcaO21Pad5nY/OZYqaHx1Scpq4TH6IYO73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172672; c=relaxed/simple;
	bh=/mVr0IsBWu2iwGuTNi9J9/x05O+fYD4j8OVfuI/xfxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=inh6IryaUJuwO8j3NvX2Hm3c/aVkYIUmwQsHv0LHk9w1AtroVLQQqf1+jdyRBmruwaeegd8onvk1+7u2sKq7qv20oSghVlsCbm8Wa1ilO2VrasD13bmpS1BNo1HzrIv5q5bSgXR3Tv42pLjzPVechnfJ0sfQyDpmpO54fvXvE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1YFIDQ+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1YFIDQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172669; x=1823708669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mVr0IsBWu2iwGuTNi9J9/x05O+fYD4j8OVfuI/xfxU=;
  b=e1YFIDQ+aYyxdhHUeKJSBVeb0MPXC/U2DzimqztbHQB0wZCwm6nsfwY0
   OOSze3xpHtDKLNT9KStgqhgeam07EGwqMYu/jbnTDdcN8RHOI1IfCBHC9
   3EFbbBmKzPFPpEZLU6I13uWTS0eSPBhdAJGkJgR5Ebki8kFyogEsDfXFC
   Ewwa9omfuQVWBN3iCQ9VSE9Y9CitW7wmTmOX3ifGTWheQ93+rLADGs2oh
   DZZ76jNWRPM3eUik7DY0erlvCf9PevlXIxFEwNYgKuOymx984XE9pclBy
   TCh8LvW+eNt8wGqNZt3otDPGgcfCswTe26cSxbZT4LGqKoXmeEY2hWtQs
   w==;
X-CSE-ConnectionGUID: sWTewCrzTgmC5XyLsUepKw==
X-CSE-MsgGUID: cMAgBv9DT1mIL8tbIxSUpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972419"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972419"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:28 -0700
X-CSE-ConnectionGUID: 98vRNAwkTY2+B5coVBbVjQ==
X-CSE-MsgGUID: oVOjR92NRHyMay6dQw/b8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425289"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:44:26 -0700
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
Subject: [PATCH v4 net-next 15/15] selftests: xsk: document generic and hardware endpoint runs
Date: Fri, 16 Oct 2026 19:43:38 +0200
Message-Id: <20261016174338.787135-16-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the frames that the endpoints exchange, the per-case veth
runner and the two-host hardware setup with a zero-copy DUT and an
SKB-mode remote: how each runner drives the endpoints, what the hardware
runner sets up and restores, what both hosts need and how to run the
cases. Point the xskxceiver header comment to the new README.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/net/lib/xsk/README.rst  | 194 ++++++++++++++++++
 .../selftests/net/lib/xsk/xskxceiver.c        |   2 +
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst

diff --git a/tools/testing/selftests/net/lib/xsk/README.rst b/tools/testing/selftests/net/lib/xsk/README.rst
new file mode 100644
index 000000000000..00d626125a99
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/README.rst
@@ -0,0 +1,194 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+xskxceiver
+==========
+
+The AF_XDP engine in ``net/lib/xsk`` is built as ``net/lib/xskxceiver``.
+The generic ``net/test_xsk.py`` test runs SKB and DRV modes over veth.
+
+Each ``xskxceiver`` endpoint generates and validates raw UDP frames over
+IPv4 or IPv6. It sends them from ``--src-ip`` to ``--dst-ip``, the address
+of its peer, via ``--dst-mac``, the MAC address of its next hop to the
+peer, and to UDP port ``--udp-port``. Over IPv4, the UDP checksum is
+zero. The UDP source port tells the sockets of ``XDP_SHARED_UMEM`` apart.
+The endpoints do not use AF_INET sockets for the test traffic. The XDP
+programs redirect only UDP packets to ``--udp-port`` and pass all other
+traffic to the stack.
+
+Generic veth test
+=================
+
+Two ``xskxceiver`` processes own the TX and RX veth interfaces. The TX
+process listens on a TCP control port (``--listen``) and the RX process
+connects. The Python runner starts a fresh process pair for each mode and
+case. A small control channel reports readiness, packet progress, skips,
+and aborts. For example::
+
+  make -C tools/testing/selftests/net/lib
+  cd tools/testing/selftests/net
+  sudo ./test_xsk.py
+
+Each case creates its own veth pair and picks a random control port and
+UDP port. The endpoints send UDP over IPv6 between two documentation
+addresses, which the veths do not need to have, and to the MAC address of
+the peer veth.
+``test_xsk`` runs each case that ``xskxceiver -l`` lists in SKB and DRV
+mode, and ``test_xsk_busy_poll`` runs them again with busy polling.
+``XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF`` is left out, as it leaks page_pool
+pages on veth, and so is ``XDP_ADJUST_TAIL_GROW``, as veth leaves no room
+to grow most frames. The runner reserves 32 huge pages of 2 MiB for the
+UNALIGNED cases and restores the count however the run ends, and leaves
+those cases out when it cannot reserve them.
+``-t`` selects cases, e.g. ``-t 'test_xsk.drv_*'``, and ``-l`` lists them.
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
+control port on the remote address, and the DUT endpoint connects to it
+over the tested link. The listener prints a line on stderr once it
+listens, so ``xsk.py`` starts the DUT endpoint without polling the remote
+for the port. The listener waits 30 seconds for its peer, and ``xsk.py``
+as long for that line. The small per-case channel reports readiness,
+packet progress, skips, and aborts. It has no capabilities or verdict
+handshake. ``xsk.py`` chooses the case, sets the timeouts, and reports
+the result from both process exit codes. Each endpoint sees only its own
+device and mode. One that skips a case tells its peer on the control
+channel, which skips the case as well, and ``xsk.py`` reports a case as
+skipped when one endpoint skips it and the other skips or passes it.
+Killing an SSH client does not stop the command it runs, so the remote
+endpoint runs under ``timeout(1)``, and ``xsk.py`` waits for it to exit
+before the case ends.
+
+The endpoints send UDP over IPv6 when ``LOCAL_V6`` and ``REMOTE_V6`` are
+set and over IPv4 otherwise, between the addresses of the two hosts. Each
+sends to the MAC address of its next hop to the other host, which is the
+peer interface on a shared link and the gateway otherwise. ``xsk.py``
+picks the UDP port at random for the run, so ntuple rules can steer the
+test flow. It takes the last DUT queue that has both an RX and a TX ring
+out of RSS and binds the DUT endpoint to it. For DUT RX cases it steers
+the test flow to that queue, and for DUT TX cases to queue 0 on the
+remote receiver. A TX-only zero-copy socket fills no RX buffers, so its
+queue drops what it receives, and TX cases keep that queue out of RSS as
+well. Accelerated RFS, which ntuple filters turn on in some drivers,
+could still steer the control connection to that queue, so RFS has to
+stay off on the DUT, as it is by default. As the XDP programs pass the
+control connection and all other traffic to the stack, the tested link
+does not have to be otherwise idle.
+
+``xsk.py`` sets up the queue, the ntuple rules and huge pages for the
+UNALIGNED cases once, before the cases run, and undoes them however the
+run ends. The run is skipped when either host has no ntuple support or
+rejects the ntuple rule, and the UNALIGNED cases are left out when either
+host cannot reserve the huge pages. Each endpoint detaches its XDP program
+and restores the MTU before it exits. Cases that do not need larger frames
+default to an MTU of 1500 (``ETH_DATA_LEN``), and the SKB-mode remote
+endpoint only raises its MTU when a case needs a larger one, as changing
+the MTU can reset the NIC. Before the endpoints start, ``xsk.py`` sets
+with ``ethtool -G`` the TX ring of the sending interface to 64 descriptors
+for HW_SW_MIN_RING_SIZE, and for HW_SW_MAX_RING_SIZE the TX ring of the
+sending interface and the RX ring of the receiving one to their maximum
+sizes, which can reset the NIC as well. Once both endpoints are ready,
+each waits for its link before sending, as such a reset can take the
+link down on both hosts, and ``xsk.py`` raises the traffic and link
+timeouts of the endpoints to 20 seconds with ``--timeout``. When the run
+ends, the runner resets the RSS indirection table of the DUT with
+``ethtool -X default``, writes the saved table back if it was not the
+default, and restores the ntuple setting and the huge-page count. It
+restores the ring sizes after the case however the endpoints end, and
+after an endpoint fails or is killed, it also detaches the XDP program
+and restores the MTU. A host whose ring sizes ``ethtool -g`` cannot read
+skips the two ring cases.
+The runner does not change channel counts. A DUT with fewer than two
+queues that have both rings skips all cases, as it has no queue to take
+out of RSS. So does a DUT that cannot take one out of RSS.
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
+Set ``LOCAL_V6`` and ``REMOTE_V6`` as well to test over IPv6, with the
+addresses added ``nodad``. ``REMOTE_ARGS`` names the namespace that holds
+the peer port. With eth0 connected back to back to eth1 of the same host,
+set it up as root::
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
+``xskxceiver -L`` lists the cases, and ``xsk.py -l`` the names to pass to
+``-t``. Omit ``-t`` to run all cases.
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
+unaligned traffic, HW ring sizes, socket teardown, and shared UMEM.
+For ``TOO_MANY_FRAGS``, the runner reads the DUT's ``xdp-zc-max-segs``
+value and passes it to both endpoint processes so the SKB peer validates
+the same packet stream without a capabilities exchange. A DUT without
+multi-buffer zero-copy does not list the case.
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index a4a66c9ebde2..e8cd3529d169 100644
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

