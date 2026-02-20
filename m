Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B313959D
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611644; cv=none; b=Tvi4x4nREXTKyIA4Amj+zNpKzxeweMOHnqlOr2TxhcTQFxa162W+OuDz4CGTrsBw1gvCrNPqRAdO2ALXcKEv8VfQZIgPa6RAmHn1dYJqaK6wFuMfgwhgVxsPtxJO1Q1pSmCy+zmlJZFiMBKQpzJ6JiDw6e7hnWqYXgIhdp8jfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611644; c=relaxed/simple;
	bh=0movS6g8APFRjZGKZxVGfx4aQ9pQCEmIriIwrf/tT1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnIHsctwVsXbFnZS/jw+RCq65X2dSCjVk76GQWPvMWTwXrYdF24JWN2SY6jXzc1yscunfNimcK5BoYLf61/ceFrFEowLpjf8HvDa53P4sZ41DioSMPhlNUWWA0/XZidcla2uks0yVESVXbqtFujAc8o25ulSgfy3NSoMcO/u+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OIPISkkZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OIPISkkZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCpZCnCQl1G+f+btfDm78pmpn5ENUAINv/Yhi6LMNhQ=;
	b=OIPISkkZdjhjaEEOBCxu3AyLwlH0mo/IA/m44DTQN2sdvp0fjZIznUcDsvJ5q5FeVQR3Dk
	lRsT58XHdkv4/TzeEm7Nq+51gA0Lj2zQjhOmJPOEGpDNWmulJZBz4crdEnZRGzKJJOnxxy
	pllVSu6U3ogk6+/efm/neJAr9Akx6H8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 6/7] selftests/bpf: Use strscpy in bpftool_helpers.c
Date: Fri, 20 Feb 2026 10:20:10 -0800
Message-ID: <20260220182011.802116-7-ihor.solodrai@linux.dev>
In-Reply-To: <20260220182011.802116-1-ihor.solodrai@linux.dev>
References: <20260220182011.802116-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace strncpy() and snprintf() calls in bpftool_helpers.c with
strscpy() and strscpy_cat() respectively.

Pass the destination buffer size to detect_bpftool_path() instead of
hardcoding BPFTOOL_PATH_MAX_LEN.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index a5824945a4a5..c99776b03f52 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -1,33 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include "bpftool_helpers.h"
 #include <unistd.h>
 #include <string.h>
 #include <stdbool.h>
 
+#include "bpf_util.h"
+#include "bpftool_helpers.h"
+
 #define BPFTOOL_PATH_MAX_LEN		64
 #define BPFTOOL_FULL_CMD_MAX_LEN	512
 
 #define BPFTOOL_DEFAULT_PATH		"tools/sbin/bpftool"
 
-static int detect_bpftool_path(char *buffer)
+static int detect_bpftool_path(char *buffer, size_t size)
 {
 	char tmp[BPFTOOL_PATH_MAX_LEN];
 
 	/* Check default bpftool location (will work if we are running the
 	 * default flavor of test_progs)
 	 */
-	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
+	strscpy_cat(tmp, sizeof(tmp), "./", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		strscpy(buffer, tmp, size);
 		return 0;
 	}
 
 	/* Check alternate bpftool location (will work if we are running a
 	 * specific flavor of test_progs, e.g. cpuv4 or no_alu32)
 	 */
-	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
+	strscpy_cat(tmp, sizeof(tmp), "../", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		strscpy(buffer, tmp, size);
 		return 0;
 	}
 
@@ -44,7 +46,7 @@ static int run_command(char *args, char *output_buf, size_t output_max_len)
 	int ret;
 
 	/* Detect and cache bpftool binary location */
-	if (bpftool_path[0] == 0 && detect_bpftool_path(bpftool_path))
+	if (bpftool_path[0] == 0 && detect_bpftool_path(bpftool_path, sizeof(bpftool_path)))
 		return 1;
 
 	ret = snprintf(command, BPFTOOL_FULL_CMD_MAX_LEN, "%s %s%s",
-- 
2.53.0

