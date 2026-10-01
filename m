Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E400492E48;
	Thu,  1 Oct 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886157; cv=none; b=f1JNiEz7s9fDNmFFZEAGQLPpsR3suRzNEuH58QNZoPeerrj6h2bNOfXI5kuJsov/JMkyA1st/YY9KkGSSi77mCD9JC14M7mvaBZuN3OE0CHk+MEuU9tC/CNhGtU3icvxPEg/bWqvymFER4YigyjRlyoLhpzfJ5jlOOgmcF0EKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886157; c=relaxed/simple;
	bh=1MLBwrasXCaCoOBM6aEwA8sCMLRpEo2XMn58YaixR9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpv3pr/xendMmeBwP2s7AWiiPo9tcwdEkfWjOmjzervf6xyugo2SU9JX+hkd6jolsproCHe0+yqct6ZN6Za8a3g7WvJBmwrAtXujZjyPpZ8XlB3xLGb2hzeMo8P5AmLtmb4rCY6O6FR9zS6RFI9ALhXj5c+2R+PrI/gRorMe9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLq5Re4g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLq5Re4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886151; x=1822422151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MLBwrasXCaCoOBM6aEwA8sCMLRpEo2XMn58YaixR9c=;
  b=DLq5Re4gXAWzxt2WSSBqdxmDfH/OilfRiwjupAT6MgTcHpnbz0YOWGgO
   95BeQoK/W8kgHxP9v9RvjirhEzaBiFZ3qkRcg4PYefUXepqmrky8NG+W7
   1eHb8z5DE4BkXPunRNawPGFQHHENY6iO/H/mzoEglhaBgbHEx2/UN+hE1
   lp8nxJnPN361yhlXUJQ+HPuurmcsh82Ss5koFbY9rEnml7swMyUJ099mp
   VP0YokVqGN2kR2Mxm7iDuAj3Svtotu1gmx/UCyFiR1pfZ8/JBJUpXlTeC
   c3/CO7OsRVR++AWnrPh12yXryCOZs7x8cMlssrXyLy0zsnaAJNdy5CQUh
   A==;
X-CSE-ConnectionGUID: 26baqUt9TuKVDLigikFmSA==
X-CSE-MsgGUID: 0bODyL4AQMyLy8Gc7upPCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466791"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466791"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:24 -0700
X-CSE-ConnectionGUID: 3LMlFOmESEOg3lvkq8N44A==
X-CSE-MsgGUID: OQm9b1YTTSKqXIpUiEO+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636686"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:23 -0700
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
Subject: [PATCH net-next 01/13] selftests: xsk: factor endpoint work out of pthread wrappers
Date: Thu,  1 Oct 2026 22:21:12 +0200
Message-Id: <20261001202124.692591-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
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

