Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3F2773FF
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836271; cv=none; b=rZa8gol2z/haCETaAU2Dm/BlliSkuFs3UGB8fCffXrP8gtQRruD8hTEbmTZsDHiryfYLgVHhUUm+Y91WDFySqWWCfxlUYIAaW7/RIufxzXbmP5JkYL0VItZ6u56lZ2/eA7CX+4g1yjdNaZjDbGy1iVGG4u7tskQ8KD/wCrwF/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836271; c=relaxed/simple;
	bh=Ea0US3HwHRZvrtdqbOKfbW0xqo74tbIZ1jL3i2R98hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIrlmJC+NnJC0V2SQzbYaMQmlDiyuXiNz01RX9hLdHBDKe7FXOnvftuhcnF2Cclqpu2qhRU7N2VHEq04kdQ6skXyDScf7hTGAEMVjoMU+WmUeW2hpliWQ+YqxXckGAc0M/gwfLPd9SPGWR7Uqj265DlW9U0oK5Jq3tgQpWN3ykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPh2WuW+; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPh2WuW+"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-45c9fdf2a06so4741454b6e.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836269; x=1771441069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFJ530PP42vpGAJX9Cv86mn3UN5wZhLZcQTGCad2CSo=;
        b=nPh2WuW+Pu4FXrTeaIw01IswsnTUkSE4cEqfOjtUmZfciE0lOh+MZxGpLT/Uan9orp
         e6WDSiyeyjxePp4rgD7C53stSbdZ5gVuRnkI/uzXuc0kNviMKmMpb/Lqh0C59i6hGiV5
         3rNfpAwTSnpH7W2E0UqlZfmxzUK33AE/UYJuqaJY3csRTxM3OXeJJ8IZVntlBJ4BSibE
         ZYM5NFZhtHGVtmJMookRn7V+yxZqHi6ANzJowTsERyET0BWE+zu/y6aiJEsBQyp8Nfs+
         Wetg0QECu3bkFYllttPJj4bCh+esXONuSxkB8gZTUPBsK/FSFsNXATYAqR+MtZr+BKXY
         x7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836269; x=1771441069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFJ530PP42vpGAJX9Cv86mn3UN5wZhLZcQTGCad2CSo=;
        b=Gs9omlTPchml9+8ePlWGURbRKZhtiIrjyhgYYl8pACqeUlyx2iXAivErIXIc5p3N0+
         n5Gh7vQNRj17N+vcZddZayMvTggh21ewu525rI6Qn6hR3WS+veRKLMTHkrTXbMKOkiwm
         0T75qVB1TD4V9dl1Zg+J5cWPe//lakBdSpbUpim6c74PjnTHrTEPJYsxf5yyd3KbpylV
         OmhDGnYWmEyoAXnWtqsYQnr8cAe60RyEijOdUVOOFcWgxJRqrjr6XBZgpfXAK+Nkxn+m
         QDzzOIMa0uZjjBX2YqnFvugSSM17mUwJsYEf0EMi4cOJgIcft1LfUA0yzZCFr5N46p1i
         SblA==
X-Gm-Message-State: AOJu0Yy0lzp3sSVujZgaBaZkK/myocb72N1lba5Dkb8hJklhlU4D7bdo
	4XljBLrt0U1Jg8aEnK0lyaySWTXDWzZ78/EB2Q9DHMob1IuasLjwVJEvE8UWUbws9raAmw==
X-Gm-Gg: AZuq6aIRlrQ29uhzokmkoh8INzipygRJho9MEymsMkHttjaCBOIbWAbHCCAg0FMoi7G
	+E0HzsPGVhQetXrC7Y9LTRziuV1iNi34Y1tmgXtc7fyxDVYx9HNTHpKmlLiqGof7VJbgfcdQaZ5
	yrVAHApTCi9EUXoDZTZrSC5rIKfzE34YuPFND41216qGa9ReCRG5AB3rGFc/vwiINs5uH2Mc8Wc
	ViJkjcVRr+/C5msoQENDYW4c62VriTnzq7zgDpWlAGJttEWqXOgyvE75XURNNuXl2+IbVIom5Ve
	NTo+KSwuyHX0OjSs2OtgFB4m227cdXhkyJdLRtYsUi2sI5tfSML1NWGp8+utBteUPyq/9igXSpN
	SbkSwwKh3cwBCGttLIZeeMNHMUTd4bQgG/QiKlPsKMOnF3ZSA5xKg7TfyzUUMEoLaI59meDtBpY
	+bm1Vv/u7sRx1tBeHdtr5gDbl16l1waZVI7W2OWkuBHn0a
X-Received: by 2002:a05:6808:1449:b0:45f:20f:76e5 with SMTP id 5614622812f47-4637b688771mr177999b6e.14.1770836268933;
        Wed, 11 Feb 2026 10:57:48 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636aee0bd4sm1426984b6e.5.2026.02.11.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:57:48 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf] selftests/bpf: Fix map_kptr grace period wait
Date: Wed, 11 Feb 2026 10:57:47 -0800
Message-ID: <20260211185747.3630539-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6521; h=from:subject; bh=mqnc0q3sbdLrmWUp4TnMa/CXRjJruOFHu5MrX7f3jws=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjNDbzPVtvVr65p6/ptiiw0yrLhMkezEqE7Pvla6o d69hl+uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzQ2wAKCRBM4MiGSL8RymVGEA CK03o+ViQlXxshpgdvu5CoKH+M1zhak3VDN+JBHbgRc2qF32Jwkxv1A4oUA/mJU0oHX9kR1m3H/S5Q Q7msWzKrtWEV0lq1FLjidBCytkWoFa72DW8uWp9v1cH530XEEHlLfXlBCKhuSkqUTSxfGuFyTNpf2m ZZYiFckrOtb0LueJo2fk6h2LLHs6dn6FgFs98S3eIpWpvWTErcs8b5UPYCBoBz9TQ+/9s6WR111uMB JRZQv1GDcSQHmFFvZyuZTdl5jer+0XAOpZaYZCOl+RHW3HLxoITqAntv4XY2YFSPeBoiMgjQnKUco2 yaylOhl6upAEU5GjL25gwhhlHyhrwZ6ZbcUICuiuvi7eZd8D1C2vwQwAKx0RGel00Uj8kfo5nM3gQ1 w8tk+2MQ7f18Krwyq9Sp1dhn6vddiFD4ZLdzH54VAop1wPRXESi2j+TLCQBlVZ9RiTGK2rT1B2Wnlt KH2LdQ6UvfYCFxyKDTHxTycm8zKtbZVf4wg3oz5HkPN6dT5ImHSdslTUJXviej4Z2rszKARblAc4wG 4ZFb0EFW1+1jxP3wieoTfjds/mC2BauGLy+t0htV/fNfMoQV9j3ZlpdVzDZbdJ/EqZzAXdI6+53e+w dpOc7NCf6Aqwcu5Gq1vtyPa+HCHasxf1VWiqvNV+59C9VvMqIqcAecyHhNsQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
broke map_kptr selftest since it removed the function we were kprobing.
Use a new kfunc that invokes call_rcu_tasks_trace and sets a program
provided pointer to an integer to 1. Technically this can be unsafe if
the memory being written to from the callback disappears, but this is
just for usage in a test where we ensure we spin until we see the value
to be set to 1, so it's ok.

Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Fixes: c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       | 15 ++++------
 .../selftests/bpf/progs/rcu_tasks_trace_gp.c  | 30 +++----------------
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 28 +++++++++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index f372162c0280..03b46f17cf53 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -118,15 +118,16 @@ static void test_map_kptr_success(bool test_run)

 static int kern_sync_rcu_tasks_trace(struct rcu_tasks_trace_gp *rcu)
 {
-	long gp_seq = READ_ONCE(rcu->bss->gp_seq);
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int ret;

-	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
-					      &opts), "do_call_rcu_tasks_trace"))
+	WRITE_ONCE(rcu->bss->done, 0);
+	ret = bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.call_rcu_tasks_trace), &opts);
+	if (!ASSERT_OK(ret, "call_rcu_tasks_trace"))
 		return -EFAULT;
-	if (!ASSERT_OK(opts.retval, "opts.retval == 0"))
+	if (!ASSERT_OK(opts.retval, "call_rcu_tasks_trace retval"))
 		return -EFAULT;
-	while (gp_seq == READ_ONCE(rcu->bss->gp_seq))
+	while (!READ_ONCE(rcu->bss->done))
 		sched_yield();
 	return 0;
 }
@@ -159,8 +160,6 @@ void serial_test_map_kptr(void)
 	skel = rcu_tasks_trace_gp__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "rcu_tasks_trace_gp__open_and_load"))
 		return;
-	if (!ASSERT_OK(rcu_tasks_trace_gp__attach(skel), "rcu_tasks_trace_gp__attach"))
-		goto end;

 	if (test__start_subtest("success-map")) {
 		test_map_kptr_success(true);
@@ -180,7 +179,5 @@ void serial_test_map_kptr(void)
 		test_map_kptr_success(true);
 	}

-end:
 	rcu_tasks_trace_gp__destroy(skel);
-	return;
 }
diff --git a/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c b/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c
index df4873558634..189c05c6abcc 100644
--- a/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c
+++ b/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c
@@ -1,36 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "../test_kmods/bpf_testmod_kfunc.h"

-struct task_ls_map {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, int);
-} task_ls_map SEC(".maps");
-
-long gp_seq;
+int done;

 SEC("syscall")
-int do_call_rcu_tasks_trace(void *ctx)
-{
-    struct task_struct *current;
-    int *v;
-
-    current = bpf_get_current_task_btf();
-    v = bpf_task_storage_get(&task_ls_map, current, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
-    if (!v)
-        return 1;
-    /* Invoke call_rcu_tasks_trace */
-    return bpf_task_storage_delete(&task_ls_map, current);
-}
-
-SEC("kprobe/rcu_tasks_trace_postgp")
-int rcu_tasks_trace_postgp(void *ctx)
+int call_rcu_tasks_trace(void *ctx)
 {
-    __sync_add_and_fetch(&gp_seq, 1);
-    return 0;
+	return bpf_kfunc_call_test_call_rcu_tasks_trace(&done);
 }

 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 186a25ab429a..e62c6b78657f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -18,6 +18,7 @@
 #include <linux/in6.h>
 #include <linux/un.h>
 #include <linux/filter.h>
+#include <linux/rcupdate_trace.h>
 #include <net/sock.h>
 #include <linux/namei.h>
 #include "bpf_testmod.h"
@@ -885,6 +886,32 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
 {
 }

+struct bpf_kfunc_rcu_tasks_trace_data {
+	struct rcu_head rcu;
+	int *done;
+};
+
+static void bpf_kfunc_rcu_tasks_trace_cb(struct rcu_head *rhp)
+{
+	struct bpf_kfunc_rcu_tasks_trace_data *data;
+
+	data = container_of(rhp, struct bpf_kfunc_rcu_tasks_trace_data, rcu);
+	WRITE_ONCE(*data->done, 1);
+	kfree(data);
+}
+
+__bpf_kfunc int bpf_kfunc_call_test_call_rcu_tasks_trace(int *done)
+{
+	struct bpf_kfunc_rcu_tasks_trace_data *data;
+
+	data = kmalloc(sizeof(*data), GFP_ATOMIC);
+	if (!data)
+		return -ENOMEM;
+	data->done = done;
+	call_rcu_tasks_trace(&data->rcu, bpf_kfunc_rcu_tasks_trace_cb);
+	return 0;
+}
+
 __bpf_kfunc int bpf_kfunc_init_sock(struct init_sock_args *args)
 {
 	int proto;
@@ -1222,6 +1249,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_call_rcu_tasks_trace)
 BTF_ID_FLAGS(func, bpf_kfunc_init_sock, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_close_sock, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_connect, KF_SLEEPABLE)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index d5c5454e257e..b393bf771131 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -118,6 +118,7 @@ void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;

 void bpf_kfunc_call_test_destructive(void) __ksym;
 void bpf_kfunc_call_test_sleepable(void) __ksym;
+int bpf_kfunc_call_test_call_rcu_tasks_trace(int *done) __ksym;

 void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p);
 struct prog_test_member *bpf_kfunc_call_memb_acquire(void);
--
2.47.3

