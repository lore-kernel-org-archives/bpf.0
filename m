Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28B3AFAEF
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354142; cv=none; b=ZVaclS/kF9mSF5py21l/J1SqbWzxtBAWH7IQNarS/inaQQbMQgL4OIioo8JhWqcRS06cLVtfHv3bNSxrv4sZ1a6gShRAXAKvAJ61sh0eD/bNwkrT3kobuokubIN5xsJM23mkpxhOmVcnOFOJNmM9B/OQIMl1Fi7vXGBOnZtqfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354142; c=relaxed/simple;
	bh=dxcp0CZRDOp2q5e+rr7UerSnZWd1pSkgU093sXfdMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSIErRI6DYzm3Bd5AEtxO5HY/QsOX765CPjo7LvrDwTh5dE0MDjGMd7CY/x3q4l1pUKU8D8R37O29SXu/aFES0W0A1OG2+pAIpmvMCLrHKh0A0GE7bF8p+6n6aJ9K7IpWchFgE5R7lfW3jKmrHUM+6t1FaCv4H6rlkC5tTU+Xmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Su2IDqEP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Su2IDqEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=j4
	4il50bFHgaumqS31YUHCXP+1RbTVVd3EXpBiV/hPk=; b=Su2IDqEPSooi74FDpi
	CAgxCvCgZs7wjOC0cbxEfGxjRcthIiNNzlm5hKIdNC4pnEhxfFo2FoOgqssHy2Ak
	K511sHB/xUBQmNRbMeVsGx9Vhn7A3Q1BTHR7dWiECxvvsA2vOjhO9Mxn43A+3b3c
	LqbZUpK21fMM0uTduWp+KJ5ts=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXP0C3mXlqOjt9Lg--.4593S4;
	Mon, 10 Aug 2026 17:28:27 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add regression test for queue/stack map size limit
Date: Mon, 10 Aug 2026 17:28:14 +0800
Message-ID: <20260810092814.2698521-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810092814.2698521-1-chenyuan_fl@163.com>
References: <20260810092814.2698521-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXP0C3mXlqOjt9Lg--.4593S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDuFy3JF1UWrW5CF17Jrb_yoW5Gw15pa
	95Jw43tay8Krs7J3y3tw4UXFZ5Kwn5Wry7GFn7KryDJrnIgr1Igr18tF15GFn3GrWkZa1Y
	vw1YqFZ3Gw47K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBLvtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RuNS2p5mbuuqQAA3O

From: Yuan Chen <chenyuan@kylinos.cn>

Verify that queue/stack maps whose element storage would overflow the
u32 head/tail index multiplication are rejected at creation time, and
that max_entries == U32_MAX (which would wrap the u32 capacity counter
to 0) is rejected as well.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../bpf/prog_tests/queue_stack_map.c          | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 41441325e179..8ab07ea77775 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -101,8 +101,53 @@ static void test_queue_stack_map_by_type(int type)
 	bpf_object__close(obj);
 }
 
+static void test_queue_stack_map_alloc_check(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	const __u32 big_value = 1 << 20; /* 1MB */
+	int fd, saved_errno;
+
+	/*
+	 * Regression test for the u32 index overflow in queue/stack maps:
+	 * a map whose element storage (max_entries * value_size) exceeds
+	 * U32_MAX bytes must be rejected at creation time, otherwise the
+	 * u32 head/tail index multiplication wraps and push/peek/pop
+	 * address the wrong element. 8192 * 1MB = 8GB > U32_MAX.
+	 */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 8192, &opts);
+	saved_errno = errno;
+	ASSERT_LT(fd, 0, "queue_oversize_fd");
+	ASSERT_EQ(saved_errno, E2BIG, "queue_oversize_errno");
+
+	/*
+	 * max_entries == U32_MAX would make the u32 capacity counter
+	 * qs->size (max_entries + 1) wrap to 0, permanently breaking the
+	 * map, so it must be rejected as well.
+	 */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &opts);
+	saved_errno = errno;
+	ASSERT_LT(fd, 0, "queue_u32max_fd");
+	ASSERT_EQ(saved_errno, E2BIG, "queue_u32max_errno");
+	if (fd >= 0)
+		close(fd);
+
+	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 8192, &opts);
+	saved_errno = errno;
+	ASSERT_LT(fd, 0, "stack_oversize_fd");
+	ASSERT_EQ(saved_errno, E2BIG, "stack_oversize_errno");
+	if (fd >= 0)
+		close(fd);
+
+	/* A normal-sized map must still be created successfully. */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts);
+	ASSERT_GE(fd, 0, "queue_normal_fd");
+	if (fd >= 0)
+		close(fd);
+}
+
 void test_queue_stack_map(void)
 {
 	test_queue_stack_map_by_type(QUEUE);
 	test_queue_stack_map_by_type(STACK);
+	test_queue_stack_map_alloc_check();
 }
-- 
2.54.0

