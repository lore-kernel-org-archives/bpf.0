Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E1471274;
	Wed, 23 Sep 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154455; cv=none; b=bkVD4RnKn8EjHlOOUfz8Gd+LByL6zRpASg4z9S2nxtgoSvGJOfyBWY40YC0fTA7e8q6w9s59ioCQOPZHPPtDtHTy7wZ2NhVv/KuWpdV+TI3LPXSe5i88PDbwcCYoFjvrh/MYajTgrHYoDCwrLQOzSggkBa6VGeFdQ9Mi7Rp0YiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154455; c=relaxed/simple;
	bh=4rjEPn5rsRxjqIv65BtjQP5DFSL+taxZZqqx/X+y3WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1/LAEfAiSJ20HQmAKK4qJbReZfywY2vAapmn+5fLu90KaWJei4GszxzKdy/pMNzuIWA5hlkrLgfSqbmC/W2eZRgsTA2aRYOQ+5g9w2m3B93U03WOUkKO/PBG4Jzc/YYYghNsOTQ9qLeewQnQ/8Hoo7ACls8enX4Il+Kd5B8KI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bRItVp/r; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bRItVp/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bc
	NqT1UVY8xeWIGgXMpMHXdOczJ57YxKCerzPo7aX8A=; b=bRItVp/rD4EC6ndInq
	QtzHqIIpZMSIyW5pFBz4FvaVSREXaM3be2tV8XS3IE7kTuE96alrXrzTKokdQay3
	xLhbj9Lf/bICnOo6evd8V7/pFbQqaMvcpxBlx5tu4/3/cD7wK/04osV5nVBMT8+U
	H380AILXGAs8K6v1MdjW92EOk=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXvIWmlrNqQZffAw--.40141S4;
	Wed, 23 Sep 2026 17:06:51 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Verify is_extended with multiple freplace links
Date: Wed, 23 Sep 2026 17:06:35 +0800
Message-ID: <20260923090635.368488-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923090635.368488-1-chenyuan_fl@163.com>
References: <20260923090635.368488-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXvIWmlrNqQZffAw--.40141S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1UKr17Cr45KrWxWFy5CFg_yoW7AFyDpa
	yjqw1rKr1rXw1qqF47Cw4xW3ya9a1kXry5GryrWwn5Ar1jvr929F18KryDCF9xXrW5t34r
	Zr1qvrn5G3yxZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j45lbUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQtXFWqzlqs3QQAA3a

From: Yuan Chen <chenyuan@kylinos.cn>

Extend tc_bpf2bpf with two freplace links, one on entry_tc and one on
subprog_tc, and detach the one on the entry: while subprog_tc is still
extended, updating entry_tc into a prog_array map must keep failing
with -EBUSY, and succeed again once the last link detaches.  The test
asserts the rejection instead of running the prog, as the update
succeeds and the prog loops unbounded on an unfixed kernel.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 74 +++++++++++++++++++
 .../bpf/progs/tailcall_freplace_multi.c       | 27 +++++++
 2 files changed, 101 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index c5c9d6c359bb..aefb46778307 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -6,6 +6,7 @@
 #include "tailcall_bpf2bpf_hierarchy2.skel.h"
 #include "tailcall_bpf2bpf_hierarchy3.skel.h"
 #include "tailcall_freplace.skel.h"
+#include "tailcall_freplace_multi.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
 #include "tailcall_cgrp_storage_owner.skel.h"
@@ -1655,6 +1656,77 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+static void test_tailcall_freplace_multi(void)
+{
+	struct tailcall_freplace_multi *freplace_skel = NULL;
+	struct bpf_link *link_subprog = NULL, *link_entry = NULL;
+	struct tc_bpf2bpf *tc_skel = NULL;
+	int tc_prog_fd, map_fd, key = 0, err;
+
+	tc_skel = tc_bpf2bpf__open_and_load();
+	if (!ASSERT_OK_PTR(tc_skel, "tc_bpf2bpf__open_and_load"))
+		return;
+
+	tc_prog_fd = bpf_program__fd(tc_skel->progs.entry_tc);
+
+	freplace_skel = tailcall_freplace_multi__open();
+	if (!ASSERT_OK_PTR(freplace_skel, "tailcall_freplace_multi__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.subprog_freplace,
+					     tc_prog_fd, "subprog_tc");
+	if (!ASSERT_OK(err, "set_attach_target subprog_tc"))
+		goto out;
+
+	err = bpf_program__set_attach_target(freplace_skel->progs.entry_freplace,
+					     tc_prog_fd, "entry_tc");
+	if (!ASSERT_OK(err, "set_attach_target entry_tc"))
+		goto out;
+
+	err = tailcall_freplace_multi__load(freplace_skel);
+	if (!ASSERT_OK(err, "tailcall_freplace_multi__load"))
+		goto out;
+
+	map_fd = bpf_map__fd(freplace_skel->maps.jmp_table);
+
+	link_subprog = bpf_program__attach_freplace(freplace_skel->progs.subprog_freplace,
+						    tc_prog_fd, "subprog_tc");
+	if (!ASSERT_OK_PTR(link_subprog, "attach_freplace subprog_tc"))
+		goto out;
+
+	link_entry = bpf_program__attach_freplace(freplace_skel->progs.entry_freplace,
+						  tc_prog_fd, "entry_tc");
+	if (!ASSERT_OK_PTR(link_entry, "attach_freplace entry_tc"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &key, &tc_prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "update jmp_table with extended prog"))
+		goto out;
+
+	err = bpf_link__destroy(link_entry);
+	link_entry = NULL;
+	if (!ASSERT_OK(err, "destroy entry link"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &key, &tc_prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "update jmp_table with still extended prog"))
+		goto out;
+
+	err = bpf_link__destroy(link_subprog);
+	link_subprog = NULL;
+	if (!ASSERT_OK(err, "destroy subprog link"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, &key, &tc_prog_fd, BPF_ANY);
+	ASSERT_OK(err, "update jmp_table");
+
+out:
+	bpf_link__destroy(link_subprog);
+	bpf_link__destroy(link_entry);
+	tailcall_freplace_multi__destroy(freplace_skel);
+	tc_bpf2bpf__destroy(tc_skel);
+}
+
 static void test_tailcall_failure()
 {
 	RUN_TESTS(tailcall_fail);
@@ -2005,6 +2077,8 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_freplace_multi"))
+		test_tailcall_freplace_multi();
 	if (test__start_subtest("tailcall_failure"))
 		test_tailcall_failure();
 	if (test__start_subtest("tailcall_sleepable"))
diff --git a/tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c b/tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c
new file mode 100644
index 000000000000..ca764411dc0b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("freplace")
+int subprog_freplace(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+SEC("freplace")
+int entry_freplace(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.54.0

