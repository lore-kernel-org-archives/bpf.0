Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3F31E82E;
	Thu,  2 Apr 2026 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111518; cv=none; b=BocFKRQF/EZREHzuLbVrB57wuZO7JuuHs9nz15QSJEMNGWWcjPISv4vENd0bJrfEUb1IYPHsN58F3NWB0evZTdfM3rXBFp4sg1Bw5hl80BH2WTdAWIchEupsymME2vEc2M0O+LZM2iNLZxdovSnC737LZdWXjlPwpZ4C3lsjvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111518; c=relaxed/simple;
	bh=vr98BifwCZR7ddPRugqbqnMKsjEEt47aZ8P/B5wnW4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pj194ya+TmdyAb950qTtMplcy0AuovQiDgveJBlMo4OD3wc+r/DcIMBaZLE1G01ZDT0qx1g1VgYr+/Rh5c9ZuL5y+IAxGVzNPOcr/iBPiNk85V4Gyz8RPDQeswhbSm4/alk06IR5IUGvkg4ynjDxgSZtvZWoylBdcSlOZJLPq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=glZd+aIc; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="glZd+aIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775111491;
	bh=3aGRFJphaUxd0Jn9c3ZHF1I5KiJsDbSpxhypActK2ow=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=glZd+aIceOMfIfy3O1rS2FVCR38xAvq/XNYiNkfb4N8VoSTYGeZfzCqMU2xICJ6DB
	 90yjbTAZRJTA05B69NFdIaHA+cXJHTBaAUhMfn/ODMP6BSfAtEX1nKO9ntikSLEyYP
	 3Y64EQVqkv5B4JjlYUVKRhEigW1LCuLiaNmLPYUE=
X-QQ-mid: zesmtpip3t1775111483t81fe87b9
X-QQ-Originating-IP: ujWLZzS029oV0y5qdr1WJ7vpgvVaHNTKp+G+weG+d5o=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 14:31:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9901766237094982486
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
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add test for cgroup storage OOB read
Date: Thu,  2 Apr 2026 14:31:16 +0800
Message-ID: <1D11C4C149BCD888+20260402063116.2012398-2-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5CD977BE2CEFCF6F+20260402062621.2008939-1-xulang@uniontech.com>
References: <5CD977BE2CEFCF6F+20260402062621.2008939-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N2f7f/zo94Yu0d6+zRXywR92gZafKYnePpiLRcNUY/hoAK1WZTyLVuYQ
	oPpkp8BoEO/jp9uIrOB+u1tqkxpkEt5YwuVPz8e2Y3b1kf8cDH+x8u3DCdvaJW5G9FwVBt+
	z62cI13axeaqdxXabGJUoqz+ARncek9q14K1gDorxFyLq+q0WI04M52iZrcW/Bw37K3xQ7M
	22gv9/JyY8U0UQe6RdSL1n9REz9LiQ/CBuxzcjTO+UQuKffnYpunV6tkvjEOsC64eOaPApX
	2hCWuj9NiIrCy1jBpG9/NjtZrZyVqcH9gwJ+13STkse2JyfYBj6DcP1d00rGmK97BcgxyLB
	bHTas7Eo6SRUCRRceJiOBgpUgVBIfibmzqHPwKJfRBlSfqaWPysN1RP+crU6Ezhb11BcOP1
	qFTDBSawmW4jSISqyN2Kw6ATSltrBT0ZNZ0bvwTGJRRIoczH5+8RiKfDTei34WR3prQ6QEJ
	ClZtOp0oEhetg5aGjCUnysMUVvnWS85lLnJhs9RO5lOZx9M0ceNBThMcEuoDXI/47Npote8
	lvoSJZhJ7H66CtH8HTBLlhT+ehM2FIndRCisUBGZ5dEqvJmRk5iSAA3f5VR5q6Yg0p1Bn28
	BqsNMdjp8KPH7HvPgF+JLJ8R6E9ghbVHEQGEkTvRqNsnJ9yu5FEsA1bgClDYf9UDFjKhd/E
	4Jid+MyRZ3hdyZ+y2iF9qErPOsCLQzEL9liOUhd1X1GwYVZMg2g5BSKtTZqGqFl2AitUoJJ
	UDsw7U0RlTkaq89hlzwQkPe8y/AYUOceX01Sb4jQsPRxFMam4VNX//cRAU2BQl9IngBbSmL
	0TATnFdQ/U5vEyyCmM4Yt5ro9SJXXJNBrctz6WfCAUl1fyFN7IyC9GTQpmEae042e6oV2pI
	nmRNifGSRv1WnyDD+/x7nSZKBbeHL9jnzPFeQTUJ0o1vEZ8FmIff7hK2yPKwyMhd4FJdaUe
	FmE/Qftkpv1MweyvMUipEK8Qo98tdyO1Xa66vmpj0H1O/Vmy2L89nAf+pMtu6pp+HtAtDvT
	+wsBCCNCEo49v4QzVdyG8FR08HLK1qdw1c7eR1uD6uag3HwZzekiOE+gDxakqtQt9LTGxRZ
	QxeY+OWldo3+iLIFV7TqK+3T/dNVQpcZqUHvQsepLZutqVVEPssclAeNBaP96Sg9g5kdxd3
	bc8e6Am2y0iPjUU=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

