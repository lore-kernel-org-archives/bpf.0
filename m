Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243278;
	b=KL3RGoagnAqHtHXCFwPJ0kSowinWqgKP1eG/c9Or1BMN4r1wJk+wMQQH2/eAflmz9NBE
	 1d2XZBsmCGIMNUqrE3U6DS43qaZ1CgjboaqGx9WQKokubJI35aNMxG4zNe0gD0SKAPquW
	 ZSEK0id5D28zwf7bCA2CKcD+6kt4tQZAausRKP4PYz/ApuMOuN2dmg3DuYxCeZMHyTAK1
	 G8k66aEK9CyHus2KA380YVEofmJ98bceA3E+d7BLNhQGTcO0q/8yAhijHzQ46Qa470ZVg
	 gV7MqJVNKDVf6Q4A78124K7JDtt0xbvsasYbjBMAiMZqIe7c5a6bbVqcA4W/x+B6YdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oEd5Iu/Y011XrY65hgeL6wzzOhAHQgrEz42YJca4Kxo=;
	b=KoLn1OAopNxq+L946aQ+t4zu90nrVRZddkULpFSPtofB5V7pt5/J+5p4THQbT3Vw4BlE
	 IFFOE2bJx2ygc6BPQ4pBxEdGhzgypxT4sl6R7zvf3XyeQTH1IQQiF1MPdZmlouv1algvm
	 syQ4CNTaEjqQCesdRSbLF1Se1DfoII0VxLUGZCCuPQ5/73hru0wvQSmzokYqTdPWigGLQ
	 E9qaky6tuN/AJgOnUFvAjvdAksO3HeAKTCs/pyz+Al8Znin5/MbRbhw5QTgGfc0QsTlVO
	 pX316kqcbctgcuY/sbuy2LXz7O1qFIaa1+xLwiBXzv8qPc6+1uVzObkIGDbLVae2MTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APvGJ3mL;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920D606A326
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5920D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APvGJ3mL
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e10a70540so700939f8f.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243277; x=1794848077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oEd5Iu/Y011XrY65hgeL6wzzOhAHQgrEz42YJca4Kxo=;
        b=APvGJ3mLxpSYP7SGI/9137F+Fbid7i1X+7jY44VsjmldwfHqRcDYReQiDOWrRZ3tRy
         NbS4fZZbksdrT5CPsL5gc1U3DfLDjmIvkICLD3ai0/XJTEZLKuqcpdcx33EQpZfoNJ5N
         utdRxmzf9BEwjORYAVm1YaHJD05YrYy3SdYFutRx1srf8dnASAKeyBppRSXny3pztVXn
         4hZeHBLverMwTbulbq1zriBSG9sK69oD9NdRb1gB9RV2UEBT+NGET4UMt9KAH0CqrxCA
         GIK2PUJuqWgwvrA2i1iRsh8YOU3KmbwCC5y95zANyKaYOzlaaaqwAs4ugDFcc/5FgBSU
         ws/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243277; x=1794848077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oEd5Iu/Y011XrY65hgeL6wzzOhAHQgrEz42YJca4Kxo=;
        b=rcULBQpTAMvbAo2E8bPBSVSbNPn8h4brbbT4vk7uOI0TA7OK/e6GABTBSzvUbukKF1
         +0BiYeU2eoOZrKapBiaqyuIjXdxf/0N0qk8Xjz5vQNN9VyEHHKVdKNY2QVkfBLC6adiF
         w/PE0UQBtU83zQcKNKGm4UmA/XdcUnrQ04Mk4+Ek3RPI1L53i1bpLDvmNecWtP6A7AJ6
         5kMwWPr+c/bVhQ4/iezj0pdFKdvxM803nsAP0qZRvTy+IO0dXitlj5YdnSO7EymfDScz
         5kt9fT2QSqE2KyA3qaQPP5wdoBlSD8gZmNQ6qsL+uLa5zBMQlff9X/MUvnfwESls2qIu
         0Sig==
X-Forwarded-Encrypted: i=1; AL+hErFHddnCQ50kVyatL+cYzl9rOF8IjwuOOBBwwvqIvJeV6ZFnH/RcYgG3nT0TGPhcXb8s79k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FvejHfM3Y8h/ga/5G5F8xv8aZKPqBH8XI3ZdU1tGiK1ML1Xc+
	z045TZpLwe2FiExx+4SwdN3mUFZVZy20Dg9I963I6OCqQV+o1Yo11iyX
X-Gm-Gg: AYBFou0x96fWxYjWE87od2GxV/2M3KaAQJcCFlLG6dDOmuXTp0Ec22SL9lP3f+fQK2D
	qvvW6czXJdg5fRj3IhTLEVNh9jR6Gs3Lzygtkc6oeP37tMjL9anMRw+Zp6FqGrL4a4IxmlKrs0W
	p2hajqUnBlXTXDZRuA3N66HKRNupvw+0J7MHqIJAfBEpG9cpwVQWlay1wNI0im6vqma9tecVx/h
	ZMc3CuLLDvw6ROmOguz52zurwW2laHeDhrbSm4wiqwqwAS0FoTp8JASV3JTJXrgwgxu02DpVRG/
	vWTqvbbaRzcjSc4cgDeonYaL813kBKjDKqC4FGoCHGZo9+u/jDgqOSxZ0qInM6r7rTRWJPv3jL1
	6kfF6FaCw+XWSg8ruTH+LVFdZUHr1WS7QS1oZ+HIKw4aNztcH5hilUl/LJYFymbrIk2anXfLXNo
	Q4zeVxhePGnwLjUu1NSni9aqimsAh7ECQwvQnQr/MjLwYUZFoJbKqZct8Hp7mPL/oG6Lf0la3mu
	7Vqe8BIT92x6nnBLyj3uETwn1rZMx8wqjwaBLQPc8PjtZMjbA4h1EROvdyndLoOIT5rifAf7PEq
	fMo28B5XdMfGOz7TxadcbSytGwcf3b2psIFwEFIOqCKeqQQxnlstsMD+erWklEpzd5v9
X-Received: by 2002:a05:6000:2004:b0:48d:f391:5c45 with SMTP id ffacd0b85a97d-498309ae8f3mr56006f8f.42.1794243276690;
        Mon, 09 Nov 2026 08:54:36 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:35 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 01/18] bpf: Add BTF ID sets for fmod_ret targets
Date: Mon,  9 Nov 2026 17:05:21 +0000
Message-ID: <20261109170550.141443-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

Add BTF_SET8_FMODRET and the BTF_FMODRET_START() and BTF_FMODRET_END()
macros to declare the functions BPF fmod_ret programs may attach to.
They work like kfunc sets: each entry is a BTF_ID_FLAGS() line and
KF_SLEEPABLE marks targets sleepable programs may attach to.

Teach resolve_btfids to find these sets and tag every listed function in
BTF with a "bpf_fmodret" decl tag, plus "bpf_fmodret_sleepable" when
KF_SLEEPABLE is set. The sleepable tag never comes without "bpf_fmodret"
and readers of the tags may rely on that. Share the set walk with the
kfunc collection. Any other flag is an error. Nothing in the code refers
to the sets, so keep .BTF_ids in the linker script, or --gc-sections may
discard them.

Nothing declares such sets yet and the kernel does not read the tags yet.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |   2 +-
 include/linux/btf_ids.h           |  14 ++++
 tools/bpf/resolve_btfids/main.c   | 121 +++++++++++++++++++++++++-----
 tools/include/linux/btf_ids.h     |  14 ++++
 4 files changed, 130 insertions(+), 21 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..f8254a88e05d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -714,7 +714,7 @@
 	BTF_INLINE_LINK						\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
-		*(.BTF_ids)						\
+		KEEP(*(.BTF_ids))					\
 	}
 #else
 #define BTF
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 8b5a9ee92513..f27b7db81100 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -13,6 +13,12 @@ struct btf_id_set {
 /* This flag implies BTF_SET8 holds kfunc(s) */
 #define BTF_SET8_KFUNCS		(1 << 0)
 
+/*
+ * This flag implies BTF_SET8 holds functions which BPF fmod_ret, fentry and
+ * fexit programs may attach to. Per-function flags: KF_SLEEPABLE only.
+ */
+#define BTF_SET8_FMODRET	(1 << 1)
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
@@ -215,6 +221,12 @@ __BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
 #define BTF_KFUNCS_END(name)				\
 BTF_SET8_END(name)
 
+#define BTF_FMODRET_START(name)				\
+__BTF_SET8_START(name, local, BTF_SET8_FMODRET)
+
+#define BTF_FMODRET_END(name)				\
+BTF_SET8_END(name)
+
 #else
 
 #define BTF_ID_LIST(name) static u32 __maybe_unused name[128];
@@ -231,6 +243,8 @@ BTF_SET8_END(name)
 #define BTF_SET8_END(name)
 #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
 #define BTF_KFUNCS_END(name)
+#define BTF_FMODRET_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_FMODRET };
+#define BTF_FMODRET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index c16dd93fa6d4..e0fb7525a5ea 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -69,6 +69,12 @@
  *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
  *
  * These kfunc annotations were historically produced by pahole.
+ *
+ * Functions found in BTF_SET8_FMODRET sets are the targets of BPF fmod_ret
+ * programs. For each of them resolve_btfids emits a "bpf_fmodret" decl tag,
+ * and also "bpf_fmodret_sleepable" when KF_SLEEPABLE is set, so the sleepable
+ * tag never comes alone. The kernel builds the set of fmod_ret targets from
+ * these tags when it loads BTF.
  */
 
 #define  _GNU_SOURCE
@@ -197,7 +203,10 @@ struct btf_links {
 
 #define DECL_TAG_FASTCALL "bpf_fastcall"
 #define DECL_TAG_KFUNC "bpf_kfunc"
+#define DECL_TAG_FMODRET "bpf_fmodret"
+#define DECL_TAG_FMODRET_SLEEPABLE "bpf_fmodret_sleepable"
 
+#define KF_SLEEPABLE	(1 << 5)
 #define KF_FASTCALL	(1 << 12)
 #define KF_ARENA_RET	(1 << 13)
 #define KF_ARENA_ARG1	(1 << 14)
@@ -208,6 +217,7 @@ struct btf_links {
 #define PARAM_SUFFIX_ARENA "__arena"
 #define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
 
+/* A function found in a BTF ID set: a kfunc or an fmod_ret target */
 struct kfunc {
 	struct rb_node rb_node;
 	const char *name;
@@ -221,6 +231,7 @@ struct btf2btf_context {
 	u32 nr_decl_tags;
 	u32 max_decl_tags;
 	struct rb_root kfuncs;
+	struct rb_root fmodrets;
 };
 
 static int verbose;
@@ -1256,16 +1267,16 @@ static int push_decl_tag_id(struct btf2btf_context *ctx, u32 decl_tag_id)
 	return 0;
 }
 
-static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
+static int push_set_func(struct rb_root *root, const char *kind, struct kfunc *kfunc)
 {
-	struct rb_node **p = &ctx->kfuncs.rb_node;
+	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	struct kfunc *k;
 
 	/*
-	 * Dedup by BTF ID: collecting the same kfunc twice is a no-op,
-	 * UNLESS the kfunc flags are inconsistent, in which case we
-	 * fail hard because it indicates a bug in a kfunc set declaration.
+	 * Dedup by BTF ID: collecting the same function twice is a no-op,
+	 * UNLESS its flags are inconsistent, in which case we fail hard
+	 * because it indicates a bug in a BTF ID set declaration.
 	 */
 	while (*p) {
 		parent = *p;
@@ -1278,8 +1289,8 @@ static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
 		} else if (k->flags == kfunc->flags) {
 			return 0;
 		} else {
-			pr_err("ERROR: resolve_btfids: kfunc %s has inconsistent flags across BTF ID sets: 0x%x != 0x%x\n",
-			       kfunc->name, k->flags, kfunc->flags);
+			pr_err("ERROR: resolve_btfids: %s %s has inconsistent flags across BTF ID sets: 0x%x != 0x%x\n",
+			       kind, kfunc->name, k->flags, kfunc->flags);
 			return -EINVAL;
 		}
 	}
@@ -1290,7 +1301,7 @@ static int push_kfunc(struct btf2btf_context *ctx, struct kfunc *kfunc)
 
 	*k = *kfunc;
 	rb_link_node(&k->rb_node, parent, p);
-	rb_insert_color(&k->rb_node, &ctx->kfuncs);
+	rb_insert_color(&k->rb_node, root);
 
 	return 0;
 }
@@ -1344,7 +1355,16 @@ static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
 	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
 }
 
-static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
+typedef int (*set_func_fn)(struct btf2btf_context *ctx, const char *name,
+			   u32 btf_id, u32 flags);
+
+/*
+ * Call FN for each function in the BTF ID sets which have SET_FLAG set. Reject
+ * an entry with flags other than ALLOWED_FLAGS, also if its function is missing.
+ */
+static int collect_set_funcs(struct object *obj, struct btf2btf_context *ctx,
+			     u32 set_flag, u32 allowed_flags, const char *kind,
+			     set_func_fn fn)
 {
 	Elf_Data *idlist = obj->efile.idlist;
 	struct btf *btf = ctx->btf;
@@ -1356,24 +1376,39 @@ static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
 	for (next = rb_first(&obj->sets); next; next = rb_next(next)) {
 		struct btf_id_set8 *set8;
 		struct btf_id *set_id;
-		u64 set_addr;
+		u64 set_addr, off;
 
 		set_id = rb_entry(next, struct btf_id, rb_node);
 		if (set_id->kind != BTF_ID_KIND_SET8 || set_id->addr_cnt != 1)
 			continue;
 
 		set_addr = set_id->addr[0];
-		set8 = idlist->d_buf + (set_addr - obj->efile.idlist_addr);
-		if (!(set8->flags & BTF_SET8_KFUNCS))
+		off = set_addr - obj->efile.idlist_addr;
+		/* A malformed set must not reach out of the section */
+		if (set_addr < obj->efile.idlist_addr || off > idlist->d_size ||
+		    idlist->d_size - off < sizeof(*set8) || set_id->cnt < 0 ||
+		    (u64)set_id->cnt > (idlist->d_size - off - sizeof(*set8)) /
+				       sizeof(set8->pairs[0])) {
+			pr_err("ERROR: resolve_btfids: set %s is out of %s\n",
+			       set_id->name, BTF_IDS_SECTION);
+			return -EINVAL;
+		}
+		set8 = idlist->d_buf + off;
+		if (!(set8->flags & set_flag))
 			continue;
 
 		for (u32 i = 0; i < set_id->cnt; i++) {
 			size_t off = (char *)&set8->pairs[i] - (char *)set8;
 			const char *name = find_name_by_addr(obj, set_addr + off);
-			struct kfunc kfunc;
+			u32 flags = set8->pairs[i].flags;
 			s32 func_id;
 			int err;
 
+			if (flags & ~allowed_flags) {
+				pr_err("ERROR: resolve_btfids: %s %s in %s has unsupported flags 0x%x\n",
+				       kind, name ?: "?", set_id->name, flags & ~allowed_flags);
+				return -EINVAL;
+			}
 			if (!name) {
 				pr_err("WARN: resolve_btfids: no BTF ID symbol for %s entry %u\n",
 				       set_id->name, i);
@@ -1383,18 +1418,15 @@ static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
 
 			func_id = btf__find_by_name_kind_own(btf, name, BTF_KIND_FUNC);
 			if (func_id < 0) {
-				pr_err("WARN: resolve_btfids: no BTF func for kfunc %s in %s\n",
-				       name, set_id->name);
+				pr_err("WARN: resolve_btfids: no BTF func for %s %s in %s\n",
+				       kind, name, set_id->name);
 				warnings++;
 				continue;
 			}
 
-			pr_debug("found kfunc %s in %s\n", name, set_id->name);
+			pr_debug("found %s %s in %s\n", kind, name, set_id->name);
 
-			kfunc.name = name;
-			kfunc.btf_id = func_id;
-			kfunc.flags = set8->pairs[i].flags;
-			err = push_kfunc(ctx, &kfunc);
+			err = fn(ctx, name, func_id, flags);
 			if (err)
 				return err;
 		}
@@ -1403,6 +1435,33 @@ static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
 	return 0;
 }
 
+static int push_kfunc(struct btf2btf_context *ctx, const char *name,
+		      u32 btf_id, u32 flags)
+{
+	struct kfunc kfunc = { .name = name, .btf_id = btf_id, .flags = flags };
+
+	return push_set_func(&ctx->kfuncs, "kfunc", &kfunc);
+}
+
+static int push_fmodret(struct btf2btf_context *ctx, const char *name,
+			u32 btf_id, u32 flags)
+{
+	struct kfunc fmodret = { .name = name, .btf_id = btf_id, .flags = flags };
+
+	return push_set_func(&ctx->fmodrets, "fmod_ret target", &fmodret);
+}
+
+static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
+{
+	return collect_set_funcs(obj, ctx, BTF_SET8_KFUNCS, ~0U, "kfunc", push_kfunc);
+}
+
+static int collect_fmodrets(struct object *obj, struct btf2btf_context *ctx)
+{
+	return collect_set_funcs(obj, ctx, BTF_SET8_FMODRET, KF_SLEEPABLE,
+				 "fmod_ret target", push_fmodret);
+}
+
 static int build_btf2btf_context(struct object *obj, struct btf2btf_context *ctx)
 {
 	int err;
@@ -1421,6 +1480,12 @@ static int build_btf2btf_context(struct object *obj, struct btf2btf_context *ctx
 		return err;
 	}
 
+	err = collect_fmodrets(obj, ctx);
+	if (err) {
+		pr_err("ERROR: resolve_btfids: failed to collect fmod_ret targets from BTF\n");
+		return err;
+	}
+
 	return 0;
 }
 
@@ -1761,10 +1826,26 @@ static int btf2btf(struct object *obj)
 			goto out;
 	}
 
+	for (next = rb_first(&ctx.fmodrets); next; next = rb_next(next)) {
+		struct kfunc *fmodret = rb_entry(next, struct kfunc, rb_node);
+
+		err = add_decl_tag(&ctx, DECL_TAG_FMODRET, fmodret->btf_id, -1);
+		if (err)
+			goto out;
+
+		if (fmodret->flags & KF_SLEEPABLE) {
+			err = add_decl_tag(&ctx, DECL_TAG_FMODRET_SLEEPABLE,
+					   fmodret->btf_id, -1);
+			if (err)
+				goto out;
+		}
+	}
+
 	err = 0;
 out:
 	free(ctx.decl_tags);
 	free_kfuncs(&ctx.kfuncs);
+	free_kfuncs(&ctx.fmodrets);
 
 	return err;
 }
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 4fe5c5f1558c..b371ef7241b9 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -13,6 +13,12 @@ struct btf_id_set {
 /* This flag implies BTF_SET8 holds kfunc(s) */
 #define BTF_SET8_KFUNCS		(1 << 0)
 
+/*
+ * This flag implies BTF_SET8 holds functions which BPF fmod_ret, fentry and
+ * fexit programs may attach to. Per-function flags: KF_SLEEPABLE only.
+ */
+#define BTF_SET8_FMODRET	(1 << 1)
+
 struct btf_id_set8 {
 	u32 cnt;
 	u32 flags;
@@ -214,6 +220,12 @@ __BTF_SET8_START(name, local, BTF_SET8_KFUNCS)
 #define BTF_KFUNCS_END(name)				\
 BTF_SET8_END(name)
 
+#define BTF_FMODRET_START(name)				\
+__BTF_SET8_START(name, local, BTF_SET8_FMODRET)
+
+#define BTF_FMODRET_END(name)				\
+BTF_SET8_END(name)
+
 #else
 
 #define BTF_ID_LIST(name) static u32 __maybe_unused name[128];
@@ -230,6 +242,8 @@ BTF_SET8_END(name)
 #define BTF_SET8_END(name)
 #define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
 #define BTF_KFUNCS_END(name)
+#define BTF_FMODRET_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_FMODRET };
+#define BTF_FMODRET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
 
-- 
2.43.0

