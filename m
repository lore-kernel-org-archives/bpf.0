Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C93BE16E;
	Wed, 19 Aug 2026 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107646; cv=none; b=XpI3oV7e7OGnjxLoNu9kUYLguUUe2ktwkK5dSJ6EBkMeX3HBpFi8akWPnLj+6KyQM7CdW1ui0NkF5ObMbLwLZ/Uo35Z4Af6MC3MvLRh222AD/TuUV0F66sy8bi4UqXoAWyHEsQMpiuxYsj8Vx7H5rB8z1VWgmiJqfSyQrUXWw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107646; c=relaxed/simple;
	bh=ZmlDpW2WF7P7kq3fZwRZB1boeKDRWSIBODjO5yrMetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Izzs6tRqu8FuSe2hn9k7Jp1I7NFfk2ogasYup9QxtN9/fqDaUGsJV5idl8NFgOzD3K8x4G339Yv6CG/4CYlhftNt6bYJEomXUAz7gwh97/HC2ve0fPeATsR/xV3fbmglFa2dp3hKiHodbAHj4dVGd8pWfCJQxspxlMVck8BsJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZZM5yQI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZZM5yQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787107645; x=1818643645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmlDpW2WF7P7kq3fZwRZB1boeKDRWSIBODjO5yrMetU=;
  b=lZZM5yQIrX91YfhsAW3KKHTtKDCOVSObfOJ+ScbTfNZWwA2iQQSNILRU
   nWHRi5CBJg+1UEXNxSY5hC+dnDB5OBFZYh/enSJbxH9TA1sRfc5QUKMPt
   6Ak6x3ktg/K+rHdycg5ut6jOgUyUUipFZm2svZL8QlPzM2fev/ueCpoXD
   SJAe91FevP7RpONOggsgTm2vZJ5uLcb6RAjPzOeyD+svDJKGBnRp2FuSO
   1+NyS2aZ7BbvMCwyM4x1qymPUR4WqxZZtORhU19HGWtWOtKn5bVfavmDm
   SXV/f70DKPf/kvwkGNYt/8voYU5zameO3lzXOdyKk6ll6IYvypCK/BBZR
   g==;
X-CSE-ConnectionGUID: k9mrwsdwR4yKWxjxH4b8Ew==
X-CSE-MsgGUID: SsWK+rz8SC+6gZVW8zrT6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87465285"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87465285"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:25 -0700
X-CSE-ConnectionGUID: tfVR4fe5RPKrMi/TLdxaCA==
X-CSE-MsgGUID: sB1IO4qqRpKlS4YgetarPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264974415"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 19:47:21 -0700
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
Subject: [PATCH net-next v3 2/4] selftests/xsk: skip TX setup after RX configuration failure
Date: Wed, 19 Aug 2026 02:44:41 +0000
Message-ID: <20260819024443.781764-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RX socket setup fails during the first traffic step, the RX worker
reports test->fail only after waiting at the setup barrier. As a result,
the main thread may begin TX setup before it detects the failure.

In shared-UMEM tests, TX setup relies on the RX-side socket and UMEM state
being initialized successfully. Proceeding with TX setup after an RX
configuration failure can therefore access uninitialized state.

Set test->fail before the RX worker reaches the barrier and verify it
before starting the TX thread. The existing teardown path after thread
join already handles cleanup of the RX socket slots and UMEM.

Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index bba5e8d4222d..814b8325493f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1699,12 +1699,15 @@ void *worker_testapp_validate_rx(void *arg)
 				       strerror(-err));
 	}
 
+	/* Publish setup failure before releasing the main thread from the barrier. */
+	if (err)
+		test->fail = true;
+
 	if (test->use_barrier)
 		pthread_barrier_wait(&barr);
 
 	/* We leave only now in case of error to avoid getting stuck in the barrier */
 	if (err) {
-		test->fail = true;
 		pthread_exit(NULL);
 	}
 
@@ -1907,7 +1910,7 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
 		}
 	}
 
-	if (ifobj2) {
+	if (ifobj2 && !test->fail) {
 		/*Spawn TX thread */
 		pthread_create(&t1, NULL, ifobj2->func_ptr, test);
 		pthread_join(t1, NULL);
-- 
2.43.0

