Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA18501F2A
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107725; cv=none; b=edRqWDN5MUKfxc/G+qa3rddP8G6RUqzLZDTHsS1nPUCDTX94oeu0shQH8kYdTEUU7vrznQ3jwuZW6TX/DbaRD9ebjycP47BU4urmx3r5U5enT3Fi8yz/J72dPXG+532c4Vg9isijzbQk7w/FGAT3w5axO9tRjJ+gygJqW2yXKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107725; c=relaxed/simple;
	bh=Gs+1E7IuXDT01mnL6KBAzHN2W8wvyG64et35Scw7jt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GloFODT5/OPaMPqaLvLM3mhyaq/q0qsV4IlYo/vMcOEjb0E5mU3dNVD/IMw2f26weRVfkXk5xh6JJ2Sw81TGoTwQV68EPNdmEY2dG8JYQsUtXeRdkCnvw/FlhgglSyq3fV/iIlv7t/MRgW46hurpqz/pMngq0F9O1/SE3Z0oQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9svb682; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9svb682"
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f44aa5d38aso1904612b6e.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107722; x=1792712522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fZ7L8JVhipyb226tEqpA6YGiIYeQ95IMxf1iQX9bSNI=;
        b=l9svb682MHv+k9hXpUHPoG9TNucrRKmfa9PMIdv6tPdrfuDKYb/kK+Bu5FZ1zQkIck
         4cgi2jQMJ+iOuH7pNZfysoce31+Sc0E0WBZfECwAvIA8TFukkdoRkl/MLLs+uXuZr77L
         05SL8/o2XtuYjGhZGF1AKI7Jgpyrg1N7Kc6KDg76E0E5L6MrWftqOQPJlonib/hMGJ9Q
         3t4fdEIAG3zf8ybuvCu65RYFrR1FnYWdB6peUIG3IT0jVei18i105VeASF/ICchFbeNi
         DEHrySaesMi7G24k0xQC0hCarDMAgGuN8iYFHeHMp4xyjNFn9giOWOYCj8CE5xVbY0SX
         lKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107722; x=1792712522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fZ7L8JVhipyb226tEqpA6YGiIYeQ95IMxf1iQX9bSNI=;
        b=JLFA8/Jtgipxni9wmy5Y3+oSoPFdepZlE+XOM/UEVBxINLk0ObFemfPRDSDizzNY4q
         Mt8BKqn0K+ZYN3usgwxMQzkQFVTFveJqwVLzvLaenVC4heMOoPJvPpz5ppBOU4c6ZbeK
         Vo0rtvapZmJdvXikO8RxEIA4bP0eD/vfgN4Lh4/Btv+vQIfpj2FWrFL0XNspkfWqnI0V
         nksqmI98uDpJNFtAkqLHMgqUgypJH2EiDIvMBbhGWRy1/L27mNRyc9DGAYgqzPCKT41E
         STPg2HC3ELCxYX0j2ZqKMz3YxwR+eYpvfrnbLzlL/nYvXf+YtKZ14mwU5urHhk/wqztf
         jK4w==
X-Gm-Message-State: AFq9FYLkSvZHpxZPd1DdN23tUCTTNjAENcHseKd+JIYrmFhXqY3U1zqk
	R11MBKiLwd36V0chj9mFhz1mKyJGoLDkafPehtPD88sOoDtsZGdcpFlC6n683tRYI9Q=
X-Gm-Gg: AYBFou2SNnZg4X54KRsyhMdr3cAd+tgAbcsRGRxlabjcREnnKJNA8qea5l/0vuo8cd6
	IyAZ4qLgQPIItz5e/JP3K8gEHaq0Qjoxr72Ir/bGqjIwmEszKRF3awqEmBnjoIgmRcfX8p9Fpzl
	WDi2FsM2Zda70M0VnTYcmVEW4yjRnsA66UxYIRVzWshlSjsAEPRi0wNc6gyLYb8SjrBboycoVpX
	WQ4AKbe+iA4SUB4i4dZRnS/b/NHc3M5KJgaYFf+hnAEuA+pB5IONK4xBPkmbQmJqSncchxsIyFV
	E+fW6dP46QbTs16yG2Wr3GDsFis2S4sVFoqeAumjmrR9NcvSv9OYe2/PIAq4KPu2IWo7q+vsUjc
	TvhwAMAIUaRZqiXCcc66EfhRZObnfsascL0+JRDmprVjcBY+6669i9v9dOTFwCnVLiFjYPwk2Tp
	SSQ98LlIRk5szlOojte+O418X9gjLafVlkFQBEf+THk6K0ZTS8mYyCOXgS7dXMx1MWyS2yWHHxY
	+xcyk6r5PYQ5yQjLUpOlXroJzHyjQTAd77GOnXt2ciR7q30M48gypqEgjn8rnqoQsozr53TL6dK
	5ZXCuA==
X-Received: by 2002:a05:6808:1304:b0:4fb:ac9b:b07f with SMTP id 5614622812f47-50c541715f1mr17564197b6e.49.1792107722485;
        Thu, 15 Oct 2026 16:42:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-53874e0e65bsm313847b6e.0.2026.10.15.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:42:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 10/15] libbpf: Bind the arena of an object to every program in it
Date: Fri, 16 Oct 2026 01:41:16 +0200
Message-ID: <20261015234125.3152346-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8520; h=from:subject; bh=Gs+1E7IuXDT01mnL6KBAzHN2W8wvyG64et35Scw7jt4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3Gul0xuUP2jL/whedklWhyu6S30e24mCxy+Yj5VuPT// v/nmjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzE6xYjwxFDfb63nC+CLtzh28qXte n/umetL51SSlcdfzjLdG6x7UKGf0b/1m99pMAw9Xpu6D91p/PuOxT/ann89gzZnm3o9kM1mwEA
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
arena now lives as long as any program of the object. With the count,
the kernel also resolves every module BTF slot of the array for every
program of the object, so each of them holds the modules the object
calls into, not only the programs that call them. Where the JIT is
disabled or the loader lacks CAP_PERFMON, every program of such an
object now fails to load, since an arena needs both, where before only
the programs using the arena did. bpf_program__clone() binds the arena
the same way, so a program loads through veristat as it does through
bpf_object__load(). An arena exclusive to another program and the
light skeleton loader are left alone.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/features.c        | 40 +++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          | 57 +++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 97 insertions(+), 2 deletions(-)

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
index fcedb78abe00..bd4df22a8a95 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -797,7 +797,8 @@ struct bpf_object {
 	/*
 	 * Slots handed out so far, slot 0 included. A kfunc insn names a module
 	 * BTF slot through its offset, slot 0 stands for vmlinux BTF and stays
-	 * empty, so the array goes to the kernel without a count.
+	 * empty, so the array goes to the kernel without a count, unless
+	 * bpf_object__bind_arena() puts the arena of the object there.
 	 */
 	size_t fd_array_used;
 
@@ -8804,6 +8805,47 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
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
+static int bpf_object__bind_arena(struct bpf_object *obj, struct bpf_program *prog,
+				  struct bpf_prog_load_opts *load_attr)
+{
+	struct bpf_map *map;
+	int err;
+
+	if (obj->gen_loader || obj->arena_map_idx < 0 || !kernel_supports(obj, FEAT_FD_ARRAY_CNT))
+		return 0;
+	map = &obj->maps[obj->arena_map_idx];
+	/*
+	 * Nothing to bind when the arena is not created, or no longer is after
+	 * a failed load, when it is exclusive to another program, and nothing
+	 * for an offloaded program, which the kernel does not let near an
+	 * arena.
+	 */
+	if (!map->autocreate || map->fd < 0 || (map->excl_prog && map->excl_prog != prog) ||
+	    load_attr->prog_ifindex)
+		return 0;
+
+	if (!obj->fd_array_used) {
+		err = libbpf_ensure_mem((void **)&obj->fd_array, &obj->fd_array_cap, sizeof(int), 1);
+		if (err)
+			return err;
+		obj->fd_array_used = 1;
+	}
+	obj->fd_array[0] = map->fd;
+	load_attr->fd_array = obj->fd_array;
+	/* with slot 0 filled every slot handed out is valid, so the array can go with a count */
+	load_attr->fd_array_cnt = obj->fd_array_used;
+	return 0;
+}
+
 static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog,
 				struct bpf_insn *insns, int insns_cnt,
 				const char *license, __u32 kern_version, int *prog_fd)
@@ -8867,6 +8909,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (obj->data_in_arena)
 		load_attr.prog_flags |= BPF_F_ARENA_SCALAR;
 	load_attr.fd_array = obj->fd_array;
+	err = bpf_object__bind_arena(obj, prog, &load_attr);
+	if (err)
+		return err;
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
@@ -9966,8 +10011,10 @@ static void bpf_object_cleanup_btf(struct bpf_object *obj)
 
 static void bpf_object_post_load_cleanup(struct bpf_object *obj)
 {
-	/* clean up fd_array */
+	/* clean up fd_array, and the slots handed out with it */
 	zfree(&obj->fd_array);
+	obj->fd_array_cap = 0;
+	obj->fd_array_used = 0;
 
 	/* clean up BTF */
 	bpf_object_cleanup_btf(obj);
@@ -10946,6 +10993,12 @@ int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts
 	attr.kern_version = OPTS_GET(opts, kern_version, 0) ?: obj->kern_version;
 	attr.fd_array = OPTS_GET(opts, fd_array, NULL) ?: obj->fd_array;
 	attr.fd_array_cnt = OPTS_GET(opts, fd_array_cnt, 0);
+	/* the arena of the object goes with the program, as in bpf_object__load() */
+	if (!OPTS_GET(opts, fd_array, NULL) && !OPTS_GET(opts, fd_array_cnt, 0)) {
+		err = bpf_object__bind_arena(obj, prog, &attr);
+		if (err)
+			return libbpf_err(err);
+	}
 	attr.token_fd = OPTS_GET(opts, token_fd, 0) ?: obj->token_fd;
 	if (attr.token_fd)
 		attr.prog_flags |= BPF_F_TOKEN_FD;
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

