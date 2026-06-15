Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0126A1AC
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546796; cv=none; b=ioT+6WI2PccqO8pnU9sgyaBimmo3JKqY59/KrDdOcHN2paZLZpxY5hid0lHy87C/7gS9d/qROnyb2Drsm/QmRDI03rYzQE9hM45+5OHrLlqoG7T9Hr+B65RgKcUBRK2zPCj9RX8Pmi1HqhFlr1XMciA+pLtXsFGBPTAbq8EUMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546796; c=relaxed/simple;
	bh=/kzVClb0qBo361V1tJDAsVTFhAaRmNxuzXQHmeUeB/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIzwmp42hE6PbhyHl3kOmb9lI0FA+C1vIz+bHfsBEERuwbeAg//iCUOg9ofYOhn2yHcpzA2Ym27VxtM7n3mlbxSXzm2/10+Q3lQlzF+0AgzXc325aNGxL1EDJKDH1jnJ4W6FTefDggG6wMyL7jzX9TdmLWXpBFDZ4P5eZ+fVbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vOv3C4xx; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vOv3C4xx"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30807ba471bso10374412eec.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781546794; x=1782151594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO5lIKAxGxaVD/I36g1nHAGezV81dPT2BpBdowYTHro=;
        b=vOv3C4xxGlgrIEjS4S1ND49QNDPe/CUtCdCYufM+4WtcJLelzH61o9DeTtEIMA9ln2
         VVZA4VcGGPCGclZvDO4CbKCqUI5fXnbI4qSiL1On6lrhILPvhMLswh2x+Z3WdMYNxy4A
         g+Bx6wA5PBwI1AbnGTosFrQKLD691vingmBGQArkbjmc0WfxCq6Okz+SR8RGS9hNoJQ8
         pAd1a+NSzU8CkOaZGQB2SsXmat3xybbZ15+uF+VWFIn0BoAE3bXsszrEjw4PubPpM/s6
         MpyvI/2tru65Ay+8Iv9OxwTaMzP1kwZCRkF+S7NY+NqvA9hYQWxdUTGcdCdJaUzLkCbH
         whJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546794; x=1782151594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO5lIKAxGxaVD/I36g1nHAGezV81dPT2BpBdowYTHro=;
        b=gPrAoJgaO9n400WDNXvGFpQ9XxCi5pB/RyCHHt/apqXwRU3WFkHTAHh2zqCAHBBHpR
         aHTIBYwl7lVIGiN771dzBhrEpCVPeevxQbFcLc+pqP8EdH8ctq9+ntpdYsJ4kubq3RAN
         yQcQ5Qv0fCvKyNaPUpka49awD/tOYDehBUbifGoQ2tRMB+WKI4HrmkBW3wzDsEanPU6Y
         tCerAxwAYVOALP2YEohvSnQOLPgQcW+UvqasO74mqEi+y0cMR1b/deqC+hne0quo5dFH
         LwakGdZDkBQ/LVddEfH0prqmkgwEQpUYoJZIk/MTR68q+VhQHAQCXy6rZErIMC3xum/u
         x8pQ==
X-Gm-Message-State: AOJu0Yw1iqRl07dvSWTYacNalsR0ySAKKtRifUyfZU6VA7B0GZSZNsAg
	5iILgiRAppGSb1hK1uCpFQrGJxcV5J3RWK1vVRuwj3kvgGHN2mQIiTrhrTmQ9ERaxsUIz410EMK
	JKMoCRhW9jA==
X-Gm-Gg: Acq92OH2+nnCPKRRicJdXgAIeI1umzNZIoe9uqjdZkqfvSfayyVCmA82kt5PwsVoVpz
	HXZuUrJ7Lzm+npQVTdI+8tOAqKIkv68B3JMdLeE8DDC579lhzEIv5lROaaPSzmvPBbqLEUKe614
	B7yFwU92t8qKsaQRbynav/bDhKO6gUjekk0dVk/rpP18t7+moXUe9PgeApXDID2bfEMl5aNYSFX
	LTI8W04orawiz1pZ85YZ8mhs3Xz3St+xhyMq5m5dvGH5zSwKjOE9tF6V6BqIpVF/drYJidgcbJd
	aAo2MQC1dJKdjvCEIJk5123dtaNYX6LYXgvGd6ujZSiUAlbxgixHwQh1rXt273Ry2/uVRZT5qog
	9/lhr2vjxsLwL/nv6qzCQka5uJluVT9AA3NJXCwEprtErtl4xxibZIwi2Be9P4nmCcYC5Z4VTpA
	oktujfD3kvE5J925UHZKg=
X-Received: by 2002:a05:7300:dc0a:b0:304:188d:d0b0 with SMTP id 5a478bee46e88-30ba5f65ea9mr203164eec.20.1781546793645;
        Mon, 15 Jun 2026 11:06:33 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::bff7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e489621sm15678225eec.6.2026.06.15.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:06:33 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpf: Allow type tag BTF records to succeed other modifier records
Date: Mon, 15 Jun 2026 14:06:14 -0400
Message-ID: <20260615180614.4376-1-emil@etsalapatis.com>
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
 kernel/bpf/btf.c                             | 145 ++++++++++++-------
 tools/testing/selftests/bpf/prog_tests/btf.c |  12 +-
 2 files changed, 94 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef4402274786..b7954f42b396 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3475,9 +3475,8 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info, u32 field_mask)
 {
-	enum btf_field_type type;
+	enum btf_field_type type = 0;
 	const char *tag_value;
-	bool is_type_tag;
 	u32 res_id;
 
 	/* Permit modifiers on the pointer itself */
@@ -3486,30 +3485,37 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
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
+	res_id = t->type;
+	t = btf_type_by_id(btf, res_id);
+	while (btf_type_is_modifier(t)) {
+		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
+			goto skip_modifier;
+
+		/* Reject extra tags */
+		if (type)
+			return -EINVAL;
+
+		tag_value = __btf_name_by_offset(btf, t->name_off);
+		if (!strcmp("kptr_untrusted", tag_value))
+			type = BPF_KPTR_UNREF;
+		else if (!strcmp("kptr", tag_value))
+			type = BPF_KPTR_REF;
+		else if (!strcmp("percpu_kptr", tag_value))
+			type = BPF_KPTR_PERCPU;
+		else if (!strcmp("uptr", tag_value))
+			type = BPF_UPTR;
+		else
+			return -EINVAL;
+
+skip_modifier:
+		res_id = t->type;
+		t = btf_type_by_id(btf, res_id);
+	}
 
 	if (!(type & field_mask))
 		return BTF_FIELD_IGNORE;
 
-	/* Get the base type */
-	t = btf_type_skip_modifiers(btf, t->type, &res_id);
 	/* Only pointer to struct is allowed */
 	if (!__btf_type_is_struct(t))
 		return -EINVAL;
@@ -5860,11 +5866,10 @@ struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
 	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), btf_id_cmp_func);
 }
 
-static int btf_check_type_tags(struct btf_verifier_env *env,
+static int btf_check_modifier_chain_length(struct btf_verifier_env *env,
 			       struct btf *btf, int start_id)
 {
 	int i, n, good_id = start_id - 1;
-	bool in_tags;
 
 	n = btf_nr_types(btf);
 	for (i = start_id; i < n; i++) {
@@ -5880,20 +5885,12 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 
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
@@ -5971,7 +5968,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	if (err)
 		goto errout;
 
-	err = btf_check_type_tags(env, btf, 1);
+	err = btf_check_modifier_chain_length(env, btf, 1);
 	if (err)
 		goto errout;
 
@@ -6379,7 +6376,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
-	err = btf_check_type_tags(env, btf, 1);
+	err = btf_check_modifier_chain_length(env, btf, 1);
 	if (err)
 		goto errout;
 
@@ -6505,7 +6502,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	if (err)
 		goto errout;
 
-	err = btf_check_type_tags(env, btf, btf_nr_types(base_btf));
+	err = btf_check_modifier_chain_length(env, btf, btf_nr_types(base_btf));
 	if (err)
 		goto errout;
 
@@ -6818,7 +6815,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	struct bpf_verifier_log *log = info->log;
 	const struct btf_param *args;
 	bool ptr_err_raw_tp = false;
-	const char *tag_value;
+	const char *tag_value = NULL;
 	u32 nr_args, arg;
 	int i, ret;
 
@@ -7024,19 +7021,43 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	info->btf_id = t->type;
 	t = btf_type_by_id(btf, t->type);
 
-	if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
-		tag_value = __btf_name_by_offset(btf, t->name_off);
-		if (strcmp(tag_value, "user") == 0)
+	while (btf_type_is_modifier(t)) {
+		const char *new_tag;
+
+		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
+			goto skip_modifier;
+
+		new_tag = __btf_name_by_offset(btf, t->name_off);
+		if (strcmp(new_tag, "user") == 0) {
 			info->reg_type |= MEM_USER;
-		if (strcmp(tag_value, "percpu") == 0)
+		} else if (strcmp(new_tag, "percpu") == 0) {
 			info->reg_type |= MEM_PERCPU;
-	}
+		} else {
+			/*
+			 * If we fail to match on the tag value just ignore it.
+			 * Tracing programs have the same BTF as the function
+			 * being traced, possibly including type tags BPF is not
+			 * aware of. We cannot possibly account for them so ignore
+			 * them.
+			 */
+			goto skip_modifier;
+		}
 
-	/* skip modifiers */
-	while (btf_type_is_modifier(t)) {
+		/* Only a single tag value supported. */
+		if (tag_value) {
+			bpf_log(log,
+				"func '%s' arg%d type %s has multiple type tags\n",
+				tname, arg, btf_type_str(t));
+			return false;
+		}
+
+		tag_value = new_tag;
+
+skip_modifier:
 		info->btf_id = t->type;
 		t = btf_type_by_id(btf, t->type);
 	}
+
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log,
 			"func '%s' arg%d type %s is not a struct\n",
@@ -7075,7 +7096,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
 	const struct btf_type *mtype, *elem_type = NULL;
 	const struct btf_member *member;
-	const char *tname, *mname, *tag_value;
+	const char *tname, *mname;
 	u32 vlen, elem_id, mid;
 
 again:
@@ -7271,8 +7292,10 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		}
 
 		if (btf_type_is_ptr(mtype)) {
-			const struct btf_type *stype, *t;
 			enum bpf_type_flag tmp_flag = 0;
+			const struct btf_type *stype;
+			const char *tag_value = NULL;
+			bool tag_found = false;
 			u32 id;
 
 			if (msize != size || off != moff) {
@@ -7282,22 +7305,38 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 				return -EACCES;
 			}
 
-			/* check type tag */
-			t = btf_type_by_id(btf, mtype->type);
-			if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
-				tag_value = __btf_name_by_offset(btf, t->name_off);
+			id = mtype->type;
+			stype = btf_type_by_id(btf, id);
+			while (btf_type_is_modifier(stype)) {
+				if (!btf_type_is_type_tag(stype) || btf_type_kflag(stype))
+					goto skip_modifier;
+
+				tag_value = __btf_name_by_offset(btf, stype->name_off);
 				/* check __user tag */
 				if (strcmp(tag_value, "user") == 0)
 					tmp_flag = MEM_USER;
 				/* check __percpu tag */
-				if (strcmp(tag_value, "percpu") == 0)
+				else if (strcmp(tag_value, "percpu") == 0)
 					tmp_flag = MEM_PERCPU;
 				/* check __rcu tag */
-				if (strcmp(tag_value, "rcu") == 0)
+				else if (strcmp(tag_value, "rcu") == 0)
 					tmp_flag = MEM_RCU;
+				else
+					goto skip_modifier;
+
+				if (tag_found) {
+					bpf_log(log,
+						"type '%s' has multiple type tags\n",
+						btf_type_str(stype));
+					return -EINVAL;
+				}
+				tag_found = true;
+
+skip_modifier:
+				id = stype->type;
+				stype = btf_type_by_id(btf, id);
 			}
 
-			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
 			if (btf_type_is_struct(stype)) {
 				*next_btf_id = id;
 				*flag |= tmp_flag;
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

