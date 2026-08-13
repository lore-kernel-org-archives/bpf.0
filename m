Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF620403B1F;
	Thu, 13 Aug 2026 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602626; cv=none; b=j/zNiACt9nIbVwV0ngwzxY0LJe3nbRhzW5U2BfeF5lIs4zc7Q5Rd32EZ466Omdr9PNPBJfqFJYWEPd/WkDWa1n1vCJqfsxxi/Clv8pL3WXdkHDatm3tBZ0UlO3pZjSv8sa0+UVu7oh6qSO5IXfB6tnpsoLN6wpp4cJ+fwabHT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602626; c=relaxed/simple;
	bh=8Zx0gUR1jbz1GzmYTuNpZLg8+Tqh1wm2h+LYt65zGMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ1gjXJJA3/oDSRo1s4apTbQIxVBL4/tgtHFgL1YQspzRBULUBXSgeR6F1+krqk2o68l78DbvIMmCDM5a/x82re9M6q1mHIRQV7pjjjegDFwlri17mg7TAFgOVkFmteZ0SkYLASBFL6XeeEWf+ZcyQA8zWxkTMHe+zr5U1hvbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wdm6aPeF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wdm6aPeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602625; x=1818138625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Zx0gUR1jbz1GzmYTuNpZLg8+Tqh1wm2h+LYt65zGMo=;
  b=Wdm6aPeFAlW/2JUPPRwR2prYM944OZRgbW5EGlli+SlaBJ/sEnc45d7w
   HaE5HmYVy8mLlE3UvCvab+RVuy8aiR4oj2QKC7lrzsB4+V2NDG1Mb34uM
   u7a08rOrrBsj9B2D/v8+xgyZcE1wdrK7euvyl7XG6lVQM5B7AAhcHMvQA
   bK9w9Gy1O/yUeZ5mmDqJoYUdF8i9HYK5bHiwkWgn5rNEFiiQ4sfZNpZny
   +/mWDjT4w9ighlZkuUAXU2HHhG2VlwcYDJiYdRufyGbOLFj+xnlsoBCTr
   e+TqogCE6aI41MkOeQhx8cvl8cuK4nrK7Nuq9g7cIRebBfpkz5slVuEPw
   A==;
X-CSE-ConnectionGUID: D3hTO4GTTLmZCiS52EOpIA==
X-CSE-MsgGUID: +BqggAHwQyisUR12feu3Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86933873"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86933873"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:24 -0700
X-CSE-ConnectionGUID: 34sjihtdRoOhH2yjCUAPPA==
X-CSE-MsgGUID: kLDkHQE1QFCEhxWuETU11A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260033374"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:20 -0700
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
	tushar.vyavahare@intel.com,
	andrii@kernel.org
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v2 0/5] selftests/xsk: improve shared-UMEM coverage
Date: Thu, 13 Aug 2026 06:27:49 +0000
Message-ID: <20260813062754.360131-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP shared-UMEM support in the existing XSK selftests is limited to
a small set of scenarios, while the supporting setup and cleanup paths
become fragile as coverage expands.

This series improves shared-UMEM testing and infrastructure in five
steps.

Patch 1 makes UMEM ownership explicit with refcounting and centralizes
socket/UMEM teardown, keeping cleanup behavior consistent across normal
completion and error paths.

Patch 2 prevents TX setup when RX socket configuration has already
failed. This avoids shared-UMEM TX setup relying on incomplete RX-side
socket and UMEM state.

Patch 3 expands XSKMAP and test capacity to four sockets and adds a
length-based XDP steering program. The classifier uses total
XDP-visible packet length (data_end - data) and SHARED_UMEM_LEN_SPLIT.

Patch 4 adds the shared-UMEM callback runner and initial 4-socket,
length-based steering, uneven-distribution, and unaligned-chunk test
cases. The unaligned path snapshots and restores alignment flags with
NULL-safe UMEM guards.

Patch 5 makes pkt_stream_even_odd_sequence() transactional: it stages
replacement streams until all allocations succeed, avoiding leaked
replacement streams and partially replaced socket stream arrays after
an allocation failure.

Together, these patches strengthen shared-UMEM setup and cleanup and
extend selftest coverage to multi-socket and packet-distribution
scenarios.

v1 -> v2:
- [1/5] Track per-slot UMEM ownership and centralize refcount-based
  socket teardown. [sashiko]
- [2/5] Replace the redundant partial-socket rollback with RX failure
  publication before the setup barrier and skip TX setup after a failed
  RX configuration. [BPF AI]
- [3/5] Trim the length-classifier comment to match nearby BPF style.
  [BPF AI]
- [5/5] Clarify the partial stream replacement leak in the commit
  message. [BPF AI]

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Tushar Vyavahare (5):
  selftests/xsk: add UMEM users refcount and centralize socket teardown
  selftests/xsk: Skip TX setup after RX configuration failure
  selftests/xsk: expand XSKMAP capacity and add length-based XDP program
  selftests/xsk: add shared-UMEM callback framework and initial test
    cases
  selftests/xsk: make pkt_stream_even_odd_sequence rollback-safe

 .../selftests/bpf/prog_tests/test_xsk.c       | 423 ++++++++++++++++--
 .../selftests/bpf/prog_tests/test_xsk.h       |  26 +-
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  15 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   3 +-
 tools/testing/selftests/bpf/xskxceiver.c      |  38 +-
 5 files changed, 430 insertions(+), 75 deletions(-)

-- 
2.43.0
