Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9094A1A23A4;
	Tue, 23 Jun 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221600; cv=none; b=hsnJJljgXWp+MsGUf/nKuLydQ0XJyC8tlUfJsRKysYQnFjJI4mFnSu2hOOh2uYaSUGCpNb22692DfY2L++b8kw0KuVyJrE6gfWv0ZLWzsZYvFLaCX0eKpSoweQaMvyPbobIrnxKJEtAmAqGMlESC34Woh6v3o03Bli2WWqBXWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221600; c=relaxed/simple;
	bh=uE6t2yV3rEdxU9QfuI1PNZNbug+x9o5/p8g2ZZysrYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgH2iqjEYxKlmS0F95UkeaeaoCHR0m4f0tuZiQva9Uk3ABzW7W68/UJ6+4Wlp8WupfyoMHt3x/uFH8+ott4KqAXn9WhNw15DwywkzZ/gLuKJb0Ciy/tnpSmlDsPH1qEOk/C1+uM10YegfORX2DyVPmCH2H7BX9MRIFIbVJDzVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2/7PLJp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2/7PLJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782221599; x=1813757599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uE6t2yV3rEdxU9QfuI1PNZNbug+x9o5/p8g2ZZysrYk=;
  b=m2/7PLJpng4w60AVL+SzsZZzTX9LbPLU7dcmrCfn+GuZ8wxRrN7lzT8c
   5B4VcZF4TNmHJzRiowjFAE14MitXEsXN+uEtlO6i39DuSBDTu25lBquMJ
   VXj+2RFhZSP59gIRylDxy6X0WkkGHIhBYTSnsGzK9/LKqkcXsPptLd3d2
   JO5HIgqLEhFKgPPzMnDpEe759CgWV4ps0MzF3HMq56f5eldmnInxvC7+P
   lipmqQbPYFYYKNeaujuZ7vVzcGZYovr0k+0ua1AD8z4zvP8MIDjvQV2HL
   BFWUWWWNCqRSfuXlCEk1zAg5fT8JQdB99j6Cft/l5yanvzHknFozuZSfg
   A==;
X-CSE-ConnectionGUID: JPt6VlcrRvC4VTj8J4qu0w==
X-CSE-MsgGUID: kVs+UvAKQhuYrhfOfSbBww==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83153510"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="83153510"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 06:33:18 -0700
X-CSE-ConnectionGUID: n9ZApdwtRaCpk0w1gnYHng==
X-CSE-MsgGUID: HcmMbh29SuitcEPIkmUCZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="251447481"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jun 2026 06:33:15 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
Date: Tue, 23 Jun 2026 15:32:33 +0200
Message-Id: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The generic path fixes cover three related cases:
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

The ZC batching path can also retain drain state when userspace has not
yet provided the end of an invalid multi-buffer packet. To keep this
state local to the singular batched path, the series prevents a second
Tx socket from joining the same pool while such drain state exists.
During the singular-to-shared transition, Tx batching is gated,
pre-existing readers are waited out, and bind fails with -EAGAIN if the
existing socket still has pending drain state. This avoids adding
multi-buffer drain handling to the shared-UMEM fallback path.

The last two patches update xskxceiver so the tests account invalid
multi-buffer Tx packets as descriptors that must be reclaimed, while
still not expecting those invalid packets on the Rx side.

This is a follow-up to Jason's changes [0] which were addressing generic
xmit only and this set allows me to pass full xskxceiver test suite run
against ice driver.

Thanks,
Maciej

[0]: https://lore.kernel.org/netdev/20260520004244.55663-1-kerneljasonxing@gmail.com/


Jason Xing (3):
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()

Maciej Fijalkowski (4):
  xsk: reclaim offending invalid desc in generic multi-buffer Tx
  xsk: reclaim invalid multi-buffer Tx descs in ZC path
  selftests/xsk: fix too-many-frags multi-buffer Tx test
  selftests/xsk: account invalid multi-buffer Tx descriptors

 include/net/xdp_sock.h                        |   1 +
 include/net/xsk_buff_pool.h                   |   6 +
 net/xdp/xsk.c                                 | 114 ++++++++++++++++--
 net/xdp/xsk_buff_pool.c                       |  66 ++++++++++
 net/xdp/xsk_queue.h                           |  66 +++++++---
 .../selftests/bpf/prog_tests/test_xsk.c       |  44 ++++---
 6 files changed, 254 insertions(+), 43 deletions(-)

-- 
2.43.0

