Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F035F166;
	Tue, 17 Mar 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741871; cv=none; b=LoOH+JSRUpAbpxNaLIgx8p2+DzAWkWqUXQGHY+F92pGbgZHkxqTuuYfOl6+EC/ScKDlhb5imvOaTCaZSkIanrT4nQxGZtD7sMZgqIbC41ZqBQ54tTiyGcyKRvc6a0NzG8btbIP9QhpiInKJ7X5K6ZFKIBzc+ncYg+1F/v6xkP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741871; c=relaxed/simple;
	bh=vr98BifwCZR7ddPRugqbqnMKsjEEt47aZ8P/B5wnW4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6hmCsF3yEGaog839WPmiSAF26wiT0onV1sJtqvItu9YmL1zWE74TwqaXFSsdMybPCLG3MPAYO8kcbGvnZDkFma/gAcxatKYs0OmaW4WUpZRp09uPbPy249/gOZ6ENLJnjcdR+b/i5sgNf4O5Pn4UMfMHRTLdOFb33w6+invMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UKBoJsf8; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UKBoJsf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773741826;
	bh=3aGRFJphaUxd0Jn9c3ZHF1I5KiJsDbSpxhypActK2ow=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UKBoJsf8dhiQ66bEuCuHWlN5CEf2IptJP4NoEg6iJvgAYhA8/NaJNhkaZ746M7UN/
	 TDZcKjlF/OBqEvm3Np/StqbXtXyk5knG5+tGN2DGY1SZ+Gwu+cn5PxcLcXmKBr2jTV
	 18MpOxyU3K67ZEbEZ5PwmULoozpiG3BEVt6zj3tk=
X-QQ-mid: zesmtpip3t1773741819t95fa259e
X-QQ-Originating-IP: A6VUEhOu+wrSwHz9/I3cIGC/kHEiAE4LQ5SWmwTqI7g=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Mar 2026 18:03:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9406838548676382481
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	xulang@uniontech.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for cgroup storage OOB read
Date: Tue, 17 Mar 2026 18:02:27 +0800
Message-ID: <1113E44394EEEBC8+20260317100227.2157104-3-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317100227.2157104-1-xulang@uniontech.com>
References: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
 <20260317100227.2157104-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mlf3QM4hU4FNpROpSSPr7UAyqe6yni/v2pCAwSMTUooB7xmoz0xA7rF3
	ZORl6HpOzHz36DTpz6it3stSAbfbBTddpLdu2JK68ysEpbN/YmBaAJ7tJxRzieH6QxGhC5L
	+Me+NXw7BCfUF1JHejEqbCmBOAOJn1ZlGcvrq8a7HXjCiJvPpzlJpLTiokwwjwfe35ABIxv
	vQ/X1NTJ7R+QMS4U2lPizNxVgu04J0AA1ef5YCMY9kSJLVT6Yr0LbIKMcrUh+A2NArFPbvY
	hR2/CTWVAY8O5qw6dnZjr6zxuIXkwRy/BdsN2QsaVlJiGyxB0srxhSuwFgyFV+vO2rJKoro
	Mbj8YuTnr1OSIurktSxIThMKE0Z5ZflvnQO8cTvsGRFRfs5a3hfU/VoN8XyZQ/7qpBT5tsR
	EfRZ4+vzvERX9wO4tqGLaO/L+eQpWovu1puwDRT0l99kO5HHuNwbT7nP94wabWDb+7kEFhk
	uowoD2TFRdYrwjDyD6Qem9D+udxaW/baIcMx4iIAcYaULbzNyFEqTfoAyPYwtu0jLx8C43R
	gFsEML36gMuvICYTesuYkYL0DF7ljSiNmZ/dnXxx1rcSe0x9CBvdmz/X67QCUTaNZaTCrGT
	PArzFf3n5miwxe5MgqB74uGrbkXD985dH7LVHxEkFr4r3SXM0aaNLrNEPdBadUoRqM7X0/v
	9Uh8IBVUqSyboO3iTsNIhHvH2W9QH2ojZEaqGs2/nef83TUgqUkvMlAtzmMX1QsyfhIGdP+
	ULwwtzDStgyd2/EhUa3ezi5lEVYLmmufiUMkcXEKHl2veXCch9ThQFPGkmVTgaKpDvSYVwo
	WsllJ9xhDzWcqCU1jskiXO4TsuZ/jdr/uHg02h2QGVwjD0IbEFdWLi9jWoL1cuHVLZQ7KjH
	XHsCJD4HhoY9lRaKczqP5FsqaYXS0vtTysKjkjviZClGebzWwdS2ZsfMZn1N/cfRQnLyRIT
	P5XvOXs7ls3d44Q/YYrQVWqysaHR6y2LskH32MZW/jco3q5BJp49jSCQo0q6kUlawgn3jsx
	4RCANA6cb97euV8e4rdGl4w/fqfCUt9eo8pboz392PApMFgpXsQe6fYtBKOaI=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

Add a test case to reproduce the out-of-bounds read issue when copying
from cgroup storage maps with unaligned value_size.

The test creates:
1. A CGROUP_STORAGE map with 4-byte value (not 8-byte aligned)
2. A LRU_PERCPU_HASH map with 4-byte value (same size)

When a socket is created in the cgroup, the BPF program triggers
bpf_map_update_elem() which calls copy_map_value_long(). This function
rounds up the copy size to 8 bytes, but the cgroup storage buffer is
only 4 bytes, causing an OOB read (before the fix).

Link: https://lore.kernel.org/all/204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com/
Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 .../selftests/bpf/prog_tests/cgroup_storage.c | 42 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_storage.c      | 43 +++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
index cf395715ced4..5b56dc893e73 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <unistd.h>
+#include <sys/socket.h>
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
@@ -94,3 +96,43 @@ void test_cgroup_storage(void)
 	close(cgroup_fd);
 	cleanup_cgroup_environment();
 }
+
+void test_cgroup_storage_oob(void)
+{
+	struct cgroup_storage *skel;
+	int cgroup_fd, sock_fd;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "create cgroup"))
+		return;
+
+	/* Load and attach BPF program */
+	skel = cgroup_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "cgroup_storage__open_and_load"))
+		goto cleanup_cgroup;
+
+	skel->links.trigger_oob = bpf_program__attach_cgroup(skel->progs.trigger_oob,
+							      cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.trigger_oob, "attach_cgroup"))
+		goto cleanup_skel;
+
+	/* Create a socket to trigger cgroup/sock_create hook.
+	 * This will execute our BPF program and trigger the OOB read
+	 * if the bug is present (before the fix).
+	 */
+	sock_fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (!ASSERT_OK_FD(sock_fd, "create socket"))
+		goto cleanup_skel;
+
+	close(sock_fd);
+
+	/* If we reach here without a kernel panic or KASAN report,
+	 * the test passes (the fix is working).
+	 */
+
+cleanup_skel:
+	cgroup_storage__destroy(skel);
+cleanup_cgroup:
+	close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_storage.c b/tools/testing/selftests/bpf/progs/cgroup_storage.c
index db1e4d2d3281..59da1d95e5b9 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_storage.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_storage.c
@@ -21,4 +21,47 @@ int bpf_prog(struct __sk_buff *skb)
 	return (*counter & 1);
 }
 
+/* Maps for OOB test */
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u32);  /* 4-byte value - not 8-byte aligned */
+} cgroup_storage_oob SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);  /* 4-byte value - same as cgroup storage */
+} lru_map SEC(".maps");
+
+SEC("cgroup/sock_create")
+int trigger_oob(struct bpf_sock *sk)
+{
+	__u32 key = 0;
+	__u32 *cgroup_val;
+	__u32 value = 0x12345678;
+
+	/* Get cgroup storage value */
+	cgroup_val = bpf_get_local_storage(&cgroup_storage_oob, 0);
+	if (!cgroup_val)
+		return 0;
+
+	/* Initialize cgroup storage */
+	*cgroup_val = value;
+
+	/* This triggers the OOB read:
+	 * bpf_map_update_elem() -> htab_map_update_elem() ->
+	 * pcpu_init_value() -> copy_map_value_long() ->
+	 * bpf_obj_memcpy(..., long_memcpy=true) ->
+	 * bpf_long_memcpy(dst, src, round_up(4, 8))
+	 *
+	 * The copy size is rounded up to 8 bytes, but cgroup_val
+	 * points to a 4-byte buffer, causing a 4-byte OOB read.
+	 */
+	bpf_map_update_elem(&lru_map, &key, cgroup_val, BPF_ANY);
+
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0

