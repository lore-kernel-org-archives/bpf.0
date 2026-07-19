Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB423932CD
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471047; cv=none; b=XKkWJsNGp2G5zP0EbtdSN7C1qzC5r26wk3/JarqKkpHFSZWEFbOdCHZZ90eHbZmaDSWKjZRvgH5o3rDknx3kjvgxcdKIsWuG0VGksW1kjBTrXROMy4am7etiSlP66PqoZHZ9Ia7MCRVgkOYXsK7rG7cp75JsEPvB0UX4ZX5hgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471047; c=relaxed/simple;
	bh=16JUB0XSpLPv7z7k6o3n45tGeMDT3nECSLHlzRIh4ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktnfDBVpm9CjFMn8avKLA0CMYYbEvXkU6b5co7c0xTActdSFXun79Pvh1jCtMzjeXF48bY6PuWRPFXpy8KcJUjEmdvvFEAFBf8+RhT0rcqLcBGJFFvtLh2t6gHseFLqt1NTnoGlATKX/tzkQy1Gb+lLvIHLo1LyaY4oDB8GKAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIt3o/k6; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIt3o/k6"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so1592665e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784471044; x=1785075844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG4qNbgg5Zsw1EQyyXYvAmygKm1qbawIKLATdXpR2zc=;
        b=UIt3o/k6gLGX/26EKypSmlO4kqhPM2FcQCIg0WxQeAabriy6Gcbmt7O+zJH8rjV6OG
         PNShYNR9S4+VLr3ZKeaI5l62DFqExu+6Ur12Qs1rvFKen38SCTs5e4J89J3+fXiw/L2c
         5SbyXdiuEwbH91iQD04JyKFIEgqcid1KDMLFgIkipcKyxYl+KZtMfOEJhPV/Lq/xhJ8g
         pCwcUux7vPhrwR3hIf+IT1t4zvym59THJFq/sIBmS0g+WfI3ul2o7ifp9zMWWHVvgWa0
         aGBcTq32uNqOCOS0L8QwX8vNsliIAaU+yiNYsIRv4BLQ4SPIHwXZC7RbwGE4VGgVAVLa
         nnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784471044; x=1785075844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nG4qNbgg5Zsw1EQyyXYvAmygKm1qbawIKLATdXpR2zc=;
        b=CJOAHZbVqVH4jiPpqR0oHbmSew5Y0DrEBqAoJsZcwpfqbEOw6x3/fIrCSsJlcJG7D6
         sdUnV55QA1D+jEo9hMfX/oJVLRN7dyOOOB8mLw4LbJ4KYLWpo4CltoIDvmWyqP+Hv0Yw
         foh7Z5VRDqectZ7EXWn6p2jBCniZXvPNQV1KyQJBqBZDCbNdvPfzrNFzRZlk7VfqZeGM
         vX58dWcsWIpTmwth2UQRXaAZe7KFaw/0BGTuG/lXncHp5cBjmWLOIwr/ng5OreOniuHb
         nF0jHQl39idnOBk/XnbuypFK+i+nJsU4x6DujWo9fCtTu9mN2krT3wSqXoOw6kckTSGS
         YaGQ==
X-Gm-Message-State: AOJu0YxMm0UB0eyenNHFawWb+MjaTHFmez/D5qilOJDKRH05UXmhU5YM
	0PDHcKck8Sc4QQ26YC/opH4Z8Mvi5HxcnO8t38Ol/PufKpj2EGP5o3XQM6DvRWxC
X-Gm-Gg: AfdE7clxPOSCrgxjBe+Df3g2WvsnD9IIFiWYZbIYZVWtzRlseRVL53YAqiXoQyJ4NyA
	QNTjwaMtdDIGVFronc18ir2XFiGUg7BaQThGqJ8kRZg4CbWfh84STF7VNCg1dFpyZFN3UIJd7RF
	GbgWJJzJCj583iPG6UjIci/KFMxMnsPfOnvc9nxs8znf9L/v6GpG5tnhMiZrKP99w6CLK86ok2H
	k7bQwBxlAvo775bvI3aZrK6qnwxM+Tw3E5xUTbAgJaIGVwW8uJGWGBUAGZmnK4H5/J3msGzpaxf
	ACSM7pCH8+VLZYaqcXPw6juXzSVl5mAfs28fb/f0lzAdcOqsAfpyd7/gcvEpSXMbKAOJiwXVnSP
	mGeYFRDOaxLo84mDYoJ3yCbuOkE0hG9FdENp6ejp7bSetVSZiQ5AxG7mJqrMst0KKY2kWQUEFxc
	TTfR2iOAnoapU7Xv82Y243sud1w8tXY0UOQpboO9KJofcxqzE1zFGL5oyKAZvAabXl2qNzrPNnc
	KX9XaE5tjCgVFdcZc+McQDV3DtDctLQNCQvMra+hZtC
X-Received: by 2002:a5d:64e4:0:b0:47f:6ef9:e4f9 with SMTP id ffacd0b85a97d-47f6ef9e5ddmr5828145f8f.10.1784471043579;
        Sun, 19 Jul 2026 07:24:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6980582csm14721396f8f.13.2026.07.19.07.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:24:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Preserve unique-field state across nested structs
Date: Sun, 19 Jul 2026 16:23:59 +0200
Message-ID: <20260719142401.2420111-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719142401.2420111-1-memxor@gmail.com>
References: <20260719142401.2420111-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4641; i=memxor@gmail.com; h=from:subject; bh=16JUB0XSpLPv7z7k6o3n45tGeMDT3nECSLHlzRIh4ao=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvm+lPDFbI8v7suRlyczFUz3bpymvSOk7csM104V8+dE ym7Mla7o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNZyMbI8Ojiwu6Xxsd2REsq bFq4obcgLH8DW5zsooVBm5I9dyrFAlWc0eZp5e174skdvJx/3tEsht+61Xs/h7R1lv0vVL2XxsA CAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

btf_find_struct_field() initializes a fresh seen mask for every recursive
descent. Unique special fields in different levels of the same aggregate
therefore do not see one another. The duplicate fields can reach
btf_parse_fields(), where they trigger an invariant WARN_ON_ONCE(). A
crafted user BTF can consequently trigger the warning before map creation
checks capabilities.

Initialize the seen mask once in btf_find_field() and pass the same pointer
through struct, datasec, and nested-struct walks. This gives the entire field
traversal one shared uniqueness state.

Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct type recursively.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cbb1e49b9bcb..8d628552ef99 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3751,7 +3751,7 @@ static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt,
-				 u32 level);
+				 u32 level, u32 *seen_mask);
 
 /* Find special fields in the struct type of a field.
  *
@@ -3762,7 +3762,7 @@ static int btf_find_struct_field(const struct btf *btf,
 static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
 				  u32 off, u32 nelems,
 				  u32 field_mask, struct btf_field_info *info,
-				  int info_cnt, u32 level)
+				  int info_cnt, u32 level, u32 *seen_mask)
 {
 	int ret, err, i;
 
@@ -3770,7 +3770,7 @@ static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *
 	if (level >= MAX_RESOLVE_DEPTH)
 		return -E2BIG;
 
-	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level);
+	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level, seen_mask);
 
 	if (ret <= 0)
 		return ret;
@@ -3827,7 +3827,7 @@ static int btf_find_field_one(const struct btf *btf,
 		if (expected_size && expected_size != sz * nelems)
 			return 0;
 		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
-					     &info[0], info_cnt, level);
+					     &info[0], info_cnt, level, seen_mask);
 		return ret;
 	}
 
@@ -3892,11 +3892,11 @@ static int btf_find_field_one(const struct btf *btf,
 static int btf_find_struct_field(const struct btf *btf,
 				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt,
-				 u32 level)
+				 u32 level, u32 *seen_mask)
 {
 	int ret, idx = 0;
 	const struct btf_member *member;
-	u32 i, off, seen_mask = 0;
+	u32 i, off;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
@@ -3910,7 +3910,7 @@ static int btf_find_struct_field(const struct btf *btf,
 
 		ret = btf_find_field_one(btf, t, member_type, i,
 					 off, 0,
-					 field_mask, &seen_mask,
+					 field_mask, seen_mask,
 					 &info[idx], info_cnt - idx, level);
 		if (ret < 0)
 			return ret;
@@ -3921,11 +3921,11 @@ static int btf_find_struct_field(const struct btf *btf,
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				u32 field_mask, struct btf_field_info *info,
-				int info_cnt, u32 level)
+				int info_cnt, u32 level, u32 *seen_mask)
 {
 	int ret, idx = 0;
 	const struct btf_var_secinfo *vsi;
-	u32 i, off, seen_mask = 0;
+	u32 i, off;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
@@ -3933,7 +3933,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 
 		off = vsi->offset;
 		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
-					 field_mask, &seen_mask,
+					 field_mask, seen_mask,
 					 &info[idx], info_cnt - idx,
 					 level);
 		if (ret < 0)
@@ -3947,10 +3947,12 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 			  u32 field_mask, struct btf_field_info *info,
 			  int info_cnt)
 {
+	u32 seen_mask = 0;
+
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0);
+		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0);
+		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
 	return -EINVAL;
 }
 
-- 
2.53.0

