Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1953EBF37;
	Tue, 10 Mar 2026 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180393; cv=none; b=TKFQbESP7nPTtNmv/rZ6vV1btaE3Frav82OuZ46kV8X+yaSle+aPcrG2JyG8O5vEzdb41Djqs0Td7HH4ft7t9glBPuXRp1oGbCMqsZJ4IeDP4Fk9TdPay/QZBb3ryWppV9CJoccThluxq0AZB3nCAZlaNHvv8J1jExbIjnhtSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180393; c=relaxed/simple;
	bh=GTJLbInsgBYeklNfOan4MgSnC88JFgggsxlakHG3+p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2macLcF7ZQXXKmYXjjP5nJrJCrH6NhB9lXu8jL6QhDp8lgTNnn6OAHEJ3oPW6Vdzny6Nx+IlLOkgF1ZlfxrggvqjKa3FuMbpZDOJLPD0hOQ6sBa8BP0KkJLXgkxktVeBf3mN6InxmaZknXVromyipxRuWiPmtHwBFffL293D2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESbuBnSW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESbuBnSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773180389; x=1804716389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GTJLbInsgBYeklNfOan4MgSnC88JFgggsxlakHG3+p4=;
  b=ESbuBnSWeo74NeqI+/kYpuR50yNUtauFbz8yZYhih6gaVF7vgX0EwHkM
   5pmUrXqIDvD1UKTCGUCUwvJW6KiYKl3WZUMEumZsUd+EEqPGqHY+u78Cw
   Uea52/8QIK6WMvlKoIJJcDuYok0ZDiDx1X808bHI/vW87IweDUAetlIcK
   8gkwojOl8FGySpyFbLvLubkPEwOCEz1Q4zi1VU5lRAv0K0xgE6kWKn2fG
   e9OKhoeFG1nUz1rpjhOnEraa4y8UifLiG4l12TEFNBi57ULbybUVbwmtF
   BawUVNxdSWbDHFCM1SEPCC2lAhZtCoJhfxZ/K2r7sioHJNsMKdRBD62eX
   A==;
X-CSE-ConnectionGUID: /WyVW/XeRACwc7nmEmkbLg==
X-CSE-MsgGUID: Ps4O2ia1Qg2DRlwEsvK/YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74156328"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74156328"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:06:28 -0700
X-CSE-ConnectionGUID: 3TTP47OGT7WXcV5uQxzcPQ==
X-CSE-MsgGUID: q9QMzVLsQty7luTBzL4qpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220298585"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2026 15:06:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	jacob.e.keller@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/5][pull request] ice: add support for devmem/io_uring Rx and Tx
Date: Tue, 10 Mar 2026 15:06:17 -0700
Message-ID: <20260310220624.537917-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

Now that ice uses libeth for managing Rx buffers and supports
configurable header split, it's ready to get support for sending
and receiving packets with unreadable (to the kernel) frags.

Extend libeth just a little bit to allow creating PPs with custom
memory providers and make sure ice works correctly with the netdev
ops locking. Then add the full set of queue_mgmt_ops and don't
unmap unreadable frags on Tx completion.
No perf regressions for the regular flows and no code duplication
implied.

Credits to the fbnic developers, which's code helped me understand
the memory providers and queue_mgmt_ops logics and served as
a reference.
---
Originally from:
https://lore.kernel.org/netdev/20260206174910.4066255-1-anthony.l.nguyen@intel.com/

Changes since:
Rebased
Patch 3:
 - fix [hopefully] all inconsistent locking
 - fix kdoc

The following are changes since commit 05e059510edf7b6101ff85db2a2e2d1b6f31ee6d:
  Merge branch 'eth-fbnic-add-fbnic-self-tests'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Alexander Lobakin (5):
  libeth: pass Rx queue index to PP when creating a fill queue
  libeth: handle creating pools with unreadable buffers
  ice: migrate to netdev ops lock
  ice: implement Rx queue management ops
  ice: add support for transmitting unreadable frags

 drivers/net/ethernet/intel/iavf/iavf_txrx.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c    | 247 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_base.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  15 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     | 185 +++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.h     |  15 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  70 +++---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  43 +++-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   2 +
 drivers/net/ethernet/intel/ice/ice_xsk.c     |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  13 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   2 +
 drivers/net/ethernet/intel/libeth/rx.c       |  43 ++++
 include/net/libeth/rx.h                      |   2 +
 include/net/libeth/tx.h                      |   2 +-
 16 files changed, 509 insertions(+), 141 deletions(-)

-- 
2.47.1

