Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBA1D5170;
	Thu, 26 Mar 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541368; cv=none; b=sP/HOppBzMT1NuZCAcsSvHL9hkx/34Mc+eHAyD49+/s78SKUuCEEtx7Jjk1BNZd8KVrgJjaUgwpye84F/JcyAta4Gb4n7xZ57aQyV92bOXnfVFJ81csUPy2U8JTqYWG+3R4d1bkZZZAP5A3K0En9UT+xvhdLXiYymZ56AY3L9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541368; c=relaxed/simple;
	bh=elsbhCKTjyHQOR/R1/g4VdpZRWj7+gyGM6TKxJrlKVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjesQp8PhGv6x7qOHu6lV7WWLMCyTW0lOfdNSBXcLYf3f2zLbIKI6JcwRkCKFRds+Xvk9ta6dCCcS9wYbs6B2ERs07Bm3GTJOtkoapLJ7KI+G9l1zvl9988COrmmjVlkW0Z77VqzXFUkVareYAFlPa8HUNtNx+clNHzSn0vFLWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGy5wR0x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGy5wR0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3735C19423;
	Thu, 26 Mar 2026 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541367;
	bh=elsbhCKTjyHQOR/R1/g4VdpZRWj7+gyGM6TKxJrlKVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DGy5wR0xoaaTRCvhlyWJjU9hGNmHtEJj/R7hy0EdbhTs2kIV9GF7uQr89KyiBsYsz
	 9MQ//BxZcQBPwQjM546oChfbnAd0quu9h+Gqs/+3ajkrVQveSFlu8aW4T6o5vFi4yh
	 HMRCgelAnxk9WQ/0l+cAYxZeWB8HTSTLDWNvzJ2JSQlQ3bccmsZi1wYaqTknnm0QfU
	 opAUGY0LLl7LpcizTLwR91CurLPXpnSieWZM7JS2Dz6a58DOY+bzP/19NtjDuwoPdJ
	 u1KHkB4u8P1Qz6TD7hZW1a+G7RoVqovrCdVLqB6JMUJV3TQtCQz38b6pCjpbJX35Sl
	 1CvjaG0uf4uJA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Mar 2026 17:09:15 +0100
Subject: [PATCH RESEND v2 2/2] selftests/bpf: add block device management
 selftests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-work-bpf-bdev-v2-2-5e3c58963987@kernel.org>
References: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
In-Reply-To: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=elsbhCKTjyHQOR/R1/g4VdpZRWj7+gyGM6TKxJrlKVU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQejdI/fCL0bfqbOgUe96K3eyf93+Q9ybWF5WpX7eIvW
 1VX3Taf1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRe68YGc6XxP3lFODh/fc+
 mS+/iD0xbmn7Kn+3UypCYn9PWGoc+MbIMLswZc+ZF+G2tfbvk0+sz5e7GMrO9vjAWbVzZ56mLev
 Q5AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add selftests to test block device tracking for bpf lsm programs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 221 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm_bdev.c      |  96 ++++++++++
 2 files changed, 317 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
new file mode 100644
index 000000000000..a970798e1173
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+
+/*
+ * Test BPF LSM block device integrity hooks with dm-verity.
+ *
+ * Creates a dm-verity device over loopback, which triggers
+ * security_bdev_setintegrity() during verity_preresume().
+ * Verifies that the BPF program correctly tracks the integrity
+ * metadata in its hashmap.
+ */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include "lsm_bdev.skel.h"
+
+/* Must match the definition in progs/lsm_bdev.c. */
+struct verity_info {
+	__u8  has_roothash;
+	__u8  sig_valid;
+	__u32 setintegrity_cnt;
+};
+
+#define DATA_SIZE_MB	8
+#define HASH_SIZE_MB	1
+#define DM_NAME		"bpf_test_verity"
+#define DM_DEV_PATH	"/dev/mapper/" DM_NAME
+
+/* Run a command and optionally capture the first line of stdout. */
+static int run_cmd(const char *cmd, char *out, size_t out_sz)
+{
+	FILE *fp;
+	int ret;
+
+	fp = popen(cmd, "r");
+	if (!fp)
+		return -1;
+
+	if (out && out_sz > 0) {
+		if (!fgets(out, out_sz, fp))
+			out[0] = '\0';
+		/* strip trailing newline */
+		out[strcspn(out, "\n")] = '\0';
+	}
+
+	ret = pclose(fp);
+	return WIFEXITED(ret) ? WEXITSTATUS(ret) : -1;
+}
+
+static bool has_prerequisites(void)
+{
+	if (getuid() != 0) {
+		printf("SKIP: must be root\n");
+		return false;
+	}
+
+	if (run_cmd("modprobe loop 2>/dev/null", NULL, 0) &&
+	    run_cmd("ls /dev/loop-control 2>/dev/null", NULL, 0)) {
+		printf("SKIP: no loop device support\n");
+		return false;
+	}
+
+	if (run_cmd("modprobe dm-verity 2>/dev/null", NULL, 0) &&
+	    run_cmd("dmsetup targets 2>/dev/null | grep -q verity", NULL, 0)) {
+		printf("SKIP: dm-verity module not available\n");
+		return false;
+	}
+
+	if (run_cmd("which veritysetup >/dev/null 2>&1", NULL, 0)) {
+		printf("SKIP: veritysetup not found\n");
+		return false;
+	}
+
+	return true;
+}
+
+void test_lsm_bdev(void)
+{
+	char data_img[] = "/tmp/bpf_verity_data_XXXXXX";
+	char hash_img[] = "/tmp/bpf_verity_hash_XXXXXX";
+	char data_loop[64] = {};
+	char hash_loop[64] = {};
+	char roothash[256] = {};
+	char cmd[512];
+	int data_fd = -1, hash_fd = -1;
+	struct lsm_bdev *skel = NULL;
+	struct verity_info val;
+	struct stat st;
+	__u32 dev_key;
+	int err;
+
+	if (!has_prerequisites()) {
+		test__skip();
+		return;
+	}
+
+	/* Clean up any stale device from a previous crashed run. */
+	snprintf(cmd, sizeof(cmd), "dmsetup remove %s 2>/dev/null", DM_NAME);
+	run_cmd(cmd, NULL, 0);
+
+	/* Create temporary image files. */
+	data_fd = mkstemp(data_img);
+	if (!ASSERT_OK_FD(data_fd, "mkstemp data"))
+		return;
+
+	hash_fd = mkstemp(hash_img);
+	if (!ASSERT_OK_FD(hash_fd, "mkstemp hash"))
+		goto cleanup;
+
+	if (!ASSERT_OK(ftruncate(data_fd, DATA_SIZE_MB * 1024 * 1024),
+		       "truncate data"))
+		goto cleanup;
+
+	if (!ASSERT_OK(ftruncate(hash_fd, HASH_SIZE_MB * 1024 * 1024),
+		       "truncate hash"))
+		goto cleanup;
+
+	close(data_fd);
+	data_fd = -1;
+	close(hash_fd);
+	hash_fd = -1;
+
+	/* Set up loop devices. */
+	snprintf(cmd, sizeof(cmd),
+		 "losetup --find --show %s 2>/dev/null", data_img);
+	if (!ASSERT_OK(run_cmd(cmd, data_loop, sizeof(data_loop)),
+		       "losetup data"))
+		goto teardown;
+
+	snprintf(cmd, sizeof(cmd),
+		 "losetup --find --show %s 2>/dev/null", hash_img);
+	if (!ASSERT_OK(run_cmd(cmd, hash_loop, sizeof(hash_loop)),
+		       "losetup hash"))
+		goto teardown;
+
+	/* Format the dm-verity device and capture the root hash. */
+	snprintf(cmd, sizeof(cmd),
+		 "veritysetup format %s %s 2>/dev/null | "
+		 "grep -i 'root hash' | awk '{print $NF}'",
+		 data_loop, hash_loop);
+	if (!ASSERT_OK(run_cmd(cmd, roothash, sizeof(roothash)),
+		       "veritysetup format"))
+		goto teardown;
+
+	if (!ASSERT_GT((int)strlen(roothash), 0, "roothash not empty"))
+		goto teardown;
+
+	/* Load and attach BPF program before activating dm-verity. */
+	skel = lsm_bdev__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		goto teardown;
+
+	err = lsm_bdev__attach(skel);
+	if (!ASSERT_OK(err, "skel attach"))
+		goto teardown;
+
+	/* Activate dm-verity — triggers verity_preresume() hooks. */
+	snprintf(cmd, sizeof(cmd),
+		 "veritysetup open %s %s %s %s 2>/dev/null",
+		 data_loop, DM_NAME, hash_loop, roothash);
+	if (!ASSERT_OK(run_cmd(cmd, NULL, 0), "veritysetup open"))
+		goto teardown;
+
+	/* Get the dm device's dev_t. */
+	if (!ASSERT_OK(stat(DM_DEV_PATH, &st), "stat dm dev"))
+		goto remove_dm;
+
+	dev_key = (__u32)st.st_rdev;
+
+	/* Look up the device in the BPF map and verify. */
+	err = bpf_map__lookup_elem(skel->maps.verity_devices,
+				   &dev_key, sizeof(dev_key),
+				   &val, sizeof(val), 0);
+	if (!ASSERT_OK(err, "map lookup"))
+		goto remove_dm;
+
+	ASSERT_EQ(val.has_roothash, 1, "has_roothash");
+	ASSERT_EQ(val.sig_valid, 0, "sig_valid (unsigned)");
+	/*
+	 * verity_preresume() always calls security_bdev_setintegrity()
+	 * for the roothash. The signature-validity call only happens
+	 * when CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is enabled.
+	 */
+	ASSERT_GE(val.setintegrity_cnt, 1, "setintegrity_cnt min");
+	ASSERT_LE(val.setintegrity_cnt, 2, "setintegrity_cnt max");
+
+	/* Verify that the alloc hook fired at least once. */
+	ASSERT_GT(skel->bss->alloc_count, 0, "alloc_count");
+
+remove_dm:
+	snprintf(cmd, sizeof(cmd), "dmsetup remove %s 2>/dev/null", DM_NAME);
+	run_cmd(cmd, NULL, 0);
+
+teardown:
+	if (data_loop[0]) {
+		snprintf(cmd, sizeof(cmd), "losetup -d %s 2>/dev/null",
+			 data_loop);
+		run_cmd(cmd, NULL, 0);
+	}
+	if (hash_loop[0]) {
+		snprintf(cmd, sizeof(cmd), "losetup -d %s 2>/dev/null",
+			 hash_loop);
+		run_cmd(cmd, NULL, 0);
+	}
+
+cleanup:
+	lsm_bdev__destroy(skel);
+	if (data_fd >= 0)
+		close(data_fd);
+	if (hash_fd >= 0)
+		close(hash_fd);
+	unlink(data_img);
+	unlink(hash_img);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_bdev.c b/tools/testing/selftests/bpf/progs/lsm_bdev.c
new file mode 100644
index 000000000000..45554e6db605
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_bdev.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+
+/*
+ * BPF LSM block device integrity tracker for dm-verity.
+ *
+ * Tracks block devices in a hashmap keyed by bd_dev.  When dm-verity
+ * calls security_bdev_setintegrity() during verity_preresume(), the
+ * setintegrity hook records the roothash and signature-validity data.
+ * The free hook cleans up when the device goes away.  The alloc hook
+ * counts allocations for test validation.
+ *
+ * The sleepable hooks exercise bpf_copy_from_user() to verify that
+ * the sleepable classification actually permits sleepable helpers.
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct verity_info {
+	__u8  has_roothash;	/* LSM_INT_DMVERITY_ROOTHASH seen */
+	__u8  sig_valid;	/* LSM_INT_DMVERITY_SIG_VALID value (non-NULL = valid) */
+	__u32 setintegrity_cnt;	/* total setintegrity calls for this dev */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 64);
+	__type(key, __u32);		/* dev_t from bdev->bd_dev */
+	__type(value, struct verity_info);
+} verity_devices SEC(".maps");
+
+/* Global counters exposed to userspace via skeleton bss. */
+int alloc_count;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm.s/bdev_setintegrity")
+int BPF_PROG(bdev_setintegrity, struct block_device *bdev,
+	     enum lsm_integrity_type type, const void *value, size_t size)
+{
+	struct verity_info zero = {};
+	struct verity_info *info;
+	__u32 dev;
+	char buf;
+
+	/*
+	 * Exercise a sleepable helper to confirm the verifier
+	 * allows it in this sleepable hook.
+	 */
+	(void)bpf_copy_from_user(&buf, sizeof(buf), NULL);
+
+	dev = bdev->bd_dev;
+
+	info = bpf_map_lookup_elem(&verity_devices, &dev);
+	if (!info) {
+		bpf_map_update_elem(&verity_devices, &dev, &zero, BPF_NOEXIST);
+		info = bpf_map_lookup_elem(&verity_devices, &dev);
+		if (!info)
+			return 0;
+	}
+
+	if (type == LSM_INT_DMVERITY_ROOTHASH)
+		info->has_roothash = 1;
+	else if (type == LSM_INT_DMVERITY_SIG_VALID)
+		info->sig_valid = (value != NULL);
+
+	__sync_fetch_and_add(&info->setintegrity_cnt, 1);
+
+	return 0;
+}
+
+SEC("lsm/bdev_free_security")
+void BPF_PROG(bdev_free_security, struct block_device *bdev)
+{
+	__u32 dev = bdev->bd_dev;
+
+	bpf_map_delete_elem(&verity_devices, &dev);
+}
+
+SEC("lsm.s/bdev_alloc_security")
+int BPF_PROG(bdev_alloc_security, struct block_device *bdev)
+{
+	char buf;
+
+	/*
+	 * Exercise a sleepable helper to confirm the verifier
+	 * allows it in this sleepable hook.
+	 */
+	(void)bpf_copy_from_user(&buf, sizeof(buf), NULL);
+
+	__sync_fetch_and_add(&alloc_count, 1);
+
+	return 0;
+}

-- 
2.47.3

