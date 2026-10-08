Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6544AB6E;
	Thu,  8 Oct 2026 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460163; cv=none; b=R655yi57t21Eer9GiszWgRG9SdIPGWuot1WKJwQnHIE9ykT4YeMAAIq8+6M1a51OYDwcUURy2uuV/ycrMiC2dwU+wa2/kv0qvFL+Y1uDD9tgrD+h+PJQoDMBHo3IsUrJT4I3OSm0Xn3Hb5bQ0NCTgNcMDfxCb6OQLzvq5cYZbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460163; c=relaxed/simple;
	bh=uzhmh6n6PBDWtQyWA6kFxsjPUX+Py+M/JsXEQ79VokU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nUFta/wpQZXYiF77ohFuhxbd+X48byIoE1G66qAwwnnP8orlF67hUegVNz1Yr5CF7pNn9dDqtfiMF8E7ZQJddLegaNfGGnyBe/ExGelFg/GEPb/pjjgffngl4I+mRad3Rwfklkz03cc1J333Ds+kZKVBNlv7P3wgioroIN1MbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DORtvTt/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DORtvTt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460161; x=1822996161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uzhmh6n6PBDWtQyWA6kFxsjPUX+Py+M/JsXEQ79VokU=;
  b=DORtvTt/VHv4vYsVKrXUmnVlue8n6Gz4xPfznEsHReS/jtHMi52ta1Qq
   bFeQPOuFrBgl5ZBWzhGFUjusC8NhtbBW3VSUwBL9AsGHWNhvYFZkcF3mW
   hzx/sGxyOGO0i0XuK9eecOBza0ylF+XHNtkjJyGFA9kRmP/AaBaPSZ4Df
   b9e1gnUUU4019Kfr3Zqt7WW2t//WbjhMnE+RzItTkyRH7/L1J5M0ej7Ug
   dt9oJfsALBMUQxD48Ijh5WtRvOZTjNP8c1fBTCedRN0QiJloXq0BVj2gK
   gVf0d1+hQeaAuGyoRmKm/fiixKO+q5eA0OMh5pDQDL8Pug9Yg/rzYvZtX
   Q==;
X-CSE-ConnectionGUID: J+Xz/egHT4ydRges2aDy3w==
X-CSE-MsgGUID: 8VeLTarLRCOP2gyhNR9vvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124913"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124913"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:21 -0700
X-CSE-ConnectionGUID: I1Iy84zgQ2y6w7+C7A6EvA==
X-CSE-MsgGUID: ZsHbtpG2Q5Kck481/puahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467087"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:19 -0700
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
Subject: [PATCH v2 net-next 00/14] selftests: net: migrate AF_XDP test suite over to net
Date: Thu,  8 Oct 2026 13:48:55 +0200
Message-Id: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/netdev/20261001202124.692591-1-maciej.fijalkowski@intel.com/
v1 -> v2:
- Rebase on net-next; NIPA could not apply v1 (Stanislav)
- Patch 9: fail TX when RX exits with packets in flight instead of
  continuing until the case timeout
- Patch 10: use the full packet length for IPv4/UDP headers in verbatim
  multi-buffer streams
- New patch 11: in hardware mode, the XDP programs redirect only the
  UDP/IPv4 test flow and pass all other traffic to the stack, so the
  link under test no longer has to carry the test traffic alone
  (Stanislav)
- Patch 13: besides an SSH remote, xsk.py supports the peer port of the
  same host in a network namespace (REMOTE_TYPE=netns), which is how
  NIPA sets up its E810 and X710 pairs. The control channel then runs
  over the tested link to REMOTE_V4, and DUT TX cases also take their
  queue out of RSS: the DUT TX socket fills no RX buffers, so its
  zero-copy queue would drop the control traffic (Stanislav)
- Patches 13 and 14: drop XSK_STATIC and link xskxceiver dynamically,
  like the other networking selftest helpers; a remote with an older
  libc can run its own build with XSK_REMOTE_DEPLOY=0
- Patch 4: remove a partially written skeleton header when bpftool
  fails, so a later build does not take it as up to date
- Patch 5: skip xskxceiver also when bpftool is in PATH but does not
  run, not only when it is missing
- Patch 14: document both remote types and the traffic filter


Heads-up for ice: to reserve a queue, xsk.py updates only the RSS
indirection table over ethtool netlink. On ice this also turns on
symmetric Toeplitz hashing, and restoring the table afterwards fails.
The fix, "ice: keep the RSS hash function on indirection-only updates",
goes to iwl-net separately [0]. Without it, the first case that takes a
queue out of RSS fails in its cleanup, and the table stays modified.


Hi,

This work moves the AF_XDP test suite over to selftests/net and adds
a hardware test on top of the python-based drv-net infrastructure.
Since a non-zero effort went into implementing xskxceiver's (not so
great testing app name) test cases, we did not want to completely
abandon it and start everything from scratch within different infra.
However, hooking it up to the networking CI will allow us to run
cyclic tests on real HW; before that, all of our HW tests were manual
local runs.

Tests were based on a process with two threads responsible for the RX
and TX paths, whereas the new infra expects two separate processes for
the DUT and remote side, where each side has either rx or tx role.

To satisfy this requirement, this series makes each xskxceiver endpoint
a process of its own, so that the RX and TX sides of a case can run on
different hosts, and adds drivers/net/hw/xsk.py, which runs the existing
test cases with the DUT in zero-copy mode against an SKB-mode xskxceiver
on a remote host or on the peer port of the same host in a network
namespace. The veth test keeps its cases and moves with the
engine from selftests/bpf to selftests/net.

ZC tests used to expect a single NIC in loopback mode, with both
sockets on one of its queues sharing a UMEM. Now we step away from it:
the DUT and the remote are separate interfaces, on two hosts or on one
host with the remote in a namespace, and an ntuple rule steers
the test traffic to the AF_XDP queue.

The remote endpoint is xskxceiver in SKB mode rather than a plain
socket, so both ends keep sharing the packet stream generation and
validation of the existing cases. This reduces the need for remote
interface being a NIC from narrow set of NICs that are AF_XDP ZC
capable.

This implies that during the test run only one side is actually
exercised, so let's introduce the concept of direction per test case.
For example, this means SEND_RECEIVE in XSK_HW_RX will test
ice_clean_rx_irq_zc() routine and in XSK_HW_TX the ice_xmit_zc().

BPF's 'test_progs -t xsk' is removed, as well as single interface mode,
which was used for ZC tests. BPF CI therefore no longer runs the
xskxceiver cases. test_xsk.sh is kept, as it is the only run that needs
no hardware and not all tests are currently covered by the HW test side.
We can decide whether to keep the delta test cases, drop them or somehow
enable within HW tests.

Thread-based approach had a pacing mechanism that was a simple in-flight
packet counter updated within critical section by both ends.
Process-based way now is going to do this pacing via xsk_peer.

xsk_peer, the control channel, carries three fixed-size messages: READY
is the barrier between steps, PROGRESS tells TX how many packets RX has
consumed so that TX does not overrun the RX UMEM, and ABORT stops the
peer after a failure.

test_xsk_case_defs.h lists each case with the DUT directions.
xskxceiver builds its test table from that file, and xsk.py parses it to
make the variants ksft_variants() named rx_<case> and tx_<case>, so -l,
-t and -T work as for any other test.


Patches 1-3 prepare the split. Patch 1 moves the endpoint work out of
the pthread entry points. Patches 2 and 3 drop the single-interface
loopback mode and the test_progs wrapper, which runs both endpoints as
threads of test_progs; neither can work with one endpoint per process.
Nothing else runs a subset of the cases, so patch 3 also merges the
cases that the wrapper left out into the main list.

Patch 4 adds a generic rule for BPF skeletons to net/bpf.mk, as Jakub
suggested in the review of the xdp_features move [1]; xskxceiver is
its first user. If that series lands first with the same rule, this
patch can be dropped.

Patch 5 moves the engine, its XDP program and the veth launcher to
selftests/net. xsk.py needs xskxceiver, and a drv-net test can only
rely on net/lib: the selftests build pulls net/lib in for net,
drivers/net and drivers/net/hw, while it skips selftests/bpf by
default. The veth test is software-only, so it goes to selftests/net,
as the drv-net README asks. selftests/bpf keeps building xsk.c from
its new place for xdp_hw_metadata and the xdp_metadata test.

Patches 6-9 split the engine. The interface capabilities move into one
struct, so that a process can mirror them for the endpoint it does not
own (6). main() is split into setup, run and cleanup (7). xskxceiver
runs one case per invocation, and test_xsk.sh owns the mode x case
matrix (8). Finally, the RX and TX endpoints become separate processes
that meet over a small TCP control channel (9).

Patch 10 adds the xskxceiver options that a two-host run needs, and
patch 11 lets the XDP programs pass traffic other than the test flow to
the stack in hardware mode. Patch 12 moves the case list into
test_xsk_case_defs.h, so that xsk.py can read it as well, and patch 13
adds xsk.py on top of them. Patch 14 documents both setups.


Known issues:
- Every case pays for process start-up, XDP attach and detach and, on
  hardware, its remote commands. We used to configure resources once
  and then execute the whole test suite; it doesn't seem to be
  CI-friendly and it is preferred to have each case's resource
  management separated; that on the other hand increases the
  execution time of the whole test suite.

- With a netns remote, the control channel shares the tested link, so
  DUT TX cases also take their queue out of RSS; a one-channel DUT
  skips them, as it skips the RX cases.

- The control channel is unauthenticated TCP, and the remote endpoint
  listens on all addresses while its case runs.

- Both endpoints get only the case number, and the control channel
  does not check that they run the same case. By default xsk.py
  copies the DUT's xskxceiver to the remote; it is configurable via
  XSK_REMOTE_DEPLOY at net.config.

- busy-poll testing happens to be done via -b passed to xsk.py, however
  i am not sure if CI uses args, we might add a shell wrapper over
  python script ;) or it could be embedded within the cases list
  generation.

- Not on hardware yet:
 * BIDIRECTIONAL, which needs both directions set up in one case; i
   think it should be removed as we sort of achieve the bi-directional
   coverage via introduced XSK_HW_{R,T}X, and it currently does not fit
   our KISS-policy on remote side;
 * XDP_SHARED_UMEM, whose XDP program picks the socket by the synthetic
   MAC address of the veth test;
 * STAT_RX_DROPPED, STAT_RX_FULL, STAT_FILL_EMPTY, XDP_DROP_HALF,
   XDP_METADATA_COPY_MULTI_BUFF, the XDP_ADJUST_TAIL, TX_QUEUE_CONSUMER,
   TEARDOWN, HW_SW_MIN_RING_SIZE and HW_SW_MAX_RING_SIZE.

[0]: https://lore.kernel.org/netdev/20261007200311.730443-1-maciej.fijalkowski@intel.com/T/#u
[1]: https://lore.kernel.org/netdev/20260925161547.1b57b653@kernel.org/

Thanks,
Maciej

Maciej Fijalkowski (14):
  selftests: xsk: factor endpoint work out of pthread wrappers
  selftests: xsk: drop the single-interface loopback mode
  selftests/bpf: drop the test_progs AF_XDP wrapper
  selftests: net: add a generic rule for BPF skeletons
  selftests: xsk: move the AF_XDP test suite to selftests/net
  selftests: xsk: collect interface capabilities in struct xsk_caps
  selftests: xsk: split xskxceiver main() into setup, run and cleanup
  selftests: xsk: run one test case per xskxceiver invocation
  selftests: xsk: run the RX and TX endpoints in separate processes
  selftests: xsk: add a hardware mode to xskxceiver
  selftests: xsk: pass non-test traffic to the stack in hardware mode
  selftests: xsk: share test case definitions with hardware runner
  selftests: drv-net: test AF_XDP zero-copy with an SKB peer
  selftests: xsk: document generic and hardware endpoint runs

 Documentation/networking/af_xdp.rst           |   6 +-
 MAINTAINERS                                   |   4 +-
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |  29 +-
 tools/testing/selftests/bpf/network_helpers.c |  48 --
 tools/testing/selftests/bpf/network_helpers.h |   2 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 170 -----
 tools/testing/selftests/bpf/xskxceiver.c      | 479 -------------
 .../testing/selftests/drivers/net/README.rst  |   7 +
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   1 +
 tools/testing/selftests/drivers/net/hw/xsk.py | 417 +++++++++++
 tools/testing/selftests/net/Makefile          |   2 +
 tools/testing/selftests/net/bpf.mk            |   6 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/lib/.gitignore    |   2 +
 tools/testing/selftests/net/lib/Makefile      |  36 +-
 .../testing/selftests/net/lib/xsk/README.rst  | 138 ++++
 .../prog_tests => net/lib/xsk}/test_xsk.c     | 621 ++++++++++--------
 .../prog_tests => net/lib/xsk}/test_xsk.h     | 121 ++--
 .../net/lib/xsk/test_xsk_case_defs.h          |  57 ++
 .../selftests/{bpf => net/lib/xsk}/xsk.c      |  86 ++-
 .../selftests/{bpf => net/lib/xsk}/xsk.h      |   6 +
 .../testing/selftests/net/lib/xsk/xsk_peer.c  | 280 ++++++++
 .../testing/selftests/net/lib/xsk/xsk_peer.h  |  19 +
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |   0
 .../lib/xsk/xsk_xdp_progs.bpf.c}              |  39 ++
 .../selftests/net/lib/xsk/xskxceiver.c        | 654 ++++++++++++++++++
 .../{bpf => net/lib/xsk}/xskxceiver.h         |   0
 .../selftests/{bpf => net}/test_xsk.sh        | 186 +++--
 .../selftests/{bpf => net}/xsk_prereqs.sh     |  64 +-
 31 files changed, 2382 insertions(+), 1101 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
 delete mode 100644 tools/testing/selftests/bpf/xskxceiver.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk.py
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (85%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (67%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (91%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (95%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.c
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.h
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (75%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xskxceiver.c
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 rename tools/testing/selftests/{bpf => net}/test_xsk.sh (57%)
 rename tools/testing/selftests/{bpf => net}/xsk_prereqs.sh (53%)

-- 
2.43.0
