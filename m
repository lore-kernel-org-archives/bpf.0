Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E533624CB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220305; cv=none; b=r2eTsvs1l7VIMupy25UtDVRq54zn/2KT9EynvL/j6exs8kspgSGXn88qRVCSGBbGdjUOMmiU3F/ctmKAg5N38VexMxRFKEW3tZ4s6l/4GY4xlLBuVD+K87oF0wt/BvENcP7uHwvvPO3OFqehxEwHIpHan/LzpS4USRy4uopT9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220305; c=relaxed/simple;
	bh=kx4MYKFC9pSH4XNzLsm5hYeABYrOiRUbsSb3ezia37c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBW9W7PWpOnXgr+1ewbMbg78gLd0zYoS/HSy9DF6BV+cRwwq83K2/AV0C0G4eaHcdYQqpIS83USK8l2+74jElw3nzuVxR5J3k6FWP0NZqxW6NRVh9sZsVuxCiHnz/QfBaSF13eS7ZOps8SJTxLko0c/tnt+Ry9/b8XPZhHlDZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXTC91eT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXTC91eT"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1624621a91.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775220301; x=1775825101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Wqfe47DlwB0zJX6L4/75rgnipcNLNutDMkaLQLf/EM=;
        b=YXTC91eTE6dTX8FFOkDmPdts5i/tm5ekv7D0joMQ1S+HhuzWCrd2RNj6FBgu9ZuX4T
         Psx6mT/RNP6aoVBWFSvgA5STLjYUtlye1nPgnPVVKl3on6K6F28zLeOC6z1gEkOunBpX
         ELbCjgL9NGXbU4qfnp2Tqghg+ir4x9tLZ5iyVTdpjO6ev3fFO2X7iW5ZYDNtOvSHmTLa
         z+6snk1pWCW7dDsqjC1+jE84rTEZ21pSsN9XfQPILQTx4W/L41Hix0/ngm9YmsJOfbEt
         REBPdGxloj/mdOUmqhqWeahrN1FgdyJJCHinuypBEJqjcfRB3KQNe7pBVtkIPLjgZg2H
         K3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775220301; x=1775825101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Wqfe47DlwB0zJX6L4/75rgnipcNLNutDMkaLQLf/EM=;
        b=gWoTWi7XMEqwI+PVigdeDkYnrUgH6I5KTRsUNAGpNERheNPhMahB8jcP1RZdL9uKzo
         Vg3/Jxa+yzzrLoWqVTcPMd+FLCX8FsL2BAtFin7IrAt1ahYpJtftdHwT1cPXdEHYbf/v
         aT9iBxrzmwqoUkEoZGKGju/jeGMSf/saAAYUfqSa3DFqyFr1SnJeu3YQJ9xqcF0uZkce
         md9dnKqze0yAhtqRtPMFpCnelzGxQT6enbDyLGk+ycIFJyoeaYTj1TuIWxh9moKsHXUS
         NbYPxKzh1r9Cn2vwGMRlRnfbQrUs/oP3y976pYvi/oK2bSdEEqW33HZ1Z6uZJ8CBvaT7
         5Anw==
X-Gm-Message-State: AOJu0Yx+EmckZD3yt1H4ORAyF6YZLYCz6OalPKLguGQ93SyvttH6IqSy
	fGpcPOBzND31WeBUqQuwjqUkPSEgNjeoc9zsxef/tnj25t9742CsCYGXiof6pZKjcmE=
X-Gm-Gg: AeBDietJkfwq/2mEdmvX0/XaNgR13c72/5XUZu8GwJlAfbpDSimes1E8CtIzFWJWE7l
	MXEbHeBjNqJFG1iSQdWDnuB8p9ZPRVQcMzBXOujGOMpMS9E7ftNo7b2kz0eOPHS9adAdXdFJJSM
	yyVjeifg5tp/d/8+TjuOHV/dTqHIyMYT2N1KmCrTelEz7JqAWb7xJeofZrILb4qKdM//kVV9+ty
	b+XqWilMNaxNxlz01Bd9WpPpCnC2BGV3ptheBzWwYbcFfhfczzp0UjzL+7PV0uVwWAG7cKoaSJU
	yy6G7uk+gLd3c/rVeIObGYb55gVMzIy//z1CzNJs4Yn2E/OYFLoz8bzVirNotseF/X9i5MaxyDr
	nZlFkS2nuMZ0pUXzfgzgLZQTVC0CSYypITnCmFrZUqGd2OvCx8hhpYPzI5Tk9KXl3I/PtojQH4R
	SUGL7xJNE9WeLNqaJXU4GOlu6VmAbvySyJ9IhWTTioWeB+4xAhMPOcLUS+bgmqXe3mbWVM
X-Received: by 2002:a17:90b:3f4d:b0:35b:e519:213b with SMTP id 98e67ed59e1d1-35de69c3c0bmr2508779a91.30.1775220300938;
        Fri, 03 Apr 2026 05:45:00 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f52c8sm5463525a91.5.2026.04.03.05.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:45:00 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	menglong8.dong@gmail.com,
	varunrmallya@gmail.com
Subject: [RFC PATCH bpf-next v3 3/3] libbpf: Auto-upgrade kprobes to multi-kprobes when supported
Date: Fri,  3 Apr 2026 18:14:12 +0530
Message-ID: <20260403124412.37449-4-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403124412.37449-1-varunrmallya@gmail.com>
References: <20260403124412.37449-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch modifies libbpf to automatically upgrade standard
SEC("kprobe") and SEC("kretprobe") programs to use the multi-kprobe
infrastructure (BPF_TRACE_KPROBE_MULTI) at load time if the kernel
supports it, making them compatible with BPF tokens.

To maintain backward compatibility and handle cases where singular
kprobes are required, new SEC("kprobe.single") and SEC("kretprobe.single")
section types are introduced. These force libbpf to use the legacy
perf_event_open() attachment path.

The following explain the reasoning for changing selftests:
- test_fill_link_info.c kprobe→kprobe.single:
  this test calls bpf_link_get_info_by_fd and asserts
  BPF_LINK_TYPE_PERF_EVENT and it explicitly needs the perf_event
  attachment path, which breaks after auto-upgrade to multi.

- test_attach_probe_manual.c kprobe→kprobe.single,
  kretprobe→kretprobe.single:
  this test exercises all four explicit attachment modes
  (default, legacy, perf, link) and PROBE_ATTACH_MODE_LINK
  creates a perf_event BPF link which the kernel rejects
  for a prog loaded with expected_attach_type = BPF_TRACE_KPROBE_MULTI.

- missed_kprobe.c kprobe->kprobe.single:
  The link is explicitly checked in the tests due to which it fails if
  we do not specifically kprobe.single this.

- get_func_ip_test.c ?kprobe→?kprobe.single: the ? is stripped from
  sec_name by libbpf at init time so the prog still gets auto-upgraded.
  It is then manually attached with a non-zero body offset,
  which kprobe_multi doesn't support.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/lib/bpf/libbpf.c                        | 104 ++++++++++++++----
 .../selftests/bpf/progs/get_func_ip_test.c    |   2 +-
 .../selftests/bpf/progs/missed_kprobe.c       |   4 +-
 .../bpf/progs/test_attach_probe_manual.c      |   4 +-
 .../selftests/bpf/progs/test_fill_link_info.c |   2 +-
 5 files changed, 88 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f56bdc243eb..7c6680759b0a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8286,6 +8286,43 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 	return 0;
 }
 
+/* This function is responsible for upgrading uprobes and kprobes
+ * to their multi counterparts.
+ */
+static int upgrade_program(struct bpf_object *obj, struct bpf_program *prog)
+{
+	const char *sec_name = prog->sec_name;
+
+	if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {
+		/* Here, we filter out for u[ret]probe or "u[ret]probe/"
+		 * but we leave out anything with an '@'
+		 * in it as uprobe_multi does not support versioned
+		 * symbols yet, so we don't upgrade.
+		 */
+		if ((strcmp(sec_name, "uprobe") == 0 ||
+		     str_has_pfx(sec_name, "uprobe/") ||
+		     strcmp(sec_name, "uretprobe") == 0 ||
+		     str_has_pfx(sec_name, "uretprobe/")) &&
+		    !strchr(sec_name, '@'))
+			prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+	}
+
+	if (kernel_supports(obj, FEAT_KPROBE_MULTI_LINK)) {
+		/* Here, we filter out for k[ret]probe or "k[ret]probe/".
+		 * We also do not allow '+' as we do not support
+		 * offsets in kprobe_multi.
+		 */
+		if ((strcmp(sec_name, "kprobe") == 0 ||
+		     str_has_pfx(sec_name, "kprobe/") ||
+		     strcmp(sec_name, "kretprobe") == 0 ||
+		     str_has_pfx(sec_name, "kretprobe/")) &&
+		    !strchr(sec_name, '+'))
+			prog->expected_attach_type = BPF_TRACE_KPROBE_MULTI;
+	}
+
+	return 0;
+}
+
 static int bpf_object_prepare_progs(struct bpf_object *obj)
 {
 	struct bpf_program *prog;
@@ -8294,22 +8331,9 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
-
-		if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {
-			const char *sec_name = prog->sec_name;
-			/* Here, we filter out for u[ret]probe or "u[ret]probe/"
-			 * but we leave out anything with an '@'
-			 * in it as uprobe_multi does not support versioned
-			 * symbols yet, so we don't upgrade.
-			 */
-			if ((strcmp(sec_name, "uprobe") == 0 ||
-			     str_has_pfx(sec_name, "uprobe/") ||
-			     strcmp(sec_name, "uretprobe") == 0 ||
-			     str_has_pfx(sec_name, "uretprobe/")) &&
-			    !strchr(sec_name, '@'))
-				prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
-		}
-
+		err = upgrade_program(obj, prog);
+		if (err)
+			return err;
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9969,10 +9993,12 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
+	SEC_DEF("kprobe.single+",	KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
+	SEC_DEF("kretprobe.single+",	KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
@@ -11814,6 +11840,30 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
+	/* This provides backwards compatibility to programs using kprobe, but
+	 * have been auto-upgraded to multi kprobe.
+	 */
+	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {
+		LIBBPF_OPTS(bpf_kprobe_multi_opts, multi_opts);
+		__u64 bpf_cookie;
+
+		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
+		multi_opts.syms = &func_name;
+		multi_opts.cnt = 1;
+		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+		if (bpf_cookie)
+			multi_opts.cookies = &bpf_cookie;
+
+		return bpf_program__attach_kprobe_multi_opts(prog, NULL, &multi_opts);
+	}
+
+	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI) {
+		pr_warn("prog '%s': multi-kprobe upgrade failed (off=%lu, mode=%d); use SEC(\"kprobe.single\")\n",
+			prog->name, offset, attach_mode);
+		return libbpf_err_ptr(-ENOTSUP);
+	}
+
 	legacy = determine_kprobe_perf_type() < 0;
 	switch (attach_mode) {
 	case PROBE_ATTACH_MODE_LEGACY:
@@ -12268,14 +12318,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 	*link = NULL;
 
 	/* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
-	if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
+	if (strcmp(prog->sec_name, "kprobe") == 0 ||
+	    strcmp(prog->sec_name, "kretprobe") == 0 ||
+	    strcmp(prog->sec_name, "kprobe.single") == 0 ||
+	    strcmp(prog->sec_name, "kretprobe.single") == 0)
 		return 0;
 
-	opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
-	if (opts.retprobe)
-		func_name = prog->sec_name + sizeof("kretprobe/") - 1;
-	else
-		func_name = prog->sec_name + sizeof("kprobe/") - 1;
+	if (str_has_pfx(prog->sec_name, "kretprobe/") ||
+	    str_has_pfx(prog->sec_name, "kretprobe.single/")) {
+		opts.retprobe = true;
+		func_name = str_has_pfx(prog->sec_name, "kretprobe/")
+			    ? prog->sec_name + sizeof("kretprobe/") - 1
+			    : prog->sec_name + sizeof("kretprobe.single/") - 1;
+	} else {
+		opts.retprobe = false;
+		func_name = str_has_pfx(prog->sec_name, "kprobe.single/")
+			    ? prog->sec_name + sizeof("kprobe.single/") - 1
+			    : prog->sec_name + sizeof("kprobe/") - 1;
+	}
 
 	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..a039760b8516 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -73,7 +73,7 @@ int BPF_PROG(test5, int a, int *b, int ret)
 }
 
 __u64 test6_result = 0;
-SEC("?kprobe")
+SEC("?kprobe.single")
 int test6(struct pt_regs *ctx)
 {
 	__u64 addr = bpf_get_func_ip(ctx);
diff --git a/tools/testing/selftests/bpf/progs/missed_kprobe.c b/tools/testing/selftests/bpf/progs/missed_kprobe.c
index 51a4fe64c917..5f405888ed0b 100644
--- a/tools/testing/selftests/bpf/progs/missed_kprobe.c
+++ b/tools/testing/selftests/bpf/progs/missed_kprobe.c
@@ -16,14 +16,14 @@ int BPF_PROG(trigger)
 	return 0;
 }
 
-SEC("kprobe/bpf_fentry_test1")
+SEC("kprobe.single/bpf_fentry_test1")
 int test1(struct pt_regs *ctx)
 {
 	bpf_kfunc_common_test();
 	return 0;
 }
 
-SEC("kprobe/bpf_kfunc_common_test")
+SEC("kprobe.single/bpf_kfunc_common_test")
 int test2(struct pt_regs *ctx)
 {
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c b/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c
index 7f08bce94596..eb0fa3b39c5f 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe_manual.c
@@ -14,14 +14,14 @@ int uretprobe_res = 0;
 int uprobe_byname_res = 0;
 void *user_ptr = 0;
 
-SEC("kprobe")
+SEC("kprobe.single")
 int handle_kprobe(struct pt_regs *ctx)
 {
 	kprobe_res = 1;
 	return 0;
 }
 
-SEC("kretprobe")
+SEC("kretprobe.single")
 int handle_kretprobe(struct pt_regs *ctx)
 {
 	kretprobe_res = 2;
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 8e47a818462f..bc6cfed71fb8 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -22,7 +22,7 @@ int unused(void)
 			CONFIG_PPC64 ? 0 : 1;
 }
 
-SEC("kprobe")
+SEC("kprobe.single")
 int BPF_PROG(kprobe_run)
 {
 	return 0;
-- 
2.53.0

