Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABC1B4F0A
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532633; cv=none; b=nsRs+zuaAmZDHFqiFMNPxNwPYb/6eKd2LgC0Z0dDYyXKY1AaKRPtPO/zL3vewaIZKYPmnzUNESeBjxgEJYwLCAiUexwadHokFan3yp9IBSpdflZXz7SLMFynMiCwQ8dg+zv2pHFopL5f/p9nLb8AsEBOF0ZdLJUOgUy3aX3gT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532633; c=relaxed/simple;
	bh=4DeF5LD/bFSXRd/ZVsWu7irKhi9iGjHSF9nq2LGFf1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMCinuUSkpSp6FD+v5qDmju4T2bdiDe2j8szDdO46dRFJ5yW3DGhU849nP1dIjUzzFLGBqvhjvCnYahqqOLzM6UJaOr2MPZiVBrt4OWiAvAgCMCg6/iJw0gHvphnZEeHQqTcyCGfJY2OE/+FiYeUy55WrDEs3Tw2gJ8NoFRBGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nArw6/wL; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nArw6/wL"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-471bf5157d7so805080b6e.3
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776532631; x=1777137431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP18WHRY7hIIgdyoqHAN4cd9mBBpSz8B4d8U2qBe8x0=;
        b=nArw6/wL8MoaAt9mAr9KUZr+PT9LWKGb8mrxXm4Az/Hfk6WgFMasVMrfXpZErOXGks
         LhGcBOD8YTfsKZfVT5foSmvpUFdKcyQ5TWCeN1YgmqKiEG2PTKPXL3d6kMfEcX30nAUk
         7elhnQDh/cbiAKU3ukipla4kiX5VlOyZuRXPN7vFCm9Sg3FlhqlAX1cQrcfQb3qa7vVD
         I2AqQpOXNeHU6l5BwRisoGQc5tGePfg5iE4u5G5qVUypAD9OlDbAUAAW9zxP7HduXno7
         3IElerBMBNW2T2NRjrgMhKUaos90e3stChmemPjUs/n/007gkyP9mocPiNAL4e/4MgqD
         4OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532631; x=1777137431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zP18WHRY7hIIgdyoqHAN4cd9mBBpSz8B4d8U2qBe8x0=;
        b=gMraP5u+kNOlHTZL2mkn1kDnfL7rHOGFvlwkUOLRqZeC/Njlkc6AMIvLjylYriulCp
         7T5gGMOw+ZX0y9GyelgY6rFAx7Rgfj4jXn3GRJN0BH7jXcMuRGBcWtM8uYlMtkXK9k06
         KKyl0Ft0ldBXz7GyiBBlSmQtY8kTAFyCtcWUavzD5PK9nzHpr/JzsZ5QPdaZOHjOJIDI
         gRmNp5FKeD7NSTCBalgiW6KOFrWVPTkR+X4xAIZiTcQy38Jwiqtb1a5riqqhhC3yii4Z
         2Mkud48Xz07AfwUqwVHkqpk4EwSOSB1IsXq/YHBbkpH2IztnHsld4OdfkH4Wso4yGJEO
         uLjA==
X-Gm-Message-State: AOJu0YxcMcohu9+D9UNgvgT0iKNAFYQWRA7lg6QQhmREHm8FTnqVAbvI
	twUDpZttpwTUBiXaH5CP1EE8Op43qreYu8x02d35PhhwekFLrIqLJ2+zVFkS6fuBSSiDeQ==
X-Gm-Gg: AeBDiescTIEEcsY1gMGNiuC3sR7FYplqBQWj9KL8osa7DeV6yqoXpMwpax1Kc0Ipk11
	F47/xQcaHMg+o5SXmndMvez+p9FamPIou10P3iVwBiAL5UwOzFoAaHY+2yYglxNj+/xRfe/h4zd
	BArXwntT/lSJaZbW3t+fyBKaOtRmkiTFcqGK7BudgAg5hF5D1yJmOmUn6pWWqwoTNBJKaapn8QQ
	YsOTFIdr4YvIXyQVkCLgHmpdVcyALJtcAj3hbmmwuMabPsCQt1MY2u+87R5f5PCgXngg6OPwFBb
	4ky0mA5GFgZ974ZPYZnSPGxmbr2ZSP6bRk2+2LYQHGrNiBW6qnWcYYyujF1hg469tKSNHIbXvqi
	8TIJ8qpf9ouca6GGjMmlmLg1IXWZAtWGry2Zy+8VIqMrrMkwfYJqj9tCSHns9YPOk3sQb7jmC0d
	+jQ7uu/EMjTAq2P0ZDVc2nLbcNJ4K3NECV+xY9v3WOPAG3g52u2FqOGD81RniQvpvXOLkOxsY/w
	T2kWRyzQbes8K9ltB5JRhpyN4VbwoKVvxKMAbbrUtk=
X-Received: by 2002:a05:6808:19a6:b0:463:cf6b:982a with SMTP id 5614622812f47-4799c9b1d26mr3823950b6e.22.1776532630856;
        Sat, 18 Apr 2026 10:17:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02630a6sm3332722b6e.15.2026.04.18.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:17:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/4] libbpf: Request verifier warnings for object loads
Date: Sat, 18 Apr 2026 19:16:58 +0200
Message-ID: <20260418171701.610025-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418171701.610025-1-memxor@gmail.com>
References: <20260418171701.610025-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7385; h=from:subject; bh=4DeF5LD/bFSXRd/ZVsWu7irKhi9iGjHSF9nq2LGFf1E=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPxnmz/KYyPdm/s4H/mHVjabBnK5Hm8pqPCc73zDNGER5M/ rOPuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET6JzL8z1x6e0GLRs8pt6ei/ruVHk qKxorzqpiyufb5H/zzV8LhJiPDt2K9+NA/y68wXP7s51y631Nl2dX0V+xN60+eVItZLl/ECAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

On kernels supporting BPF_LOG_LEVEL_WARN, have libbpf request verifier
warnings for BPF object program loads by ORing in the warning bit.  This
keeps the existing log_level=0 retry semantics for verbose logs, while
still surfacing verifier warnings for successful loads.

When libbpf owns the log buffer, use a small buffer for warning-only
loads and flush captured warnings through the print callback. Detect
support by probing for BPF_FEAT_VERIFIER_WARNINGS in enum bpf_features,
and document the updated kernel_log_level behavior.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/features.c        | 56 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 25 ++++++++++-----
 tools/lib/bpf/libbpf.h          |  7 +++--
 tools/lib/bpf/libbpf_internal.h |  2 ++
 4 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 4f19a0d79b0c..78f07866db12 100644
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
+		"BPF_LOG_LEVEL_WARN verifier warnings", probe_kern_verifier_warnings,
+	},
 	[FEAT_MEMCG_ACCOUNT] = {
 		"memcg-based memory accounting", probe_memcg_account,
 	},
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a80a018fc7d..c7b00c097698 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7841,12 +7841,17 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
 	const char *prog_name = NULL;
+	const size_t warn_log_buf_size = 4096;
 	size_t log_buf_size = 0;
 	char *log_buf = NULL, *tmp;
 	bool own_log_buf = true;
 	__u32 log_level = prog->log_level;
+	bool supports_verifier_warnings = kernel_supports(obj, FEAT_VERIFIER_WARNINGS);
 	int ret, err;
 
+	if (supports_verifier_warnings)
+		log_level |= 16;
+
 	/* Be more helpful by rejecting programs that can't be validated early
 	 * with more meaningful and actionable error message.
 	 */
@@ -7921,10 +7926,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	}
 
 retry_load:
-	/* if log_level is zero, we don't request logs initially even if
-	 * custom log_buf is specified; if the program load fails, then we'll
-	 * bump log_level to 1 and use either custom log_buf or we'll allocate
-	 * our own and retry the load to get details on what failed
+	/* If verifier warning logging is supported, we can request warnings
+	 * even without verbose logging. If the program load fails, retry with
+	 * log_level=1 to get details on what failed.
 	 */
 	if (log_level) {
 		if (prog->log_buf) {
@@ -7936,7 +7940,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 			log_buf_size = obj->log_size;
 			own_log_buf = false;
 		} else {
-			log_buf_size = max((size_t)BPF_LOG_BUF_SIZE, log_buf_size * 2);
+			log_buf_size = max(log_level == 16 ? warn_log_buf_size :
+					   (size_t)BPF_LOG_BUF_SIZE,
+					   log_buf_size * 2);
 			tmp = realloc(log_buf, log_buf_size);
 			if (!tmp) {
 				ret = -ENOMEM;
@@ -7954,7 +7960,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 
 	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
 	if (ret >= 0) {
-		if (log_level && own_log_buf) {
+		if (log_level == 16 && load_attr.log_true_size && own_log_buf) {
+			pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS --\n%s-- END PROG LOAD WARNINGS --\n",
+				prog->name, log_buf);
+		} else if (log_level && own_log_buf) {
 			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
 				 prog->name, log_buf);
 		}
@@ -7981,8 +7990,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		goto out;
 	}
 
-	if (log_level == 0) {
-		log_level = 1;
+	if (log_level == (supports_verifier_warnings ? 16 : 0)) {
+		log_level = 1 | (supports_verifier_warnings ? 16 : 0);
 		goto retry_load;
 	}
 	/* On ENOSPC, increase log buffer size and retry, unless custom
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index bba4e8464396..598c6daa822b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -194,8 +194,11 @@ struct bpf_object_open_opts {
 	/*
 	 * Log level can be set independently from log buffer. Log_level=0
 	 * means that libbpf will attempt loading BTF or program without any
-	 * logging requested, but will retry with either its own or custom log
-	 * buffer, if provided, and log_level=1 on any error.
+	 * verbose logging requested, but will retry with either its own or
+	 * custom log buffer, if provided, and log_level=1 on any error. On
+	 * kernels supporting verifier warning logging, libbpf will also
+	 * request warning messages for successful program loads by default
+	 * when log_level=0.
 	 * And vice versa, setting log_level>0 will request BTF or prog
 	 * loading with verbose log from the first attempt (and as such also
 	 * for successfully loaded BTF or program), and the actual log buffer
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 3781c45b46d3..b2460982d6ca 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -378,6 +378,8 @@ enum kern_feature_id {
 	FEAT_BTF_DECL_TAG,
 	/* BTF_KIND_TYPE_TAG support */
 	FEAT_BTF_TYPE_TAG,
+	/* Kernel supports BPF_LOG_LEVEL_WARN for verifier warnings */
+	FEAT_VERIFIER_WARNINGS,
 	/* memcg-based accounting for BPF maps and progs */
 	FEAT_MEMCG_ACCOUNT,
 	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
-- 
2.52.0

