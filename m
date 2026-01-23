Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E222E62DC;
	Fri, 23 Jan 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157038; cv=none; b=ov6sRTODIgtAoBU1mxzi3Pw4iAg3dqic5ly6T5hr2oMa/rzmazM8QVbTEL9gdueiwK5jNk0W6N1p4ij84y/j/18112nloqefO6K0X0oN3I3rjSGs3Ybcz7OwWBjZYDz8Q2nHiSstFjJseklkmbqIQ277nSvmDkpCERxMO2sBMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157038; c=relaxed/simple;
	bh=gDp24hQBkfuRljYs/tKLF/LrU5I4JCP6iuariKKfYXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9lqQ/w57naxgzYtWHUjctEAaOQMEz541lz5ZVWLc7MhxKtBvXOFYJkqjc2+U2KwDw8BiaJpAWtQLLZeJVPmM7ii4r6UlWom1wbCfmpDaTnEVqsWhVyKRMFZxW8wOm8Cke1/EyDTB2HTZ3poRDkG/vXIOMQX2eWBYR4iChsRZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b+IpG7Z0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b+IpG7Z0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1F7CBC21ABD;
	Fri, 23 Jan 2026 08:30:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB8AE6070A;
	Fri, 23 Jan 2026 08:30:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7107119A8790;
	Fri, 23 Jan 2026 09:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769157029; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2Oo3a1R4lC2ZRgioFr1OQLi8lwVUDpK7gcpsSofgGOY=;
	b=b+IpG7Z0z/xVWg1y9SkhBPaQFIN+w27jRcwUHyG5JSGAIv8+2UEOLBcT22CWzCn0Ezm2ki
	CB+c/TaUGEWcjhNGNSL+g6P0rIc/8rzA5MqlnQaiPCmXcM5yGoYGSfey1odcT3J4nBRwMS
	JfjH550iw5Mnf2mrSEB7MZXkYVl01spolUUQvOQ9yI3WUSM6DEJvRbGldX80cryGrEv1DY
	l9qhTEk0rdvLYFq4BoprHRYEzKGCMO5h4dnkKUYMm3YpTaSHRX22LdExHHWGUtGNoedNbK
	DymGl4m7CjRv/GKPM9I7pWVtj6X58LkStmSkjPkZ33IvBh5yKOuPgfMVU3cpiw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 23 Jan 2026 09:30:10 +0100
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: convert
 test_bpftool_map_access.sh into test_progs framework
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260123-bpftool-tests-v4-3-a6653a7f28e7@bootlin.com>
References: <20260123-bpftool-tests-v4-0-a6653a7f28e7@bootlin.com>
In-Reply-To: <20260123-bpftool-tests-v4-0-a6653a7f28e7@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The test_bpftool_map.sh script tests that maps read/write accesses
are being properly allowed/refused by the kernel depending on a specific
fmod_ret program being attached on security_bpf_map function.

Rewrite this test to integrate it in the test_progs. The
new test spawns a few subtests:

  #36/1    bpftool_maps_access/unprotected_unpinned:OK
  #36/2    bpftool_maps_access/unprotected_pinned:OK
  #36/3    bpftool_maps_access/protected_unpinned:OK
  #36/4    bpftool_maps_access/protected_pinned:OK
  #36/5    bpftool_maps_access/nested_maps:OK
  #36/6    bpftool_maps_access/btf_list:OK
  #36      bpftool_maps_access:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Acked-by: Quentin Monnet <qmo@kernel.org>

---
Changes in v2:
- move the new test in prog_tests directory
- collect Quentin's AB
---
 tools/testing/selftests/bpf/Makefile               |   1 -
 .../selftests/bpf/prog_tests/bpftool_maps_access.c | 371 +++++++++++++++++++
 tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------------
 3 files changed, 371 insertions(+), 399 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1bb7db1ed6ea..2c2f68a171ed 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -108,7 +108,6 @@ TEST_PROGS := test_kmod.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
 	test_bpftool.sh \
-	test_bpftool_map.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
 	test_xdp_features.sh
diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c b/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c
new file mode 100644
index 000000000000..e0eb869cb1b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_maps_access.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/stat.h>
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/libbpf.h>
+#include <bpftool_helpers.h>
+#include <test_progs.h>
+#include <bpf/bpf.h>
+#include "security_bpf_map.skel.h"
+
+#define PROTECTED_MAP_NAME	"prot_map"
+#define UNPROTECTED_MAP_NAME	"not_prot_map"
+#define BPF_ITER_FILE		"bpf_iter_map_elem.bpf.o"
+#define BPFFS_PIN_DIR		"/sys/fs/bpf/test_bpftool_map"
+#define INNER_MAP_NAME		"inner_map_tt"
+#define OUTER_MAP_NAME		"outer_map_tt"
+
+#define MAP_NAME_MAX_LEN	64
+#define PATH_MAX_LEN		128
+
+enum map_protection {
+	PROTECTED,
+	UNPROTECTED
+};
+
+struct test_desc {
+	char *name;
+	enum map_protection protection;
+	struct bpf_map *map;
+	char *map_name;
+	bool pinned;
+	char pin_path[PATH_MAX_LEN];
+	bool write_must_fail;
+};
+
+static struct security_bpf_map *general_setup(void)
+{
+	struct security_bpf_map *skel;
+	uint32_t key, value;
+	int ret, i;
+
+	skel = security_bpf_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
+		goto end;
+
+	struct bpf_map *maps[] = {skel->maps.prot_map, skel->maps.not_prot_map};
+
+	ret = security_bpf_map__attach(skel);
+	if (!ASSERT_OK(ret, "attach maps security programs"))
+		goto end_destroy;
+
+	for (i = 0; i < sizeof(maps)/sizeof(struct bpf_map *); i++) {
+		for (key = 0; key < 2; key++) {
+			int ret = bpf_map__update_elem(maps[i], &key,
+					sizeof(key), &key, sizeof(key),
+					0);
+			if (!ASSERT_OK(ret, "set initial map value"))
+				goto end_destroy;
+		}
+	}
+
+	key = 0;
+	value = 1;
+	ret = bpf_map__update_elem(skel->maps.prot_status_map, &key,
+			sizeof(key), &value, sizeof(value), 0);
+	if (!ASSERT_OK(ret, "configure map protection"))
+		goto end_destroy;
+
+	if (!ASSERT_OK(mkdir(BPFFS_PIN_DIR, S_IFDIR), "create bpffs pin dir"))
+		goto end_destroy;
+
+	return skel;
+end_destroy:
+	security_bpf_map__destroy(skel);
+end:
+	return NULL;
+}
+
+static void general_cleanup(struct security_bpf_map *skel)
+{
+	rmdir(BPFFS_PIN_DIR);
+	security_bpf_map__destroy(skel);
+}
+
+static void update_test_desc(struct security_bpf_map *skel,
+			      struct test_desc *test)
+{
+	/* Now that the skeleton is loaded, update all missing fields to
+	 * have the subtest properly configured
+	 */
+	if (test->protection == PROTECTED) {
+		test->map = skel->maps.prot_map;
+		test->map_name = PROTECTED_MAP_NAME;
+	} else {
+		test->map = skel->maps.not_prot_map;
+		test->map_name = UNPROTECTED_MAP_NAME;
+	}
+}
+
+static int test_setup(struct security_bpf_map *skel, struct test_desc *desc)
+{
+	int ret;
+
+	update_test_desc(skel, desc);
+
+	if (desc->pinned) {
+		ret = snprintf(desc->pin_path, PATH_MAX_LEN, "%s/%s", BPFFS_PIN_DIR,
+				desc->name);
+		if (!ASSERT_GT(ret, 0, "format pin path"))
+			return 1;
+		ret = bpf_map__pin(desc->map, desc->pin_path);
+		if (!ASSERT_OK(ret, "pin map"))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void test_cleanup(struct test_desc *desc)
+{
+	if (desc->pinned)
+		bpf_map__unpin(desc->map, NULL);
+}
+
+static int lookup_map_value(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "map lookup %s key 0 0 0 0",
+			map_handle);
+	if (!ASSERT_GT(ret, 0, "format map lookup cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int read_map_btf_data(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "btf dump map %s",
+			map_handle);
+	if (!ASSERT_GT(ret, 0, "format map btf dump cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int write_map_value(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN,
+		       "map update %s key 0 0 0 0 value 1 1 1 1", map_handle);
+	if (!ASSERT_GT(ret, 0, "format value write cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int delete_map_value(char *map_handle)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN,
+		       "map delete %s key 0 0 0 0", map_handle);
+	if (!ASSERT_GT(ret, 0, "format value deletion cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int iterate_on_map_values(char *map_handle, char *iter_pin_path)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+
+	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "iter pin %s %s map %s",
+		       BPF_ITER_FILE, iter_pin_path, map_handle);
+	if (!ASSERT_GT(ret, 0, "format iterator creation cmd"))
+		return 1;
+	ret = run_bpftool_command(cmd);
+	if (ret)
+		return ret;
+	ret = snprintf(cmd, MAP_NAME_MAX_LEN, "cat %s", iter_pin_path);
+	if (ret < 0)
+		goto cleanup;
+	ret = system(cmd);
+
+cleanup:
+	unlink(iter_pin_path);
+	return ret;
+}
+
+static int create_inner_map(void)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(
+		cmd, MAX_BPFTOOL_CMD_LEN,
+		"map create %s/%s type array key 4 value 4 entries 4 name %s",
+		BPFFS_PIN_DIR, INNER_MAP_NAME, INNER_MAP_NAME);
+	if (!ASSERT_GT(ret, 0, "format inner map create cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static int create_outer_map(void)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(
+		cmd, MAX_BPFTOOL_CMD_LEN,
+		"map create %s/%s type hash_of_maps key 4 value 4 entries 2 name %s inner_map name %s",
+		BPFFS_PIN_DIR, OUTER_MAP_NAME, OUTER_MAP_NAME, INNER_MAP_NAME);
+	if (!ASSERT_GT(ret, 0, "format outer map create cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static void delete_pinned_map(char *map_name)
+{
+	char pin_path[PATH_MAX_LEN];
+	int ret;
+
+	ret = snprintf(pin_path, PATH_MAX_LEN, "%s/%s", BPFFS_PIN_DIR,
+		       map_name);
+	if (ret >= 0)
+		unlink(pin_path);
+}
+
+static int add_outer_map_entry(int key)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN];
+	int ret = 0;
+
+	ret = snprintf(
+		cmd, MAX_BPFTOOL_CMD_LEN,
+		"map update pinned %s/%s key %d 0 0 0 value name %s",
+		BPFFS_PIN_DIR, OUTER_MAP_NAME, key, INNER_MAP_NAME);
+	if (!ASSERT_GT(ret, 0, "format outer map value addition cmd"))
+		return 1;
+	return run_bpftool_command(cmd);
+}
+
+static void test_basic_access(struct test_desc *desc)
+{
+	char map_handle[MAP_NAME_MAX_LEN];
+	char iter_pin_path[PATH_MAX_LEN];
+	int ret;
+
+	if (desc->pinned)
+		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "pinned %s",
+			       desc->pin_path);
+	else
+		ret = snprintf(map_handle, MAP_NAME_MAX_LEN, "name %s",
+			       desc->map_name);
+	if (!ASSERT_GT(ret, 0, "format map handle"))
+		return;
+
+	ret = lookup_map_value(map_handle);
+	ASSERT_OK(ret, "read map value");
+
+	ret = read_map_btf_data(map_handle);
+	ASSERT_OK(ret, "read map btf data");
+
+	ret = write_map_value(map_handle);
+	ASSERT_OK(desc->write_must_fail ? !ret : ret, "write map value");
+
+	ret = delete_map_value(map_handle);
+	ASSERT_OK(desc->write_must_fail ? !ret : ret, "delete map value");
+	/* Restore deleted value */
+	if (!ret)
+		write_map_value(map_handle);
+
+	ret = snprintf(iter_pin_path, PATH_MAX_LEN, "%s/iter", BPFFS_PIN_DIR);
+	if (ASSERT_GT(ret, 0, "format iter pin path")) {
+		ret = iterate_on_map_values(map_handle, iter_pin_path);
+		ASSERT_OK(ret, "iterate on map values");
+	}
+}
+
+static void test_create_nested_maps(void)
+{
+	if (!ASSERT_OK(create_inner_map(), "create inner map"))
+		return;
+	if (!ASSERT_OK(create_outer_map(), "create outer map"))
+		goto end_cleanup_inner;
+	ASSERT_OK(add_outer_map_entry(0), "add a first entry in outer map");
+	ASSERT_OK(add_outer_map_entry(1), "add a second entry in outer map");
+	ASSERT_NEQ(add_outer_map_entry(2), 0, "add a third entry in outer map");
+
+	delete_pinned_map(OUTER_MAP_NAME);
+end_cleanup_inner:
+	delete_pinned_map(INNER_MAP_NAME);
+}
+
+static void test_btf_list(void)
+{
+	ASSERT_OK(run_bpftool_command("btf list"), "list btf data");
+}
+
+static struct test_desc tests[] = {
+	{
+		.name = "unprotected_unpinned",
+		.protection = UNPROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = false,
+		.write_must_fail = false,
+	},
+	{
+		.name = "unprotected_pinned",
+		.protection = UNPROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = true,
+		.write_must_fail = false,
+	},
+	{
+		.name = "protected_unpinned",
+		.protection = PROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = false,
+		.write_must_fail = true,
+	},
+	{
+		.name = "protected_pinned",
+		.protection = PROTECTED,
+		.map_name = UNPROTECTED_MAP_NAME,
+		.pinned = true,
+		.write_must_fail = true,
+	}
+};
+
+static const size_t tests_count = ARRAY_SIZE(tests);
+
+void test_bpftool_maps_access(void)
+{
+	struct security_bpf_map *skel;
+	struct test_desc *current;
+	int i;
+
+	skel = general_setup();
+	if (!ASSERT_OK_PTR(skel, "prepare programs"))
+		goto cleanup;
+
+	for (i = 0; i < tests_count; i++) {
+		current = &tests[i];
+		if (!test__start_subtest(current->name))
+			continue;
+		if (ASSERT_OK(test_setup(skel, current), "subtest setup")) {
+			test_basic_access(current);
+			test_cleanup(current);
+		}
+	}
+	if (test__start_subtest("nested_maps"))
+		test_create_nested_maps();
+	if (test__start_subtest("btf_list"))
+		test_btf_list();
+
+cleanup:
+	general_cleanup(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/test_bpftool_map.sh b/tools/testing/selftests/bpf/test_bpftool_map.sh
deleted file mode 100755
index 515b1df0501e..000000000000
--- a/tools/testing/selftests/bpf/test_bpftool_map.sh
+++ /dev/null
@@ -1,398 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-TESTNAME="bpftool_map"
-BPF_FILE="security_bpf_map.bpf.o"
-BPF_ITER_FILE="bpf_iter_map_elem.bpf.o"
-PROTECTED_MAP_NAME="prot_map"
-NOT_PROTECTED_MAP_NAME="not_prot_map"
-BPF_FS_TMP_PARENT="/tmp"
-BPF_FS_PARENT=$(awk '$3 == "bpf" {print $2; exit}' /proc/mounts)
-BPF_FS_PARENT=${BPF_FS_PARENT:-$BPF_FS_TMP_PARENT}
-# bpftool will mount bpf file system under BPF_DIR if it is not mounted
-# under BPF_FS_PARENT.
-BPF_DIR="$BPF_FS_PARENT/test_$TESTNAME"
-SCRIPT_DIR=$(dirname $(realpath "$0"))
-BPF_FILE_PATH="$SCRIPT_DIR/$BPF_FILE"
-BPF_ITER_FILE_PATH="$SCRIPT_DIR/$BPF_ITER_FILE"
-BPFTOOL_PATH="bpftool"
-# Assume the script is located under tools/testing/selftests/bpf/
-KDIR_ROOT_DIR=$(realpath "$SCRIPT_DIR"/../../../../)
-
-_cleanup()
-{
-	set +eu
-
-	# If BPF_DIR is a mount point this will not remove the mount point itself.
-	[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2> /dev/null
-
-	# Unmount if BPF filesystem was temporarily created.
-	if [ "$BPF_FS_PARENT" = "$BPF_FS_TMP_PARENT" ]; then
-		# A loop and recursive unmount are required as bpftool might
-		# create multiple mounts. For example, a bind mount of the directory
-		# to itself. The bind mount is created to change mount propagation
-		# flags on an actual mount point.
-		max_attempts=3
-		attempt=0
-		while mountpoint -q "$BPF_DIR" && [ $attempt -lt $max_attempts ]; do
-			umount -R "$BPF_DIR" 2>/dev/null
-			attempt=$((attempt+1))
-		done
-
-		# The directory still exists. Remove it now.
-		[ -d "$BPF_DIR" ] && rm -rf "$BPF_DIR" 2>/dev/null
-	fi
-}
-
-cleanup_skip()
-{
-	echo "selftests: $TESTNAME [SKIP]"
-	_cleanup
-
-	exit $ksft_skip
-}
-
-cleanup()
-{
-	if [ "$?" = 0 ]; then
-		echo "selftests: $TESTNAME [PASS]"
-	else
-		echo "selftests: $TESTNAME [FAILED]"
-	fi
-	_cleanup
-}
-
-check_root_privileges() {
-	if [ $(id -u) -ne 0 ]; then
-		echo "Need root privileges"
-		exit $ksft_skip
-	fi
-}
-
-# Function to verify bpftool path.
-# Parameters:
-#   $1: bpftool path
-verify_bpftool_path() {
-	local bpftool_path="$1"
-	if ! "$bpftool_path" version > /dev/null 2>&1; then
-		echo "Could not run test without bpftool"
-		exit $ksft_skip
-	fi
-}
-
-# Function to verify BTF support.
-# The test requires BTF support for fmod_ret programs.
-verify_btf_support() {
-	if [ ! -f /sys/kernel/btf/vmlinux ]; then
-		echo "Could not run test without BTF support"
-		exit $ksft_skip
-	fi
-}
-
-# Function to initialize map entries with keys [0..2] and values set to 0.
-# Parameters:
-#  $1: Map name
-#  $2: bpftool path
-initialize_map_entries() {
-	local map_name="$1"
-	local bpftool_path="$2"
-
-	for key in 0 1 2; do
-		"$bpftool_path" map update name "$map_name" key $key 0 0 0 value 0 0 0 $key
-	done
-}
-
-# Test read access to the map.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key
-access_for_read() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key="$4"
-
-	# Test read access to the map.
-	if ! "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
-		echo " Read access to $key in $map_name failed"
-		exit 1
-	fi
-
-	# Test read access to map's BTF data.
-	if ! "$bpftool_path" btf dump map "$name_cmd" "$map_name" 1>/dev/null; then
-		echo " Read access to $map_name for BTF data failed"
-		exit 1
-	fi
-}
-
-# Test write access to the map.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key
-#   $5: Whether write should succeed (true/false)
-access_for_write() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key="$4"
-	local write_should_succeed="$5"
-	local value="1 1 1 1"
-
-	if "$bpftool_path" map update "$name_cmd" "$map_name" key $key value \
-			$value 2>/dev/null; then
-		if [ "$write_should_succeed" = "false" ]; then
-			echo " Write access to $key in $map_name succeeded but should have failed"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Write access to $key in $map_name failed but should have succeeded"
-			exit 1
-		fi
-	fi
-}
-
-# Test entry deletion for the map.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key
-#   $5: Whether write should succeed (true/false)
-access_for_deletion() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key="$4"
-	local write_should_succeed="$5"
-	local value="1 1 1 1"
-
-	# Test deletion by key for the map.
-	# Before deleting, check the key exists.
-	if ! "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
-		echo " Key $key does not exist in $map_name"
-		exit 1
-	fi
-
-	# Delete by key.
-	if "$bpftool_path" map delete "$name_cmd" "$map_name" key $key 2>/dev/null; then
-		if [ "$write_should_succeed" = "false" ]; then
-			echo " Deletion for $key in $map_name succeeded but should have failed"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Deletion for $key in $map_name failed but should have succeeded"
-			exit 1
-		fi
-	fi
-
-	# After deleting, check the entry existence according to the expected status.
-	if "$bpftool_path" map lookup "$name_cmd" "$map_name" key $key 1>/dev/null; then
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Key $key for $map_name was not deleted but should have been deleted"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "false" ]; then
-			echo "Key $key for $map_name was deleted but should have not been deleted"
-			exit 1
-		fi
-	fi
-
-	# Test creation of map's deleted entry, if deletion was successful.
-	# Otherwise, the entry exists.
-	if "$bpftool_path" map update "$name_cmd" "$map_name" key $key value \
-				$value 2>/dev/null; then
-		if [ "$write_should_succeed" = "false" ]; then
-			echo " Write access to $key in $map_name succeeded after deletion attempt but should have failed"
-			exit 1
-		fi
-	else
-		if [ "$write_should_succeed" = "true" ]; then
-			echo " Write access to $key in $map_name failed after deletion attempt but should have succeeded"
-			exit 1
-		fi
-	fi
-}
-
-# Test map elements iterator.
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: BPF_DIR
-#   $5: bpf iterator object file path
-iterate_map_elem() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local bpf_dir="$4"
-	local bpf_file="$5"
-	local pin_path="$bpf_dir/map_iterator"
-
-	"$bpftool_path" iter pin "$bpf_file" "$pin_path" map "$name_cmd" "$map_name"
-	if [ ! -f "$pin_path" ]; then
-		echo " Failed to pin iterator to $pin_path"
-		exit 1
-	fi
-
-	cat "$pin_path" 1>/dev/null
-	rm "$pin_path" 2>/dev/null
-}
-
-# Function to test map access with configurable write expectations
-# Parameters:
-#   $1: Name command (name/pinned)
-#   $2: Map name
-#   $3: bpftool path
-#   $4: key for rw
-#   $5: key to delete
-#   $6: Whether write should succeed (true/false)
-#   $7: BPF_DIR
-#   $8: bpf iterator object file path
-access_map() {
-	local name_cmd="$1"
-	local map_name="$2"
-	local bpftool_path="$3"
-	local key_for_rw="$4"
-	local key_to_del="$5"
-	local write_should_succeed="$6"
-	local bpf_dir="$7"
-	local bpf_iter_file_path="$8"
-
-	access_for_read "$name_cmd" "$map_name" "$bpftool_path" "$key_for_rw"
-	access_for_write "$name_cmd" "$map_name" "$bpftool_path" "$key_for_rw" \
-		"$write_should_succeed"
-	access_for_deletion "$name_cmd" "$map_name" "$bpftool_path" "$key_to_del" \
-		"$write_should_succeed"
-	iterate_map_elem "$name_cmd" "$map_name" "$bpftool_path" "$bpf_dir" \
-		"$bpf_iter_file_path"
-}
-
-# Function to test map access with configurable write expectations
-# Parameters:
-#   $1: Map name
-#   $2: bpftool path
-#   $3: BPF_DIR
-#   $4: Whether write should succeed (true/false)
-#   $5: bpf iterator object file path
-test_map_access() {
-	local map_name="$1"
-	local bpftool_path="$2"
-	local bpf_dir="$3"
-	local pin_path="$bpf_dir/${map_name}_pinned"
-	local write_should_succeed="$4"
-	local bpf_iter_file_path="$5"
-
-	# Test access to the map by name.
-	access_map "name" "$map_name" "$bpftool_path" "0 0 0 0" "1 0 0 0" \
-		"$write_should_succeed" "$bpf_dir" "$bpf_iter_file_path"
-
-	# Pin the map to the BPF filesystem
-	"$bpftool_path" map pin name "$map_name" "$pin_path"
-	if [ ! -e "$pin_path" ]; then
-		echo " Failed to pin $map_name"
-		exit 1
-	fi
-
-	# Test access to the pinned map.
-	access_map "pinned" "$pin_path" "$bpftool_path" "0 0 0 0" "2 0 0 0" \
-		"$write_should_succeed" "$bpf_dir" "$bpf_iter_file_path"
-}
-
-# Function to test map creation and map-of-maps
-# Parameters:
-#   $1: bpftool path
-#   $2: BPF_DIR
-test_map_creation_and_map_of_maps() {
-	local bpftool_path="$1"
-	local bpf_dir="$2"
-	local outer_map_name="outer_map_tt"
-	local inner_map_name="inner_map_tt"
-
-	"$bpftool_path" map create "$bpf_dir/$inner_map_name" type array key 4 \
-		value 4 entries 4 name "$inner_map_name"
-	if [ ! -f "$bpf_dir/$inner_map_name" ]; then
-		echo " Failed to create inner map file at $bpf_dir/$outer_map_name"
-		return 1
-	fi
-
-	"$bpftool_path" map create "$bpf_dir/$outer_map_name" type hash_of_maps \
-		key 4 value 4 entries 2 name "$outer_map_name" inner_map name "$inner_map_name"
-	if [ ! -f "$bpf_dir/$outer_map_name" ]; then
-		echo " Failed to create outer map file at $bpf_dir/$outer_map_name"
-		return 1
-	fi
-
-	# Add entries to the outer map by name and by pinned path.
-	"$bpftool_path" map update pinned "$bpf_dir/$outer_map_name" key 0 0 0 0 \
-		value pinned "$bpf_dir/$inner_map_name"
-	"$bpftool_path" map update name "$outer_map_name" key 1 0 0 0 value \
-		name "$inner_map_name"
-
-	# The outer map should be full by now.
-	# The following map update command is expected to fail.
-	if "$bpftool_path" map update name "$outer_map_name" key 2 0 0 0 value name \
-		"$inner_map_name" 2>/dev/null; then
-		echo " Update for $outer_map_name succeeded but should have failed"
-		exit 1
-	fi
-}
-
-# Function to test map access with the btf list command
-# Parameters:
-#   $1: bpftool path
-test_map_access_with_btf_list() {
-	local bpftool_path="$1"
-
-	# The btf list command iterates over maps for
-	# loaded BPF programs.
-	if ! "$bpftool_path" btf list 1>/dev/null; then
-		echo " Failed to access btf data"
-		exit 1
-	fi
-}
-
-set -eu
-
-trap cleanup_skip EXIT
-
-check_root_privileges
-
-verify_bpftool_path "$BPFTOOL_PATH"
-
-verify_btf_support
-
-trap cleanup EXIT
-
-# Load and attach the BPF programs to control maps access.
-"$BPFTOOL_PATH" prog loadall "$BPF_FILE_PATH" "$BPF_DIR" autoattach
-
-initialize_map_entries "$PROTECTED_MAP_NAME" "$BPFTOOL_PATH"
-initialize_map_entries "$NOT_PROTECTED_MAP_NAME" "$BPFTOOL_PATH"
-
-# Activate the map protection mechanism. Protection status is controlled
-# by a value stored in the prot_status_map at index 0.
-"$BPFTOOL_PATH" map update name prot_status_map key 0 0 0 0 value 1 0 0 0
-
-# Test protected map (write should fail).
-test_map_access "$PROTECTED_MAP_NAME" "$BPFTOOL_PATH" "$BPF_DIR" "false" \
- "$BPF_ITER_FILE_PATH"
-
-# Test not protected map (write should succeed).
-test_map_access "$NOT_PROTECTED_MAP_NAME" "$BPFTOOL_PATH" "$BPF_DIR" "true" \
- "$BPF_ITER_FILE_PATH"
-
-test_map_creation_and_map_of_maps "$BPFTOOL_PATH" "$BPF_DIR"
-
-test_map_access_with_btf_list "$BPFTOOL_PATH"
-
-exit 0

-- 
2.52.0

