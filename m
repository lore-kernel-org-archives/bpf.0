Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D847A865;
	Fri,  7 Aug 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110248; cv=none; b=W+/TyD4ps9LpfA2hILSMu7L7Dc5hE/vx4fwXLRhjpeYeASpu67rT88IMYeciy0aGuxCmjEaiOMtqMDRbxVs6l0k8M7XYiH9Wy5BAXgSZVHpU1Vv1G5jKkjs5jiSP2FshwFPJ5rIsmoB731BuGbIglpCVl4bcA2jQuEbUnJUuWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110248; c=relaxed/simple;
	bh=aWWMQSkZbKXri0tFZLqyOsPobBpLvE0Kmfoe6hh87xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEN8YHvtUURcVHfuW9Es6Hk+aVpD7myy1fXPWtTO04nlZsZunuBG5G9H9YFH8gKR5AsOkQGyvzgZX+qOHO4ZD0qyL+zlywGhcRdrWAMg/FMFUr5NoNZu1OtZYpAscyRGIu5QCclg9wrDTl4bSe5bv7XhADKJVus8iLtyYd1anIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gX3iQh4h; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gX3iQh4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786110245; x=1817646245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aWWMQSkZbKXri0tFZLqyOsPobBpLvE0Kmfoe6hh87xQ=;
  b=gX3iQh4h7dhxHLLEwlOcfLXTVYFn4ZXBwI0WknOVVImdnvhKKfrOJQAV
   DCAtm67BmT3Z/8RvuVu7fmH12qHmdw7K4R/hYQjvsOMTlYp8kdLJ50Q11
   QjeWbyHVBCICYyx/rW1iktntV/vMWLKxqkkYAb5GNGpWVY8oAi5MLbgZx
   ESffCLchZ+g7I0wNULpOu1759x5LdKcuE6zwpz9SaaO8kHXJ6koyRpVrN
   dFZvJxUGpaAn3xqUT6fOqYG1M99nlTSgr/ywkQuefzygNWlfcaq0B98KO
   hXJFGSTWDHVeQeutOEPQiP5loY5IFGXxRPT+zX52XR+jla6yHMInPgo+W
   A==;
X-CSE-ConnectionGUID: caYcbJpmR6ywSPKy86EmbQ==
X-CSE-MsgGUID: ZUstbVgfRSy8Ix+CpTfRrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98079925"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98079925"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:44:02 -0700
X-CSE-ConnectionGUID: wBjy6OpMRhOx+leeNz9t7g==
X-CSE-MsgGUID: O/g4HMp0SjqF0t9CfY9oCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287080037"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 06:43:57 -0700
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
Subject: [PATCH net-next 0/5] selftests/xsk: improve shared-UMEM coverage and infrastructure
Date: Fri,  7 Aug 2026 13:42:04 +0000
Message-ID: <20260807134209.3794735-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_XDP shared-UMEM support in existing XSK selftests is limited to a
small set of scenarios and cleanup paths that become fragile as coverage
expands.

This series improves shared-UMEM testing and infrastructure in five
steps.

Patch 1 introduces explicit UMEM lifetime management with refcounting
and consolidates socket/UMEM teardown into common helpers, keeping
cleanup behavior consistent across normal completion and error paths.

Patch 2 adds rollback for partial socket setup in xsk_configure() when
xsk_socket__create() retries are exhausted or busy-poll setup fails.

Patch 3 adds a length-based XDP steering helper and updates XSKMAP/test
capacity constants for 4-socket scenarios. Steering is explicitly based
on total XDP-visible packet length (data_end - data) using
SHARED_UMEM_LEN_SPLIT.

Patch 4 adds the shared-UMEM callback runner together with the first
four test cases (4-socket, length-based steering, uneven distribution,
and unaligned chunk mode) in one commit so every SHA in the series
builds and bisects cleanly. The unaligned path snapshots/restores prior
alignment flags with NULL-safe UMEM guards.

Patch 5 makes pkt_stream_even_odd_sequence() rollback-safe by staging
replacement streams in temporary arrays and committing only after all
allocations succeed.

Together, these patches make shared-UMEM setup/cleanup more robust and
extend selftest coverage to common multi-socket and distribution
scenarios.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Tushar Vyavahare (5):
  selftests/xsk: add UMEM users refcount and centralize socket teardown
  selftests/xsk: roll back partial socket setup on configure failures
  selftests/xsk: expand XSKMAP capacity and add length-based XDP program
  selftests/xsk: add shared-UMEM callback framework and initial test
    cases
  selftests/xsk: make pkt_stream_even_odd_sequence rollback-safe

 .../selftests/bpf/prog_tests/test_xsk.c       | 428 ++++++++++++++++--
 .../selftests/bpf/prog_tests/test_xsk.h       |  24 +
 .../selftests/bpf/progs/xsk_xdp_progs.c       |  19 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h  |   3 +-
 tools/testing/selftests/bpf/xskxceiver.c      |  35 +-
 5 files changed, 436 insertions(+), 73 deletions(-)

-- 
2.43.0

