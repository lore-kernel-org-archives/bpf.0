Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAD4848AA;
	Thu,  8 Oct 2026 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460164; cv=none; b=aDr8A/aRkMlu88/N0I16sW8ruCtqm5N699qJaEN+LOBh1LUWDWJMBV3TAZobbpEcsIlyLmXbgK/cheeO6Dj5Zl/folcwq4jgdqFjRGSHHFF9lKg4IbHdJmm7GJ+1GcnY/E+R/1K7xvhWFCQmYpw22egWY3k3pgQTCU4HctFfV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460164; c=relaxed/simple;
	bh=1MLBwrasXCaCoOBM6aEwA8sCMLRpEo2XMn58YaixR9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYSX9zIO6mjSEcz5MBWCtl7BddADPqsDKtusmY1bjmPWvUghSfEVVtYgH18oAlru5UFAtQfcUL/cKhttmrWDUZpXFMi1XMYYGnDyo9TwS5PYKaARj0QfHe548Cy3Abi8PnR+D62yI5ZXhyPbNRPh4phFiAE7RPdCj7vFHrCx6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lee/bgCJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lee/bgCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460164; x=1822996164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MLBwrasXCaCoOBM6aEwA8sCMLRpEo2XMn58YaixR9c=;
  b=Lee/bgCJ+7xCl8tf6U1brwT7+7DhhIhXdBTeevXkThKqvUV6Aj3l+yAG
   ojluA/o4BJv6dL4+/IWT0+x4b/asRoraqkoqk8BaQlXiJXrInR2Ssohsx
   grWLwoZF1jlkRDS/ci7q9knBu/0dZky0rk7HUqE2qSzfA7ivVTVzBYcQP
   9s2IaQk5rK6DF/AXRkLfc8ahBbJdcxZ2J0Iq6YUEkQNmnhRrKlnTcWi8W
   LDpabAnf7RsVEQpmVakTt4KC51KKzJVdklZt6b9vT9319iz3wZgiaaZXR
   fYEXWkRKb1IElnz5wh1cAfzY/5+YR7qUKIZiqtrGztGSkr3UyqRmoN5Ti
   g==;
X-CSE-ConnectionGUID: 6epVod30TMm1kCAWJ3Yh6Q==
X-CSE-MsgGUID: 6fP2fFl9R+G6Md2QNCs4PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124918"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124918"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:23 -0700
X-CSE-ConnectionGUID: zMv9oRNcRUyWc+++TrmwNA==
X-CSE-MsgGUID: DBVDAHj2SlSyjT80Xe5xvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467094"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:21 -0700
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
Subject: [PATCH v2 net-next 01/14] selftests: xsk: factor endpoint work out of pthread wrappers
Date: Thu,  8 Oct 2026 13:48:56 +0200
Message-Id: <20261008114909.734364-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move TX execution, RX setup and RX validation into synchronous helpers
and leave the pthread entry points as thin wrappers, so the same code
can later run without a thread per endpoint. Barrier, pacing and test
behavior are unchanged, but plan is to step away from thread-based
model in favor of separate process approach, hence this preparation.

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

