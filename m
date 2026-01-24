Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340925C818
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225521; cv=none; b=UmIfSmi3oz0Zl5faMEiohJViZTSaOVzrLNrCHKrLL5AH4aqd/xXiik0Dc1xjx+o+QtJdfxFPYcKgKbSgS+Hb6jiA1fuYMTKl6XExahNhCvmHVhixrdtMBvZ6x2GcIHyWNf2LtYFBG0bzKtTeWaQ+Di43wqkRzbmszHrL91p0/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225521; c=relaxed/simple;
	bh=D1aO+oqWTqVbI7neF6MggHiTAyqchYMiNo/15B60NDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1JK9hD9IzwstWt4h5RFAAYn2t3PI/to1T4Bidk2VYlA6Z/EORcBGqVJaiE9BmT6E1RlSg6fNfZcwFW1yn3oe2kCcKu6u2hFe7NRig2Y3NzkYFdXUpUxT3GFbvarVMEnn8pg3eYefCOxU1iz+rjtywJpHSPphCQVeD0uU+qbqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJpoDgY/; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJpoDgY/"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0fe77d141so16684925ad.1
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225519; x=1769830319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPw7fdOWCFlcs/hrYLDN1KcscquTuLr5di1FEI+zxGg=;
        b=YJpoDgY/Z88InrWYrLWl1fKzuDji49Mf7TcJxi35EqYyHKIVfVY4Pr0iMVUGP3+rSI
         e0ILnKc56hfJ1BHqutx0W1H/CHIxo/rkoATYllD/L7G/PG76V9rCQ7+141J1/Ynhqd9s
         oU1uoKvpOSz6O0SI2apMBdTnQOwO1x7b4UXSuvxOPwog0HOk138MCXlc7Xa/w6h9Egs9
         iuqOkFUwGTN/hL3aMPeVFRkENo3iNoFVBqGHisiMhBqA1VScpEjibEkHLUyrCfodLNMB
         5t/Z6IG0YCprgBxhwAk1gCwu11WKFd/LQ0LHXobK71LEWVg1CiFc1Lmg04DukXujC+TU
         WuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225519; x=1769830319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPw7fdOWCFlcs/hrYLDN1KcscquTuLr5di1FEI+zxGg=;
        b=Ol7yEWKCXuzOhX7GvUeHAwPhK1sd2Zm58jCrclVQRiN2g/D1gKedkpdhr6OfPtL50V
         qI6byYzJgipPSq3Qt9U4A3tFJXXYJPv0GZ5jXZWGZOeKgCMAA3Mwqa6wLcxTK/ayHv+u
         3/UUdv3N0UZtZojTPdUci39HXAvfNUznjD7laxGHxVzuI0jFmM8n9JLCl2T7z8kHDNn+
         mFNCVDMMQy/4k69Gv8DRoMobI6qqQvnRQgfjEQ8o9dTsxP9Rt7IdiqZZM1ransAu/zzf
         6nwKAAGx7wL0q/QnQ4oHtK37wQxDZrq4ilaPLjz4pZp8Z2UlSiKlNujssDa2cABd5z3m
         M0HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjmepJU2IifkXWHHpAF3TNa6pfhVG3JSjrphM9+6HK1ruIwkRURczoK3SlKaL+NJ0EhZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYAHTyr80hvAe+OjA2PWsp2s1UpswBk1QLmYCr9Wtt3niz2b3
	lXyNVHXjUlNmnlHAAjDxsxJp39gLhgjyi+jQmrc14jhsgIx+VjofrvVA
X-Gm-Gg: AZuq6aKmYDQQD+ftPBT6CY5C86we2vlMQiFZm0Dx1kfQz3t/Dm3QXJrLf5TEwJrmkfu
	tKWFYtKA9x989C5lDK227gtQWChMoEHjaSmZxyvtS/2QtcLwCd8dY3L2eJtoVGFl200QvWyihr2
	f/05i4pcKbHIZDaEz2Sxu6eMF4tF6EE4uD0zBziRA6++ics4NeAXt/yRBzlJKqYWkj9pOILrpv2
	N+vQXPDvk9RSo5kqDpQeaPcmYo9p2rWmRlueCMa/EJv3D7BN+zxuBtZf6mD3lvliXEFv4EjYLqF
	RwOvQftL2qRio0+MUPQgBLHUjr8FKNqPqc1DEHSg+JjjRGzVjSCwhsrHPdKK7/EFkrNvIRoZvfk
	nLuprlhPxm/rIBS7yfQbrLzSMCt87iS93gi+zjQ8EtlO3DvvMKG2i9ZCOVpDUffAnF+D5oJfzlX
	4XnSwzZHQq
X-Received: by 2002:a17:902:f647:b0:2a7:63e4:b1ac with SMTP id d9443c01a7336-2a80ec5388dmr28034185ad.38.1769225518970;
        Fri, 23 Jan 2026 19:31:58 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:31:58 -0800 (PST)
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
Subject: [PATCH bpf-next v12 03/13] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Sat, 24 Jan 2026 11:31:09 +0800
Message-ID: <20260124033119.28682-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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

