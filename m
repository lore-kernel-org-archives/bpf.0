Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE335972
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858870; cv=none; b=irUgCxU63obwWJjJ9u2ar3nAfCLLmlxOXEcudSghVhdV4TnP81Rd8EVINgl6Kh8YJ2vEAo+tmHBemeiC+6/irk+MMfMoUhQqbcLsNbmC66lH7t6oYGKWPiJEQu1oZn+6nLrPQWtmcrD3QPDQ3lSYvis28LFcXchWM6WCXwYuArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858870; c=relaxed/simple;
	bh=yllfhc5T0VQ81mYt1TnAnZSV8uFx28Iu5IiEUOiqLu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHIsllDSz2saGJGEzrE3/5HFclJNBG9tD8jGyAkx4HyD6Hbt5Hcl0aTv/nXSXJLRtz3GYgLhSHUNt1Bk2FDQ7BVYmW7qZqJ4cYAiGc8Oe29steDqZ9IlYJNLrWu+6NH/Crv2MJfp+ZsQ7cxxWlUBXP9cb1Mv/Kcaq1KmIP9OLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RwmWqZdE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RwmWqZdE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3UryONr82QOcsDXQInSLfyd4LBGQNlvXlWMbeH0b5Y=;
	b=RwmWqZdEJnc/EgwLvLCEJDIGl84npgyqDfJwy7eoHZJ9Vjws9z9W0hDeTohBTV69IhK0O3
	2htYrSyOpltiI2Kb2MG3f3dI6QaMH0BQGDY8dLf8IUFxbR7IqSR9nFBNoeRv924q3dlfxu
	mr83mSXtajJg+qcT0mKGQG5OIhL+KAo=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 05/14] selftests/bpf: Fix memory leaks in tests
Date: Wed, 11 Feb 2026 17:13:47 -0800
Message-ID: <20260212011356.3266753-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix trivial memory leaks detected by userspace ASAN:
  - htab_update: free value buffer in test_reenter_update cleanup
  - test_xsk: delete old pkt_stream before replacing in stats tests
  - testing_helpers: free buffer allocated by getline() in
    parse_test_list_file

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/htab_update.c | 1 +
 tools/testing/selftests/bpf/prog_tests/test_xsk.c    | 2 ++
 tools/testing/selftests/bpf/testing_helpers.c        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index d0b405eb2966..ea1a6766fbe9 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -61,6 +61,7 @@ static void test_reenter_update(void)
 
 	ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
 out:
+	free(value);
 	htab_update__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index bab4a31621c7..dac90ddcdd7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2005,6 +2005,7 @@ int testapp_stats_rx_full(struct test_spec *test)
 {
 	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
 		return TEST_FAILURE;
+	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
@@ -2017,6 +2018,7 @@ int testapp_stats_fill_empty(struct test_spec *test)
 {
 	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
 		return TEST_FAILURE;
+	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->use_fill_ring = false;
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 16eb37e5bad6..66af0d13751a 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -212,6 +212,7 @@ int parse_test_list_file(const char *path,
 			break;
 	}
 
+	free(buf);
 	fclose(f);
 	return err;
 }
-- 
2.53.0

