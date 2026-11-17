Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951380;
	b=F1s1nKUqmGMbddiv4ThhnNcx9Trbk78yzAqortXYTgHExtX6UZ78J3wE3JwJq5fhe8Ol
	 HTHRYZYdk/TaZ/EnKqqbQYiTplqDPPw7YeG4xocbBgLj4WvYl+n16498Jb8f7nPgi6pcC
	 F9R273qoOM1LEHIH4Fa52YWRIgA9CMGb+Ajv1mGgmiG/EfcM/ohRNkJsV1BZYvoMiAdVm
	 Gzw66bSiQQ07t8ZriJWlhS4kvthM0WXtgJeWQPA7SLP7BRewsT7tLue/ggIQzM4C3lSdq
	 WpKBTT65PMmY6uzZJoiwb57LZmaRg1cwI0p/giy4aJhKYkI1Ja52YDEz2Q2oOy6ALHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951380;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=tGu9tniT0HTRbstRlbIxO1WwovePQfrHyIVpSk6swGg=;
	b=HRUVRSdzmq1rCpgLATVUHtxk3DSZ6vQpEt9Nmn1l3knAOfy9/kpdxSLoUygt/nJ0dUwU
	 FywUrSiXfijBt8Z1ldCQheKJF5Yop38tceUcUoKZp+kp/eW2ciRJzL+OdvmxHjcgxMu7W
	 cDeRalLczsTEWwMM0LsH+g1dC/1wbGbSK65uQdXz8HfNP+WFL7VaA9/Vx+O7DiBZhJshR
	 bWvKjBNF6LTXsvijXlwVMsee+d98mWn0D1q3SUhgkdDLxfyStgxxBM21BkIBtog/NQlxb
	 dKcV4MHYDt+tlfLe+0miz8yRuJxx51rp65QsTWF6paosMdfVmbInZiQPSOPlU1PXEiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D1I/3TKd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71575606A31C;
	Tue, 17 Nov 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1I/3TKd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C221F000C4;
	Tue, 17 Nov 2026 21:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794951380;
	bh=tGu9tniT0HTRbstRlbIxO1WwovePQfrHyIVpSk6swGg=;
	h=Date:From:To:Cc:Subject;
	b=D1I/3TKdZJXn96Ol+W7mQqQL6YewfSOROTyhVII6rNVwSRW7JpJebYof5uNDT10lz
	 04pBpAUEVTlxi3QtJueUaZF6HcL4Cyu0cenU4csvGNcx7hfEMdNRKPUxNpAxxP/ik+
	 EYfUJEMok/4G1jXs1SEIUMZRLtDqvMZtTDTjdN+p93ZmFNEOIIGD7DImKZ5v9QrC8w
	 4xFDypkhCO+Xc2OTCSVan4lbkGU80uc1yJY5TeLQa2qq3rvB5vk88P4DFRSm4SuVsO
	 M2xsMlRQmL+RsaTljIZHvSiWwfmM/s/tT1VoLoY32chQupaRHeJzhZ7ctAsgAMr7ZU
	 S8bJlUvWFCO3g==
Date: Tue, 17 Nov 2026 21:36:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <avzIz70qnJIA2t3x@sirena.org.uk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FyCdLcCvqJgJM9uc"
Content-Disposition: inline


--FyCdLcCvqJgJM9uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/btf.c

between commit:

  b7cc45994c3f9 ("bpf: Check variable-offset accesses against special field=
s")

=66rom the bpf tree and commit:

  ca4395aade31a ("bpf: Walk each type once when looking for special fields")

=66rom the bpf-next tree.  I'm not confident of this merge, it discards
the bpf commit on the basis that it looks like there is some new
handling of special fields in the bpf-next tree but I'm not sure that
overlaps with the fix.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined kernel/bpf/btf.c
index 49fcd32d418a9,e95ca39f990c6..0000000000000
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@@ -281,6 -281,7 +281,7 @@@ struct btf=20
  	char name[MODULE_NAME_LEN];
  	bool kernel_btf;
  	__u32 *base_id_map; /* map from distilled base BTF -> vmlinux BTF ids */
+ 	u32 *next_tag; /* see btf_link_decl_tags() */
  };
 =20
  enum verifier_phase {
@@@ -308,6 -309,9 +309,9 @@@ enum resolve_mode=20
  					 */
  };
 =20
+ /* It bounds the time of the loops that compare or print names */
+ #define BTF_MAX_NAME_LEN 4096
+=20
  #define MAX_RESOLVE_DEPTH 32
 =20
  struct btf_sec_info {
@@@ -319,6 -323,7 +323,7 @@@ struct btf_verifier_env=20
  	struct btf *btf;
  	u8 *visit_states;
  	struct resolve_vertex stack[MAX_RESOLVE_DEPTH];
+ 	unsigned long *names;	/* offsets of the strings that can be names */
  	struct bpf_verifier_log log;
  	u32 log_type_id;
  	u32 top_stack;
@@@ -684,10 -689,15 +689,15 @@@ s32 btf_find_by_name_kind(const struct=20
  				return id;
  		}
  	} else {
+ 		/* only the tags in BTF of a program have long names */
+ 		bool slow =3D !btf->kernel_btf && strlen(name) > KSYM_NAME_LEN;
+=20
  		for (id =3D btf_start_id(btf); id < total; id++) {
  			t =3D btf_type_by_id(btf, id);
  			if (BTF_INFO_KIND(t->info) !=3D kind)
  				continue;
+ 			if (slow && bpf_must_abort())
+ 				return -EINTR;
  			tname =3D btf_name_by_offset(btf, t->name_off);
  			if (strcmp(tname, name) =3D=3D 0)
  				return id;
@@@ -914,49 -924,6 +924,6 @@@ const char *btf_str_by_offset(const str
  	return NULL;
  }
 =20
- /* Names in BTF of Rust are not C identifiers. Allow any printable charac=
ter */
- static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
- {
- 	/* offset must be valid */
- 	const char *src =3D btf_str_by_offset(btf, offset);
- 	const char *src_limit;
-=20
- 	if (!isprint(*src))
- 		return false;
-=20
- 	/* set a limit on identifier length */
- 	src_limit =3D src + KSYM_NAME_LEN;
- 	src++;
- 	while (*src && src < src_limit) {
- 		if (!isprint(*src))
- 			return false;
- 		src++;
- 	}
-=20
- 	return !*src;
- }
-=20
- /* Allow any printable character in DATASEC names */
- static bool btf_name_valid_section(const struct btf *btf, u32 offset)
- {
- 	/* offset must be valid */
- 	const char *src =3D btf_str_by_offset(btf, offset);
- 	const char *src_limit;
-=20
- 	if (!*src)
- 		return false;
-=20
- 	/* set a limit on identifier length */
- 	src_limit =3D src + KSYM_NAME_LEN;
- 	while (*src && src < src_limit) {
- 		if (!isprint(*src))
- 			return false;
- 		src++;
- 	}
-=20
- 	return !*src;
- }
-=20
  static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
  {
  	const char *name;
@@@ -1907,6 -1874,7 +1874,7 @@@ static void btf_free(struct btf *btf
  	if (!btf_is_vmlinux(btf))
  		kvfree(btf->data);
  	kvfree(btf->base_id_map);
+ 	kvfree(btf->next_tag);
  	kfree(btf);
  }
 =20
@@@ -1991,9 -1959,21 +1959,21 @@@ nomem
  static void btf_verifier_env_free(struct btf_verifier_env *env)
  {
  	kvfree(env->visit_states);
+ 	kvfree(env->names);
  	kfree(env);
  }
 =20
+ /* Names in BTF of Rust are not C identifiers. Allow any printable charac=
ter */
+ static bool btf_name_valid(const struct btf_verifier_env *env, u32 offset)
+ {
+ 	const struct btf *btf =3D env->btf;
+=20
+ 	/* offset must be valid */
+ 	if (offset < btf->start_str_off)
+ 		return *btf_str_by_offset(btf, offset);
+ 	return test_bit(offset - btf->start_str_off, env->names);
+ }
+=20
  static bool env_type_is_resolve_sink(const struct btf_verifier_env *env,
  				     const struct btf_type *next_type)
  {
@@@ -2766,7 -2746,7 +2746,7 @@@ static int btf_ref_type_check_meta(stru
  	 */
  	if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPEDEF) {
  		if (!t->name_off ||
- 		    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 		    !btf_name_valid(env, t->name_off)) {
  			btf_verifier_log_type(env, t, "Invalid name");
  			return -EINVAL;
  		}
@@@ -3028,7 -3008,7 +3008,7 @@@ static s32 btf_fwd_check_meta(struct bt
 =20
  	/* fwd type must have a valid name */
  	if (!t->name_off ||
- 	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -3351,7 -3331,7 +3331,7 @@@ static s32 btf_struct_check_meta(struc
 =20
  	/* struct type either no name or a valid one */
  	if (t->name_off &&
- 	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -3369,7 -3349,7 +3349,7 @@@
 =20
  		/* struct member either no name or a valid one */
  		if (member->name_off &&
- 		    !btf_name_valid_identifier(btf, member->name_off)) {
+ 		    !btf_name_valid(env, member->name_off)) {
  			btf_verifier_log_member(env, t, member, "Invalid name");
  			return -EINVAL;
  		}
@@@ -3636,13 -3616,45 +3616,45 @@@ static int btf_find_kptr(const struct b
  	return BTF_FIELD_FOUND;
  }
 =20
+ /* For BTF of programs: next_tag[type] -> its first tag, next_tag[tag] ->=
 its next tag, ... 0 */
+ static int btf_link_decl_tags(struct btf *btf)
+ {
+ 	u32 i;
+=20
+ 	btf->next_tag =3D kvcalloc(btf->nr_types, sizeof(u32), GFP_KERNEL | __GF=
P_NOWARN);
+ 	if (!btf->next_tag)
+ 		return -ENOMEM;
+ 	for (i =3D btf->nr_types; --i;) {
+ 		if (!btf_type_is_decl_tag(btf->types[i]))
+ 			continue;
+ 		btf->next_tag[i] =3D btf->next_tag[btf->types[i]->type];
+ 		btf->next_tag[btf->types[i]->type] =3D i;
+ 	}
+ 	return 0;
+ }
+=20
+ static int btf_type_ptr_cmp(const void *a, const void *b)
+ {
+ 	return cmp_int(*(void **)a, *(void **)b);
+ }
+=20
+ /* last_id is 0 for the first tag */
  int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *=
pt,
  			   int comp_idx, const char *tag_key, int last_id)
  {
+ 	int i =3D last_id ?: btf_named_start_id(btf, false) - 1, n =3D btf_nr_ty=
pes(btf);
  	int len =3D strlen(tag_key);
- 	int i, n;
+ 	struct btf_type **p;
 =20
- 	for (i =3D last_id + 1, n =3D btf_nr_types(btf); i < n; i++) {
+ 	if (btf->next_tag && !last_id) {
+ 		/* the types are in the order of their ids in btf->data */
+ 		p =3D bsearch(&pt, btf->types + 1, n - 1, sizeof(*p), btf_type_ptr_cmp);
+ 		if (!p)
+ 			return -ENOENT;
+ 		i =3D p - btf->types;
+ 	}
+=20
+ 	while ((i =3D btf->next_tag ? btf->next_tag[i] ?: n : i + 1) < n) {
  		const struct btf_type *t =3D btf_type_by_id(btf, i);
 =20
  		if (!btf_type_is_decl_tag(t))
@@@ -3665,8 -3677,7 +3677,7 @@@ const char *btf_find_decl_tag_value(con
  	const struct btf_type *t;
  	int len, id;
 =20
- 	id =3D btf_find_next_decl_tag(btf, pt, comp_idx, tag_key,
- 				    btf_named_start_id(btf, false) - 1);
+ 	id =3D btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
  	if (id < 0)
  		return ERR_PTR(id);
 =20
@@@ -3682,6 -3693,36 +3693,36 @@@
  	return value;
  }
 =20
+ /*
+  * The value of the decl tag "<tag_key><value>" on a function of the kern=
el or of
+  * a module. The build sorts their BTF by name: the tags with one key are
+  * neighbours, and so are those with one value.
+  *
+  * Only the own types of btf are searched, not its base. With the BTF of =
a module
+  * func_id can be a FUNC of vmlinux: it stands for the function of that n=
ame in the
+  * module. What the build found in the code of vmlinux is not true for it.
+  */
+ const char *btf_find_func_tag_value(const struct btf *btf, u32 func_id, c=
onst char *tag_key)
+ {
+ 	int id, n =3D btf_nr_types(btf), len =3D strlen(tag_key);
+ 	const char *name =3D NULL;
+ 	u32 name_off =3D 0;
+=20
+ 	for (id =3D btf_find_by_name_kind_bsearch(btf, tag_key); id < n; id++) {
+ 		const struct btf_type *t =3D btf_type_by_id(btf, id);
+=20
+ 		if (t->name_off !=3D name_off) {
+ 			name_off =3D t->name_off;
+ 			name =3D btf_name_by_offset(btf, name_off);
+ 			if (strncmp(name, tag_key, len))
+ 				break;
+ 		}
+ 		if (t->type =3D=3D func_id && btf_type_is_decl_tag(t))
+ 			return name + len;
+ 	}
+ 	return NULL;
+ }
+=20
  static int
  btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
  		    const struct btf_type *t, int comp_idx, u32 off,
@@@ -3773,106 -3814,106 +3814,106 @@@ end
  	return type;
  }
 =20
- /* Repeat a number of fields for a specified number of times.
+ /*
+  * A walk over the members of a type and of the structs in it. A struct i=
s entered once.
+  * The next member of that type gets a copy of the fields that were found:
   *
-  * Copy the fields starting from the first field and repeat them for
-  * repeat_cnt times. The fields are repeated by adding the offset of each
-  * field with
-  *   (i + 1) * elem_size
-  * where i is the repeat index and elem_size is the size of an element.
+  *   struct in  { kptr p; };
+  *   struct out { struct in a; long x; struct in b[2]; };
+  *                enter 'in'           copy from a, twice
   */
- static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
- 			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
+ struct btf_field_walk {
+ 	struct btf_field_info *info;
+ 	u32 cnt;
+ 	u32 field_mask;
+ 	u32 seen_mask;
+ 	struct btf_field_scope {
+ 		const struct btf_type *t;
+ 		u32 off;	/* in the outer type */
+ 		u32 nelems;
+ 		u32 first;	/* its fields in 'info' */
+ 		u32 cnt;
+ 		u32 next;	/* member to look at */
+ 		u32 parent;
+ 	} *scopes;
+ 	u32 scope;		/* the current one */
+ 	struct bpf_index index;	/* address of the type -> scope */
+ };
+=20
+ /* An allocated object has 4096 bytes at most */
+ #define BTF_OBJ_FIELDS_MAX (SZ_4K / sizeof(u64))
+=20
+ static int btf_add_field(struct btf_field_walk *w, struct btf_field_info =
info)
  {
- 	u32 i, j, total_cnt, total_repeats;
- 	u32 cur;
-=20
- 	/* Ensure not repeating fields that should not be repeated. */
- 	for (i =3D 0; i < field_cnt; i++) {
- 		switch (info[i].type) {
- 		case BPF_KPTR_UNREF:
- 		case BPF_KPTR_REF:
- 		case BPF_KPTR_PERCPU:
- 		case BPF_UPTR:
- 		case BPF_LIST_HEAD:
- 		case BPF_RB_ROOT:
- 			break;
- 		default:
- 			return -EINVAL;
- 		}
- 	}
-=20
- 	if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
- 	    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
- 	    total_cnt > (u32)info_cnt)
- 		return -E2BIG;
-=20
- 	cur =3D field_cnt;
- 	for (i =3D 0; i < repeat_cnt; i++) {
- 		memcpy(&info[cur], &info[0], field_cnt * sizeof(info[0]));
- 		for (j =3D 0; j < field_cnt; j++)
- 			info[cur++].off +=3D (i + 1) * elem_size;
- 	}
+ 	struct btf_field_info *last =3D w->cnt ? &w->info[w->cnt - 1] : NULL;
 =20
+ 	if (last && info.off < last->off + btf_field_type_size(last->type))
+ 		return -EEXIST;
+ 	if ((w->field_mask & BPF_GRAPH_NODE) && w->cnt =3D=3D BTF_OBJ_FIELDS_MAX)
+ 		return -EFBIG;
+ 	if (bpf_must_abort())
+ 		return -EINTR;
+ 	if (!bpf_table_next(w->info, w->cnt))
+ 		return -ENOMEM;
+ 	w->info[w->cnt++] =3D info;
  	return 0;
  }
 =20
- static int btf_find_struct_field(const struct btf *btf,
- 				 const struct btf_type *t, u32 field_mask,
- 				 struct btf_field_info *info, int info_cnt,
- 				 u32 level, u32 *seen_mask);
-=20
- /* Find special fields in the struct type of a field.
-  *
-  * This function is used to find fields of special types that is not a
-  * global variable or a direct field of a struct type. It also handles the
-  * repetition if it is the element type of an array.
-  */
- static int btf_find_nested_struct(const struct btf *btf, const struct btf=
_type *t,
- 				  u32 off, u32 nelems,
- 				  u32 field_mask, struct btf_field_info *info,
- 				  int info_cnt, u32 level, u32 *seen_mask)
+ /* Copy 'cnt' fields from 'first' on to 'nelems' elements. The first copy=
 is 'by' bytes off. */
+ static int btf_repeat_fields(struct btf_field_walk *w, u32 first, u32 cnt=
, u32 by,
+ 			     u32 nelems, u32 elem_size, bool array)
  {
- 	int ret, err, i;
+ 	struct btf_field_info info;
+ 	u32 i, j;
+ 	int err;
 =20
- 	level++;
- 	if (level >=3D MAX_RESOLVE_DEPTH)
- 		return -E2BIG;
-=20
- 	ret =3D btf_find_struct_field(btf, t, field_mask, info, info_cnt, level,=
 seen_mask);
-=20
- 	if (ret <=3D 0)
- 		return ret;
-=20
- 	/* Shift the offsets of the nested struct fields to the offsets
- 	 * related to the container.
- 	 */
- 	for (i =3D 0; i < ret; i++)
- 		info[i].off +=3D off;
-=20
- 	if (nelems > 1) {
- 		err =3D btf_repeat_fields(info, info_cnt, ret, nelems - 1, t->size);
- 		if (err =3D=3D 0)
- 			ret *=3D nelems;
- 		else
- 			ret =3D err;
+ 	for (i =3D 0; i < nelems && cnt; i++, by +=3D elem_size) {
+ 		for (j =3D first; j < first + cnt; j++) {
+ 			info =3D w->info[j];
+ 			info.off +=3D by;
+ 			if (array && !(info.type & (BPF_KPTR | BPF_UPTR | BPF_GRAPH_ROOT)))
+ 				return -EINVAL;
+ 			if (info.type & w->seen_mask)
+ 				return -E2BIG;
+ 			err =3D btf_add_field(w, info);
+ 			if (err)
+ 				return err;
+ 		}
  	}
+ 	return 0;
+ }
 =20
- 	return ret;
+ static int btf_enter_struct(struct btf_field_walk *w, const struct btf_ty=
pe *t, u32 off, u32 nelems)
+ {
+ 	int i =3D bpf_index_find(&w->index, (unsigned long)t);
+ 	struct btf_field_scope *s;
+=20
+ 	if (i >=3D 0) {
+ 		s =3D &w->scopes[i];
+ 		return btf_repeat_fields(w, s->first, s->cnt, off - s->off, nelems, t->=
size,
+ 					 nelems > 1);
+ 	}
+ 	i =3D w->index.cnt;
+ 	s =3D bpf_table_next(w->scopes, i);
+ 	if (!s || bpf_index_add(&w->index, (unsigned long)t, i))
+ 		return -ENOMEM;
+ 	*s =3D (struct btf_field_scope){
+ 		.t =3D t, .off =3D off, .nelems =3D nelems, .first =3D w->cnt, .parent =
=3D w->scope,
+ 	};
+ 	w->scope =3D i;
+ 	return 0;
  }
 =20
  static int btf_find_field_one(const struct btf *btf,
  			      const struct btf_type *var,
  			      const struct btf_type *var_type,
  			      int var_idx,
- 			      u32 off, u32 expected_size,
- 			      u32 field_mask, u32 *seen_mask,
- 			      struct btf_field_info *info, int info_cnt,
- 			      u32 level)
+ 			      u32 base, u32 off, u32 expected_size,
+ 			      struct btf_field_walk *w)
  {
  	int ret, align, sz, field_type;
- 	struct btf_field_info tmp;
  	const struct btf_array *array;
+ 	struct btf_field_info info;
  	u32 i, nelems =3D 1;
 =20
  	/* Walk into array types to find the element type and the number of
@@@ -3889,15 -3930,13 +3930,13 @@@
  		return 0;
 =20
  	field_type =3D btf_get_field_type(btf, var_type,
- 					field_mask, seen_mask, &align, &sz);
+ 					w->field_mask, &w->seen_mask, &align, &sz);
  	/* Look into variables of struct types */
  	if (!field_type && __btf_type_is_struct(var_type)) {
  		sz =3D var_type->size;
  		if (expected_size && expected_size !=3D sz * nelems)
  			return 0;
- 		ret =3D btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
- 					     &info[0], info_cnt, level, seen_mask);
- 		return ret;
+ 		return btf_enter_struct(w, var_type, base + off, nelems);
  	}
 =20
  	if (field_type =3D=3D 0)
@@@ -3909,6 -3948,7 +3948,7 @@@
  		return 0;
  	if (off % align)
  		return 0;
+ 	off +=3D base;
 =20
  	switch (field_type) {
  	case BPF_SPIN_LOCK:
@@@ -3920,8 -3960,7 +3960,7 @@@
  	case BPF_REFCOUNT:
  	case BPF_TASK_WORK:
  	case BPF_RCU_HEAD:
- 		ret =3D btf_find_struct(btf, var_type, off, sz, field_type,
- 				      info_cnt ? &info[0] : &tmp);
+ 		ret =3D btf_find_struct(btf, var_type, off, sz, field_type, &info);
  		if (ret < 0)
  			return ret;
  		break;
@@@ -3929,17 -3968,14 +3968,14 @@@
  	case BPF_KPTR_REF:
  	case BPF_KPTR_PERCPU:
  	case BPF_UPTR:
- 		ret =3D btf_find_kptr(btf, var_type, off, sz,
- 				    info_cnt ? &info[0] : &tmp, field_mask);
+ 		ret =3D btf_find_kptr(btf, var_type, off, sz, &info, w->field_mask);
  		if (ret < 0)
  			return ret;
  		break;
  	case BPF_LIST_HEAD:
  	case BPF_RB_ROOT:
  		ret =3D btf_find_graph_root(btf, var, var_type,
- 					  var_idx, off, sz,
- 					  info_cnt ? &info[0] : &tmp,
- 					  field_type);
+ 					  var_idx, off, sz, &info, field_type);
  		if (ret < 0)
  			return ret;
  		break;
@@@ -3949,81 -3985,51 +3985,51 @@@
 =20
  	if (ret =3D=3D BTF_FIELD_IGNORE)
  		return 0;
- 	if (!info_cnt)
- 		return -E2BIG;
- 	if (nelems > 1) {
- 		ret =3D btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
- 		if (ret < 0)
- 			return ret;
- 	}
- 	return nelems;
- }
-=20
- static int btf_find_struct_field(const struct btf *btf,
- 				 const struct btf_type *t, u32 field_mask,
- 				 struct btf_field_info *info, int info_cnt,
- 				 u32 level, u32 *seen_mask)
- {
- 	int ret, idx =3D 0;
- 	const struct btf_member *member;
- 	u32 i, off;
-=20
- 	for_each_member(i, t, member) {
- 		const struct btf_type *member_type =3D btf_type_by_id(btf,
- 								    member->type);
-=20
- 		off =3D __btf_member_bit_offset(t, member);
- 		if (off % 8)
- 			/* valid C code cannot generate such BTF */
- 			return -EINVAL;
- 		off /=3D 8;
-=20
- 		ret =3D btf_find_field_one(btf, t, member_type, i,
- 					 off, 0,
- 					 field_mask, seen_mask,
- 					 &info[idx], info_cnt - idx, level);
- 		if (ret < 0)
- 			return ret;
- 		idx +=3D ret;
- 	}
- 	return idx;
- }
-=20
- static int btf_find_datasec_var(const struct btf *btf, const struct btf_t=
ype *t,
- 				u32 field_mask, struct btf_field_info *info,
- 				int info_cnt, u32 level, u32 *seen_mask)
- {
- 	int ret, idx =3D 0;
- 	const struct btf_var_secinfo *vsi;
- 	u32 i, off;
-=20
- 	for_each_vsi(i, t, vsi) {
- 		const struct btf_type *var =3D btf_type_by_id(btf, vsi->type);
- 		const struct btf_type *var_type =3D btf_type_by_id(btf, var->type);
-=20
- 		off =3D vsi->offset;
- 		ret =3D btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
- 					 field_mask, seen_mask,
- 					 &info[idx], info_cnt - idx,
- 					 level);
- 		if (ret < 0)
- 			return ret;
- 		idx +=3D ret;
- 	}
- 	return idx;
+ 	return btf_add_field(w, info) ?:
+ 	       btf_repeat_fields(w, w->cnt - 1, 1, sz, nelems - 1, sz, true);
  }
 =20
  static int btf_find_field(const struct btf *btf, const struct btf_type *t,
- 			  u32 field_mask, struct btf_field_info *info,
- 			  int info_cnt)
+ 			  struct btf_field_walk *w)
  {
- 	u32 seen_mask =3D 0;
+ 	const struct btf_var_secinfo *vsi;
+ 	const struct btf_member *member;
+ 	struct btf_field_scope *s;
+ 	const struct btf_type *var;
+ 	u32 i, off;
+ 	int err;
 =20
- 	if (__btf_type_is_struct(t))
- 		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &se=
en_mask);
- 	else if (btf_type_is_datasec(t))
- 		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0, &see=
n_mask);
- 	return -EINVAL;
+ 	if (!__btf_type_is_struct(t) && !btf_type_is_datasec(t))
+ 		return -EINVAL;
+=20
+ 	for (err =3D btf_enter_struct(w, t, 0, 1); !err;) {
+ 		if (bpf_must_abort())
+ 			return -EINTR;
+ 		s =3D &w->scopes[w->scope];
+ 		i =3D s->next++;
+ 		if (i =3D=3D btf_type_vlen(s->t)) {
+ 			if (!w->scope)
+ 				break;
+ 			s->cnt =3D w->cnt - s->first;
+ 			w->scope =3D s->parent;
+ 			err =3D btf_repeat_fields(w, s->first, s->cnt, s->t->size, s->nelems -=
 1,
+ 						s->t->size, true);
+ 		} else if (btf_type_is_datasec(s->t)) {
+ 			vsi =3D btf_type_var_secinfo(s->t) + i;
+ 			var =3D btf_type_by_id(btf, vsi->type);
+ 			err =3D btf_find_field_one(btf, var, btf_type_by_id(btf, var->type), -=
1,
+ 						 0, vsi->offset, vsi->size, w);
+ 		} else {
+ 			member =3D btf_type_member(s->t) + i;
+ 			off =3D __btf_member_bit_offset(s->t, member);
+ 			if (off % 8)
+ 				/* valid C code cannot generate such BTF */
+ 				return -EINVAL;
+ 			err =3D btf_find_field_one(btf, s->t, btf_type_by_id(btf, member->type=
), i,
+ 						 s->off, off / 8, 0, w);
+ 		}
+ 	}
+ 	return err;
  }
 =20
  /* Callers have to ensure the life cycle of btf if it is program BTF */
@@@ -4134,6 -4140,8 +4140,8 @@@ static int btf_parse_graph_root(const s
  	 * verify its type.
  	 */
  	for_each_member(i, t, member) {
+ 		if (bpf_must_abort())
+ 			return -EINTR;
  		if (strcmp(info->graph_root.node_name,
  			   __btf_name_by_offset(btf, member->name_off)))
  			continue;
@@@ -4175,37 -4183,29 +4183,29 @@@ static int btf_parse_rb_root(const stru
  					    __alignof__(struct bpf_rb_node));
  }
 =20
- static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
- {
- 	const struct btf_field *a =3D (const struct btf_field *)_a;
- 	const struct btf_field *b =3D (const struct btf_field *)_b;
-=20
- 	if (a->offset < b->offset)
- 		return -1;
- 	else if (a->offset > b->offset)
- 		return 1;
- 	return 0;
- }
-=20
  struct btf_record *btf_parse_fields(const struct btf *btf, const struct b=
tf_type *t,
  				    u32 field_mask, u32 value_size)
  {
- 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
- 	u32 next_off =3D 0, field_type_size;
+ 	struct btf_field_info *info_arr __free(kvfree) =3D NULL;
+ 	struct btf_field_walk w =3D { .field_mask =3D field_mask };
+ 	u32 field_type_size;
  	struct btf_record *rec;
  	int ret, i, cnt;
 =20
- 	ret =3D btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr=
));
+ 	ret =3D btf_find_field(btf, t, &w);
+ 	kvfree(w.scopes);
+ 	kvfree(w.index.slots);
+ 	info_arr =3D w.info;
  	if (ret < 0)
  		return ERR_PTR(ret);
- 	if (!ret)
+ 	if (!w.cnt)
  		return NULL;
 =20
- 	cnt =3D ret;
+ 	cnt =3D w.cnt;
  	/* This needs to be kzalloc to zero out padding and unused fields, see
  	 * comment in btf_record_equal.
  	 */
- 	rec =3D kzalloc_flex(*rec, fields, cnt, GFP_KERNEL_ACCOUNT | __GFP_NOWAR=
N);
+ 	rec =3D kvzalloc_flex(*rec, fields, cnt, BPF_VERIFIER_GFP);
  	if (!rec)
  		return ERR_PTR(-ENOMEM);
 =20
@@@ -4223,11 -4223,10 +4223,10 @@@
  			ret =3D -EFAULT;
  			goto end;
  		}
- 		if (info_arr[i].off < next_off) {
- 			ret =3D -EEXIST;
+ 		if (bpf_must_abort()) {
+ 			ret =3D -EINTR;
  			goto end;
  		}
- 		next_off =3D info_arr[i].off + field_type_size;
 =20
  		rec->field_mask |=3D info_arr[i].type;
  		rec->fields[i].offset =3D info_arr[i].off;
@@@ -4316,9 -4315,6 +4315,6 @@@
  		goto end;
  	}
 =20
- 	sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
- 	       NULL, rec);
-=20
  	return rec;
  end:
  	btf_record_free(rec);
@@@ -4624,7 -4620,7 +4620,7 @@@ static s32 btf_enum_check_meta(struct b
 =20
  	/* enum type either no name or a valid one */
  	if (t->name_off &&
- 	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -4640,7 -4636,7 +4636,7 @@@
 =20
  		/* enum member must have a valid name */
  		if (!enums[i].name_off ||
- 		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+ 		    !btf_name_valid(env, enums[i].name_off)) {
  			btf_verifier_log_type(env, t, "Invalid name");
  			return -EINVAL;
  		}
@@@ -4732,7 -4728,7 +4728,7 @@@ static s32 btf_enum64_check_meta(struc
 =20
  	/* enum type either no name or a valid one */
  	if (t->name_off &&
- 	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -4748,7 -4744,7 +4744,7 @@@
 =20
  		/* enum member must have a valid name */
  		if (!enums[i].name_off ||
- 		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+ 		    !btf_name_valid(env, enums[i].name_off)) {
  			btf_verifier_log_type(env, t, "Invalid name");
  			return -EINVAL;
  		}
@@@ -5038,7 -5034,7 +5034,7 @@@ static s32 btf_locsec_check_meta(struc
  	}
 =20
  	if (!t->name_off ||
- 	    !btf_name_valid_section(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -5230,7 -5226,7 +5226,7 @@@ static s32 btf_func_check_meta(struct b
  			       u32 meta_left)
  {
  	if (!t->name_off ||
- 	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -5299,7 -5295,7 +5295,7 @@@ static s32 btf_var_check_meta(struct bt
  	}
 =20
  	if (!t->name_off ||
- 	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -5365,7 -5361,7 +5361,7 @@@ static s32 btf_datasec_check_meta(struc
  	}
 =20
  	if (!t->name_off ||
- 	    !btf_name_valid_section(env->btf, t->name_off)) {
+ 	    !btf_name_valid(env, t->name_off)) {
  		btf_verifier_log_type(env, t, "Invalid name");
  		return -EINVAL;
  	}
@@@ -5752,7 -5748,7 +5748,7 @@@ static int btf_func_proto_check(struct=20
 =20
  		if (args[i].name_off &&
  		    (!btf_name_offset_valid(btf, args[i].name_off) ||
- 		     !btf_name_valid_identifier(btf, args[i].name_off))) {
+ 		     !btf_name_valid(env, args[i].name_off))) {
  			btf_verifier_log_type(env, t,
  					      "Invalid arg#%u", i + 1);
  			return -EINVAL;
@@@ -5985,6 -5981,22 +5981,22 @@@ static int btf_check_all_types(struct b
  		return err;
 =20
  	env->phase++;
+ 	/*
+ 	 * Structs and arrays go first. A walk from a pointer stops at them and =
hides this loop:
+ 	 *   ptr -> typedef -> array -+
+ 	 *             ^--------------+
+ 	 */
+ 	for (i =3D btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
+ 		type_id =3D btf->start_id + i;
+ 		t =3D btf_type_by_id(btf, type_id);
+=20
+ 		if ((btf_type_is_struct(t) || btf_type_is_array(t)) &&
+ 		    !env_type_is_resolved(env, type_id)) {
+ 			err =3D btf_resolve(env, t, type_id);
+ 			if (err)
+ 				return err;
+ 		}
+ 	}
  	for (i =3D btf->base_btf ? 0 : 1; i < btf->nr_types; i++) {
  		type_id =3D btf->start_id + i;
  		t =3D btf_type_by_id(btf, type_id);
@@@ -6035,6 -6047,7 +6047,7 @@@ static int btf_parse_str_sec(struct btf
  	const struct btf_header *hdr;
  	struct btf *btf =3D env->btf;
  	const char *start, *end;
+ 	u32 i, len =3D 0;
 =20
  	hdr =3D &btf->hdr;
  	start =3D btf->nohdr_data + hdr->str_off;
@@@ -6059,6 -6072,21 +6072,21 @@@
  		return -EINVAL;
  	}
 =20
+ 	/* many names can share one long string: look at each byte once */
+ 	kvfree(env->names);
+ 	env->names =3D kvcalloc(BITS_TO_LONGS(hdr->str_len), sizeof(long),
+ 			      GFP_KERNEL | __GFP_NOWARN);
+ 	if (!env->names)
+ 		return -ENOMEM;
+ 	for (i =3D hdr->str_len; i--;) {
+ 		if (!start[i])
+ 			len =3D 0;
+ 		else if (!isprint(start[i]))
+ 			len =3D BTF_MAX_NAME_LEN;
+ 		else if (len++ < BTF_MAX_NAME_LEN)
+ 			__set_bit(i, env->names);
+ 	}
+=20
  	return 0;
  }
 =20
@@@ -6290,6 -6318,10 +6318,10 @@@ btf_parse_struct_metas(struct bpf_verif
  			ret =3D -EINVAL;
  			goto free_aof;
  		}
+ 		if (bpf_must_abort()) {
+ 			ret =3D -EINTR;
+ 			goto free_aof;
+ 		}
 =20
  		ret =3D btf_find_kptr(btf, t, 0, 0, &tmp, BPF_KPTR);
  		if (ret !=3D BTF_FIELD_FOUND)
@@@ -6347,6 -6379,9 +6379,9 @@@
  		record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK |=
 BPF_LIST_HEAD | BPF_LIST_NODE |
  						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
  						  BPF_KPTR, t->size);
+ 		/* It cannot be allocated. A map has its own record. */
+ 		if (record =3D=3D ERR_PTR(-EFBIG))
+ 			continue;
  		/* The record cannot be unset, treat it as an error if so */
  		if (IS_ERR_OR_NULL(record)) {
  			ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
@@@ -6473,7 -6508,7 +6508,7 @@@ static struct btf *btf_parse(const unio
  	if (err)
  		goto errout;
 =20
- 	err =3D btf_parse_type_sec(env);
+ 	err =3D btf_parse_type_sec(env) ?: btf_link_decl_tags(btf);
  	if (err)
  		goto errout;
 =20
@@@ -8091,20 -8126,11 +8126,11 @@@ int btf_struct_access(struct bpf_verifi
  		if (!meta)
  			break;
  		rec =3D meta->record;
- 		for (i =3D 0; i < rec->cnt; i++) {
- 			struct btf_field *field =3D &rec->fields[i];
- 			u32 offset =3D field->offset;
- 			/* An access at 'lo' or above ends after the start of the field. */
- 			s64 lo =3D max(min_off, (s64)offset - size + 1);
-=20
- 			/* Round up to min_off + k * step. The step is never 0. */
- 			lo +=3D imod(min_off - lo, reg->step);
- 			if (lo <=3D max_off && lo < offset + field->size) {
- 				bpf_log(log,
- 					"direct access to %s is disallowed\n",
- 					btf_field_type_name(field->type));
- 				return -EACCES;
- 			}
+ 		i =3D btf_record_first_field(rec, off);
+ 		if (i < rec->cnt && rec->fields[i].offset < off + size) {
+ 			bpf_log(log, "direct access to %s is disallowed\n",
+ 				btf_field_type_name(rec->fields[i].type));
+ 			return -EACCES;
  		}
  		break;
  	}
@@@ -8636,8 -8662,8 +8662,8 @@@ static int btf_scan_decl_tags(struct bp
  			      const struct btf_type *fn_t,
  			      u32 arg_idx, bool is_global, u32 *tags)
  {
- 	int id =3D btf_named_start_id(btf, false) - 1;
  	const char tag_key[] =3D "arg:";
+ 	int id =3D 0;
  	static const struct {
  		const char *tag_value;
  		enum btf_arg_tag arg_tag;
@@@ -8747,8 -8773,7 +8773,7 @@@ static int btf_validate_return_type(str
  }
 =20
  static int btf_check_arg_slots(struct bpf_verifier_log *log, const char *=
tname,
- 			       bool is_global, u32 slot_cnt,
- 			       struct bpf_subprog_info *sub)
+ 			       bool is_global, u32 slot_cnt)
  {
  	if (slot_cnt <=3D MAX_BPF_FUNC_REG_ARGS)
  		return 0;
@@@ -8760,12 -8785,7 +8785,7 @@@
  			tname, slot_cnt, MAX_BPF_FUNC_REG_ARGS);
  		return -EINVAL;
  	}
- 	if (!bpf_jit_supports_stack_args()) {
- 		bpf_log(log, "JIT does not support function %s() with %d argument slots=
\n",
- 			tname, slot_cnt);
- 		return -EFAULT;
- 	}
- 	sub->stack_arg_cnt =3D slot_cnt - MAX_BPF_FUNC_REG_ARGS;
+ 	/* The code of a static function tells which stack arguments it takes */
  	return 0;
  }
 =20
@@@ -8832,13 -8852,15 +8852,15 @@@ int btf_prepare_func_args(struct bpf_ve
  	}
  	args =3D (const struct btf_param *)(t + 1);
  	nargs =3D btf_type_vlen(t);
- 	sub->arg_slot_cnt =3D nargs;
+ 	sub->arg_slot_cnt =3D min_t(u32, nargs, MAX_BPF_FUNC_ARGS);
  	if (nargs > MAX_BPF_FUNC_ARGS) {
+ 		if (!is_global) /* not fatal for static funcs */
+ 			return -EINVAL;
  		bpf_log(log, "kernel supports at most %d parameters, function %s has %d=
\n",
  			MAX_BPF_FUNC_ARGS, tname, nargs);
  		return -EFAULT;
  	}
- 	err =3D btf_check_arg_slots(log, tname, is_global, nargs, sub);
+ 	err =3D btf_check_arg_slots(log, tname, is_global, nargs);
  	if (err)
  		return err;
 =20
@@@ -9027,7 -9049,7 +9049,7 @@@ skip_pointer
  		return -EINVAL;
  	}
 =20
- 	err =3D btf_check_arg_slots(log, tname, is_global, slots_used, sub);
+ 	err =3D btf_check_arg_slots(log, tname, is_global, slots_used);
  	if (err)
  		return err;
  	sub->arg_slot_cnt =3D slots_used;

--FyCdLcCvqJgJM9uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr8yM4ACgkQJNaLcl1U
h9CenAf9HGY0wUU0TJN3DP5cbhu9wAwWpMY7Gkcmh5EAGcr0C+Zwq4au+NDD7fv/
lLquL3eXHPZ1p6cPkPOTpoEzFPznThJOWz9ptKZPbO1dmeHmflZmhEgThAIyfbgv
BbPoXBfVxdBqcFuJoH6sOYNDYBxhbT07EkQ7/eFd4pU21ZsEQy/MAVmvvft5+d8a
/Ve3BtHMeA6NtBOzVW0xPddDfaz9GT9iJ3GX8DWHn/Wl+zCBLNh3o5QJAyME9GQn
ZrsknOQilTOPEV9PSMfdowUnnDnZhTk2KR9b/QW2x0AQq6tsaZBT749538NRVjDV
EZgPIiCwnofWPeO1CMZ79e7hDM+JQw==
=ARmB
-----END PGP SIGNATURE-----

--FyCdLcCvqJgJM9uc--
