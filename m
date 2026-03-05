Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54679272E7C
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679795; cv=none; b=RIJb3GWMMMA/Iw8bUn+AL7DqonqOF6QAUi1yMk1TjlKsM/J3mIaszCk15AUmJc0HOsxvBTZw/taMRZ3TO6MIw/UIU33zTF6hIAJIC4Pm0nVqYolD0PvJwXNNrdn2nGDH0oFmHbJ/JkMLcFCXkga/QpWDVFAUCtmy3cw7KAwbYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679795; c=relaxed/simple;
	bh=qG4F646r3A03uFZqgMgj8Cu/cQ6QTmmOz2MQdWFq8TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4sEbfpbMcinLzuWThYw/cslRw3Lw9TlQtuiJUCF0LubPwafIc/k2cYLyOcduqpwnU0DA7T99i833PFhbJOp7aTdyOb1d0iXEAkx7JED9cdrrVLUkmzYoG3RA7I7jvBK4tWuCcmVl8AWoAlF3n3NNR6fWxaWw3zWbVaZNGAvDNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEnqGSyJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEnqGSyJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7986fb839f5so65834607b3.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772679792; x=1773284592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ougbaORYHxsMlWm77a6+iuoe/ZWgFx+bT/l0ak418rc=;
        b=GEnqGSyJthze/mX9hGVYpfo0ItYzkYDwlk3qN0OIYJ06qSKKNP6y+iUtiUuzfwfMkg
         A35cAgxktitBUZkXRAuoK78Etz0X64gX3avA/wUhnF9NrBo8+Q4a9WV5pM5xo4kTf16K
         8T8mH8l8dZ5DIKx6BLTZL8neUfhpkvcPibBOsDz0K2jbHslZpii5WqTpUaSS82Lkm9MQ
         YI8S8GcF/W5dLvHNYoH7q/+sOKcloVj/XyICzT0jK+hw7vIwph6yC8lMdxWw4eVD619E
         MXHNUOayonYrRV+9uEu/zWUApu0bCUEgJ5QznaCZQCSAQRSWzqliA7M+y9S9Gd7QXc9X
         GR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772679792; x=1773284592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ougbaORYHxsMlWm77a6+iuoe/ZWgFx+bT/l0ak418rc=;
        b=vP4oE05nTHQMyY2Q7pu0R/FpULbAMuR5tZKsqhka8qhGUmtjhuD6NPyvUD9wJO1vXL
         BNeZsvV2zVPtlBE0iwQGi8WeYzsuNvaZSalpQ30fx3p9OeNjiWp1ajvAy5Jqwa3TNlRR
         iu87/X4kS6PK7SxZoSYRz2w86HOS9Z0fF02szsoGFb+ox/GOaskTXl3KSSgHmO6iXZwA
         ohtB2rzIuCkQYvNDcupIoTEpLuXWL25Qo/4ZTcRevE143TKsj+JdcZLL9ZPAsgtiAgkr
         I5tfGuvqaOeREx/07T4Bu14ogZfIo+o5mVpY21WNnUSlxQORsXOLJPCnziXu4xv3RWXr
         d35w==
X-Gm-Message-State: AOJu0Yy2ouWd2S3glesUnOSS/S6m9ZLakIVbtuef0NB+/rOGE/YCvsGE
	hneWESR0uE90wWhDbOB2hV3wQTqpHbfvw0Dt2OOL3rIqlWPPVyvB75edun7S7FszrRLzGd2H
X-Gm-Gg: ATEYQzxJmALE7+A8+fzUl8rhixRwG5JgBLukOibw4n6gFuEjjc6jJ5OWhi1Awd7pnDN
	B3qMN8TECib3EweQs8+VUst1pAC1queeLOyh5pq0zc1e/WNFlDqWu1KATE0NTl0FpqABz78sbNw
	5P85BNRnHnx7oAElAKAIKChfYjkWtxCWg+QsmfBzT+khf150GoynqHzg8hAEz5jfsUyrxSREJ58
	y8mWa3MRruG5hsvcdj9iSXuTRSDy/OjIdPUm2E6TQFZ68fOqOdUFFXaXT39VKSadRumzn+Sn4s/
	tO6AshgMbdEtbau4+MSEfXFGpZyLxSMrTtcrtkoxZIzTx+LAwpNAD4yVexhx2PSq8Oh7Dw7dPtZ
	81WrSvDjtkljme0piBBzS93fvB4vdRVfjinE2xjIyHbMX44BGLP7YDjbyI3Xvx2ia0PpTf0lfL+
	LozXR7xK6clFGW92C/G3TRdzoj4n1ywTGNDfvjAeOLsF0IxrXxxuoOcUevZeRi/KHdnSrdWs9oG
	Es4pzKyNmukO7TL4sBW21/416kqHC1DqMBU
X-Received: by 2002:a05:690c:dc4:b0:798:6401:fd31 with SMTP id 00721157ae682-798c6c0e66dmr39861277b3.15.1772679792149;
        Wed, 04 Mar 2026 19:03:12 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8183sm82350587b3.30.2026.03.04.19.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:03:11 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: livepatch_trampoline: skip when prerequisites are missing
Date: Thu,  5 Mar 2026 11:02:58 +0800
Message-ID: <20260305030258.5273-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

livepatch_trampoline relies on livepatch sysfs and livepatch-sample.ko.
When CONFIG_LIVEPATCH is disabled or the samples module isn't built, the
test fails with ENOENT and causes false failures in minimal CI configs.

Skip the test when livepatch sysfs or the sample module is unavailable.
Also avoid writing to livepatch sysfs when it's not present.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---

v2:
  - Add missing Cc's suggested by get_maintainer.pl
  - Prefix subject with bpf-next to avoid Patchwork tree mis-detection
  - Drop Fixes tag to avoid verify_fixes issues due to tree mismatch
  - No code changes

v1: https://patchew.org/linux/20260227042354.20926-1-sun.jian.kdev@gmail.com/

 .../bpf/prog_tests/livepatch_trampoline.c     | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
index 72aa5376c30e..75336d9c2313 100644
--- a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
+++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
@@ -2,9 +2,12 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <test_progs.h>
+#include <unistd.h>
 #include "testing_helpers.h"
 #include "livepatch_trampoline.skel.h"
 
+#define LIVEPATCH_ENABLED_PATH "/sys/kernel/livepatch/livepatch_sample/enabled"
+
 static int load_livepatch(void)
 {
 	char path[4096];
@@ -19,7 +22,8 @@ static int load_livepatch(void)
 static void unload_livepatch(void)
 {
 	/* Disable the livepatch before unloading the module */
-	system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
+	if (!access(LIVEPATCH_ENABLED_PATH, F_OK))
+		system("echo 0 > " LIVEPATCH_ENABLED_PATH);
 
 	unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
 }
@@ -82,6 +86,28 @@ void test_livepatch_trampoline(void)
 {
 	int retry_cnt = 0;
 
+	/* Skip if kernel was built without CONFIG_LIVEPATCH */
+	if (access("/sys/kernel/livepatch", F_OK)) {
+		test__skip();
+		return;
+	}
+
+	/*
+	 * Skip if livepatch-sample.ko was not built (same path logic as
+	 * load_livepatch()).
+	 */
+	{
+		char path[4096];
+
+		snprintf(path, sizeof(path),
+			 "%s/samples/livepatch/livepatch-sample.ko",
+			 getenv("KBUILD_OUTPUT") ? : "../../../..");
+		if (access(path, R_OK)) {
+			test__skip();
+			return;
+		}
+	}
+
 retry:
 	if (load_livepatch()) {
 		if (retry_cnt) {

base-commit: 0b3bb205808195159be633a8cefb602670e856fb
-- 
2.43.0

