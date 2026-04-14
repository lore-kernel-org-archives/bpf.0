Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD42175A6E;
	Tue, 14 Apr 2026 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130862; cv=none; b=ZbiF+fPirP6Sk5xnsyzbKCI3qOciXnytazqu9XTK7+asSzzd8LgIJ/xiq1IVgQ1NDYt99+AEVbt63XZ+VGRLtmm6gypTTVi0LyXuPWc3rNtBLW+a5DUPo56TdS4MYGspLODuVj5r/2XKmYqoHdw/vGHdsXU7wQjtFXJkTTam//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130862; c=relaxed/simple;
	bh=CVUH62THuE+t3vMuudrdn17dofVDtLU4tnG9KdHkRa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i6vP2g2aNTV0uLUJc7Q1ngQaUh6DbdarQIUlK2UtYOVoz3ZL2v+ONnem+PSo+/KLPrKfkDJisw2ez2Ll7Rk5g9vTFciZVXoxZfAYgt6UCMYFs2XYaXWC2XdgO2T6Xpe0/rmrX2szgoQI79p9yhXLP5sHQ0po5tzzifCDXOFZPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HndldtIv; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HndldtIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776130826;
	bh=2o2nXaGn3xy5dIW84oGoCrtG+4Y7V7BBZuKTJB3Mq+A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HndldtIvXmRS8Wd/66Kx/pGm0VHAZGhsOsCBGWJnCi9Yqnf0cKz0XHrTnNF6/4sty
	 4RjQ4RwlM8w1HallqIqdxkzC4SohJG9hvg46NBweo3fXrcNa7VAvU8ooFT+Zvk6wWK
	 Lfjgz5pyHa21QuJo7T171IDrpC6AtGxKBdsxHqE8=
X-QQ-mid: zesmtpip2t1776130810t54227dfc
X-QQ-Originating-IP: PDvphrMKRxJXOzB0Ljt/SoSN7n9Nsoceku01euB8pcQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Apr 2026 09:40:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6462308600708098347
EX-QQ-RecipientCnt: 9
From: Yihan Ding <dingyihan@uniontech.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Date: Tue, 14 Apr 2026 09:40:01 +0800
Message-Id: <20260414014001.814324-1-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
X-QQ-XMAILINFO: OUC5DGN0mB58SbT23Ysuy1huG8Skch3ykYU0WJWEsu+9hn3TzU1tu2go
	f/HXpU7xy/RkNfsq9X8ypD32qVtNd4y62qVSFSR/TCtPSwTnTwNdtl9zez4nVsrIial04KK
	lvSIp4yqH631lYGZCMeq2b/lkTs1C9uKHZGy/BCXnSr23EP2W7mr+EMsXmpVIvKxjFvmAt0
	PW9XPpF6Pf0JIIulvVr2Yy42ovRIEAYad3CWUvRxkRr7TRfG00wbU7IjcnID69rRvo7vKzG
	PETMaNbXtqDyUPcxg3wEP4XLuI9BKjlMWOfFKgyfqvrVLOF6VgpgKQlnrvuNLiznZpBEIh0
	uxw0xEB7xY589i5FkAjh5t2CVVzOIBnce+lXdOd9YiAcwcqc9Dsi644ttIR4cEzQ4SR3xsf
	kbulxK84fbrRu0N4MOjVLy3tcUIPz29UiIhZmTWo+ddxg0BOMQQ+ILtEtCwIVDyeTD7TTf3
	brWOnSfEnp6I161to06rIKSzvey/MUM69ipYRhB9ESReIS0Y6s2JBIqXIjd7dmSyBctMncG
	7VG9MYbIbkT3uhZkh4A51xNVP2ZshVZi90ClN44pGPxFwUuhK34VodBcyuLKQEMciRPzQ3V
	igAGFEITpbclKavysupXWSPVR/QgQTJrACMr0AK7l7VAN3tSiUO9hcuMJ6mBePN1vRlx0GW
	QdfVGZJfHT8YxThvBoa97OcO55Sl6c3iROrZIcE+BdGYLc22fR9dHGlhvuEswjfs5BOF1GV
	DO9W5NW/1SkgclGFO15vKwdmIM/w7QzLmypBpQWURZDqllZqfSf2P3mm6uabYMx/Z8488Fp
	WTX1ZQ+OxZEOnY2Q86DuVU+DkLsYm55HQKeD+VWpLqUTmPgp2ZCwl4NucL8FVo/ONHyyRpv
	8WkzNmznLCzH8c2aJK2ypkg7JoaWVXHF+3V11qRUzSCVf+hzOP9PenXQZZ4C+RmCjEfmIjX
	TVSvDZPaH+6dTUTD5LnJ3nBHkqrCULt1zQKRhgydAsqAH5VSgfPE8n21sU5FGLs7iLK6gWL
	7zHVgBvQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

bpf_bprintf_prepare() currently rejects any non-ASCII byte in the format
string, such as UTF-8 Chinese text.

All BPF formatted output helpers that go through bpf_bprintf_prepare(),
such as bpf_trace_printk(), bpf_seq_printf() and bpf_snprintf(), only
need ASCII parsing for conversion specifiers. Plain text does not need
that restriction, but today any byte >= 0x80 makes the format fail
validation.

As a result, UTF-8 text literals are rejected even when they are not part
of a format specifier. In practice, an ASCII-only bpf_trace_printk()
format works, while the same format with UTF-8 literal text produces no
trace output.

Allow non-ASCII bytes in plain text while keeping the existing control
character checks and keeping format specifiers ASCII-only. This preserves
the current parsing rules for '%' sequences and allows valid UTF-8 text
to be emitted.

Extend the trace_printk selftest accordingly by emitting both ASCII and
UTF-8 strings and verifying that both appear in the trace output.

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
Testing:
- Reproduced on x86_64 without this patch: ASCII trace output works, while
   UTF-8 literal text in bpf_trace_printk() is rejected and produces no trace
   output.
- Verified with tools/testing/selftests/bpf: ./test_progs -t trace_printk

 kernel/bpf/helpers.c                          | 21 +++++++++++++-----
 .../selftests/bpf/prog_tests/trace_printk.c   | 22 ++++++++++++++-----
 .../selftests/bpf/progs/trace_printk.c        |  5 +++++
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..e2f103297e4a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 		data->buf = buffers->buf;
 
 	for (i = 0; i < fmt_size; i++) {
-		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
+		unsigned char c = fmt[i];
+
+		/*
+		 * Permit non-ASCII bytes in plain text so UTF-8 messages can be
+		 * emitted, while keeping format specifiers ASCII-only.
+		 */
+		if (isascii(c) && !isprint(c) && !isspace(c)) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -867,6 +873,10 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 		 * always access fmt[i + 1], in the worst case it will be a 0
 		 */
 		i++;
+		if (!isascii((unsigned char)fmt[i])) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		/* skip optional "[0 +-][num]" width formatting field */
 		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
@@ -881,8 +891,9 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 		if (fmt[i] == 'p') {
 			sizeof_cur_arg = sizeof(long);
 
-			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
-			    ispunct(fmt[i + 1])) {
+			if (fmt[i + 1] == 0 ||
+			    isspace((unsigned char)fmt[i + 1]) ||
+			    ispunct((unsigned char)fmt[i + 1])) {
 				if (tmp_buf)
 					cur_arg = raw_args[num_spec];
 				goto nocopy_fmt;
@@ -958,8 +969,8 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 			fmt_ptype = fmt[i];
 fmt_str:
 			if (fmt[i + 1] != 0 &&
-			    !isspace(fmt[i + 1]) &&
-			    !ispunct(fmt[i + 1])) {
+			    !isspace((unsigned char)fmt[i + 1]) &&
+			    !ispunct((unsigned char)fmt[i + 1])) {
 				err = -EINVAL;
 				goto out;
 			}
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index e56e88596d64..f7b03dc4eaf4 100644
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
@@ -46,11 +49,20 @@ void serial_test_trace_printk(void)
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
index 6695478c2b25..97afe8b149b0 100644
--- a/tools/testing/selftests/bpf/progs/trace_printk.c
+++ b/tools/testing/selftests/bpf/progs/trace_printk.c
@@ -10,13 +10,18 @@ char _license[] SEC("license") = "GPL";
 
 int trace_printk_ret = 0;
 int trace_printk_ran = 0;
+int trace_printk_utf8_ret = 0;
+int trace_printk_utf8_ran = 0;
 
-const char fmt[] = "Testing,testing %d\n";
+static const char fmt[] = "Testing,testing %d\n";
+static const char utf8_fmt[] = "中文,测试 %d\n";
 
 SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int sys_enter(void *ctx)
 {
 	trace_printk_ret = bpf_trace_printk(fmt, sizeof(fmt),
 					    ++trace_printk_ran);
+	trace_printk_utf8_ret = bpf_trace_printk(utf8_fmt, sizeof(utf8_fmt),
+						 ++trace_printk_utf8_ran);
 	return 0;
 }
-- 
2.20.1
