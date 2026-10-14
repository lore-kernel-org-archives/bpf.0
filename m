Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92259387341;
	Wed, 14 Oct 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003548; cv=none; b=FtJpEeNEwZiaLDV41SI9KVrhRLwVkUz6SqenLV/JRSlb3mcZD/PtIA52RL7Qn+ecImuLgULkaxPAyJtYIFCD8TWmXHkQ8lfCMcWXtOywJmZfRNogZWqkUCBUt6O5xQUsUDzDGz7SmCPoSkWjDXZtqv4RDKfIXTM4CNK2MuK7dG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003548; c=relaxed/simple;
	bh=PtWr67SBVF6L1S13MrwMD1k0Z5FhdfROwjf0gpUh/bA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAYQT9k5+TkQ9rEJviTem9hzycbXIYGZqLQqkLcpc7MSdb/aHQ1TqEB1qlts3ZHZN5UIdvY5cWlgkzDIpko+KVWd1wnibbDiFKJvZlfuA6dKly1zj5pugKxOSz80Z/nRiaY/nxpTcy/MwWQJbZgUZSn/jh041ElbNKCUYPuCABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoyXAMUY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoyXAMUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003546; x=1823539546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PtWr67SBVF6L1S13MrwMD1k0Z5FhdfROwjf0gpUh/bA=;
  b=JoyXAMUY4kXmuC2NRBFp3CFNgVIxbKfp9J7WAIUg1wl/qdDQp98TgYZL
   YeSdfRkOgSabO/FLQepuAVi9bH3lV/Sj1TOs5kTrsFo/fm8qthEbgLUmY
   50u/2Q7D0VJI/HV1+tez4M+4ygW4/pwp8yPiyyqcYcZ4teApxn2I8fo1h
   tmcfeSxxhvjTJqf+5WZk5yUdz31IEIuHjSfi3MOARLEMgAMxjsPTEG7dQ
   4+lPCTOTZpPGEf3U8eIE1LF/rSTkOSWNhYaXPHKAsESXkIGQb9AJZdFTy
   etXFhH/otlLtpPndK4s4z6ZatnTwsakK98asqvXahljhE6diGL8nGeHzb
   w==;
X-CSE-ConnectionGUID: QZKH9BGQRSWaJvDMEynEFg==
X-CSE-MsgGUID: XpIkSXU/Qw6k9vB6Iq2X1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767229"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767229"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:45:45 -0700
X-CSE-ConnectionGUID: 93n+wIZKSQCqz9UHD98SKw==
X-CSE-MsgGUID: j+Sj0rJdQIKrgM2kNpImtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420655"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:45:42 -0700
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
Subject: [PATCH v3 net-next 00/15] selftests: net: migrate AF_XDP test suite over to net
Date: Wed, 14 Oct 2026 20:45:24 +0200
Message-Id: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/netdev/20261008114909.734364-1-maciej.fijalkowski@intel.com/
v2 -> v3:
- New patch 2: size the TX UMEM of HW_SW_MAX_RING_SIZE like the RX
  one; the case only worked with the single-interface shared UMEM
- Patch 6: test_xsk.sh skips without xskxceiver, -lpthread for glibc
  older than 2.34, tools/include ahead of CFLAGS for O= (Sashiko)
- Patch 8: hw_ring_size_reset() skips no-op resets and keeps the NIC's
  sizes on failure; TAP header right after parsing (Sashiko)
- Patch 9: test_xsk.py replaces test_xsk.sh (Bjorn), with a KTAP case
  per mode and case, a veth pair per case (Sashiko) and
  test_xsk_busy_poll; helpers shared with xsk.py go to net/lib/py/xsk.py;
- XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF and XDP_ADJUST_TAIL_GROW are left
  out on veth (Jakub, Bjorn)
- Patch 10: wait for the listener's stderr line instead of polling with
  ss; pass only when both endpoints pass; -P takes only a port; ABORT
  and PROGRESS fixes (Sashiko)
- Patch 11: default MTU of 1500, link wait after MTU or XDP changes,
  one-mode cases skip on both endpoints, smaller fixes (Sashiko); RX
  fills its fill ring before the bind and each endpoint sizes its own
  rings, as zero-copy drivers and HW_SW_MAX_RING_SIZE need
- Patch 12: pass IPv4 fragments to the stack, run both
  XDP_ADJUST_TAIL_GROW cases on hardware, read adjust_value via the
  skeleton (Sashiko)
- New patch 13 replaces v2 patch 12 (test_xsk_case_defs.h): xskxceiver
  -L lists the hardware cases by DUT role for xsk.py (Jakub); hardware
  runs gain STAT_RX_FULL, STAT_FILL_EMPTY, XDP_DROP_HALF,
  XDP_METADATA_COPY_MULTI_BUFF, the XDP_ADJUST_TAIL cases, TEARDOWN and
  HW_SW_{MIN,MAX}_RING_SIZE -- that has been actually a huge oversight
  on my side where I did not cover the hw_flags on these cases at v2;
- Patch 14: drv-net conventions: cfg.net_lib_dir, cfg.remote.deploy(),
  RSS and ntuple as in iou-zcrx.py, no REMOTE_TYPE checks, sudo or
  XSK_* variables (Jakub); control channel to REMOTE_V4 for both remote
  types, DUT queue out of RSS in both directions, timeout(1) for the
  remote endpoint (Sashiko); one-time queue, ntuple and huge page
  setup; test_xsk_busy_poll replaces -b and it is covered within single
  ksft_run()
- Patch 15: document both runners with a netns remote example; drop
  the XSK_* note from drivers/net/README.rst
- rebase!

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
namespace. The veth test moves with the engine from selftests/bpf to
selftests/net as test_xsk.py. It replaces test_xsk.sh and runs all of
its cases but XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF, which leaks page_pool
pages on veth, and XDP_ADJUST_TAIL_GROW, as veth leaves no room to grow
most frames.

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
For example, this means rx_SEND_RECEIVE will test the
ice_clean_rx_irq_zc() routine and tx_SEND_RECEIVE the ice_xmit_zc().

BPF's 'test_progs -t xsk' is removed, as well as single interface mode,
which was used for ZC tests. BPF CI therefore no longer runs the
xskxceiver cases. The veth test is kept, as it is the only run that
needs no hardware and not all tests are currently covered by the HW
test side.
We can decide whether to keep the delta test cases, drop them or somehow
enable within HW tests.

Thread-based approach had a pacing mechanism that was a simple in-flight
packet counter updated within critical section by both ends.
Process-based way now is going to do this pacing via xsk_peer.

xsk_peer, the control channel, carries three fixed-size messages: READY
is the barrier between steps, PROGRESS tells TX how many packets RX has
consumed so that TX does not overrun the RX UMEM, and ABORT stops the
peer after a failure.

The test table in test_xsk.h is grouped by the endpoint role that each
case tests, which a hardware run gives to the DUT: RX, TX, both, or
none for the generic cases, which run on veth only. xskxceiver -L lists
each hardware case once per role, and xsk.py makes the variants
ksft_variants() named rx_<case> and tx_<case> from that list, so -t and
-T work as for any other test. Both runners reject -l and -h, as
ksft_run() exits on them before main() can undo the setup of the run.


Patches 1-4 prepare the split. Patch 1 moves the endpoint work out of
the pthread entry points. Patch 2 sizes the TX UMEM of
HW_SW_MAX_RING_SIZE like the RX one, as the case only worked with the
UMEM that the single-interface mode shares. Patches 3 and 4 drop the
single-interface loopback mode and the test_progs wrapper, which runs
both endpoints as threads of test_progs; neither can work with one
endpoint per process. Nothing else runs a subset of the cases, so
patch 4 also merges the cases that the wrapper left out into the main
list.

Patch 5 adds a generic rule for BPF skeletons to net/bpf.mk, as Jakub
suggested in the review of the xdp_features move [1]; xskxceiver is
its first user. If that series lands first with the same rule, this
patch can be dropped.

Patch 6 moves the engine, its XDP program and the veth launcher to
selftests/net. xsk.py needs xskxceiver, and a drv-net test can only
rely on net/lib: the selftests build pulls net/lib in for net,
drivers/net and drivers/net/hw, while it skips selftests/bpf by
default. The veth test is software-only, so it goes to selftests/net,
as the drv-net README asks. selftests/bpf keeps building xsk.c from
its new place for xdp_hw_metadata and the xdp_metadata test.

Patches 7-10 split the engine. The interface capabilities move into one
struct, so that a process can mirror them for the endpoint it does not
own (7). main() is split into setup, run and cleanup (8). xskxceiver
runs one case per invocation, and test_xsk.py, which replaces
test_xsk.sh, owns the mode x case matrix (9). Finally, the RX and TX
endpoints become separate processes that meet over a small TCP control
channel (10).

Patch 11 adds the xskxceiver options that a two-host run needs, and
patch 12 lets the XDP programs pass traffic other than the test flow to
the stack in hardware mode. Patch 13 groups the test table by endpoint
role and lists the hardware cases with xskxceiver -L, and patch 14 adds
xsk.py on top of them. Patch 15 documents both setups.


Tested on both netns and ssh REMOTE_TYPEs on my local setup.

Known issues, follow-ups?:
- Not on hardware yet:
 * BIDIRECTIONAL, which needs both directions set up in one case; i
   think it should be removed as we sort of achieve the bi-directional
   coverage via the rx_ and tx_ variants, and it currently does not fit
   our KISS-policy on remote side;
 * XDP_SHARED_UMEM, whose XDP program picks the socket by the synthetic
   MAC address of the veth test;
 * STAT_RX_DROPPED and TX_QUEUE_CONSUMER, which do not run in zero-copy
   mode.
- we could move the routines that reserve queues and do RSS updates to
  lib as there are several tests doing almost the same thing; this way
  xsk.py would become way smaller; reserving hugepages is another
  candidate...as well as ntuple commands;

[1]: https://lore.kernel.org/netdev/20260925161547.1b57b653@kernel.org/

Thanks,
Maciej

Maciej Fijalkowski (15):
  selftests: xsk: factor endpoint work out of pthread wrappers
  selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE
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
  selftests: xsk: list the hardware test cases
  selftests: drv-net: test AF_XDP zero-copy with an SKB peer
  selftests: xsk: document generic and hardware endpoint runs

 Documentation/networking/af_xdp.rst           |   6 +-
 MAINTAINERS                                   |   5 +-
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |  29 +-
 tools/testing/selftests/bpf/network_helpers.c |  48 --
 tools/testing/selftests/bpf/network_helpers.h |   2 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 170 ----
 tools/testing/selftests/bpf/test_xsk.sh       | 246 ------
 tools/testing/selftests/bpf/xsk_prereqs.sh    |  93 ---
 tools/testing/selftests/bpf/xskxceiver.c      | 479 -----------
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   5 +
 tools/testing/selftests/drivers/net/hw/xsk.py | 263 ++++++
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/bpf.mk            |   6 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/lib/.gitignore    |   2 +
 tools/testing/selftests/net/lib/Makefile      |  34 +
 .../testing/selftests/net/lib/py/__init__.py  |   4 +
 tools/testing/selftests/net/lib/py/xsk.py     |  81 ++
 .../testing/selftests/net/lib/xsk/README.rst  | 166 ++++
 .../prog_tests => net/lib/xsk}/test_xsk.c     | 765 +++++++++++-------
 .../prog_tests => net/lib/xsk}/test_xsk.h     | 142 +++-
 .../selftests/{bpf => net/lib/xsk}/xsk.c      | 109 ++-
 .../selftests/{bpf => net/lib/xsk}/xsk.h      |   7 +
 .../testing/selftests/net/lib/xsk/xsk_peer.c  | 293 +++++++
 .../testing/selftests/net/lib/xsk/xsk_peer.h  |  19 +
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |   0
 .../lib/xsk/xsk_xdp_progs.bpf.c}              |  47 ++
 .../selftests/net/lib/xsk/xskxceiver.c        | 682 ++++++++++++++++
 .../{bpf => net/lib/xsk}/xskxceiver.h         |   0
 tools/testing/selftests/net/test_xsk.py       | 154 ++++
 33 files changed, 2474 insertions(+), 1388 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
 delete mode 100755 tools/testing/selftests/bpf/test_xsk.sh
 delete mode 100755 tools/testing/selftests/bpf/xsk_prereqs.sh
 delete mode 100644 tools/testing/selftests/bpf/xskxceiver.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk.py
 create mode 100644 tools/testing/selftests/net/lib/py/xsk.py
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (81%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (80%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (88%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (95%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.c
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.h
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (70%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xskxceiver.c
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 create mode 100755 tools/testing/selftests/net/test_xsk.py

-- 
2.43.0

