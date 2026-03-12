Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E53033F5
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345033; cv=none; b=FqwwYp+7y/b9AeTYLjSJidQtdvKvNjseMzNuGR5RU7gnKlcDp1hfp3Eyqa7lOQbh7hnUPFxzJP/yzy1py2/xZFj9Gzafo/raIW7xsCxGd7BrDjrw9yzAD/AIPKetM4qJQZ4eATj8FYbWVTClo7uZrg0YNNoyrVeuavv0DL8vGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345033; c=relaxed/simple;
	bh=FcwenqK1fe4/K0H3WQPxL+lhp+S/nQYzHDtfKRlLGuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLdJycWkN+keC5KoI4CYXcjRMSx9X5QAQIoO4n4rw+yLn9BKj/ZOtNIYOs/mYPgRtOvxkP5Vnw6q3u7uNyPxOihSwYSw0aI5rMJd/H8Z9SSqY6oUJXw5lXyuaG0jgdzNfFu7Mv27+hTEoC8I5JLfJ8SVnPA3r1fRJz+x8K/a8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9p5Vi4s; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9p5Vi4s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773345029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=so2GoLhlCa/idEeBKsUtyqs7+YdigcjbXWXVtfFa+jc=;
	b=J9p5Vi4sBPJjrNnbYL/TvG/u7zVmE97FMsd/8eROjqrYwutfD/hsNSdg5Xt8N7s2KDEHf3
	eZyh3RCLxYdIsskpvY5YC3P8MPL0jaGzy6b8kDyVfZYKBuG8qsujYBzVrHZBoAB9Lf4CfY
	sA4mOquRfjZ2gWosJpvzsADYyGCAb+w=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1] selftests/bpf: Bump path and command buffer sizes in bpftool_helpers.c
Date: Thu, 12 Mar 2026 12:50:17 -0700
Message-ID: <20260312195017.210430-1-ihor.solodrai@linux.dev>
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
 tools/testing/selftests/bpf/bpftool_helpers.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index 929fc257f431..6a5e99b5e542 100644
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
+	snprintf(tmp, PATH_MAX, "./%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
 		strscpy(buffer, tmp, size);
 		return 0;
@@ -38,7 +38,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
 	/* Check alternate bpftool location (will work if we are running a
 	 * specific flavor of test_progs, e.g. cpuv4 or no_alu32)
 	 */
-	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
+	snprintf(tmp, PATH_MAX, "../%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
 		strscpy(buffer, tmp, size);
 		return 0;
@@ -50,7 +50,7 @@ static int detect_bpftool_path(char *buffer, size_t size)
 
 static int run_command(char *args, char *output_buf, size_t output_max_len)
 {
-	static char bpftool_path[BPFTOOL_PATH_MAX_LEN] = {0};
+	static char bpftool_path[PATH_MAX] = {0};
 	bool suppress_output = !(output_buf && output_max_len);
 	char command[BPFTOOL_FULL_CMD_MAX_LEN];
 	FILE *f;
@@ -84,4 +84,3 @@ int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_l
 {
 	return run_command(args, output_buf, output_max_len);
 }
-
-- 
2.53.0

