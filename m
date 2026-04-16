Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57134E75A;
	Thu, 16 Apr 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341069; cv=none; b=Qovn+DkWGvfZx5nqSp/MsNHFiC2BNPjWCu8ifEovo+OoO1fMlUmzgSI+56dF4pP1o+PmcEHZYx/rXnTOtMsXmJR24Fc+JZc7E8Iz6ODrSwlC0mhh0Z9cKfABYNCwS0nmGa9koSduUoTOFiMkDUFdCh/nw3Ez+OC/cM/DQYt8bBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341069; c=relaxed/simple;
	bh=2RWoAJVntLClYbXMgY4e7S6tPe1KtrZ64VoBRPJAbkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TEu++/g18huCYLIGdtlMAfdvlBouAmCzpjE8xwOmHeK16J/F1xTb0q4jpZiwLTp1m/cqVi8LPuaeSZnxk3voicGZ7cQ7Kfivg0RYuPWQ7KJr3WgEGDshcul2DsPqf9oTVDIg3J7d+V1BoR3PtQYgb4wphvtxMPVV7Yh/A2C1FMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DKsAdI9u; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DKsAdI9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776340968;
	bh=p+9hmRcBGjUD7hAYTrYwIVaa7QHqLTPJpo+ZwKhtW58=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DKsAdI9ux2/04cT1ABwuvtFoAoy5BpHUlqYjp9JzoKNLwfk8sKMw6+lxiaiC+xD8m
	 spLm5UVR+NGFSt3coecBUTHHrRRLOpYZj6PyweErd1hy27/dTNHHMYZaYVpFoUkUy3
	 sYX1mRwXEguY4ItMOdQJ7AGsH1QPGb4Ai6UnaJqs=
X-QQ-mid: zesmtpip3t1776340961t6cd7fa8a
X-QQ-Originating-IP: sla+t2bIx/UvTPWfXH3ZZeAngiUnb3FrcVltf9bh598=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Apr 2026 20:02:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17050199014614233316
EX-QQ-RecipientCnt: 9
From: Yihan Ding <dingyihan@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	alan.maguire@oracle.com,
	paul.chaignon@gmail.com,
	linux-kernel@vger.kernel.org,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: cover UTF-8 trace_printk output
Date: Thu, 16 Apr 2026 20:01:42 +0800
Message-Id: <20260416120142.1420646-3-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260416120142.1420646-1-dingyihan@uniontech.com>
References: <20260416120142.1420646-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OWhN4QRntHSG5GnzBclCdmoQKfNkWB3VHwfgNjrtsitstuxPFc0boGFh
	HkUpZpCLsmr1Zwx26lLEN18XfZlhcWbPr2bjoJl1tWfx/u927JCCZgJCcle4EaNNU7JxLb2
	y4q+WPNoBzAmoPlopNm3WK3wTLoybx1lodKICeH6kt6NqamPkzz1YS5w+0VcgY0rJaoWAiJ
	dJL9FXLjs/pYsq53ZSimcu+Yht0CT3fTbtw4XffR2SRhzqBDFC5uu10C8MbFk4X3CieL9GL
	C3SJqrA2Hb5+ZInhW/oT3rNlvOttays9QkWaWQieQO+1FdnfglBaKhXg3Sx/gxQ6e/NsfpN
	3NgetSorN0txzUauEUcG5Hxt883ZUvAySCwdXx5vlWn4fMMgN7KAlZiGe2X9s+IF65mrNfx
	2naMw4ZPY5T/R1kYE4f+/m1D/k0HpER+b5pK4+oSVGz8IFEFo99bBA+hW3efwpSqkce4bQD
	WpJBg1txyCsR6MAlET+EZq6NSI8iT0zOSZz+V+PyABDCF+2CoLUaFr98S6x+el1n9G1szjh
	mquqfp5il4Oih5jn3W8YbCrjsW++HFx7Hf/5r5n9Zpfw5DWaBup7LXC3/P6jyKv3j29pMkb
	jwJicaI8q1q0hO0pPjvnc31vT7Mj/IUPXsO9SY6ZQWqHMItIH0p3kgzzU3MlpYJTv7rxlCp
	A/JvaFtNRG09WPkED9n4ynqdDzlPg5IUrgJV+bCLa6EXVMRVikOE+qaTlglrsq0SCYEysU9
	tVUv6lc5Pg4iejiGhCLV0KlZW1sodlV8JzsroMD4/IsMT5HT5U6FqJSYphGybR+8lM/KPkb
	w5BYok+QQQuA7/hsvQ5swwfpQwCFJUMuc7mhuAYH2FIID1wYYplRaqryry6dpqZQ9JIGpLI
	KcOoE2+byWQVhwJjT0V1rmikjLi2Y8nWx4vT8JaCTU4CK+HBm+svzWW6n9NgQ9H2fcGSvXH
	rxaVrFFDoGtG3kUC8Y5Kfv/YJ6oygJEB0tRSbTPJOX6jhNR32ZiENerdbiV4csbaRaAYeWI
	ebqmtcjyYjp29Wh/K1iwAYupWW7+PnYtufnA8swQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Extend trace_printk coverage to verify that UTF-8 literal text is
emitted successfully and that '%' parsing still rejects non-ASCII
bytes once format parsing starts.

Use an explicitly invalid format string for the negative case so the
ASCII-only parser expectation is visible from the test code itself.

Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
 .../selftests/bpf/prog_tests/trace_printk.c   | 28 +++++++++++++++----
 .../selftests/bpf/progs/trace_printk.c        | 10 +++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index e56e88596d64..a5a8104c1ddd 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -6,18 +6,21 @@
 #include "trace_printk.lskel.h"
 
 #define SEARCHMSG	"testing,testing"
+#define SEARCHMSG_UTF8	"中文,测试"
 
 static void trace_pipe_cb(const char *str, void *data)
 {
 	if (strstr(str, SEARCHMSG) != NULL)
-		(*(int *)data)++;
+		((int *)data)[0]++;
+	if (strstr(str, SEARCHMSG_UTF8))
+		((int *)data)[1]++;
 }
 
 void serial_test_trace_printk(void)
 {
 	struct trace_printk_lskel__bss *bss;
 	struct trace_printk_lskel *skel;
-	int err = 0, found = 0;
+	int err = 0, found[2] = {};
 
 	skel = trace_printk_lskel__open();
 	if (!ASSERT_OK_PTR(skel, "trace_printk__open"))
@@ -46,11 +49,24 @@ void serial_test_trace_printk(void)
 	if (!ASSERT_GT(bss->trace_printk_ret, 0, "bss->trace_printk_ret"))
 		goto cleanup;
 
-	/* verify our search string is in the trace buffer */
-	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
-		 "read_trace_pipe_iter");
+	if (!ASSERT_GT(bss->trace_printk_utf8_ran, 0, "bss->trace_printk_utf8_ran"))
+		goto cleanup;
+
+	if (!ASSERT_GT(bss->trace_printk_utf8_ret, 0, "bss->trace_printk_utf8_ret"))
+		goto cleanup;
+
+	if (!ASSERT_LT(bss->trace_printk_invalid_spec_ret, 0,
+		       "bss->trace_printk_invalid_spec_ret"))
+		goto cleanup;
+
+	/* verify our search strings are in the trace buffer */
+	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, found, 1000),
+		  "read_trace_pipe_iter");
+
+	if (!ASSERT_EQ(found[0], bss->trace_printk_ran, "found"))
+		goto cleanup;
 
-	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
+	if (!ASSERT_EQ(found[1], bss->trace_printk_utf8_ran, "found_utf8"))
 		goto cleanup;
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
index 6695478c2b25..f4c538ec3ebd 100644
--- a/tools/testing/selftests/bpf/progs/trace_printk.c
+++ b/tools/testing/selftests/bpf/progs/trace_printk.c
@@ -10,13 +10,23 @@ char _license[] SEC("license") = "GPL";
 
 int trace_printk_ret = 0;
 int trace_printk_ran = 0;
+int trace_printk_invalid_spec_ret = 0;
+int trace_printk_utf8_ret = 0;
+int trace_printk_utf8_ran = 0;
 
 const char fmt[] = "Testing,testing %d\n";
+static const char utf8_fmt[] = "中文,测试 %d\n";
+/* Non-ASCII bytes after '%' must still be rejected. */
+static const char invalid_spec_fmt[] = "%\x80\n";
 
 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int sys_enter(void *ctx)
 {
 	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
 					    ++trace_printk_ran);
+	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
+						 ++trace_printk_utf8_ran);
+	trace_printk_invalid_spec_ret = bpf_trace_printk(invalid_spec_fmt,
+							 sizeof(invalid_spec_fmt));
 	return 0;
 }
-- 
2.20.1

