Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB75370D70;
	Tue,  2 Jun 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398518; cv=none; b=Ji+UwR5k6MDUeiROok6+twU6PNWyECfMM4RvGzUmIqcPlf9NStdMRgvb5xH7sgldroXoRqC7gt0rproT1vKz3SwjjqQZfpcB0nMIrP66hwwgdN/MHsfskamFyNi8B4K5YdFwaXzn9QTejioElkTg2spXJyq3YOTNoAHKeGopAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398518; c=relaxed/simple;
	bh=oMCDSGIiA7rAhyfl58Dy3YCjcKQMxzLCezYPyj7Rpi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lIzMc/DWBSmT4ZRLAvgwWh6W4vTczRLD6QN6zjbGfZ2qk3a03IzjaKZ8YbnbFSgDrB8Rw6OJy8wAAZjRk3tSdeOuVH5LqbqLAbrQ9f9YDVRMCWII57iWatErY09F2W9dfGskQ40gLmRkkFpBi/6tcghc2UKu9NH77iIz6izfSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=eHp9HakL; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="eHp9HakL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qL
	3Uc1p+r+rPSOXpA8y7qKJQv+j8ib4lLSCjdmxRl3s=; b=eHp9HakLD3ZjNuN2o0
	d7YeCD3Dyepz5HCySp7BX5DoyQDS//LXdh1bkYkNLyMgOAk7i3jVrqXAY+v6VrFF
	R3LGP6ccdnrUuYdaTfwP2pyiRnuWJQA57NEYwt+xsNORhOpNAuXtCGROFniGs3e9
	Nj9jHFteaqD1F8HIW3JERGp80=
Received: from song-MS-7D48.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v1xguR5qJ9shAw--.49221S2;
	Tue, 02 Jun 2026 19:07:13 +0800 (CST)
From: Song Chen <chensong_2000@126.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	kaitao.cheng@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@126.com>
Subject: [PATCH v4] btf: reject to register duplicated kfunc
Date: Tue,  2 Jun 2026 19:07:10 +0800
Message-ID: <20260602110710.19642-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v1xguR5qJ9shAw--.49221S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyxJw1xGFy7Gr1UXrykGrg_yoW5Kr1UpF
	45Jr95uF4xKw13Xa1xtFyDury3Gw18Ga12yF9xGF43Xr4qgrWDJF1j9F1Yv3sIyry8Cay7
	tF4ruFWUu3yjg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UivtZUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpQGoKGoeuWEANwAA3-

I had an ebpf program which calls a kfunc defined and
implemented in one of my kernel modules, it was working
fine in 6.16, but was rejected to run by libbpf in 6.19,
the error message was:

libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
incompatible with vmlinux [94389]

The reason is there is a new added kfunc in kernel 6.19
which happens to be the same name with my kfunc. However the
error message is not obvious enough to address problem
immediately.

Therefore, this patches searches duplicated kfunc in
both btf_vmlinux and btf_modules list before a kernel module
attempts to register kfuncs through register_btf_kfunc_id_set,
it prints clear error message and returns error code if same name
kfunc has already implemented and registered, then developer
knows at the first place.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Suggested-by: Kaitao Cheng <kaitao.cheng@linux.dev>
Reviewed-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Song Chen <chensong_2000@126.com>

---
changelog:
v1 --- v2:
libbpf has already specified which module this kfunc belongs to as
ebpf code onwer's expectation, then verifier uses
find_kallsyms_symbol_value to search kfunc's addr.

v2 --- v3:
After v2, I tried a new idea of introducing a namespace in libbpf
to specify kfunc owner in an ebpf program suggested by Kaitao Cheng,
please see [1]. Alex suggested to go back to report an error during
kmod load on conflicting kfunc name for now. What's more, v2 only
searched bpf_vmlinux, v3 also traverses btf_modules list.

v3 --- v4
Fixed some coding style problems suggested from Kaitao Cheng.
---
 kernel/bpf/btf.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..fe1612677a4a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8618,6 +8618,41 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	return 0;
 }
 
+static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
+{
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	struct btf_module *btf_mod, *tmp;
+#endif
+	s32 id;
+
+	if (!btf_is_module(btf))
+		return 0;
+
+	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);
+	if (id >= 0) {
+		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
+				func_name, id);
+		return -EINVAL;
+	}
+
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	mutex_lock(&btf_module_mutex);
+	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+		if (btf_mod->btf == btf)
+			continue;
+		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
+		if (id >= 0) {
+			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
+					func_name, id, btf_mod->module->name);
+			mutex_unlock(&btf_module_mutex);
+			return -EINVAL;
+		}
+	}
+	mutex_unlock(&btf_module_mutex);
+#endif
+	return 0;
+}
+
 static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 {
 	const struct btf_type *func;
@@ -8631,7 +8666,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 
 	/* sanity check kfunc name */
 	func_name = btf_name_by_offset(btf, func->name_off);
-	if (!func_name || !func_name[0])
+	if (!func_name || !func_name[0] ||
+		btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
 		return -EINVAL;
 
 	func = btf_type_by_id(btf, func->type);
-- 
2.43.0

