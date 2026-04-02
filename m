Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277033191BB;
	Thu,  2 Apr 2026 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109853; cv=none; b=STAujPE4AmDAQuEHaVQe5iBAR2pkky72rRSPc9GgSF7wnCKOtR3beS4aeTHG/sduSmUH3dI1UgnJb6vXZVkurbtoy3UAdfZWZDxHh+gmS7nfhp8NIHAVEuRnvGx8qemBAKcd6zzuSIX08pczP8I29if3XSx3ts4g0u34j9dUQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109853; c=relaxed/simple;
	bh=vr98BifwCZR7ddPRugqbqnMKsjEEt47aZ8P/B5wnW4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDBM6XAVcqJMMfqZY4CFb7WwJsfIoac2FPW5mdVlr7mMACZCBRD7CdemybIuysWLjQr+oEyI2OIUmGgUu0y7pBSF8A44ohtV7TtACSAQE2jW7cD8c7HM+BMYLFaZtSo/B/6DxEAJDa+Ex5CftdPMM9qPo8JXhGopXx3rMLG/HN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cf1NmFq6; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cf1NmFq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775109821;
	bh=3aGRFJphaUxd0Jn9c3ZHF1I5KiJsDbSpxhypActK2ow=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cf1NmFq6yUjTiMmIgBVGUICGROTGFyu/tpK0DwHJrO/lxlimmBsirbGsAGyL/NdLG
	 UUTMU0TUApanbE2+Ngo+9/1UaMPePbH4MnFO3ne1QHw6rhaMhDqfuyb/TkOCRQDvFO
	 Wer+sepPW10yymdUHBDr1VNgm4WDNOKAuKgXKQzk=
X-QQ-mid: zesmtpip3t1775109815t2a2f4c98
X-QQ-Originating-IP: 5VQu7i5lJBIvGpkFvQZjcyCQ0Bwq4HoTj9GxTdi6wIg=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 14:03:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15171942429747109532
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test for cgroup storage OOB read
Date: Thu,  2 Apr 2026 14:03:23 +0800
Message-ID: <A9CDD4FD062FBDCD+20260402060323.1995132-3-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402060323.1995132-1-xulang@uniontech.com>
References: <20260402060323.1995132-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nfza43amelPGrH7cQlN+qASgAPqRII/nAQ/mIiPpJjGc2Puvu2FGj6Xu
	X/AUopsxCS1NGrfyGA6/+hs5Xv15GHnbrOVgBi69eOt+f81L4gZdaUlCFXLC8EtTCIzo1UO
	2+KJv08O8W1aTFb/f0M7oqNcKIeavYr6KaNfnR6zAIhLO0Q6d27nIqK3rgpIX/LE2y2TR3K
	S8d390vSSf16lMZW31uVdDCqb4CewHS/jUoUL9VEhHK6DbGj7RPi8ECcQjnvCLBo3dQETA2
	3QKpuniULQbU3DLf7S8wcV0B8pf+xmYU2xENE8Y6vn3mh6vNL1u9TIRAlxM3v3QN2gkaB9x
	qzp9+mYDpfMMwx+AV1pFpmSA4lNW3EecBjnMBEH7BAvJ1U00ZWZYobDA4n6EnEaOrjqdV5m
	1b1N/VrqGhDkUgrJAddgNdnctcOyR1mkj2a5YWQypTbElpdQy/44WtD/ZjRq677y5kjBg/o
	N0G/4ea2H+1Fz4pH42KllhNbFD4hsi/De35JLXOo5YWN87Vm13BvX7oqCy7Rqbbg2RiQkda
	9ikKlPhoX6AvtHdcJ+JcnvqJLrYeLVKYFtN7w+WfiiGStygUJ579wc9QE/LaQz/jflddH3/
	Musa6DYMd4HV9N9nTq6sZcO4Dd1klH5vRlhzKKTy2kvfR5srDzO/HvkHwVm7MqDMy3S/owD
	kT9bftWoVvumMeJF/sXLClunAq0k2YF4Ft+w9a060GY9ipDkF7O6qB4Umfc8Hu8C4K3/Tt7
	WgXNwv3v8mZvV/6+3xztmOxQyfpSvgGTSjJuM7JtwEPIa6R+hGsFo4p1v3O5AyfDIty39p0
	iv9aBijM3ah70wwlAKJbtCbk/hx6OPf9gnNhPeJpQkslDJYjIJ96aoqjRuyk76g9dmqW0eD
	0JhJIKuvhqhWAhmiJ/Ix8dY/KwkC3uwuTh9MqXy+I0cFhIqtMZjFgENW5vEBT6j+60DK9+J
	iXh4ZGFTvJctxa7nFTZoxw/6DFy97rkTEWgL+9qiMtOTWfnSMvG3F18fp21Xyw9WnKaTqsh
	UMT+YqLW8KOACLLw9KLnF0e9QBHUhwEYsMUlwJHHJCA3gjmtPwGGh/KLeCe5BUOSiyFAWai
	MmOGKFNjhGhH8b9KZe/JYlR2vZW5nGxCx3pBdpDJRruFx5C+7s9izE=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

