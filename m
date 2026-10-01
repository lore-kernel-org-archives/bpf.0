Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D6535FDF;
	Thu,  1 Oct 2026 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886190; cv=none; b=Tr5xn03XlxolMSk3vIVzFWtJlvhu9s886Rzkvo3iOPhtlE6WQ2/Zfu3oFhdHWPKmR4H67ZV40qVZ9ZflNY9fvAqhbtzLcYp4aZdP1troMPtXeSTYFbgZ3CNLkFyqLjqp+W9c3xwiZxWi8ycMGdIT/CORc3H08nQMK39vQDnXCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886190; c=relaxed/simple;
	bh=uECaupwzr1FypG4I4f4hVN90zQI3oHk7Uef1PP5+6+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UssTj9KBNTUn2TP6Ln16Oc0VdJ4dM7blYqQhaa7ll/fney/gv46bz4hm5s6r/NrGjLz1A5gVKSNyFqhiPKl8/E9U/mdJjcptLERZRwWwlWlBdu6Y/034hW/VOJefEALSX5E+aafEPPoOQD5gt2/Q8Mc8mncyJlFCJzuUttPVsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlmC+Ek2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlmC+Ek2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886185; x=1822422185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uECaupwzr1FypG4I4f4hVN90zQI3oHk7Uef1PP5+6+k=;
  b=BlmC+Ek2/8p1Nq1A7toFrPBMSp+2SXt4i+Yc4OO+xPtNQQ/JNM306b8z
   WrY3/Y1GW+kvCuzwv/+7W1vqqEiWzntf7eKRvLaDWDQgmnLps6LgtCq+x
   IH6vSo578+6O9IAkPvRWygvnBadvcr5SwQB7E+AvoKOH7ok8EWCvVyllc
   vEyiy9K9/GnPPVWQYLdPG7N/XOnm23D3SLrGNM/Ixy1a6aEugSlrewaHT
   9Nq4lzK5jGnMh+g1qMqtbxGsUsZ7UiHo4c6Y/hU/fUT+Yt0242oAz2UMi
   w7+7tk3XpMbATtDSLxzZ9is6JMZFkZeKxuM5VOKM/gyQHJnXrizyyNpNh
   w==;
X-CSE-ConnectionGUID: 7zjFzd0tReerUGVxmyAbZw==
X-CSE-MsgGUID: m6cn6x0qTBeQ4KolnfaBxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466853"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466853"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:57 -0700
X-CSE-ConnectionGUID: RSe4uUZ5RTS8aLb2+K9ASA==
X-CSE-MsgGUID: 5f3V3kSwRqaY+DrxwTFFCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636744"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:55 -0700
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
Subject: [PATCH net-next 13/13] selftests: xsk: document generic and hardware endpoint runs
Date: Thu,  1 Oct 2026 22:21:24 +0200
Message-Id: <20261001202124.692591-14-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
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
 .../testing/selftests/net/lib/xsk/README.rst  | 130 ++++++++++++++++++
 .../selftests/net/lib/xsk/xskxceiver.c        |   2 +
 3 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index c6bed9a985bc..34a5053a9816 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -132,6 +132,13 @@ Communication channel dependent::
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
index 000000000000..a4503e50a6c4
--- /dev/null
+++ b/tools/testing/selftests/net/lib/xsk/README.rst
@@ -0,0 +1,130 @@
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
+on the remote receiver. The XDP programs redirect every packet, so the
+tested link must carry no other traffic; SSH and the control channel go
+to the ``REMOTE_ARGS`` host, which has to be reached over another link.
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
+Setup
+-----
+
+Build the engine on the DUT::
+
+  make -C tools/testing/selftests/net/lib
+
+A top-level selftests build with ``TARGETS=drivers/net/hw`` includes
+``net/lib`` as well. The binary is linked statically when the static
+libraries are installed; ``XSK_STATIC=0`` or ``XSK_STATIC=1`` overrides the
+probe.
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
+Each case starts its remote endpoint over SSH, and a DUT TX case also adds
+and removes a flow steering rule on the remote. SSH connection sharing for
+the remote host (``ControlMaster``, ``ControlPath`` and ``ControlPersist``
+in ssh_config(5)) avoids a new SSH login for each remote command. With
+``sudo``, that is root's SSH configuration.
+
+The remote host needs AF_XDP in SKB mode and BPF. ``xsk.py`` copies the
+DUT's ``xskxceiver`` binary to the remote, so both hosts must have
+compatible architectures. ``XSK_REMOTE_BIN`` chooses a fixed destination
+path for that copy. Set ``XSK_REMOTE_DEPLOY=0`` to use a binary built on
+the remote from the same test case definitions instead. ``XSK_REMOTE_SUDO=1``
+runs the remote endpoint and setup commands through passwordless ``sudo -n``;
+omit it when SSH logs in as root. The DUT needs ntuple and RSS support for
+RX cases, while the remote needs ntuple support for DUT TX cases. The test
+uses ``NetDrvEpEnv`` and the networking selftest Python helpers for setup
+and rollback.
+
+The DUT uses the SSH host name to connect to the remote control listener.
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

