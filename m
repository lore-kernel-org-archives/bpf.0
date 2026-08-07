Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC13C4551;
	Fri,  7 Aug 2026 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068410; cv=none; b=F0Xghu/c9GfewHmKQF7SQ11mXAlerqWhxCXo3BLJ3IX7y3OmYwrDFz7eDh2Cj115PQi+3iSPsgwA3v0AJlrwm9fuGccSnQHf2EXSJ5JNSMjbyllZEyQxKgVqZu8+G8rHALJ24N7D8nd2Oa3rcJ2GZHz/EIAMbfVtr+nt5aPWlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068410; c=relaxed/simple;
	bh=gEPegvIxEWeSeyKAMyz6rS/H2geQgcqk1OwE7i0AdP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utpcpUL+rfJqAP+ib0shkWEQfoSbcWyomNNB9iAEEvMjLP+OUWdeIu40Yx4VuPvhSHgoCRGU3t/mv5mMRHWlpJxrK9d6sZuRumpodQLlJh0u2tDEzg+ObQtilesN2eDUVGO9Zy55tu/SaRM1KBUtQ/T86izzQVFDbv+bYl5JTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K6aClThy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K6aClThy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ix
	i2Nqgqjg61OldYMyrwA7BepICp+2fudiRBHJKOLE8=; b=K6aClThyeSVheiz5Hx
	TLBHirEoF2UzXyTYBsTtigWEUVn20NEcOedKZOdxFnWDIxJNVL5pQgOxW+zFAvQE
	PY68e6vjvhnoDnnV//lNnl8ppj+CLYV5SmYGmORWhj0iiEcgwJ7sUCNbG5JNo6bk
	svNa8HhXMSRry9vJoq98p0thU=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXnpiGPXVqyp9rNw--.41530S4;
	Fri, 07 Aug 2026 10:06:05 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH 2/2] selftests/bpf: Add regression test for queue/stack map size limit
Date: Fri,  7 Aug 2026 10:05:48 +0800
Message-ID: <20260807020548.1376979-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807020548.1376979-1-chenyuan_fl@163.com>
References: <20260807020548.1376979-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXnpiGPXVqyp9rNw--.41530S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1UWFy3Zw1rWFy7CrWruFg_yoW5Jr15pa
	95Xw43KFW8JrsrJ3y5tw4UXFZ5Wwn5WryUKFn7Kr9rJrnIqr1xWr48KFyUGFs3CrWkZa15
	Zw1vgrZ3Gw47K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvVbgUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5g1qKGp1PY1oFwAA35

From: Yuan Chen <chenyuan@kylinos.cn>

queue/stack maps address elements[] with a u32 head/tail index
multiplied by value_size, so maps whose element storage exceeds
U32_MAX bytes must be rejected at creation time (see the fix in
queue_stack_map_alloc_check()).

Verify that creating a queue/stack map with max_entries * value_size
> U32_MAX (8192 * 1MB) fails with -E2BIG, and that a normal-sized
map is still created successfully.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../bpf/prog_tests/queue_stack_map.c          | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index 41441325e179..6f8ac285e719 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -101,8 +101,42 @@ static void test_queue_stack_map_by_type(int type)
 	bpf_object__close(obj);
 }
 
+static void test_queue_stack_map_alloc_check(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	const __u32 big_value = 1 << 20; /* 1MB */
+	int fd, saved_errno;
+
+	/* Regression test for the u32 index overflow in queue/stack maps:
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

