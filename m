Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842903;
	b=lFNdxJlpcC9ciSZr/r+5RX6fWXh7951i8NIebki/Pu807yhcmNz0XW4+vC1HoIGgAscw
	 PDtRBj7RlbaPI39aHHbrbU/9PvvfPCf9llwStl1DYwA/2Ujbq0NxFZHbXbWpIwNdRF3Jw
	 0dej8GMSULTxTk5icjp5n6I6kMAGvdUHfxiihCY6E2bIC7+ds1r3sDFGjdwdEPFMCSmca
	 wlGcsv7ca5lBQbTWNP8ITtmtHOVXN9LUy5UbBWhEg2h3pJEtMTcBphY5VYB+0jHmeSlKZ
	 c/s5Grg994OT82vrq8pAe/8TOAkjkcpfstP9d38OQJG8Fm0Cl7yJOl9/uTkec111+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t23Bo3Qlr9E/p+IrhICjUTqkQl9+evkBHi9ttxXjS8U=;
	b=tQIcwwVB7yQrzu2pZSvWqbSh47isYDMqlneTc739rM9RqI8gzl79EIPWs1ARjpFMJQVX
	 YsXl8Jk3pej9K7kz1NJ+ZVrFAjMMMKAiS4qaDXXuR3sUpoOHmp+AmakNbPoxW0cqwEp/n
	 oKld4BCNx2ul35PlGYo7pjqCYLvwW+BRhJDw4jdMR2gWxlUDYvsj79SF9qOush/YUlixm
	 V6w0zDvvCd5cXyh65rzuWG3Kh6rtV2MJGMy/p65ibfAf25KMTgKUQVaN26XotxAm+5FQo
	 2ofVDE/0m5CYh378mPmBsj8zahI+VoUBmGZerar5Amw7TExjuDT9YezXYPejXm6vg+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=anXStpTJ;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4E606A334
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D4E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=anXStpTJ
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1703062b3a.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842902; x=1795447702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t23Bo3Qlr9E/p+IrhICjUTqkQl9+evkBHi9ttxXjS8U=;
        b=anXStpTJ2GWaMDIJuGNAOsKuyR6d6Hv4TWN4XBF2RP3lWlFQc3IBYa+xILkjyPOfWI
         zMzbgWGmIKJufZn23rGzL4aZx0H39oRmMaAf296wxf1p8XkBiIcIhvHP7vlVDjIeQQNu
         ycbHlVEz6oYF0tiQnaWEVXFvQsrqJ/uxTMfe+O/mgVvWtX11xVdeN/Tl5EDHIuGpTzkF
         svAVgCnUqoOwoUXjx4n3xWb4lfUKtmY4J/2SNwJpq3r9IIH2/u1jiPAlju8zHzfnWyJa
         +jiQzAjeEABkaMr0rYtbkQO650m0nNZWhZRPp1c/JADqZHTQ5zxMWcI0IECMpLWfMVhS
         HaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842902; x=1795447702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t23Bo3Qlr9E/p+IrhICjUTqkQl9+evkBHi9ttxXjS8U=;
        b=0ZkyFAYJQVxIByhQS4JfroPMJQiOuwCbq3wEMEY8AmbeS94TTuHmSVeLxtn4E/XWsu
         /3gHnDIimIa+vXC5nWZfsNKnb5L0YGcV2L00nRZbJNyt1VZ9cwFVhKHiLZrWRhIpzmrd
         s71ex50n15MVtb16fxjZkGKe4jhJM/N8KiqvVq9Ot+21wEFaJfMNs815kMXkRUaUbOnu
         wGi9pSQu+XlX+y4fqbzxsoZpvUoEX6R8HcPuTS9KSQDAjZ/1SqI8GmWwcqzoBwerWXUA
         PrhvPBhiVOmIN0PR1WwY+mDpjO5kHFPXA6DWMyfpVxnA0en8yE5CRicBAMDxxGv1ilOR
         owzw==
X-Gm-Message-State: APuU4Z/ezoQ5qyDJz9llV6NsTO+FApZdflwPeDB7qxwTWNpUxTs9k8dC
	0XI8GA40xjyS7eMT6oY4j2CHOpUkSMYatSl4bI7PMF1WLw0+95sL9nb0SpOwCQ==
X-Gm-Gg: AZFdTZdsF6lfiG4Ja/sys/mR/FJlG1DdCKUr0n4+1zH1718+jXokvgYgZ9Dq1mfkaRl
	SwTvK7fIth1xr72N8mG+mEkOnJaizjtmTUzC2G93Qh+vevmfGMITe7QJpawgDTCxneJPm05/15A
	XhfawsYyX1Ex2MRpcQcGJbHXSMuC4jUA23NZmVkmGCLjJUVaiOtiHx34rS0Pw5VU3pnH6mhvCm+
	Z/fSEq4dl4b5aFXKGcFnboIXJIa/R/pMwtlRyq0+MQWZ/bkA9Ms+QsB+St3ZsiesqTX+efk5Y9y
	w3tG6Sj9LInnXZqbR/VGd6S0pTqAbOE1FdJkPE00q1dINLScXl1QIiFPZsiWeaRhceP3ykMCAWg
	IUILrPpM7kBSYvWsmfNvxmkA4TDWZAdixg8t0zKTh/Qf6EHaZxnjiCwsLk0gjRreV4kAk95cFXD
	Mb/LKam4mhIto1BM9h1doaB+VWMfwWd5kX0EsCiTc+hD9qkya3+uzTLtuferY39LiDIC+guxeF+
	4IBisE9KqtiF+8dGRTVu82idVYNQIw/ZtaVZxWNH6Dn0z+A+W+M/YXoIw8cGWWpdSGoJY81B6uU
	bSUbcyFgfvhgP9P1QndUgIeWWdNYuBPXLWRYJDLBPG/mlQeAdGyXxw+DzV6wIhB+3FXc5ny8rnB
	AqDUF3L3VyH1pKTLzYMIw4opMWA0lBikontXEGaJuMhlF8o5EQSJ3uTWlvUsaVY1iSusYNdKVTw
	==
X-Received: by 2002:a17:902:e80c:b0:2e9:5772:9aa5 with SMTP id d9443c01a7336-2ee0dac6b6emr102906825ad.32.1794842901622;
        Mon, 16 Nov 2026 07:28:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a583b4sm1037915ad.44.2026.11.16.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:28:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 18/21] bpf: Raise the limit on the length of BTF names
Date: Mon, 16 Nov 2026 15:26:23 +0000
Message-ID: <20261116152626.4032587-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A name of 513 bytes refuses the whole BTF. Mangled names can be longer.
The users that copy a name use snprintf(). Raise the limit to 4096. It
cannot go away: a search by name takes types x length, and so does the
log. The search can be stopped now.

Many types can point into one long string. Look at each byte once and
keep a bit for each offset:

  strings:  f o o \0 b \7 r \0
  names:    1 1 1 0  0 0  1 0

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 108 +++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 56 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f97b8e754863..e95ca39f990c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -309,6 +309,9 @@ enum resolve_mode {
 					 */
 };
 
+/* It bounds the time of the loops that compare or print names */
+#define BTF_MAX_NAME_LEN 4096
+
 #define MAX_RESOLVE_DEPTH 32
 
 struct btf_sec_info {
@@ -320,6 +323,7 @@ struct btf_verifier_env {
 	struct btf *btf;
 	u8 *visit_states;
 	struct resolve_vertex stack[MAX_RESOLVE_DEPTH];
+	unsigned long *names;	/* offsets of the strings that can be names */
 	struct bpf_verifier_log log;
 	u32 log_type_id;
 	u32 top_stack;
@@ -685,10 +689,15 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 				return id;
 		}
 	} else {
+		/* only the tags in BTF of a program have long names */
+		bool slow = !btf->kernel_btf && strlen(name) > KSYM_NAME_LEN;
+
 		for (id = btf_start_id(btf); id < total; id++) {
 			t = btf_type_by_id(btf, id);
 			if (BTF_INFO_KIND(t->info) != kind)
 				continue;
+			if (slow && bpf_must_abort())
+				return -EINTR;
 			tname = btf_name_by_offset(btf, t->name_off);
 			if (strcmp(tname, name) == 0)
 				return id;
@@ -915,49 +924,6 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-/* Names in BTF of Rust are not C identifiers. Allow any printable character */
-static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
-{
-	/* offset must be valid */
-	const char *src = btf_str_by_offset(btf, offset);
-	const char *src_limit;
-
-	if (!isprint(*src))
-		return false;
-
-	/* set a limit on identifier length */
-	src_limit = src + KSYM_NAME_LEN;
-	src++;
-	while (*src && src < src_limit) {
-		if (!isprint(*src))
-			return false;
-		src++;
-	}
-
-	return !*src;
-}
-
-/* Allow any printable character in DATASEC names */
-static bool btf_name_valid_section(const struct btf *btf, u32 offset)
-{
-	/* offset must be valid */
-	const char *src = btf_str_by_offset(btf, offset);
-	const char *src_limit;
-
-	if (!*src)
-		return false;
-
-	/* set a limit on identifier length */
-	src_limit = src + KSYM_NAME_LEN;
-	while (*src && src < src_limit) {
-		if (!isprint(*src))
-			return false;
-		src++;
-	}
-
-	return !*src;
-}
-
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
 {
 	const char *name;
@@ -1993,9 +1959,21 @@ static int env_resolve_init(struct btf_verifier_env *env)
 static void btf_verifier_env_free(struct btf_verifier_env *env)
 {
 	kvfree(env->visit_states);
+	kvfree(env->names);
 	kfree(env);
 }
 
+/* Names in BTF of Rust are not C identifiers. Allow any printable character */
+static bool btf_name_valid(const struct btf_verifier_env *env, u32 offset)
+{
+	const struct btf *btf = env->btf;
+
+	/* offset must be valid */
+	if (offset < btf->start_str_off)
+		return *btf_str_by_offset(btf, offset);
+	return test_bit(offset - btf->start_str_off, env->names);
+}
+
 static bool env_type_is_resolve_sink(const struct btf_verifier_env *env,
 				     const struct btf_type *next_type)
 {
@@ -2768,7 +2746,7 @@ static int btf_ref_type_check_meta(struct btf_verifier_env *env,
 	 */
 	if (BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF) {
 		if (!t->name_off ||
-		    !btf_name_valid_identifier(env->btf, t->name_off)) {
+		    !btf_name_valid(env, t->name_off)) {
 			btf_verifier_log_type(env, t, "Invalid name");
 			return -EINVAL;
 		}
@@ -3030,7 +3008,7 @@ static s32 btf_fwd_check_meta(struct btf_verifier_env *env,
 
 	/* fwd type must have a valid name */
 	if (!t->name_off ||
-	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -3353,7 +3331,7 @@ static s32 btf_struct_check_meta(struct btf_verifier_env *env,
 
 	/* struct type either no name or a valid one */
 	if (t->name_off &&
-	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -3371,7 +3349,7 @@ static s32 btf_struct_check_meta(struct btf_verifier_env *env,
 
 		/* struct member either no name or a valid one */
 		if (member->name_off &&
-		    !btf_name_valid_identifier(btf, member->name_off)) {
+		    !btf_name_valid(env, member->name_off)) {
 			btf_verifier_log_member(env, t, member, "Invalid name");
 			return -EINVAL;
 		}
@@ -4162,6 +4140,8 @@ static int btf_parse_graph_root(const struct btf *btf,
 	 * verify its type.
 	 */
 	for_each_member(i, t, member) {
+		if (bpf_must_abort())
+			return -EINTR;
 		if (strcmp(info->graph_root.node_name,
 			   __btf_name_by_offset(btf, member->name_off)))
 			continue;
@@ -4640,7 +4620,7 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
 
 	/* enum type either no name or a valid one */
 	if (t->name_off &&
-	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -4656,7 +4636,7 @@ static s32 btf_enum_check_meta(struct btf_verifier_env *env,
 
 		/* enum member must have a valid name */
 		if (!enums[i].name_off ||
-		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+		    !btf_name_valid(env, enums[i].name_off)) {
 			btf_verifier_log_type(env, t, "Invalid name");
 			return -EINVAL;
 		}
@@ -4748,7 +4728,7 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
 
 	/* enum type either no name or a valid one */
 	if (t->name_off &&
-	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -4764,7 +4744,7 @@ static s32 btf_enum64_check_meta(struct btf_verifier_env *env,
 
 		/* enum member must have a valid name */
 		if (!enums[i].name_off ||
-		    !btf_name_valid_identifier(btf, enums[i].name_off)) {
+		    !btf_name_valid(env, enums[i].name_off)) {
 			btf_verifier_log_type(env, t, "Invalid name");
 			return -EINVAL;
 		}
@@ -5054,7 +5034,7 @@ static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !btf_name_valid_section(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -5246,7 +5226,7 @@ static s32 btf_func_check_meta(struct btf_verifier_env *env,
 			       u32 meta_left)
 {
 	if (!t->name_off ||
-	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -5315,7 +5295,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !btf_name_valid_identifier(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -5381,7 +5361,7 @@ static s32 btf_datasec_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !btf_name_valid_section(env->btf, t->name_off)) {
+	    !btf_name_valid(env, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
@@ -5768,7 +5748,7 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 
 		if (args[i].name_off &&
 		    (!btf_name_offset_valid(btf, args[i].name_off) ||
-		     !btf_name_valid_identifier(btf, args[i].name_off))) {
+		     !btf_name_valid(env, args[i].name_off))) {
 			btf_verifier_log_type(env, t,
 					      "Invalid arg#%u", i + 1);
 			return -EINVAL;
@@ -6067,6 +6047,7 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	const struct btf_header *hdr;
 	struct btf *btf = env->btf;
 	const char *start, *end;
+	u32 i, len = 0;
 
 	hdr = &btf->hdr;
 	start = btf->nohdr_data + hdr->str_off;
@@ -6091,6 +6072,21 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	/* many names can share one long string: look at each byte once */
+	kvfree(env->names);
+	env->names = kvcalloc(BITS_TO_LONGS(hdr->str_len), sizeof(long),
+			      GFP_KERNEL | __GFP_NOWARN);
+	if (!env->names)
+		return -ENOMEM;
+	for (i = hdr->str_len; i--;) {
+		if (!start[i])
+			len = 0;
+		else if (!isprint(start[i]))
+			len = BTF_MAX_NAME_LEN;
+		else if (len++ < BTF_MAX_NAME_LEN)
+			__set_bit(i, env->names);
+	}
+
 	return 0;
 }
 
-- 
2.55.0

