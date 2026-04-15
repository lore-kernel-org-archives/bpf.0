Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BC28CF5D;
	Wed, 15 Apr 2026 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223368; cv=none; b=CU+PZWdgXaxRqM3IIXB/8IORX5hDINUWya4yaQjU01izPkWTzyoJanAzC0RCiDLvZ9YEWlSH0RenhxEjZ3ZN+AaiDi/vQe96uLNlhy8x7/fo8FhIP+nMq76ebXZKUy3QDgtred31t6aEwbCxUQI5pLx07DZEyQAgPHsoRFG2oaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223368; c=relaxed/simple;
	bh=NiDDBj1otxDIg7G7cOdLRt29IfQDbiNx9uadV42in8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHZT5jKgkW+R/OFdQTOBOVveqQQFXQBHanjCFTQAqXMbPtHcOJJ8kJ8kuaGDAFMmH5uFZZxADLHczBNIPVzBsDFmMSq+e3ZjPv9WOjpCItk+gMlM8BjhaTHzNohSzRWuLHkcGAPsAgoj+hG1pL7eMSNReEUwZnEgzcLLoY9RxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p3dmB2iJ; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p3dmB2iJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776223313;
	bh=lCZAk/cEgPCjy6Qt2SDdMkiO9Vf4UdSkRwIqWJXf5aU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=p3dmB2iJ2FnJx9EL2bzdOcSQ9yiyMJFeTD76p25mlAPDQ8SivqB9u9g6mo2poYW3B
	 yubbKvmgEUl8N8wLo48e4UGSXncw7qqKK5IEpcl/hTN8UUHu3r7xitnuMEjDj+bBV9
	 LpPwNWEy879Y3Yz5PhVyb0Lv3oeFXY1o5auLKMh0=
X-QQ-mid: zesmtpip4t1776223306t06ee2289
X-QQ-Originating-IP: 89XciiglrPtiScbt+uAiWtPXobvh9wdI+AB6AGNs05Q=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Apr 2026 11:21:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11992392841904199774
EX-QQ-RecipientCnt: 10
From: Yihan Ding <dingyihan@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	alan.maguire@oracle.com,
	kernel@uniontech.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: cover UTF-8 trace_printk output
Date: Wed, 15 Apr 2026 11:21:26 +0800
Message-Id: <20260415032126.1096299-3-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415032126.1096299-1-dingyihan@uniontech.com>
References: <20260415032126.1096299-1-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: MjQ00mYXMHtu0CPE2zsrVIjhUM/JyP3DGt+II1ATSCfvyNfAEjy4aHWk
	8XyD9MJzC5fTwsytgteCuC9mVcF7mu/jlWddBWxzJArY4sDWTg4SmI4/9u78IKP7dbFlLUg
	7YnW7UKdF5DusXq7DScfanmK8IxFHmdEndqXLWyAYSmhY9b1gQYJkMNvz5zRFEWw42GcoHO
	Fb6H0B0cQC+GqM2i2938RyiVf1IVJqojV95tnQZONrBy4vlDsP8DQCHF/cKBa4dEZ5+aSWV
	uNtQKFqff4/A8abZ1IUDtx/pgWDi3SnADc4WdlLu1JEga7JNA7F7JWYnmQ665kYjEENXg5H
	C4rapUvqnPrLcRvexfK8jsdUZ2PInTt5v1GNsn7UkKQ6/cT6UEZw0JD/KDQ00vIFzdZ5bFU
	s4I4brOh9sCz08lPmbNRTdMK2dqSlK3VhokUF7TaXTn902K5sbPvsEbrrWQwjbRf+aeUTgm
	Vjmggbwk8RB3rTsLqqkkb7ysJPEyLaFd3LjQzqA33s4XGnklEknah3HkbzxmtCrL27GZ/Qn
	Tv+5iRuuHIYZFxnpXgglfVJaySAD1AZt2G0xLtYVRzvWhAe41Lzq5ppQBcY5j/IP3YM73jM
	NRZBPrgIxr9MPOjSncbSUylDJD6XzURcq4fHzMqm9YGaTcV0wh+8e5EWqJ9pRqQ8KmWV6GF
	roaFtGDgTPDDSvsE31PekOqZp7Z0TvOR3S9r8mj2IAmhA1UrOhXCAk0lK5+GXZp25bExfMQ
	VWSSkI2DdAk/eZzXyxVR4nN1fIrGY8ZBY6eXt/IXYcgKGDiqsK1jsiVp9QY/RJx8OXS96T5
	gZScxnH0sOVFn3L0d4E6BG5VOgE6QGVMGlCU12YBTWrRTdbU06CwX0i0OS0SWG5KxzqrPHf
	yztsBJiiTyA/wBOjOiqN5hXxHgFpF8nKg+eaBjQCNwag3KCjni6mt4KdJQCbLUv88x2ZM+G
	OpOsOXw8YtNt31Ed3OQECU6V+aygbqxvZYM9bMNVHe/HbztSSCVLSwaKD9pNgseSAwAWDmn
	dxyZmsWBqrRF8n1Q0kE7XrbLIZvxolgHmsfTxilQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Extend trace_printk coverage to verify that UTF-8 literal text is
emitted successfully and that non-ASCII bytes are still rejected once
parsing is inside a '%' format sequence.

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
 .../selftests/bpf/prog_tests/trace_printk.c   | 26 +++++++++++++++----
 .../selftests/bpf/progs/trace_printk.c        |  9 +++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index e56e88596d64..40499f01d228 100644
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
+	if (strstr(str, SEARCHMSG_UTF8) != NULL)
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
+	if (!ASSERT_GT(bss->trace_printk_utf8_ran, 0, "bss->trace_printk_utf8_ran"))
+		goto cleanup;
+
+	if (!ASSERT_GT(bss->trace_printk_utf8_ret, 0, "bss->trace_printk_utf8_ret"))
+		goto cleanup;
+
+	if (!ASSERT_LT(bss->trace_printk_utf8_spec_ret, 0,
+		       "bss->trace_printk_utf8_spec_ret"))
+		goto cleanup;
+
+	/* verify our search strings are in the trace buffer */
+	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, found, 1000),
 		 "read_trace_pipe_iter");
 
-	if (!ASSERT_EQ(found, bss->trace_printk_ran, "found"))
+	if (!ASSERT_EQ(found[0], bss->trace_printk_ran, "found"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(found[1], bss->trace_printk_utf8_ran, "found_utf8"))
 		goto cleanup;
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/trace_printk.c b/tools/testing/selftests/bpf/progs/trace_printk.c
index 6695478c2b25..62153d8c5eba 100644
--- a/tools/testing/selftests/bpf/progs/trace_printk.c
+++ b/tools/testing/selftests/bpf/progs/trace_printk.c
@@ -10,13 +10,22 @@ char _license[] SEC("license") = "GPL";
 
 int trace_printk_ret = 0;
 int trace_printk_ran = 0;
+int trace_printk_utf8_spec_ret = 0;
+int trace_printk_utf8_ret = 0;
+int trace_printk_utf8_ran = 0;
 
 const char fmt[] = "Testing,testing %d\n";
+static const char utf8_fmt[] = "中文,测试 %d\n";
+static const char utf8_spec_fmt[] = "%中文\n";
 
 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int sys_enter(void *ctx)
 {
 	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
 					    ++trace_printk_ran);
+	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
+						 ++trace_printk_utf8_ran);
+	trace_printk_utf8_spec_ret = bpf_trace_printk(utf8_spec_fmt,
+						      sizeof(utf8_spec_fmt));
 	return 0;
 }
-- 
2.20.1

