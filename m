Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E3395AD2
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314999; cv=none; b=AS7CBPJFLQQ5VP0aKaCxxGhqVqXVBCp6BCPWMR99NhytaVjU0zcO4UWNZAXz4tRHZW/uel7jRw71bhdXFhiDQcnsNO+gt9pIDGPM1Ut+r56oj+fmecn5OSY7ToJucj7/9ph1PTlP6mtyReSxZ9RBBpM0YKriNO60tAvI7ZIhStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314999; c=relaxed/simple;
	bh=RvWV5kRD5G6kCXyOZBwl54hodI4htRbl4KUmcoGIRmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xkm7AJ4yoEk4Ymp5VR2VNLHdkzw2sLf3AzrDm23YlFcUE3+ioiuwM4noLNP5Zjajfz4ECzrB9x4CV3mDRXpTWlWfiPEgm1pq18RiJPuGmF4JFcZlpn9oHoCtpLejCWRRb+cD8sAUe1fhL5F85ji5OgH+ofmhzbjUOfPv9i2H7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=En5ZTMVm; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="En5ZTMVm"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward204d.mail.yandex.net (postfix) with ESMTPS id DF63B8B71D
	for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 22:28:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8a97:0:640:ac66:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 9F17CC008E;
	Tue, 06 Oct 2026 22:28:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp) with ESMTPSA id fSSIRv0hUmI0-TIU0Pkhh;
	Tue, 06 Oct 2026 22:28:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1791314923; bh=RgUssRFsAbFCs3PnZzZ6melVgipx1gIf+HJ260q4DMg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=En5ZTMVmrJQZQewocOZlTDyzmBkOt7WKURJvK7q5hGNL4hOVQPGagGJ5F0wabOlP0
	 piM++vcgwLIU3I6zmSLqDB2bXDyk8HlmsWjlo2V94qMT6zBjD0cvjQmJctPMo2kSGb
	 BLzqh0A+SBjrR9SmykJkOJbMYg4t8fUc29dhLu6M=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [RFC PATCH] bpf: test: parallel execution of basic tests
Date: Tue,  6 Oct 2026 22:28:40 +0300
Message-ID: <20261006192840.155680-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since an amount of basic tests is large enough, implement
simple workqueue-based parallel execution, with an option
to fallback to similar-to-legacy behavior.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 lib/test_bpf.c | 160 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 56 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index af6f3340c034..270899aed1e7 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -13,6 +13,7 @@
 #include <linux/bpf.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 #include <linux/if_vlan.h>
 #include <linux/prandom.h>
 #include <linux/highmem.h>
@@ -24,6 +25,7 @@
 #define MAX_DATA	128
 #define MAX_INSNS	512
 #define MAX_K		0xffffFFFF
+#define MAX_OUTPUT	256
 
 /* Few constants used to init test 'skb' */
 #define SKB_TYPE	3
@@ -83,6 +85,10 @@ struct bpf_test {
 	__u8 frag_data[MAX_DATA];
 	int stack_depth; /* for eBPF only, since tests don't call verifier */
 	int nr_testruns; /* Custom run count, defaults to MAX_TESTRUNS if 0 */
+	struct work_struct work;
+	char output[MAX_OUTPUT];
+	int nbytes;
+	int index;
 };
 
 /* Large test cases need separate allocation and fill handler. */
@@ -3174,6 +3180,7 @@ static int bpf_fill_staggered_jsle32_reg(struct bpf_test *self)
 	return __bpf_fill_staggered_jumps(self, &jmp, -1, -1);
 }
 
+static struct workqueue_struct *bpf_wq;
 
 static struct bpf_test tests[] = {
 	{
@@ -14974,6 +14981,18 @@ static void release_test_data(const struct bpf_test *test, void *data)
 		kfree_skb(data);
 }
 
+static void __printf(2, 3)
+test_log(struct bpf_test *test, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	test->nbytes += vscnprintf(test->output + test->nbytes,
+				   sizeof(test->output) - test->nbytes,
+				   fmt, args);
+	va_end(args);
+}
+
 static int filter_length(int which)
 {
 	struct sock_filter *fp;
@@ -15000,7 +15019,8 @@ static void *filter_pointer(int which)
 
 static struct bpf_prog *generate_filter(int which, int *err)
 {
-	__u8 test_type = tests[which].aux & TEST_TYPE_MASK;
+	struct bpf_test *test = &tests[which];
+	__u8 test_type = test->aux & TEST_TYPE_MASK;
 	unsigned int flen = filter_length(which);
 	void *fptr = filter_pointer(which);
 	struct sock_fprog_kern fprog;
@@ -15012,14 +15032,14 @@ static struct bpf_prog *generate_filter(int which, int *err)
 		fprog.len = flen;
 
 		*err = bpf_prog_create(&fp, &fprog);
-		if (tests[which].aux & FLAG_EXPECTED_FAIL) {
-			if (*err == tests[which].expected_errcode) {
-				pr_cont("PASS\n");
+		if (test->aux & FLAG_EXPECTED_FAIL) {
+			if (*err == test->expected_errcode) {
+				test_log(test, "PASS\n");
 				/* Verifier rejected filter as expected. */
 				*err = 0;
 				return NULL;
 			} else {
-				pr_cont("UNEXPECTED_PASS\n");
+				test_log(test, "UNEXPECTED_PASS\n");
 				/* Verifier didn't reject the test that's
 				 * bad enough, just return!
 				 */
@@ -15028,8 +15048,8 @@ static struct bpf_prog *generate_filter(int which, int *err)
 			}
 		}
 		if (*err) {
-			pr_cont("FAIL to prog_create err=%d len=%d\n",
-				*err, fprog.len);
+			test_log(test, "FAIL to prog_create err=%d len=%d\n",
+				 *err, fprog.len);
 			return NULL;
 		}
 		break;
@@ -15037,7 +15057,7 @@ static struct bpf_prog *generate_filter(int which, int *err)
 	case INTERNAL:
 		fp = bpf_prog_alloc(bpf_prog_size(flen), 0);
 		if (fp == NULL) {
-			pr_cont("UNEXPECTED_FAIL no memory left\n");
+			test_log(test, "UNEXPECTED_FAIL no memory left\n");
 			*err = -ENOMEM;
 			return NULL;
 		}
@@ -15046,8 +15066,8 @@ static struct bpf_prog *generate_filter(int which, int *err)
 		/* Type doesn't really matter here as long as it's not unspec. */
 		fp->type = BPF_PROG_TYPE_SOCKET_FILTER;
 		memcpy(fp->insnsi, fptr, fp->len * sizeof(struct bpf_insn));
-		fp->aux->stack_depth = tests[which].stack_depth;
-		fp->aux->verifier_zext = !!(tests[which].aux &
+		fp->aux->stack_depth = test->stack_depth;
+		fp->aux->verifier_zext = !!(test->aux &
 					    FLAG_VERIFIER_ZEXT);
 
 		/* We cannot error here as we don't need type compatibility
@@ -15055,7 +15075,7 @@ static struct bpf_prog *generate_filter(int which, int *err)
 		 */
 		fp = bpf_prog_select_runtime(fp, err);
 		if (*err) {
-			pr_cont("FAIL to select_runtime err=%d\n", *err);
+			test_log(test, "FAIL to select_runtime err=%d\n", *err);
 			return NULL;
 		}
 		break;
@@ -15125,7 +15145,7 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 
 		data = generate_test_data(test, i);
 		if (!data && !(test->aux & FLAG_NO_DATA)) {
-			pr_cont("data generation failed ");
+			test_log(test, "data generation failed ");
 			err_cnt++;
 			break;
 		}
@@ -15133,12 +15153,12 @@ static int run_one(const struct bpf_prog *fp, struct bpf_test *test)
 		release_test_data(test, data);
 
 		if (ret == test->test[i].result) {
-			pr_cont("%lld ", duration);
+			test_log(test, "%lld ", duration);
 		} else {
 			s32 res = test->test[i].result;
 
-			pr_cont("ret %d != %d (%#x != %#x)",
-				ret, res, ret, res);
+			test_log(test, "ret %d != %d (%#x != %#x)",
+				 ret, res, ret, res);
 			err_cnt++;
 		}
 	}
@@ -15155,6 +15175,9 @@ module_param(test_id, int, 0);
 static int test_range[2] = { 0, INT_MAX };
 module_param_array(test_range, int, NULL, 0);
 
+static bool legacy;
+module_param(legacy, bool, 0);
+
 static bool exclude_test(int test_id)
 {
 	return test_id < test_range[0] || test_id > test_range[1];
@@ -15345,65 +15368,80 @@ static __init int test_skb_segment(void)
 	return err_cnt ? -EINVAL : 0;
 }
 
-static __init int test_bpf(void)
+static atomic_t err_cnt = ATOMIC_INIT(0), pass_cnt = ATOMIC_INIT(0);
+static atomic_t jit_cnt = ATOMIC_INIT(0), run_cnt = ATOMIC_INIT(0);
+
+static void test_bpf_work_handler(struct work_struct *work)
 {
-	int i, err_cnt = 0, pass_cnt = 0;
-	int jit_cnt = 0, run_cnt = 0;
+	struct bpf_test *test = container_of(work, struct bpf_test, work);
+	struct bpf_prog *fp;
+	int err;
 
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		struct bpf_prog *fp;
-		int err;
+	test_log(test, "#%d %s ", test->index, test->descr);
 
-		cond_resched();
-		if (exclude_test(i))
-			continue;
+	fp = generate_filter(test->index, &err);
 
-		pr_info("#%d %s ", i, tests[i].descr);
+	if (test->fill_helper) {
+		kfree(test->u.ptr.insns);
+		test->u.ptr.insns = NULL;
+	}
 
-		if (tests[i].fill_helper &&
-		    tests[i].fill_helper(&tests[i]) < 0) {
-			pr_cont("FAIL to prog_fill\n");
-			continue;
+	if (fp == NULL) {
+		if (err == 0) {
+			atomic_inc(&pass_cnt);
+			return;
 		}
+		atomic_inc(&err_cnt);
+		return;
+	}
 
-		fp = generate_filter(i, &err);
+	test_log(test, "jited:%u ", fp->jited);
 
-		if (tests[i].fill_helper) {
-			kfree(tests[i].u.ptr.insns);
-			tests[i].u.ptr.insns = NULL;
-		}
+	atomic_inc(&run_cnt);
+	if (fp->jited)
+		atomic_inc(&jit_cnt);
 
-		if (fp == NULL) {
-			if (err == 0) {
-				pass_cnt++;
-				continue;
-			}
-			err_cnt++;
-			continue;
-		}
+	err = run_one(fp, test);
+	release_filter(fp, test->index);
 
-		pr_cont("jited:%u ", fp->jited);
+	if (err) {
+		test_log(test, "FAIL (%d times)\n", err);
+		atomic_inc(&err_cnt);
+	} else {
+		test_log(test, "PASS\n");
+		atomic_inc(&pass_cnt);
+	}
 
-		run_cnt++;
-		if (fp->jited)
-			jit_cnt++;
+	pr_info("%s", test->output);
+}
 
-		err = run_one(fp, &tests[i]);
-		release_filter(fp, i);
+static __init int test_bpf(void)
+{
+	int i;
 
-		if (err) {
-			pr_cont("FAIL (%d times)\n", err);
-			err_cnt++;
-		} else {
-			pr_cont("PASS\n");
-			pass_cnt++;
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (exclude_test(i))
+			continue;
+
+		if (tests[i].fill_helper &&
+		    tests[i].fill_helper(&tests[i]) < 0) {
+			pr_err("#%d %s: FAIL to setup helper\n",
+			       i, tests[i].descr);
+			continue;
 		}
+
+		INIT_WORK(&tests[i].work, test_bpf_work_handler);
+		tests[i].index = i;
+		queue_work(bpf_wq, &tests[i].work);
 	}
 
+	flush_workqueue(bpf_wq);
+
 	pr_info("Summary: %d PASSED, %d FAILED, [%d/%d JIT'ed]\n",
-		pass_cnt, err_cnt, jit_cnt, run_cnt);
+		atomic_read(&pass_cnt), atomic_read(&err_cnt),
+		atomic_read(&jit_cnt), atomic_read(&run_cnt));
 
-	return err_cnt ? -EINVAL : 0;
+	return atomic_read(&err_cnt) ? -EINVAL : 0;
 }
 
 struct tail_call_test {
@@ -15901,6 +15939,14 @@ static int __init test_bpf_init(void)
 	if (ret < 0)
 		return ret;
 
+	if (legacy)
+		bpf_wq = alloc_ordered_workqueue("test_bpf_wq", 0);
+	else
+		bpf_wq = alloc_workqueue("test_bpf_wq", WQ_UNBOUND, num_online_cpus());
+
+	if (!bpf_wq)
+		return -ENOMEM;
+
 	if (!strlen(test_suite) || !strcmp(test_suite, "test_bpf")) {
 		ret = test_bpf();
 		if (ret)
@@ -15925,6 +15971,8 @@ static int __init test_bpf_init(void)
 
 static void __exit test_bpf_exit(void)
 {
+	if (bpf_wq)
+		destroy_workqueue(bpf_wq);
 }
 
 module_init(test_bpf_init);
-- 
2.55.0

