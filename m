Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1739282C;
	Tue, 16 Jun 2026 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625023; cv=none; b=FcP5QHm8LymTGHQeEiuGjfB+Tz93r7uJv685jmV2FNKMCOpZIISstXCB703xjVzQfqsNO4cqbPFrXHcdnB/LgidtYl3q0GzGF0cCrU+TVOEcgJ1NW8iRKM2B9ckqXW0zN5GME+8rjIWq8cGkK9W7Zvvji7nkPZ4KNhvMqY9CZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625023; c=relaxed/simple;
	bh=TwBV8VPYVxSy1EgFWxObclBgVWNGRE9JBaZgyorMpnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRQ+E7m9Bj8iw5SswWyv6i8zzKj5CvVf0YLGiH2INIv6dbom277HoB24h2bZ8Idy/hasHYN8+7L2ymlkEk+r4n2jNajKA6fZop4y1ynnNKgojYkLf6t4l6QsS4zStp2Wg7M4UyCr3HkHeoebs3TPbahV+dY6LvllUZCd1wt+SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhlZFyfo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhlZFyfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781625022; x=1813161022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TwBV8VPYVxSy1EgFWxObclBgVWNGRE9JBaZgyorMpnk=;
  b=FhlZFyfolpeApEpPYBex115yGRidBo62ZAHC8J9xL+lKbePBnf/nk5tD
   XFkfwHVe09c5wRU4MYS0x1ZAlIvCpPEhc9IgGM1+zPDKG0R363uPyOjje
   3gI8/IuYDDm2aSYCfz+Pj76iW1+Ga72fUGBoANU8f+wAEkeaR+u4I2XQN
   Bp4uU9mYGmIIhWMntKwCZ84bTH2nQo6cfqZlSK9LBKQDw1rlvOurQp3dl
   HeRhVCsj8+UAMt2FSpsXexDun4jA6oz6JIJqmcsCGcNAnpLJFM2xx9H3g
   EZF1hION5jxRbqAIoBsche6x4uZgT8jIz1fvHbRggTPspO6yubkhmOtVC
   A==;
X-CSE-ConnectionGUID: npAVwhvhQWevZV2u5DR6+Q==
X-CSE-MsgGUID: lTHJMGAGTeOQgjcn2sQrbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86232985"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86232985"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:21 -0700
X-CSE-ConnectionGUID: Vlbj8AqaSmypbcOatriXHg==
X-CSE-MsgGUID: zhg1Np77Q4Ke3T7HM9ZF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247684278"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 08:50:18 -0700
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
Subject: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test behavior
Date: Tue, 16 Jun 2026 21:19:51 +0530
Message-ID: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves AF_XDP selftests by making timeout handling
explicit and fixing sources of non-determinism in xsk timeout tests.

Patch 1 introduces test_spec::poll_tmout and removes implicit
dependence on RX UMEM setup state for timeout behavior.

Patch 2 fixes thread harness sequencing by attaching XDP programs
before worker startup, removing signal-based termination, and using
barrier synchronization only for dual-thread runs.

Patch 3 restores shared_umem after POLL_TXQ_FULL so test-local
configuration does not leak into subsequent cases on shared-netdev
runs.

Together these changes make timeout handling easier to follow and
improve selftest stability, especially on real NIC runs.

Tushar Vyavahare (3):
  selftests/xsk: make poll timeout mode explicit
  selftests/xsk: fix timeout thread harness sequencing
  selftests/xsk: restore shared_umem after POLL_TXQ_FULL

 .../selftests/bpf/prog_tests/test_xsk.c       | 96 +++++++++++--------
 .../selftests/bpf/prog_tests/test_xsk.h       |  2 +
 2 files changed, 56 insertions(+), 42 deletions(-)

-- 
2.43.0

