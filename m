Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23261414A2A;
	Thu, 13 Aug 2026 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602633; cv=none; b=adgBtzM+AOZmrtighcAgDTBIUxl0bYDCk4/KAY78ED10+gp95YE9OHtHp9459U9g1zUNTpgCwKW+ktgSXvMeaLTQtRg8Ly8Uli2ddgZNo8qqjAn9/5713CmzQ9RAnLbnKKbck2/jp79JcjZesAecWv3kSuvlsJeYxfzbqLH1a7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602633; c=relaxed/simple;
	bh=xfQXLrpVgT3l5CY/+kxM966Cr+RQGelivBanh7yKUqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsXOBRD7+PEpJncxzZlLsK4KWzFf8u5lSe34kiw/OI8g7SPbKh1NjkpMyWo7xbcBJMgqKRGLRL8BAKMicyEN/GXNonjau+2f7l7TPpaVFjj9WpXeezKQHtzeT/WjEBDV2qSGS5SDoILXltHVOOv7hvrmSXi32FpiVQ6vt2FBUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiP7RLHK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiP7RLHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786602633; x=1818138633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfQXLrpVgT3l5CY/+kxM966Cr+RQGelivBanh7yKUqk=;
  b=RiP7RLHKuE4dv145mqXAsZrdTgAH5Zp2X8lM1GVDQKB1iTGVpKw5InQC
   JCAm9+CNUM621Bgb2d5731iGweMq8ylM9xSw5gYMRwzQVuKaYVpJQlV41
   AYTUt563iaBY30UAHj8xIWiFOPiU4eh8VHsyvoJo7KFdAMGYKzxMpAnTG
   n7mLsyXrXjCRExlz/OhEFo1UoqOUwI3VlTLkXRWMoDPFNhDyckslS/+wv
   ewAp5Iop7R7awdIJiu65FS/R5JL4/g/NBgH9P+u9ox37Ws5GWZQSgrpmx
   iuKFUNxtf7lvIeyBCBHmIN8A/ywdGvjtoWcfyiwnOgGv0Zs3SwAmX/2Qd
   g==;
X-CSE-ConnectionGUID: 9EZqKwqdT0qUGIhIfwt9bg==
X-CSE-MsgGUID: AK645ckxSmuhNMtbuyRXLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86933887"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86933887"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:32 -0700
X-CSE-ConnectionGUID: Te35g2ijT+utLSOAa2nr/g==
X-CSE-MsgGUID: 1A8qaZHbRdOR/ee2SEt4Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260033487"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:30:28 -0700
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
Subject: [PATCH net-next v2 2/5] selftests/xsk: Skip TX setup after RX configuration failure
Date: Thu, 13 Aug 2026 06:27:51 +0000
Message-ID: <20260813062754.360131-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813062754.360131-1-tushar.vyavahare@intel.com>
References: <20260813062754.360131-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RX socket setup fails during the first traffic step, the RX worker
previously reports test->fail only after waiting at the setup barrier. The
main thread can then start TX setup before it observes that failure.

For shared-UMEM tests, TX setup depends on the RX-side socket and UMEM
state having been configured successfully. Do not start TX setup after a
failed RX setup.

Set test->fail before the RX worker reaches the barrier and check it
before starting the TX thread. The existing post-join teardown cleans up
the RX socket slots and UMEM.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index a3c77ab5f05c..6d3b2ecc957b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1703,12 +1703,15 @@ void *worker_testapp_validate_rx(void *arg)
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

