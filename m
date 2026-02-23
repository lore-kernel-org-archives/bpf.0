Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B236AB45;
	Mon, 23 Feb 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873712; cv=none; b=LP/rc7grwWhMjY6I1HppqmFc8LIsa+p53vHsHfmqWsym2kTvJH2IwULkaRwVEJPMqy82Rwgyzfi72pU8oDNfOT5WonTylQcJ7jnSODagsqE5blPcLo276M7C3mueW9DciKvSTke+WGUHfYKDoG9jN5n/MEYXOqMardwsfPUOR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873712; c=relaxed/simple;
	bh=WxIHISnlJujj/dtKo/N6448U5Y6RpFNFaB5rPM1xSVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3t+JE3VB7Fnf27gGZVDgYQWm+IQe2ORWjmiswJ6D7jvLmZZOcFTUSI1C57oQbnuaLk/+Y0DgSGburZ7ha5Q3JdeWpy//UdaqT/rQ4sj+02qiclxm5KQxO0o0R8FCgzWwNAYi06GHGfvrtT1lPolDIT+oI8rNxlFAYUt+TZpDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O57j4h46; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O57j4h46"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A90CmRkI47b5bxg9+VzZKEZEkNShHExnEzDPpDjrzDM=;
	b=O57j4h46os8LhBuD3Jj1yyj3Bf2JQjvbtUVz6C6/TaJHbmJGiSKkufgI84V9aJYJqvib8S
	hWzAWFE2hJYNzNlWXQoehbp0vuRwigYVMc9yKl1uilee/1VPYJqEdZ3QJdxRQIdVxqFJlL
	Kzn7wl5nJiKaS4bfri4oWbO0yDUJulA=
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
Subject: [PATCH bpf v4 10/20] selftests/bpf: Fix memory leaks in tests
Date: Mon, 23 Feb 2026 11:07:26 -0800
Message-ID: <20260223190736.649171-11-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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

