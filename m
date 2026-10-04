Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48F436361
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121133; cv=none; b=XUIySgM0EBBGd64T7tG1QHYUvSgH9sCfWnCn4mKSWRNz3EbXQWoeqPx1NKkuG93xE7cU/efmgTmw8LLhlLXYy8CLSygwoqb/KIFeovyndhYvdUF67F/p7c6noZLFeDRhFpsDUlDbK4ZxozsXHo57F/jYrK7OZjlHrkSqU1D9m8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121133; c=relaxed/simple;
	bh=5rY7Zvhy0lju40FoExRO+DFdI19ouI7bPkM/wMW4pUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZSaJQJHzY1zNGrqO4X7znTzSdqKRWDxsCMVGxlaDJvOmWTe0HcqVKku3h+sDFkHebJasSYOJDUa9ue0rAy8Z1hpqyhzfdA5Bex1igW2zfYB5CCnBU2Ww9+FjO1CohizA8U6wG4HdX/UwVQOF8SyjhKagEMuwgzUez7ooi2BpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJkE3SL6; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJkE3SL6"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09dso298290a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121131; x=1791725931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z7pjctxEeg+GdxvgiDBBC/mxzFSZr+DY/EdCpC5SQoQ=;
        b=tJkE3SL6EtyKl8LliILcfeLMcXTDhAWUsxYpPEtKqcwoMM+DSmNUKz4aUzitdPN8qm
         s4ZI6DLH23UfXhZw+67L5C2VvDpU1ZVdE6ymBlMOvtwR8uJ9uLVpuQtPR+UVdeTbJgzv
         xsXpyJEQyOJ7UQH7T7HQw99itJPcyOhiHHVwc+BmGZXQYpVV81980EKaUzK20V4v09pc
         LsxytjMe4Lrm2ywySUdgZYyulcGCKpFgRCUOmz02G8il1evtiCKJtaKzHsQWOfzgrxs7
         XwvT0RJ4K8GgyRnZGZYMXfkBzDUBP6qL/moe1gPu34R9bl/pGlSr92s0LyLyW02yAV7R
         1ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121131; x=1791725931;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7pjctxEeg+GdxvgiDBBC/mxzFSZr+DY/EdCpC5SQoQ=;
        b=BEzhqB3/WI1w+90sNMJNO2pM0HTxb8WbtFBz6I/4bxMHNjcAGB6R2JGEpWoRtSRCO2
         oPpAUeIfNCzNLjaX959APc7SFEx+6HN9iUyFKgNC2Gk0I7jLyyobJWYhkGMfq13N/2Wo
         VFhzpjW59cc3Zgy8PC1VFT1Bc56MEYBSBfHsZZdxTZSozgRs/mNhWCzQm707ryUc2nWl
         NP8+xaeQsX0Ae9oefde0qlD6/jR/ZURwgkk31ghNG6WouOOivuZ0JmXbGorE4dk0Xil+
         2mnJjqiakXxFG89zQ4jxWRuytOY1+H8wzqx2h7DprX7SUsSKpN32CeUs1nKcRuuweIQ4
         ZAbQ==
X-Gm-Message-State: AFuF++lz/X4pviEExhPJ3ipre4JWdnyEE73wAn50Y/3D2P93ZKLOe13V
	cH0H+dGYEHJ0dT5pouboMlFhUaxzhrRpDEoZpuAI6tEWj5yPDgALGVEqt59rQA==
X-Gm-Gg: AYBFou1dOpYTyApzlhN6eNCucwoEy6m47TYNcdYvtUdcSaLmJAPvCUqF3hGHJdYmrb9
	xd8g+Xw5gda+BWaH4hi1rsb5fddCmjEBoBCm2J75sgFGzpQOhewLhb4pSNMCooNw5KRuI+yMH5r
	Kf9Qw4TIVdzcY8iEOvRZe4PU6KcFARUoMC46w0bnDI+hSDlBfojnkTn/F1YqcAYynLisOqGzAiR
	oBXQzslNJ4Y0xD5bfgzGeNrlZW3WCpuD3BI9TjvoQ9HjhSSuwh9Q9rrZAWWemfcq03JJJu7qXsm
	cMrou8N45h66/KQaha5Twstw/EJyBnnjqFQp33w5rRahF2wkalWQFkUWZEUH+M6Pu7+p+GmtHXr
	RbJ1QyjkFg3ujnMFGQ9j7qIYz2Q9aLM+nb55xFQj5OXP1XpqqFXbC5k5e2p0WNGfjZyhJ0r21rn
	4f6m47AYvpIxX50snylyKqNE0aOZju8TcRGo8Ia1wmkMEGydw4flgaSuXdgZ0jvYtKa7HynU571
	am7bSubT4esz5g=
X-Received: by 2002:a05:6a21:1f8d:b0:3e0:e46f:7bab with SMTP id adf61e73a8af0-3e0e46f9077mr3250960637.32.1791121131048;
        Sun, 04 Oct 2026 06:38:51 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 15/43] bpf: varying offset access support for PTR_TO_BTF_ID pointers
Date: Sun,  4 Oct 2026 06:37:57 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-15-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
index f71778a75f30..27a53204696f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6521,6 +6521,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
 	u32 btf_id = 0;
+	s64 min_off;
 	int ret;
 
 	if (!env->allow_ptr_leaks) {
@@ -6536,36 +6537,31 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
 
@@ -6575,6 +6571,18 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
