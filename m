Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB419D092;
	Thu, 30 Apr 2026 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528130; cv=none; b=cxb+SW015tFzPKRUx90bPAtvEDyIHGEZUphjT2dOA6f0H7hp8kVHUHPkQojrQk09tTEc9WrGl7EZ2z0vjsV3GvFEaGvqb0owTQwUvrEXaazXEFvF4sHjW8ODjWDYmw+6pyGZO7feA9sPsZRQCTSPhaxbXbO6DLshXdguoNNO9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528130; c=relaxed/simple;
	bh=VEVeRnr6OLUlat5XpaoH5+gakKZyyaACOfNTuaD1cRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTUZ8RHcQ1WOhUY/X183/nARGdQoIibsMmwztCyKTLB2lt8QWgxr7zbW7hpmnv8UOEZMoqhjWS8RR+6TU2Sa8Nc/HGKUywFyKJrs0I6rwhlpntBfZShKsKQdgfZeJvuwBGW04PxTpfWvyK4+0fin6hHiQFYGR2c5pSyl6R0ZmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=UY13qZ/L; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="UY13qZ/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rz
	jqN/aA6EV6+Xb+ZRvgUonnTkHTfHjAf8xD8ppttkc=; b=UY13qZ/Lj4/mEhFNfU
	yhtg4du6IKhqyaQ3B0N9v/ssoxZuqLRxfJaQJfLRVef8sh6s6bIQdXS+Kg7SIknY
	cAOb0ioJztgXoJCwvSigD4U1EVQyjH9zEllJ9xftgJPAvqDrvsTrZEjT8lOTkN/n
	Znn8aRGLXjAMDc28Cd7Dmo2mE=
Received: from song-MS-7D48.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgD31y7c7PJpwDQpDw--.55843S2;
	Thu, 30 Apr 2026 13:47:10 +0800 (CST)
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
Subject: [PATCH 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs over vmlinux kfuncs
Date: Thu, 30 Apr 2026 13:47:07 +0800
Message-ID: <20260430054707.38965-1-chensong_2000@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgD31y7c7PJpwDQpDw--.55843S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF45Zr4DCw47Ar43Ar47urg_yoW8ur4kpF
	Z5Jr13ZF4xJrySvFWkZrW5u343C3WxKw42vFW3JF1rZr1rtF4kJF1Fy3WYyF90v34qva40
	9r4YqFy7C3yUZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIg4hUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsh6JCWny7N6arwAA3w

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
 tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..9c308930bddb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8538,29 +8538,31 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 {
 	struct module_btf *mod_btf;
 	struct btf *btf;
-	int i, id, err;
+	int i, id = 0, err;
 
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
-			btf = mod_btf->btf;
-			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
-			if (id != -ENOENT)
-				break;
-		}
+	for (i = 0; i < obj->btf_module_cnt; i++) {
+		/* we assume module_btf's BTF FD is always >0 */
+		mod_btf = &obj->btf_modules[i];
+		btf = mod_btf->btf;
+		id = btf__find_by_name_kind_own(btf, ksym_name, kind);
+		if (id != -ENOENT)
+			goto found;
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

