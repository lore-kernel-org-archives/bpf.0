Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A525D216
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626403; cv=none; b=rWs6cdjoToJUWkeh8gM/wMkKpr7nqqzk2F/Mct5Sm1ga4AdeCvC+qTK6MJ8ZvbnrAWOWM9PUzDZrr13SaX1gOkLtvGgFIfKBW0HWTHYqzX1whXtbD48S4WMCoP7MGGUuZwQeksTq2MV2DkIzE753M1kUN+tytBLV/+sAGOvUzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626403; c=relaxed/simple;
	bh=WxIHISnlJujj/dtKo/N6448U5Y6RpFNFaB5rPM1xSVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QefXa3H51R/ghHvreCi7TkskuI0B4HR+acNEyEZn03n3ah/C29kqxtQHVL1dFbqvOJA2a0v6orQZj49xSP0kEIMB2RT5Jd/xOGl0abpfaYkpegl/uCFwJLaOvEleE+Mrzqu0PgbNAy+QVatSzCmP+ebwHADTPO/rBRotjsQJJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CsNB0/hz; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CsNB0/hz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A90CmRkI47b5bxg9+VzZKEZEkNShHExnEzDPpDjrzDM=;
	b=CsNB0/hzEVEgmYUHload31OQNfcZDS3ta0SJk5JPvFKppO02cxleA4oa0W202vKLgESFyq
	flNZg5hqq06q+9JMmI3hHuABv3XDsBN9j1t2p44JY8h93IFONaRmXlnNUyalaUtQtjmySD
	9oUc01Ww6UpikNbDaj5H+hv+goKx0BU=
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
Subject: [PATCH bpf v3 05/15] selftests/bpf: Fix memory leaks in tests
Date: Fri, 20 Feb 2026 14:25:54 -0800
Message-ID: <20260220222604.1155148-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
References: <20260220222604.1155148-1-ihor.solodrai@linux.dev>
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

