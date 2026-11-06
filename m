Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996414;
	b=HPlaZSr4z9X/ZeKj+gWDFAPOchdjVhY7xYUKcF62BCgzHKiaRgjghgot/hn+4mVvgvBq
	 qFpn4YmFpXYl62oOcM1RHmn+b1Uic3VFaCHmDWrynDitj5gJpD3+lUMczAez6GgWcEpgt
	 txeSWyJZJ88zLENGaSsOc7Objb2MkN0WxVCEqKo1mpYVs9kvBW43+rapdtyGBXBi7De0e
	 nrPsNhKJQeIPedCDV7V8afvLENe0SudfJMKJfQlcq3ufmG7RYShuo4bi+ThVFpfGB8JY0
	 PlfiX5vA4SzAOwWFOfyqFEfy0W5Hm3Ve31s31Kx7B/1p2DnNTQvvfnQ7DboUxh/by2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=v1K3WFaaxXIY1YG+wT7d7rSFJH79cYXrlV1wWh3xm5M=;
	b=u6WL/v9HEJxzuhrh7o5ZjcuTwkvJpEX3h+r7sxggX6wOBH5j1to/OO/urd07kluo46V8
	 JEExCHlfLmCeQiH9GXwtZwMsKNqnDmaW+PDYlq7q4jOaCCI/PTmNJtGo57gnRU601RWcT
	 hvj7msvn4GA2ClXkRfigmzi/bhIwkHN6TXunMkxzzvSeYJSruhpCbdF0DnuoODTXIBv22
	 9VvOmRfAlpK8fKcVfw98O2n7iAP2RUb4WHvvtpZg2CBedDJlaS3s2YcH4DiHPgyG1apq/
	 BCzl9wQsk9QOwE9ld1MuituOEXkWEv6eDqB+ujl4M3/celOo/WfuAFBf//VhlzoyCSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=feZwjoGg;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE63606A335
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE63606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=feZwjoGg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso956469a91.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793996413; x=1794601213; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1K3WFaaxXIY1YG+wT7d7rSFJH79cYXrlV1wWh3xm5M=;
        b=feZwjoGgZvGjnvAisqizVGEX7FwYxeX/flqBPhC1rp6tU5CK/e1YOUcxdojAZ9VjW0
         WdZlIaJ7E3hwE7nXWH5vVRjyGHUT4DRSHpAU7tBVB2qSoFeghnKkJz9VFsWBfEPGtBRv
         uwVNYhhDt0a60x4KP+5VsWVAKxdYTXuYlfoXdQ3vix84NjZ+RwFJWJmId2AD3VtroGW0
         uYdusyoUuEh1VwXyS/06VhXTaOWps2U7VktiU3QDi3cblL5JWS6nT07QMe4pLXxgCwLJ
         2/AbYTL8qvubkbvKZjFJzGFluu2LadCh7pdbG4iIZWmvLMnoN4Ify38svTa4fJsLHacD
         ykRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996413; x=1794601213;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1K3WFaaxXIY1YG+wT7d7rSFJH79cYXrlV1wWh3xm5M=;
        b=EIBNodZxTJ+y5EcMrOBNeel8ojCHyC2Pi0ppcUQpdJojqpnb280JAAz+cyGTEkpKZv
         fXYrJTmHkObc3vxFBOsfaxd6AkulKMkmUhP+BRfMyq9+W3v1bjWGXsJl3AQJZmGAy1em
         z8iDGMQ0kfq0UhUagoeffraXAccgk4TTv5or5ha0vDoQ5gHmERA4nNaZB5YDnY5uWIni
         aRI3FXsYsYm2dPXfyxek9XHWRmlGLiHZWBw5dsEaOLKuSgh3RO8RJLdIRgW0bwFAhmpo
         W5E9O836LaPejtUoL3SGPF5JF+Wc6IdJ7FCsJQWiTIwI+o/yClqw209qH2eaN9IFQA0F
         FMiw==
X-Gm-Message-State: APuU4Z+SbS8xFSb305FIUrujWBx6jeRfV1rubRvThFx9RUjYw/KpwsWQ
	VmR50eTknlFQgsXKV6IsXo3641EUrUnr6VhfiNquC2A7x/IpxUOfPQaRxfmv0nibtSf5ttMY6+V
	KTLIR1ZyleUf00Rpd8g==
X-Received: from pjqt7.prod.google.com ([2002:a17:90a:ae07:b0:3ae:7abe:56ae])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fd0:b0:3a4:945e:bc33 with SMTP id 98e67ed59e1d1-3b0db705ccbmr3457348a91.47.1793996412941;
 Fri, 06 Nov 2026 12:20:12 -0800 (PST)
Date: Fri, 06 Nov 2026 20:19:49 +0000
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261106-lskel-struct-ops-v1-2-a4486ffc79cb@google.com>
Subject: [PATCH RFC bpf-next 2/7] libbpf: Implement bpf_gen__init_kern_struct_ops()
 for light skeletons
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, "=?utf-8?q?Thi=C3=A9baud_Weksteen?=" <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

Add bpf_gen__init_kern_struct_ops() in gen_loader.c and wire it up in
bpf_object__init_kern_struct_ops_maps() when generating a light
skeleton.

At runtime, the generated loader program:
1. Resolves the BTF ID and module BTF FD of the wrapper struct
   bpf_struct_ops_<tname> via bpf_btf_find_by_name_kind().
2. Queries the wrapper struct's size and "data" member offset using
   bpf_btf_get_struct_member_info().
3. Resolves the BTF ID and module BTF FD of the target interface struct
   <tname> for program attach_btf_id resolution.
4. Allocates a 4 KB kern_vdata buffer in the loader data blob and
   populates non-zero scalar/array fields and per-program member offsets
   and attach indices.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/bpf_gen_internal.h |   4 +
 tools/lib/bpf/gen_loader.c       | 197 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           |  43 ++++-----
 tools/lib/bpf/libbpf_internal.h  |  24 +++++
 4 files changed, 245 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 206adf28793d..b424410e8839 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -84,5 +84,9 @@ void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, bool is_ld64, int kind, int insn_idx);
 void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo);
 void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx, int key, int inner_map_idx);
+void bpf_gen__init_kern_struct_ops(struct bpf_gen *gen, struct btf *btf,
+				   struct bpf_struct_ops *st_ops,
+				   __u32 *vtype_id_off,
+				   unsigned int *val_sz_off);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 555d4757a898..09713c39f71e 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -14,11 +14,14 @@
 #include "hashmap.h"
 #include "bpf_gen_internal.h"
 #include "skel_internal.h"
+#include "relo_core.h"
 
 #define MAX_USED_MAPS	64
 #define MAX_USED_PROGS	32
 #define MAX_KFUNC_DESCS 256
 #define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)
+#define STRUCT_OPS_VALUE_PREFIX "bpf_struct_ops_"
+#define KERN_VDATA_MAX_SIZE 4096
 
 /* The following structure describes the stack layout of the loader program.
  * In addition R6 contains the pointer to context.
@@ -1338,3 +1341,197 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
 	debug_ret(gen, "map_freeze");
 	emit_check_err(gen);
 }
+
+/* Expects:
+ * BPF_REG_8 - (btf_obj_fd << 32) | btf_id
+ *
+ * Overwrites BPF_REG_{0, 1, 2, 3, 4, 7}
+ * Returns result in BPF_REG_7
+ */
+static void emit_bpf_get_struct_member_info(struct bpf_gen *gen, const char *mname)
+{
+	emit(gen, BPF_MOV32_REG(BPF_REG_1, BPF_REG_8));
+	emit(gen, BPF_MOV64_REG(BPF_REG_2, BPF_REG_8));
+	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 32));
+	if (mname) {
+		int mname_len = strlen(mname) + 1;
+		int mname_off = add_data(gen, mname, mname_len);
+
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, mname_off));
+		emit(gen, BPF_MOV64_IMM(BPF_REG_4, mname_len));
+	} else {
+		emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
+		emit(gen, BPF_MOV64_IMM(BPF_REG_4, 0));
+	}
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_btf_get_struct_member_info));
+	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+	debug_ret(gen, "get_struct_member_info(%s)", mname ?: "NULL");
+	emit_check_err(gen);
+}
+
+/* Expects:
+ * BPF_REG_8 - (btf_obj_fd << 32) | kern_type_id
+ * BPF_REG_9 - kern_data_off
+ */
+static void emit_st_ops_member_val(struct bpf_gen *gen, const char *mname,
+				   const void *mdata, __u32 msize,
+				   int kern_vdata_off)
+{
+	int mdata_off;
+
+	if (libbpf_is_mem_zeroed(mdata, msize))
+		return;
+
+	if (msize > KERN_VDATA_MAX_SIZE) {
+		gen->error = -E2BIG;
+		return;
+	}
+
+	mdata_off = add_data(gen, mdata, msize);
+	emit_bpf_get_struct_member_info(gen, mname);
+
+	/* Extract member byte offset (lower 32 bits of R7), add kern_data_off, and bound it */
+	emit(gen, BPF_MOV32_REG(BPF_REG_2, BPF_REG_7));
+	emit(gen, BPF_ALU32_REG(BPF_ADD, BPF_REG_2, BPF_REG_9));
+	emit(gen, BPF_JMP_IMM(BPF_JLE, BPF_REG_2, KERN_VDATA_MAX_SIZE - msize, 2));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_7, -E2BIG));
+	emit_check_err(gen);
+
+	/* Copy msize bytes from mdata_off into kern_vdata_off + offset */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, kern_vdata_off));
+	emit(gen, BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_2, msize));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, mdata_off));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
+}
+
+/* Expects:
+ * BPF_REG_8 - (btf_obj_fd << 32) | kern_type_id
+ * BPF_REG_9 - kern_data_off
+ */
+static void emit_st_ops_member_prog(struct bpf_gen *gen, const char *mname,
+				    struct bpf_struct_ops *st_ops, __u32 member_idx,
+				    struct bpf_program *prog)
+{
+	int attach_type_off;
+
+	if (st_ops->progs[member_idx] && st_ops->progs[member_idx] != prog)
+		bpf_program__set_autoload(st_ops->progs[member_idx], false);
+	st_ops->progs[member_idx] = prog;
+
+	if (!prog)
+		return;
+
+	st_ops->kern_func_off[member_idx] = add_data(gen, NULL, sizeof(__u32));
+	attach_type_off = add_data(gen, NULL, sizeof(__u32));
+	bpf_program__set_expected_attach_type(prog, attach_type_off);
+
+	emit_bpf_get_struct_member_info(gen, mname);
+
+	/* 1. Store member byte offset (lower 32 bits of R7 + kern_data_off)
+	 * into st_ops->kern_func_off[member_idx]
+	 */
+	emit(gen, BPF_MOV32_REG(BPF_REG_2, BPF_REG_7));
+	emit(gen, BPF_ALU32_REG(BPF_ADD, BPF_REG_2, BPF_REG_9));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, st_ops->kern_func_off[member_idx]));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0));
+
+	/* 2. Store member index (upper 32 bits of R7) into attach_type_off */
+	emit(gen, BPF_MOV64_REG(BPF_REG_2, BPF_REG_7));
+	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 32));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, attach_type_off));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0));
+}
+
+void bpf_gen__init_kern_struct_ops(struct bpf_gen *gen, struct btf *btf,
+				   struct bpf_struct_ops *st_ops,
+				   __u32 *vtype_id_off,
+				   unsigned int *val_sz_off)
+{
+	struct ksym_relo_desc relo = { .kind = BTF_KIND_STRUCT };
+	const struct btf_member *member;
+	const struct btf_type *type;
+	char tname[192], stname[256];
+	const char *tname_raw;
+	__u32 i;
+
+	type = btf__type_by_id(btf, st_ops->type_id);
+	tname_raw = btf__name_by_offset(btf, type->name_off);
+	snprintf(tname, sizeof(tname), "%.*s",
+		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
+	snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);
+
+	/* 1. Resolve BTF ID of struct bpf_struct_ops_<tname> */
+	*vtype_id_off = add_data(gen, NULL, sizeof(__u64));
+	relo.name = stname;
+	emit_bpf_find_by_name_kind(gen, &relo);
+	emit_check_err(gen);
+	emit(gen, BPF_MOV64_REG(BPF_REG_8, BPF_REG_7));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, *vtype_id_off));
+	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_7, 0));
+
+	/* 2. Use the BTF ID to find the struct_ops value struct size and "data" offset */
+	*val_sz_off = add_data(gen, NULL, sizeof(__u32));
+	emit_bpf_get_struct_member_info(gen, NULL);
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, *val_sz_off));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7, 0));
+
+	emit_bpf_get_struct_member_info(gen, "data");
+	emit(gen, BPF_MOV32_REG(BPF_REG_9, BPF_REG_7));
+
+	/* 3. Resolve BTF ID of struct <tname> */
+	st_ops->type_id_off = add_data(gen, NULL, sizeof(__u64));
+	relo.name = tname;
+	emit_bpf_find_by_name_kind(gen, &relo);
+	emit_check_err(gen);
+	emit(gen, BPF_MOV64_REG(BPF_REG_8, BPF_REG_7));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, st_ops->type_id_off));
+	emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_7, 0));
+
+	/* 4. Allocate and populate space in the data blob for kern_vdata */
+	st_ops->kern_vdata_off = add_data(gen, NULL, KERN_VDATA_MAX_SIZE);
+	member = btf_members(type);
+	for (i = 0; i < btf_vlen(type); i++, member++) {
+		const struct btf_type *mtype;
+		const char *mname;
+		void *mdata;
+		__s64 msize;
+		__u32 moff;
+
+		mname = btf__name_by_offset(btf, member->name_off);
+		if (btf_member_bitfield_size(type, i)) {
+			pr_warn("struct_ops init_kern: bitfield %s is not supported\n",
+				mname);
+			gen->error = -ENOTSUP;
+			return;
+		}
+
+		moff = member->offset / 8;
+		mdata = st_ops->data + moff;
+		msize = btf__resolve_size(btf, member->type);
+		if (msize < 0) {
+			pr_warn("struct_ops init_kern: failed to resolve the size of member %s\n",
+				mname);
+			gen->error = msize;
+			return;
+		}
+
+		mtype = skip_mods_and_typedefs(btf, member->type, NULL);
+		if (btf_is_ptr(mtype)) {
+			struct bpf_program *prog = *(void **)mdata;
+
+			emit_st_ops_member_prog(gen, mname, st_ops, i, prog);
+		} else {
+			emit_st_ops_member_val(gen, mname, mdata, msize,
+					       st_ops->kern_vdata_off);
+		}
+	}
+}
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0e2a93a42908..7754d6640167 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -523,25 +523,6 @@ struct bpf_program {
 	__u32 subprog_cnt;
 };
 
-struct bpf_struct_ops {
-	struct bpf_program **progs;
-	__u32 *kern_func_off;
-	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
-	void *data;
-	/* e.g. struct bpf_struct_ops_tcp_congestion_ops in
-	 *      btf_vmlinux's format.
-	 * struct bpf_struct_ops_tcp_congestion_ops {
-	 *	[... some other kernel fields ...]
-	 *	struct tcp_congestion_ops data;
-	 * }
-	 * kern_vdata-size == sizeof(struct bpf_struct_ops_tcp_congestion_ops)
-	 * bpf_map__init_kern_struct_ops() will populate the "kern_vdata"
-	 * from "data".
-	 */
-	void *kern_vdata;
-	__u32 type_id;
-};
-
 #define DATA_SEC ".data"
 #define PERCPU_SEC ".percpu"
 #define BSS_SEC ".bss"
@@ -1462,7 +1443,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
-	size_t i;
+	size_t i, j;
 	int err;
 
 	for (i = 0; i < obj->nr_maps; i++) {
@@ -1474,9 +1455,25 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!map->autocreate)
 			continue;
 
-		err = bpf_map__init_kern_struct_ops(map);
-		if (err)
-			return err;
+		if (obj->gen_loader) {
+			const struct btf_type *type;
+
+			bpf_gen__init_kern_struct_ops(obj->gen_loader, obj->btf,
+						      map->st_ops,
+						      &map->btf_vmlinux_value_type_id,
+						      &map->def.value_size);
+			map->mod_btf_fd = -1;
+			type = btf__type_by_id(obj->btf, map->st_ops->type_id);
+			for (j = 0; j < btf_vlen(type); j++) {
+				if (map->st_ops->progs[j])
+					map->st_ops->progs[j]->attach_btf_id =
+						map->st_ops->type_id_off;
+			}
+		} else {
+			err = bpf_map__init_kern_struct_ops(map);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e90b5336bac0..845d6557c922 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -293,6 +293,30 @@ struct btf_map_def {
 	__u64 map_extra;
 };
 
+struct bpf_struct_ops {
+	struct bpf_program **progs;
+	__u32 *kern_func_off;
+	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
+	void *data;
+	/* e.g. struct bpf_struct_ops_tcp_congestion_ops in
+	 *      btf_vmlinux's format.
+	 * struct bpf_struct_ops_tcp_congestion_ops {
+	 *	[... some other kernel fields ...]
+	 *	struct tcp_congestion_ops data;
+	 * }
+	 * kern_vdata-size == sizeof(struct bpf_struct_ops_tcp_congestion_ops)
+	 * In standard mode, bpf_map__init_kern_struct_ops() will populate the
+	 * "kern_vdata" buffer from "data".
+	 * In gen_loader mode, bpf_gen__init_kern_struct_ops() will allocate
+	 * space for "kern_vdata" in the loader data blob and record its offset
+	 * in "kern_vdata_off".
+	 */
+	void *kern_vdata;
+	int kern_vdata_off;
+	int type_id_off;
+	__u32 type_id;
+};
+
 int parse_btf_map_def(const char *map_name, struct btf *btf,
 		      const struct btf_type *def_t, bool strict,
 		      struct btf_map_def *map_def, struct btf_map_def *inner_def);

-- 
2.56.0.455.g6c5a503b38-goog

