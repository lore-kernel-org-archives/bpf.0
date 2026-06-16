Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104B3DA7FD
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590501; cv=none; b=k75KmtGFsKbxo3o/hEX/sPzLth1uLQQ0/60KBdJ8GYrJK3RbmKZdoWi0s/SVwfiyZKSene08hLV0E0AGekYn+zTlIXh/mlXcIuct6khNtmD1KUPHymtBp+hJHAntDS8jR/wPolIGBrH4BZxb3ElBoyypn9vamJ4vX5VK+oBOkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590501; c=relaxed/simple;
	bh=ALIMGatHvM15pOp4hi4QRNL+xMzCT4JnHF69vUiSJp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBYjhS1nWm5hKa+NiEO5U+54amqUvEl9SrXnjcEe/8MiPccVVOLFxMN7o6FTLaDOvIb45XqYgYRk+p2bXEe3dXppC4r5o0oBtBkbyQm7L/bxnCm9CU3+gHtvo7/zQuSaUVkzVav24MpDyDvBwjuhHc5TUBHjghKZf6oHmcNvjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=l2IsriiE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="l2IsriiE"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so1982701a91.2
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 23:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781590498; x=1782195298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuOEi8Eyaz5Nvf3SDwAi30HjTvfYxkxH/iPQMZtmnZc=;
        b=l2IsriiERBfkqF2Qafp2CKBoWrnQoz6M6Uxym2Sk8pkdxqAJP6raxbVS6CDBzu/SGu
         yAOFyTD2gy97PUBZ79GhjBn2F8o7xCq6kNR/VL5Z9fByn2YrinMSD275vfwjs9NTJHxS
         C4+175ZENbm65Snzi8QQo5aTpkG5VX4IhKnqq6wqkayEVu8KLC12tCA0ub6cHfBpLLup
         hgbeXlY4YrtBbKOQXkn+xOLASB0TPdD4nlPKXvb/ztnhei7O6xj4U9sIhlzvp0raP8OY
         7qIa7tMepAxEVIkuG1Eb/h57qKTq4mV6e9i7+Te3lbucJ6rpXFT1VO1ckNN+P1LePj9G
         Br8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590498; x=1782195298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuOEi8Eyaz5Nvf3SDwAi30HjTvfYxkxH/iPQMZtmnZc=;
        b=QynlE5PdZWRQ1E3HtiwMys5SV0HuXS1CD9sGjnhChrOel27m4BnvkRcHkm+f+1NkY/
         1TPrNdX3XpoGj0VSrL+wfLWiU5t9zryRG3AgnaBGhwZmFXyx6LOZMI0Hfm2RwCFYII31
         GVBG2f5V9NtctS83ckwuvFOFSVb4Z+AeOIEWBhNLYpMySf/rjrIc5FcJTJeE5OExADij
         YYA+lZZfh1sJncMJ3/hTSCAYfz7R6c0lKIrUePE025Gq3khwvc1K5yg/AVLCvtq62uNO
         kEKDnEi/uj7J2oSGm1IywL2lvaq4vf4eFtb93poMJJO1zBfsUfPXz9V9yb0wk16OTFHq
         fBBw==
X-Gm-Message-State: AOJu0Yzvn7FEI3F7BqVdx/r5J12UB1NwXsHSHmAYt9DmOPLbRSnciYgC
	IPxjWh824OwmXtNAmrfKx/EnyBfCFrobwrsfj/KHhvOrNbDkiUiiJ1mgWNX+5P2exMh/pxK1K4V
	LeJHpClgfqQ==
X-Gm-Gg: Acq92OF5H/aU54M9qxLM1h1vMna6h3pzbVc8meHh84Zt5lEN+o5NwOKJRmqbktT0ty+
	31Vw5+UXtzlGx+CtXvoK+weTtxOuezIJIQk1tF7K2pfa2BIAWeAIbqczlBRe6jNRhuioHFBcE00
	H7/PvIYGFRRiuoEDPK34lgAatwBvBxUwy7HLSv65+44YuMHt1ejVB5a+7uXLNaxsbzqZTDDPuqL
	pcdEaWndLF4Krh6mlH3kxxlQstYkUjZtvDBa3FGETKaYQB61+uL/yYSS598Wv8flfDfnk+QlNlF
	m1TH98i9qZntwvd431WtjwJ10vlVSeabBbdH/wnJ8zhXGqLNdNhzr0g3vvQylSmtIvos/lgkdss
	S89DedYYuxxIRZMtGFKhCtnJVJNmcwj59mF8Ct0alhL2Vhhvseqv+yphkFCwpPQuc/zTVok8VDW
	8LVT6SFetd7d/7GMdP6Y1EtxdVwUiegzCm9DBYMXbDuFmHnQgv8DY=
X-Received: by 2002:a17:90b:5292:b0:379:1f28:cdc2 with SMTP id 98e67ed59e1d1-37c528e0bd5mr2492724a91.13.1781590498094;
        Mon, 15 Jun 2026 23:14:58 -0700 (PDT)
Received: from krios (d206-116-244-52.bchsia.telus.net. [206.116.244.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae7d1sm1509630a91.3.2026.06.15.23.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:14:57 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2] bpf: Allow type tag BTF records to succeed other modifier records
Date: Tue, 16 Jun 2026 02:14:54 -0400
Message-ID: <20260616061454.7869-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of recently, Clang is able to attach type tag records to modifier BTF
records. This is useful for using typedefs that encompass a base type
and a type tag, e.g.:

typedef struct rbtree __arena rbtree_t;

Modify btf_check_type_tags() so that it allows this sequence of records.
The function now only checks for record loops in BTF modifier record
chains. Rename to btf_check_modifier_chain_length to reflect this.

Also expand the BTF modifier traversal code to take into account that
type record can be interleaved with other modifier records. In effect
this means traversing all modifiers to collect the type tags.

Also modify existing selftests to now accept modifier records (const,
typedef) that point to type tag records.

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Vineet Gupta <vineet.gupta@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---

Changelog v1->v2:

- Factor main type tag walk into a separate function (Eduard). The
  change makes certain code paths now more permissive (unrecognized tags
  do not cause an error for kptrs, and we can have multiple instances of
  the same tag), but imo handling those edge cases was a grey area in the
  first place and it is better to consistently scan type tags the same
  way everywhere.

 kernel/bpf/btf.c                             | 209 +++++++++++--------
 tools/testing/selftests/bpf/prog_tests/btf.c |  12 +-
 2 files changed, 125 insertions(+), 96 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef4402274786..4ba2ff132503 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -28,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/overflow.h>
+#include <linux/bitops.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
@@ -3472,12 +3473,69 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 	return BTF_FIELD_FOUND;
 }
 
+struct btf_type_tag_match {
+	const char *name;
+	u32 flag;
+};
+
+struct btf_type_tag_walk_ctx {
+	const struct btf_type *t;	/* Input/Output */
+	u32 id;				/* Output */
+	u32 res;			/* Output */
+};
+
+static int btf_type_tag_walk(const struct btf *btf,
+			     struct btf_type_tag_walk_ctx *ctx,
+			     const struct btf_type_tag_match *matches,
+			     u32 match_cnt)
+{
+	const struct btf_type *t = ctx->t;
+	u32 res = 0;
+	const char *tag;
+	u32 id, i;
+
+	do {
+		id = t->type;
+		t = btf_type_by_id(btf, id);
+
+		if (!btf_type_is_modifier(t))
+			break;
+
+		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
+			continue;
+
+		tag = __btf_name_by_offset(btf, t->name_off);
+		for (i = 0; i < match_cnt; i++) {
+			if (strcmp(tag, matches[i].name))
+				continue;
+			res |= matches[i].flag;
+			break;
+		}
+	} while (true);
+
+	/* We only support a single tag. */
+	if (hweight32(res) > 1)
+		return -EINVAL;
+
+	ctx->t = t;
+	ctx->id = id;
+	ctx->res = res;
+
+	return 0;
+}
+
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
-	enum btf_field_type type;
-	const char *tag_value;
-	bool is_type_tag;
+	static const struct btf_type_tag_match kptr_type_tags[] = {
+		{ "kptr_untrusted", BPF_KPTR_UNREF },
+		{ "kptr", BPF_KPTR_REF },
+		{ "percpu_kptr", BPF_KPTR_PERCPU },
+		{ "uptr", BPF_UPTR },
+	};
+	struct btf_type_tag_walk_ctx ctx;
+	enum btf_field_type type = 0;
+	int err;
 	u32 res_id;
 
 	/* Permit modifiers on the pointer itself */
@@ -3486,30 +3544,20 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
-	t = btf_type_by_id(btf, t->type);
-	is_type_tag = btf_type_is_type_tag(t) && !btf_type_kflag(t);
-	if (!is_type_tag)
-		return BTF_FIELD_IGNORE;
-	/* Reject extra tags */
-	if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
-		return -EINVAL;
-	tag_value = __btf_name_by_offset(btf, t->name_off);
-	if (!strcmp("kptr_untrusted", tag_value))
-		type = BPF_KPTR_UNREF;
-	else if (!strcmp("kptr", tag_value))
-		type = BPF_KPTR_REF;
-	else if (!strcmp("percpu_kptr", tag_value))
-		type = BPF_KPTR_PERCPU;
-	else if (!strcmp("uptr", tag_value))
-		type = BPF_UPTR;
-	else
-		return -EINVAL;
+
+	ctx.t = t;
+	err = btf_type_tag_walk(btf, &ctx, kptr_type_tags,
+				ARRAY_SIZE(kptr_type_tags));
+	if (err)
+		return err;
+
+	t = ctx.t;
+	res_id = ctx.id;
+	type = ctx.res;
 
 	if (!(type & field_mask))
 		return BTF_FIELD_IGNORE;
 
-	/* Get the base type */
-	t = btf_type_skip_modifiers(btf, t->type, &res_id);
 	/* Only pointer to struct is allowed */
 	if (!__btf_type_is_struct(t))
 		return -EINVAL;
@@ -5860,11 +5908,10 @@ struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
 	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), btf_id_cmp_func);
 }
 
-static int btf_check_type_tags(struct btf_verifier_env *env,
-			       struct btf *btf, int start_id)
+static int btf_check_modifier_chain_length(struct btf_verifier_env *env,
+					   struct btf *btf, int start_id)
 {
 	int i, n, good_id = start_id - 1;
-	bool in_tags;
 
 	n = btf_nr_types(btf);
 	for (i = start_id; i < n; i++) {
@@ -5880,20 +5927,12 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 
 		cond_resched();
 
-		in_tags = btf_type_is_type_tag(t);
 		while (btf_type_is_modifier(t)) {
 			if (!chain_limit--) {
 				btf_verifier_log(env, "Max chain length or cycle detected");
 				return -ELOOP;
 			}
-			if (btf_type_is_type_tag(t)) {
-				if (!in_tags) {
-					btf_verifier_log(env, "Type tags don't precede modifiers");
-					return -EINVAL;
-				}
-			} else if (in_tags) {
-				in_tags = false;
-			}
+
 			if (cur_id <= good_id)
 				break;
 			/* Move to next type */
@@ -5971,7 +6010,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	if (err)
 		goto errout;
 
-	err = btf_check_type_tags(env, btf, 1);
+	err = btf_check_modifier_chain_length(env, btf, 1);
 	if (err)
 		goto errout;
 
@@ -6379,7 +6418,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
-	err = btf_check_type_tags(env, btf, 1);
+	err = btf_check_modifier_chain_length(env, btf, 1);
 	if (err)
 		goto errout;
 
@@ -6505,7 +6544,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	if (err)
 		goto errout;
 
-	err = btf_check_type_tags(env, btf, btf_nr_types(base_btf));
+	err = btf_check_modifier_chain_length(env, btf, btf_nr_types(base_btf));
 	if (err)
 		goto errout;
 
@@ -6811,14 +6850,18 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
 {
+	static const struct btf_type_tag_match ctx_type_tags[] = {
+		{ "user", MEM_USER },
+		{ "percpu", MEM_PERCPU },
+	};
 	const struct btf_type *t = prog->aux->attach_func_proto;
 	struct bpf_prog *tgt_prog = prog->aux->dst_prog;
 	struct btf *btf = bpf_prog_get_target_btf(prog);
 	const char *tname = prog->aux->attach_func_name;
 	struct bpf_verifier_log *log = info->log;
+	struct btf_type_tag_walk_ctx ctx;
 	const struct btf_param *args;
 	bool ptr_err_raw_tp = false;
-	const char *tag_value;
 	u32 nr_args, arg;
 	int i, ret;
 
@@ -7021,22 +7064,18 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	info->btf = btf;
-	info->btf_id = t->type;
-	t = btf_type_by_id(btf, t->type);
-
-	if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
-		tag_value = __btf_name_by_offset(btf, t->name_off);
-		if (strcmp(tag_value, "user") == 0)
-			info->reg_type |= MEM_USER;
-		if (strcmp(tag_value, "percpu") == 0)
-			info->reg_type |= MEM_PERCPU;
+	ctx.t = t;
+	ret = btf_type_tag_walk(btf, &ctx, ctx_type_tags,
+				ARRAY_SIZE(ctx_type_tags));
+	if (ret) {
+		bpf_log(log, "func '%s' arg%d type %s has multiple type tags\n",
+			tname, arg, btf_type_str(t));
+		return false;
 	}
+	info->reg_type |= ctx.res;
+	info->btf_id = ctx.id;
+	t = ctx.t;
 
-	/* skip modifiers */
-	while (btf_type_is_modifier(t)) {
-		info->btf_id = t->type;
-		t = btf_type_by_id(btf, t->type);
-	}
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log,
 			"func '%s' arg%d type %s is not a struct\n",
@@ -7075,7 +7114,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
 	const struct btf_type *mtype, *elem_type = NULL;
 	const struct btf_member *member;
-	const char *tname, *mname, *tag_value;
+	const char *tname, *mname;
 	u32 vlen, elem_id, mid;
 
 again:
@@ -7271,8 +7310,15 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		}
 
 		if (btf_type_is_ptr(mtype)) {
-			const struct btf_type *stype, *t;
+			static const struct btf_type_tag_match walk_type_tags[] = {
+				{ "user", MEM_USER },
+				{ "percpu", MEM_PERCPU },
+				{ "rcu", MEM_RCU },
+			};
 			enum bpf_type_flag tmp_flag = 0;
+			struct btf_type_tag_walk_ctx ctx = { .t = mtype };
+			const struct btf_type *stype;
+			int err;
 			u32 id;
 
 			if (msize != size || off != moff) {
@@ -7282,22 +7328,17 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 				return -EACCES;
 			}
 
-			/* check type tag */
-			t = btf_type_by_id(btf, mtype->type);
-			if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
-				tag_value = __btf_name_by_offset(btf, t->name_off);
-				/* check __user tag */
-				if (strcmp(tag_value, "user") == 0)
-					tmp_flag = MEM_USER;
-				/* check __percpu tag */
-				if (strcmp(tag_value, "percpu") == 0)
-					tmp_flag = MEM_PERCPU;
-				/* check __rcu tag */
-				if (strcmp(tag_value, "rcu") == 0)
-					tmp_flag = MEM_RCU;
+			err = btf_type_tag_walk(btf, &ctx, walk_type_tags,
+						ARRAY_SIZE(walk_type_tags));
+			if (err) {
+				bpf_log(log, "type '%s' has multiple type tags\n",
+					btf_type_str(mtype));
+				return err;
 			}
+			tmp_flag = ctx.res;
+			id = ctx.id;
+			stype = ctx.t;
 
-			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id = id;
 				*flag |= tmp_flag;
@@ -7868,7 +7909,12 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
 			      const struct btf *btf, u32 type_id,
 			      u32 *tags)
 {
+	static const struct btf_type_tag_match func_type_tags[] = {
+		{ "arena", ARG_TAG_ARENA },
+	};
+	struct btf_type_tag_walk_ctx ctx;
 	const struct btf_type *t;
+	int err;
 
 	/* Find the first pointer type in the chain. */
 	t = btf_type_skip_modifiers(btf, type_id, NULL);
@@ -7880,24 +7926,15 @@ static int btf_scan_type_tags(struct bpf_verifier_env *env,
 	if (!t || !btf_type_is_ptr(t))
 		return 0;
 
-	/* We got a pointer, get all associated type tags. */
-	for (t = btf_type_by_id(btf, t->type); t && btf_type_is_modifier(t);
-		t = btf_type_by_id(btf, t->type)) {
-
-		/* Skip non-type tag modifiers. */
-		if (!btf_type_is_type_tag(t))
-			continue;
-
-		const char *tag = __btf_name_by_offset(btf, t->name_off);
-
-		if (strcmp(tag, "arena") == 0) {
-			*tags |= ARG_TAG_ARENA;
-		} else {
-			bpf_log(&env->log, "function signature member has unsupported type tag '%s'\n",
-				tag);
-			return -EOPNOTSUPP;
-		}
+	ctx.t = t;
+	err = btf_type_tag_walk(btf, &ctx, func_type_tags,
+				ARRAY_SIZE(func_type_tags));
+	if (err) {
+		bpf_log(&env->log,
+			"function signature member has multiple type tags\n");
+		return err;
 	}
+	*tags |= ctx.res;
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index a9de328a8697..df785a00f0b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4121,8 +4121,6 @@ static struct btf_raw_test raw_tests[] = {
 	.key_type_id = 1,
 	.value_type_id = 1,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Type tags don't precede modifiers",
 },
 {
 	.descr = "type_tag test #3, type tag order",
@@ -4141,8 +4139,6 @@ static struct btf_raw_test raw_tests[] = {
 	.key_type_id = 1,
 	.value_type_id = 1,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Type tags don't precede modifiers",
 },
 {
 	.descr = "type_tag test #4, type tag order",
@@ -4161,8 +4157,6 @@ static struct btf_raw_test raw_tests[] = {
 	.key_type_id = 1,
 	.value_type_id = 1,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Type tags don't precede modifiers",
 },
 {
 	.descr = "type_tag test #5, type tag order",
@@ -4198,11 +4192,9 @@ static struct btf_raw_test raw_tests[] = {
 	.map_name = "tag_type_check_btf",
 	.key_size = sizeof(int),
 	.value_size = 4,
-	.key_type_id = 1,
-	.value_type_id = 1,
+	.key_type_id = 4,
+	.value_type_id = 4,
 	.max_entries = 1,
-	.btf_load_err = true,
-	.err_str = "Type tags don't precede modifiers",
 },
 {
 	.descr = "type_tag test #7, tag with kflag",
-- 
2.54.0

