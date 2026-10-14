Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B4387341;
	Wed, 14 Oct 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003558; cv=none; b=Irul4RCFRFP4e//5pMT4eDPlBIkNisdDMSjgnTeWkqliVpTVoWIO+WxHHKYRPhGo8dmAZ9XdJhHLP+2dYFBKd1ky4QBkz5HduglpRi2UW68pXk/rQUIwli937ac4DMuJNDD74gFjKWlWaQBJOdQlTzmxuopYSOe4c72tC8HNswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003558; c=relaxed/simple;
	bh=1H9nA0pI46Y7H6wdHH4NkMi2wHmTpbTho+9ea+FRfiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njXaNMmlCiSBoclzCWE8MLSze05NszJLmqwC+zMXZQrHBhdSzdFjarUUA5ZKWAQLXhfpJC2C/GPhi6E45C4IEHmEe1OmXrXrsz1OWpq56Z1E3jPzku38HyHah+xbBh23hrGMAfhNfKKLt8BuIUUIVt14dR7HerV2Sz/fxyse4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgOxJSpU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgOxJSpU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003557; x=1823539557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1H9nA0pI46Y7H6wdHH4NkMi2wHmTpbTho+9ea+FRfiM=;
  b=CgOxJSpU74Zgf2njQkwv4Of4QjCx3/tSIq2Wtd3rDwet3//sQihMxbs5
   29aQT3axxtuytJZKuzQUpbfR2+3ngvMjDsGAyTFwh0rS6vPu4sZjRRqVd
   klkw4pwuMTrVzaOF5j2V+UKsbcDcCqD5tSW4rGoNvIl2HJnpws/Bf4Nbg
   thezgYb2PQ6Dzi8Snm5qTTwlMfEBjuMMpQewCaArX/ayEY0SbJTJOAEF4
   rM12l/bRV06MOqxwDoATzDH5jjyBpYa5dBrYeFj0EgmAMirx02M5E+dew
   y9LARm43MSt25pwbdFhgSVj+wd+tnhU5bmTSgwRYQcIeRmTzDaUEWjp+g
   w==;
X-CSE-ConnectionGUID: WgpW22veR4a0jyjv5fXkVA==
X-CSE-MsgGUID: ZV31mlhvT7mIgZ5G/0vOZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767260"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:45:56 -0700
X-CSE-ConnectionGUID: SSNVdwXmSxuTnS7pgpriCg==
X-CSE-MsgGUID: 2WVuAXwAR26VSPxLpStDSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420674"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:45:53 -0700
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
Subject: [PATCH v3 net-next 01/15] selftests: xsk: factor endpoint work out of pthread wrappers
Date: Wed, 14 Oct 2026 20:45:25 +0200
Message-Id: <20261014184539.774708-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move TX execution, RX setup and RX validation into synchronous helpers
and leave the pthread entry points as thin wrappers, so that the same
code can run in a process per endpoint later in this series. Barrier,
pacing and test behavior are unchanged.

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

