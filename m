Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5A1E520A;
	Sun, 19 Jul 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469385; cv=none; b=AhTifHqh2Bj4UVdx/JRUMk9ulCSxacbPskavIGs7KXNO+STtJT+FOH0OkFjpFpW9+PsMGEH7Wb1LkKdUWfgzQGKy6rxOotD+DD2kLjym5U88pfnnWjzWJxmUMpJ5drJj7ONOtcv+aD5rY2Rg+r0PR6VbaKIzITPXoQxuQOT0Pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469385; c=relaxed/simple;
	bh=abfPelF1q2maxt7gQZ/q5vFPyzU70yXiR/t3AixVe2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgZt4m7v3RRKB8cjrJCOIxqe+isafPTmZ1aU4VSEySB1wl5x33eFotwzV+KfFBso1GsKLhkAKlwSUZSajQJHw42XPYksDdwteyKbnq3wk2vskBoShV1y0QmiapyY0HvSepoZENnJt5+85bEwn8827zxN0lem5DjtXAjDijGv0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eqrp9H0Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eqrp9H0Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784469383; x=1816005383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=abfPelF1q2maxt7gQZ/q5vFPyzU70yXiR/t3AixVe2M=;
  b=Eqrp9H0QVXcv4Gvflg9nsPIFo4RRrMjFovGxttc4gmmxksK2Diq2Vkv/
   5qOAcYQSCMtXgeendwkoKwrX0dE8UxtNrY2SpjeKrh93CRdiUyv/v5mOz
   oYubtHk+OZH/CaUCiJMxx9NxYloYz9BTk3vxnl6FSl4glhdX9zH780maK
   sGeQGlPX2NUPplc9fCdpXfbrjKZ0AHRfpKLzGejAdu173AMhVV1GiDOCj
   xc07UwVWFD3idWDwAxLyJYaA9PGCy11BnEJnp1QbeUvbzCvuuj3Pcw1Vu
   tltOxJRlUxx8PFneEKfqYqXqkbdLLDn5l9wPFQxEVaKi4VunAoStSO2/Z
   w==;
X-CSE-ConnectionGUID: lyKqT4AGSJGAWyXwyrpFKg==
X-CSE-MsgGUID: tdSurGqwRCyuLSUicCAKCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="88894139"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="88894139"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:56:22 -0700
X-CSE-ConnectionGUID: obrRlvhKQ+eBZC8Bqlh6jw==
X-CSE-MsgGUID: tRxzyI0kT1O7FYAu9VD1eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="260791912"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 19 Jul 2026 06:56:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
Date: Sun, 19 Jul 2026 15:56:03 +0200
Message-Id: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
https://lore.kernel.org/netdev/20260714140722.111645-1-maciej.fijalkowski@intel.com/T/
v3->v4:

* Return standalone invalid Tx descriptors through the completion ring in
  both the generic and zero-copy Tx paths. Advancing the Tx-ring consumer
  releases only the ring slot; returning the descriptor address through
  the CQ also transfers ownership of the corresponding UMEM frame back to
  userspace.

* Remove xsk_tx_batch::consumed_descs. With standalone invalid descriptors
  now reclaimed through the CQ, every descriptor permanently removed from
  the Tx ring is represented by either tx_descs or reclaim_descs. Use
  their sum for Tx-consumer advancement, shared-UMEM fairness accounting,
  and progress detection.

* Ensure that generic reclaim-only processing publishes the updated
  Tx-ring consumer even when no packet was submitted to the networking
  stack.

* Update the XSK selftests to count every descriptor submitted to the Tx
  ring as an expected CQ entry, while continuing to count only valid
  packets as expected Rx traffic. This covers standalone invalid
  descriptors, invalid multi-buffer packets, oversized packets, and the
  non-verbatim STAT_TX_INVALID tests.

* Update the AF_XDP documentation to describe the completion ring as an
  ownership-transfer mechanism and document that standalone, invalid
  multi-buffer, and oversized Tx packets are reclaimed through the CQ.

* Add Jason's tags

v2: https://lore.kernel.org/netdev/20260710194424.84844-1-maciej.fijalkowski@intel.com/
v2->v3:

* Added a preceding patch that sizes the pool-wide temporary Tx descriptor
  array to the larger of the first Tx ring and the device's
  xdp_zc_max_segs capability. This guarantees that the shared-UMEM path can
  inspect one maximum-sized valid packet even when the socket that creates
  the pool has a smaller Tx ring. Consequently, this patch now records the
  actual allocated size in pool->tx_descs_nentries rather than the first
  socket's Tx ring size.

* Fixed a possible infinite retry loop when a shared-UMEM socket contains
  an incomplete multi-buffer packet. Pass the original descriptor budget
  to xskq_cons_read_desc_batch() instead of the number of descriptors
  currently available, so the parser can distinguish producer exhaustion
  from actual budget exhaustion.

* Moved the completion-ring space check to the common batched Tx path, so
  it is performed exactly once for both singular and shared-SG pools. Keep
  the legacy shared non-SG fallback outside this handling, as it reserves
  completion entries one descriptor at a time.

* Reworked xsk_tx_peek_release_desc_batch() to use a common singular/shared
  batched flow. Resolve an empty Tx socket list before checking CQ space,
  select the shared-SG walker through an explicit shared-pool condition,
  and commit the resulting batch through one common path.

* Simplified xsk_tx_commit_batch() by moving the cached CQ producer
  snapshot into the helper instead of passing it from each caller.

v1: https://lore.kernel.org/netdev/20260623133240.1048434-1-maciej.fijalkowski@intel.com/
v1->v2:

* Reduced the series from seven to five patches by squashing the three
  generic Tx drain and reclaim changes into a single patch. The resulting
  patch handles overflow, invalid descriptors in the middle of a packet,
  and reclaim of the offending descriptor as one coherent change. This
  so it will be less likely to have things reported by Sashiko that are
  fixed in later commits;

* Reworked the zero-copy implementation substantially:
  * removed the bind-transition mechanism, including tx_share_pending,
    xp_prepare_xsk_tx_share(), xp_finish_xsk_tx_share(),
    synchronize_net(), and the transient bind() -EAGAIN behavior;
  * added packet-framed parsing for shared-UMEM SG pools, allowing
    per-socket drain state to be resumed by both singular and shared Tx
    paths;
  * retained the legacy one-descriptor fallback for shared non-SG pools;
  * preserved the existing per-socket fairness quota while allowing the
    shared walker to consume multiple complete packets and continue
    filling the requested batch across fairness rounds;
  * made the fairness quota large enough to process one maximum-sized
    valid multi-buffer packet;
  * extended the parser result with consumed-descriptor and
    budget-limited accounting needed by the shared walker;
  * recorded the size of the pool's temporary Tx descriptor array and
    capped batch processing at that size;
  * kept reclaim-only descriptors ordered after preceding driver-visible
    descriptors and protected the delayed-reclaim state with
    READ_ONCE()/WRITE_ONCE().

* Rewrote the zero-copy patch description to cover oversized packets,
  continuation draining across calls, shared-UMEM SG handling, and CQ
  publication ordering.

* Corrected the too-many-frags selftest description to state that the
  invalid packet contains max_frags + 1 fragments and terminates at an
  explicit packet boundary.


Hi,

This series fixes several AF_XDP multi-buffer Tx paths where descriptors
consumed from the Tx ring are not consistently returned to userspace
through the completion ring when the packet is later dropped as invalid.

The affected cases are invalid or oversized multi-buffer Tx packets in
both the generic and zero-copy paths. In these cases, the kernel can
consume one or more Tx descriptors while building or validating a
multi-buffer packet, then drop the packet before it reaches the device.
Userspace still owns the UMEM buffers only after the corresponding
addresses are returned through the CQ. Missing completions therefore
make userspace lose track of those buffers.

The generic path fixes cover following related cases:
* partially built multi-buffer skbs dropped by xsk_drop_skb();
  continuation descriptors left in the Tx ring after xsk_build_skb()
  reports overflow;
* invalid descriptors encountered in the middle of a multi-buffer
  packet, including the offending invalid descriptor itself.

The zero-copy path is handled separately. The batched Tx parser now
distinguishes descriptors that can be passed to the driver from
descriptors that are consumed only because they belong to an invalid
multi-buffer packet. Reclaim-only descriptors are written to the CQ
address area and published in completion order, after any earlier
driver-visible Tx descriptors.

The last two patches update xskxceiver so the tests account invalid
multi-buffer Tx packets as descriptors that must be reclaimed, while
still not expecting those invalid packets on the Rx side.

This is a follow-up to Jason's changes [0] which were addressing generic
xmit only and this set allows me to pass full xskxceiver test suite run
against ice driver.

Thanks,
Maciej

[0]: https://lore.kernel.org/netdev/20260520004244.55663-1-kerneljasonxing@gmail.com/


Jason Xing (2):
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()

Maciej Fijalkowski (4):
  xsk: provide sufficient space in pool->tx_descs
  xsk: reclaim invalid Tx descriptors in ZC batch path
  selftests/xsk: fix too-many-frags multi-buffer Tx test
  selftests/xsk: account reclaimed invalid Tx descriptors

 Documentation/networking/af_xdp.rst           |  54 ++--
 include/net/xdp_sock.h                        |   1 +
 include/net/xsk_buff_pool.h                   |   9 +-
 net/xdp/xsk.c                                 | 255 +++++++++++++++---
 net/xdp/xsk_buff_pool.c                       |  13 +-
 net/xdp/xsk_queue.h                           |  65 +++--
 .../selftests/bpf/prog_tests/test_xsk.c       |  50 ++--
 7 files changed, 347 insertions(+), 100 deletions(-)

-- 
2.43.0

