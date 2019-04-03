Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB90DC10F0D
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5787A2171F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCSXa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:23:30 -0400
Received: from www62.your-server.de ([213.133.104.62]:55370 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSX3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:23:29 -0400
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBkXj-0006D7-9x; Wed, 03 Apr 2019 20:23:23 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, joe@wand.net.nz, yhs@fb.com,
        andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 06/15] bpf: kernel side support for BTF Var and DataSec
Date:   Wed,  3 Apr 2019 20:22:57 +0200
Message-Id: <62cf123c51006a02c1ffa9aaaf2881a8eb292d59.1554314902.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This work adds kernel-side verification, logging and seq_show dumping
of BTF Var and DataSec kinds which are emitted with latest LLVM. The
following constraints apply:

BTF Var must have:

- Its kind_flag is 0
- Its vlen is 0
- Must point to a valid type
- Type must not resolve to a forward type
- Must have a valid name
- Name may include dots (e.g. in case of static variables
  inside functions)
- Cannot be a member of a struct/union
- Linkage so far can either only be static or global/allocated

BTF DataSec must have:

- Its kind_flag is 0
- Its vlen cannot be 0
- Its size cannot be 0
- Must have a valid name
- Name may include dots (e.g. to represent .bss, .data, .rodata etc)
- Cannot be a member of a struct/union
- Inner btf_var_secinfo array with {type,offset,size} triple
  must be sorted by offset in ascending order
- Type must always point to BTF Var
- BTF resolved size of Var must be <= size provided by triple
- DataSec size must be >= sum of triple sizes (thus holes
  are allowed)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/btf.c | 393 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 379 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd3921b..5c9285c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -185,6 +185,16 @@
 	     i < btf_type_vlen(struct_type);				\
 	     i++, member++)
 
+#define for_each_vsi(i, struct_type, member)			\
+	for (i = 0, member = btf_type_var_secinfo(struct_type);	\
+	     i < btf_type_vlen(struct_type);			\
+	     i++, member++)
+
+#define for_each_vsi_from(i, from, struct_type, member)				\
+	for (i = from, member = btf_type_var_secinfo(struct_type) + from;	\
+	     i < btf_type_vlen(struct_type);					\
+	     i++, member++)
+
 static DEFINE_IDR(btf_idr);
 static DEFINE_SPINLOCK(btf_idr_lock);
 
@@ -262,6 +272,8 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_RESTRICT]	= "RESTRICT",
 	[BTF_KIND_FUNC]		= "FUNC",
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
+	[BTF_KIND_VAR]		= "VAR",
+	[BTF_KIND_DATASEC]	= "DATASEC",
 };
 
 struct btf_kind_operations {
@@ -308,6 +320,7 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	case BTF_KIND_VOLATILE:
 	case BTF_KIND_CONST:
 	case BTF_KIND_RESTRICT:
+	case BTF_KIND_VAR:
 		return true;
 	}
 
@@ -375,13 +388,27 @@ static bool btf_type_is_int(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_INT;
 }
 
+static bool btf_type_is_var(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_VAR;
+}
+
+static bool btf_type_is_datasec(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
+}
+
 /* What types need to be resolved?
  *
  * btf_type_is_modifier() is an obvious one.
  *
  * btf_type_is_struct() because its member refers to
  * another type (through member->type).
-
+ *
+ * btf_type_is_var() because the variable refers to
+ * another type. btf_type_is_datasec() holds multiple
+ * btf_type_is_var() types that need resolving.
+ *
  * btf_type_is_array() because its element (array->type)
  * refers to another type.  Array can be thought of a
  * special case of struct while array just has the same
@@ -390,9 +417,11 @@ static bool btf_type_is_int(const struct btf_type *t)
 static bool btf_type_needs_resolve(const struct btf_type *t)
 {
 	return btf_type_is_modifier(t) ||
-		btf_type_is_ptr(t) ||
-		btf_type_is_struct(t) ||
-		btf_type_is_array(t);
+	       btf_type_is_ptr(t) ||
+	       btf_type_is_struct(t) ||
+	       btf_type_is_array(t) ||
+	       btf_type_is_var(t) ||
+	       btf_type_is_datasec(t);
 }
 
 /* t->size can be used */
@@ -403,6 +432,7 @@ static bool btf_type_has_size(const struct btf_type *t)
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION:
 	case BTF_KIND_ENUM:
+	case BTF_KIND_DATASEC:
 		return true;
 	}
 
@@ -467,6 +497,16 @@ static const struct btf_enum *btf_type_enum(const struct btf_type *t)
 	return (const struct btf_enum *)(t + 1);
 }
 
+static const struct btf_var *btf_type_var(const struct btf_type *t)
+{
+	return (const struct btf_var *)(t + 1);
+}
+
+static const struct btf_var_secinfo *btf_type_var_secinfo(const struct btf_type *t)
+{
+	return (const struct btf_var_secinfo *)(t + 1);
+}
+
 static const struct btf_kind_operations *btf_type_ops(const struct btf_type *t)
 {
 	return kind_ops[BTF_INFO_KIND(t->info)];
@@ -478,23 +518,31 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 		offset < btf->hdr.str_len;
 }
 
-/* Only C-style identifier is permitted. This can be relaxed if
- * necessary.
- */
-static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
+static bool __btf_name_char_ok(char c, bool first, bool dot_ok)
+{
+	if ((first ? !isalpha(c) :
+		     !isalnum(c)) &&
+	    c != '_' &&
+	    ((c == '.' && !dot_ok) ||
+	      c != '.'))
+		return false;
+	return true;
+}
+
+static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
 {
 	/* offset must be valid */
 	const char *src = &btf->strings[offset];
 	const char *src_limit;
 
-	if (!isalpha(*src) && *src != '_')
+	if (!__btf_name_char_ok(*src, true, dot_ok))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!isalnum(*src) && *src != '_')
+		if (!__btf_name_char_ok(*src, false, dot_ok))
 			return false;
 		src++;
 	}
@@ -502,6 +550,19 @@ static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 	return !*src;
 }
 
+/* Only C-style identifier is permitted. This can be relaxed if
+ * necessary.
+ */
+static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
+{
+	return __btf_name_valid(btf, offset, false);
+}
+
+static bool btf_name_valid_section(const struct btf *btf, u32 offset)
+{
+	return __btf_name_valid(btf, offset, true);
+}
+
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
 {
 	if (!offset)
@@ -697,6 +758,32 @@ static void btf_verifier_log_member(struct btf_verifier_env *env,
 	__btf_verifier_log(log, "\n");
 }
 
+__printf(4, 5)
+static void btf_verifier_log_vsi(struct btf_verifier_env *env,
+				 const struct btf_type *datasec_type,
+				 const struct btf_var_secinfo *vsi,
+				 const char *fmt, ...)
+{
+	struct bpf_verifier_log *log = &env->log;
+	va_list args;
+
+	if (!bpf_verifier_log_needed(log))
+		return;
+	if (env->phase != CHECK_META)
+		btf_verifier_log_type(env, datasec_type, NULL);
+
+	__btf_verifier_log(log, "\t type_id=%u offset=%u size=%u",
+			   vsi->type, vsi->offset, vsi->size);
+	if (fmt && *fmt) {
+		__btf_verifier_log(log, " ");
+		va_start(args, fmt);
+		bpf_verifier_vlog(log, fmt, args);
+		va_end(args);
+	}
+
+	__btf_verifier_log(log, "\n");
+}
+
 static void btf_verifier_log_hdr(struct btf_verifier_env *env,
 				 u32 btf_data_size)
 {
@@ -1542,6 +1629,53 @@ static int btf_modifier_resolve(struct btf_verifier_env *env,
 	return 0;
 }
 
+static int btf_var_resolve(struct btf_verifier_env *env,
+			   const struct resolve_vertex *v)
+{
+	const struct btf_type *next_type;
+	const struct btf_type *t = v->t;
+	u32 next_type_id = t->type;
+	struct btf *btf = env->btf;
+	u32 next_type_size;
+
+	next_type = btf_type_by_id(btf, next_type_id);
+	if (!next_type) {
+		btf_verifier_log_type(env, v->t, "Invalid type_id");
+		return -EINVAL;
+	}
+
+	if (!env_type_is_resolve_sink(env, next_type) &&
+	    !env_type_is_resolved(env, next_type_id))
+		return env_stack_push(env, next_type, next_type_id);
+
+	if (btf_type_is_modifier(next_type)) {
+		const struct btf_type *resolved_type;
+		u32 resolved_type_id;
+
+		resolved_type_id = next_type_id;
+		resolved_type = btf_type_id_resolve(btf, &resolved_type_id);
+
+		if (btf_type_is_ptr(resolved_type) &&
+		    !env_type_is_resolve_sink(env, resolved_type) &&
+		    !env_type_is_resolved(env, resolved_type_id))
+			return env_stack_push(env, resolved_type,
+					      resolved_type_id);
+	}
+
+	/* We must resolve to something concrete at this point, no
+	 * forward types or similar that would resolve to size of
+	 * zero is allowed.
+	 */
+	if (!btf_type_id_size(btf, &next_type_id, &next_type_size)) {
+		btf_verifier_log_type(env, v->t, "Invalid type_id");
+		return -EINVAL;
+	}
+
+	env_stack_pop_resolved(env, next_type_id, next_type_size);
+
+	return 0;
+}
+
 static int btf_ptr_resolve(struct btf_verifier_env *env,
 			   const struct resolve_vertex *v)
 {
@@ -1609,6 +1743,15 @@ static void btf_modifier_seq_show(const struct btf *btf,
 	btf_type_ops(t)->seq_show(btf, t, type_id, data, bits_offset, m);
 }
 
+static void btf_var_seq_show(const struct btf *btf, const struct btf_type *t,
+			     u32 type_id, void *data, u8 bits_offset,
+			     struct seq_file *m)
+{
+	t = btf_type_id_resolve(btf, &type_id);
+
+	btf_type_ops(t)->seq_show(btf, t, type_id, data, bits_offset, m);
+}
+
 static void btf_ptr_seq_show(const struct btf *btf, const struct btf_type *t,
 			     u32 type_id, void *data, u8 bits_offset,
 			     struct seq_file *m)
@@ -2411,6 +2554,222 @@ static struct btf_kind_operations func_ops = {
 	.seq_show = btf_df_seq_show,
 };
 
+static s32 btf_var_check_meta(struct btf_verifier_env *env,
+			      const struct btf_type *t,
+			      u32 meta_left)
+{
+	const struct btf_var *var;
+	u32 meta_needed = sizeof(*var);
+
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (btf_type_vlen(t)) {
+		btf_verifier_log_type(env, t, "vlen != 0");
+		return -EINVAL;
+	}
+
+	if (btf_type_kflag(t)) {
+		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
+		return -EINVAL;
+	}
+
+	if (!t->name_off ||
+	    !__btf_name_valid(env->btf, t->name_off, true)) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+
+	/* A var cannot be in type void */
+	if (!t->type || !BTF_TYPE_ID_VALID(t->type)) {
+		btf_verifier_log_type(env, t, "Invalid type_id");
+		return -EINVAL;
+	}
+
+	var = btf_type_var(t);
+	if (var->linkage != BTF_VAR_STATIC &&
+	    var->linkage != BTF_VAR_GLOBAL_ALLOCATED) {
+		btf_verifier_log_type(env, t, "Linkage not supported");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	return meta_needed;
+}
+
+static void btf_var_log(struct btf_verifier_env *env, const struct btf_type *t)
+{
+	const struct btf_var *var = btf_type_var(t);
+
+	btf_verifier_log(env, "type_id=%u linkage=%u", t->type, var->linkage);
+}
+
+static const struct btf_kind_operations var_ops = {
+	.check_meta		= btf_var_check_meta,
+	.resolve		= btf_var_resolve,
+	.check_member		= btf_df_check_member,
+	.check_kflag_member	= btf_df_check_kflag_member,
+	.log_details		= btf_var_log,
+	.seq_show		= btf_var_seq_show,
+};
+
+static s32 btf_datasec_check_meta(struct btf_verifier_env *env,
+			          const struct btf_type *t,
+				  u32 meta_left)
+{
+	const struct btf_var_secinfo *vsi;
+	u64 last_vsi_end_off = 0, sum = 0;
+	u32 i, meta_needed;
+
+	meta_needed = btf_type_vlen(t) * sizeof(*vsi);
+	if (meta_left < meta_needed) {
+		btf_verifier_log_basic(env, t,
+				       "meta_left:%u meta_needed:%u",
+				       meta_left, meta_needed);
+		return -EINVAL;
+	}
+
+	if (!btf_type_vlen(t)) {
+		btf_verifier_log_type(env, t, "vlen == 0");
+		return -EINVAL;
+	}
+
+	if (!t->size) {
+		btf_verifier_log_type(env, t, "size == 0");
+		return -EINVAL;
+	}
+
+	if (btf_type_kflag(t)) {
+		btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
+		return -EINVAL;
+	}
+
+	if (!t->name_off ||
+	    !btf_name_valid_section(env->btf, t->name_off)) {
+		btf_verifier_log_type(env, t, "Invalid name");
+		return -EINVAL;
+	}
+
+	btf_verifier_log_type(env, t, NULL);
+
+	for_each_vsi(i, t, vsi) {
+		/* A var cannot be in type void */
+		if (!vsi->type || !BTF_TYPE_ID_VALID(vsi->type)) {
+			btf_verifier_log_vsi(env, t, vsi,
+					     "Invalid type_id");
+			return -EINVAL;
+		}
+
+		if (vsi->offset < last_vsi_end_off || vsi->offset >= t->size) {
+			btf_verifier_log_vsi(env, t, vsi,
+					     "Invalid offset");
+			return -EINVAL;
+		}
+
+		if (!vsi->size || vsi->size > t->size) {
+			btf_verifier_log_vsi(env, t, vsi,
+					     "Invalid size");
+			return -EINVAL;
+		}
+
+		last_vsi_end_off = vsi->offset + vsi->size;
+		if (last_vsi_end_off > t->size) {
+			btf_verifier_log_vsi(env, t, vsi,
+					     "Invalid offset+size");
+			return -EINVAL;
+		}
+
+		btf_verifier_log_vsi(env, t, vsi, NULL);
+		sum += vsi->size;
+	}
+
+	if (t->size < sum) {
+		btf_verifier_log_type(env, t, "Invalid btf_info size");
+		return -EINVAL;
+	}
+
+	return meta_needed;
+}
+
+static int btf_datasec_resolve(struct btf_verifier_env *env,
+			       const struct resolve_vertex *v)
+{
+	const struct btf_var_secinfo *vsi;
+	struct btf *btf = env->btf;
+	u16 i;
+
+	for_each_vsi_from(i, v->next_member, v->t, vsi) {
+		u32 var_type_id = vsi->type, type_id, type_size = 0;
+		const struct btf_type *var_type = btf_type_by_id(env->btf,
+								 var_type_id);
+		if (!var_type || !btf_type_is_var(var_type)) {
+			btf_verifier_log_vsi(env, v->t, vsi,
+					     "Not a VAR kind member");
+			return -EINVAL;
+		}
+
+		if (!env_type_is_resolve_sink(env, var_type) &&
+		    !env_type_is_resolved(env, var_type_id)) {
+			env_stack_set_next_member(env, i + 1);
+			return env_stack_push(env, var_type, var_type_id);
+		}
+
+		type_id = var_type->type;
+		if (!btf_type_id_size(btf, &type_id, &type_size)) {
+			btf_verifier_log_vsi(env, v->t, vsi, "Invalid type");
+			return -EINVAL;
+		}
+
+		if (vsi->size < type_size) {
+			btf_verifier_log_vsi(env, v->t, vsi, "Invalid size");
+			return -EINVAL;
+		}
+	}
+
+	env_stack_pop_resolved(env, 0, 0);
+	return 0;
+}
+
+static void btf_datasec_log(struct btf_verifier_env *env,
+			    const struct btf_type *t)
+{
+	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
+}
+
+static void btf_datasec_seq_show(const struct btf *btf,
+				 const struct btf_type *t, u32 type_id,
+				 void *data, u8 bits_offset,
+				 struct seq_file *m)
+{
+	const struct btf_var_secinfo *vsi;
+	const struct btf_type *var;
+	u32 i;
+
+	seq_printf(m, "section (\"%s\") = {", __btf_name_by_offset(btf, t->name_off));
+	for_each_vsi(i, t, vsi) {
+		var = btf_type_by_id(btf, vsi->type);
+		if (i)
+			seq_puts(m, ",");
+		btf_type_ops(var)->seq_show(btf, var, vsi->type,
+					    data + vsi->offset, bits_offset, m);
+	}
+	seq_puts(m, "}");
+}
+
+static const struct btf_kind_operations datasec_ops = {
+	.check_meta		= btf_datasec_check_meta,
+	.resolve		= btf_datasec_resolve,
+	.check_member		= btf_df_check_member,
+	.check_kflag_member	= btf_df_check_kflag_member,
+	.log_details		= btf_datasec_log,
+	.seq_show		= btf_datasec_seq_show,
+};
+
 static int btf_func_proto_check(struct btf_verifier_env *env,
 				const struct btf_type *t)
 {
@@ -2542,6 +2901,8 @@ static const struct btf_kind_operations * const kind_ops[NR_BTF_KINDS] = {
 	[BTF_KIND_RESTRICT] = &modifier_ops,
 	[BTF_KIND_FUNC] = &func_ops,
 	[BTF_KIND_FUNC_PROTO] = &func_proto_ops,
+	[BTF_KIND_VAR] = &var_ops,
+	[BTF_KIND_DATASEC] = &datasec_ops,
 };
 
 static s32 btf_check_meta(struct btf_verifier_env *env,
@@ -2622,13 +2983,17 @@ static bool btf_resolve_valid(struct btf_verifier_env *env,
 	if (!env_type_is_resolved(env, type_id))
 		return false;
 
-	if (btf_type_is_struct(t))
+	if (btf_type_is_struct(t) || btf_type_is_datasec(t))
 		return !btf->resolved_ids[type_id] &&
-			!btf->resolved_sizes[type_id];
+		       !btf->resolved_sizes[type_id];
 
-	if (btf_type_is_modifier(t) || btf_type_is_ptr(t)) {
+	if (btf_type_is_modifier(t) || btf_type_is_ptr(t) ||
+	    btf_type_is_var(t)) {
 		t = btf_type_id_resolve(btf, &type_id);
-		return t && !btf_type_is_modifier(t);
+		return t &&
+		       !btf_type_is_modifier(t) &&
+		       !btf_type_is_var(t) &&
+		       !btf_type_is_datasec(t);
 	}
 
 	if (btf_type_is_array(t)) {
-- 
2.9.5

