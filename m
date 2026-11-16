Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808711;
	b=n5Y5YzMBshdBcwDuj+zEWoIQjxWb+iMXRU9vZ+cR2uBNkjbrh0X9b2RHek3SS7eWK0vQ
	 1iDUXX7zliHzP1zPAwCAPtkwqUBm9TeWpAQynI0RECk8hj1dn9qvPl9q49o9GLCr/Us5v
	 lPOC+N78705I/uvYgNYjwnQUGNb1oN859q4q+x8iuAXKTLs6HHtlOD7zUpMaNwf+oj1Fq
	 +MQ0XQ2TPt+Ayj9CGHNk3HbIrC1lq/LdTNIFrNH+I8fGl5yKH6XTy8P+ISPkcJkzEM9d0
	 F0VSRzjC8nOrhXR4HayrUD4BYW89oFt559LLXdaJH45iPRYzpwuelzXgWmnB2F8Azvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t23Bo3Qlr9E/p+IrhICjUTqkQl9+evkBHi9ttxXjS8U=;
	b=Nz69rE/8J5HbUbMpwQkR7LXQyjpC0iTsoiUQvhX9JHL8vaTn2XoEI5J0DhLSXkCWtlLi
	 T4Fh396ETbDdL7XT3psDpurY2tDmOBuChGhwdba7qli+gZYkOw5JwiaYxIQmBGKmdMz6+
	 wMiBqo6EWI7fiP1tpgLduPdJ5y0BpUfBav4zbamAPkAN9pJZoMps8yk+5kc4q7hO0tP8b
	 SW72J2xTNpH6NiIGBXnzqGzGR3Qlwp27nkvNCqzfMONxLNiQdQ5pO+Y9aBtDKIuTX2cuq
	 xI9TV2nkFMHpB48SkmzTkzKJTcrvowVx3iZsjdZeV/v1fA1QaunBOj+Mdu77dKYXmAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sPMHkaLB;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DC606A333
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 601DC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sPMHkaLB
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso817059a12.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808711; x=1795413511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t23Bo3Qlr9E/p+IrhICjUTqkQl9+evkBHi9ttxXjS8U=;
        b=sPMHkaLB7owTIqnFqGle6efXgbYbkwNDBYGpfbDBAzrSbS4e72RybvL7AtfE6P5vMk
         E8W+rGHTLjiufXIvPhV/aooTLUZW6AhRARd0Kj0Flqjhk4WP91ndMfkEnWEVjpASGSN5
         EHi/A8pVla8WuADyr3KgZur236WFTPde3xbReTjQiiLPztBIPonxBApw+kWtpLnj4mJv
         0Su8fT3yPzRcXFrwnKBgWZQ3JJahxU1nlskFlopQQ/exh4UdRYkvW2g4vQV0KR41R7Dx
         v4ve23acYOQCvKKmvtUmrRfaJEZi7Qcxn7XRpX2hJd3beQZT17uiuEPSso2xg3LYmVdm
         BIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808711; x=1795413511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t23Bo3Qlr9E/p+IrhICjUTqkQl9+evkBHi9ttxXjS8U=;
        b=JVHVZgMUdmwXyI2GGSf6tgy//uWyZXcD/zMtlqHzDSlrxEZcsulyqHvRQCiw5RZwBa
         +5f0htb7OIR5fz1hIWJ8gwUgbDivrxWpuTC1BZ1urNBlKIgkesobrsKFR3MpzoozWBzS
         Wif+Zm8qqiGlTzAxEoHYBUWDYi2WexD64xlDvYSx5mPMRtRGjEva6yDi2NeRny1T7tbO
         dAv+jnzE3o5hz372Iv/sumQvPvuOLb41H2PVskFSToDtk3cX98F6uHIEf6GgMXieGYp0
         T5uEIBYf40HMU/iWFOLSYjamPGxS0htzI61ub+h3OIocauaAZwh7lZSQvYh/VYhMagNe
         vYkQ==
X-Gm-Message-State: APuU4Z/UixZXJ0wrx6m3JplEPa6F1/y2ZrVU3/elK505vdSuUXZvGXaa
	ilmIK/6hY1SqIIm3hfpL4nh5NDOHmTWQ4fbNE0DdtM66g6FKbI0lvQB4KOzX4w==
X-Gm-Gg: AZFdTZcNOEbi/X/pc8Rh+r5EunmR/I7BDOwTnLRJS3sbIB0S7xAdhF0dABbyaObzK/F
	3CYWX43YDB4+ofzuEHF8uOPiBAaRAaN9Ylw2O2mN7ktG0igsGyj8TD0A80F9z5ocuIHxvBMFafb
	2tCxOdOZ8dPC5KO6BUvKWJLU9PUp6YJI1o0KGx3q/38KXdSbJ4aw3uMn1WdUe4nEXcosIwJvsjR
	6WWioS6YBr6XTXZRURsThvtfg/K1mTT+uc9HIRyl4D36vGxjNws6mbAu6z5oEQ7XvpOuRGMzotV
	Gp67QFNLdDiqR9WlXgwa8MQQ+X0L7Q4bgMWq/OU+DD1NL+O51wtCg+GtgaW3UhgKkgqXGR6vaoa
	NdzP6VDNeA6uprpMCj1W3lsk9Nquh47BwVM1a+yk+wc1pugdrNpAIskZdmsVRTVtOTe97AUfDii
	lL60CBJB2eVDuq08DpdN6GR/KFb07I2F/UJSyNJhVvG455i8y//MlVQ4oYVosgQSoC3tEftSMPL
	iKc9tTnAwJY47NCU2unau11ixBFJVLFRVE5MD1pArmLouoXHYK4G4wdCjteACWPNQUjk+XUm8uc
	8MLCgbm9FmQxzu3jhPro8BMT0gCf1oosjy7EEkatKE2ofq1hpFmetJCKrEgxuan1yEAotZKyp5z
	jydLKvNjdsd6lsrFIETfzfS+wJ+GkldUad9iQ2kCcaUbByyJneZfZuV9W0ipKKIDB4RHs4qp4Ig
	==
X-Received: by 2002:a17:90b:1d46:b0:3ac:7613:1ec3 with SMTP id 98e67ed59e1d1-3b1b0a3eaaemr8322360a91.37.1794808710545;
        Sun, 15 Nov 2026 21:58:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3ac294bsm7295869a91.2.2026.11.15.21.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:58:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 18/21] bpf: Raise the limit on the length of BTF names
Date: Mon, 16 Nov 2026 05:56:35 +0000
Message-ID: <20261116055638.4171529-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
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

