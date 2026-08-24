Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D3438011;
	Mon, 24 Aug 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582300; cv=none; b=qq5oD5u7Qq/reYja6JcH6vqmIr7bd1dkIMGYa+g+Ox2Y0u4tWIuheoIn8fJQbRUUDErFzdegW/pFW3faWr13r0c6ouPD3Gm6PlG1kWW5DtNZnzAjO0jADyl/J4EAWu/kN7Ou6zTF2V9y7BBuBDkqUao945gsAC5+BOXE/fUhjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582300; c=relaxed/simple;
	bh=yiUiflDVanlKSVYyi+qbFEeVwBkElRInG2Qf/yLZgbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTJZ9mm1j1hRtY0yH0RzAQiXp3zeIZcJKR9dH75ZeFx8x+ayVcDNGuC1fPeLVl4PVmdkvWrCnFaefQZ0Y4lEKYzK3dAHxbCxns+g/y0GocvcV04qpaggg+12QNw4a2m8o+KJxrTlnZ5HK44x53EbMfq+qRrC8DO3skIIWbi6K4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Xxio33sw; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Xxio33sw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3E
	TUOZnkD0p5Jk119NJQbzsZZOFcufeLhAP1I1izjpY=; b=Xxio33swPz5Fhapz34
	0thUa1EdnAAF7nDO2Di02YvIL44LaR7+QsPK5+QU2BilxOsqgSuHkAn845i8GCsA
	nOiaVtAjKTgfihivrVehZzjBXgAa+RG/tsF0pzTqgVmWIrqKZeCVxomR8HWXd80M
	XPGMufncJIfx/9eDJn4O5DyzY=
Received: from nec8-i7 (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+osAV4xqIt5SMw--.54939S4;
	Mon, 24 Aug 2026 22:36:50 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH 2/4] bpf: Fix use-after-free of program BTF in mem-alloc destructor
Date: Mon, 24 Aug 2026 22:36:19 +0800
Message-ID: <20260824143621.2098856-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824143621.2098856-1-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn+osAV4xqIt5SMw--.54939S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4kZFWDGFy3Kr4rCw45Wrg_yoWrJFy5pF
	4xCr4akw4ktrs7CwsxWwsxCry5Wan7ZF1UuFyfWw1Ygw4rXr1DXr409FWa9FW5Cr4rtws5
	Ar1jgFZxGry5AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwZ2fUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQKTUWqMVwKt+AAA3n

From: Yuan Chen <chenyuan@kylinos.cn>

bpf_ma_set_dtor() duplicates the map's btf_record for the bpf_mem_alloc
destructor. For kptr fields backed by the program BTF (MEM_ALLOC kptrs,
e.g. objects allocated with bpf_obj_new()/bpf_percpu_obj_new()),
btf_record_dup() only borrows the reference, matching what
btf_parse_fields() did for the map's own record.

The duplicated record, however, is released later from the deferred
bpf_mem_alloc destructor workqueue (free_mem_alloc_deferred), by which
time the program BTF may already have been freed: bpf_map_free() drops
the map's own reference, and the RCU callback can run before the
workqueue. Reading field->kptr.btf in btf_record_free() (via
btf_is_kernel()) is then a use-after-free, detected by KASAN as
"slab-use-after-free in btf_is_kernel" when a map with a MEM_ALLOC kptr
field is destroyed.

Hold a reference on program BTF for the lifetime of the duplicated
record and drop it right before the record is freed. The last btf_put()
only schedules the object for RCU destruction, so btf_record_free() can
still safely read the field descriptors.

The rhtab kptr selftests exercise this path on every map teardown and
triggered the bug under KASAN; with this fix they pass cleanly.

Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/hashtab.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0df8db27cd8c..b8df2bc9a9a0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -493,10 +493,54 @@ static void htab_pcpu_mem_dtor(void *obj, void *ctx)
 		bpf_obj_free_fields(hrec->record, per_cpu_ptr(pptr, cpu));
 }
 
+/*
+ * bpf_ma_set_dtor() duplicates the map's btf_record. For kptr fields whose
+ * btf is the program BTF (MEM_ALLOC kptrs, e.g. objects allocated with
+ * bpf_obj_new()/bpf_percpu_obj_new()) btf_record_dup() only borrows the
+ * reference, like btf_parse_fields() did for the map's own record. The
+ * duplicated record is released later from the deferred bpf_mem_alloc
+ * destructor workqueue, by which time the program BTF may already have been
+ * freed (the map dropped its own reference in bpf_map_free()), so reading
+ * field->kptr.btf there would be a use-after-free.
+ *
+ * Hold a reference on non-kernel (program) BTF for the lifetime of the
+ * duplicated record and release it before the record is freed. After the
+ * last btf_put() the object is only destroyed after an RCU grace period, so
+ * btf_record_free() can still safely read the field descriptors.
+ */
+static void htab_record_prog_btf_ref(struct btf_record *rec, bool get)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	for (i = 0; i < rec->cnt; i++) {
+		const struct btf_field *field = &rec->fields[i];
+
+		switch (field->type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
+			if (field->kptr.btf && !btf_is_kernel(field->kptr.btf)) {
+				if (get)
+					btf_get(field->kptr.btf);
+				else
+					btf_put(field->kptr.btf);
+			}
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void htab_dtor_ctx_free(void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
 
+	htab_record_prog_btf_ref(hrec->record, false);
 	btf_record_free(hrec->record);
 	kfree(ctx);
 }
@@ -521,6 +565,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 		kfree(hrec);
 		return err;
 	}
+	htab_record_prog_btf_ref(hrec->record, true);
 	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
 	return 0;
 }
-- 
2.54.0

