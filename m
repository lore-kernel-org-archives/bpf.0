Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877F296BA5
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374687; cv=none; b=uHAlyEhOTmupQhIGsb1/EJUvb8bFsCx3K2xt9qbtMSsic+3Wwh2GZ+5UjD4R9HnMQbAafzx7F+SI59xNGbHv4POSyHvbBORQ96qzfsZo/GjiypDF52YIkoIY5P8tn40MUUchXdLFOnWV+fsYx6q3mqwSiurfa4671CN1N8SgKsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374687; c=relaxed/simple;
	bh=Dqjt9da2F3+bSTPjCKiM2B8GO3yugqgHmf62RfXNF/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0WSptntNn0BxF21WsvOApjj52OoqdW0NynXCVrR2ysNoZA3xNs/MfamC169/J321F0/s5w6I4RNjj/lUOa3h6Zhcn7fJHTrlJgpUawbZT6UUfOYDWFdVnLtesH5C3MpxKpaInk+ZvPQ6Umj5QIhNhK1kDzRHorLGLz0ekkZjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWNbUZ3k; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWNbUZ3k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WbVeiBXZtOYlCXL9iWHzaxACQwulopsaza7fJa1mOo=;
	b=ZWNbUZ3kU9uhSfgGZuLLjWRTE0DvSuZ2JMh5kr4SryOSyFVVwAkeepDW9RcaVlqaIFxatH
	C9KEOvn3aIsLGsFE9xomGm9vgs67le0kz+r4cL0iSoIv7labUNrxwxQftNHJWLLC4GAT9x
	w1Z0gSK2njwv59WgZL3aDkrm4HTkstU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 05/15] selftests/bpf: Fix memory leaks in tests
Date: Tue, 17 Feb 2026 16:30:31 -0800
Message-ID: <20260218003041.1156774-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
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
  - test_xsk: inline pkt_stream_replace() in testapp_stats_rx_full()
    and testapp_stats_fill_empty()
  - testing_helpers: free buffer allocated by getline() in
    parse_test_list_file

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/htab_update.c    |  1 +
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 +++++++++++++++----
 tools/testing/selftests/bpf/testing_helpers.c |  1 +
 3 files changed, 22 insertions(+), 4 deletions(-)

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
index bab4a31621c7..7e38ec6e656b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -2003,9 +2003,17 @@ int testapp_stats_tx_invalid_descs(struct test_spec *test)
 
 int testapp_stats_rx_full(struct test_spec *test)
 {
-	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+	struct pkt_stream *tmp;
+
+	tmp = pkt_stream_generate(DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (!tmp)
+		return TEST_FAILURE;
+	test->ifobj_tx->xsk->pkt_stream = tmp;
+
+	tmp = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	if (!tmp)
 		return TEST_FAILURE;
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	test->ifobj_rx->xsk->pkt_stream = tmp;
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
 	test->ifobj_rx->release_rx = false;
@@ -2015,9 +2023,17 @@ int testapp_stats_rx_full(struct test_spec *test)
 
 int testapp_stats_fill_empty(struct test_spec *test)
 {
-	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE))
+	struct pkt_stream *tmp;
+
+	tmp = pkt_stream_generate(DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	if (!tmp)
+		return TEST_FAILURE;
+	test->ifobj_tx->xsk->pkt_stream = tmp;
+
+	tmp = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	if (!tmp)
 		return TEST_FAILURE;
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
+	test->ifobj_rx->xsk->pkt_stream = tmp;
 
 	test->ifobj_rx->use_fill_ring = false;
 	test->ifobj_rx->validation_func = validate_fill_empty;
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

