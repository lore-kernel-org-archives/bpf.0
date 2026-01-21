Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4753803F0;
	Wed, 21 Jan 2026 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027479; cv=none; b=Or+3y5HlQ4KW6XYLEkvBoVkyRMzK40c+NaaI3CQ+PfG7uVxel1SKD3niKEm7T6MgeGGtrmpuInswSO1wBoVfh69Yei5uCtxdJZDqwSGZZ/S/wttNuj4u9mkWGaripTqUFH0VGCKlvn4w+izVE0Mv3e4TWnl0plYujXEU1bjjZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027479; c=relaxed/simple;
	bh=RqfGGxrSfeCq4Vqwo5xlSFtS4gPAvF1vdV6jpgXqAMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqB1plIz/oVBFkg1lVTVOAP3cQIBDhGy4HrOlYI3DEi2y878wduOUERDKGaD0ULkivLu8J21dwVy6FIRhrppp5t4DEq0u9f/7ArT+ZdUkqYjdBLdiuWKCSEQD7tn0H2G8qXRSYye7BRuaLhREfqXnxEPAgNAu1UIxyiYWbmkM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cNON4J5o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cNON4J5o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0822B4E421D5;
	Wed, 21 Jan 2026 20:31:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D22536070A;
	Wed, 21 Jan 2026 20:31:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36F3A119B1D53;
	Wed, 21 Jan 2026 21:31:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769027473; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CzwlI3vwhCgY6zmoO8Cw8YvGVgDS0E9ppWDsYocPW2Y=;
	b=cNON4J5oqdHyhceESqYjpyiFN62KHiEOeQE/b/u3jl32ohhluYrKl08HL8TwMkypgA1pvV
	inKX7NLULmTB7ojiVfl+asahI+1m0MHolr9dOfK8rTsYbOAiD5SDFAU7lLYgGO+pSn1ezo
	NNLSkLznNCHu7Q3+ooFJw4FL+p+X7JfPJkX6tIGmpAtpYCTbe0o2rsjEU5VJp9ypkpOWoE
	SAx4GWgguoRBz1beFrmH3X9BaqlPGiF7vKGF48TlfPQFGA206p5HcjmkXcGjoYqxMsv3Ih
	YRWAzqwRrIoVrUcxpbZ7XpjNrmFb3yfd1+o+ZrLmaVbzwkLAMb8zCDLqXvwEcA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 21 Jan 2026 21:31:00 +0100
Subject: [PATCH bpf-next v3 1/3] bpf/selftests: add a few helpers for
 bpftool testing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-bpftool-tests-v3-1-368632f377e5@bootlin.com>
References: <20260121-bpftool-tests-v3-0-368632f377e5@bootlin.com>
In-Reply-To: <20260121-bpftool-tests-v3-0-368632f377e5@bootlin.com>
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

In order to integrate some bpftool tests into test_progs, define a few
specific helpers that allow to execute bpftool commands, while possibly
retrieving the command output. Those helpers most notably set the
path to the bpftool binary under test. This version checks different
possible paths relative to the directories where the different
test_progs runners are executed, as we want to make sure not to
accidentally use a bootstrap version of the binary.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- Drop the new runner from commit, keep only the new bpftool-specific
  helpers
- replace hardcoded path with a detected (and cached) path
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 tools/testing/selftests/bpf/bpftool_helpers.c | 74 +++++++++++++++++++++++++++
 tools/testing/selftests/bpf/bpftool_helpers.h | 11 ++++
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9488d076c740..2cc559ecc723 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -747,7 +747,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 json_writer.c 		\
 			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
-			 ip_check_defrag_frags.h
+			 ip_check_defrag_frags.h	\
+			 bpftool_helpers.c
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
new file mode 100644
index 000000000000..a5824945a4a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_helpers.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "bpftool_helpers.h"
+#include <unistd.h>
+#include <string.h>
+#include <stdbool.h>
+
+#define BPFTOOL_PATH_MAX_LEN		64
+#define BPFTOOL_FULL_CMD_MAX_LEN	512
+
+#define BPFTOOL_DEFAULT_PATH		"tools/sbin/bpftool"
+
+static int detect_bpftool_path(char *buffer)
+{
+	char tmp[BPFTOOL_PATH_MAX_LEN];
+
+	/* Check default bpftool location (will work if we are running the
+	 * default flavor of test_progs)
+	 */
+	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH);
+	if (access(tmp, X_OK) == 0) {
+		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		return 0;
+	}
+
+	/* Check alternate bpftool location (will work if we are running a
+	 * specific flavor of test_progs, e.g. cpuv4 or no_alu32)
+	 */
+	snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "../%s", BPFTOOL_DEFAULT_PATH);
+	if (access(tmp, X_OK) == 0) {
+		strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
+		return 0;
+	}
+
+	/* Failed to find bpftool binary */
+	return 1;
+}
+
+static int run_command(char *args, char *output_buf, size_t output_max_len)
+{
+	static char bpftool_path[BPFTOOL_PATH_MAX_LEN] = {0};
+	bool suppress_output = !(output_buf && output_max_len);
+	char command[BPFTOOL_FULL_CMD_MAX_LEN];
+	FILE *f;
+	int ret;
+
+	/* Detect and cache bpftool binary location */
+	if (bpftool_path[0] == 0 && detect_bpftool_path(bpftool_path))
+		return 1;
+
+	ret = snprintf(command, BPFTOOL_FULL_CMD_MAX_LEN, "%s %s%s",
+		       bpftool_path, args,
+		       suppress_output ? " > /dev/null 2>&1" : "");
+
+	f = popen(command, "r");
+	if (!f)
+		return 1;
+
+	if (!suppress_output)
+		fread(output_buf, 1, output_max_len, f);
+	ret = pclose(f);
+
+	return ret;
+}
+
+int run_bpftool_command(char *args)
+{
+	return run_command(args, NULL, 0);
+}
+
+int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_len)
+{
+	return run_command(args, output_buf, output_max_len);
+}
+
diff --git a/tools/testing/selftests/bpf/bpftool_helpers.h b/tools/testing/selftests/bpf/bpftool_helpers.h
new file mode 100644
index 000000000000..dec1ba201410
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpftool_helpers.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#pragma once
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+
+#define MAX_BPFTOOL_CMD_LEN	(256)
+
+int run_bpftool_command(char *args);
+int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_len);

-- 
2.52.0

