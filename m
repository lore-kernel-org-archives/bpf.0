Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61268436BF4;
	Thu,  8 Oct 2026 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460200; cv=none; b=cloeJbZnVOdq0p9wbBfPEtu33MEcN2SqG7cgtIyVcoNr/sAi0saU2xuZqvzeP+Wu0dTv8l1obZHpwSPa92JaXlxaKVb73aEMerZLwxqf7MLfCgYT+KF3Qs323pkwL1aHzt7X+ukiyhgsBHZywtFKuYapXsDXLnLlTb11/HxXzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460200; c=relaxed/simple;
	bh=E9geH52L9w96yxC9y/1VqVsanYaI27E4swGbeTPfA0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSnwsn+LA18B6qF7uUaSORZrbh71bKdDDm0PhMiueK+GHdDBypJdN0l8sLSLFOjAhnyOEiA6hAikxOBl2yafjnMDkYOvFaqWEgbTKdq7TeLwPXi1d8G7zHR65ml929E1QN2bCGHEOcw0VQqRvDW54SeN9NP1R8Yk/Hsn7LJS35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJExHgjn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJExHgjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460198; x=1822996198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9geH52L9w96yxC9y/1VqVsanYaI27E4swGbeTPfA0w=;
  b=XJExHgjnZCHpFW6pLUWlU5sIrXYQWhSSJBWQpYlNfXbWFgiGU4BYSCU6
   VosG6bxWhrrbgYpJkze4LTm5kljqhQapNzEtjLhDY+FeLPsbL8Zw/VECu
   j5kdBkpSLKp37aN04t1uHsu4+mQEsD0eUYSf//EcBjNpoOK7LUscnIeTl
   r1zcOyIHO2/XOnkNFHJGb1XAX201R/eOZ6BGe/VX1GwPdHKeUYb8mapVQ
   jVu1WvkPvounVBWVtjGtU7wOgmD5WHV69xIDbmvQHdbyJxpb98+q703My
   MkCQDjAhkwyQ1vrCT44gmKEHKXZ1BrA94A9E8wt7PEgsTSY+8Gktfp9pW
   g==;
X-CSE-ConnectionGUID: Lkd9/nwYRgehsFtxGqMSfg==
X-CSE-MsgGUID: qH5FwFLgSs6o7rCwFcnwdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124999"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:58 -0700
X-CSE-ConnectionGUID: iqmmNXg9SImufhWrTEvzMA==
X-CSE-MsgGUID: gP8kfgQvRmWEp58bgyjm1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467222"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:56 -0700
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
Subject: [PATCH v2 net-next 14/14] selftests: xsk: document generic and hardware endpoint runs
Date: Thu,  8 Oct 2026 13:49:09 +0200
Message-Id: <20261008114909.734364-15-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the per-case veth launcher and the two-host hardware setup
where the DUT uses AF_XDP zero-copy and the remote xskxceiver uses SKB
mode.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../testing/selftests/drivers/net/README.rst  |   7 +
 .../testing/selftests/net/lib/xsk/README.rst  | 138 ++++++++++++++++++
 .../selftests/net/lib/xsk/xskxceiver.c        |   2 +
 3 files changed, 147 insertions(+)
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index 3fe49bce4f3a..c62443a4cbfc 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -141,6 +141,13 @@ Communication channel dependent::
   for netns - name of the "remote" namespace
   for ssh - name/address of the remote host
 
+Test specific variables
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Some tests read further variables from the same environment or
+``net.config``. ``hw/xsk.py`` and its ``XSK_*`` variables are described in
+``tools/testing/selftests/net/lib/xsk/README.rst``.
+
 Example
 =======
 
diff --git a/tools/testing/selftests/net/lib/xsk/README.rst b/tools/testing/selftests/net/lib/xsk/README.rst
new file mode 100644
index 000000000000..d0a0a902ed78
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/README.rst
@@ -0,0 +1,138 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+xskxceiver
+==========
+
+The AF_XDP engine in ``net/lib/xsk`` is built as ``net/lib/xskxceiver``.
+The generic ``net/test_xsk.sh`` test runs SKB and DRV modes over veth.
+
+Generic veth test
+=================
+
+Two ``xskxceiver`` processes own the TX and RX veth interfaces. The TX
+process listens on a TCP control port and the RX process connects. The
+shell wrapper starts a fresh process pair for each mode and case. A small
+control channel reports readiness, packet progress, and aborts. For example::
+
+  make -C tools/testing/selftests/net/lib
+  cd tools/testing/selftests/net
+  sudo ./test_xsk.sh
+
+The shell wrapper creates the veth pair. ``-m skb|drv`` selects a mode,
+``-t`` selects a test by the name or number shown by ``xskxceiver -l``,
+and ``-p N`` selects a fixed control port instead of the default random
+port. The generic frame format is unchanged.
+
+Hardware zero-copy test
+=======================
+
+``test_xsk_case_defs.h`` defines the cases for both ``xskxceiver`` and
+``drivers/net/hw/xsk.py``, and the DUT directions in which the Python
+runner runs each of them. The runner reads this list and owns the TAP
+results.
+
+It starts one ``xskxceiver`` process on each host for each case. The DUT
+runs in ZC mode; the remote runs in SKB mode and does not need zero-copy.
+RX and TX cases are named separately in TAP. The hardware runner skips a
+DUT that does not advertise AF_XDP zero-copy. The DUT endpoint binds with
+``XDP_ZEROCOPY``, which fails instead of falling back to copy mode, so an
+advertised device that cannot bind or run a case fails it.
+
+The remote XSK endpoint listens on a TCP control port and the DUT connects.
+The listener prints a line on stderr once it listens, so ``xsk.py`` starts
+the DUT endpoint without polling the remote for the port. The small
+per-case channel reports readiness, packet progress, and aborts. It has no
+capabilities or verdict handshake. ``xsk.py`` chooses the case, sets the
+timeout, and reports the result from both process exit codes.
+
+Both XSK endpoints generate and validate raw IPv4/UDP frames with one fixed
+UDP port, so ntuple rules can steer the test flow. They do not use AF_INET
+sockets. On DUT RX cases ``xsk.py`` reserves the last RX queue outside RSS
+and steers test traffic to it. On DUT TX cases it steers traffic to queue 0
+on the remote receiver. The XDP programs redirect only the test flow and
+pass all other traffic to the stack, so the tested link does not have to
+be otherwise idle.
+Each case sets up only what its direction needs and undoes it when the
+case ends, so a setup failure skips only the cases that need that setup.
+Each endpoint detaches its XDP program and restores any changed ring sizes
+and the MTU before it exits. The SKB-mode remote endpoint only raises its
+MTU when a case needs a larger one, as changing the MTU can reset the NIC.
+The runner restores the RSS table, ntuple setting, and huge-page count.
+After an endpoint fails or is killed, the runner also detaches the XDP
+program and restores the MTU. The runner does not change channel counts.
+A one-channel DUT skips RX cases because it has no queue to reserve
+outside RSS.
+
+The remote is either another host (``REMOTE_TYPE=ssh``) or the peer port
+of the same host moved to a network namespace (``REMOTE_TYPE=netns``).
+With SSH, the control channel goes to the ``REMOTE_ARGS`` host. In a
+namespace, the remote endpoint runs the DUT's binary through
+``ip netns exec`` and the control channel goes to ``REMOTE_V4`` over the
+tested link. The DUT TX socket fills no RX buffers, so its zero-copy queue
+drops what it receives; with a namespace remote, DUT TX cases also reserve
+that queue outside RSS, so a one-channel DUT skips them as well.
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
+  REMOTE_TYPE=ssh
+  REMOTE_ARGS=user@remote.example.com
+  XSK_REMOTE_BIN=/path/to/remote/xskxceiver
+  XSK_REMOTE_SUDO=1
+
+Run as root on the DUT::
+
+  cd tools/testing/selftests/drivers/net/hw
+  sudo ./xsk.py -t test_xsk.rx_send_receive
+
+``./xsk.py -l`` lists the case names. Omit ``-t`` to run the full hardware
+matrix. Set the variables in ``net.config`` when using ``sudo`` so they are
+available to the test process.
+
+``./xsk.py -b`` runs the same cases as ``test_xsk_busy_poll`` instead, with
+the DUT endpoint busy polling as in the busy-poll pass of ``test_xsk.sh``.
+Each case then sets ``napi_defer_hard_irqs`` and ``gro_flush_timeout`` on
+the DUT to the values ``test_xsk.sh`` uses on veth and restores them when
+it ends. The remote endpoint does not busy poll.
+
+With SSH, each case starts its remote endpoint over SSH, and a DUT TX case
+also adds and removes a flow steering rule on the remote. SSH connection
+sharing for the remote host (``ControlMaster``, ``ControlPath`` and
+``ControlPersist`` in ssh_config(5)) avoids a new SSH login for each remote
+command. With ``sudo``, that is root's SSH configuration.
+
+The remote host needs AF_XDP in SKB mode and BPF. ``xsk.py`` copies the
+DUT's ``xskxceiver`` binary to the remote, so both hosts must have
+compatible architectures and libraries. ``XSK_REMOTE_BIN`` chooses a fixed
+destination path for that copy. Set ``XSK_REMOTE_DEPLOY=0`` to use a binary
+built on the remote from the same test case definitions instead.
+``XSK_REMOTE_SUDO=1`` runs the remote endpoint and setup commands through
+passwordless ``sudo -n``; omit it when SSH logs in as root. The DUT needs
+ntuple and RSS support for RX cases, while the remote needs ntuple support
+for DUT TX cases. The test uses ``NetDrvEpEnv`` and the networking selftest
+Python helpers for setup and rollback.
+
+With SSH, the DUT uses the SSH host name to connect to the remote control
+listener.
+``XSK_UDP_PORT`` changes the fixed test UDP port (default 42567). The remote
+listens on all addresses for control.
+
+The hardware list covers baseline traffic, 2K frames, poll, headroom,
+invalid TX descriptors, TX invalid-descriptor statistics, metadata, 9K,
+and unaligned traffic. For ``TOO_MANY_FRAGS``, the runner reads the DUT's
+``xdp-zc-max-segs`` value and passes it to both endpoint processes so the
+SKB peer validates the same packet stream without a capabilities exchange.
diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
index 8b94dc3709ea..510cb8e4e054 100644
--- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
+++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
@@ -9,6 +9,8 @@
  * See test_xsk.sh for detailed information on test topology
  * and prerequisite network setup.
  *
+ * See README.rst for the generic and hardware test setup.
+ *
  * Each instance of this test program runs one endpoint, Tx or Rx, with a
  * single socket and a unique UMEM. Two instances validate in-order packet
  * delivery and packet content by sending packets to each other.
-- 
2.43.0

