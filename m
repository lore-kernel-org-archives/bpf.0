Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3723CE099
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314323; cv=none; b=ZMybzG4MCSM2IhhTRgDXhfxz+xvhSP0tKhZcEp5HiAFhdLApdG4kZrM/DdsRk8urilqpERdCIURek7idSppVvbrPEdBhNelQ8z13T3UaWd23jWiWe1eSZKg1yTirsj8AALfI8VQgGpIuBBaMCSMMQUWhSfS98buqhZBYfb8urys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314323; c=relaxed/simple;
	bh=lGb4MATMev5Gg7HA/8QM+xk+hIN9hkWAdbwKpbRrc7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvcW9gdh9S6yA3z41+uDcz8SA7PD+rpJQ5SHvf7qloUbkCEmWr5h9iCiHlfEm9b98NqvsIlyHNs+IDRmqDlWWcoaxFKW2XpcgTW/Yck6Xsy2hyYAunNNrKqDOywXDHAfZwtWMWMxaRxRlOiX3Npp33ZvHbP3EJhCSVk2Dgx8lk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx75FNr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx75FNr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCF81F000E9;
	Wed, 29 Jul 2026 08:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314322;
	bh=6DUUXE6c73G8hVd7u4lBWAfeYrnICoRg3OLbDT5yRUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kx75FNr1Ut2HDcg+0a9eqkWoyq1CNfjoFRj9v4SquaK3n6FGQH5XJx+d4kkqKTLcZ
	 eW0dYX3RJS0WXpLdzpds7oiIb+S2On6Nl39RkN7YlQUNniKmsvnew7RGLINdYCfswO
	 r40VrGlcViDHzGds/t41m6QFW8+u+/NF9a6+KJrfh24YDeQZ+atOgSrQkchYZ65qNG
	 DO45cXf1/Dm+AC3QCXha5r4YC7zjXB7xNI8r8lo/dZI1IJL2yHUktOhVKjZb5mgrQr
	 aquZrevQ/nQHFZW5CWWf+LNmwk+xGlR/qjW1Px1ydKG2NEqI2b4AKfAXG0KfCbHt4c
	 NAoZypvUgVsEQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 03/11] bpf: Factor stackid_new_bucket from __bpf_get_stackid
Date: Wed, 29 Jul 2026 10:37:59 +0200
Message-ID: <20260729083807.1588544-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new stackid_new_bucket allocates the new bucket and initializes it
with the trace data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 48 +++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 7bc2a966e3e8..366195b08c79 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -559,31 +559,52 @@ static int stackid_fastpath(struct stackid *stackid, struct bpf_map *map,
 	return -ENOENT;
 }
 
+static struct stack_map_bucket *
+stackid_new_bucket(struct stackid *stackid, struct bpf_map *map)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	struct bpf_stack_build_id *id_offs;
+	struct stack_map_bucket *bucket;
+	u32 i;
+
+	bucket = (struct stack_map_bucket *) pcpu_freelist_pop(&smap->freelist);
+	if (unlikely(!bucket))
+		return NULL;
+
+	if (stack_map_use_build_id(map)) {
+		id_offs = (struct bpf_stack_build_id *)bucket->data;
+		for (i = 0; i < stackid->nr; i++)
+			id_offs[i].ip = stackid->ips[i];
+	} else {
+		memcpy(bucket->data, stackid->ips, stackid->len);
+	}
+
+	bucket->hash = stackid->hash;
+	bucket->nr = stackid->nr;
+	return bucket;
+}
+
 static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			      struct perf_callchain_entry *trace, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
-	u32 trace_len, i;
+	u32 trace_len;
 	int err;
 
 	err = stackid_fastpath(stackid, map, trace, flags);
 	if (err != -ENOENT)
 		return err;
 
+	new_bucket = stackid_new_bucket(stackid, map);
+	if (!new_bucket)
+		return -ENOMEM;
+
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
 
-		/* for build_id+offset, pop a bucket before slow cmp */
-		new_bucket = (struct stack_map_bucket *)
-			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
-		new_bucket->nr = stackid->nr;
 		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
-		for (i = 0; i < stackid->nr; i++)
-			id_offs[i].ip = stackid->ips[i];
 		stack_map_get_build_id_offset(id_offs, stackid->nr, user, false /* !may_fault */);
 		trace_len = stackid->nr * sizeof(struct bpf_stack_build_id);
 		if (stackid->hash_matches && stackid->bucket->nr == stackid->nr &&
@@ -595,17 +616,8 @@ static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
 			pcpu_freelist_push(&smap->freelist, &new_bucket->fnode);
 			return -EEXIST;
 		}
-	} else {
-		new_bucket = (struct stack_map_bucket *)
-			pcpu_freelist_pop(&smap->freelist);
-		if (unlikely(!new_bucket))
-			return -ENOMEM;
-		memcpy(new_bucket->data, stackid->ips, stackid->len);
 	}
 
-	new_bucket->hash = stackid->hash;
-	new_bucket->nr = stackid->nr;
-
 	old_bucket = xchg(&smap->buckets[stackid->id], new_bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
-- 
2.54.0

