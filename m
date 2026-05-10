Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62223F417;
	Sun, 10 May 2026 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382312; cv=none; b=cQM1SG04EPa2LXIW1ojz+MzbtZOdYRSSrrJZScCBS9JQ/aGiYm9Tb6+zQR6T6ODrMjvqLtutOvoW4G7CS/hA5noA2aMdZPDdl+biLpkhZfoZ+PCG1GwvMcEyuvG5BmMR0h0BHMJQ7N0FVFCd9lr3fRxeWlnxRDQhjcUUdovhNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382312; c=relaxed/simple;
	bh=AhCwVsvREkfvZcVO3oGK0aE7K6/a+9mlXh00xo8EoDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AO004i6luEkq3F8ni6Xn8EuFuiFdEHtVTawYU537wbaWbFDfbAFp1RvNdl5IdNuG7KwgwoTNOEWRaYwhztzZIqHcHe3i661S4INvt1eJf+JgBXqXKJlmJ2+H2XWOoC1uvalzXM3ZyhF5Br1o9nXMnj6gNWOJZlA9pj5bsVtSKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=me5As/T+; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="me5As/T+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gH
	zfpUhTHSEqK2GA2nR5+2DK090Wq2ZCF5rNBJ4ehKE=; b=me5As/T+MP2f4Y+fUq
	44aKA0rMllUqn0ToYOQ7ocMP0UNH6vHHEhBRYgjNC3Rx5qKu/EV3TB8tkx6oWBEh
	9qCxR0xtGsCAuXnjqUECXvFAA7lSa/8RdGFIPowKdxaJ0+vElq3NZlhrS8lizfIz
	ZlCNgvsoHuFX5zl4ycsCZ2VVM=
Received: from song-MS-7E28.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDn7wIR9f9pQvmxBA--.2369S2;
	Sun, 10 May 2026 11:01:38 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs over vmlinux kfuncs
Date: Sun, 10 May 2026 11:01:36 +0800
Message-ID: <20260510030136.27876-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7wIR9f9pQvmxBA--.2369S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4rZryfJr4fJF1xuFyUJrb_yoW5uF43pF
	s5Arn0yF4xJr9IyF48XrWUury5KryxGw4YvFW3tF13ur18XF4kAF18A3WYv3s8A34qqayI
	gF4YqF13CrWUXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEuyI7UUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRLbW2n-9RJOHwAA3X

Change the kfunc resolution order in find_ksym_btf_id() to search
module BTFs before vmlinux BTF. This allows kernel modules to override
vmlinux kfuncs with the same name, enabling a form of live-patching
for kfuncs.

Previously, vmlinux kfuncs were always preferred, making it impossible
for modules to provide enhanced or fixed versions of existing kfuncs.
With this change, modules can now override kernel kfuncs, while
programs that don't use module BTFs remain unaffected.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Song Chen <chensong_2000@126.com>

---
changelog:
v1 -->  v2:
1, introduce namespace to specify which module the kfunc belongs to, like:
modulea__foo
moduleb__foo
foo
As a result, kfunc foo can co-exist in modulea, moduleb and vmlinux, ebpf
code owner can specify which one he wants to call.
---
 tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..9c9e5ff4d754 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8532,35 +8532,65 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 	return libbpf_kallsyms_parse(kallsyms_cb, obj);
 }
 
+static void split_module_from_ksym(const char *ksym_name,
+			const char **module_name,
+			size_t *module_name_len,
+			const char **kfunc_name)
+{
+	const char *sep = strstr(ksym_name, "__");
+
+	if (!sep) {
+		*module_name = NULL;
+		*module_name_len = 0;
+		*kfunc_name = ksym_name;
+	} else {
+		*module_name = ksym_name;
+		*module_name_len = sep - ksym_name;
+		*kfunc_name = sep + strlen("__");
+	}
+}
+
 static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
-			    __u16 kind, struct btf **res_btf,
-			    struct module_btf **res_mod_btf)
+			__u16 kind, struct btf **res_btf,
+			struct module_btf **res_mod_btf)
 {
 	struct module_btf *mod_btf;
 	struct btf *btf;
-	int i, id, err;
+	int i, id = 0, err;
+	const char *module_name;
+	const char *kfunc_name;
+	size_t module_name_len;
+
+	split_module_from_ksym(ksym_name, &module_name, &module_name_len, &kfunc_name);
+	if (module_name_len == 0)
+		goto search_vmlinux;
 
-	btf = obj->btf_vmlinux;
 	mod_btf = NULL;
-	id = btf__find_by_name_kind(btf, ksym_name, kind);
 
-	if (id == -ENOENT) {
-		err = load_module_btfs(obj);
-		if (err)
-			return err;
+	err = load_module_btfs(obj);
+	if (err)
+		goto search_vmlinux;
 
-		for (i = 0; i < obj->btf_module_cnt; i++) {
-			/* we assume module_btf's BTF FD is always >0 */
-			mod_btf = &obj->btf_modules[i];
+	for (i = 0; i < obj->btf_module_cnt; i++) {
+		/* we assume module_btf's BTF FD is always >0 */
+		mod_btf = &obj->btf_modules[i];
+		if (strlen(mod_btf->name) == module_name_len &&
+			!strncmp(mod_btf->name, module_name, module_name_len)) {
 			btf = mod_btf->btf;
-			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
+			id = btf__find_by_name_kind_own(btf, kfunc_name, kind);
 			if (id != -ENOENT)
-				break;
+				goto found;
 		}
 	}
-	if (id <= 0)
+
+search_vmlinux:
+	btf = obj->btf_vmlinux;
+	mod_btf = NULL;
+	id = btf__find_by_name_kind(btf, ksym_name, kind);
+	if (id == -ENOENT)
 		return -ESRCH;
 
+found:
 	*res_btf = btf;
 	*res_mod_btf = mod_btf;
 	return id;
-- 
2.43.0

