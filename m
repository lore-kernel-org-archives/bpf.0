Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D66036AB55
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873702; cv=none; b=X65M55lckKj3EMRoLr+Z+FFUURUkCoRvOkwmh2TJTqmLtLShHg3XLKh10+HhgtnXAiDi6Cas/2Ang5RrALEjozopOlDxEGCQuumR8calFCAfxXjN34qGj1MaTscbpk1lmZDCNuuSrfebynIG98PK7FXIziQy5+AZi+QiRhx7V4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873702; c=relaxed/simple;
	bh=dM4QGEXT/D9pDurHifV8OTpDMd4fGbpvmLcO5PvDpxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYHQdnnPb2znlsimfZIsphihk7+1x9egVXLxgkdw/u1Z39yZQoPW86KH3YkjTgMyXlOJnDgzSOYOpXsd0lqpP65qZSBuGR/OsnN1CzpbXKow0dYxaU/jNiKlg8YSYmX8h2Yg0/fh3O+ETfXP34Sne7PJPDuCr7403Fa9lDhb1+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjtIa6RT; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjtIa6RT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zvv5GEAcoBWd42ld/hJY9KlCqYIxZFl5fK7TBTDqRg=;
	b=EjtIa6RT9zyUgSoICeJvM+aPXXs1azUNpls4Kv33GF0TgYDmiTsC6n4wfLzjiKss+axq+G
	/vf8dJScN3/Yck4WtVsWS/ps5yp1ABSw3dlMZalW2AHg1Wl5sZ7+XSui4bF0jC+CRj5UO3
	hCj9mWGzN5H+tSM4YU7ZgcOlgcifAoM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v4 07/20] resolve_btfids: Fix memory leaks reported by ASAN
Date: Mon, 23 Feb 2026 11:07:23 -0800
Message-ID: <20260223190736.649171-8-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
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

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 81 ++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index ca7fcd03efb6..5208f650080f 100644
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
@@ -258,17 +262,21 @@ static struct btf_id *__btf_id__add(struct rb_root *root,
 	return id;
 }
 
-static inline struct btf_id *btf_id__add(struct rb_root *root, char *name, enum btf_id_kind kind)
+static inline struct btf_id *btf_id__add(struct rb_root *root,
+					 const char *name,
+					 enum btf_id_kind kind)
 {
 	return __btf_id__add(root, name, kind, false);
 }
 
-static inline struct btf_id *btf_id__add_unique(struct rb_root *root, char *name, enum btf_id_kind kind)
+static inline struct btf_id *btf_id__add_unique(struct rb_root *root,
+						const char *name,
+						enum btf_id_kind kind)
 {
 	return __btf_id__add(root, name, kind, true);
 }
 
-static char *get_id(const char *prefix_end)
+static int get_id(const char *prefix_end, char *buf, size_t buf_sz)
 {
 	/*
 	 * __BTF_ID__func__vfs_truncate__0
@@ -277,28 +285,28 @@ static char *get_id(const char *prefix_end)
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
@@ -335,10 +343,9 @@ static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind k
 
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
@@ -346,6 +353,21 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 	return btf_id__add(root, id, BTF_ID_KIND_SYM);
 }
 
+static void btf_id__free_all(struct rb_root *root)
+{
+	struct rb_node *next;
+	struct btf_id *id;
+
+	next = rb_first(root);
+	while (next) {
+		id = rb_entry(next, struct btf_id, rb_node);
+		next = rb_next(&id->rb_node);
+		rb_erase(&id->rb_node, root);
+		free(id->name);
+		free(id);
+	}
+}
+
 static void bswap_32_data(void *data, u32 nr_bytes)
 {
 	u32 cnt, i;
@@ -1547,6 +1569,11 @@ int main(int argc, const char **argv)
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

