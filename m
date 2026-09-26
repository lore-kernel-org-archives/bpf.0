Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E23A05C4
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465722; cv=none; b=OZobRnHpU9l0fEdfptrfsW0JkjBVz7ggDznwBDvQ+ph67GwaFLlKXsssTnKuji2M1LCbyLRRTR/WIiuMS+bMVAv6zRUSsW7PHwFDjkbucFle7g2y0U0EGyGhk7R78bl756FG7upHSIGNenjuo7kyQa/cOHAbbbpKjXnq3cwIo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465722; c=relaxed/simple;
	bh=acEpGvFHKuEdEHkOo9qPO7ChRUB8bqZb6gFhJSxFNM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUV5gTV6gQ9bY8HG8JL4Bpe3kUkpwzDoDmThL2yE8e5nX/6s1WHtmo0S2z9h0cn4ibeHJqr7r/8fdzEzheAW3FGn5yhhexh8thoZTD+pOvykY5KpjdNqqIODX2H32rJN+AXQ4NSZcuRwnV4WwE4k7BFRNpClOrvaExw7LREup6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+t6UfFy; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+t6UfFy"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-48870973bddso840538f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465718; x=1791070518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfUnry3yQRy6KcUkVKpDtVYlOJAPNCtGzB3z+KVGzDc=;
        b=q+t6UfFywAw4ejL6ZU/jPBORMAxjCv2Q9i5Op8ve8Gz8TAE2juDe3laD89VfbthoKC
         2qjTf8bXJcpW8HoCHLIOxLuOetO/gSIK5KOFCHczuS+LqwT0kOHtaoQ18+yEtgfA9+f/
         R3PjNKixRFMatr0yt54RCzYc3uDuu1vL5ya2yjGSEYwv5pBW1f1wPqf+7dFH0YRarTZK
         5ll20hG/WwlFJhAgQEbSUdw/axagScrwcejhdm22ffIv0B7qgKIWze88GIAV3UzwOd34
         JIuOellBt8d5jszlcyvAzTtLkF7Fw9DxWlTEqodSjNBo7JjapzSWKx0lZCY6xyMASsEl
         NxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465718; x=1791070518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfUnry3yQRy6KcUkVKpDtVYlOJAPNCtGzB3z+KVGzDc=;
        b=nQat5HtZ8dfz0CIO7GBzArPjyHmmO5zaiF8x6cWkm4ozAZ3W+hEeozYLMqHZZxiV6u
         ER24UfSad9h351TE89nEGVSC5Pf1wFm0oJQNJ3Ff65glC/31Pvl+hvfex6+g6q4YQ7AT
         UccQo79iYZOswkh4qAn6z4YqfOqJ0LuJR+Z4MyO/AFOXfx0hLYuizSF5T/3IpbH2Cchb
         3bGVlbKp4gCGEk7OCcoUKPnNIA3ej3B0TeBLepwAZkhGbVqs/fRBTSt+oez7e6p2QxZo
         ++5/7A3ooO+3YiAj2JWnxYdRZ4Uinjg6BR059meDUbYcRt9+SAMy+TFTMZnMAgEjKsPd
         Bfrw==
X-Gm-Message-State: AFq9FYIfqId+wQQwcUEzjIfJ8UL62OCXSqxsGaROZ/duxbbqWlRlHr17
	Wd9TzKwJZzq/tvzhd6SrhBWNLL5MPFdgG5BIvic2np36jpcee8I0er61UC+NtCNq
X-Gm-Gg: AYBFou2oJfWDU0aC6umkuDMEP+sfr8ZRCQzzyiL8g0BZZrAPJ9Ba8pm4AYqx8SCLbnB
	8O4gbUV7Qwk9wq0hDmjjeO2N3HBvmuVCHHNQOMzrBnqCGLdOUih1D6Gr+dDD4w1rl3p2CstSs7u
	ujKIubESUPmQ6ZHS58p8GapxXyejAkoeiLd98l4krVJCkQuFxp7UsFKEW1wJp2I2nmkxhYTRnVA
	AK7kg640fbMbtwNEqMBK+CRgIJRMmVa3rQIkIUzdTclIhEbPjZKPR9gwxfeQ02YZKOI4IX7nqLd
	6woQk4/+IZ4fz2apmN8jnRjBKs3wmcW/Kx4RFbVDdAvIasdGPxXRxzP/HWnVc95WlrHfW6lZgUS
	pDimfxXqh/UKHy+bnvHWNUx6h3wr78GKhkMxkddimMlUI6xXgH/YnqufLjdVJkMmT3qEjqp9cdm
	fnqTYt3u79Oitb8ihOjLxX45QevIlGBbvqxgu6s6H0oD7Y/C2aS2cVvpyCzilSUeYRVkrW3BSHZ
	FtbO20/i4VzTU62JQAnDvhCaPqPWce+nsA+MRJNY+9GiDqTiDezywD6i7M69IFpb1k6v/Z8c4ZR
	r7fm66RKvYXXvVAO4MvurRQLJZvXcRzlLlmKpw==
X-Received: by 2002:adf:e197:0:b0:488:8cf8:1c with SMTP id ffacd0b85a97d-4888cf80236mr928578f8f.0.1790465717603;
        Sat, 26 Sep 2026 16:35:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a74538asm16375248f8f.34.2026.09.26.16.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 07/16] bpf: Trust typed pointer fields of typed arena objects
Date: Sun, 27 Sep 2026 01:34:45 +0200
Message-ID: <20260926233503.3114147-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25141; i=memxor@gmail.com; h=from:subject; bh=acEpGvFHKuEdEHkOo9qPO7ChRUB8bqZb6gFhJSxFNM0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWNzlGn8x9h2Td/af8O9ifdp4ZnrBI/njrT+XHti9Q 37btXyNjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwk+BMjw+HQ6eynzJcFrd7J /q/13K3L57m+tlnrR+w9rhftt69yJxvD/wQbsbmJb3uaTk3d6F9y9hy/wIfJx//lCfz7MePlVMa 9y/gA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A pointer member of a typed arena object whose pointee is itself a struct
with a typed arena is a typed pointer field: it holds a pointer to an object
of that struct, or 0, and nothing else, because the verifier lets nothing
else be written there. Typed objects live in memory only programs can
write, every store into such a field is a 64-bit store of a typed arena
pointer to the pointee struct at offset zero or of the constant 0, and a
chunk comes back zeroed when it is reused. A stale pointer, to an object
whose chunk was released and claimed again, still names a whole object of
the type. So a 64-bit load from the field gives back a value that is an
object of the pointee type or 0 without a check, and a linked structure in
a typed arena is walked with plain loads: no cast per hop, no annotation.

Detect the fields from BTF alone. A struct is typed when it has a special
field, a kptr today, or a pointer member to a typed struct, taken to the
closure: the closure runs when the program's BTF is parsed, before the
struct records, and is kept in the BTF, so that parsing a record can ask
whether a pointee is typed. A struct whose only pointers are to itself and
that has no special field of its own never joins, and pointer members
tagged as arena pointers are user addresses and stay scalars. The field
becomes a new record kind, BPF_TYPED_PTR, eight bytes aligned to eight like
a kptr, allowed in arrays and nested structs, with nothing to acquire,
release or free. It counts as a special field, so a struct holding only a
pointer to a typed struct, a list head for instance, gets a typed arena of
its own. The same member of a struct allocated with bpf_obj_new() keeps its
old meaning, a plain pointer that loads as a scalar, and so does the same
shape in a map value or in the raw arena, whose memory is not disciplined.

The load yields a new form of typed arena pointer, PTR_UNSANITIZED: the
value is trusted to be an object or 0 but is not canonical, since nothing
masked it into its slot, and it may be 0, which no NULL check is required
to exclude. It survives 64-bit copies, spills and fills, and 64-bit
compares on the raw value, so a loop ends with the usual test against 0. It
may be stored back into a typed pointer field or anywhere a pointer store is
allowed. What it cannot do yet is serve as an address: a load or store
through it, arithmetic on it, or passing it to a call is refused until the
next patch teaches the lowering to sanitize it in place at that point.

Narrower loads and stores of a typed pointer field, stores of anything but
a typed pointer to the pointee or 0, and atomics on the field are rejected,
as the field's invariant depends on them. A struct whose special fields are
only inherited from a nested struct has no record of its own and is refused
at registration rather than treated as a verifier bug.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  12 ++++
 include/linux/bpf_verifier.h |   6 ++
 kernel/bpf/btf.c             | 131 +++++++++++++++++++++++++++++++----
 kernel/bpf/log.c             |   3 +-
 kernel/bpf/syscall.c         |   3 +
 kernel/bpf/verifier.c        | 124 +++++++++++++++++++++++++++++++--
 6 files changed, 260 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 307e0e7c9445..f4c65fabedbf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -218,6 +218,7 @@ enum btf_field_type {
 	BPF_RES_SPIN_LOCK = (1 << 12),
 	BPF_TASK_WORK  = (1 << 13),
 	BPF_RCU_HEAD   = (1 << 14),
+	BPF_TYPED_PTR  = (1 << 15),
 };
 
 enum bpf_cgroup_storage_type {
@@ -451,6 +452,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_task_work";
 	case BPF_RCU_HEAD:
 		return "bpf_rcu_head";
+	case BPF_TYPED_PTR:
+		return "typed_ptr";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -478,6 +481,7 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_TYPED_PTR:
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
@@ -514,6 +518,7 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_TYPED_PTR:
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
@@ -562,6 +567,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_UPTR:
 	case BPF_TASK_WORK:
 	case BPF_RCU_HEAD:
+	case BPF_TYPED_PTR:
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -948,6 +954,12 @@ enum bpf_type_flag {
 	/* MEM is an object in a typed arena, reached through a native pointer. */
 	MEM_ARENA		= BIT(21 + BPF_BASE_TYPE_BITS),
 
+	/*
+	 * MEM_ARENA pointer as loaded from a typed pointer field: an object of
+	 * the type or 0, not yet masked into its slot.
+	 */
+	PTR_UNSANITIZED		= BIT(22 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 135049628313..77e7c4b45a1f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1475,6 +1475,12 @@ static inline bool type_is_local_obj(u32 type)
 	return type & (MEM_ALLOC | MEM_ARENA);
 }
 
+/* A typed arena pointer as a typed pointer field holds it, not yet rounded into its slot. */
+static inline bool type_is_unsanitized_arena_obj(u32 type)
+{
+	return type_is_typed_arena_obj(type) && type_flag(type) & PTR_UNSANITIZED;
+}
+
 static inline bool insn_is_typed_arena_cast(const struct bpf_insn *insn)
 {
 	return insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->off == BPF_TYPED_ARENA_CAST;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6a29a9d87702..20338a2657cd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -272,6 +272,8 @@ struct btf {
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
 	struct btf_layout *layout;
+	/* structs with special fields, closed over plain pointers to them; see btf_find_kptr() */
+	unsigned long *typed_structs;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1890,6 +1892,7 @@ static void btf_free_struct_ops_tab(struct btf *btf)
 static void btf_free(struct btf *btf)
 {
 	btf_free_struct_meta_tab(btf);
+	bitmap_free(btf->typed_structs);
 	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
 	btf_free_struct_ops_tab(btf);
@@ -3578,6 +3581,11 @@ bool btf_type_is_arena_ptr(const struct btf *btf, const struct btf_type *t)
 	return false;
 }
 
+static bool btf_struct_is_typed(const struct btf *btf, u32 id)
+{
+	return btf->typed_structs && id < btf_nr_types(btf) && test_bit(id, btf->typed_structs);
+}
+
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
@@ -3589,6 +3597,7 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	};
 	struct btf_type_tag_walk_ctx ctx;
 	enum btf_field_type type = 0;
+	const struct btf_type *ptr;
 	int err;
 	u32 res_id;
 
@@ -3598,6 +3607,7 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
+	ptr = t;
 
 	ctx.t = t;
 	err = btf_type_tag_walk(btf, &ctx, kptr_type_tags,
@@ -3609,6 +3619,15 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	res_id = ctx.id;
 	type = ctx.res;
 
+	/*
+	 * A plain pointer to a struct that has a typed arena is a typed pointer
+	 * field: an object of that struct, or NULL, whatever the program wrote.
+	 * Arena pointers are user addresses and stay plain scalars.
+	 */
+	if (!type && field_mask & BPF_TYPED_PTR && __btf_type_is_struct(t) &&
+	    !btf_type_is_arena_ptr(btf, ptr) && btf_struct_is_typed(btf, res_id))
+		type = BPF_TYPED_PTR;
+
 	if (!(type & field_mask))
 		return BTF_FIELD_IGNORE;
 
@@ -3748,7 +3767,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	}
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
-	if (field_mask & (BPF_KPTR | BPF_UPTR) && !__btf_type_is_struct(var_type)) {
+	if (field_mask & (BPF_KPTR | BPF_UPTR | BPF_TYPED_PTR) && !__btf_type_is_struct(var_type)) {
 		type = BPF_KPTR_REF;
 		goto end;
 	}
@@ -3780,6 +3799,7 @@ static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
 		case BPF_UPTR:
+		case BPF_TYPED_PTR:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			break;
@@ -3915,6 +3935,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_TYPED_PTR:
 		ret = btf_find_kptr(btf, var_type, off, sz,
 				    info_cnt ? &info[0] : &tmp, field_mask);
 		if (ret < 0)
@@ -4262,6 +4283,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_TYPED_PTR:
+			/* The pointee is in this BTF, which outlives the record. */
+			rec->fields[i].kptr.btf = (struct btf *)btf;
+			rec->fields[i].kptr.btf_id = info_arr[i].kptr.type_id;
+			break;
 		case BPF_LIST_HEAD:
 			ret = btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
@@ -6162,12 +6188,29 @@ static const char * const alloc_obj_fields[] = {
 	"bpf_refcount",
 };
 
+/*
+ * Whether a struct holds a typed pointer field, given the typed structs known
+ * so far. Every struct of the BTF is scanned, kernel structs pulled in from
+ * vmlinux.h included, and the scan can fail on members a typed arena object
+ * could not have, such as pointers with kernel type tags: a failure does not
+ * make a struct typed. A struct that a program registers is parsed again then,
+ * and that parse reports what is wrong with it.
+ */
+static bool btf_struct_has_typed_ptr(const struct btf *btf, const struct btf_type *t)
+{
+	struct btf_field_info info[BTF_FIELDS_MAX];
+
+	return btf_find_field(btf, t, BPF_TYPED_PTR, info, ARRAY_SIZE(info)) > 0;
+}
+
 static struct btf_struct_metas *
 btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 {
 	struct btf_struct_metas *tab = NULL;
+	unsigned long *typed = NULL;
 	struct btf_id_set *aof;
 	int i, n, id, ret;
+	bool changed;
 
 	BUILD_BUG_ON(offsetof(struct btf_id_set, cnt) != 0);
 	BUILD_BUG_ON(sizeof(struct btf_id_set) != sizeof(u32));
@@ -6231,26 +6274,65 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 	}
 	sort(&aof->ids, aof->cnt, sizeof(aof->ids[0]), btf_id_cmp_func, NULL);
 
+	/*
+	 * The structs with special fields, and their closure over plain
+	 * pointers: a pointer member to a struct with special fields is a typed
+	 * pointer field, itself a special field, so the struct holding it joins
+	 * the set, and so on until nothing changes. A struct whose only pointers
+	 * are to itself, with no special field of its own, never joins. The set
+	 * is published in the btf before the records are parsed, since parsing
+	 * consults it for every pointer member.
+	 */
+	typed = bitmap_zalloc(n, GFP_KERNEL | __GFP_NOWARN);
+	if (!typed) {
+		ret = -ENOMEM;
+		goto free_aof;
+	}
 	for (i = 1; i < n; i++) {
-		struct btf_struct_metas *new_tab;
 		const struct btf_member *member;
-		struct btf_struct_meta *type;
-		struct btf_record *record;
 		const struct btf_type *t;
-		int j, tab_cnt;
+		int j;
 
 		t = btf_type_by_id(btf, i);
 		if (!__btf_type_is_struct(t))
 			continue;
+		for_each_member(j, t, member) {
+			if (btf_id_set_contains(aof, member->type)) {
+				set_bit(i, typed);
+				break;
+			}
+		}
+	}
+	btf->typed_structs = typed;
+	do {
+		changed = false;
+		for (i = 1; i < n; i++) {
+			const struct btf_type *t;
+
+			t = btf_type_by_id(btf, i);
+			if (!__btf_type_is_struct(t) || test_bit(i, typed))
+				continue;
+			cond_resched();
+			if (btf_struct_has_typed_ptr(btf, t)) {
+				set_bit(i, typed);
+				changed = true;
+			}
+		}
+	} while (changed);
+
+	for (i = 1; i < n; i++) {
+		struct btf_struct_metas *new_tab;
+		struct btf_struct_meta *type;
+		struct btf_record *record;
+		const struct btf_type *t;
+		int tab_cnt;
+
+		if (!test_bit(i, typed))
+			continue;
+		t = btf_type_by_id(btf, i);
 
 		cond_resched();
 
-		for_each_member(j, t, member) {
-			if (btf_id_set_contains(aof, member->type))
-				goto parse;
-		}
-		continue;
-	parse:
 		tab_cnt = tab ? tab->cnt : 0;
 		new_tab = krealloc(tab, struct_size(new_tab, types, tab_cnt + 1),
 				   GFP_KERNEL | __GFP_NOWARN);
@@ -6266,10 +6348,12 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		type->btf_id = i;
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
 						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
-						  BPF_KPTR, t->size);
+						  BPF_KPTR | BPF_TYPED_PTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
+			bpf_log(log, "struct %s has an invalid layout of special fields: %d\n",
+				__btf_name_by_offset(btf, t->name_off), ret);
 			goto free;
 		}
 		type->record = record;
@@ -6279,6 +6363,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 	return tab;
 free:
 	btf_struct_metas_free(tab);
+	bitmap_free(typed);
+	btf->typed_structs = NULL;
 free_aof:
 	kfree(aof);
 	return ERR_PTR(ret);
@@ -7782,6 +7868,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	u32 id = reg->btf_id;
 	int err;
 
+	t = btf_type_by_id(btf, id);
 	while (type_is_local_obj(reg->type)) {
 		struct btf_struct_meta *meta;
 		struct btf_record *rec;
@@ -7795,6 +7882,25 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			struct btf_field *field = &rec->fields[i];
 			u32 offset = field->offset;
 			if (off < offset + field->size && offset < off + size) {
+				if (field->type == BPF_TYPED_PTR) {
+					/*
+					 * A typed pointer field is only special in a
+					 * typed arena object, where it is read and
+					 * written whole. In an allocated object it is
+					 * the plain pointer member it always was.
+					 */
+					if (!type_is_typed_arena_obj(reg->type))
+						continue;
+					if (off != offset || size != field->size) {
+						bpf_log(log,
+							"typed pointer field of struct %s must be accessed with a 64-bit load or store\n",
+							__btf_name_by_offset(btf, t->name_off));
+						return -EACCES;
+					}
+					*next_btf_id = field->kptr.btf_id;
+					*flag = MEM_ARENA | PTR_UNSANITIZED;
+					return PTR_TO_BTF_ID;
+				}
 				bpf_log(log,
 					"direct access to %s is disallowed\n",
 					btf_field_type_name(field->type));
@@ -7804,7 +7910,6 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		break;
 	}
 
-	t = btf_type_by_id(btf, id);
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag,
 				      field_name, !type_is_local_obj(reg->type));
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 1ae29a08a607..f2319e9f0fa6 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -432,7 +432,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 			strscpy(postfix, "_or_null");
 	}
 
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s",
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s%s%s",
 		 type & MEM_RDONLY ? "rdonly_" : "",
 		 type & MEM_RINGBUF ? "ringbuf_" : "",
 		 type & MEM_USER ? "user_" : "",
@@ -440,6 +440,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 		 type & MEM_RCU ? "rcu_" : "",
 		 type & PTR_UNTRUSTED ? "untrusted_" : "",
 		 type & PTR_TRUSTED ? "trusted_" : "",
+		 type & PTR_UNSANITIZED ? "unsanitized_" : "",
 		 type & MEM_ARENA ? "typed_arena_" : ""
 	);
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ac52f4ae414c..c989a29e1ba7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -688,6 +688,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_WORKQUEUE:
 		case BPF_TASK_WORK:
 		case BPF_RCU_HEAD:
+		case BPF_TYPED_PTR:
 			/* Nothing to release */
 			break;
 		default:
@@ -743,6 +744,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_WORKQUEUE:
 		case BPF_TASK_WORK:
 		case BPF_RCU_HEAD:
+		case BPF_TYPED_PTR:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -877,6 +879,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
 		case BPF_RCU_HEAD:
+		case BPF_TYPED_PTR:
 			break;
 		default:
 			WARN_ON_ONCE(1);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f854d8419fff..5ca5fc4696d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -358,6 +358,9 @@ static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_stat
 	type = reg->type;
 	if (type_may_be_null(type))
 		return false;
+	/* A typed pointer field holds an object or 0, and its load is neither checked nor masked. */
+	if (type_flag(type) & PTR_UNSANITIZED)
+		return false;
 
 	/*
 	 * The types below guarantee a non-NULL base, an unbounded offset can
@@ -379,6 +382,23 @@ static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_stat
 		type == CONST_PTR_TO_MAP;
 }
 
+/*
+ * @regno is about to serve as an address, or go to a call. A typed arena
+ * pointer loaded from a typed pointer field is not canonical yet: its slice
+ * and slot are what the field's discipline promises, not what the lowering has
+ * masked, and until the lowering learns to sanitize it in place such a use is
+ * refused.
+ */
+static int typed_arena_use(struct bpf_verifier_env *env, int regno)
+{
+	struct bpf_reg_state *reg = &cur_regs(env)[regno];
+
+	if (!type_is_unsanitized_arena_obj(reg->type))
+		return 0;
+	verbose(env, "R%d unsanitized typed arena pointer cannot be dereferenced\n", regno);
+	return -EACCES;
+}
+
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 {
 	struct btf_record *rec = NULL;
@@ -6328,6 +6348,61 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 					  "__safe_trusted_or_null");
 }
 
+/*
+ * A typed pointer field of a typed arena object holds a pointer to an object
+ * of the pointee struct, or 0, and nothing else. Only a 64-bit store of a
+ * typed arena pointer to that struct at offset 0, sanitized or not, or of the
+ * constant 0, may write it, and only a plain 64-bit load may read it. The load
+ * yields the value as stored: an unsanitized typed arena pointer, which the
+ * write discipline makes trustworthy without a check.
+ */
+static int check_typed_ptr_field_access(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
+					struct bpf_reg_state *reg, const char *tname, u32 btf_id,
+					enum bpf_access_type atype, int value_regno)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[env->insn_idx];
+	u8 class = BPF_CLASS(insn->code);
+	struct bpf_reg_state *val;
+	struct bpf_typed_arena *ta;
+
+	if (BPF_MODE(insn->code) != BPF_MEM || BPF_SIZE(insn->code) != BPF_DW ||
+	    (class != BPF_LDX && class != BPF_STX && class != BPF_ST)) {
+		verbose(env, "typed pointer field of struct %s must be accessed with a 64-bit load or store\n",
+			tname);
+		return -EACCES;
+	}
+	if (atype == BPF_READ) {
+		/*
+		 * The pointer leads into the pointee's typed arena, which the
+		 * program may never cast to or allocate from: register it here,
+		 * as a cast would, so that the sanitization has a slice to mask
+		 * into and the slice exists for the map's lifetime.
+		 */
+		ta = typed_arena_register(env, btf_id);
+		if (IS_ERR(ta))
+			return PTR_ERR(ta);
+		return mark_btf_ld_reg(env, regs, value_regno, PTR_TO_BTF_ID, reg->btf, btf_id,
+				       MEM_ARENA | PTR_UNSANITIZED);
+	}
+
+	if (class == BPF_ST) {
+		if (!insn->imm)
+			return 0;
+	} else {
+		val = &regs[value_regno];
+		if (val->type == SCALAR_VALUE && tnum_is_const(val->var_off) && !val->var_off.value)
+			return 0;
+		if (type_is_typed_arena_obj(val->type) &&
+		    !(type_flag(val->type) & ~(MEM_ARENA | PTR_UNSANITIZED)) &&
+		    val->btf == reg->btf && val->btf_id == btf_id &&
+		    tnum_is_const(val->var_off) && !val->var_off.value)
+			return 0;
+	}
+	verbose(env, "store into typed pointer field of struct %s expects a typed arena pointer to struct %s or NULL\n",
+		tname, btf_name_by_offset(reg->btf, btf_type_by_id(reg->btf, btf_id)->name_off));
+	return -EACCES;
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs, struct bpf_reg_state *reg,
 				   argno_t argno, int off, int size,
@@ -6433,6 +6508,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	if (ret == PTR_TO_BTF_ID && flag & MEM_ARENA)
+		return check_typed_ptr_field_access(env, regs, reg, tname, btf_id, atype, value_regno);
+
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -7170,6 +7248,10 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
+	err = typed_arena_use(env, insn->src_reg);
+	if (err)
+		return err;
+
 	/* check dst operand */
 	err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 	if (err)
@@ -7221,6 +7303,10 @@ static int check_store_reg(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err)
 		return err;
 
+	err = typed_arena_use(env, insn->dst_reg);
+	if (err)
+		return err;
+
 	dst_reg_type = regs[insn->dst_reg].type;
 
 	/* Check if (dst_reg + off) is writeable. */
@@ -7273,6 +7359,10 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	err = typed_arena_use(env, insn->dst_reg);
+	if (err)
+		return err;
+
 	if (!atomic_ptr_type_ok(env, insn->dst_reg, insn)) {
 		verbose(env, "BPF_ATOMIC stores into R%d %s is not allowed\n",
 			insn->dst_reg,
@@ -9386,6 +9476,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		return 0;
 	}
 
+	/* Every register argument reaches the callee, an ignored one included. */
+	if (regno >= 0) {
+		err = typed_arena_use(env, regno);
+		if (err)
+			return err;
+	}
+
 	if (arg_type == ARG_IGNORE)
 		return 0;
 
@@ -16811,6 +16908,15 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		aux->prevent_zext = true;
 	}
 
+	/* Arithmetic moves a typed arena pointer within its object, which needs the object. */
+	if (BPF_CLASS(insn->code) == BPF_ALU64) {
+		err = typed_arena_use(env, insn->dst_reg);
+		if (!err && src_reg)
+			err = typed_arena_use(env, insn->src_reg);
+		if (err)
+			return err;
+	}
+
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
 
@@ -16948,8 +17054,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 #define BPF_TYPED_ARENA_FIELDS \
 	(BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD | \
 	 BPF_LIST_NODE | BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT | BPF_WORKQUEUE | \
-	 BPF_UPTR | BPF_TASK_WORK | BPF_RCU_HEAD)
-#define BPF_TYPED_ARENA_SUPPORTED_FIELDS BPF_KPTR
+	 BPF_UPTR | BPF_TASK_WORK | BPF_RCU_HEAD | BPF_TYPED_PTR)
+#define BPF_TYPED_ARENA_SUPPORTED_FIELDS (BPF_KPTR | BPF_TYPED_PTR)
 
 /*
  * The size of a struct's typed arena is a declared resource, read from the
@@ -17031,11 +17137,15 @@ static struct bpf_typed_arena *typed_arena_register(struct bpf_verifier_env *env
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 	btf_record_free(record);
-	/* BTF keeps a record for every struct with these fields. */
+	/*
+	 * BTF keeps a record for every struct with these fields as direct
+	 * members; one that only inherits them from a nested struct has none.
+	 */
 	meta = btf_find_struct_meta(btf, btf_id);
 	if (!meta) {
-		verifier_bug(env, "struct %s has special fields but no metadata", tname);
-		return ERR_PTR(-EFAULT);
+		verbose(env, "struct %s has special fields only in a nested struct, which a typed arena does not support\n",
+			tname);
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	err = typed_arena_size(env, btf, t, tname, &size, &value);
@@ -19569,6 +19679,10 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 		if (err)
 			return err;
 
+		err = typed_arena_use(env, insn->dst_reg);
+		if (err)
+			return err;
+
 		dst_reg_type = cur_regs(env)[insn->dst_reg].type;
 
 		err = check_mem_access(env, env->insn_idx, cur_regs(env) + insn->dst_reg, argno_from_reg(insn->dst_reg),
-- 
2.53.0

