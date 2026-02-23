Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4536A03E
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873690; cv=none; b=E13MV6DKhanfyAl+Sq5mZDUQtqdIk2S6clNs1Iqv45kH9jpbOkr31gEXdyi1xObVHY9n2QpZnKSJJ9xPMyKfdC8jSWr2zeX2ZgDpuOj79ELB1mWEb9WO1x01geCAFWvid1Jq03XFYOsPyilvFBx98vmWdQcvU3OChQxfwCGiVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873690; c=relaxed/simple;
	bh=nL9fNv8ceOeOxooMuKNnBuBIiAwCq8vILhKnk7cD+bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCmY6RrpIvt4fDFqdDklUjOzIjpWRfYaf1eLZRQBNy5fm3RKB3J0A9hVDkse3IkT2zkZFRHGd6uWlz05cFhfloRMvNkyKE/3PQNMeFTKFNtfC0SZA2MF1Q6/XPRUN50xuMLBVwB9PHwS3PZIDrY3wugcbwgiWhhsPCzVcsr3idg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLbczP03; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLbczP03"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRmqhruTyQ4dkQ9qQRrgrVBM+JiDjFeye9z/j9b866s=;
	b=CLbczP03wcnNKE5D5XA+WCx5NhaaA+DbaNK/YcsLPpOG6fCm+Lfn5TBGvKwfA6E5lL5rYm
	x18YOHgAmLye9UB5lkPczVB7y4zXw1b9NvbxKBtO5eNx2iWAAxHEYM3jL2bH01KU5kIhJn
	N6k6SFH/FI5cH2gNEXdy7iL9DUsL7b0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v4 04/20] selftests/bpf: Use strscpy in bpftool_helpers.c
Date: Mon, 23 Feb 2026 11:07:20 -0800
Message-ID: <20260223190736.649171-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace strncpy() calls in bpftool_helpers.c with strscpy().

Pass the destination buffer size to detect_bpftool_path() instead of
hardcoding BPFTOOL_PATH_MAX_LEN.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index a5824945a4a5..595a636fa13b 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -1,15 +1,17 @@
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
 
@@ -18,7 +20,7 @@ static int detect_bpftool_path(char *buffer)
 	 */
 	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		strscpy(buffer, tmp, size);
 		return 0;
 	}
 
@@ -27,7 +29,7 @@ static int detect_bpftool_path(char *buffer)
 	 */
 	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
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

