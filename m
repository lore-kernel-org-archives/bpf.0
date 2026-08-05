Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F53F99E6
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922160; cv=none; b=MuZYALQGhnZyPskusHSpSIh3adUbDri++PRyGmNbs2vIalhoo5ZkHMPlAFvnGuCeaHNPEQWMRKIsEqtF98z+pRxM7dpAOJz2fZF52SWwBj42cOOPY0B5cnOkH/H2V31C/w06VQ82Y7GW1u5GzdnK/yZu0GopC4idVi+OFg6Ir1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922160; c=relaxed/simple;
	bh=fqb3s8NCQbzPmMCVCBpn6vaXkSo6NZU5HDuTpUa8k8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttKrIiYb5yxlEtqnpw/ZwG6AAss26dWAN9mi4U/cGjmMk85ROjpcUVK8mSMA8Hkh60HVJ9OtAM8sx0w/1nHlZ4XBJLtxKTw4vsbathPBRla94yeiyxrS2s0G9Z4me5K/UIInis4/cmyEkY49YNI+sfK747x6NSKRqzaDrMT16+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIckd206; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIckd206"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E528E1F00A3A;
	Wed,  5 Aug 2026 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922158;
	bh=Pa5hHTApRoHu8udU24uEMyG0YdVNgGC3q8DLX6bidl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIckd206NDCcMNkYK4zv31ualbz4E71vVL8LRcKtU8c46rYKFPNhsOQMsXmgxxW9T
	 P2WSo56N6c5toI59r873wNWpmIMZpAn1nW45KOOpb3h5Ll6J8NT1UC7uzYHBcgQtKP
	 uAW8Y3TbWhtULv024ZBf5riZagIQHERFaFH8HS8epQk0HhvnXcyDp0m6JQx78eOPef
	 uuVUg3WPSMXf7wmm20XtJNApnYVXijEgpqN+m7zvkbcnkJqM2smg/x99OLYhtURN9v
	 SVT1Dnu8/06fxeyjEiiqGAQuw04s5ZjGqayF+F5j6JsJNK4VpDq5vt0YjVVzZCHQcK
	 Ko65g9fuI2ALw==
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
Subject: [PATCHv4 bpf-next 03/12] bpf: Factor stackid_new_bucket from __bpf_get_stackid
Date: Wed,  5 Aug 2026 11:28:34 +0200
Message-ID: <20260805092843.516315-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
References: <20260805092843.516315-1-jolsa@kernel.org>
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
index 27210b5d16fc..d930d9754d7d 100644
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

