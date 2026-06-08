Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5A29DB64;
	Mon,  8 Jun 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924193; cv=none; b=BA+UAWlkluI8FUce5yCU4zZxfvkko8KeNlinZ8+mVJjdKNmuQ+1C4QSTjpRvWo5d/ZlMNd1sxoGEuKV3mI/5lx/ILusSUMkKQUa3oCWqD+cCML3XKIcSks4wcd0K/ccEun83WcpEzi+ftE0eAzG6mTzS7PaZbEvJcAkSOxDGduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924193; c=relaxed/simple;
	bh=a4xP8RCXhHTuk1OmWoDtA1nUxXkbfRRh8V6ytyhYvKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIFOEVENyyXK+QP5viYYQUR+eYkWmHGIzYMFJAdcjKoVydCfUwynYu/VDhsnYVQGyB7JniwAD1Vj7rCfs+SB7le+SzW0YndcHv58BKylJv2TuFXqg0Kwu1dccXYrHUpzP+Uz9nhYfdXX7r86vlxDGMGtuY4zeRIzjZB6unBfy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnS7CDiX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnS7CDiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780924192; x=1812460192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a4xP8RCXhHTuk1OmWoDtA1nUxXkbfRRh8V6ytyhYvKw=;
  b=DnS7CDiXRIh0YVySDVNkMTKf2bgiJk0QQwaHJ3SYTJkCmWrGm6m5R4YN
   +zwm1+zUtb5tMWqPJt2cbYeCuwCxrGvPs0GqeMaDhE83rbt/ReLBP934Q
   LtSpdWFjGVV1IEeHs6auGg7aNlEdq8eLNkyaV/3vSYQvULKkqpwj5zILK
   oY6ecROXNmOZQXbrgivYBhe3Zeoy3Gz2310Th7iZc07+L2UO7FZgYJu18
   rIhrCKXD46mcvAYyaJkbFWtj8itQbxXRRyZQkueTczDfTdB3GXX1fHOQ8
   OknWswcUCoT6qTxKtM0db05pBFLo/mvEaQFHybqXHCYScquViHDHNWKzr
   A==;
X-CSE-ConnectionGUID: i0s2mVOPTkS0Oo5qnbzMZg==
X-CSE-MsgGUID: a/MX1r8SRgKSrjaTaPksNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92223680"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92223680"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:09:51 -0700
X-CSE-ConnectionGUID: I1tkXw6tSCKAQpXa/WY9JA==
X-CSE-MsgGUID: EylWRlzcRO+q0+8RlIrxXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269252914"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:09:47 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v3 0/4] selftests/xsk: simplify UMEM setup
Date: Mon,  8 Jun 2026 18:39:33 +0530
Message-ID: <20260608130938.958793-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series simplifies UMEM handling in selftests/xsk.

It centralizes UMEM property setup through helpers, moves UMEM ownership
from ifobject to socket-owned state, and normalizes umem_size/mmap_size
usage across the touched paths.

v1 -> v2:
- Applied helper usage consistently across the touched test paths.
- Moved UMEM ownership to socket-owned state and switched to one
  heap-backed umem_real object at xsk_arr[0] with explicit reset/cleanup.
- Kept shared-UMEM TX behavior unchanged via TX-local UMEM state
  copy/reset during TX configuration.
- Folded pkt_generate() umem parameter removal into the ownership
  refactor patch (no standalone cleanup patch). [Maciej]
- Updated mmap_size teardown handling to join the RX worker thread in
  single-thread mode before cleanup to synchronize UMEM mapping state.

v2 -> v3:
- Reverted the unnecessary pkt_generate() interface change. [Maciej]
- Removed the unneeded umem_rx/umem_tx locals in
  testapp_validate_traffic(). [Maciej]
- No functional changes, only review-driven cleanup.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Tushar Vyavahare (4):
  selftests/xsk: Introduce helpers for setting UMEM properties
  selftests/xsk: Move UMEM state from ifobject to xsk_socket_info
  selftests/xsk: Use umem_size() helper consistently
  selftests/xsk: Introduce mmap_size in umem struct

 .../selftests/bpf/prog_tests/test_xsk.c       | 193 ++++++++++--------
 .../selftests/bpf/prog_tests/test_xsk.h       |   3 +-
 2 files changed, 111 insertions(+), 85 deletions(-)

-- 
2.43.0

