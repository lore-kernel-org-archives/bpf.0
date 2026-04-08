Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E103363089
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614458; cv=none; b=U0/lXXbYsDnptmz0WIrPMRFRph1brRCF6eUgu1j+XjROVLH2bdPFiNxIsQHw6piHl8Gty6p0SnP3FKdzR7iIyI9sgpFjJGFtAj7QWNd/ycaCLQ/2UV88X4gUnUk30qxGL8Z42SkiXbbXXET3Wp3oL3o9ZWYSdVg+i89oLiphhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614458; c=relaxed/simple;
	bh=B9PiWuqW3So5/jMPMLOFwsn2nBya0vGvoUHtjNIrL0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kraa1HHr+6uE7PcgmnAW95XD2ESmFH3N4MOM86vQe4ujsSXsbLblRViflbIENv7qbO2WvLKjuQm5gAoCxL1SpvxKBvUOnOX0QP2l6F6hUgNdmE8i4f9TD5AIcII3BmB2m2jO595ZAP3epwNzrKyW4r8+OT5yab+LfOYDVscbPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRg1UuyH; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRg1UuyH"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d7ebe11bffso5006735a34.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614456; x=1776219256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt9fNjbCJJBPGFmXqySKz97TNz/TxsUn/wiV/u55Z3w=;
        b=MRg1UuyHfJQFG5Pr1SABJiU1dvpWIVbJ8BQ5GPz9E7/6qgsk7s2rWnhHeyNp/hhlh8
         wQGygEmOeu1MUvE+IdrOF8jE9ZSdFy7gVerOk3bkeLGJ6TFgCFhXuu5rvGaFsszOh1bK
         Cp1H1ewuYS/GOuJlOWa9eN07Ag+xSp1J6e1+HRW6AK8Ial08V5/Rr1DP4asw2ITK1PHh
         HsBwU8r8RIKQ9YwWNG+jMMzM3Ax+4+QIo1YoylukMl+9Aa6piAaLmEIn6+st4Za+uWGk
         jojCjkLBWOH3EwGKRRORRf80MzN27FTwEDFYmBqwI76eie77PwRCAI1fDOgUSJEGW8BS
         3Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614456; x=1776219256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lt9fNjbCJJBPGFmXqySKz97TNz/TxsUn/wiV/u55Z3w=;
        b=C1uOsw+iqAv2HW6fmZTDm78dcb7gHkIe7Rr+1Fs2AMPlVYW+evYbKFbOb3qQ/6rArp
         USdtIzp3Hs+gcQwPZCZLTDgWenrk5iruXqn/eYEzNahxH5+lry9pEyflaFIFioqvtzHk
         kKjY1vS4Y50xoJRxNEYDJig1RtB8W/OM0Nt21K92uZf0H+ru4IdJ3FmH58c4jNydwWOv
         hmwFnsrkbWdeFQXrY1aVTV0crfg4wvAVqsHc3O9cVfd58hsacEcGUBm36TUE8KD5fr42
         I7jpiR4lP/CzUe+aVeZfQ3ZcHfUyPmGtFSoK5EYbCtMR4R9pcCngD1PmtDGD8iajwurn
         3cSQ==
X-Gm-Message-State: AOJu0YyJnDXnFt3Dsdj1jBXc/PsuMpsrZdciy7oOY1fzzRs1PQzTm+Fu
	0LTOpS+3aIHmUM3Mpcjx0GxkgngvjP7Lv09SuvjFGQKrCsnHbli0PsF8TKIFQBqVjLQ=
X-Gm-Gg: AeBDiev2lfQ8gGsKA/wEMFkRcSYLEeWC4GfHXPt5Crmlsh9jlUhTpwQQn/fjQ1b6Ym2
	i0+WJ960Dy+ZuknTNs9jYnJIaux1ELc1fth/EyTs+J1T/cHSu9bysZLBRPP8+0VRcFuVURmI4Lr
	RqNuOf5bdJhW7Zi149rJCsLNw1/N0N27vTzQAgy2j2Yemzkj4PB50H2ocGS85sF1N9zzNDjKVO+
	9we6dqK/ri4Mh6QtuhJ5IW3uDvsMy6djoFjMSRdkeSmgBE9eyHYD9d0IGXUJA9aohsJnUzyx/Pa
	l3ILyG3xLIrZ8s1hRF2Rk894IaaTNQAArRVxbblqOJIUgEBsNpxvsMUZzPWuzEPjmpoqavtQhDF
	FlOKzwAVuA/aGBpRxxZ2Cc3YV7KdwF9LktnT4CKS34F5SPk7nuGjZnklfUwmle6NvgLbQcBMNXC
	Kn3iLaCfi7jBVXWCpqJGXxCum62LIpjYDlmCyOKxyf861M
X-Received: by 2002:a05:6820:1989:b0:67b:b790:f5d6 with SMTP id 006d021491bc7-6821d83d975mr10347275eaf.15.1775614455658;
        Tue, 07 Apr 2026 19:14:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a8d1d2cfsm10913504eaf.13.2026.04.07.19.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:14 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 6/6] libbpf: Flush verifier warning messages by default
Date: Wed,  8 Apr 2026 04:13:57 +0200
Message-ID: <20260408021359.3786905-7-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
References: <20260408021359.3786905-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6719; h=from:subject; bh=B9PiWuqW3So5/jMPMLOFwsn2nBya0vGvoUHtjNIrL0s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzuOn/il83t/+WNloknHdWeP0TL8L/ucyRNV/HHsQE3vx 7lv/jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEyEK4Xhn9bmD/VCnXo3k7Yv3HUwJX n3WnblefPvWc75euX971XN8/wZ/hkITPp/41NLfvENk6/bbH/cSX67gPHM/GMBIvf7C48rKjEBAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Allow passing a log buffer with log_level = 0, and also set the log
buffer by default when loading a program, so that warnings can be
captured and flushed, such that we can notify users of deprecation
messages from the verifier even if program succeeds in loading.

Use the presence of enum bpf_features member to disable passing log_buf
with log_level = 0 as the verifier will reject the program due to an
invalid attribute. Low-level bpf_prog_load() API is relaxed, and will
continue passing on older kernels as long as callers don't pass log_buf
unconditionally.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf.c             |  5 +--
 tools/lib/bpf/features.c        | 56 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 20 +++++++-----
 tools/lib/bpf/libbpf_internal.h |  2 ++
 4 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5846de364209..01dd8a126ef6 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -315,11 +315,12 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
 
-	if (log_level) {
+	/* Pass log_buf/log_size independently so log_level=0 loads can collect warnings. */
+	if (log_buf) {
 		attr.log_buf = ptr_to_u64(log_buf);
 		attr.log_size = log_size;
-		attr.log_level = log_level;
 	}
+	attr.log_level = log_level;
 
 	fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
 	OPTS_SET(opts, log_true_size, attr.log_true_size);
diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 4f19a0d79b0c..a9091c66ed32 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -208,6 +208,59 @@ static int probe_kern_btf_type_tag(int token_fd)
 					     strs, sizeof(strs), token_fd));
 }
 
+static bool btf_type_has_enum_value(const struct btf *btf, const struct btf_type *t,
+				    const char *value_name)
+{
+	int i, vlen = btf_vlen(t);
+
+	if (btf_is_enum(t)) {
+		const struct btf_enum *e = btf_enum(t);
+
+		for (i = 0; i < vlen; i++, e++) {
+			if (strcmp(btf__name_by_offset(btf, e->name_off), value_name) == 0)
+				return true;
+		}
+	} else if (btf_is_enum64(t)) {
+		const struct btf_enum64 *e = btf_enum64(t);
+
+		for (i = 0; i < vlen; i++, e++) {
+			if (strcmp(btf__name_by_offset(btf, e->name_off), value_name) == 0)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int probe_kern_verifier_warnings(int token_fd)
+{
+	const struct btf_type *t;
+	struct btf *btf;
+	bool found = false;
+	__s32 type_id;
+
+	(void)token_fd;
+
+	btf = btf__load_vmlinux_btf();
+	if (libbpf_get_error(btf))
+		return 0;
+
+	type_id = btf__find_by_name_kind(btf, "bpf_features", BTF_KIND_ENUM);
+	if (type_id < 0)
+		type_id = btf__find_by_name_kind(btf, "bpf_features", BTF_KIND_ENUM64);
+	if (type_id < 0) {
+		btf__free(btf);
+		return 0;
+	}
+
+	t = btf__type_by_id(btf, type_id);
+	if (t)
+		found = btf_type_has_enum_value(btf, t, "BPF_FEAT_VERIFIER_WARNINGS");
+
+	btf__free(btf);
+	return found;
+}
+
 static int probe_kern_array_mmap(int token_fd)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts,
@@ -669,6 +722,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_TYPE_TAG] = {
 		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
 	},
+	[FEAT_VERIFIER_WARNINGS] = {
+		"success-path verifier warnings", probe_kern_verifier_warnings,
+	},
 	[FEAT_MEMCG_ACCOUNT] = {
 		"memcg-based memory accounting", probe_memcg_account,
 	},
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 42bdba4efd0c..ea8ac67fcb3f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7832,10 +7832,13 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
 	const char *prog_name = NULL;
+	const size_t warn_log_buf_size = 4096;
 	size_t log_buf_size = 0;
 	char *log_buf = NULL, *tmp;
 	bool own_log_buf = true;
 	__u32 log_level = prog->log_level;
+	bool want_verifier_warnings = log_level == 0 &&
+		kernel_supports(obj, FEAT_VERIFIER_WARNINGS);
 	int ret, err;
 
 	/* Be more helpful by rejecting programs that can't be validated early
@@ -7912,12 +7915,11 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	}
 
 retry_load:
-	/* if log_level is zero, we don't request logs initially even if
-	 * custom log_buf is specified; if the program load fails, then we'll
-	 * bump log_level to 1 and use either custom log_buf or we'll allocate
-	 * our own and retry the load to get details on what failed
+	/* If supported, pass a buffer with log_level=0 so the kernel can report
+	 * success-path warnings. If the program load fails, retry with
+	 * log_level=1 to get details on what failed.
 	 */
-	if (log_level) {
+	if (log_level || want_verifier_warnings) {
 		if (prog->log_buf) {
 			log_buf = prog->log_buf;
 			log_buf_size = prog->log_size;
@@ -7927,7 +7929,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 			log_buf_size = obj->log_size;
 			own_log_buf = false;
 		} else {
-			log_buf_size = max((size_t)BPF_LOG_BUF_SIZE, log_buf_size * 2);
+			log_buf_size = max(log_level ? (size_t)BPF_LOG_BUF_SIZE : warn_log_buf_size,
+					   log_buf_size * 2);
 			tmp = realloc(log_buf, log_buf_size);
 			if (!tmp) {
 				ret = -ENOMEM;
@@ -7945,7 +7948,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 
 	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
 	if (ret >= 0) {
-		if (log_level && own_log_buf) {
+		if (want_verifier_warnings && log_level == 0 && load_attr.log_true_size) {
+			pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS --\n%s-- END PROG LOAD WARNINGS --\n",
+				prog->name, log_buf);
+		} else if (log_level && own_log_buf) {
 			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
 				 prog->name, log_buf);
 		}
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index cabdaef79098..7c72ade7a179 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -378,6 +378,8 @@ enum kern_feature_id {
 	FEAT_BTF_DECL_TAG,
 	/* BTF_KIND_TYPE_TAG support */
 	FEAT_BTF_TYPE_TAG,
+	/* Kernel supports success-path verifier warnings */
+	FEAT_VERIFIER_WARNINGS,
 	/* memcg-based accounting for BPF maps and progs */
 	FEAT_MEMCG_ACCOUNT,
 	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
-- 
2.52.0

