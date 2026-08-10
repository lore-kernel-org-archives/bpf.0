Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D113D9DB0
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370430; cv=none; b=u9qxwBvzL6T8EXgqBli9aJthhajYbNMc0gZEvqz3dfyKAD+qtFlKgpDEgNAUDt4xBvF9A8/LorkD1GM0WaNQgRy2DlDtHQYRq6T1gE8jFyoSXaHDklP1PrNd1dGxbST8jT0tE+lXbV2dktigFkBqBcjEKjo3S4T51EM7MgaM7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370430; c=relaxed/simple;
	bh=vYoywqIid8C39llvGtthw5wM+/Lb+1BHKmBfKGgXsXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHqEPWN+LXA7ueQ625i7P7vB4WNE1PEkZKREXtEFPJLc13acskuanH82KANSr94N+CYnmwQU8D1XNNKTgk6bBDRfdn9kAUQ7exHVMSFRtAXQUzqPcM2WkggL0Eg2mwciWdXXpT2N+N1MI/yBEujQCXQd+42KYkwtvQbypLjDInE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aLYsA5f5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aLYsA5f5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Aq
	1UB+6s16vYulxHBxK9nU8gXNUvfU5dnA/iitiEB3A=; b=aLYsA5f5AbuHFAyb9q
	HNAyF9xIVtT6j8ADWAzL92RqahR8n8xZvbCEyG+q7pl10wyEJY5MGXEnM1Zp/BOK
	NDV3FW+uNFjczc0MCF8zUN14ruJ19HcH4yTXh5STWvLy5YQStwib1CEKwHP4xGvN
	zvvvnRpwh1kQIA8Z5Eujtv+U8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X7VQ2XlqRT48Og--.14699S4;
	Mon, 10 Aug 2026 21:59:47 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add regression test for queue/stack map size limit
Date: Mon, 10 Aug 2026 21:59:34 +0800
Message-ID: <20260810135934.2887684-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810135934.2887684-1-chenyuan_fl@163.com>
References: <20260810135934.2887684-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7VQ2XlqRT48Og--.14699S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDuF4kXFWkGw45CFWUtwb_yoW5Wr45pa
	95Ja13t3y8Grs7J3y5tw1UXFZYgwn5Wr1UGFn7KryDArnIgr1Igry8tF15GFn7GrWkZa1Y
	vw1jqFZ3Gw47K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkGYLUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5hODQWp52VP6OgAA3u

From: Yuan Chen <chenyuan@kylinos.cn>

Verify that queue/stack maps whose element storage would overflow the
u32 head/tail index multiplication are rejected at creation time, and
that max_entries == U32_MAX (which would wrap the u32 capacity counter
to 0) is rejected as well.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../bpf/prog_tests/queue_stack_map.c          | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 41441325e179..043cbe92e2ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -2,6 +2,8 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 
+#define U32_MAX ((u32)UINT_MAX)
+
 enum {
 	QUEUE,
 	STACK,
@@ -101,8 +103,55 @@ static void test_queue_stack_map_by_type(int type)
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
+	if (fd >= 0)
+		close(fd);
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

