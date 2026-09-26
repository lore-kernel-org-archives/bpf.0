Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F647C0F5
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432463; cv=none; b=X/SOa3D12ruk8bIDf61fdqlI04jJEmkHDgGZUzMFjNiTltw6sORusnH2kwsVp/ZykSv+nC1qBDfT54Uy6Qhw+pvPge6vdBRI/dQS7rzoi/Bift/r39uCyxYZ84pbNDrk2ITmBI8BzT5PHFi2m+gJF8xErFdemA86xPBTT16HrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432463; c=relaxed/simple;
	bh=Luq3ysHH7NORXlsePvF1mFs6QlcH9Ko8uoGOLtUiJt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJ4L8dIcXipiV0qcpQAjeBrke5AUDB04NlYCZRvGrZl3aDyaAzQdfs1ESISl/OycWKKJef/JBDItfs0jHA79fxsAujd2OncZcpS/W0IC2MpOX9IqyaYiATOFrvv4cVcF1gQnMZTQPRFBVxS9STA/CvyXcMrNmfh4d3YxOL1tOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oY7kEouh; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY7kEouh"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1deaso334297a12.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432461; x=1791037261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ev11zTR/3oXfDn0t7TsoyfrdhTiJobhva4YgfEQvXs8=;
        b=oY7kEouhDeWcgjjkFB8ET4ftpo1InsrGhZnQg+GbnaY3J3c6eXD4hOKcYTxQxujkQz
         +MZhHb3Iy8nWJOxKqtL4vDVSkZui+G0VU116BB5Bz1USZwTKtgj3tvBo/17iYqnIkm/t
         quTL9ihrz+DS4xKnN+k/pjfFMCsgyjxkQaKyQHwn7cdJh2dHPYUYYA9ysQ3WASRyeRIi
         dajlZ00Q1fFcN61AigJe9H4snldiYL8ADvYd+tM9Xd0n+jOpb0A3wQ9yXhmBTGDcWagc
         gBkRtlXaPjmJ4QhnBD7rE1mnFiEaoZzdb86vPgPT3PMLbp0/HbjFBtP9+4hW2w7Iih3T
         ltxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432461; x=1791037261;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ev11zTR/3oXfDn0t7TsoyfrdhTiJobhva4YgfEQvXs8=;
        b=w6zmMtALhdKMvYO4P1fJpWq0KyFu6PvApOIbofdq5acxHNqvqyH/zWra9mxqCccyhY
         Rhh/1v1swWa/OUAk4YVuVev6x79MuAeuzDyPrEHdCCBg8oWl6KAJlqU1HMuO65Byy05/
         fX0l+RU9XDWn04xaXemedM3YGB8HJ/d5S7F1mSs/xzVVAm38wH0SPFINKuB0VYF8x6vA
         abMBEkaTOkwsPSjV9iapQ1uob3HF0oxCG+hbPYKLmY5/DrjnfkM66oO67J3bWudt4tRg
         I1OH4Yce53DbGo2V4RwvRzg3uhBbQK9h/w2yBhmPUU5uckkO+b+FpcNhbuTDlau+JwG+
         Kw6w==
X-Gm-Message-State: AFq9FYKfdwy1nmKqgX+XivXv2GtVW0wO4o3FYfCInwkmLxIdP8S7ZcLS
	4VVkzKHRxvgza72DbnEUssGlqaWzHOCJuVJEgpOkmjEmodcYy1YpyOZR1kDgOqmgHsw=
X-Gm-Gg: AYBFou2yVAp9ykV35SryI03x2d743rncd73o4Pqya1lxhkrkjYoOt0kJuvao8wCPfHR
	9dGGzQ9vDDN2y9UQ2UX5dcP5eVAmK7UB6mmCxMsKePzM57LcNroNYJBvntKVMoaQgOmoSIe+SIf
	GFKcawfZjacy6RxGYDU4HKmVNj0wksEbcKdoIeULhyEWIgAIysRimsv6sQkvdvUCTFXZL9MaJqA
	fJipwcXQmUIpneQO9twoGcqovu0DFRmzJ9ZNU5DSsLXRAIapkeGDHq00h2svClHdQAnCE41GMgV
	Ck73XxFAkE1RcaiTqHRIK/DZH0s8Xn4qAFSzrT9hdke0vcrSZVmDA/Ff5DTe1CQ1lMpn//Kjk1U
	xJH3QoqugCeaRB7XhuYH+848pjTW2zfW1IyZ4sTQ8D5y82d9xIhZF5s1ASRZ7C2PdGGt/NjCyN6
	5DnB6oEjkEaUvySjmPnGakffE8WkHS4w1Zn09hn0SeRng1vv8lcCe2HmS0h9hGoS06oswBMpegP
	MNXKYqV1qn5TaEalsf/VWetRqFbNSrvxfWuq8WLcQ==
X-Received: by 2002:a17:90b:268c:b0:3a0:5238:1aed with SMTP id 98e67ed59e1d1-3a098729546mr7819612a91.37.1790432460622;
        Sat, 26 Sep 2026 07:21:00 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 15/36] bpf: varying offset access support for PTR_TO_BTF_ID pointers
Date: Sat, 26 Sep 2026 07:20:13 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-15-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c      | 149 +++++++++++++++++++++++++++++++++++++++++++-------
 kernel/bpf/states.c   |   1 +
 kernel/bpf/verifier.c |  38 ++++++++-----
 3 files changed, 152 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bcfefdfb734..37437b93471d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7496,6 +7496,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
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
@@ -7504,10 +7512,43 @@ enum bpf_struct_walk_result {
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
@@ -7542,22 +7583,19 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
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
@@ -7680,6 +7718,9 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			 *      the array's element as long as it is
 			 *      within the mtrue_end boundary.
 			 */
+			if (push_array(arrays, arrays_cnt,
+				       (struct array_access){ mid, off - moff }))
+				return -E2BIG;
 
 			/* skip empty array */
 			if (moff == mtrue_end)
@@ -7772,15 +7813,29 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 
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
@@ -7807,26 +7862,30 @@ int btf_struct_access(struct bpf_verifier_log *log,
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
@@ -7846,6 +7905,54 @@ int btf_struct_access(struct bpf_verifier_log *log,
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
+		if (array_start >= flex_off)
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
@@ -7886,7 +7993,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	if (!type)
 		return false;
 	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL,
-			      walk_flex_arrays);
+			      walk_flex_arrays, NULL, NULL);
 	if (err != WALK_STRUCT)
 		return false;
 
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d4fa98998543..3eaae1452c54 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -632,6 +632,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 	case PTR_TO_MEM:
 	case PTR_TO_BUF:
 	case PTR_TO_TP_BUFFER:
+	case PTR_TO_BTF_ID:
 		/* If the new min/max/var_off satisfy the old ones and
 		 * everything else matches, we are OK.
 		 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 89b1a0aa3a25..a78a9924a610 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6372,6 +6372,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
 	u32 btf_id = 0;
+	s64 min_off;
 	int ret;
 
 	if (!env->allow_ptr_leaks) {
@@ -6387,36 +6388,31 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
 
@@ -6426,6 +6422,18 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
2.55.0
