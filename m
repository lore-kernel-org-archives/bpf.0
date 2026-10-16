Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922FC550DA1;
	Fri, 16 Oct 2026 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172631; cv=none; b=tJvazX4L8uVgWRjKRhARmwuTgc1HhOadhXSh36OOrjvAnV7OF7+sRf8llVcZkwVUjWmIGEn3zH2PX+yaan+ShYvF1TnLmN54LKnknoBCq1DdVpCQQwqjM+TH9sxXiZStDrnebOSQV0lslEtNF1ZOKBTDQPfppeSsMh4nQ2LJnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172631; c=relaxed/simple;
	bh=YfUoiPOOKPxjvtbC8NNI+v164ZBHHt8l33xKkc6Tkuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r9WMfH9IPELphebzveeawjzZC7+lwxthcXMpEb7aoLLt82CtUNFNRXolOQHcWGYG7wUvOrpXK20zisTlJRZS49v9SHLhXs/yzT/Mf8TN7TDY4b4AZjXfcX7fLqLHL5XxhPrEp8Ncq2AYXLk3Nitj8V400y4369FatWGNvOA2CYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCI3JOC7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCI3JOC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172628; x=1823708628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YfUoiPOOKPxjvtbC8NNI+v164ZBHHt8l33xKkc6Tkuc=;
  b=OCI3JOC75kflQ6yiHybSxWfJzQY6JKKWxKOaYTE9iPTlrcotH6A8eaqs
   wm5oz07e+SnrKdK0htquRDDsT4l3MnhT71ydTc6i5iI/+81vu0d902FQo
   3A9QB1GRtMNi+S4wIxQJxC/o5ccDL7+UKXcekzRgMc6le0wxzZyPP5f0P
   j0DssVirdkmcsnRJQaeoF0Bgr6K8zNjo9J3iQGeMbUEcWYt3VrWiG7JJA
   2baNcg1p/69IK6bipP3r3nh75IRqq0JfCeeg0Y6FJllfrvCRxJ1EWHhAR
   W4tL2/ioxQeNPLkaVtHtwaIUXtviYx5rvt95o3Z0aFmM8PT5DaDVJOM4E
   A==;
X-CSE-ConnectionGUID: eVpbru71RrybOuM2M0ZO+Q==
X-CSE-MsgGUID: l1niuyghTayh4oVqk6QhAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972327"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972327"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:43:48 -0700
X-CSE-ConnectionGUID: Pae8+wjZQpOnzTs6c0JpEw==
X-CSE-MsgGUID: wFxjvpVLSBKXf793bleOfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425169"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:43:46 -0700
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
Subject: [PATCH v4 net-next 00/15] selftests: net: migrate AF_XDP test suite over to net
Date: Fri, 16 Oct 2026 19:43:23 +0200
Message-Id: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/netdev/20261014184539.774708-1-maciej.fijalkowski@intel.com/
v3 -> v4:
- add tags from Mr Björn
- Drop --hw in xskxceiver, align packet layout between hw/veth runners (Björn)
- drop parse_u32() in xskxceiver (Björn)
- move ethtool -G and ring sizing logic from C to python
- configurable --timeout (Björn)
- keep the HW_SW_MAX_RING_SIZE batch below the XSK TX ring size (Sashiko)
- restore hugepage count in veth runner on exception paths (Sashiko)
- use ExitStack in hw runner to cover setup unrolls (Björn, Sashiko)
- support IPv6 next to IPv4 (Björn)
- send to the next-hop MAC, the peer need not be on-link (Björn)
- make --listen work on its own rather than follow the TX role (Björn)
- run XDP_SHARED_UMEM on HW, the socket is picked by UDP source port
- fail a case when one endpoint fails and the other skips (Björn)
- keep the TX half of the unaligned check in the xsk_caps conversion
- detach in cleanup_iface() with the flags of mode_to_xdp_flags()
- reserve 2 MiB huge pages, tolerate hosts without hugetlb or root (Sashiko)
- lower the veth case timeout to 20s, within the net timeout (Sashiko)
- guard pkts_in_flight against forged PROGRESS reports (Sashiko)
- log short fragments, fix the IPv4 fragment comment (Sashiko)
- keep the MIN_PKT_SIZE and PKT_HDR_SIZE names to cut churn
- read what a gone peer left at READY, drain after a SKIP (Sashiko)
- cap --max-frags, which sizes a packet array (Sashiko)
- skip the hw run when RSS or ntuple setup is refused (Sashiko)
- bound the gateway ping, fail clearly without its MAC (Sashiko)
- note in the README that RFS has to stay off on the DUT (Sashiko)

v2: https://lore.kernel.org/netdev/20261008114909.734364-1-maciej.fijalkowski@intel.com/
v2 -> v3:
- new patch: size the TX UMEM of HW_SW_MAX_RING_SIZE like the RX one
- replace test_xsk.sh with test_xsk.py, a veth pair per case (Sashiko)
- add busy-poll variants to both runners
- wait for the listener's stderr line instead of polling with ss
- default MTU of 1500, wait for link after MTU/XDP changes (Sashiko)
- fill the fill ring before bind, as zero-copy drivers need
- xskxceiver -L lists HW cases, replacing test_xsk_case_defs.h (Jakub)
- run more cases on HW, e.g. TEARDOWN and HW_SW_{MIN,MAX}_RING_SIZE
- follow drv-net conventions in xsk.py, drop XSK_* variables (Jakub)
- set up queue, ntuple and huge pages once per run
- build, ring reset, control channel, XDP and xsk.py fixes (Sashiko)
- document both runners with a netns remote example

v1: https://lore.kernel.org/netdev/20261001202124.692591-1-maciej.fijalkowski@intel.com/
v1 -> v2:
- rebase on net-next, NIPA could not apply v1 (Stanislav)
- new patch: pass non-test traffic to the stack on HW (Stanislav)
- support a netns remote, like NIPA's E810/X710 setup (Stanislav)
- drop XSK_STATIC, link xskxceiver dynamically
- fail TX when RX exits with packets in flight
- fix IPv4/UDP lengths in verbatim multi-buffer streams
- build fixes for a failing or broken bpftool
- document both remote types and the traffic filter


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

xsk_peer, the control channel, carries four fixed-size messages: READY
is the barrier between steps, PROGRESS tells TX how many packets RX has
consumed so that TX does not overrun the RX UMEM, ABORT stops the peer
after a failure, and SKIP makes the peer skip a case that its endpoint
skips.

The test table in test_xsk.h is grouped by the endpoint role that each
case tests, which a hardware run gives to the DUT: RX, TX, both, or
none for the generic cases, which run on veth only. xskxceiver -L lists
each hardware case once per role, and xsk.py makes the variants
ksft_variants() named rx_<case> and tx_<case> from that list, so -t,
-T and -l work as for any other test.


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

Patch 11 makes the endpoints send UDP over IPv4 or IPv6 between the
interface MACs, on veth as on hardware, and lets the XDP programs pass
all other traffic to the stack. Patch 12 adds what endpoints on two
hosts need, and patch 13 groups the test table by endpoint role and
lists the hardware cases with xskxceiver -L. Patch 14 adds xsk.py on
top of them, and patch 15 documents both setups.


Known issues:
- Every case pays for process start-up, XDP attach and detach and, on
  hardware, its remote commands. We used to configure resources once
  and then execute the whole test suite; it doesn't seem to be
  CI-friendly and it is preferred to have each case's resource
  management separated; that on the other hand increases the
  execution time of the whole test suite. Only what all cases share,
  the huge pages and, on hardware, the queue taken out of RSS and the
  ntuple rules, is set up once per run.

- The control channel goes to the remote address with either remote
  type, so it shares the tested link. A zero-copy TX socket fills no
  RX buffers and its queue would drop that traffic, so the DUT queue
  stays out of RSS in both directions, and a DUT with fewer than two
  queues skips the run.

- The control channel is unauthenticated TCP, and the remote endpoint
  listens on the remote address while its case runs.

- Both endpoints get only the case number, and the control channel
  does not check that they run the same case. xsk.py copies the DUT's
  xskxceiver to the remote with cfg.remote.deploy(), so that both ends
  number the cases alike.

- Not on hardware (yet, or ever):
 * BIDIRECTIONAL, which needs both directions set up in one case; i
   think it should be removed as we sort of achieve the bi-directional
   coverage via the rx_ and tx_ variants, and it currently does not fit
   our KISS-policy on remote side;
 * STAT_RX_DROPPED and TX_QUEUE_CONSUMER, which do not run in zero-copy
   mode.

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
  selftests: xsk: send UDP over IPv4 or IPv6 between the interface MACs
  selftests: xsk: prepare xskxceiver for endpoints on two hosts
  selftests: xsk: list the hardware test cases
  selftests: drv-net: test AF_XDP zero-copy with an SKB peer
  selftests: xsk: document generic and hardware endpoint runs

 Documentation/networking/af_xdp.rst           |   6 +-
 MAINTAINERS                                   |   5 +-
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |  29 +-
 tools/testing/selftests/bpf/network_helpers.c |  48 -
 tools/testing/selftests/bpf/network_helpers.h |   2 -
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 170 ----
 tools/testing/selftests/bpf/test_xsk.sh       | 246 -----
 tools/testing/selftests/bpf/xsk_prereqs.sh    |  93 --
 tools/testing/selftests/bpf/xskxceiver.c      | 479 ----------
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   5 +
 tools/testing/selftests/drivers/net/hw/xsk.py | 368 ++++++++
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/bpf.mk            |   6 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/lib/.gitignore    |   2 +
 tools/testing/selftests/net/lib/Makefile      |  34 +
 .../testing/selftests/net/lib/py/__init__.py  |   4 +
 tools/testing/selftests/net/lib/py/xsk.py     |  96 ++
 .../testing/selftests/net/lib/xsk/README.rst  | 194 ++++
 .../prog_tests => net/lib/xsk}/test_xsk.c     | 876 +++++++++++-------
 .../prog_tests => net/lib/xsk}/test_xsk.h     | 155 +++-
 .../selftests/{bpf => net/lib/xsk}/xsk.c      |  85 +-
 .../selftests/{bpf => net/lib/xsk}/xsk.h      |   6 +
 .../testing/selftests/net/lib/xsk/xsk_peer.c  | 339 +++++++
 .../testing/selftests/net/lib/xsk/xsk_peer.h  |  21 +
 .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |   3 +-
 .../lib/xsk/xsk_xdp_progs.bpf.c}              |  91 +-
 .../selftests/net/lib/xsk/xskxceiver.c        | 620 +++++++++++++
 .../{bpf => net/lib/xsk}/xskxceiver.h         |   0
 tools/testing/selftests/net/test_xsk.py       | 163 ++++
 33 files changed, 2697 insertions(+), 1454 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
 delete mode 100755 tools/testing/selftests/bpf/test_xsk.sh
 delete mode 100755 tools/testing/selftests/bpf/xsk_prereqs.sh
 delete mode 100644 tools/testing/selftests/bpf/xskxceiver.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk.py
 create mode 100644 tools/testing/selftests/net/lib/py/xsk.py
 create mode 100644 tools/testing/selftests/net/lib/xsk/README.rst
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (79%)
 rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (78%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (90%)
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (96%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.c
 create mode 100644 tools/testing/selftests/net/lib/xsk/xsk_peer.h
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (67%)
 rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (57%)
 create mode 100644 tools/testing/selftests/net/lib/xsk/xskxceiver.c
 rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
 create mode 100755 tools/testing/selftests/net/test_xsk.py

-- 
2.43.0

