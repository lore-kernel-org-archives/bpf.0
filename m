Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7C4C10D1
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542928; cv=none; b=kKiSqtaeycjBsIxnXKo7wXnVKMpsnBdwxUMnj5V29lYxHrGBw0VoSLspKm0QU46Qh+ZpgYKKZpbkYltDzMVrWr9bpvAASwoQ2ykzzFi9JY1o0YkCafugeuAhVYQhQ4mcBP37shkf2th7Ik/iIcrAjNT+c/7HWmKD/q4ZTWdT5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542928; c=relaxed/simple;
	bh=7OgfxqzViuwGE9EkgMRzAKGDFLBdaeh49VjLxJaQ2gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJGdetw9jE8+qDABPWAFNHUseNWso4hw6pEXp+ucZr2lagAqQhiq3tFxhuvt6OVyQGZ07n0qcrxQJdYuzxGzm2X4OyVg+jOWCzg4QN7XMAAE4ixitdPLnd2fEfWLkGPRZfA/ZS1eNiCu9e6PWVBOSZnjEvfVP/XpiDm7b54mLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGR+5VZZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGR+5VZZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so120431a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542913; x=1792147713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v74LasCAiGDkZvaGSeYfcRDyP4A4eqo8vI5tgLhh3ws=;
        b=UGR+5VZZmEh2mDbvUVLPBez/48qQ+wRAQ/IcI21GGu4IOgdw2ChEnz/K5Opw++torQ
         ORLpWke1I9TL/YCh8MSJxbz2ucyr9a0vM8KffuFp2naDYwMp4kySQZlA5EiJHzCxx98S
         YfWCBzIpJSrL9nWhVyD06BvVbkNkUD3QdhV0eV1xntuwo39rid5yDVQ4Mi8kx3kO5ArH
         NB/upsaDrEcYtCAIxPWbSVRj92HwhvLTAPv+a34IPyiEqskXdxGLYtN4dCgSIPcNdgDl
         j0zDsUuDFAyApubXypC0CT7aR2jeV/ZR/u0J1c8bqkITOaNKenSSOmqpf3S1BkEmIyye
         DjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542913; x=1792147713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v74LasCAiGDkZvaGSeYfcRDyP4A4eqo8vI5tgLhh3ws=;
        b=CCXu32/YZBOVDH7a/NgoZixZ7HBxYdUfYfw0MWj9s43+OGJbdtcieJ/yQYO/0RfIfD
         FizyIIrNLFyDlVFrji/L7WKOCDKZpPS+yyxonjPgx+JfuNLEEcON3xoOlYMMtA2knXyK
         C/v7+qhK2Bc+JLXvarpJah82mgH3cW9BpZaYwg/lmONMj2URMMwBjdRBSVFagu6ptLJl
         9i1NTdatLJnj6z4dEYF6Z5FADj9RpZqJmgtSEZKf8pu7ddrsU/PDMXE1YYhd4qsSLM5g
         zzccRkM+LCGEqc3QPQLbhiIL3ghfEhfhdZMmjHwXV+OIufsTwSjc3x5vkV3PHpUjZwSu
         KMjw==
X-Gm-Message-State: AFq9FYLBAsXW+yKFl2xuvMnwlZuyCYfG6DrGcbdLc+qIQkqbPR2f0EHQ
	Y4HgyGv0dCS/Cj0I2iPptDCvUU8+lVIoCIfNVtj5TpI0qiOHdLnQH4tCZn0OCA==
X-Gm-Gg: AYBFou0YiSkjk+M3dTIrbsUnpYSCEPDXWbrfZQxe4ucwzdCzfsBX5xAArbXDo5XRrpW
	t9+IrHFfUqA9qLZL9UKRtF9HrwCheSkK4/THSRTEgzdb58KTXAp4G7djWjw8odaA4O6VazjEr6P
	I+OMCnmMieDYihLMD5iGaUXArq8+i7tj57q+Z96BgoQB8tNCnbrvKxWwaKou2en60PMW6WTigIk
	G5NOVjqz+M1svANOrsTOnjsAQQGia4HF4ZS2E3LplYhcQMkAE7j/jw+FwIpw1pcU1nVzrYRYYY1
	sBLHprZYSD5XWkxUA6yQA5bhS3vsKngT/SFx3ZUpmojMYP3hrd7r+Z3UmBp5JzJaU9cv0NN0UGG
	or3P3UynuMepEY9NJ/N62tNYReaeLgH7e9CbVDL6i6JObA2e7gGadPuC+WQdBzgIU5jzpQbfco+
	ZvzNk/nmq1DvRN+ysxCrkd4ATFVbqqr/K2jwu2D/9v2im1Wxj0ThImsA0kfSpiJrTqv7FbLaAF0
	WvZmV1ANcHG9uiT4e/J0Nbxeg==
X-Received: by 2002:a17:90b:5486:b0:39e:6a7f:1dcd with SMTP id 98e67ed59e1d1-3ab3ab1d56cmr1516515a91.41.1791542912782;
        Fri, 09 Oct 2026 03:48:32 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:32 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 20/51] bpf: varying offset access support for PTR_TO_BTF_ID pointers
Date: Fri,  9 Oct 2026 03:47:38 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-20-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Relax the requirements for reads like `p->arr[i].field`, where `p` is a
PTR_TO_BTF_ID, by allowing `i` to be a non-constant value.
This is useful for loops over arrays accessed from a PTR_TO_BTF_ID
when the verifier widens the loop induction variable.

Check that the access stays within array bounds based on the access
register's min and max bounds. Check that the access is aligned with
array elements using the register's `base` and `step`.

Technically, modify btf_struct_access() such that:
- it identifies `field` by walking BTF from the minimum offset
  (the register's reg_smin + static instruction offset);
- it remembers which arrays contain `field`;
- it checks that offsets `k * step` stay within the array
  and point to the same `field`;
- it does not check upper bounds for flexible arrays
  (as is already the case for constant-offset access).

Support for flexible arrays nested inside trailing struct members
(e.g. p->nested.data[i], with data declared as int data[]) is left
for future work.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c      | 159 ++++++++++++++++++++++++++++++++++++++++++--------
 kernel/bpf/states.c   |   1 +
 kernel/bpf/verifier.c |  38 +++++++-----
 3 files changed, 159 insertions(+), 39 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0630675377aa..f4d119f3d5ef 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2079,7 +2079,8 @@ static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
  * *elem_id: id of u32
  * *total_nelems: (x * y).  Hence, individual elem size is
  *                (*type_size / *total_nelems)
- * *type_id: id of type if it's changed within the function, 0 if not
+ * *type_id: ID of the returned type if leading modifiers were stripped;
+ *           otherwise left unchanged.
  *
  * type: is not an array (e.g. const struct X)
  * return type: type "struct X"
@@ -2087,7 +2088,8 @@ static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
  * *elem_type: same as return type ("struct X")
  * *elem_id: 0
  * *total_nelems: 1
- * *type_id: id of type if it's changed within the function, 0 if not
+ * *type_id: ID of the returned type if leading modifiers were stripped;
+ *           otherwise left unchanged.
  */
 static const struct btf_type *
 __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
@@ -2120,7 +2122,8 @@ __btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
 		case BTF_KIND_TYPE_TAG:
-			id = type->type;
+			if (!array_type)
+				id = type->type;
 			type = btf_type_by_id(btf, type->type);
 			break;
 
@@ -7549,6 +7552,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 }
 EXPORT_SYMBOL_GPL(btf_ctx_access);
 
+#define MAX_ARRAYS_WALK 16
+
+/* Description of an array crossed while walking a BTF access chain */
+struct array_access {
+	u32 id;		/* BTF_KIND_ARRAY type id */
+	u32 off;	/* offset of the access within the array */
+};
+
 enum bpf_struct_walk_result {
 	/* < 0 error */
 	WALK_SCALAR = 0,
@@ -7557,10 +7568,43 @@ enum bpf_struct_walk_result {
 	WALK_STRUCT,
 };
 
+static const struct btf_member *find_flex_member(const struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_array *array;
+	const struct btf_type *mtype;
+	const struct btf_member *member;
+	u32 vlen = btf_type_vlen(t);
+
+	if (vlen == 0)
+		return NULL;
+
+	member = btf_type_member(t) + vlen - 1;
+	mtype = btf_type_skip_modifiers(btf, member->type, NULL);
+	if (!btf_type_is_array(mtype))
+		return NULL;
+
+	array = (const struct btf_array *)(mtype + 1);
+	if (array->nelems != 0)
+		return NULL;
+
+	return member;
+}
+
+static int push_array(struct array_access *arrays, u32 *arrays_cnt, struct array_access item)
+{
+	if (arrays == NULL)
+		return 0;
+	if (*arrays_cnt == MAX_ARRAYS_WALK)
+		return -1;
+	arrays[(*arrays_cnt)++] = item;
+	return 0;
+}
+
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, int off, int size,
 			   u32 *next_btf_id, enum bpf_type_flag *flag,
-			   const char **field_name, bool walk_flex_arrays)
+			   const char **field_name, bool walk_flex_arrays,
+			   struct array_access *arrays, u32 *arrays_cnt)
 {
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
 	const struct btf_type *mtype, *elem_type = NULL;
@@ -7595,22 +7639,19 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		/* If the last element is a variable size array, we may
 		 * need to relax the rule.
 		 */
-		if (vlen == 0)
+		member = find_flex_member(btf, t);
+		if (!member)
 			goto error;
 
-		member = btf_type_member(t) + vlen - 1;
-		mtype = btf_type_skip_modifiers(btf, member->type,
-						NULL);
-		if (!btf_type_is_array(mtype))
+		moff = __btf_member_bit_offset(t, member) / 8;
+		if (off < moff)
 			goto error;
 
+		mtype = btf_type_skip_modifiers(btf, member->type, &mid);
 		array_elem = (struct btf_array *)(mtype + 1);
-		if (array_elem->nelems != 0)
-			goto error;
 
-		moff = __btf_member_bit_offset(t, member) / 8;
-		if (off < moff)
-			goto error;
+		if (push_array(arrays, arrays_cnt, (struct array_access){ mid, off - moff }))
+			return -E2BIG;
 
 		/* allow structure and integer */
 		t = btf_type_skip_modifiers(btf, array_elem->type,
@@ -7733,6 +7774,9 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			 *      the array's element as long as it is
 			 *      within the mtrue_end boundary.
 			 */
+			if (push_array(arrays, arrays_cnt,
+				       (struct array_access){ mid, off - moff }))
+				return -E2BIG;
 
 			/* skip empty array */
 			if (moff == mtrue_end)
@@ -7825,15 +7869,29 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 
 int btf_struct_access(struct bpf_verifier_log *log,
 		      const struct bpf_reg_state *reg,
-		      int off, int size, enum bpf_access_type atype __maybe_unused,
+		      int _off, int size, enum bpf_access_type atype __maybe_unused,
 		      u32 *next_btf_id, enum bpf_type_flag *flag,
 		      const char **field_name)
 {
 	const struct btf *btf = reg->btf;
 	enum bpf_type_flag tmp_flag = 0;
+	struct array_access arrays[MAX_ARRAYS_WALK];
+	const struct btf_member *member;
 	const struct btf_type *t;
+	u32 i, arrays_cnt = 0;
 	u32 id = reg->btf_id;
-	int err;
+	s64 min_off, max_off, flex_off;
+	int err, off, ret;
+
+	if (check_add_overflow(reg_smin(reg), (s64)_off, &min_off) ||
+	    check_add_overflow(reg_smax(reg), (s64)_off, &max_off) ||
+	    min_off != (int)min_off) {
+		bpf_log(log,
+			"offset computation overflows: register offset range is [%lld, %lld], instruction offset is %d\n",
+			reg_smin(reg), reg_smax(reg), _off);
+		return -EINVAL;
+	}
+	off = min_off;
 
 	while (type_is_alloc(reg->type)) {
 		struct btf_struct_meta *meta;
@@ -7860,26 +7918,30 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	t = btf_type_by_id(btf, id);
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag,
-				      field_name, !type_is_alloc(reg->type));
-
+				      field_name, !type_is_alloc(reg->type), arrays, &arrays_cnt);
 		switch (err) {
 		case WALK_PTR:
 			/* For local types, the destination register cannot
 			 * become a pointer again.
 			 */
-			if (type_is_alloc(reg->type))
-				return SCALAR_VALUE;
+			if (type_is_alloc(reg->type)) {
+				ret = SCALAR_VALUE;
+				goto check_variable_offset;
+			}
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
 			*next_btf_id = id;
 			*flag = tmp_flag;
-			return PTR_TO_BTF_ID;
+			ret = PTR_TO_BTF_ID;
+			goto check_variable_offset;
 		case WALK_PTR_UNTRUSTED:
 			*flag = MEM_RDONLY | PTR_UNTRUSTED;
-			return PTR_TO_MEM;
+			ret = PTR_TO_MEM;
+			goto check_variable_offset;
 		case WALK_SCALAR:
-			return SCALAR_VALUE;
+			ret = SCALAR_VALUE;
+			goto check_variable_offset;
 		case WALK_STRUCT:
 			/* We found nested struct, so continue the search
 			 * by diving in it. At this point the offset is
@@ -7899,6 +7961,55 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	} while (t);
 
 	return -EINVAL;
+
+check_variable_offset:
+	if (min_off == max_off)
+		return ret;
+
+	/* Find an offset at which access would go to a flexible array tail (if any). */
+	t = btf_type_skip_modifiers(btf, reg->btf_id, NULL);
+	member = find_flex_member(btf, t);
+	flex_off = member ? __btf_member_bit_offset(t, member) / 8 : S64_MAX;
+
+	/*
+	 * If this is a varying offset access, the step recorded within a register
+	 * should correspond to one of the arrays visited while walking.
+	 */
+	for (i = 0; i < arrays_cnt; i++) {
+		s64 array_start, array_end, access_end;
+		u32 asize, esize, elem_id;
+
+		/*
+		 * 'arrays' records top-level arrays only, use __btf_resolve_size()
+		 * to get flattened representation.
+		 */
+		t = btf_type_by_id(btf, arrays[i].id);
+		if (IS_ERR(__btf_resolve_size(btf, t, &asize, NULL, &elem_id, NULL, NULL)) ||
+		    IS_ERR(btf_resolve_size(btf, btf_type_by_id(btf, elem_id), &esize)))
+			continue;
+		/* Make sure every accessed offset lands on the same field of some element. */
+		if (esize == 0 || reg->step % esize != 0)
+			continue;
+
+		array_start = min_off - arrays[i].off;
+		/* An array within the flexible tail has no upper bound to exceed */
+		if (array_start >= flex_off && btf_type_is_array(t) &&
+		    btf_type_array(t)->nelems == 0)
+			return ret;
+
+		/* the 'size' bytes read at max_off must stay within the array */
+		if (check_add_overflow(array_start, (s64)asize, &array_end) ||
+		    check_add_overflow(max_off, (s64)size, &access_end) ||
+		    access_end > array_end)
+			continue;
+		return ret;
+	}
+
+	bpf_log(log,
+		"invalid variable offset access into struct %s: offsets [%lld, %lld] size %d step %d do not match any array\n",
+		btf_name_by_offset(btf, btf_type_by_id(btf, reg->btf_id)->name_off),
+		min_off, max_off, size, reg->step);
+	return -EINVAL;
 }
 
 /* Check that two BTF types, each specified as an BTF object + id, are exactly
@@ -7939,7 +8050,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	if (!type)
 		return false;
 	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL,
-			      walk_flex_arrays);
+			      walk_flex_arrays, NULL, NULL);
 	if (err != WALK_STRUCT)
 		return false;
 
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 981328f5eb60..2f6a7620eb72 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -633,6 +633,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	case PTR_TO_BUF:
 	case PTR_TO_TP_BUFFER:
 	case PTR_TO_STACK:
+	case PTR_TO_BTF_ID:
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f5b2500335a7..192efb722997 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6554,6 +6554,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
 	u32 btf_id = 0;
+	s64 min_off;
 	int ret;
 
 	if (!env->allow_ptr_leaks) {
@@ -6569,36 +6570,31 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
-	if (!tnum_is_const(reg->var_off)) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+	if (check_add_overflow(reg_smin(reg), off, &min_off)) {
 		verbose(env,
-			"%s is ptr_%s invalid variable offset: off=%d, var_off=%s\n",
-			reg_arg_name(env, argno), tname, off, tn_buf);
+			"%s is ptr_%s access, offset computation overflows: register's minimal offset is %lld, instruction offset is %d\n",
+			reg_arg_name(env, argno), tname, reg_smin(reg), off);
 		return -EACCES;
 	}
 
-	off += reg->var_off.value;
-
-	if (off < 0) {
+	if (min_off < 0) {
 		verbose(env,
-			"%s is ptr_%s invalid negative access: off=%d\n",
-			reg_arg_name(env, argno), tname, off);
+			"%s is ptr_%s invalid negative access: off=%lld\n",
+			reg_arg_name(env, argno), tname, min_off);
 		return -EACCES;
 	}
 
 	if (reg->type & MEM_USER) {
 		verbose(env,
-			"%s is ptr_%s access user memory: off=%d\n",
-			reg_arg_name(env, argno), tname, off);
+			"%s is ptr_%s access user memory\n",
+			reg_arg_name(env, argno), tname);
 		return -EACCES;
 	}
 
 	if (reg->type & MEM_PERCPU) {
 		verbose(env,
-			"%s is ptr_%s access percpu memory: off=%d\n",
-			reg_arg_name(env, argno), tname, off);
+			"%s is ptr_%s access percpu memory\n",
+			reg_arg_name(env, argno), tname);
 		return -EACCES;
 	}
 
@@ -6608,6 +6604,18 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	}
 
 	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
+		if (!tnum_is_const(reg->var_off)) {
+			char tn_buf[48];
+
+			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+			verbose(env,
+				"%s is ptr_%s invalid variable offset: off=%d, var_off=%s\n",
+				reg_arg_name(env, argno), tname, off, tn_buf);
+			return -EACCES;
+		}
+
+		off += reg->var_off.value;
+
 		if (!btf_is_kernel(reg->btf)) {
 			verifier_bug(env, "reg->btf must be kernel btf");
 			return -EFAULT;

-- 
2.53.0
