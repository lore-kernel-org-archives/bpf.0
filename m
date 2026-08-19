Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26638391E73;
	Wed, 19 Aug 2026 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107641; cv=none; b=cL64lrR7QQmgXNostm7d3AEUy4aL4kPYdUr7d3/burSJxI1HYJkuTn50uPrnmCIRmBayE1FbVUR1aD5eO0J23i7MvrYadj8w5EFSLwa94JnXj3R07Gn7MTn9hIZ1/xfysMiYh8ptlw+kH7y7GUq/A+BfpZAC33al3o7/5KBZSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107641; c=relaxed/simple;
	bh=2n0B2ShrboWrolM9pLGFUtF6UAwLxTuiwk/f4ckPX1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIlxfiGinZ7ZR7KcvoFC2CUa6exPttCCIhdpQ3p0ATJjljJmaSRlhmDcIwVSpVSP4SEF8vzgv+Fy/P6yY+Rxk1aYNmXDtjNXXu3aJEs4Du742T9+irOZ9d3ZwhIto5qAmPgzeQDqKI9eRxxfH75zxbh7Hl1SZflA1XlhFrgzFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhvQYh6O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhvQYh6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787107639; x=1818643639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2n0B2ShrboWrolM9pLGFUtF6UAwLxTuiwk/f4ckPX1g=;
  b=LhvQYh6Od7QXbMeivOqG5YryklW0qrMvmmIHRVoobI73h7mxhW8nQ1NC
   m2Q8GUbKTeBmAtP6rCfyAndNwdu1PrZAZ6be+h/pZutqmfhKNY7ijoifT
   1TDN7v1yfCvXrh2KZn7ympmjqN0UBCUtRoAYSZLxAimFI543voCup0aei
   xd7uWR9yySGHtYh2DqJwJ+LUXz6Y0+UX4qv+ct7l5XM5VLpOQM+nufCa7
   /5lWJUB4EeZcgif390tJIl5MhgxjTGt9W+5cnyRILGKk5gcrqoXQayolQ
   0oEZVZSTy6GT06a4lc4DHkwJkaiMQmdAeRiU+kzNnV3l0+r6aUFflXM6O
   w==;
X-CSE-ConnectionGUID: FbOs6HQ5TIuGz/+HK+1PcA==
X-CSE-MsgGUID: pPyHs00FQgKZX4EN6efTgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87465268"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87465268"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:18 -0700
X-CSE-ConnectionGUID: AsyAwLo6T/K4YDzWqmZszQ==
X-CSE-MsgGUID: Zzmu/Hb7QUCXKS7WMmcujQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264974377"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:14 -0700
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
Subject: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM coverage
Date: Wed, 19 Aug 2026 02:44:39 +0000
Message-ID: <20260819024443.781764-1-tushar.vyavahare@intel.com>
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

This series improves shared-UMEM testing and infrastructure in four
steps.

Patch 1 makes UMEM ownership explicit with refcounting and centralizes
socket and UMEM teardown, keeping cleanup behavior consistent across
normal completion and error paths. A UMEM that survives teardown now
fails the test instead of leaking silently.

Patch 2 prevents TX setup when RX socket configuration has already
failed. This avoids shared-UMEM TX setup relying on incomplete RX-side
socket and UMEM state.

Patch 3 expands XSKMAP and test capacity to four sockets and adds a
length-based XDP steering program. The classifier uses total
XDP-visible packet length (data_end - data) and SHARED_UMEM_LEN_SPLIT.

Patch 4 adds the shared-UMEM callback runner and initial 4-socket,
length-based steering, uneven-distribution, and unaligned-chunk test
cases. The three packet-stream sequences share one transactional helper
that stages replacement streams and publishes them into the socket
arrays only after every allocation has succeeded.

Together, these patches strengthen shared-UMEM setup and cleanup and
extend selftest coverage to multi-socket and packet-distribution
scenarios.

v1 -> v2:
- [1/4] Track per-slot UMEM ownership and centralize refcount-based
  teardown. [sashiko]
- [2/4] Publish RX failure before the setup barrier and skip TX setup
  after a failed RX configuration. [BPF AI]
- [3/4] Trim the length-classifier comment to match nearby BPF style.
  [BPF AI]
- [4/4] Clarify the partial stream replacement leak in the commit
  message. [BPF AI]

v2 -> v3:
- [1/4] Keep one xsk_umem_info for shared-UMEM TX setup instead of
  copying it; initialize only the non-owning TX buffer view. [sashiko]
- [1/4] Propagate xsk_umem__delete() errors so the stack-allocated
  zero-copy probe cannot lose deferred cleanup. [sashiko]
- [1/4] Record UMEM deletion failures in test->fail; in-test teardown
  cannot retry them. [sashiko]
- [1/4] Collapse the redundant teardown helpers into a single loop.
  [sashiko]
- [4/4] Fold the previous 5/5 rollback-safe stream replacement into
  this patch. [BPF AI]
- [4/4] Factor the three stream sequences into pkt_stream_replace_seq(),
  driven by a pkt_stream_dims_fn callback. [BPF AI]
- [4/4] Drop the stream-readiness check and the uneven-distribution
  hook; neither could fail. [sashiko]
- [4/4] Drop the unreachable NULL-safe UMEM guards from the unaligned
  test. [co-pilot]

Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Tushar Vyavahare (4):
  selftests/xsk: add UMEM users refcount and centralize socket teardown
  selftests/xsk: skip TX setup after RX configuration failure
  selftests/xsk: expand XSKMAP capacity and add length-based XDP program
  selftests/xsk: add shared-UMEM callback framework and initial test
    cases

 .../selftests/bpf/prog_tests/test_xsk.c       | 340 +++++++++++++++---
 .../selftests/bpf/prog_tests/test_xsk.h       |  27 +-
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  15 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   3 +-
 tools/testing/selftests/bpf/xskxceiver.c      |  40 +--
 5 files changed, 344 insertions(+), 81 deletions(-)

-- 
2.43.0

