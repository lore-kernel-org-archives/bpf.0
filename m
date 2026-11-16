Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808694;
	b=FOfCTAdoXWfmXQC3Rz5Frws18Bl+Dtb5lXUJ8RnH/vhjgCFZbWpYTiq/UK0g4etYiJsr
	 e4yM8y2iogCt9AXL+mcG+NTaq8vldbHMHFZhJPkkZNfYSj7CiMYy4k/nU75g4N/Rx0IOV
	 S4HlQvSGgen+38+n37BlwFwE5y3gGlDX5wso2EDyiS/0TAGjXYG9NOeX/jO4lQGOv29MK
	 nBj3zH1OdORQys66lLvlgKReZudhvfjWcR9loI6yjp/gcZ9iYawokm2lKiY6ORaMRW2Ym
	 Dco3BAyuxPBla/H0CrTqrdX9IA+C15SXwFHrWQbpgOJrJ4In1gwv1TMz6HMWDYglJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Rl6rpqCgINMnR0K8FGj1qRIflM9SM/kIkQeoCq0DYE=;
	b=UNT1/mkPfYTjcJbLMaaWNR39MNCkLajAvdiOMVUocRZxVrYLMVGaAfRjxgiLqOIgO3p3
	 jvHBjcReF9XV75AxYliSbS92mCaVQdV+uUHD3uREhV4/bM+Jnyp412vOwDwGeXeQpGbqI
	 hTFoJKmGeLVmQr+nAhO4xrmPBe5DUY0jW/6uJSSzKl/8eeGpzoQaKE+h1aN7a7ApmptTk
	 j/Oc7j80j75FelfGgpIDqZN/EO4jdtVBQ/j5z/5H/DrManW4pYlBIpCt87+0zmT/UQaU7
	 vmp2xy7TXTFWsTEvQd3ms1OP7kgpArtG1oUIg1KE42LfOpq46pNiv6vjMBnhhE5moVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNlKWD0c;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B814606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B814606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aNlKWD0c
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1623839a91.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808693; x=1795413493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Rl6rpqCgINMnR0K8FGj1qRIflM9SM/kIkQeoCq0DYE=;
        b=aNlKWD0cG922D56ZtMpl30PR1yTdWJwH/rEck8/NdqDimHRYIg4Z3WEyJPiigVK+rt
         edVdNXlk4onp1b2V8Er8mOA1uPFikEFcDBY3RtBTQOV+97wB5hV4WfGsXtx6fDwMK+XL
         xjEcFMWvrM/iDO6133Xmj20BIa2mlVHcOqPzLrrVaewNrPeD3Z+UL19bz6cTOuiyCRt+
         fTnBCMkFW4dyvM7dnHbIzIcYql1FFrZW3k+cFsXehGJg8UMUl3e08oKyI28ZoO2P6Nla
         9fRB+dlS2pazzZ07gVX1P36JMfSOIVQXaWWgV5j8SJ1yCgpjr/U7emVtxPR4VS5TqTTp
         GiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808693; x=1795413493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Rl6rpqCgINMnR0K8FGj1qRIflM9SM/kIkQeoCq0DYE=;
        b=Lp05Uig6ieFAXptEBf+ySk6t9KnkrV6PAKFSF8vur8lUZAXrPA0OpDYk+HNu/3uuZw
         2TNhtThdFuFCNYzS0NWNg+4gWzNE4h8lrh4ECTIQ+hEwtnwPwvLELlCfac0vXbLXCljR
         klIKZtM5jLTpK0VyvFYZc+UaW9sE5cKwSkMaGr9ZOr0PGGVoZYGrfPiT5x0g+JjgJxay
         4uaJ7zq4XfEtx/UnRh7UkhRMU5p6P82wQx0x3wMrDP9W9KqjZy1tygns3CXUaZUF7OZa
         kny8aupK1QpVshDDqWhYXoH7ZdodHAv/D/N+RRKEE1PEH0D/rvTwC+QzOOJinm7BH9pR
         ikjA==
X-Gm-Message-State: APuU4Z/ihM3bI2fT6Jp1sq5dtTkUGTzroUgE6z7648GQTCKZp4HHspO+
	m1S0SAOlin+Ja+TqEh91yc843/cUHZpiQa2GdRKcuJf6QCS35ER92i97eSI0LQ==
X-Gm-Gg: AZFdTZcn2xcOQ5TFmaT0VrxDWFSCQ3YjeqDiw+FzSnorSfSqEbG9m8FGzzYWT3OJYlI
	DNWBINKZn1Xa5aB9jXng19v7wESXUbL+/scvrAwmxx7pt9asNo4W/YlhlHz1lcQA836aelMmuBd
	KxSDP1mZJbKbff3L1WEDjjcKyN0HV+l/wfDXXWpkOcBdxQkS0xWWp8QmVhKzpoToCzWygb0k6SI
	SpV4Zg/YMj4ILzYwUY4WLbXZOne+9P4Y1Wxn3lM/K7tYpx3MT/ocFoYfl3VebZf7M9fu5ErmAtd
	dL06LArkAfaoXv7/HPI4FncAlGdISBmt+TdBn4O37tCeTj3qcqf13FrtFc3MgoaH1JtwC/oLytJ
	oiB0r5Zp27gD2560fYLF7gGpfAKWvMij+oPtsjjQ5/KcyIiKQClQYqLTMp3CHJQei482UBg633f
	Y4v+P+3ZffDgLg2PYJQOUxoJ6CiKVCG84GARHBAUb2R1gMLOwGqczwyUQhFva0O9eCeJzfv+R1n
	bMtzjdo8EfEA+Il1SKZEecOZ77dEYhHcv2H7Tgu9dsIf78wEG5VLEaPo689wjdxX1I7eKlws1HX
	3ZmuHzwJm34JZfUlAFylJk+369fL9m6x0JVE+mc/kz51acObw/8hivzTUnKhvB79idK+wU9oNmp
	hDMvQN6Or80wWbeN5+BZK+MAapOFShNr5Rwcf5SsFp13idNuCf9f8Pf4k3qZsOMQCVI71HCTfBg
	==
X-Received: by 2002:a17:90b:102:b0:3ad:4a8b:c703 with SMTP id 98e67ed59e1d1-3b1b0a42b42mr6089556a91.19.1794808693118;
        Sun, 15 Nov 2026 21:58:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm15408189a91.14.2026.11.15.21.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:58:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 15/21] bpf: Link the decl tags of a type
Date: Mon, 16 Nov 2026 05:56:32 +0000
Message-ID: <20261116055638.4171529-16-alexei.starovoitov@gmail.com>
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

The search for a tag looks at all types, for each argument of each
subprog. That is quadratic when the number of subprogs has no limit.

Link the tags when the BTF is loaded:

  next_tag[func] -> tag -> tag -> 0

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fffde271bbd7..9bb98a1c1072 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -281,6 +281,7 @@ struct btf {
 	char name[MODULE_NAME_LEN];
 	bool kernel_btf;
 	__u32 *base_id_map; /* map from distilled base BTF -> vmlinux BTF ids */
+	u32 *next_tag; /* see btf_link_decl_tags() */
 };
 
 enum verifier_phase {
@@ -1907,6 +1908,7 @@ static void btf_free(struct btf *btf)
 	if (!btf_is_vmlinux(btf))
 		kvfree(btf->data);
 	kvfree(btf->base_id_map);
+	kvfree(btf->next_tag);
 	kfree(btf);
 }
 
@@ -3636,13 +3638,45 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	return BTF_FIELD_FOUND;
 }
 
+/* For BTF of programs: next_tag[type] -> its first tag, next_tag[tag] -> its next tag, ... 0 */
+static int btf_link_decl_tags(struct btf *btf)
+{
+	u32 i;
+
+	btf->next_tag = kvcalloc(btf->nr_types, sizeof(u32), GFP_KERNEL | __GFP_NOWARN);
+	if (!btf->next_tag)
+		return -ENOMEM;
+	for (i = btf->nr_types; --i;) {
+		if (!btf_type_is_decl_tag(btf->types[i]))
+			continue;
+		btf->next_tag[i] = btf->next_tag[btf->types[i]->type];
+		btf->next_tag[btf->types[i]->type] = i;
+	}
+	return 0;
+}
+
+static int btf_type_ptr_cmp(const void *a, const void *b)
+{
+	return cmp_int(*(void **)a, *(void **)b);
+}
+
+/* last_id is 0 for the first tag */
 int btf_find_next_decl_tag(const struct btf *btf, const struct btf_type *pt,
 			   int comp_idx, const char *tag_key, int last_id)
 {
+	int i = last_id ?: btf_named_start_id(btf, false) - 1, n = btf_nr_types(btf);
 	int len = strlen(tag_key);
-	int i, n;
+	struct btf_type **p;
+
+	if (btf->next_tag && !last_id) {
+		/* the types are in the order of their ids in btf->data */
+		p = bsearch(&pt, btf->types + 1, n - 1, sizeof(*p), btf_type_ptr_cmp);
+		if (!p)
+			return -ENOENT;
+		i = p - btf->types;
+	}
 
-	for (i = last_id + 1, n = btf_nr_types(btf); i < n; i++) {
+	while ((i = btf->next_tag ? btf->next_tag[i] ?: n : i + 1) < n) {
 		const struct btf_type *t = btf_type_by_id(btf, i);
 
 		if (!btf_type_is_decl_tag(t))
@@ -3665,8 +3699,7 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 	const struct btf_type *t;
 	int len, id;
 
-	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key,
-				    btf_named_start_id(btf, false) - 1);
+	id = btf_find_next_decl_tag(btf, pt, comp_idx, tag_key, 0);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -6519,7 +6552,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	if (err)
 		goto errout;
 
-	err = btf_parse_type_sec(env);
+	err = btf_parse_type_sec(env) ?: btf_link_decl_tags(btf);
 	if (err)
 		goto errout;
 
@@ -8677,8 +8710,8 @@ static int btf_scan_decl_tags(struct bpf_verifier_env *env,
 			      const struct btf_type *fn_t,
 			      u32 arg_idx, bool is_global, u32 *tags)
 {
-	int id = btf_named_start_id(btf, false) - 1;
 	const char tag_key[] = "arg:";
+	int id = 0;
 	static const struct {
 		const char *tag_value;
 		enum btf_arg_tag arg_tag;
-- 
2.55.0

