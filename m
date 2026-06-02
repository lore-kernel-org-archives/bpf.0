Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC113090DE
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360892; cv=none; b=CsL8jCu8Tbc4om5r7EWJFR1MgA2sL4A90ztixzs/5zLV0IRd5sGLBs7fjXmfmbZ9TlAQy0SS9jECwg+S1RCNSZkuIuxHJv7qcoxYr9G8PinKLZYOshV2NOFw9GhkOnTWVNSLafJgCMUGMaQaXAWyIPT50ZQif+C57mEF7pRbG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360892; c=relaxed/simple;
	bh=Jhsa1jm36WKPjklvS6ABZ1yq2MWkNk57k0WYgkRR9ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlirVckhRbqHMhHgcrxqt/TtK797vUCLfEhuLmB2gcZAazWNKRAKwruZ7oEZN3fH/f7oxrtgMZZk+n/3V44wwczaE1uHeDl3O80cDYNsUDFSsBvKJVK8PxNs50EiGW85nU6XBln4y6/T3EDwWeGzsHQIiQpX0o9Qx3d97pQzIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QtS6iszt; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QtS6iszt"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304d8e3bb72so7038710eec.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780360890; x=1780965690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlgqHOgRxecDH9jroL+3TyLS3hGeTMGdo7efoKaBOy4=;
        b=QtS6iszt5Cfzq7ljay1a7PxPrp85Y5RSKWjpH8Y8xHevxct+Ksj3vQJeY/K8jZRzrk
         U0wJYlWoUZlL5MSvhEVBwbA7+NlegRv0+btim5w5BP5eJ2UcslLoTG9OYu3GyKfvt2hM
         0EZ/j+igVoLELb2WXaPZ1Nsug2yU9LTZ7JrSSt4xeBe1xdqssB0WrJtGriWePgDjEs8O
         RN8ssXlfuyq2aFonRsOzIR3P8PxVE10BFgfN6CwieJzCY1/Vp8ul1JjyPzofOvL6b6FP
         5X+01OF4D+F3ciSUOMcomAC+PC9rY4C+y4qzDBRlMhj1z6R7RohmNXRy0fAAnDgWTzSF
         MOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780360890; x=1780965690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AlgqHOgRxecDH9jroL+3TyLS3hGeTMGdo7efoKaBOy4=;
        b=fEpjEyGRW2kHxVwYf2IpZcjXOAuGQYMc1NBYcvnP23j47SaiiA/ZExM2DRpXYM7PCo
         +jZu+pTCsc3CLruQuH7hbcXQAPAznBZ7zuBofx0qErKWcv8nEPwjpddgPt8+kcerFk7d
         MLQG6O4bcqYJuPOtDpO7/5zpCbQEHQ43TQhvRYCN4DozPPIt1FGGiYp9o8mGbiEpTrUD
         973JatYYBHdoCUi6DpGv3NxOGl0SvAjjoeTTghZvFtPQFFdEwwbNSgjGMhMLpFKPhcjt
         bmww9PxrGdEdEpNHnoYyaTPfql04PRQvjZZ55aiD6EwNOXJhZMJayWPuAkKPreHNjRUj
         x1oA==
X-Gm-Message-State: AOJu0Yx8hqOY6Hd+NiUSVCDd35Tr+VPyPztj2JbWF3ovpTcb1X050TIq
	Wh53ugb5t0zrQ6kE0mSuCfChSw7gm0mW0s86FAtNEY90oOkmovT4sh61y1Tms21dmb7sh2fXuFS
	WDkNWPvjby2Ic
X-Gm-Gg: Acq92OEi9I3MA8n7jMlbFyq4xWHYeAdciifIfFDI7B81/uy7mSLsdLX6LcTQBHcxPe+
	x533bFsGjqBPqZXDMkrRvxswQ04Z3/OUeE17+SE6LUEODy52kYXh4BVGBPe0gwWtfoIieh4zd0z
	Mfa4I2yhUrgJ8yVvQ6rz7jqwe43wZ+GZ+Y8ruLRpGGwaPA44WyanRczg5g7Bjl9IRmC7NPwI475
	XrF/TyA3Vx6Xx6+pfaViayKvWrkryqJm8jaTNYtdi/75VxnymMtDd9ZMhkRcfv5A/+DPJ2tg8pH
	1bR3mFiOJ5umr/cQa4bhNSan5lj0gw/h7UVFm9xmNAKYqcKEUKdnvbh1jBKWMMjvViskzy1dwl/
	EnaXO/wZI/zRLmqsWNquVAD0DyEQjXYFRQ7lGwRexf3Dje73qviby/v49q6TXcE+Cbdu8Y1WauT
	XFBykFOkaUCs8f0L/gQuXb14ivXmXnLQ==
X-Received: by 2002:a05:693c:8302:b0:307:3aa8:ca46 with SMTP id 5a478bee46e88-3073aa8ccbamr73327eec.3.1780360889775;
        Mon, 01 Jun 2026 17:41:29 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10172018eec.28.2026.06.01.17.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:41:29 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 2/6] verifier: parse BTF type tags for function arguments
Date: Mon,  1 Jun 2026 20:41:16 -0400
Message-ID: <20260602004120.17087-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004120.17087-1-emil@etsalapatis.com>
References: <20260602004120.17087-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BTF parsing logic for function arguments goes through
the arguments' decl tags, but does not go into their type
tags. Add type tag parsing for function arguments.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c | 120 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17d4ab0a8206..c6a930aca67e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7802,6 +7802,84 @@ enum btf_arg_tag {
 	ARG_TAG_ARENA	  = BIT_ULL(5),
 };
 
+static int btf_scan_decl_tags(struct bpf_verifier_env *env,
+			      const struct btf *btf,
+			      const struct btf_type *fn_t,
+			      u32 arg_idx, bool is_global, u32 *tags)
+{
+	int id = btf_named_start_id(btf, false) - 1;
+
+	/*
+	 * The 'arg:<tag>' decl_tag takes precedence over the derivation
+	 * of the register type from the BTF type itself.
+	 */
+	while ((id = btf_find_next_decl_tag(btf, fn_t, arg_idx, "arg:", id)) > 0) {
+		const struct btf_type *tag_t = btf_type_by_id(btf, id);
+		const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
+
+		/* disallow arg tags in static subprogs */
+		if (!is_global) {
+			bpf_log(&env->log,
+				"arg#%d type tag is not supported in static functions\n",
+				arg_idx);
+			return -EOPNOTSUPP;
+		}
+
+		if (strcmp(tag, "ctx") == 0) {
+			*tags |= ARG_TAG_CTX;
+		} else if (strcmp(tag, "trusted") == 0) {
+			*tags |= ARG_TAG_TRUSTED;
+		} else if (strcmp(tag, "untrusted") == 0) {
+			*tags |= ARG_TAG_UNTRUSTED;
+		} else if (strcmp(tag, "nonnull") == 0) {
+			*tags |= ARG_TAG_NONNULL;
+		} else if (strcmp(tag, "nullable") == 0) {
+			*tags |= ARG_TAG_NULLABLE;
+		} else if (strcmp(tag, "arena") == 0) {
+			*tags |= ARG_TAG_ARENA;
+		} else {
+			bpf_log(&env->log, "arg#%d has unsupported set of tags\n", arg_idx);
+			return -EOPNOTSUPP;
+		}
+	}
+	if (id != -ENOENT) {
+		bpf_log(&env->log, "arg#%d type tag fetching failure: %d\n", arg_idx, id);
+		return id;
+	}
+
+	return 0;
+}
+
+static int btf_scan_type_tags(struct bpf_verifier_env *env,
+			      const struct btf *btf, u32 type_id,
+			      u32 *tags)
+{
+	const struct btf_type *t;
+
+	/* Find the first pointer type in the chain. */
+	t = btf_type_skip_modifiers(btf, type_id, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return 0;
+
+	/* We got a pointer, get all associated type tags. */
+	t = btf_type_by_id(btf, t->type);
+	while (t && btf_type_is_type_tag(t)) {
+		const char *tag = __btf_name_by_offset(btf, t->name_off);
+
+		if (strcmp(tag, "arena") == 0) {
+			*tags |= ARG_TAG_ARENA;
+		} else {
+			bpf_log(&env->log, "function signature member has unsupported type tag '%s'\n",
+				tag);
+			return -EOPNOTSUPP;
+		}
+
+		t = btf_type_by_id(btf, t->type);
+	}
+
+	return 0;
+}
+
 /* Process BTF of a function to produce high-level expectation of function
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This information
  * is cached in subprog info for reuse.
@@ -7820,6 +7898,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	struct btf *btf = prog->aux->btf;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t, *fn_t;
+	int err;
 	u32 i, nargs, btf_id;
 	const char *tname;
 
@@ -7903,42 +7982,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	 */
 	for (i = 0; i < nargs; i++) {
 		u32 tags = 0;
-		int id = btf_named_start_id(btf, false) - 1;
-
-		/* 'arg:<tag>' decl_tag takes precedence over derivation of
-		 * register type from BTF type itself
-		 */
-		while ((id = btf_find_next_decl_tag(btf, fn_t, i, "arg:", id)) > 0) {
-			const struct btf_type *tag_t = btf_type_by_id(btf, id);
-			const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
-
-			/* disallow arg tags in static subprogs */
-			if (!is_global) {
-				bpf_log(log, "arg#%d type tag is not supported in static functions\n", i);
-				return -EOPNOTSUPP;
-			}
+		err = btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
+		if (err)
+			return err;
 
-			if (strcmp(tag, "ctx") == 0) {
-				tags |= ARG_TAG_CTX;
-			} else if (strcmp(tag, "trusted") == 0) {
-				tags |= ARG_TAG_TRUSTED;
-			} else if (strcmp(tag, "untrusted") == 0) {
-				tags |= ARG_TAG_UNTRUSTED;
-			} else if (strcmp(tag, "nonnull") == 0) {
-				tags |= ARG_TAG_NONNULL;
-			} else if (strcmp(tag, "nullable") == 0) {
-				tags |= ARG_TAG_NULLABLE;
-			} else if (strcmp(tag, "arena") == 0) {
-				tags |= ARG_TAG_ARENA;
-			} else {
-				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
-				return -EOPNOTSUPP;
-			}
-		}
-		if (id != -ENOENT) {
-			bpf_log(log, "arg#%d type tag fetching failure: %d\n", i, id);
-			return id;
-		}
+		err = btf_scan_type_tags(env, btf, args[i].type, &tags);
+		if (err)
+			return err;
 
 		t = btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
-- 
2.54.0

