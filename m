Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F75408254
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359317; cv=none; b=diKCJPc38VVpSil2U3dHytz6DicTtSO3hKl9aCHfM+D6MMaENiGy5Viw1WLd8vdlvfOUzIL8BY3YSUi7riqiR+JlDDXYq1kFkolHDmoK+MksV47iuXZYxzmPgoMUkFQLKscnA4t1UaVddgbupph1xdCmLtOWHXAzMRZ8YzFN8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359317; c=relaxed/simple;
	bh=W8Bd5oOh7MSEjkdrvK8qvAERcEfQxBWSesqhUyPZLIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWx+mMQgAm3D/oZejcqLXeAENS4+Kiv0YmSH5UTCq8tqBMShkGDYnpn1Q4Y7GxVwGSAXLsYMSxCZKhLGEnj7ecmJTorew68E3LuCg1Zc1h4zDiDQtrkrF/0wiCbRiY79B/ZdKovkFgNXRQtaK6oNtRfa95qRgaaoA0v48tKEZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qqts5DIo; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qqts5DIo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773359313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MeWN31fg3miuhcowYMCs4k5ZaJg35aFgNm2XxKtrdiA=;
	b=Qqts5DIofesK9H4b8rc1EmZG0bCZ+9zkHCmzvyesF0GgyPryHSFsstPOPdwSQ5lE3inpQt
	nBFftiwaiLXjmzqq6ZIO3HfCxx8RiLoc8Q45yS5P9tIqz46b7A2t7mkDdlDDv0Ck++Wt6x
	csIYUM62aU1/bh5TFlOWOe9HYonucg0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2] selftests/bpf: Bump path and command buffer sizes in bpftool_helpers.c
Date: Thu, 12 Mar 2026 16:48:20 -0700
Message-ID: <20260312234820.439720-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The path length of 64 is way too low in some envirnoments, which leads
to subtle failures due to truncation [1].

Replace BPFTOOL_PATH_MAX_LEN with PATH_MAX, and set
BPFTOOL_FULL_CMD_MAX_LEN to double of PATH_MAX.

[1] https://github.com/libbpf/libbpf/actions/runs/22980753016/job/66719800527

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index 929fc257f431..0a2a4f0a2794 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -2,18 +2,18 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdbool.h>
+#include <limits.h>
 
 #include "bpf_util.h"
 #include "bpftool_helpers.h"
 
-#define BPFTOOL_PATH_MAX_LEN		64
-#define BPFTOOL_FULL_CMD_MAX_LEN	512
+#define BPFTOOL_FULL_CMD_MAX_LEN	(PATH_MAX * 2)
 
 #define BPFTOOL_DEFAULT_PATH		"tools/sbin/bpftool"
 
 static int detect_bpftool_path(char *buffer, size_t size)
 {
-	char tmp[BPFTOOL_PATH_MAX_LEN];
+	char tmp[PATH_MAX];
 	const char *env_path;
 
 	/* First, check if BPFTOOL environment variable is set */
@@ -29,7 +29,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
 	/* Check default bpftool location (will work if we are running the
 	 * default flavor of test_progs)
 	 */
-	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
+	snprintf(tmp, sizeof(tmp), "./%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
 		strscpy(buffer, tmp, size);
 		return 0;
@@ -38,7 +38,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
 	/* Check alternate bpftool location (will work if we are running a
 	 * specific flavor of test_progs, e.g. cpuv4 or no_alu32)
 	 */
-	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
+	snprintf(tmp, sizeof(tmp), "../%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
 		strscpy(buffer, tmp, size);
 		return 0;
@@ -50,7 +50,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
 
 static int run_command(char *args, char *output_buf, size_t output_max_len)
 {
-	static char bpftool_path[BPFTOOL_PATH_MAX_LEN] = {0};
+	static char bpftool_path[PATH_MAX] = {};
 	bool suppress_output = !(output_buf && output_max_len);
 	char command[BPFTOOL_FULL_CMD_MAX_LEN];
 	FILE *f;
@@ -60,7 +60,7 @@ static int run_command(char *args, char *output_buf, size_t output_max_len)
 	if (bpftool_path[0] == 0 && detect_bpftool_path(bpftool_path, sizeof(bpftool_path)))
 		return 1;
 
-	ret = snprintf(command, BPFTOOL_FULL_CMD_MAX_LEN, "%s %s%s",
+	ret = snprintf(command, sizeof(command), "%s %s%s",
 		       bpftool_path, args,
 		       suppress_output ? " > /dev/null 2>&1" : "");
 
@@ -84,4 +84,3 @@ int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_l
 {
 	return run_command(args, output_buf, output_max_len);
 }
-
-- 
2.53.0

