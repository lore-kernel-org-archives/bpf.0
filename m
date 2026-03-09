Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66339392C48
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053105; cv=none; b=GAibipQZ22u7+dH2M5TYK+HxZQRJdE7yr7oWuiUCfYmprzu0w6Ul2xlTX+FIAPqhiHVoCevZOQaWcGU8SFhBwpvN+hgJP5BDdGHM21M3JTleEJUG56umP6KWzmEjQwd3mhqoz4ZVo0Tu/xWdQWRIJsDuS0oYxCDSgMjHETM/cqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053105; c=relaxed/simple;
	bh=jYs0pJTHjkLdfsfBnMIrJb5n7ksT9fbzlweEBr7D4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDHOXUiQcpFd0DnubahxuG4QPACEg0t812utJyhLNoAr2eCUCaGeY6xI9pBLWFrA4GLIh8VIY/qvm8BZNhU6tykICrIvSdKMAal0BqSS9nP2gmhky+vBg+VUUZFIEBGWMH6CIEUSOggD4dxcUylAc2bRPXIioO/CjRLlyWr29ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaUIfx/3; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaUIfx/3"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ae222d978so11025996d50.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053103; x=1773657903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDtJtjT4fzine+ZeyXNiHwdW8ww64N9rv71BsVnohzU=;
        b=CaUIfx/3Ha9HcYg2MAi8z9nMsKYJ2BID/wmR+SpQtnO+PJvJfEvafH+VFGSf+Qzbgv
         pND/yqLXAyK3QY9doXt2C8DoC3bQZENqLoKgETD07+NtD3+o0UWivHO5D+wQLvzOMG9k
         2J16bbwS9MoeH3pcFe+rebZKD8/iPayG+c/E2DU1Oz6Ek0ScIgGI4zLXg/kCR1ly6KIc
         KLd4Xb4ZT73b4wAvz9penUjN+WpP1cyodauRVNP7qNNKdKl60ghdFanB5A8VHqMS81ri
         JKWbzrtXB6w2RgDZ8/Gf4LiNP78o22bF2g8HUaCN0OlPsGLxmuUQkvrTC0CHAFJbrYJ0
         4aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053103; x=1773657903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDtJtjT4fzine+ZeyXNiHwdW8ww64N9rv71BsVnohzU=;
        b=TM9TmXbcdpkjTgDcymkYshKyK0NVKLBVGZeIJ4ffGXsG+OXd3Kah7VRnGW68sdt9HD
         yxwGbKkqDG+KDKzk7L/4uhYWf9SQMFyIn3k6AyfS5WghgWaIeXIU3x6J+yd2lC98lnOU
         4LLU+G0HCahySgZBSgVFDzEKKZpHHSjaDPDgaxOrSaf4WeiFF6qhkTHJKHVBQvx+541j
         vsO5noPUB4jasTPU9vtACA3aejJShcgGMJeVeyhEwB86fHtDqsmQKPuj0Oq71Im/a0Io
         dj0PCpIxXdfTmmOCVGkkWU0x3ZMe6QWWqA/BUiTABujohSWhCPXbyQDx3vEPLmnfJNM2
         8e5w==
X-Gm-Message-State: AOJu0Yzekx4rJLyYWsj+v7oGbeesli5++ppPn04ppJG8RviIiEzkWv5t
	RJJCMjW+Yfkof3MHuZwIUl4szPX2GgJ5u5flLCZg+BXm02NYsSsJteNV3HAG9YKDzZQ=
X-Gm-Gg: ATEYQzxbLeW1ofXkucRrPuGzqciRbaNjvJxfq7fuYZz26zPLVZbRJs8P7sYTiHrGKZs
	viQM9o9VCWpsgpsMp5D+unR6Fe1eVv2nJZXhV7bDIoxrwGSuBtmurTBQ1uMLaaJzcse5AIimlqq
	O1z1If5K25KQh5AK4CEkVEOHhGdaZaB+oh1WF+vI03vqFzovmtCffWRq9aDcuSXlmhqHWd46CkY
	CK1xEMxAn/yseRhiFiKTL4EyMsZv/03kmnPhlqO8fjaYG/0MvNgevVOmm2C0YJXB/Tnx+7Ix5Z7
	7eHwo/SLxs6Ae7p5QSopLKWzlUL7Pr99kbvb61pAPNjYKAkJTJDi5928WuNECjKk/NtAtRoIPwr
	RDkER6+9yjaZOFG6cFRdAu3vhVQHK+BSvM8g2wEN9VvSwSPxKU/qLSAf6pLi/WUmBh1oyK879o7
	sWM+ZiTWi83qyBEnFy31IPw5OWeI8p6Z+j42bsWdAVc3OBNO7QPOSsmo2NADrOeAkBOYV2b0m2l
	/BarA/E0Byb69e3XH44Ij6NOAk=
X-Received: by 2002:a05:690e:16d5:b0:64c:c0d0:9088 with SMTP id 956f58d0204a3-64d14350c51mr6706591d50.69.1773053103222;
        Mon, 09 Mar 2026 03:45:03 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176d9574sm4466857d50.18.2026.03.09.03.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:45:02 -0700 (PDT)
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
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v4 bpf-next] selftests/bpf: livepatch_trampoline: skip when prerequisites are missing
Date: Mon,  9 Mar 2026 18:44:48 +0800
Message-ID: <20260309104448.817401-1-sun.jian.kdev@gmail.com>
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
v4:
  - Drop redundant <errno.h> and <unistd.h> includes; both are already included by test_progs.h (per Jiayuan Chen)
  - Tested: ./test_progs -t livepatch_trampoline -vv (SKIP when livepatch-sample.ko missing)

v3:
  - Skip on -ENOENT from load_livepatch() instead of duplicating module path logic (suggested by Jiri Olsa)
  - Tested: ./test_progs -t livepatch_trampoline (SKIP when livepatch-sample.ko missing)

v2:
  - Skip when /sys/kernel/livepatch is missing
  - Guard sysfs write in unload_livepatch() when enabled knob is absent

v3: https://lore.kernel.org/bpf/20260309033712.728133-1-sun.jian.kdev@gmail.com/
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20260305030258.5273-1-sun.jian.kdev@gmail.com/
v1: https://patchew.org/linux/20260227042354.20926-1-sun.jian.kdev@gmail.com/

 .../bpf/prog_tests/livepatch_trampoline.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
index 72aa5376c30e..0a12af924a99 100644
--- a/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
+++ b/tools/testing/selftests/bpf/prog_tests/livepatch_trampoline.c
@@ -5,6 +5,8 @@
 #include "testing_helpers.h"
 #include "livepatch_trampoline.skel.h"
 
+#define LIVEPATCH_ENABLED_PATH "/sys/kernel/livepatch/livepatch_sample/enabled"
+
 static int load_livepatch(void)
 {
 	char path[4096];
@@ -19,7 +21,8 @@ static int load_livepatch(void)
 static void unload_livepatch(void)
 {
 	/* Disable the livepatch before unloading the module */
-	system("echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled");
+	if (!access(LIVEPATCH_ENABLED_PATH, F_OK))
+		system("echo 0 > " LIVEPATCH_ENABLED_PATH);
 
 	unload_module("livepatch_sample", env_verbosity > VERBOSE_NONE);
 }
@@ -81,9 +84,22 @@ static void __test_livepatch_trampoline(bool fexit_first)
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

