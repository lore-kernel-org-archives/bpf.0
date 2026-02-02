Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABFF3612E1
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030961; cv=none; b=DwzNjaKLAwcWJdPBTfA+CRZgjpkWLTbAe8xtuDEBuC3kX1xc9nEFjKRqi4xM+ozvc7ifXx9SqEFRRkTQX+U/ANOYU7dFlMUbyk/kyBL0dPZxmHYkvU4IikdSqANlEf8hf+OrriZBuVdjr3wKR63CrDTBPWcL4f5tK9AV5QH+SxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030961; c=relaxed/simple;
	bh=22sFyTT7zKstT7raUlAMlhW/K0ywNMaYuC46nWw/mUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYbaVLG+rwtUaKJhW9AlxKm5CLclYS7FXfs5JKEUgj36IXvgU+CGyOmjfetD3l05dz5lvWozRkMxAgkOlVZF3k33ZRNmkhbZqW4AK0UL5ekq9NvPcGpdIIBcEd8pRSqmx8kDoR1mJAfaCsumZyKFIVSNLSyooB6C+IzWJUr4jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X26ME4wX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X26ME4wX"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-352e2c59264so2791841a91.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030959; x=1770635759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rbEpDPZnhCwf5iyaGOMt7RKstu0/YR3aU3fxdzXw9A=;
        b=X26ME4wX9bABpLUXqhgJgWCb6UopKSOlQNQrDk1SdJ9uoRhBMJ+YPOdLIeePmusmf/
         z5Ye5ghmajhbLxIXqK3EBBkjx/hRl4ICefXkbPlufhhgTHg8QAFtvGEpAsB6zzk5iOJN
         TJ45PmJ/0u4vPqsIkpyPJ/FhRoBQ5h2d65kl8sY17nzzr25+pxu/rE1+ejoC2lNK6KOd
         qQY9NiELmX/2Y9wdVJ0j76lSSSGCliS8w/dSKVgEY447sUdmlMitFgP4r09EAvHVrXz9
         eveLgqMdFp2WU9J0dbKBRmSXvdTn0Ac7xmOZXzPizxbAcA0FnoNbp5zgFPaN+ZkoObHn
         O0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030959; x=1770635759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1rbEpDPZnhCwf5iyaGOMt7RKstu0/YR3aU3fxdzXw9A=;
        b=FY3wAZjYM2DPAJtDNn4m8Lk3sA5W8PUMLHEMjL58z8h37jU5x9VWQJeWThUhRWK8Dl
         /F/aNPmOKthGeiBfxN3/keHZbx/kg/cNcf5yXfwRAws++mCZ1zen+wwm73w05igbbban
         7nhh5N/71fa8sPwnF6RWw3sgvdUwwqMRKZ1fA2uwUjj14SDborMU2D9wBdYfEhXzs5D6
         UCUTmvh8VrZQgBBd8SMxrR3IhD15y8r/xeMnhWIvNpkKRvWNV8wSIIl+vH2iWL4b2ZBq
         EnA54XD1F4cA2Ej0Xye7CgZI/EHIlf3p+YWub/v4cc5MhlPrrIvuXvhwofa+EkSgsTFQ
         ZIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK3bWQeldm2MhqYraJDKcHkIHebGSVFhhPVi4xVkP52e1tArSap6F11kXB14VnMLnn8mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgDFruhag2uc+NQQMHNggDILDd63fOLDtz6OQYG/DrTePgsjv
	iCEqjO7YwgsG6CI5MiM9F8nUPjeXDgAgm683SA6O+0jG1d2x+L/6Vyaw
X-Gm-Gg: AZuq6aIfUcPvxyfKV2hchqzdaGz17X8pDgekg5BmxGRrIx0q7WHz1o4ec4+k6oN/s9b
	lSDeQVnz2UlR3RrQwlmeHzw0Mcjsm3j2uuxScgq6A5eFlsrfdqgt4nXMOvtTN2ni0Z2Fhi5J6sZ
	hLQnz6zhLSXPR91MmWAlfAmiINVUbpCW80esQcU3io3eV3XPr6Wm4JvQaSi7ph1Zm0iQJ8uNZax
	S3aFAhznO8TKg+Tb9b3E1zJ0RH09pPxv6SWyZx4mnawMOkSM4uOgBz21HkEQ9DuP908CePI2fd/
	oDqCLimiGw7uy3N1kEowxIl1B73ftQEZ6SDHvEqNoOTXyIp0zLIUmupzCJ3/U9KYfJ1reuZjuyo
	aT1TD1bZxfzbnC3UaIdM0qOO6dP2LxOWKG+riJWjznDvAtep6hLgm5kJlXcOkvDTOEUXMxBpT9I
	wlNYLVJAQT/bv9QVPMcXUFPxcYPoWX+q4u2VvYmg==
X-Received: by 2002:a17:90b:56c3:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-3543b3a54c9mr10469703a91.25.1770030959281;
        Mon, 02 Feb 2026 03:15:59 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f3ed0dasm14474680a91.14.2026.02.02.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:15:58 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org,
	ast@kernel.org
Cc: mhiramat@kernel.org,
	andrii.nakryiko@gmail.com,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] btf: Add for_each_enum and for_each_enum64 helper macros
Date: Mon,  2 Feb 2026 19:15:47 +0800
Message-Id: <20260202111548.3555306-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202111548.3555306-1-dolinux.peng@gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Introduce two new helper macros, for_each_enum and for_each_enum64,
to clean up code.

No functional changes.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 include/linux/btf.h | 10 +++++++
 kernel/bpf/btf.c    | 66 +++++++++++++++++++--------------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..cde2deb8e25e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -254,6 +254,16 @@ const char *btf_type_str(const struct btf_type *t);
 	     i < btf_type_vlen(datasec_type);			\
 	     i++, member++)
 
+#define for_each_enum(i, enum_type, member)			\
+	for (i = 0, member = btf_enum(enum_type);		\
+	     i < btf_type_vlen(enum_type);			\
+	     i++, member++)
+
+#define for_each_enum64(i, enum_type, member)			\
+	for (i = 0, member = btf_enum64(enum_type);		\
+	     i < btf_type_vlen(enum_type);			\
+	     i++, member++)
+
 static inline bool btf_type_is_ptr(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_PTR;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..c80a7a0cbe1d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -728,11 +728,6 @@ static const struct btf_array *btf_type_array(const struct btf_type *t)
 	return (const struct btf_array *)(t + 1);
 }
 
-static const struct btf_enum *btf_type_enum(const struct btf_type *t)
-{
-	return (const struct btf_enum *)(t + 1);
-}
-
 static const struct btf_var *btf_type_var(const struct btf_type *t)
 {
 	return (const struct btf_var *)(t + 1);
@@ -743,11 +738,6 @@ static const struct btf_decl_tag *btf_type_decl_tag(const struct btf_type *t)
 	return (const struct btf_decl_tag *)(t + 1);
 }
 
-static const struct btf_enum64 *btf_type_enum64(const struct btf_type *t)
-{
-	return (const struct btf_enum64 *)(t + 1);
-}
-
 static const struct btf_kind_operations *btf_type_ops(const struct btf_type *t)
 {
 	return kind_ops[BTF_INFO_KIND(t->info)];
@@ -4317,14 +4307,14 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
 			       const struct btf_type *t,
 			       u32 meta_left)
 {
-	const struct btf_enum *enums = btf_type_enum(t);
+	const struct btf_enum *enump;
 	struct btf *btf = env->btf;
 	const char *fmt_str;
 	u16 i, nr_enums;
 	u32 meta_needed;
 
 	nr_enums = btf_type_vlen(t);
-	meta_needed = nr_enums * sizeof(*enums);
+	meta_needed = nr_enums * sizeof(*enump);
 
 	if (meta_left < meta_needed) {
 		btf_verifier_log_basic(env, t,
@@ -4347,16 +4337,16 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
 
 	btf_verifier_log_type(env, t, NULL);
 
-	for (i = 0; i < nr_enums; i++) {
-		if (!btf_name_offset_valid(btf, enums[i].name_off)) {
+	for_each_enum(i, t, enump) {
+		if (!btf_name_offset_valid(btf, enump->name_off)) {
 			btf_verifier_log(env, "\tInvalid name_offset:%u",
-					 enums[i].name_off);
+					 enump->name_off);
 			return -EINVAL;
 		}
 
 		/* enum member must have a valid name */
-		if (!enums[i].name_off ||
-		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+		if (!enump->name_off ||
+		    !btf_name_valid_identifier(btf, enump->name_off)) {
 			btf_verifier_log_type(env, t, "Invalid name");
 			return -EINVAL;
 		}
@@ -4365,8 +4355,8 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
 			continue;
 		fmt_str = btf_type_kflag(t) ? "\t%s val=%d\n" : "\t%s val=%u\n";
 		btf_verifier_log(env, fmt_str,
-				 __btf_name_by_offset(btf, enums[i].name_off),
-				 enums[i].val);
+				 __btf_name_by_offset(btf, enump->name_off),
+				 enump->val);
 	}
 
 	return meta_needed;
@@ -4382,8 +4372,8 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
 			  u32 type_id, void *data, u8 bits_offset,
 			  struct btf_show *show)
 {
-	const struct btf_enum *enums = btf_type_enum(t);
-	u32 i, nr_enums = btf_type_vlen(t);
+	const struct btf_enum *enump;
+	u32 i;
 	void *safe_data;
 	int v;
 
@@ -4393,13 +4383,13 @@ static void btf_enum_show(const struct btf *btf, const struct btf_type *t,
 
 	v = *(int *)safe_data;
 
-	for (i = 0; i < nr_enums; i++) {
-		if (v != enums[i].val)
+	for_each_enum(i, t, enump) {
+		if (v != enump->val)
 			continue;
 
 		btf_show_type_value(show, "%s",
 				    __btf_name_by_offset(btf,
-							 enums[i].name_off));
+							 enump->name_off));
 
 		btf_show_end_type(show);
 		return;
@@ -4425,14 +4415,14 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
 				 const struct btf_type *t,
 				 u32 meta_left)
 {
-	const struct btf_enum64 *enums = btf_type_enum64(t);
+	const struct btf_enum64 *enump;
 	struct btf *btf = env->btf;
 	const char *fmt_str;
 	u16 i, nr_enums;
 	u32 meta_needed;
 
 	nr_enums = btf_type_vlen(t);
-	meta_needed = nr_enums * sizeof(*enums);
+	meta_needed = nr_enums * sizeof(*enump);
 
 	if (meta_left < meta_needed) {
 		btf_verifier_log_basic(env, t,
@@ -4455,16 +4445,16 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
 
 	btf_verifier_log_type(env, t, NULL);
 
-	for (i = 0; i < nr_enums; i++) {
-		if (!btf_name_offset_valid(btf, enums[i].name_off)) {
+	for_each_enum64(i, t, enump) {
+		if (!btf_name_offset_valid(btf, enump->name_off)) {
 			btf_verifier_log(env, "\tInvalid name_offset:%u",
-					 enums[i].name_off);
+					 enump->name_off);
 			return -EINVAL;
 		}
 
 		/* enum member must have a valid name */
-		if (!enums[i].name_off ||
-		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+		if (!enump->name_off ||
+		    !btf_name_valid_identifier(btf, enump->name_off)) {
 			btf_verifier_log_type(env, t, "Invalid name");
 			return -EINVAL;
 		}
@@ -4474,8 +4464,8 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
 
 		fmt_str = btf_type_kflag(t) ? "\t%s val=%lld\n" : "\t%s val=%llu\n";
 		btf_verifier_log(env, fmt_str,
-				 __btf_name_by_offset(btf, enums[i].name_off),
-				 btf_enum64_value(enums + i));
+				 __btf_name_by_offset(btf, enump->name_off),
+				 btf_enum64_value(enump));
 	}
 
 	return meta_needed;
@@ -4485,8 +4475,8 @@ static void btf_enum64_show(const struct btf *btf, const struct btf_type *t,
 			    u32 type_id, void *data, u8 bits_offset,
 			    struct btf_show *show)
 {
-	const struct btf_enum64 *enums = btf_type_enum64(t);
-	u32 i, nr_enums = btf_type_vlen(t);
+	const struct btf_enum64 *enump;
+	u32 i;
 	void *safe_data;
 	s64 v;
 
@@ -4496,13 +4486,13 @@ static void btf_enum64_show(const struct btf *btf, const struct btf_type *t,
 
 	v = *(u64 *)safe_data;
 
-	for (i = 0; i < nr_enums; i++) {
-		if (v != btf_enum64_value(enums + i))
+	for_each_enum64(i, t, enump) {
+		if (v != btf_enum64_value(enump))
 			continue;
 
 		btf_show_type_value(show, "%s",
 				    __btf_name_by_offset(btf,
-							 enums[i].name_off));
+							 enump->name_off));
 
 		btf_show_end_type(show);
 		return;
-- 
2.34.1

