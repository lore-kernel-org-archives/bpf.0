Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA91428FD
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380151; cv=none; b=Oc3sffrGagcXt0D9IDZtMMXxRXAZRzSN9bgujsQ+o9Rk6veLgGxJcjqgYHtn1Fd82wRWeRglRxjMGx0D2TF90GeXKx7gBMeJOcfxlr44pkg0rW12670t/t8/iJrVhoyGw7xfhdiPzkgQ6A0acyxv6hJRHe/1wLuElJELnzJogto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380151; c=relaxed/simple;
	bh=mvslh4SFAC/ZdAGaXutOtjBsosEfJYNH6cdRUAOORKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAASivn6DS4mApixVzjb01Bzz2P15cFPdRK+zGI1cdsMRQVTmBqHi6jYsdGACz99YvwyHYfAM+tFQ7PWVpBxOxaLDw4kIpoReKdGpStETfW9AtPvVDE9SII78gQvJK7wkqYbMzxmKYiOAdila4IIvSllnUyGMON9QcWu2R7+MDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4a393b699fso140347966b.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380148; x=1711984948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5nDzv3VJ9jhaN5/PKwtL4JM8viNwxHH4cEOJR6xTzs=;
        b=spJeTD76bod7B3Urel3VsSaR7C0ZzfDSX2xkKDVpH1EZHecVlTlmNJZBUDbQXwYgva
         M6s3bQtrSKnM0L71TZx/lmvQKykfIxi+e2TqfYBbAAE51V+s3Ym+2tZDYm1KsHJfSiR/
         yjqqLDVOU7Cplpj7XxvPMwdOY8/R67wv8KWCrbTLd0jwxJ+N+srWS1Yy+t9tA3sM/ntu
         5OHdvJp4QSdMXslRKwl5G6ERMSc3maqP7yvEM1ubUsRfolvJBvn8B3MVDXYiL7nsc15g
         dqOnFtl1gXkrW/MtIFKknTOexOPFmheZtNiWVkJkCwX9PjAthZlzE0pAj27Gmky5nSGd
         reSQ==
X-Gm-Message-State: AOJu0Ywgnb3thpW5JgxiyTlJ0unlB5QXXmM4/z6HQY9QxX6j6QFz0U+r
	WeBOeW71hSeHHiSi1nOa3kILsWzwGuXBI9U7dSL/rwrm1luZe+9oJsNLbzK7QkQ=
X-Google-Smtp-Source: AGHT+IHALKejJ+BJsN2FqUmb6jKKnmeAlvjiE2/bykmBmss3fZ73nEr94RLhCCsRfvLNMAJwQH1ZGQ==
X-Received: by 2002:a17:907:9804:b0:a49:833d:a9ad with SMTP id ji4-20020a170907980400b00a49833da9admr3295117ejc.38.1711380147697;
        Mon, 25 Mar 2024 08:22:27 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::4:e1d0])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090605d700b00a46abaeeb1csm3154351ejt.104.2024.03.25.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:22:27 -0700 (PDT)
From: Mykyta Yatsenko mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpf: improve error message for unsupported helper
Date: Mon, 25 Mar 2024 15:22:10 +0000
Message-ID: <20240325152210.377548-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF verifier emits "unknown func" message when given BPF program type
does not support BPF helper. This message may be confusing for users, as
important context that helper is unknown only to current program type is
not provided.

This patch changes message to "program of this type cannot use helper "
and aligns dependent code in libbpf and tests. Any suggestions on
improving/changing this message are welcome.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c                                     | 4 ++--
 tools/bpf/bpftool/feature.c                               | 3 ++-
 tools/lib/bpf/libbpf_probes.c                             | 6 ++++--
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c       | 2 +-
 .../selftests/bpf/progs/verifier_helper_restricted.c      | 8 ++++----
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca6cacf7b42f..a1a96ba867d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10188,8 +10188,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (env->ops->get_func_proto)
 		fn = env->ops->get_func_proto(func_id, env->prog);
 	if (!fn) {
-		verbose(env, "unknown func %s#%d\n", func_id_name(func_id),
-			func_id);
+		verbose(env, "program of this type cannot use helper %s#%d\n",
+			func_id_name(func_id), func_id);
 		return -EINVAL;
 	}
 
diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 708733b0ea06..c754a428c8c6 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -664,7 +664,8 @@ probe_helper_ifindex(enum bpf_func_id id, enum bpf_prog_type prog_type,
 
 	probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns), buf,
 				sizeof(buf), ifindex);
-	res = !grep(buf, "invalid func ") && !grep(buf, "unknown func ");
+	res = !grep(buf, "invalid func ") && !grep(buf, "unknown func ") &&
+		!grep(buf, "program of this type cannot use helper ");
 
 	switch (get_vendor_id(ifindex)) {
 	case 0x19ee: /* Netronome specific */
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 302188122439..feef28040cdb 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -448,7 +448,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	/* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
 	 * at all, it will emit something like "invalid func unknown#181".
 	 * If BPF verifier recognizes BPF helper but it's not supported for
-	 * given BPF program type, it will emit "unknown func bpf_sys_bpf#166".
+	 * given BPF program type, it will emit "unknown func bpf_sys_bpf#166"
+	 * or "program of this type cannot use helper bpf_sys_bpf#166".
 	 * In both cases, provided combination of BPF program type and BPF
 	 * helper is not supported by the kernel.
 	 * In all other cases, probe_prog_load() above will either succeed (e.g.,
@@ -457,7 +458,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	 * that), or we'll get some more specific BPF verifier error about
 	 * some unsatisfied conditions.
 	 */
-	if (ret == 0 && (strstr(buf, "invalid func ") || strstr(buf, "unknown func ")))
+	if (ret == 0 && (strstr(buf, "invalid func ") || strstr(buf, "unknown func ") ||
+			 strstr(buf, "program of this type cannot use helper ")))
 		return 0;
 	return 1; /* assume supported */
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index a88e6e07e4f5..c646c812a3bf 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -315,7 +315,7 @@ static void test_rel_setsockopt(void)
 	struct bpf_dctcp_release *rel_skel;
 	libbpf_print_fn_t old_print_fn;
 
-	err_str = "unknown func bpf_setsockopt";
+	err_str = "program of this type cannot use helper bpf_setsockopt";
 	found = false;
 
 	old_print_fn = libbpf_set_print(libbpf_debug_print);
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
index 0ede0ccd090c..059aa716e3d0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -30,7 +30,7 @@ struct {
 
 SEC("kprobe")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE")
-__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
 __naked void in_bpf_prog_type_kprobe_1(void)
 {
 	asm volatile ("					\
@@ -44,7 +44,7 @@ __naked void in_bpf_prog_type_kprobe_1(void)
 
 SEC("tracepoint")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_TRACEPOINT")
-__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
 __naked void in_bpf_prog_type_tracepoint_1(void)
 {
 	asm volatile ("					\
@@ -58,7 +58,7 @@ __naked void in_bpf_prog_type_tracepoint_1(void)
 
 SEC("perf_event")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_PERF_EVENT")
-__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
 __naked void bpf_prog_type_perf_event_1(void)
 {
 	asm volatile ("					\
@@ -72,7 +72,7 @@ __naked void bpf_prog_type_perf_event_1(void)
 
 SEC("raw_tracepoint")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
-__failure __msg("unknown func bpf_ktime_get_coarse_ns")
+__failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
 __naked void bpf_prog_type_raw_tracepoint_1(void)
 {
 	asm volatile ("					\
-- 
2.42.0

