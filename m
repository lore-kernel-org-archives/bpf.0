Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C6171AD
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285751; cv=none; b=QkhOIsRAfNzQvDyuEFb9Z+BMK6bRhDMTwa8F4972glByKIUbBm42vfiYOHt4B2GP65SEjLxdrx4sQbjKxukM2Re30VPMQi3cNSfhaCNbcQFsTMhlRTl007z6CmrCmUy1cR222PH8wMNcTv+9v0faH8PacQXcu0kwMKW0lDv5GIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285751; c=relaxed/simple;
	bh=JrODJJcVR24hZIZEQI3b9QI4VckhWWVhWDwQbSFtSPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4q+b5HS+IezM0YWCvZ+xJUXjgn4xCdypPbetTMYeKJf5i9D8lWI4Quy5uX1tVJaCa1qSrUCKzBFJvB2uFJ04qpgvl7wFe6+yC2RbVDPRgwpvCQB8nxmuivOFHG9a1vrF+s62lqR09oxyLncgIrHI4o1JHdafVo0Tr+Um51jWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HiUC6p3/; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HiUC6p3/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712285741; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AcYjN5VXBKtvQEuuQE/zVL8Yv9a6PKz80X8USUskYXo=;
	b=HiUC6p3/CAZmy8B4x+sT32kRlw+Aj+Miv5t0/E1oUHs6JxqluhBG2dxI2MIxJOqTa8KBlL+VTA2wwwbyRR8oKn5hMGZsvlQ7UX2Ow6FNNSCQ8f9MgtawDpUCq27c2b7Ps04BO8KU8OVS2FzqajGoM8H0FiExvhHdN+xahas1XUA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3vv8Zw_1712285740;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3vv8Zw_1712285740)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 10:55:41 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: add test for bpf_for_each_map_elem() with different maps
Date: Fri,  5 Apr 2024 10:55:36 +0800
Message-Id: <20240405025536.18113-4-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240405025536.18113-1-lulie@linux.alibaba.com>
References: <20240405025536.18113-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test is added for bpf_for_each_map_elem() with either an arraymap or a
hashmap.
$ tools/testing/selftests/bpf/test_progs -t for_each
 #93/1    for_each/hash_map:OK
 #93/2    for_each/array_map:OK
 #93/3    for_each/write_map_key:OK
 #93/4    for_each/multi_maps:OK
 #93      for_each:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 .../selftests/bpf/prog_tests/for_each.c       | 62 +++++++++++++++++++
 .../selftests/bpf/progs/for_each_multi_maps.c | 49 +++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps.c

diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
index 8963f8a549f2..09f6487f58b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -5,6 +5,7 @@
 #include "for_each_hash_map_elem.skel.h"
 #include "for_each_array_map_elem.skel.h"
 #include "for_each_map_elem_write_key.skel.h"
+#include "for_each_multi_maps.skel.h"
 
 static unsigned int duration;
 
@@ -143,6 +144,65 @@ static void test_write_map_key(void)
 		for_each_map_elem_write_key__destroy(skel);
 }
 
+static void test_multi_maps(void)
+{
+	struct for_each_multi_maps *skel;
+	__u64 val, array_total, hash_total;
+	__u32 key, max_entries;
+	int i, err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+
+	skel = for_each_multi_maps__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "for_each_multi_maps__open_and_load"))
+		return;
+
+	array_total = 0;
+	max_entries = bpf_map__max_entries(skel->maps.arraymap);
+	for (i = 0; i < max_entries; i++) {
+		key = i;
+		val = i + 1;
+		array_total += val;
+		err = bpf_map__update_elem(skel->maps.arraymap, &key, sizeof(key),
+					   &val, sizeof(val), BPF_ANY);
+		if (!ASSERT_OK(err, "array_map_update"))
+			goto out;
+	}
+
+	hash_total = 0;
+	max_entries = bpf_map__max_entries(skel->maps.hashmap);
+	for (i = 0; i < max_entries; i++) {
+		key = i + 100;
+		val = i + 1;
+		hash_total += val;
+		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
+					   &val, sizeof(val), BPF_ANY);
+		if (!ASSERT_OK(err, "hash_map_update"))
+			goto out;
+	}
+
+	skel->bss->data_output = 0;
+	skel->bss->use_array = 1;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_OK(topts.retval, "retval");
+	ASSERT_EQ(skel->bss->data_output, array_total, "array output");
+
+	skel->bss->data_output = 0;
+	skel->bss->use_array = 0;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_pkt_access), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_OK(topts.retval, "retval");
+	ASSERT_EQ(skel->bss->data_output, hash_total, "hash output");
+
+out:
+	for_each_multi_maps__destroy(skel);
+}
+
 void test_for_each(void)
 {
 	if (test__start_subtest("hash_map"))
@@ -151,4 +211,6 @@ void test_for_each(void)
 		test_array_map();
 	if (test__start_subtest("write_map_key"))
 		test_write_map_key();
+	if (test__start_subtest("multi_maps"))
+		test_multi_maps();
 }
diff --git a/tools/testing/selftests/bpf/progs/for_each_multi_maps.c b/tools/testing/selftests/bpf/progs/for_each_multi_maps.c
new file mode 100644
index 000000000000..ff0bed7d4459
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/for_each_multi_maps.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, __u32);
+	__type(value, __u64);
+} arraymap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+struct callback_ctx {
+	int output;
+};
+
+u32 data_output = 0;
+int use_array = 0;
+
+static __u64
+check_map_elem(struct bpf_map *map, __u32 *key, __u64 *val,
+	       struct callback_ctx *data)
+{
+	data->output += *val;
+	return 0;
+}
+
+SEC("tc")
+int test_pkt_access(struct __sk_buff *skb)
+{
+	struct callback_ctx data;
+
+	data.output = 0;
+	if (use_array)
+		bpf_for_each_map_elem(&arraymap, check_map_elem, &data, 0);
+	else
+		bpf_for_each_map_elem(&hashmap, check_map_elem, &data, 0);
+	data_output = data.output;
+
+	return 0;
+}
-- 
2.32.0.3.g01195cf9f

