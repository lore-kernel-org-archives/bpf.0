Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21730AAA6
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866110; cv=none; b=LD/wH/hpSmbEYh6FWbUeUGL3fgJMJFmwxaBQypP7tOv3ig+9jH1POYGEiXB+ukbRRLt6knBYW4zcmA/ScEP75E7uMW2gvEknjToPTvzPpdkds2P86CZGtQWvxUF9wCOLXnb/PZ7D3xaeMOinHPBgUpTN3mwqCR95SUEk8/LE5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866110; c=relaxed/simple;
	bh=Lx4c9V5/QvYf/N2reFs933ZtfUWinQFdNJ/WSKGCf7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRUlSA89JBwdHXawd0giML0CGYAlm27JRJldKLu2ICbuZnzaXqWIQruGCUvw+IaUKePamWAC3DVGEDMSoPioCvjEz6ixqxF1tSk3d6kcrfj0EouLMKBb/Yfq5CtvJMwYbqJbUCB7rvlS2RgfvaEaECyJkxcBM1PLHYF78N3nrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=SBkkPbaO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="SBkkPbaO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bccb978bd9so69985225ad.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779866108; x=1780470908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm4vR0bSmWs0T1cZkadLVTgEEdKxDPIOmjQ7Aijkq3E=;
        b=SBkkPbaOnGDPkW0h+C6+tbdQHWmuEK1+X+cZbn+rBysd/96zEtA9s7iDmCHlmuU3nz
         fL2pVxK9W+68kkOsKJc+VFzKoSDQPBr90PheMb8fqJIeEAMDxZwpn6gmmN6HMb59vOb/
         9F84FGlr9JuxyHj6D/D8Ucq1AlJ2AdFRhTpvfzhQShOtM83FQnR9PpKQA/bUjpORgBjs
         5XuKept/QM6k0OOq8wA8gAB78XEpj/juYbgRrYdq/BOtAHO7UHsQ7CdqtXBUvVRsXdkA
         F7PDCCB5Qjt0aGY68F4bXyHgJfYAeAiVGUNX62AagI9NzeAqK8aCiHXEdrWBi8Ez0VW8
         8DXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866108; x=1780470908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vm4vR0bSmWs0T1cZkadLVTgEEdKxDPIOmjQ7Aijkq3E=;
        b=PAxw8ARLVT9WOM7tyt1mI3e8IMVjXlLmE1ZFGWrV7YJL31LVEWz57EvAWC5GhPE1Sn
         MMJplVQ0vmRCHJSgSgzfDVIDLrBJOaWzr+Ra1olErNRRgp/s2DJ2+sGY7QBZIJd7exoa
         aL7Xa4irVcyQeRUToz8E/fKncy+Y0NMZRurV+8b/6hMC4weCMh3GQtbz7gXxiUrcKxGC
         K5hFxRfbSESOFI3gxtK7IOwCzQ+SKEPixeJWk7B2jQKmhIWQJudEQoiPi4IMG3UR40pp
         cVMk0nZVGT6UVUje3Avy+Ih937bYwGGHNeT3V9I4HqV7b7k67Xd+wTMXhc/n9NbwmwmJ
         fwJA==
X-Gm-Message-State: AOJu0YzpIYiyxyIqhenD2xJCvzaPqPncz+AK11/JB2ngxvInomhEBu7R
	XRF7K+swMRLQ4ArIVAsioCU8UUL5XLZX/VBBQKR/bv1i2evc83Tc4r2ttYpKb5Ez02oFqIvxrtr
	GxxgIrSoJsQ==
X-Gm-Gg: Acq92OHzyqg33zziRLowCAE8in+/xkmFdpfsXWgOAz9xkxqNTvEmB9jn9fJb5nqJlNU
	S6QsW2XR2GH2g0uyd9B8o07elXWNoXRkhqi7RRhGZxaDO8OKBK9HSJdFa89eERoPTE4CZOpzSZg
	Xoyvh5Ef4YCtV6pMNxDkVKsijO73TA/7GKvC9A8RxTW7wVXmrWCitFzQG/KlAU4AqGVYXP0Vpv+
	nxiEU37Qv9Ng39JA6SvPevZsY3jwzfs9SUSwcspMpkIql5Lb/VPK2yJkJxku9Bc1GF6YGKuox7B
	ij1BO3hZ0xXP2f2Puakr0//Or/bteiYLVobVMBHPEiMZAdy6YfX2lg9+KOupFx4FD2OBw+zFl1p
	6SbXy8ibGi5iE163YJGlWIPlAVwSs4jD5fiI8qaWzttOjBWk1tXvgfO5MrDMi4+u//SDcKgd1XN
	pTzVF20z30XLYt+Vg8Btja2w8tN/dWWC5SE58=
X-Received: by 2002:a17:902:f543:b0:2bd:73f4:8e4f with SMTP id d9443c01a7336-2beb06bf8efmr176583875ad.0.1779866107974;
        Wed, 27 May 2026 00:15:07 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d68adsm169036365ad.32.2026.05.27.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:15:07 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/5] verifier: parse BTF type tags for function arguments
Date: Wed, 27 May 2026 03:14:54 -0400
Message-ID: <20260527071457.4598-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527071457.4598-1-emil@etsalapatis.com>
References: <20260527071457.4598-1-emil@etsalapatis.com>
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

