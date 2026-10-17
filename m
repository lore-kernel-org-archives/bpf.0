Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663618787A
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200686; cv=none; b=EIhTWCfpSg4zBSmXNp3mMEqj7eh8QiqYUO06z5VQ8aR2Mwefsp8Yk2sKQqXbRbisVeJMIYl1alHAIVgnVYamudvdoN8s/JNZ2BJms5zBjfs1uo/oirah73awwAEq7ObgDEAKRXnpOSOk36C+dAx7FZuvCN6JEJZw+/epN/cI3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200686; c=relaxed/simple;
	bh=/8x8Rlp8p31Ti25G5GQ91i89tF2GgqIshJhE1x9Dtqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obEbmx4iJPlyQVxlOY2h1zwNWD1LIElnhUAglvEGIkrXQMvFhZ8esSDDTPiKXZaVDyrXzf5Yz+H8mbG4R9NSV27PwPhs86hsCCFJfZVIt0QrYTPIlfoLfOxWc2AOsh8a1LsCagC0vQTVsuFuAsYaM5JAbtKpOFPdzYq0PQXkZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGavYQIT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGavYQIT"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so246621a12.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200683; x=1792805483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPVLCLwxkDEUczpC6MQgcn+TjCoKoOga5avi+i2pycw=;
        b=eGavYQITx94ET7RmmnYtxE7EDpVQ/UPD6ySSTRFbiJwAdQu2Zde5s36ksgXUCuI75D
         CZr+iSIMpYRRVBWCNpXCIqZ4njyC7N96dWIpAEd4UxAKeGSXrYSxBusP7isx0SIniCO/
         jxhypmvKdRi9/UpOOEHqFKDU2oM3H9SrqYQOT10d/eNYFiTxLHrRHxNsQ6xuj6LxZv4v
         mKkr9lEmLPk6m7GPeB/Gii25MDRQlVMhSuw3xJb43i7lWT7XMoC6S7Y1gpmNGZIHOfdq
         IvMk00hQJtM8skk5zJhn7iuioQFDJqSCzZTwxQuF5K47PZ3yTJWyTdd2zBBgcZ9qzmdY
         IKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200683; x=1792805483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPVLCLwxkDEUczpC6MQgcn+TjCoKoOga5avi+i2pycw=;
        b=XdwBjomO9aGu8RhPDM81Fr/C2beDroDx/ghPt/g89UGjxdvQPMuQHhBt2r1GjciI+g
         2akZShKhx9Qo+oQE8+P2PqaJJNbWikrlagoWM4mTT3UN8JgvTglv3LBef1/AavQ1iv8P
         67jgwXDFa1Jo23LKmQX1kACyzZV5MmPNXBG/K85WlfYvejNVj4UU5cVkJpV+TWpRGWz0
         8MlsTYr1dR/giOYxmNlGwROm651K6ZvGNp+lM08qT/fP2IKPqbTfS615b6CSKOmXg84H
         iXqgaDem8FNNVpQWWjtdsbaJSL4T5EZ5xmca+yD8EGmHgJzltPk7QDF3qyngHkDnSHLr
         WAbA==
X-Gm-Message-State: AFq9FYKqksy2U9vHLk8p6lZskn4kpFmkoVM8VUBd85S7xveZf1qQVsCz
	8Z6LAZWeAIN/4gq3PBsiiW5hpAtN52/kfffeP0v7lLaZ9lreSy13CgDYYa2dG7IS
X-Gm-Gg: AYBFou2kUKNMUfM/YC4MnfKWMzNIQ8GMrDlD4qWxIbqCsUOym1ROnT9c0zrHv9p9RfO
	Mj9JI7ZzxeKj2rzRNOFzrnYveoHNM3kFPj/RTYjrokUZw5bbf8SAwQAm9kA9WOdQ4OgFo6t1pX3
	acEJYpHOki2ne+rCesoDZU6zURyu35luMKwKcnBJlz9yd2X1ynnJq7cN/yU2Ap0hW2MajQUQwNr
	91nwDs8lt2Q+COXkoY93E9aYB5V86wycqgR+6TUwv69j03B+Q15x+RTQe4NWsFkHGqdHxFLErNK
	PObx9fgQfcokCbNAJjllaoeV7naaBu2T8KnKi208/If4ComatUqIuvIifIjUtvo/9D/W/GyL3Vr
	u6eIPOsU6y7nkAw9pe2+jZbDH3nllu+GU/9gSphwdUQQHEgzEkeyMg/6Ryf4TzHlD+Dg8WnkvE5
	hUz333eD5LFzR5esI6B+a2xxNjce9R+JZcDgGWcJ8/MRFIh9iD+8xiR6IpiNdUKxh36COFYxBT9
	eyHsaDLMvntYXWEyZOkbdcKnx+kcd7iOl2juUeLdwy0OxjXX+o7F1rg3rQ4Sz/Xm6uFFbdIywoj
	Tuv1RWaz9506vc2pLkpw9A++UCiIqktI4qAg35vJ2co=
X-Received: by 2002:a17:90b:4ccc:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3acee2937ffmr1230211a91.4.1792200683279;
        Fri, 16 Oct 2026 18:31:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11158754a91.5.2026.10.16.18.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:31:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 27/38] bpf: Keep iterator programs off special map fields
Date: Sat, 17 Oct 2026 01:24:40 +0000
Message-ID: <20261017012451.364800-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The bpf_map_elem iterator, for all but the per-cpu maps, and the
bpf_sk_storage_map iterator hand the live value of an element to the
program as a writable buffer.  The verifier does not know the map when it
checks the program, so nothing keeps the program from writing over a
bpf_spin_lock, a bpf_timer, a kptr or another special field, which neither
a map update nor a pointer to a map value can touch.  With CAP_BPF and
CAP_PERFMON, or a BPF token, a program can so make the kernel follow a
pointer of its choice: after a write over a bpf_timer the kernel crashes
on the written value when the element is removed.

Offsets into a buffer are constants.  Let the verifier record the range of
bytes that a program may write through a read-write buffer, and refuse the
program with -EACCES, at attach and at a link update, if a special field
of the map lies in that range.

A program that only reads, or that writes beside the special fields, works
as before.  One that writes on both sides of a special field is refused,
since the range covers the field.

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h       |  5 +++++
 kernel/bpf/map_iter.c     | 36 ++++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c     | 12 +++++++++---
 net/core/bpf_sk_storage.c |  2 +-
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6f93bd1414e5..8b26c4ec12a7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1858,6 +1858,9 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	/* [min, max): the bytes of a rdwr buffer that may be written */
+	u32 min_rdwr_write;
+	u32 max_rdwr_write;
 	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
@@ -3196,6 +3199,8 @@ void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
 			      struct seq_file *seq);
 int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 				struct bpf_link_info *info);
+int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
+				   const struct bpf_map *map);
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 16537356c1a2..a58c148692e6 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -97,22 +97,50 @@ static struct bpf_iter_reg bpf_map_reg_info = {
 	.seq_info		= &bpf_map_seq_info,
 };
 
+/*
+ * For an iterator that hands the live map value to the program as a writable
+ * buffer: the verifier knows nothing of the map, so the special fields of the
+ * value have to lie outside of what the program may write.
+ */
+int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
+				   const struct bpf_map *map)
+{
+	const struct btf_record *rec = map->record;
+	const struct btf_field *field;
+	u32 i;
+
+	if (IS_ERR_OR_NULL(rec) || !prog->aux->max_rdwr_write)
+		return 0;
+
+	for (i = 0; i < rec->cnt; i++) {
+		field = &rec->fields[i];
+		if (field->offset < prog->aux->max_rdwr_write &&
+		    field->offset + field->size > prog->aux->min_rdwr_write)
+			return -EACCES;
+	}
+
+	return 0;
+}
+
 static int bpf_iter_map_check_prog(const struct bpf_prog *prog,
 				   const struct bpf_iter_aux_info *aux)
 {
 	const struct bpf_map *map = aux->map;
 	u32 value_size = map->value_size;
+	bool is_percpu;
 
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+	is_percpu = map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
+	if (is_percpu)
 		value_size = round_up(value_size, 8) * num_possible_cpus();
 
 	if (prog->aux->max_rdonly_access > map->key_size ||
 	    prog->aux->max_rdwr_access > value_size)
 		return -EACCES;
 
-	return 0;
+	/* the program gets a copy of a per-cpu value */
+	return is_percpu ? 0 : bpf_iter_map_check_value_write(prog, map);
 }
 
 static int bpf_iter_attach_map(struct bpf_prog *prog,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 09173d1d66d3..6ee9b5c6fe47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6053,9 +6053,10 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       const struct bpf_reg_state *reg,
 			       argno_t argno, int off, int size,
 			       bool zero_size_allowed,
-			       u32 *max_access)
+			       u32 *max_access, bool write)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	struct bpf_prog_aux *aux = env->prog->aux;
 	u32 access_end;
 	int err;
 
@@ -6064,6 +6065,11 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 		return err;
 
 	*max_access = max(access_end, *max_access);
+	if (write && size) {
+		if (!aux->max_rdwr_write || access_end - size < aux->min_rdwr_write)
+			aux->min_rdwr_write = access_end - size;
+		aux->max_rdwr_write = max(access_end, aux->max_rdwr_write);
+	}
 
 	return 0;
 }
@@ -7339,7 +7345,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		}
 
 		err = check_buffer_access(env, reg, argno, off, size, false,
-					  max_access);
+					  max_access, t == BPF_WRITE);
 
 		if (!err && value_regno >= 0 && (rdonly_mem || t == BPF_READ))
 			mark_reg_unknown(env, regs, value_regno);
@@ -7852,7 +7858,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 		}
 		return check_buffer_access(env, reg, argno, 0,
 					   access_size, zero_size_allowed,
-					   max_access);
+					   max_access, access_type == BPF_WRITE);
 	case PTR_TO_STACK:
 		return check_stack_range_initialized(
 				env, reg,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 72b9ee4c98de..1c59300af05c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -925,7 +925,7 @@ static int bpf_iter_map_check_prog(const struct bpf_prog *prog,
 	if (prog->aux->max_rdwr_access > aux->map->value_size)
 		return -EACCES;
 
-	return 0;
+	return bpf_iter_map_check_value_write(prog, aux->map);
 }
 
 static int bpf_iter_attach_map(struct bpf_prog *prog,
-- 
2.55.0

