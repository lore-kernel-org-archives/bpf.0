Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B91F3B87
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858865; cv=none; b=PId6eza1L4nIC4H7zIvtNE1FJFQbVzvR73pxTEyVTSPMyCFhqGMjVs3S1lc2Ox2+0YTJk9Z1MrWESbNZ1JMqc2kLQgBOmZZWKrWU4KT2J/qCC8WSRNjXSrD3cYZgTdZurrc/tvvPnpx4dXhaeqmJSFCel5v4BcVDOGfgEIGvRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858865; c=relaxed/simple;
	bh=rLfYrmOokTxg+vkTwHAnlTtrEWEMsAqg2HN4aUDU1eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+GcGwpYKWWT0YJsTnrt6hEQXhSWGIyv3R20mHP5bQfT4gWRgyyfBHVAlC+I8AmVZaq40QN0/PE34BNJku2uYYWZeBnSYjMCbfYUPaKojLf7O1ut4bgqUZSwo91vsPHRQzv+H3BAD369ji8BCBXIf6tym+VCqhDLhb0E/s7SyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gFFWDnsU; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gFFWDnsU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozo9SbbgBm5h3TJRJS40oegHI+0Q8oLhbtdly51Ny2o=;
	b=gFFWDnsUGMLnhPoAg8m3REoZOkiHVWchZtLomoiu9dsq3dKORjdYNyc2txYKP6BSokfyBI
	VtnID1eFlIIRVopPbHVenXkIjLq9VkMb+cgeOMvdz0Gu53LENOW/ZpMVp+gav7FdwQiQoi
	v894/d8yMc6XF7K0QaQJa8pFgzVW+oU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/14] resolve_btfids: Fix memory leaks reported by ASAN
Date: Wed, 11 Feb 2026 17:13:44 -0800
Message-ID: <20260212011356.3266753-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Running resolve_btfids with ASAN reveals memory leaks in btf_id
handling.

- Change get_id() to use a local buffer
- Make btf_id__add() strdup the name internally
- Add btf_id__free_all() that frees all nodese of a tree
- Call the cleanup function on exit for every tree

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 78 +++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index ca7fcd03efb6..863fa0faaa31 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -226,7 +226,7 @@ static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
 }
 
 static struct btf_id *__btf_id__add(struct rb_root *root,
-				    char *name,
+				    const char *name,
 				    enum btf_id_kind kind,
 				    bool unique)
 {
@@ -250,7 +250,11 @@ static struct btf_id *__btf_id__add(struct rb_root *root,
 	id = zalloc(sizeof(*id));
 	if (id) {
 		pr_debug("adding symbol %s\n", name);
-		id->name = name;
+		id->name = strdup(name);
+		if (!id->name) {
+			free(id);
+			return NULL;
+		}
 		id->kind = kind;
 		rb_link_node(&id->rb_node, parent, p);
 		rb_insert_color(&id->rb_node, root);
@@ -258,17 +262,17 @@ static struct btf_id *__btf_id__add(struct rb_root *root,
 	return id;
 }
 
-static inline struct btf_id *btf_id__add(struct rb_root *root, char *name, enum btf_id_kind kind)
+static inline struct btf_id *btf_id__add(struct rb_root *root, const char *name, enum btf_id_kind kind)
 {
 	return __btf_id__add(root, name, kind, false);
 }
 
-static inline struct btf_id *btf_id__add_unique(struct rb_root *root, char *name, enum btf_id_kind kind)
+static inline struct btf_id *btf_id__add_unique(struct rb_root *root, const char *name, enum btf_id_kind kind)
 {
 	return __btf_id__add(root, name, kind, true);
 }
 
-static char *get_id(const char *prefix_end)
+static int get_id(const char *prefix_end, char *buf, size_t buf_sz)
 {
 	/*
 	 * __BTF_ID__func__vfs_truncate__0
@@ -277,28 +281,28 @@ static char *get_id(const char *prefix_end)
 	 */
 	int len = strlen(prefix_end);
 	int pos = sizeof("__") - 1;
-	char *p, *id;
+	char *p;
 
 	if (pos >= len)
-		return NULL;
+		return -1;
 
-	id = strdup(prefix_end + pos);
-	if (id) {
-		/*
-		 * __BTF_ID__func__vfs_truncate__0
-		 * id =            ^
-		 *
-		 * cut the unique id part
-		 */
-		p = strrchr(id, '_');
-		p--;
-		if (*p != '_') {
-			free(id);
-			return NULL;
-		}
-		*p = '\0';
-	}
-	return id;
+	if (len - pos >= buf_sz)
+		return -1;
+
+	strcpy(buf, prefix_end + pos);
+	/*
+	 * __BTF_ID__func__vfs_truncate__0
+	 * buf =           ^
+	 *
+	 * cut the unique id part
+	 */
+	p = strrchr(buf, '_');
+	p--;
+	if (*p != '_')
+		return -1;
+	*p = '\0';
+
+	return 0;
 }
 
 static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
@@ -335,10 +339,9 @@ static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind k
 
 static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 {
-	char *id;
+	char id[KSYM_NAME_LEN];
 
-	id = get_id(name + size);
-	if (!id) {
+	if (get_id(name + size, id, sizeof(id))) {
 		pr_err("FAILED to parse symbol name: %s\n", name);
 		return NULL;
 	}
@@ -346,6 +349,22 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 	return btf_id__add(root, id, BTF_ID_KIND_SYM);
 }
 
+static void btf_id__free_all(struct rb_root *root)
+{
+	struct rb_node *node, *next;
+	struct btf_id *id;
+
+	node = rb_first(root);
+	while (node) {
+		next = rb_next(node);
+		id = rb_entry(node, struct btf_id, rb_node);
+		rb_erase(node, root);
+		free(id->name);
+		free(id);
+		node = next;
+	}
+}
+
 static void bswap_32_data(void *data, u32 nr_bytes)
 {
 	u32 cnt, i;
@@ -1547,6 +1566,11 @@ int main(int argc, const char **argv)
 out:
 	btf__free(obj.base_btf);
 	btf__free(obj.btf);
+	btf_id__free_all(&obj.structs);
+	btf_id__free_all(&obj.unions);
+	btf_id__free_all(&obj.typedefs);
+	btf_id__free_all(&obj.funcs);
+	btf_id__free_all(&obj.sets);
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
 		close(obj.efile.fd);
-- 
2.53.0

