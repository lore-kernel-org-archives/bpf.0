Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70A3B3C17
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560472; cv=none; b=pPM3vZ/KHITN9JhRzYvpV7p0hRt4jY1jFl1t4q9bT+lCkak5tKdpWxsioKp6n6kpZ1R4v/lyJ+PIUUcipq/HB4/8aRSfXJ7cxuhBe5EyBnkwhGUrpki0Td6u3owK8Tudb611EwgUQFMYAy3NW5Su2oyFETP7uG+2/els0BFX33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560472; c=relaxed/simple;
	bh=5Vg+Ae0dkZb8MFRZUe+lNii+3fajC59xlykJV2UL/m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnEU1J/I5GUbc3YSMqvVIwv7RXgLBEH6FI1rVO788IgJMypLTAAkH9hh8qB7XUKt3pIWF3kgKotja0ThfjK6ihjwjto/vS1EXGJgPWztoN0y/Xc8PdiWvTLezRKeZHMf7m7GK3QxdentHV3PJuCT6vuMB4wL0njnN3TbV6XW1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kCDGbDI7; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kCDGbDI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gK
	o5vplmG/g72aI8qVupgczWP/Q6bUTODRYi3HE6rN4=; b=kCDGbDI7F7VqO/q9N/
	O3COypSf/awCprXQdMAQTLBwPmokEH//z3ehFYcfpBGkUHwia7R4x/FKdQli8qJC
	aXZxRWh0UGbTsKnnXB4xlrxm880ubVF8mkpL6zbqPc20DZy6o3P3AI1zMksO+Owk
	myGuhpyfC1mYDnD56AZQyvnRc=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3hgXdAYxqoLE7Ow--.19386S4;
	Mon, 24 Aug 2026 16:33:37 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	andrii.nakryiko@gmail.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for queue/stack map size limit
Date: Mon, 24 Aug 2026 16:33:27 +0800
Message-ID: <20260824083327.1708560-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824083327.1708560-1-chenyuan_fl@163.com>
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3hgXdAYxqoLE7Ow--.19386S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDuFy8Gr18JrWUAF43Wrg_yoW5Gry3pa
	95Ja13try8Gr4fJ3y3tw1UXFsYgws5WryUKFn2grykArnFgF1Igry8tF17Jrn3GFZ5Xa15
	Zw1YqFZ3Gw4jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv2NtUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gI282qMAeK1aAAA35

From: Yuan Chen <chenyuan@kylinos.cn>

Verify that queue/stack maps whose element storage would overflow the
u32 head/tail index multiplication are rejected at creation time, and
that max_entries == U32_MAX (which would wrap the u32 capacity counter
to 0) is rejected as well.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
v4: check the bpf_map_create() return value directly instead of errno
    as suggested by Andrii Nakryiko

 .../selftests/bpf/prog_tests/queue_stack_map.c     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 41441325e179..efe808eedd9a 100644
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
@@ -101,8 +103,43 @@ static void test_queue_stack_map_by_type(int type)
 	bpf_object__close(obj);
 }
 
+static void test_queue_stack_map_alloc_check(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	const __u32 big_value = 1 << 20; /* 1MB */
+	int fd;
+
+	/*
+	 * Regression test for the u32 index overflow in queue/stack maps:
+	 * a map whose element storage (max_entries * value_size) exceeds
+	 * U32_MAX bytes must be rejected at creation time, otherwise the
+	 * u32 head/tail index multiplication wraps and push/peek/pop
+	 * address the wrong element. 8192 * 1MB = 8GB > U32_MAX.
+	 */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, big_value, 8192, &opts);
+	ASSERT_EQ(fd, -E2BIG, "queue_oversize");
+
+	/*
+	 * max_entries == U32_MAX would make the u32 capacity counter
+	 * qs->size (max_entries + 1) wrap to 0, permanently breaking the
+	 * map, so it must be rejected as well.
+	 */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 1, U32_MAX, &opts);
+	ASSERT_EQ(fd, -E2BIG, "queue_u32max");
+
+	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, big_value, 8192, &opts);
+	ASSERT_EQ(fd, -E2BIG, "stack_oversize");
+
+	/* A normal-sized map must still be created successfully. */
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, 64, 100, &opts);
+	ASSERT_GE(fd, 0, "queue_normal");
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
2.43.0

