Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826DE3812C7;
	Tue,  1 Sep 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244225; cv=none; b=MB0KnCbeAfzXHHkoa9ST5kNIBaLUWFGBN4xxX8d+VpKGcJc9imtv3Es915j5JCj1d1sTI6Ma0nLEatME1KojnOp0xc+io0R/sG9C+9gh3aZ5jr8egzmISd1TFIaoIktnAxdwIg+iGOfdijf0w0ESHRNh12IC1PzgU9NwPdLd8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244225; c=relaxed/simple;
	bh=+iYCkLJBD1CTXM4wo0FayQCQ8EHm1fbEwSf2jgfMvqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHGqLqB+UXWev5hQyAq2uNqWywzqJ1CfYIrsjm0gsHe9rjGt9zVKuJF9CRy+/KykZ+Isls4Q+2VcMrQN5RuTUXAXjqXcI/lu+Hrohhxo4BL83Qwkg1gtEUj0+9OPXfJF400mTCm6RwTPHv2qfB4iy+Y4B6Oi8fCBRFcGtuyasyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DfYyUX8X; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DfYyUX8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=XR
	UR5zZRZ7TV9XYlyi/hU2YGzIrVLJbcihPkGSjgxmk=; b=DfYyUX8XqcSZc4CgdX
	7pkQMtc1S6Y0CS+wnoOG9tAqV9Kz5lvisF2jngC1Oog1dlmjbSweRw58y9bA7T7t
	TsLY505lqnTTvXomHcrvN3mE2W2aR1lEBpTk/wKg1kbLzCyGEUba181vpiacQ7Fd
	pMqm1V08FGNNhO/lb4lDbB2rY=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n5+mcJZqA6mBNA--.25535S4;
	Tue, 01 Sep 2026 14:29:01 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 2/4] bpf: Fix use-after-free of program BTF in mem-alloc destructor
Date: Tue,  1 Sep 2026 14:28:43 +0800
Message-ID: <20260901062845.1379760-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901062845.1379760-1-chenyuan_fl@163.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3n5+mcJZqA6mBNA--.25535S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1UGw15Jw4rXF17Zr15twb_yoW5KF1rpF
	4xCFW3Kr4ktFn2kFZ3Xw4DAFy5Za97ZF15uFy3Ww1Y93yFqr1DAa1IgFWrZFy5CrWkKwnY
	9r1jga9xGrWjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbnYwUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5Q2HRWqWcK2xmAAA3i

From: Yuan Chen <chenyuan@kylinos.cn>

bpf_ma_set_dtor() duplicates the map's btf_record for the bpf_mem_alloc
destructor. btf_record_dup() only borrows the BTF references held by
the fields: kptrs and list_head/rb_root fields point at the program
BTF, whose lifetime is independent of the map. The duplicated record is
used from the deferred mem-alloc destructor workqueue, which can run
after the program BTF is gone (bpf_map_free() drops the map's
reference, and the RCU callback may run first). Reading the borrowed
descriptors there is a use-after-free, detected by KASAN as
"slab-use-after-free in btf_is_kernel".

Keep a reference on the borrowed program BTFs for the lifetime of the
duplicated record. The record is freed from a preemptible worker, so
the last btf_put() (which only schedules RCU destruction) does not make
the field descriptors safe to read; snapshot the borrowed BTFs, free
the record, then drop the references.

The rhtab kptr selftests exercise this path on every map teardown and
triggered the bug under KASAN; with this fix they pass cleanly.

Fixes: 1df97a7453ee ("bpf: Register dtor for freeing special fields")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/hashtab.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index aaedda3730f3..30bcc573772e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -493,11 +493,76 @@ static void htab_pcpu_mem_dtor(void *obj, void *ctx)
 		bpf_obj_free_fields(hrec->record, per_cpu_ptr(pptr, cpu));
 }
 
+/*
+ * The duplicated record borrows program BTFs, but is freed from a deferred
+ * workqueue that may run after the program BTF is gone. Hold a reference for
+ * the record's lifetime and snapshot the borrowed BTFs, since
+ * btf_record_free() frees the record.
+ */
+
+/* Program BTF borrowed by the field, or NULL. */
+static struct btf *htab_field_borrowed_btf(const struct btf_field *field)
+{
+	struct btf *btf = NULL;
+
+	switch (field->type) {
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
+		btf = field->kptr.btf;
+		break;
+	case BPF_LIST_HEAD:
+	case BPF_RB_ROOT:
+		btf = field->graph_root.btf;
+		break;
+	default:
+		break;
+	}
+
+	if (btf && !btf_is_kernel(btf))
+		return btf;
+	return NULL;
+}
+
+/* Snapshot the program BTFs @rec borrows into @btfs; returns their count. */
+static int htab_record_prog_btfs_snapshot(struct btf_record *rec,
+					  struct btf **btfs)
+{
+	int i, n = 0;
+
+	if (IS_ERR_OR_NULL(rec))
+		return 0;
+
+	for (i = 0; i < rec->cnt; i++) {
+		struct btf *btf = htab_field_borrowed_btf(&rec->fields[i]);
+
+		if (btf)
+			btfs[n++] = btf;
+	}
+	return n;
+}
+
+static void htab_record_prog_btf_get(struct btf_record *rec)
+{
+	struct btf *btfs[BTF_FIELDS_MAX];
+	int i, n;
+
+	n = htab_record_prog_btfs_snapshot(rec, btfs);
+	for (i = 0; i < n; i++)
+		btf_get(btfs[i]);
+}
+
 static void htab_dtor_ctx_free(void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
+	struct btf *btfs[BTF_FIELDS_MAX];
+	int i, n;
 
+	n = htab_record_prog_btfs_snapshot(hrec->record, btfs);
 	btf_record_free(hrec->record);
+	for (i = 0; i < n; i++)
+		btf_put(btfs[i]);
 	kfree(ctx);
 }
 
@@ -521,6 +586,7 @@ static int bpf_ma_set_dtor(struct bpf_map *map, struct bpf_mem_alloc *ma,
 		kfree(hrec);
 		return err;
 	}
+	htab_record_prog_btf_get(hrec->record);
 	bpf_mem_alloc_set_dtor(ma, dtor, htab_dtor_ctx_free, hrec);
 	return 0;
 }
-- 
2.54.0

