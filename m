Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96682BD033
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374716; cv=none; b=KZ5OpdVr+gcYLBR6MCPhodpxZePJUsyR9PdH6mx2XEh/2XIsr38lBoGANgemrO+L2beAaFVU1zLVlw91/eIMSW2/rC6TBKQgKbN/dgGQgmjJHY9nv95BM2mL96UVhRdSH6nIj1zH1Yjfe+FdpaM8W05pI0xzdX2hXCu3sUQJIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374716; c=relaxed/simple;
	bh=smjiuInwcCQtLC8OWZ39uExnF3V6vhwhl8sv6ftERP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AItq8P9IBcyL/8uVlWznnJBaBGMdkfpI14md+M0M7Zzrdfa8M+M8wqYmk2rKJPpU97mSCSWHN5xhhwyO0NawfMuHxfP7GdXtLrK2rQ3nJTIWJnwQ7XlxaSPHsnLfvKs1y5OytI5VUu3iqKonPyln4sHQ8JpD2Ig1X0StJYUdtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pu619S5W; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pu619S5W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771374714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8X6kehvt+PWy9aq2ekWX663KglL6Yjb8cBvRGjnXqvY=;
	b=pu619S5WX3NM3T0xS73RfoIK99R/V9Yfzcqlnj2dvV9xfiVH/g7qj6PKYakO6QxKzFM554
	owJW9ihqt8pEpQNk01ky9GQHL323zs6szUcmkhFWKRF+e+HGi4HuMcp97LF2nPbQPg4pTQ
	fIHCFmb/5faJwH+S6Ek9sxZJ19RgCZ8=
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
Subject: [PATCH bpf v2 14/15] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
Date: Tue, 17 Feb 2026 16:30:40 -0800
Message-ID: <20260218003041.1156774-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bpftool_maps_access and bpftool_metadata tests may fail on BPF CI
with "command not found", depending on a workflow.
This happens because detect_bpftool_path() only checks two hardcoded
relative paths:
  - ./tools/sbin/bpftool
  - ../tools/sbin/bpftool

Add support for a BPFTOOL environment variable that allows specifying
the exact path to the bpftool binary.

Also replace strncpy() with snprintf() for proper null-termination.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/bpftool_helpers.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
index a5824945a4a5..d810e73da6c8 100644
--- a/tools/testing/selftests/bpf/bpftool_helpers.c
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "bpftool_helpers.h"
+#include <stdio.h>
 #include <unistd.h>
 #include <string.h>
 #include <stdbool.h>
@@ -12,13 +13,24 @@
 static int detect_bpftool_path(char *buffer)
 {
 	char tmp[BPFTOOL_PATH_MAX_LEN];
+	const char *env_path;
+
+	/* First, check if BPFTOOL environment variable is set */
+	env_path = getenv("BPFTOOL");
+	if (env_path && access(env_path, X_OK) == 0) {
+		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", env_path);
+		return 0;
+	} else if (env_path) {
+		fprintf(stderr, "bpftool '%s' doesn't exist or is not executable\n", env_path);
+		return 1;
+	}
 
 	/* Check default bpftool location (will work if we are running the
 	 * default flavor of test_progs)
 	 */
 	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
 		return 0;
 	}
 
@@ -27,11 +39,11 @@ static int detect_bpftool_path(char *buffer)
 	 */
 	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
 	if (access(tmp, X_OK) == 0) {
-		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
 		return 0;
 	}
 
-	/* Failed to find bpftool binary */
+	fprintf(stderr, "Failed to detect bpftool path, use BPFTOOL env var to override\n");
 	return 1;
 }
 
@@ -71,4 +83,3 @@ int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_l
 {
 	return run_command(args, output_buf, output_max_len);
 }
-
-- 
2.53.0

