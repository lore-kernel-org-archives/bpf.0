Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A802D780A;
	Sun, 24 May 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779611503; cv=none; b=q0IxWvT5fETW+0gCL4KKmD5AyoP70cY5hW9mo7hLGCWyXLv6tfcJPVvWzuOy9/F+4JFzTsduBh+9fqHpTq9GX5JdTKMk+TZWvgqUS7w4RD4O0UYROLL/sBCMW7l+KU89mGX1ORw95tDf/TQt43CuXSkMtigNJ/YG7AvFOZULTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779611503; c=relaxed/simple;
	bh=Jn9hvttYy7Eb/PRoryi5viSi+2qB8PFM1XicxVgxh8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHGlhye0kXIPDRjBZCUmJyw0ikxba82BGp07XuzmB8XLWkcIv2E/1tnktKvuXeuYrHY5osAG2RFJGJ9/ZUwbWuylwJ42QhHGfjXFicXdU016OzsJhBTaTsQsrOaNgzyZfvuAXb53Vn05bQmiDzDKrm7nl6E+g6D5oGKi8fiEQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=I557M+xZ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="I557M+xZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yX
	YtoyphmUN/yS02oWg0Dgdc0OXybpFfYON0sU9r34w=; b=I557M+xZNoeFuuEsgo
	FENGdF/NIJjuF4/EaH8V5tCFzDxPlcL5kvLippbEjLzRwMf/2FgbKsrjUd6GYUSG
	cnSwWEo367Cb1UMU0OolUFc8ISZ3lxZ5UZbtURb9olGoC6NNuCIM7F4WROrOsdel
	jGWz95djiFcwcnc3C2cPg0Qoc=
Received: from song-MS-7E28.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnN436thJqB6nGAA--.13903S2;
	Sun, 24 May 2026 16:29:47 +0800 (CST)
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
Subject: [PATCH v3] kernel/bpf/btf.c: reject to register duplicated kfunc
Date: Sun, 24 May 2026 16:29:44 +0800
Message-ID: <20260524082944.10625-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN436thJqB6nGAA--.13903S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyxJw1xGFy7Gr1UXrykGrg_yoW5tw4xpF
	45Jr98uF4xtw13Xayxtr1Dury3Gw18Ga12yF9xKFW3Ar4jgrWDJr109F1Yv3sIyry8Ca4U
	tF4rWFWDu3yjq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uev3bUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRsLimoStvuF6wAA3k

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

[1]:https://lore.kernel.org/all/CAADnVQ+jYGMjAC9aNygmhyppUO9foWN4z9cjSpwCEXAFHpRVJQ@mail.gmail.com/
---
 kernel/bpf/btf.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..a14ad3720872 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8618,6 +8618,47 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	return 0;
 }
 
+static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
+{
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	struct btf_module *btf_mod, *tmp;
+#endif
+	s32 id;
+	int ret = 0;
+
+	if (!btf_is_module(btf))
+		goto out;
+
+	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
+					func_name, kind);
+	if (id >= 0) {
+		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
+					func_name, id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	mutex_lock(&btf_module_mutex);
+	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+		if (btf_mod->btf == btf)
+			continue;
+		id = btf_find_by_name_kind(btf_mod->btf,
+					func_name, kind);
+		if (id >= 0) {
+			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
+					func_name, id, btf_mod->module->name);
+			ret = -EINVAL;
+			break;
+		}
+	}
+	mutex_unlock(&btf_module_mutex);
+#endif
+
+out:
+	return ret;
+}
+
 static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 {
 	const struct btf_type *func;
@@ -8631,7 +8672,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 
 	/* sanity check kfunc name */
 	func_name = btf_name_by_offset(btf, func->name_off);
-	if (!func_name || !func_name[0])
+	if (!func_name || !func_name[0]
+			|| btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
 		return -EINVAL;
 
 	func = btf_type_by_id(btf, func->type);
-- 
2.43.0

