Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFA39183B;
	Wed,  3 Jun 2026 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469277; cv=none; b=II7ZNJ58oiPdEEtH4Rir8R+vytiZV69E935RZJg7KIKXEzuFGSPvDbZ/hWp5auUmfcR4cMKf3SSPOMHnyjz3ocHQ/KVxrpKo0o9SJ3rn2Nku5rfhncQe7SRuN8FumnFh+6XtGVBBOXWGsmsKbGN6fPkFBMnpLKzEunCOcLOSaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469277; c=relaxed/simple;
	bh=u54brfiqq1gqzyz2AZW4xQ1pVAWQ83450faF6+2WNQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHll+FDzQfeJ5osA5SHUCzfnuJlrmNqkWwsLzBNN5rW/qL+JsNEvlPuDhclM/gDikJ1vGX2etmbHeRVFYic6MXHNbrIOrYgsWcuTRgmTGs7tg0WL2aQZiOCXz29IOPIbeMGrMIpLL58GIvhTYvx1KduUsYpIcn5J1siJbGF83uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FAMdC6uO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAMdC6uO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780469276; x=1812005276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u54brfiqq1gqzyz2AZW4xQ1pVAWQ83450faF6+2WNQY=;
  b=FAMdC6uOdopcmVYiWRnqgJ1iH41yX5GCvgbH1/sC/x/RCVQ/K/YUO40t
   kbmSBN05V+cOCCYDOlT6IaylXmA0DS5eRwBPdG4zRnSO8Z0+F16PQfrdt
   pSoWfVpk/ZH4FDjwbbq2fpjeRHpJwo8Jq9TynpTig11ORyvKNMudh1+vo
   VuQksHZDRJslQ/3L3ZHOOviv71d1LkgPd7oRBIYS1pFuBq2fjc/DkQ81f
   BAgwZNoCYt9mDWILG8fFWI9FN6COm86fAqBjVHI9pvpDnNebWuQXVSuZR
   zpEGPmFmosZldkYASW+RR47i5hW5/3aqnLMwHvHtvyj5ZaQJnCuNgAVej
   g==;
X-CSE-ConnectionGUID: 9hqyub3QTgyFj4IzjGCjaA==
X-CSE-MsgGUID: FGx69jTLSk2L8cFV82fMCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81449056"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81449056"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:47:55 -0700
X-CSE-ConnectionGUID: HHuW2PLBSZSu331ILmzPow==
X-CSE-MsgGUID: FHkqr/mARwWdILVxzKBfgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237778922"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:47:51 -0700
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
Subject: [PATCH net-next v2 0/4] selftests/xsk: simplify UMEM setup
Date: Wed,  3 Jun 2026 11:33:23 +0530
Message-ID: <20260603060327.298389-1-tushar.vyavahare@intel.com>
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

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Tushar Vyavahare (4):
  selftests/xsk: Introduce helpers for setting UMEM properties
  selftests/xsk: Move UMEM state from ifobject to xsk_socket_info
  selftests/xsk: Use umem_size() helper consistently
  selftests/xsk: Introduce mmap_size in umem struct

 .../selftests/bpf/prog_tests/test_xsk.c       | 203 ++++++++++--------
 .../selftests/bpf/prog_tests/test_xsk.h       |   3 +-
 2 files changed, 117 insertions(+), 89 deletions(-)

-- 
2.43.0

