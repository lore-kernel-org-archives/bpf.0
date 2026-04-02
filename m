Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360E3A168F;
	Thu,  2 Apr 2026 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115799; cv=none; b=AXBdulP0KhguW/OvQzhCQcksmGVwWae2ZTmm0sNvcL8vNEQ8nzhYmVQGYJxLNZ6QH8C8ed7IoVDEXYC96cAcwSumRunjzaaFwWh5zAtU6UHQki4DmbFBfllTllmeVkSjCNibi8cNMnwzsBEv4AcXoegVMu8F8nfio+zwlN0s47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115799; c=relaxed/simple;
	bh=BJ99MVIqEdzCoFSg/CR/0bqGKH2QaRwlKyFfRc3a3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmQRffB/ZLxYCwQqtDtZbMBoUMzfovLD9W7BcVel98PDa2/VGi6eIHuWqMPDiK73pUtiL9MXm5cLvpvv6O9Cj8QfFhXIyGs/QLGzTCZE12e/DfAnO+CQB//E9N+eI4lCi0Gp0dDrL1OasRuFtzFJ7pPeSPq+5daRyMs5IYvlbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BO9s/Sc/; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BO9s/Sc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775115770;
	bh=qgI3FT0GBDBMWaM8gWjFF/AzJorzgi4+AANeSjdMKTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BO9s/Sc/oZLgR4OqIqTX1/aK603qVdus+SuSuwiaLXpmY3TGV/4kJWrOZPvvM1QUy
	 sWboqRBn0j9jcnBrj4RImKpWter3dYEG9appUQdOAsLToszRuj7sAF9zzgEQSol1fZ
	 mRPdZgWZfvyeCgWq/UTvDCXkcJGRxgY48W+OMZ0k=
X-QQ-mid: zesmtpip2t1775115763tbf7cae39
X-QQ-Originating-IP: 6gOvkrQZdHhClCIbnisXZ/zxkWc77Mfl8XMTljFSPTA=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:42:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8165112614966405982
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
	yonghong.song@linux.dev,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v5 2/2] selftests/bpf: Add test for cgroup storage OOB read
Date: Thu,  2 Apr 2026 15:42:36 +0800
Message-ID: <D63BF0DBFF1EA122+20260402074236.2187154-2-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OSNvDVUIgTHK7x0IMcmXmr988azSb9kSPvrpG2lDRBL/slxBLGofdqLp
	cIrZANWeSp+bCn8odDqIocc5v1QT8fPYSm6bVT5GSe0ql+2/VB+JLAwuRc6n39P1PcQf95F
	Nnkv/CjJnUccH4p39j6JAxTdjOP3o2WO6w6L8WdNjjelHjz1+AGIv/gC/TQCL/EY7Q6TZcb
	qM3NzMQtrjiddRDmw90GH7sa+z8kC7hrNHPRUkIJM6xtg1qZ9Jv40y7N/pmthqkX9kW4tZj
	wEAtr0Qni+TaHcmSUfuZwBKSvveVc7lSkJJBcxH6LrVYJjt50Hy5rKkLnXBFbVQVHV9Bawn
	P4eQ6KTnw5MNwgG6V5hioMwym97qApC1ZFyEUBWiw9Tx4S8tWsCo+F7gFPJREKsUFLKNgV5
	bKyN6wNKBYIJPcHteO59b9ywKFZvGBb7tsMY7O05LT/J3lcIA+q27Shk8swM2ORDCJUtmFM
	txBosKOkvWfKRgHWeOWgn5sQkkuH9dECM7KGDG+Unl4zbKLHmKblm+/jjgBbbouFjHQUXFi
	eXP8Ix/8zhvFXYQvCez+NEdkJJUCXOXcm+fmCfl2nm111e9PMVYGgA/qrCXJaXvBWT/IU0J
	dSTdlmcfV0GCtk/PCPc0JnR/aKapO1XT1KC9xRxZmsur6A6DiUBytDQHla8iIIgfFDGWjoc
	TSl1/mGli7hJfwlsxzTw2W5SutK5MBOlxiALCoPAo4MoDrm9CChBS8nXHIIAkCTKD358c4b
	wVJRRK7gz7m+1mu2er3dlONseTtFg3eeKT+PkkUrTSQkP0wMmwEcRfrOjgzge/U2en0UjKI
	worfS0vqIdXErYq4F0hYdDNDowoEQhWTr7khYzOQFYLQmv3fpG/csYg9uTXqNN93wHuQlsQ
	2G0ks22TiTBAKSjm5Loyks3Uw2exgrh/Vlk3hJohbM6dq1BMr3pnrwTQSMnflammgRylyOD
	V2IiWVnr2CWf+vKJA0tuMlII747pQbHAEkwmuCrccLfcsv8jzZQ7aiUqsXH1E2rbysq4AuU
	3r2GWi75oBZ2PwbvSazDQr0M9yh+nO/bFz5OBc00F/5ca4iSP+tQN9WY5hCbGmjXO7IAlyc
	SB5IeyBR6wRbzrHP19OI3LKKhwa5aXRqGo3QT0vNR9A09epK2/0ykCuXiiwAeSjI9Me339K
	SPIv
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

Add a test case to reproduce the out-of-bounds read issue when copying
from a cgroup storage map to a pcpu map with a value_size not rounded
up to 8 bytes.

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

