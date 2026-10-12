Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B332A3D7
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812261; cv=none; b=kal5SxbHw4xm5RdOteBBn0GJuS4yC/sLAVooncR3XkUC7QRIoe0tr+0goKvWuXrzU6n6/TUp9mHF4ib3ec5fXH+m5vuzw0HHOBeUi9GjcV38QORImdQfUYddvif90nsBRrr+0yi/6FfeZi6U/DOPBD9Yi/FYUe7RA0kj1GMP2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812261; c=relaxed/simple;
	bh=kbbtpE9Xumvtb0knEFpm5OuUFLjOw97UVr/z73O/SLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMGqcCe4OmcECNR3yzEaQ52lpMJTxS8qg1bDO/lf/g/SEvUMC41ooU/6MaXzPPKT25MzVR7zSR1MInLRUxJIcYJxItlcXqET/9+I5gKXZ54qXRcvQAhxMR/h8aoM7urXsf5iY/RQvGOjZ6C+4Wu1S0gwsRxV50u52xcxruuFcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brUV7VzF; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brUV7VzF"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4f6b95ba1f6so1140115b6e.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812259; x=1792417059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BhYV+ELlfoRJn/XLn9tyRonZNjaNwu7Hwh2YUUxYpX0=;
        b=brUV7VzFYpPPpOOSlV7txJKsAZG/k8kEiuKoYK2mNEBShuvD9u47Op534abA4mu9HI
         AXgkvbr+wI7qHFvDK1LhZUO8A3pnibX0gGNw20J6vJTMCWuJsN1RO+CZNRbaUEj2dEon
         FGEkbWHtBsxIvnPHOMnzVgYFcRqHSV6h81oP6dTyTbu/jqt6rU3i2aZDKs1VV0DesYZ8
         DOGoUUdNVNoz+zxlNWk3yjcdfFFf4mZaKe8WDPsmTfGXyo5ikinx/W5jbiTWlsvq5FT5
         7+ORYubLSlAu5iU5oGki6C/3BMqQvFA/yAokVCFbzJdWKzW/VAc3wmEwWX9zZ5WYinon
         0zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812259; x=1792417059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BhYV+ELlfoRJn/XLn9tyRonZNjaNwu7Hwh2YUUxYpX0=;
        b=GElmrZgRPQjrY8khIjWOx54qx7uRoVeUxDaNxX4D0+0vKvKZBGD5ZZsowXM/Rcsh3l
         PZjBj53E8aCFdSecKArMuavDo6l5FBTLE0ibwZsk/2gUAwhzDwXuZ0VatTh50Prv6qk5
         2BEpjPxZCYH2Q68LIvU/Er669AKeTpSmFxg9EIBCHE2jvPyIjOIh2C4ujSNEg1yc7ygr
         EtPG/rf/A9092FnUb7bYwPZxGw/PKOMa8DufTGwRxNAu0T63/drdNKjxY8lx8HF6Ohjw
         tkdxoGtBgai9tnIQ+h9NUA2HeQvj2gNn6lXxeNK2Sim4LPKQUD5JQS/rvmxJ6YQXah7+
         gVNA==
X-Gm-Message-State: AFq9FYKyTBTCAlVSgG8aT0JjHMLPQUOxO5ZE2lR8CchK0XPY79YT/1++
	hgvb81flxEt3YxXLu17VPpdBHmOWpMoODTEcaezXFK/7j9aQXR0Qra/jJLBE6ypVEv8=
X-Gm-Gg: AYBFou0aaia4LU4vykDRfDsBGNjvEerR66+5O57GZSH2+/lVZLfGsZ1tFvbMpgFgShA
	lmnPAvp9XRCxjIexq0wP2M5/0/Zfw1v2g/E+bcrgxiJnsz5PVzgJC6tMoJRkXfavy8NMFfcbYyR
	1JbaE47Rb3lYHngT/npf0l6VKZ9KZ/66NDvQw4DTQ4SI45xqXhaJHxOVU/Yk26kysRjGAuZ9vgF
	LxCAP8Ua/ROlTSy8xGznh4sY2MIL+oE37THYAbuwmVjWZvQK/VpWbRQrupZKqo6j7vk/bW+4q2W
	ZZZ0OqvVeqn13yKPn9pYKBCCfpGFPvpIganVGjwPaiB2OeJ59aA19dnEmKA5ylvEYgc64mcwh09
	aybZPmJlvcy4JUTwRaOe5Zd47VtyY8rwsbiLUNFkR6ARND8NEYrqfYh2SDPbHJtuiNwf7ZLc1Xn
	zz9DVrX21zm5LuYlhOmr7qqJWWAzYRXIlLKfJhZKb+vmpODNJzSWZZLY/qIw+1qplKumlE/DKNo
	xL8Hcouj3PnUBHdwZEBnAlUwsJwAsHzVK4+/Q+8mmgHF3Nx30M35+PRjIcQUkKM0muGhc0c8EMN
	253QyA==
X-Received: by 2002:a05:6808:c3c2:b0:4f4:550a:3a88 with SMTP id 5614622812f47-50c50f31c5emr8643925b6e.16.1791812258935;
        Mon, 12 Oct 2026 06:37:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c17d84e77sm10902563b6e.7.2026.10.12.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/10] libbpf: Bind the arena of an object to every program in it
Date: Mon, 12 Oct 2026 15:37:03 +0200
Message-ID: <20261012133711.4030594-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5972; h=from:subject; bh=kbbtpE9Xumvtb0knEFpm5OuUFLjOw97UVr/z73O/SLw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7WMkiKKO9+GWjxJOlyy/LdW7+Uu8dSgn0daF7wRCZ7S ezC5o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPxu8bwP3/72vMWTrGl/zZG71xgfb SK6eHKJ/qHdmQzT/q49e/2068ZGb7ry95UsTm0qu52/oeGpKPWS9tyt7lGtX61U1p3XPGzHAMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A program has an arena only when one of its insns refers to the arena
map. The kernel can hand a program arena pointers all the same: as
__arena struct_ops arguments, through __arena struct members and as
kfunc return values. The verifier rejects those in a program without an
arena, since it has nowhere to place them, and so a struct_ops callback
that touches nothing but its arguments fails to load until it refers to
the arena artificially, e.g. with asm volatile("" :: "r"(&arena)).

Bind the arena of an object to every program loaded from it. The kernel
binds the maps of a continuous fd_array (fd_array_cnt) like maps an insn
refers to, so pass the arena in slot 0, which is free: a kfunc insn with
offset 0 names vmlinux BTF rather than a slot. The module BTF slots that
follow stay as they are. A feature probe keeps older kernels, which
reject a non-zero fd_array_cnt, on the previous behavior.

An object has at most one arena, libbpf refuses a second one, so there
is no ambiguity about which arena a program gets. Programs that never
touch the arena pay for the binding with the arena base setup in their
JIT prologue and with the arena showing up among their maps, and the
arena now lives as long as any program of the object. The light
skeleton loader is left alone.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/features.c        | 40 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 37 ++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 79 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 9f589980beef..71c6a666afcb 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -77,6 +77,43 @@ static int probe_kern_global_data(int token_fd)
 	return probe_fd(ret);
 }
 
+/*
+ * A continuous fd_array binds every map in it to the program, whether an
+ * insn refers to the map or not. Kernels without the attribute reject a
+ * non-zero fd_array_cnt.
+ */
+static int probe_kern_fd_array_cnt(int token_fd)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+		.fd_array_cnt = 1,
+	);
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
+
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "libbpf_det_bind", sizeof(int), sizeof(int), 1,
+			     &map_opts);
+	if (map < 0) {
+		ret = -errno;
+		pr_warn("Error in %s(): %s. Couldn't create simple array map.\n",
+			__func__, errstr(ret));
+		return ret;
+	}
+
+	prog_opts.fd_array = &map;
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	close(map);
+	return probe_fd(ret);
+}
+
 static int probe_kern_btf(int token_fd)
 {
 	static const char strs[] = "\0int";
@@ -742,6 +779,9 @@ static struct kern_feature_desc {
 	[FEAT_PERCPU_DATA] = {
 		"kernel supports percpu data", probe_kern_percpu_data,
 	},
+	[FEAT_FD_ARRAY_CNT] = {
+		"continuous fd_array (fd_array_cnt)", probe_kern_fd_array_cnt,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb09ded90773..2360c8cc94d3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8799,6 +8799,38 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_sz);
 
+/*
+ * Bind the arena of the object to the program about to be loaded. A program
+ * has an arena only when an insn refers to the map, but the kernel can hand
+ * it arena pointers all the same, as struct_ops arguments, through tagged
+ * struct members or as kfunc return values, and the verifier rejects those
+ * when the program has no arena to place them in. A continuous fd_array
+ * binds every map in it, the arena takes slot 0, which is free: a kfunc insn
+ * with offset 0 names vmlinux BTF rather than a slot.
+ */
+static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_prog_load_opts *load_attr)
+{
+	struct bpf_map *map;
+	int err;
+
+	if (obj->arena_map_idx < 0 || !kernel_supports(obj, FEAT_FD_ARRAY_CNT))
+		return 0;
+	map = &obj->maps[obj->arena_map_idx];
+	if (map->fd < 0)
+		return 0;
+
+	if (!obj->fd_array_cnt) {
+		err = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int), 1);
+		if (err)
+			return err;
+		obj->fd_array_cnt = 1;
+	}
+	obj->fd_array[0] = map->fd;
+	load_attr->fd_array = obj->fd_array;
+	load_attr->fd_array_cnt = obj->fd_array_cnt;
+	return 0;
+}
+
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
 				const char *license, __u32 kern_version, int *prog_fd)
@@ -8862,6 +8894,11 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (obj->data_in_arena)
 		load_attr.prog_flags |= BPF_F_ARENA_SCALAR;
 	load_attr.fd_array = obj->fd_array;
+	if (!obj->gen_loader) {
+		err = bpf_object__bind_arena(obj, &load_attr);
+		if (err)
+			return err;
+	}
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4e45dfacb548..22d9fe512ea1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -404,6 +404,8 @@ enum kern_feature_id {
 	FEAT_BPF_SYSCALL_COMMON_ATTRS,
 	/* Kernel supports percpu data */
 	FEAT_PERCPU_DATA,
+	/* Kernel binds every map in a continuous fd_array (fd_array_cnt) to the program */
+	FEAT_FD_ARRAY_CNT,
 	__FEAT_CNT,
 };
 
-- 
2.53.0-Meta

