Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C658E2A1;
	Fri, 16 Oct 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172632; cv=none; b=sqJAfvhDTzmZLe0ygq8VnRbux8zZCO5UHFKiS1ZtF4VP5n+E2JjcB0hSMFfzBkjsi8MOHI2OIAV7hE7MDMvc1olw69hTrrluxCj7jsz3TBrlyAFGBTDmnoL8Zjc+4KS5NEKlVh/6HPCK0GIHL5hDiY55T4AuYJ8wK9vy38YcRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172632; c=relaxed/simple;
	bh=n8xR3sCuJkJMI28MjYCN2Fk6GY3D5gfq9K9jCPJq6Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMQbANv+lKDvQhXdyKQZcOR7KVlgaS290RtnIvFWlQbuNzHnCM8k6DNEJJM3K65Z3IHFWLoViB1p+fut10EiXGuXJu0Q/ta6mifCsKTHoxOX9tDKHcBhksWVbe4Ut7AzWgHgObd0Z7IEKVclecqt9Oo64ALuVviG7KtQmN9Bh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSvty2ZK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSvty2ZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172631; x=1823708631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8xR3sCuJkJMI28MjYCN2Fk6GY3D5gfq9K9jCPJq6Bg=;
  b=VSvty2ZKkLwSzyQuc/fXboRtRBz1zEGlljF1sFvHxOMQeDq76GAj5KM2
   eU/KezTOCfWUG9tnTKXVGwURotakQSNKmoZ9KT+DHrIqkbc755EJDiSjS
   +G+7+DdUgXPJqSSO5orG5fawgVapHI3Q7zbK5n3sv8+6Gfh3kOabGT5Tz
   Ji4839q716FUuDXW4cZOwXIv1baAlbtNrnhWrKpN8PIjKSIy1HLEeIX7m
   2/TkjGD3vner2cnGcgoBf8IvOQQq1ku1jZ3gzD//DeRYIoyeyJFjUMmjP
   zRzm5Rh+Xea2S8juZgwNFrwSFLiEdEEst9g3afiYhUXqBqKxXREcfy1FB
   w==;
X-CSE-ConnectionGUID: d3uiXMs1RHqmyHPzpbDsDg==
X-CSE-MsgGUID: dxWMKqiuSWGrmW5r2VG3gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972331"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:43:50 -0700
X-CSE-ConnectionGUID: pTGck6Q8SY+uYSuG1/pO9w==
X-CSE-MsgGUID: OtDXTUjTTY2zCkqJ71zjjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425177"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:43:48 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net-next 01/15] selftests: xsk: factor endpoint work out of pthread wrappers
Date: Fri, 16 Oct 2026 19:43:24 +0200
Message-Id: <20261016174338.787135-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move TX execution, RX setup and RX validation into synchronous helpers
and leave the pthread entry points as thin wrappers, so that the same
code can run in a process per endpoint later in this series. Barrier,
pacing and test behavior are unchanged.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 98 +++++++++++--------
 1 file changed, 59 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 4549358cc8c2..2a1362874092 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1623,40 +1623,31 @@ static int thread_common_ops(struct test_spec *test, struct ifobject *ifobject)
 	return 0;
 }
 
-void *worker_testapp_validate_tx(void *arg)
+static int testapp_validate_tx_endpoint(struct test_spec *test,
+					struct ifobject *ifobject)
 {
-	struct test_spec *test = (struct test_spec *)arg;
-	struct ifobject *ifobject = test->ifobj_tx;
 	int err;
 
 	if (test->current_step == 1) {
-		if (!ifobject->shared_umem) {
-			if (thread_common_ops(test, ifobject)) {
-				test->fail = true;
-				pthread_exit(NULL);
-			}
-		} else {
-			if (thread_common_ops_tx(test, ifobject)) {
-				test->fail = true;
-				pthread_exit(NULL);
-			}
-		}
+		if (!ifobject->shared_umem)
+			err = thread_common_ops(test, ifobject);
+		else
+			err = thread_common_ops_tx(test, ifobject);
+		if (err)
+			return err;
 	}
 
 	err = send_pkts(test, ifobject);
 
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
-	if (err)
-		test->fail = true;
 
-	pthread_exit(NULL);
+	return err;
 }
 
-void *worker_testapp_validate_rx(void *arg)
+static int testapp_prepare_rx_endpoint(struct test_spec *test,
+				       struct ifobject *ifobject)
 {
-	struct test_spec *test = (struct test_spec *)arg;
-	struct ifobject *ifobject = test->ifobj_rx;
 	int err;
 
 	if (test->current_step == 1) {
@@ -1669,35 +1660,64 @@ void *worker_testapp_validate_rx(void *arg)
 				       strerror(-err));
 	}
 
-	if (test->use_barrier)
-		pthread_barrier_wait(&barr);
+	return err;
+}
 
-	/* We leave only now in case of error to avoid getting stuck in the barrier */
-	if (err) {
-		test->fail = true;
-		pthread_exit(NULL);
-	}
+static int testapp_validate_rx_endpoint(struct test_spec *test,
+					struct ifobject *ifobject)
+{
+	bool supported;
+	int err;
 
 	err = receive_pkts(test);
 
 	if (!err && ifobject->validation_func)
 		err = ifobject->validation_func(ifobject);
+	if (!err)
+		return TEST_PASS;
 
-	if (err) {
-		if (!test->adjust_tail) {
-			test->fail = true;
-		} else {
-			bool supported;
+	if (!test->adjust_tail)
+		return err;
 
-			if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
-				test->fail = true;
-			else if (!supported)
-				test->adjust_tail_support = false;
-			else
-				test->fail = true;
-		}
+	if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
+		return TEST_FAILURE;
+	if (!supported) {
+		test->adjust_tail_support = false;
+		return TEST_PASS;
 	}
 
+	return err;
+}
+
+void *worker_testapp_validate_tx(void *arg)
+{
+	struct test_spec *test = (struct test_spec *)arg;
+	int err;
+
+	err = testapp_validate_tx_endpoint(test, test->ifobj_tx);
+	if (err)
+		test->fail = true;
+
+	pthread_exit(NULL);
+}
+
+void *worker_testapp_validate_rx(void *arg)
+{
+	struct test_spec *test = (struct test_spec *)arg;
+	struct ifobject *ifobject = test->ifobj_rx;
+	int err;
+
+	err = testapp_prepare_rx_endpoint(test, ifobject);
+
+	if (test->use_barrier)
+		pthread_barrier_wait(&barr);
+
+	/* We leave only now in case of error to avoid getting stuck in the barrier */
+	if (!err)
+		err = testapp_validate_rx_endpoint(test, ifobject);
+	if (err)
+		test->fail = true;
+
 	pthread_exit(NULL);
 }
 
-- 
2.43.0

