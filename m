Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808670;
	b=j5GjuR2MFdAKfUOHipDK1O7wVZih7PVheGXEXsSL7Vt4aNTfMgK4QtYfSV3ZJ1r7KG8G
	 guuuYRN/mb9Ghr8iN9AS++DJG0f5gzOWcWEahlJXebrPbaj38iN/03UuB+mYVH9fck/Li
	 Xisd+RF5JLVcQ23jiUAmd1ZkTpurNjQEd7kkP6A4UMaLhrbAEviO55xnAW83ZLGgP02JQ
	 zkhUajRa1NXSMsMvT/h5G8JSWeFnKUPjnxe6EKthuKm4TzBCJMnDV2PUjm4562mylxQNu
	 +q1bjEcN3v7zTfVQRmiNsbSz8NLVtDFFR/Hw8R0YYgwHwTz5zsfhUVqTQW4izfyYZWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ACvzaShZlCo6fcsqnaIAPFDDtpWeGtCPcOsEdn6sdk=;
	b=zNZde/aOK1e5RRdy3zAzb+GmzOekMxxlku6lc3CI3+8uen7iVpY1sHfPe1QahLjt87LI
	 g2aE66LEN9ggEoyq3v3SHjvcs4KkdAQ76sSagPwPyLiuEkOx81C8OFRi0DrtcRGTJXDOq
	 e9RdWImt7UzmHIR747CHFJErLzcjy9/gIDA0gpRXx6PyZXYj45d3KW8JZdCDA1ZATfYvX
	 M2PhRFzex/gjtz6chmvdrkDu6Dhgj3SHa9bI66DYsiI6jaofILpIsL/yUB8TFIfqlewlV
	 lE7XYeYahb4qTsKJfgXz3Tb7d+LuBbMqAmRduDOURK3/eC95iIdq7pCzkPKR2qcY6qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pW++7MN6;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A445606A32C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A445606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pW++7MN6
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b271e573adso1354607b3a.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808669; x=1795413469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ACvzaShZlCo6fcsqnaIAPFDDtpWeGtCPcOsEdn6sdk=;
        b=pW++7MN6RZHH3VUUKSbUnxgtIZS1gMq2ElnPoMk06oB5/ihA9YpiL2HaWjqDyD0RPt
         YfI3aMIl6vqXdooi1oNUpCuWjOzWz3eiE+C4875KPA56IqEPKQCZxtlFr7fllU/EGS35
         9aOPZhD5tO3dmzQgX2VcVgtlwc3tlwhIMvS0lcAJX9aRzKWbNMkKcoDw5CssWffSb9eh
         48fKpSbqYbmxTO0rv45cC0G2d+yggkofabrx7PTsQ4i070hkpyFlevZ6M3P9JaoHIry7
         x47DCmhXtKLuCeKjnK6FCUk/qIqfk89Tc3Pze5KOxnYl1KyaimIaiXLfWJTKfWq9oWx4
         zYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808669; x=1795413469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ACvzaShZlCo6fcsqnaIAPFDDtpWeGtCPcOsEdn6sdk=;
        b=xrKND2MdRFN1wTgoNvv8nWWLIL/3OKKqomRbgMqYOEm/0GQPuDlCWRJRXO7x88dJav
         Gw4kPVMp3csGV9kgYn83aDHtFRqbe9cN+a/RhMdlUwO8wcTxyOgqOeB2B8BkWpIpyjjR
         203oJGqqtAU0196zIlBB8pjiGlRwMj4k5uoCAEpcdBLeLVhNa99uFz3yu1FA4wM3BwZw
         gwPZH/M9elmkEsnxsz0+eBECGRpuuCfwM1/iDNqzFocmx9jhqziCx+dnJGwE4LNzp4nv
         /Kd/LNEHaTYq4RKyToRxWwSYu8P3rCgsjf/fCGyxnUMb5dCFFbNQof8vLMYemvWPysyV
         7fxQ==
X-Gm-Message-State: APuU4Z/BdYsiEq8VOpJg3tQCbWvQLWrcPD7ZMRgAmqgDz77vzl2eW3gH
	tkY4krL0LHueTcK3y6p0HE9EiSgRh1S4uasNmZOMa18MdP220dqYog4l/ZahKA==
X-Gm-Gg: AYBFou3pg7JII2HMGY7z//DK/lGR58l0/h1zgUE8UZrKIOvfbSdw8ptZi7DvIy6wHUb
	0i4mITAwB4+y3WfL4kwMmjZ7Cvk3obsEW5aJn6PolxdSX+mGX5eXX/XsuPZwELpqUuXMy0P9MJV
	NQx/4lvl7U7b6ECmESOOVlaWJjephID4VlBZigTP6jzdqXupSbR/ARLET0d1Vh6NJbjAnYV7jpS
	+B+QFOMDKJ0dj9tI3S62Q12p1Inl5RQysg6PE7eroFj4UzrF6ORN6sZFFBNU4l/EDqVMyiXIXos
	6ndmCUak7AD0bPn55PyscWX2hmsPbGUtC8tye3vtGfdZ+RyZ9vN0PLi8DFj9u8S1zs+fFGC7XD7
	NH3+4vZrjtiBh0oLz8dqX5UCSMw72vWC/HTVj4pUrPQC+0LtoTEbO3JnNXjkK1NC3gBY4ip9iQq
	5fArbQ+TN3yiB/3koXF0cm9GcI2MqivzdW6wFmtuaORzLX2N3pyaowb8JSYBuGnv3H9DAIQT6j7
	3di+o7vuSfCaWSOWnV17PN5Cuv7HB3FcUEqgZEfs/FDCZVcxplvQxltD7X2Wbuy3krg8drhZgPC
	bmVCep95TP/FjwZ+TPoHFF/galHJXCN2r0W9Cl9x4ZHa+r95tpVANMstpf7h779SmAifpv6O9rX
	z6ZPcFHZvnBkEFQj2D98JA9Qrv1hY5BzZeNpgASsJ+rzpDKWgRmv/ec6bIk5c+NvxJ+TQSZ6fBA
	==
X-Received: by 2002:a05:6a00:a13:b0:8a0:76ea:36a2 with SMTP id d2e1a72fcca58-8beb93ae04emr8840235b3a.54.1794808669188;
        Sun, 15 Nov 2026 21:57:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8f63sm3230009b3a.9.2026.11.15.21.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 11/21] libbpf: Size the tables of the loader program from the object
Date: Mon, 16 Nov 2026 05:56:28 +0000
Message-ID: <20261116055638.4171529-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

gen_loader mirrors limits of the kernel: 64 maps, 32 programs and 256
kfuncs. The numbers are known before the loader is made.

  fd_array:  [ maps | copies of maps | unused | BTFs of kfuncs ]
  prog_fds:  [ programs ]              was on the stack of the loader

Use gotol and a register for ctx when an offset needs more than 16 bits.
That was an error, so loaders that could be made do not get gotol.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |   3 +-
 tools/lib/bpf/gen_loader.c       | 157 +++++++++++++------------------
 tools/lib/bpf/libbpf.c           |   8 +-
 3 files changed, 74 insertions(+), 94 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 206adf28793d..c30e05b66abc 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -50,6 +50,7 @@ struct bpf_gen {
 	struct ksym_desc *ksyms;
 	__u32 nr_ksyms;
 	int fd_array;
+	int prog_fds;
 	int nr_fd_array;
 	/*
 	 * Maps with pointers to functions, that programs get their own copies
@@ -61,7 +62,7 @@ struct bpf_gen {
 };
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps,
-		   int max_func_ptr_maps);
+		   int max_func_ptr_maps, int nr_kfuncs);
 int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 555d4757a898..27b4bc9e55ac 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -15,11 +15,6 @@
 #include "bpf_gen_internal.h"
 #include "skel_internal.h"
 
-#define MAX_USED_MAPS	64
-#define MAX_USED_PROGS	32
-#define MAX_KFUNC_DESCS 256
-#define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)
-
 /* The following structure describes the stack layout of the loader program.
  * In addition R6 contains the pointer to context.
  * R7 contains the result of the last sys_bpf command (typically error or FD).
@@ -34,7 +29,6 @@
 struct loader_stack {
 	__u32 btf_fd;
 	__u32 inner_map_fd;
-	__u32 prog_fd[MAX_USED_PROGS];
 };
 
 #define stack_off(field) \
@@ -47,6 +41,16 @@ static int blob_fd_array_off(struct bpf_gen *gen, int index)
 	return gen->fd_array + index * sizeof(int);
 }
 
+static int blob_prog_fd_off(struct bpf_gen *gen, int index)
+{
+	return gen->prog_fds + index * sizeof(int);
+}
+
+static bool is_simm16(__s64 value)
+{
+	return value == (__s64)(__s16)value;
+}
+
 static int realloc_insn_buf(struct bpf_gen *gen, __u32 size)
 {
 	size_t off = gen->insn_cur - gen->insn_start;
@@ -113,20 +117,18 @@ static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps,
-		   int max_func_ptr_maps)
+		   int max_func_ptr_maps, int nr_kfuncs)
 {
-	size_t stack_sz = sizeof(struct loader_stack), nr_progs_sz;
-	int i;
+	size_t stack_sz = sizeof(struct loader_stack);
+	int i, cleanup_sz;
 
-	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
+	/* maps | maps with pointers to functions | unused | BTFs of kfuncs, never at index 0 */
+	gen->fd_array = add_data(gen, NULL,
+				 (nr_maps + max_func_ptr_maps + 1 + nr_kfuncs) * sizeof(int));
+	gen->prog_fds = add_data(gen, NULL, nr_progs * sizeof(int));
 	gen->log_level = log_level;
 	gen->nr_obj_maps = nr_maps;
 	gen->max_func_ptr_maps = max_func_ptr_maps;
-	if (nr_maps + max_func_ptr_maps > MAX_USED_MAPS) {
-		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
-		gen->error = -E2BIG;
-		return;
-	}
 	/* their fds are closed like the fds of the maps of the object when loading fails */
 	nr_maps += max_func_ptr_maps;
 	/* save ctx pointer into R6 */
@@ -139,27 +141,24 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	emit(gen, BPF_MOV64_IMM(BPF_REG_3, 0));
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
 
-	/* nr_progs includes subprogs and progs that are not loaded */
-	nr_progs = min(nr_progs, MAX_USED_PROGS);
-	/* amount of stack actually used, only used to calculate iterations, not stack offset */
-	nr_progs_sz = offsetof(struct loader_stack, prog_fd[nr_progs]);
-	/* jump over cleanup code */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
-			      /* size of cleanup code below (including map fd cleanup) */
-			      (nr_progs_sz / 4) * 3 + 2 +
-			      /* 6 insns for emit_sys_close_blob,
-			       * 6 insns for debug_regs in emit_sys_close_blob
-			       */
-			      nr_maps * (6 + (gen->log_level ? 6 : 0))));
+	/*
+	 * jump over cleanup code below:
+	 * 6 insns for emit_sys_close_blob,
+	 * 6 insns for debug_regs in emit_sys_close_blob
+	 */
+	cleanup_sz = (stack_sz / 4) * 3 + 2 + (nr_progs + nr_maps) * (6 + (gen->log_level ? 6 : 0));
+	emit(gen, is_simm16(cleanup_sz) ? BPF_JMP_A(cleanup_sz) : BPF_JMP32_A(cleanup_sz));
 
 	/* remember the label where all error branches will jump to */
 	gen->cleanup_label = gen->insn_cur - gen->insn_start;
 	/* emit cleanup code: close all temp FDs */
-	for (i = 0; i < nr_progs_sz; i += 4) {
+	for (i = 0; i < stack_sz; i += 4) {
 		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
 		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
 		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
 	}
+	for (i = 0; i < nr_progs; i++)
+		emit_sys_close_blob(gen, blob_prog_fd_off(gen, i));
 	for (i = 0; i < nr_maps; i++)
 		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
@@ -192,28 +191,9 @@ static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
 	return prev - gen->data_start;
 }
 
-/* Get index for map_fd/btf_fd slot in reserved fd_array, or in data relative
- * to start of fd_array. Caller can decide if it is usable or not.
- */
-static int add_map_fd(struct bpf_gen *gen)
-{
-	if (gen->nr_maps == MAX_USED_MAPS) {
-		pr_warn("Total maps exceeds %d\n", MAX_USED_MAPS);
-		gen->error = -E2BIG;
-		return 0;
-	}
-	return gen->nr_maps++;
-}
-
 static int add_kfunc_btf_fd(struct bpf_gen *gen)
 {
-	int cur;
-
-	if (gen->nr_fd_array == MAX_KFUNC_DESCS) {
-		cur = add_data(gen, NULL, sizeof(int));
-		return (cur - gen->fd_array) / sizeof(int);
-	}
-	return MAX_USED_MAPS + gen->nr_fd_array++;
+	return gen->nr_obj_maps + gen->max_func_ptr_maps + 1 + gen->nr_fd_array++;
 }
 
 static int insn_bytes_to_bpf_size(__u32 sz)
@@ -247,18 +227,33 @@ static void move_blob2blob(struct bpf_gen *gen, int off, int size, int blob_off)
 	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_1, BPF_REG_0, 0));
 }
 
+/* Returns the register for an access to ctx + *off: R6, or tmp if *off needs more than 16 bits */
+static int emit_ctx_reg(struct bpf_gen *gen, int tmp, int *off)
+{
+	if (is_simm16(*off))
+		return BPF_REG_6;
+	emit(gen, BPF_MOV64_REG(tmp, BPF_REG_6));
+	emit(gen, BPF_ALU64_IMM(BPF_ADD, tmp, *off));
+	*off = 0;
+	return tmp;
+}
+
 static void move_blob2ctx(struct bpf_gen *gen, int ctx_off, int size, int blob_off)
 {
+	int ctx = emit_ctx_reg(gen, BPF_REG_2, &ctx_off);
+
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, blob_off));
 	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, BPF_REG_1, 0));
-	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_6, BPF_REG_0, ctx_off));
+	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), ctx, BPF_REG_0, ctx_off));
 }
 
 static void move_ctx2blob(struct bpf_gen *gen, int off, int size, int ctx_off,
 				   bool check_non_zero)
 {
-	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, BPF_REG_6, ctx_off));
+	int ctx = emit_ctx_reg(gen, BPF_REG_0, &ctx_off);
+
+	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, ctx, ctx_off));
 	if (check_non_zero)
 		/* If value in ctx is zero don't update the blob.
 		 * For example: when ctx->map.max_entries == 0, keep default max_entries from bpf.c
@@ -277,12 +272,6 @@ static void move_stack2blob(struct bpf_gen *gen, int off, int size, int stack_of
 	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_1, BPF_REG_0, 0));
 }
 
-static void move_stack2ctx(struct bpf_gen *gen, int ctx_off, int size, int stack_off)
-{
-	emit(gen, BPF_LDX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_0, BPF_REG_10, stack_off));
-	emit(gen, BPF_STX_MEM(insn_bytes_to_bpf_size(size), BPF_REG_6, BPF_REG_0, ctx_off));
-}
-
 static void emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int attr_size)
 {
 	emit(gen, BPF_MOV64_IMM(BPF_REG_1, cmd));
@@ -294,11 +283,6 @@ static void emit_sys_bpf(struct bpf_gen *gen, int cmd, int attr, int attr_size)
 	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
 }
 
-static bool is_simm16(__s64 value)
-{
-	return value == (__s64)(__s16)value;
-}
-
 static void emit_check_err(struct bpf_gen *gen)
 {
 	__s64 off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
@@ -309,7 +293,8 @@ static void emit_check_err(struct bpf_gen *gen)
 	if (is_simm16(off)) {
 		emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, off));
 	} else {
-		gen->error = -ERANGE;
+		emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 1));
+		emit(gen, BPF_JMP32_A(off - 1));
 	}
 }
 
@@ -401,12 +386,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 	for (i = 0; i < gen->nr_func_ptr_maps; i++)
 		emit_sys_close_blob(gen, blob_fd_array_off(gen, gen->nr_obj_maps + i));
 	for (i = 0; i < gen->nr_progs; i++)
-		move_stack2ctx(gen,
-			       sizeof(struct bpf_loader_ctx) +
-			       sizeof(struct bpf_map_desc) * gen->nr_maps +
-			       sizeof(struct bpf_prog_desc) * i +
-			       offsetof(struct bpf_prog_desc, prog_fd), 4,
-			       stack_off(prog_fd[i]));
+		move_blob2ctx(gen,
+			      sizeof(struct bpf_loader_ctx) +
+			      sizeof(struct bpf_map_desc) * gen->nr_maps +
+			      sizeof(struct bpf_prog_desc) * i +
+			      offsetof(struct bpf_prog_desc, prog_fd), 4,
+			      blob_prog_fd_off(gen, i));
 	for (i = 0; i < gen->nr_maps; i++)
 		move_blob2ctx(gen,
 			      sizeof(struct bpf_loader_ctx) +
@@ -578,8 +563,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 		gen->error = -EDOM; /* internal bug */
 		return;
 	} else {
-		/* add_map_fd does gen->nr_maps++ */
-		idx = add_map_fd(gen);
+		idx = gen->nr_maps++;
 		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
 						 0, 0, 0, blob_fd_array_off(gen, idx)));
 		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7, 0));
@@ -720,11 +704,7 @@ static void emit_bpf_kallsyms_lookup_name(struct bpf_gen *gen, struct ksym_relo_
  * BPF_REG_8 - pointer to instruction
  *
  * We need to reuse BTF fd for same symbol otherwise each relocation takes a new
- * index, while kernel limits total kfunc BTFs to 256. For duplicate symbols,
- * this would mean a new BTF fd index for each entry. By pairing symbol name
- * with index, we get the insn->imm, insn->off pairing that kernel uses for
- * kfunc_tab, which becomes the effective limit even though all of them may
- * share same index in fd_array (such that kfunc_btf_tab has 1 element).
+ * index in fd_array, which has one slot for each symbol.
  */
 static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo, int insn)
 {
@@ -837,7 +817,8 @@ static void emit_relo_ksym_typeless(struct bpf_gen *gen,
 	/* skip typeless ksym_desc in fd closing loop in cleanup_relos */
 	kdesc->typeless = true;
 	emit_bpf_kallsyms_lookup_name(gen, relo);
-	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_7, -ENOENT, 1));
+	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_7, -ENOENT, 1));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_7, 0));
 	emit_check_err(gen);
 	/* store lower half of addr into insn[insn_idx].imm */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_9, offsetof(struct bpf_insn, imm)));
@@ -979,8 +960,7 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
 			emit_sys_close_blob(gen, insn);
 		} else if (!kdesc->is_ld64) {
 			emit_sys_close_blob(gen, blob_fd_array_off(gen, kdesc->off));
-			if (kdesc->off < MAX_FD_ARRAY_SZ)
-				gen->nr_fd_array--;
+			gen->nr_fd_array--;
 		}
 	}
 	if (gen->nr_ksyms) {
@@ -1136,14 +1116,10 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		gen->attach_kind = 0;
 	}
 	emit_check_err(gen);
-	if (gen->nr_progs == MAX_USED_PROGS) {
-		pr_warn("Total programs exceeds %d\n", MAX_USED_PROGS);
-		gen->error = -E2BIG;
-		return;
-	}
-	/* remember prog_fd in the stack, if successful */
-	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7,
-			      stack_off(prog_fd[gen->nr_progs])));
+	/* remember prog_fd in the blob, if successful */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, blob_prog_fd_off(gen, gen->nr_progs)));
+	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7, 0));
 	gen->nr_progs++;
 }
 
@@ -1159,10 +1135,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 static void emit_copy_initial_value(struct bpf_gen *gen, int map_idx, int value,
 				    __u32 value_size, int nr_more_insns)
 {
-	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
-			      sizeof(struct bpf_loader_ctx) +
-			      sizeof(struct bpf_map_desc) * map_idx +
-			      offsetof(struct bpf_map_desc, initial_value)));
+	int off = sizeof(struct bpf_loader_ctx) + sizeof(struct bpf_map_desc) * map_idx +
+		  offsetof(struct bpf_map_desc, initial_value);
+	int ctx = emit_ctx_reg(gen, BPF_REG_3, &off);
+
+	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, ctx, off));
 	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8 + nr_more_insns));
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, value));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 44134421bd7d..1efc0dd37b2e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9909,7 +9909,7 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	 * permit cross-endian creation of "light skeleton".
 	 */
 	if (obj->gen_loader) {
-		int nr_func_ptr_maps = 0, nr_progs = 0, i;
+		int nr_func_ptr_maps = 0, nr_progs = 0, nr_entries = 0, i;
 		bool text_has_callx = false;
 
 		/*
@@ -9929,8 +9929,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			    !prog_is_subprog(obj, &obj->programs[i]) &&
 			    (text_has_callx || prog_has_callx(&obj->programs[i])))
 				nr_progs++;
-		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
-			      obj->nr_programs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
+		for (i = 0; i < obj->nr_programs; i++)
+			nr_entries += !prog_is_subprog(obj, &obj->programs[i]);
+		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level, nr_entries,
+			      obj->nr_maps, nr_func_ptr_maps * nr_progs, obj->nr_extern);
 	} else if (!is_native_endianness(obj)) {
 		pr_warn("object '%s': loading non-native endianness is unsupported\n", obj->name);
 		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
-- 
2.55.0

