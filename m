Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846B27FB1F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027453; cv=none; b=pvrkzIRlUHvMh/JlnaZXFKk02ykA/t7xuelYChXZ/bRJPxfuElRgyIMYhkVO38PhEBYh9Ovtv8rAtiOlnEYnu4Pj9nP7Sv71acBndtjAj7NEuVqY4BdD/mleest4XZo6qMIQUzZs98JcRdzsAEJfHk6QjmOkd5VeU3j1nXVSeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027453; c=relaxed/simple;
	bh=nwFTga/392ZpBEUmDyM2fA8sFXdfCsdAuHr9LVqUiAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DRNN7mcg+V9qjNOEb+ii0RHIcaWDFBl4MgA61sLpzIpLxjHtA1w70Kx3tpHsRcHHK8h14lICj42XbREi3myfs+crlJRyq8/XQBNjUKA9Z6E6eClN9rREmlauBotJ2S/fjsfp09ef8/gUUoyTj1pdkstM55UGct+r6ocrIIelvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLNRwKwX; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLNRwKwX"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdfd129c52so7449179eec.0
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773027451; x=1773632251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lTdaOcT/DU4oMcYTLNfdDr6SytuHIB8obzd/B98sqrw=;
        b=RLNRwKwXzsaFJKcm6yWIcY01wrf+cTHJ8GaGFx0xvoS2gZnquhwxpmnz9r6yXXjION
         OAjLHtRVhurJsLWfjqLgUBiy2AJisseu/S/UCLGo2ITGPfB8xQAtYd9+6ESoAAQCE+y8
         hZ+24qxeHiB9c31TOSMINAq6U3I8zck0qeTa28JjiGgKaXCw+Av5pUIcAib704sTwGEG
         xxpn5qp8l6SKcWg2oqDWGFf0Fae5KoS6ZucyvDTjGA8pMeJG3w7JpnUbN4PQQBEvlMpy
         kCzbEHMwDHumQIbpXPmQyj1eYCHdO/CPP/CvtJSETRnADm+HRWV8Czv/1Qt8KCUGyGG5
         UjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773027451; x=1773632251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTdaOcT/DU4oMcYTLNfdDr6SytuHIB8obzd/B98sqrw=;
        b=WSDpdxzOL40DiLamOPAEEzWkqNfsMUtVt60EntBjmSuBMNxlPVHaAUtRaCbm4GSJ69
         OZJefjSvRcBN+hHYGYm59o9GZHkoo0kNarN40OQr+zekPYravV0SRt48ufz+Cj0/57OH
         7dQdp1iFX6HdFBVjDOT27zpSOFr4FNl0QgrS0HXR6OdWLVAPhRTqZ5NXo+GGGKxiJwFK
         RU8jAyCUlRx1DPV2NcN43iu9iK9ImPKng6Sgf9IJ7xGyhTh2EU70JI4JJJlYiRWamNTo
         BLS++J2sxsoMwLRIMHpm4R2318+lEhi1zgewsW6iRunmETZr9tWx3pxrN4npVc7Wsq4s
         Z0fQ==
X-Gm-Message-State: AOJu0YxVmjfBZCiX+lLcFIzmwT5vZz62igDITBIEBTc2kHgxRo2JHqFT
	H248jbkBGUDT+Efu1crfNLOVbSLLvbD0cCf8DRhBEYtEjiEPzE0vXV6aCB+onnVrhGU=
X-Gm-Gg: ATEYQzytIWj79GrWnsjaJzDMovaYE9Yq2xyqo6s+kz6CbJRwRshFVll+LqdmLUJspUQ
	YUDv88VG6feWMOVhnFTguM0oOtwwxZpQ5kakU64CCuSBav+6+ojQvCGpe0ssWcXZ11V3qmfCllY
	fZr/nqeu1qObylIRPzw3cGFMennxHUBr7q63dSIGM/AsBUg72sj/iiyhYmxqrrDfA86rn512UlE
	EmF/gIFsGzVmuHATUGYCqFwshv4/KEY+etjnSAnTMmdGD1jbNGQzzkyuZjGdpjsbTIKZJGe5ZvK
	Rcmn2ZHINTCh1fA0vdomTsrIcyLd0rEIh6BffLkha/a5rViOIsOkSb+ScRHAedR5kEYyZQ99SD9
	Xm/9ye/KZkWDdYkddNybg/Bo0vw2+99NeA6w8NhlP46DFQ9IYKLUdOHd7yvbdLW5UbD2ScqWHsA
	bbswdYgwHOfx6R/abX7MRTHqSuUXO4i8qdzDZTifQQZJWgJ99TQEHLNzzmxT5rbdnQvAK2/frE6
	DnXuYbughFIq3XAGzoxLMPJysY=
X-Received: by 2002:a05:7022:160b:b0:11b:82b8:40ae with SMTP id a92af1059eb24-128c2df15f8mr4769534c88.18.1773027450995;
        Sun, 08 Mar 2026 20:37:30 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d8ee3503sm1074922c88.0.2026.03.08.20.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 20:37:30 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v3 bpf-next] selftests/bpf: livepatch_trampoline: skip when prerequisites are missing
Date: Mon,  9 Mar 2026 11:37:12 +0800
Message-ID: <20260309033712.728133-1-sun.jian.kdev@gmail.com>
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

v3:
  - Skip on -ENOENT from load_livepatch() instead of duplicating module path logic (suggested by Jiri Olsa)
  - Tested: ./test_progs -t livepatch_trampoline (SKIP when livepatch-sample.ko missing)

v2:
  - Skip when /sys/kernel/livepatch is missing
  - Guard sysfs write in unload_livepatch() when enabled knob is absent

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260305030258.5273-1-sun.jian.kdev@gmail.com/
v1: https://patchew.org/linux/20260227042354.20926-1-sun.jian.kdev@gmail.com/

 .../bpf/prog_tests/livepatch_trampoline.c     | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
index 72aa5376c30e..b306a4070513 100644
--- a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
+++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
@@ -2,9 +2,13 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <test_progs.h>
+#include <errno.h>
+#include <unistd.h>
 #include "testing_helpers.h"
 #include "livepatch_trampoline.skel.h"
 
+#define LIVEPATCH_ENABLED_PATH "/sys/kernel/livepatch/livepatch_sample/enabled"
+
 static int load_livepatch(void)
 {
 	char path[4096];
@@ -19,7 +23,8 @@ static int load_livepatch(void)
 static void unload_livepatch(void)
 {
 	/* Disable the livepatch before unloading the module */
-	system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
+	if (!access(LIVEPATCH_ENABLED_PATH, F_OK))
+		system("echo 0 > " LIVEPATCH_ENABLED_PATH);
 
 	unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
 }
@@ -81,9 +86,22 @@ static void __test_livepatch_trampoline(bool fexit_first)
 void test_livepatch_trampoline(void)
 {
 	int retry_cnt = 0;
+	int err;
+
+	/* Skip if kernel was built without CONFIG_LIVEPATCH */
+	if (access("/sys/kernel/livepatch", F_OK)) {
+		test__skip();
+		return;
+	}
 
 retry:
-	if (load_livepatch()) {
+	err = load_livepatch();
+	if (err) {
+		if (err == -ENOENT) {
+			test__skip();
+			return;
+		}
+
 		if (retry_cnt) {
 			ASSERT_OK(1, "load_livepatch");
 			goto out;

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.43.0

