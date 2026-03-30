Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA363C345B
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868474; cv=none; b=SBOzOYsn7x2lp+vzKYqFs6jow5gZdY30zgxO52rfR2qU1ykngpIMTnIUljz9haUYxysENTesptbRsLSl/7rILWFFfDK9haAERQswm5tlDiANHkoIjoHA+AkUCtVjDT5DuVK1HTutO7+5tpBKJBd+mP7sleExHKZ3t3MoJAAqaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868474; c=relaxed/simple;
	bh=lqJpTC+I56xQqupGTb+WFFTo6NyZjyNGSBXBDplJRrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjWa/wKcyMf/eerild9X6IjIzQkFWtTgmpjHYbtUBME/3iLTW/W3Nd+yIUgfy9F8E4FFI4PPjW+Vc+gvIOZhml93Jd1hjnDGv5cFveblPxRN2FjWXt/nFMdv2pvfqheF3DPdiDAOyeBSSsSuMwSfORqt/u4tuqC0jwMHbA+GUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF6dYOCa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF6dYOCa"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c739d32b72cso2781316a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868472; x=1775473272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDv4iYg7IyIBFaVAyL6MvTJiVehOKhgwcTE2u0eTsXI=;
        b=PF6dYOCa8H0NwpnDB0tFs112nkF7uNcu+Y7pC/QyytKpkFNXGp43irzbmeTfFYBNCI
         ihwpIbbKRSpV8HXVJF3dI1O8GIdz5wY3pjKKY2a7+PTZBp7q5kgKl5yUpt5p/Q/FcDXo
         vzs1Ox874YbglgWL3AQ2NOLBW06/xszr+8SuhqkVEaMo5rWicp9k0VBzzEE/NKPjBQwz
         psXmR4X3Gtms59t9r0rWhf6rLuN6R3JkGoygmE0E0F05+aUsa5CiKMz7h52Nx+twc89E
         vGS8AK91o3W01dXmYzCTCDPixRMV1jM2NoaHqy8OmY6JCkyKkflyrcHXty3RdzVE4r9K
         0UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868472; x=1775473272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDv4iYg7IyIBFaVAyL6MvTJiVehOKhgwcTE2u0eTsXI=;
        b=X9hKbbCNVO5tw/27BJcFHX5anF4bloWn+/1puJ108AqBbsTZUuEu7h9opjQa8pGuCo
         BQdYs7s3zQAwGLBkleGqoHcNczj/0f7CM9V/OLvEQH1JMVP3Dt6GJ89QMucqJ+GJMGJa
         fQQqWxOqeY0w9HPYnKLn/8g9JahO32Mx/K8w5J71RPKjAc4TLmF4BZHOF/iMi4nQa1ZM
         d8yHhv0LKClvTi4XWby59ZuFwH6eit2wfcnJpU7O7I9iQm6lQfBHElXXk5yJqV0n70fj
         EGDYYC+x4BDImj4H6NWt2uk182Fyid9Rw3kGxAFH50o7+3Q6RNOmWlXI7tg7SteSJoxZ
         ew3g==
X-Forwarded-Encrypted: i=1; AJvYcCX8ck3T+XDOdsvcFIh4e/JmcPk8H+Y63xABKCdXSs2+7dvF7f2som3uTj5jSxiK/0iwuOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSfpVBslPNktdvaH8blJvNM78Hlh/jMV62SOr3a9vlfmrcBFP
	9ivpOWEMJUZWkLp2ahrJdjexZN4VNtza8Mk31p+d+Fexk8fEl4rV5QaV
X-Gm-Gg: ATEYQzyGcWB3H69EEUFrQPXBShydrWR7LzLBwtM8Q9GImE3FM74O1DYeef3LpgMiZik
	5d12jMrv5y22j76ibyiAIcochOhlI5BYollt4zMqvcOb5bMWQxgXqh0TSQDE+Hgvqnqi/hgQXCL
	ekK6O3snHqSkpSLf8Wu00RTyeLahKGIPWcWvAu5lCnENr0frHbZzui1riAkJ/T+3Q5XFzKqAyLp
	ubw76w/vWlRzZjGQA+kevdJC7uOyHwJHpeiErpDRz+PjUo7i1lpbVi2GclxDKx792GsebkQUcpR
	YFklSAjTkgGUKCvqtNs+2PPSBwznzqLWGR8ALOMTvEuVidRuvmJ3b17bqzTofzJ8wc+E+cpgSXS
	Ue8Vens4i2WQQzRjYrFFV2E/XyMaMdcCdFieMlGLq9Z2ej2I/h8SWUCT9c13ZF9VliCVlr+VhGJ
	jJK4DcqP9osURgJmD+uxJEUlFKdmfxxhPR1ZlGsPUD/Vhu4ciIcGP1wt+Q2KMLNk/iCaMdXicas
	1mKIGZdg0K5
X-Received: by 2002:a05:6a20:3ca3:b0:398:a33a:71c9 with SMTP id adf61e73a8af0-39c87ac323amr11533305637.43.1774868471401;
        Mon, 30 Mar 2026 04:01:11 -0700 (PDT)
Received: from eris-fedora.iitr.ac.in ([103.37.201.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917d843esm6806615a12.29.2026.03.30.04.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:01:11 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	alan.maguire@oracle.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	puranjay@kernel.org,
	bjorn@kernel.org,
	leon.hwang@linux.dev,
	varunrmallya@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 3/3] libbpf: Auto-upgrade kprobes to multi-kprobes when supported
Date: Mon, 30 Mar 2026 16:30:19 +0530
Message-ID: <20260330110019.549079-4-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330110019.549079-1-varunrmallya@gmail.com>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
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
 tools/lib/bpf/libbpf.c                        | 61 +++++++++++++++++--
 .../selftests/bpf/progs/get_func_ip_test.c    |  2 +-
 .../selftests/bpf/progs/missed_kprobe.c       |  4 +-
 .../bpf/progs/test_attach_probe_manual.c      |  4 +-
 .../selftests/bpf/progs/test_fill_link_info.c |  2 +-
 5 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bd7b6f486430..9d0a36f8279a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8265,6 +8265,24 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 			}
 		}
 
+		if (kernel_supports(obj, FEAT_KPROBE_MULTI_LINK)) {
+			const char *sec_name = prog->sec_name;
+			/* Here, we filter out for k[ret]probe or "k[ret]probe/"
+			 * but we leave out anything with an '@'
+			 * in it as kprobe_multi does not support versioned
+			 * symbols, so we don't upgrade. Also for '+' as we do not
+			 * support offsets.
+			 */
+			if (((strncmp(sec_name, "kprobe", 6) == 0 &&
+			      (sec_name[6] == '/' || sec_name[6] == '\0')) ||
+			     (strncmp(sec_name, "kretprobe", 9) == 0 &&
+			      (sec_name[9] == '/' || sec_name[9] == '\0'))) &&
+			    !strchr(sec_name, '@') &&
+			    !strchr(sec_name, '+') &&
+			    !(prog->prog_flags & BPF_F_SLEEPABLE))
+				prog->expected_attach_type = BPF_TRACE_KPROBE_MULTI;
+		}
+
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9924,10 +9942,12 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -11769,6 +11789,25 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
+	/* This provides backwards compatibility to programs using kprobe, but
+	 * have been auto-upgraded to multi kprobe.
+	 */
+	if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+	    offset == 0 && attach_mode == PROBE_ATTACH_MODE_DEFAULT) {
+		LIBBPF_OPTS(bpf_kprobe_multi_opts, multi_opts);
+		const char *syms[1] = { func_name };
+		__u64 bpf_cookie;
+
+		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
+		multi_opts.syms = syms;
+		multi_opts.cnt = 1;
+		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+		if (bpf_cookie)
+			multi_opts.cookies = &bpf_cookie;
+
+		return bpf_program__attach_kprobe_multi_opts(prog, NULL, &multi_opts);
+	}
+
 	legacy = determine_kprobe_perf_type() < 0;
 	switch (attach_mode) {
 	case PROBE_ATTACH_MODE_LEGACY:
@@ -12223,14 +12262,24 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
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
2.52.0

