Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5C3D8131;
	Thu, 25 Jun 2026 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388343; cv=none; b=PgEGWkL2XF+GzRmf9FOYp529OsQm7FSHoMMouFLJsx6QV3y/w3vF6DQWkR0UxDJ9LRWSY7EGhVVs/JEHLriABdsIXx98TsHYiT5UdDj2AkE89GSvxBUiB59plfjY5GTXfyarEDnunMC9ofMxCOI5P1brD7WF6Sm3kWdQOtFniww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388343; c=relaxed/simple;
	bh=1QgyVE0VKY8LGCv8Iung0ENYj2jFbspc8w9gsaoFru8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umfLUMWw4nh3Pxe6Ay2nhZE9mVfGvGN0U8teTcSDk+hRt6uiux65F8p+L7GAgqGOfWOjZCcFlFWxS3foQU/HFc0ACzBViuE8znzQoaNXC3/g0xcorv3in00/CQGHOOzn49B4X6wJ89z1YStXDjuKt1hFROvZQgRK15e824ioLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H06QXh4q; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H06QXh4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782388342; x=1813924342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1QgyVE0VKY8LGCv8Iung0ENYj2jFbspc8w9gsaoFru8=;
  b=H06QXh4qvFx07Ube2LHt2/Ehjb8y502wS+r5yrAl5lAKjAC8JrU5xcGX
   EvuzylOJXIYF0H8LGHoPCY8ulTcgL51/ZLQbpItXfKhhcXyHwbxO0+xMb
   09XOZecRisffm2JF3/pMX/ASFhmSma5HH74QKUJeGg3SutI2kCiLAZBas
   eXQ9Ilvb0Xk1vDoOgKBvGs6vGY0/y+h8W9HdJF2yhkGg8sbg6F70FYhlG
   ACsvkRCy5fJyMINZhwa1hYf5Y6zidxJo2wc5nKDP6EnWxFEXAEql7Uf4Y
   Z1F/0tAQJQ+2WfVFYxTvZ07ZD8rqV+nsze/6+plre1nrT4k9fE4d7I7gQ
   A==;
X-CSE-ConnectionGUID: WT4NOTUbQsK9QhNs80ckmg==
X-CSE-MsgGUID: mGGOMtLGTZ2h+ZQDK/gpFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83215155"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83215155"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 04:52:21 -0700
X-CSE-ConnectionGUID: LRe6WxBgSTOuxFWfSDddWw==
X-CSE-MsgGUID: UxBhEGdRRXKBY1AI8DzgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246661084"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2026 04:52:19 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in BIDIRECTIONAL test
Date: Thu, 25 Jun 2026 13:52:15 +0200
Message-Id: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UMEM state refactor made __send_pkts() use xsk->umem for Tx
address generation. At the same time, the shared-UMEM Tx setup copies the
Rx UMEM state into a Tx-local state object and resets base_addr and
next_buffer before configuring the Tx socket.

Passing that Tx-local object to xsk_configure() makes xsk->umem point to
the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test once
the roles are switched: the same socket is then used for Rx validation, but
received descriptors from the other logical UMEM half are checked against
base_addr == 0. With the new UMEM bounds check, a valid address such as
base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
window.

Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
and Rx validation. Use the ifobject-local UMEM copy only for Tx descriptor
address generation, preserving the BIDIRECTIONAL test's intent of using
the proper logical UMEM half after the direction switch.

Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk_socket_info")
Reviewed-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Tested-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2:
- fix SoB line
- rebase
- add tags from Tushar
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 72875071d4f1..26437d4bdc8e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1169,8 +1169,8 @@ static int receive_pkts(struct test_spec *test)
 static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
 {
 	u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
+	struct xsk_umem_info *umem = ifobject->xsk_arr[0].umem_real;
 	struct pkt_stream *pkt_stream = xsk->pkt_stream;
-	struct xsk_umem_info *umem = xsk->umem;
 	bool use_poll = ifobject->use_poll;
 	struct pollfd fds = { };
 	int ret;
@@ -1521,7 +1521,7 @@ static int thread_common_ops_tx(struct test_spec *test, struct ifobject *ifobjec
 	umem_tx->base_addr = 0;
 	umem_tx->next_buffer = 0;
 
-	ret = xsk_configure(test, ifobject, umem_tx, true);
+	ret = xsk_configure(test, ifobject, umem_rx, true);
 	if (ret)
 		return ret;
 	ifobject->xsk = &ifobject->xsk_arr[0];
-- 
2.43.0

