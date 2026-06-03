Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5D38F942
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517909; cv=none; b=iRrpMLS5xb9FneQzZhROFfSiyfQJ9oaePCTOQ8OhbTfq7+6BjF8oWhZu3LYqzP57jWe3h3B4ctBXaPi2qLSOYKMrmc4X7zqOvEwX4IOYMe2aSM86UxTZVxzomSVVa8lxH4eUFWeh2HZ3lFUgnVGYdGThWG2ckiGHfZmvjvxjVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517909; c=relaxed/simple;
	bh=xgytlGXhusZGA3N7WTFBsuzdq7Xm4VDSRwDPt3Oydq8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ceTLy2BQxRovlBOkwYozFRfDkr2QD3f0dpDUVWPuuzHuW28V+6A6hFyKMxdr3cCq/8cWYg52UGa56rDtUY6tLVFSAjMtFjMA0x12ZtOlw4Ies55wpGaU4aT++lvOosSNSbzwY8d23tvjA8J2hKpU9QOm+9dNt4aUoxh8qX7MWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnS5rEES; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnS5rEES"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-bebacba844bso339643466b.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780517906; x=1781122706; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfN7PD8iFeHxSeJMrIAzcOBS7mbEvDYz55+eWid8ZDo=;
        b=EnS5rEESzuEFJH+lobaWMrqpfCftL+EvYNwT3Ty5K964BsKy42hFLKWhFMcM6FLXjh
         O9VlxmQ8OmUMZXC6jzP+YIbUwt1RpknC7e/v1nfvCiRlSsIPh6w4oJDjK4J17rr2K1SZ
         vtwX9eF89l5Shvhe+2sfRnr1cibNFi476QWbzjBcM9uJsr1qV2zJcbQ4IUM3yP1ziop8
         ObkYzcS/EDmpR7JyLUHz1vceJ01RrEl8N9dctdWgsl18aNd1MZCDBdwZUvLMiI17egd4
         wjE2A1Iorbo3+Pr04765hEn8xVHU49uIMwp/Hd4IY/AfJ3Tyi2ztcnOIDuqkIAmI+4Ra
         euBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780517906; x=1781122706;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfN7PD8iFeHxSeJMrIAzcOBS7mbEvDYz55+eWid8ZDo=;
        b=bIjHgOaKtxk3ZFBZcPkM6WR/HwV/s5DIFKqQQdIXLKSvc1gGC95X0pXP6hVaDICh5G
         mzOFJ4Dia5ReamCBacaGQ0PhCVAJrbC1fqAT2Yb3Vn1dXj6dGgT9btwtBzED59Li2V+m
         VsW/OuTjv6LxAxcaMlIkrq6PB5qTolqqekGcA9JbVsr4xE5q03g6muPvGOQtSud2zOZl
         Go8raxv6kIzoF4F90DbLyJkEAlS9vQZWmEKwD5V/neTPw6cQ0+gO/ROvolejnwAuxnfs
         VijgUEwVzfKcN8V551O1I+odxIrR1v3dU5p/Lt9J7eNeCkA4lW3AESY/lv4PVdNcW9rZ
         i50Q==
X-Gm-Message-State: AOJu0YyOAOtnYXD0tKRzhFgrhxc+JS1I7P56z9Hvfjn2est9TJqeQbdk
	bUFLg/jETuB5No5N8fhCvvg/26AvoxHh+cPQOQ6jSLbuXQnsZFJx9u/gg8nevZe/LTvDS0LHbHh
	Fcd+Q3MQDETZCVRway1874fUeffagygiKuP42lXIgSZp/srAoP8ta1e5heBBlKSP4otDsrxaY75
	hXkYG4KVwbJygmOXklfvYDRc9h84DuGVGVDEO7tqJbhPkKVIcWodphlpHsUOy9cr9GTSbPHg==
X-Received: from ejbcb18.prod.google.com ([2002:a17:906:a452:b0:bcc:37d4:e0d2])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:398c:b0:bf0:59a2:4ccc with SMTP id a640c23a62f3a-bf0ac40a9ddmr239323566b.3.1780517905806;
 Wed, 03 Jun 2026 13:18:25 -0700 (PDT)
Date: Wed,  3 Jun 2026 20:18:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260603201822.770596-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] bpf: clean up btf_scan_decl_tags()
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor the newly introduced btf_scan_decl_tags() to improve
readability and maintainability. The current implementation uses a
manual if-else chain and a magic number offset to strip the "arg:"
prefix from declaration tags.

Replace the if-else logic with a table-driven approach using a static
const array. This separates the tag data from the scanning logic, making
the helper more extensible for future tags. Additionally, replace the
magic number '4' with a sizeof-based calculation on the prefix string to
ensure the offset remains synchronized with the search key.

Finally, optimize the loop by moving the is_global check to the top of
the block. This allows the verifier to fail-fast on static subprograms
without performing unnecessary BTF string and type lookups.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/btf.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 68921d9172b5..55aa3ba1b1e0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7808,14 +7808,28 @@ static int btf_scan_decl_tags(struct bpf_verifier_env *env,
 			      u32 arg_idx, bool is_global, u32 *tags)
 {
 	int id = btf_named_start_id(btf, false) - 1;
+	const char tag_key[] = "arg:";
+	static const struct {
+		const char *tag_value;
+		enum btf_arg_tag arg_tag;
+	} tag_values[] = {
+		{ "ctx", ARG_TAG_CTX },
+		{ "trusted", ARG_TAG_TRUSTED },
+		{ "untrusted", ARG_TAG_UNTRUSTED },
+		{ "nonnull", ARG_TAG_NONNULL },
+		{ "nullable", ARG_TAG_NULLABLE },
+		{ "arena", ARG_TAG_ARENA },
+	};
 
 	/*
 	 * The 'arg:<tag>' decl_tag takes precedence over the derivation
 	 * of the register type from the BTF type itself.
 	 */
-	while ((id = btf_find_next_decl_tag(btf, fn_t, arg_idx, "arg:", id)) > 0) {
-		const struct btf_type *tag_t = btf_type_by_id(btf, id);
-		const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
+	while ((id = btf_find_next_decl_tag(btf, fn_t, arg_idx, tag_key, id)) > 0) {
+		const struct btf_type *tag_t;
+		const char *tag;
+		int i;
+		bool found;
 
 		/* disallow arg tags in static subprogs */
 		if (!is_global) {
@@ -7825,19 +7839,19 @@ static int btf_scan_decl_tags(struct bpf_verifier_env *env,
 			return -EOPNOTSUPP;
 		}
 
-		if (strcmp(tag, "ctx") == 0) {
-			*tags |= ARG_TAG_CTX;
-		} else if (strcmp(tag, "trusted") == 0) {
-			*tags |= ARG_TAG_TRUSTED;
-		} else if (strcmp(tag, "untrusted") == 0) {
-			*tags |= ARG_TAG_UNTRUSTED;
-		} else if (strcmp(tag, "nonnull") == 0) {
-			*tags |= ARG_TAG_NONNULL;
-		} else if (strcmp(tag, "nullable") == 0) {
-			*tags |= ARG_TAG_NULLABLE;
-		} else if (strcmp(tag, "arena") == 0) {
-			*tags |= ARG_TAG_ARENA;
-		} else {
+		tag_t = btf_type_by_id(btf, id);
+		tag = __btf_name_by_offset(btf, tag_t->name_off) + (sizeof(tag_key) - 1);
+
+		found = false;
+		for (i = 0; i < ARRAY_SIZE(tag_values); ++i) {
+			if (!strcmp(tag, tag_values[i].tag_value)) {
+				*tags |= tag_values[i].arg_tag;
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
 			bpf_log(&env->log, "arg#%d has unsupported set of tags\n", arg_idx);
 			return -EOPNOTSUPP;
 		}
-- 
2.54.0.1032.g2f8565e1d1-goog

