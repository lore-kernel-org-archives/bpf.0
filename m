Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE2269B01
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235650; cv=none; b=PBVlY9KC5L8BQB+/TuTjj832GrO8lFPnvihpbY51pLkyykxDLVXZZhXo91hBvg6SE1P3OBUSd3vtxqYyr8tO2AG0MNIUb3dsTJleJOl1S8gWpEa5jjlzRff756JPxjyQ4bYw24Bggbe4C1+672WyJJyJ+lnmxOa+90sWxl9+UTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235650; c=relaxed/simple;
	bh=D1aO+oqWTqVbI7neF6MggHiTAyqchYMiNo/15B60NDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ayh3LD/Z7CqKCKIx2ppBfL/KclR18a8CfAWZFH77uzoO9LdaKqHKbq0ZXCWcrqOK5BY/9bW5J/55ydXgxUZ2gYp2aY2vEuinhAO6e7uwfVqcbFE9dHPtocWmzzFWcnBxc/R5nrlwBpa2caV+R1PvvumPNO7/glpifypwCnH/MxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9UJMk+Q; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9UJMk+Q"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso1304533b3a.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235648; x=1769840448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPw7fdOWCFlcs/hrYLDN1KcscquTuLr5di1FEI+zxGg=;
        b=Q9UJMk+QyFdM54HgvqwWDamoSXUDXZnYw3PaeM5x7vzv28lWtEATH2PdM5/W7jgv8s
         OuHL2dQ0NIYPSjNJaki+F2grin9wE/Emh60sAcPqBb0ej4r5Kl+reZonmDwJG0WNmdXm
         cR3v1TXBDNGDQe+JktQVsU7oVpoBqohtUgz718pTwOcORfYdhicGh9wqZl2cxqXcndfX
         jfC+FyLE0ewroacOytTyCv2bTXRXFvrRNRhCMRH4IH75bcWozCfSjGyFsePFcKFo/GXI
         Gfc7MVH7L/X4VDhmL9Trsb62Ug+WHErrVatlHEFywWCEWXDIIsv+DLcjzmr0gvxBt95z
         2uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235648; x=1769840448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPw7fdOWCFlcs/hrYLDN1KcscquTuLr5di1FEI+zxGg=;
        b=eBvy1vffa116Au+c4UvlzcHwa32PDI8GecmM9Z1fRHO/qPDiRhqmtp+Dy/dFN8U/jf
         xinGhT+35REomgV0re2NZbwlF3GW9Kf6l+Hb7sOp2qz0W0CjpdQo7uE/+8H7Ld1AJBy/
         mu/a/sPGh1AuAyZ2gwut+aPif6wKMp/j4CGnDM5rAM7GbM+Ie8UH5FMxhfGk2QnrPHKw
         rzQ+tpZ/uA0hpOCJsVYTcMjy/SVb2uXvQv2nT+xUbH9xPxjKZtGrdyUe0tlr7LRHVmwj
         fm6Dz8j/9xJPJUnBC9D/gQ7S+B9+agj/JhZBfZG6/PKjEiDl5sG4Qe02aO/77qMGA9Hj
         BTcg==
X-Forwarded-Encrypted: i=1; AJvYcCWbzXyYbzsNazIu4Xr84qizovhAeH8gttSgSOOZ7O/re4s1ZcCQJUyyGJByX47ErnHvEfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXToq4PbEBQymC+7B/TJU9rM1Op3fUv1ZfF9ue6C5/+7LFB4wI
	arcey8/Q17a8cvlq9RqQDdckVfrn9RaHhSg7HshT9Ut0AeRalzhFkqdu
X-Gm-Gg: AZuq6aLmcffJzLhjycutEeQBbxD7Nkii5E8Z3RrkrEpIrr3hisx29/OnJr1KlHNxFmw
	8ya+hKLkKGTkZT+l6wADJnG78G2UR10DV9jkG3h4Q3Zg2lAbHoK0pp7LuZxuL3/M1tMyb8YObMY
	iaAMAeB4eQrWUK7T/psmPPx3AiVKIUq5WnAalBtVyKWjjVl4fsyZYxtP9LY/m9hRfH2AKfg6x2e
	usZ0dSgaxfG/PS+IyXi+zeoVLWuIKjXUBLn3ecnqlQxq3VCdWUTCZE7Q6BdPpR46d8C3FgWmcQT
	PYLbiRxtCDYhEcpp1mFHO68XTzLFnqs/ycVnTQHiFBZVjLvcydYhON3y6JQs7db5R957q0HZ2du
	5pAm3YrLRBs0PejtZRD9xahz2IKCuDpZULQPY+rWjfZ6k+SOQHJp9d1osJKrL/F/qegBsq98deO
	YTZnp91j1Y
X-Received: by 2002:a05:6a21:7a4a:b0:366:14ac:8c75 with SMTP id adf61e73a8af0-38e6f863065mr5199794637.75.1769235648305;
        Fri, 23 Jan 2026 22:20:48 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:20:47 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 03/13] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Sat, 24 Jan 2026 14:19:58 +0800
Message-ID: <20260124062008.8657-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function argument of "void *ctx" to bpf_session_cookie() and
bpf_session_is_return(), which is a preparation of the next patch.

The two kfunc is seldom used now, so it will not introduce much effect
to change their function prototype.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
v10:
- drop the declaration of bpf_session_is_return() and bpf_session_cookie()
---
 kernel/bpf/verifier.c                             |  6 +++++-
 kernel/trace/bpf_trace.c                          |  4 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h          |  3 ---
 .../bpf/progs/kprobe_multi_session_cookie.c       | 15 +++++++--------
 .../selftests/bpf/progs/uprobe_multi_session.c    |  7 +++----
 .../bpf/progs/uprobe_multi_session_cookie.c       | 15 +++++++--------
 .../bpf/progs/uprobe_multi_session_recursive.c    | 11 +++++------
 7 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2081343a848d..0fa73d56cb8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12484,6 +12484,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_session_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12561,6 +12562,7 @@ BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_session_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12615,7 +12617,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d466a1503da3..13f0a2de33b7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3323,7 +3323,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc bool bpf_session_is_return(void)
+__bpf_kfunc bool bpf_session_is_return(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
@@ -3331,7 +3331,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc __u64 *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index e0189254bb6e..7dad01439391 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,9 +79,6 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
-extern bool bpf_session_is_return(void) __ksym __weak;
-extern __u64 *bpf_session_cookie(void) __ksym __weak;
-
 struct dentry;
 /* Description
  *  Returns xattr of a dentry
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index 0835b5edf685..ad627016e3e5 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -23,16 +22,16 @@ int BPF_PROG(trigger)
 	return 0;
 }
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -42,17 +41,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_kprobe_1_result);
+	return check_cookie(ctx, 1, &test_kprobe_1_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_kprobe_2_result);
+	return check_cookie(ctx, 2, &test_kprobe_2_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_kprobe_3_result);
+	return check_cookie(ctx, 3, &test_kprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
index 30bff90b68dc..6e46bb00ff58 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
@@ -51,7 +50,7 @@ static int uprobe_multi_check(void *ctx, bool is_return)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
 int uprobe(struct pt_regs *ctx)
 {
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
 
 static __always_inline bool verify_sleepable_user_copy(void)
@@ -67,5 +66,5 @@ int uprobe_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
 		uprobe_multi_sleep_result++;
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
index 5befdf944dc6..b5db196614a9 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -13,16 +12,16 @@ __u64 test_uprobe_1_result = 0;
 __u64 test_uprobe_2_result = 0;
 __u64 test_uprobe_3_result = 0;
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -32,17 +31,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
 int uprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_uprobe_1_result);
+	return check_cookie(ctx, 1, &test_uprobe_1_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_2")
 int uprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_uprobe_2_result);
+	return check_cookie(ctx, 2, &test_uprobe_2_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_3")
 int uprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_uprobe_3_result);
+	return check_cookie(ctx, 3, &test_uprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..3ce309248a04 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
@@ -16,11 +15,11 @@ int idx_return = 0;
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
 
-static int check_cookie(void)
+static int check_cookie(struct pt_regs *ctx)
 {
-	__u64 *cookie = bpf_session_cookie();
+	__u64 *cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return()) {
+	if (bpf_session_is_return(ctx)) {
 		if (idx_return >= ARRAY_SIZE(test_uprobe_cookie_return))
 			return 1;
 		test_uprobe_cookie_return[idx_return++] = *cookie;
@@ -40,5 +39,5 @@ int uprobe_recursive(struct pt_regs *ctx)
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	return check_cookie();
+	return check_cookie(ctx);
 }
-- 
2.52.0

