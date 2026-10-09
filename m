Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2074C9E1C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542958; cv=none; b=RUoHvhFQ2YTSxJS3gaYTxoaG7xkgVggMUQlmwBBcg3JNNy3kdPZO3FiazwC7tGa3u78LU3SyomuYm9sskuyOOLh13wHBDlJ0We3qN6JBXYK6jPUFKF1yge/6YsQFRk5TGCtfq49NGQpGpCgWqymcgMuCwNK/5c2382e/zJCo3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542958; c=relaxed/simple;
	bh=asrPNVecqBKsz8l1FwyKttv+JmBGABRZyVnbgvcs5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDiKp5FYxHFyvs5z/eZmL03bmLLI9lCt6Ix/MoZv//0cE5AbErDyi3PDaaUk9mfJChTqXr48u20PJbUGlW7YnPXnhJJz+cGfan2vh4Z/ELn7prjgtW3zM5aeuoW1w7BJJ1QOnWwN9GfyC69NfIMuZo8k6LS5BW+9UvMcKjvYzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvbSwLXn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvbSwLXn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so386585a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542935; x=1792147735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jZ02jkCSNXJG5CzHYwQ0hrRF+4ADTBRlf66BlnVTr8=;
        b=rvbSwLXngE1G104ieSt94sWi9BmeY1Z9+gh60aXGWC147voKwUJjcksOL9LnQSHeXt
         bDdZRO0UTfXy5oMPrvpb389Ad272Yst0UlZJ7LSet0OLnRaipZcxfwdetL6LAyhE1E4O
         4DzrlByz1x9ELksvcBujcgzVoZp1Ji4JrxbcvTUdU27EC60+gAV+k3d69DZPTB95vdlV
         EZbZUe8wYyHQuf2MNuCMwv2v74XDAJVzHpYC4vfJnwOxEgthYZ2F5T0TFdHG6IC6qobc
         RTkee6LIl7ZlEmTLWnZzX9fL6A43WAWu51pC7aMftfK4q1HE6j6eac8568sEg19MkayA
         fipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542935; x=1792147735;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jZ02jkCSNXJG5CzHYwQ0hrRF+4ADTBRlf66BlnVTr8=;
        b=CcNwcUG/M/TCBdzdFr8wdKtaQ9QRAuKC9XYxzz+mNW2+/BoOfQk8BvAyBp7MLk9eJx
         Oyk1TZ/XlTuyWQwY7/KXHxX/MAO8xfFybHpahKMhSEUUqWEV9weFLdVbwGlCWpWSQMNZ
         37nQmeYce8zWaMrOcMQ/AcD8ARDglO/NzMaqlhPxpcG3F1ibrtwK0XcFULykgjC0UFjw
         bTB2XmDq5jwECX4I61/Q3e9iG1MZtEQgECOgQHEHjpp3ZZO8fSksHL0WUVNPZ9kcND4a
         hpqHpATuffikJyq9AlWo3qXyPI8aYQWc4CvqWe6PoU6KJZn2JlFwVEAicdZInj4GZeLK
         zLpQ==
X-Gm-Message-State: AFq9FYLHJaD0Tfbhca+sJrslY149nyzrt3GwJEI9HHoKhWAx4EVfR05h
	U3yPCnHvmXVTisheNtWabfuBFTYAuIX4SCh2bcei0vNkw5z6o5IxjCKz0gUqy4qZ
X-Gm-Gg: AYBFou23MoHHswjTVku/TqIsgHB8PhSXm5PXjPGD12UiYPDywvBPbN8degP+uPSM0Ap
	SG76RBwzhgOSPJZsVayos4zM7G+emqWMKKMcTMX3H1tGjP1CCQkixCRUiLJs3dfDZaPqE3rJ95/
	sqoQmbHBZm5qwjjn1vC0rGKPzVU2uv5WcLX2nQa1hyi/OgCQlouBNuTLiQ/nDC07meTFqk5udqT
	BM7V92Pheu6KLEazZ1vDjszQQ7F41YOUPvAFQi64Rejm4VO/xldWki9GHcTzpr9fhwms/4Eq92J
	R3lMobj5Tp0mqtdtKBvmhJhcahYPSpvhBK0fACnJNcNjjzdVf9aZb1SgKjNGvwVLpQR7Z5kjg9L
	HwiwCaNXUpgLsURGYr61kXZ+jtmAlikcMYo3au0qmzmHV9GxkIGEmeQIJ2qpMYNIaB9HYeJQAjY
	gMGpMjsyMTxP+KzbAJOa36OQk9stBTFO0oV987BY31RX+83d6/1IRX5POewLVlvtyUwgMhrRtDg
	fYspYQidh5gDFA=
X-Received: by 2002:a17:90b:4a90:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3ab3a903353mr1566417a91.45.1791542935033;
        Fri, 09 Oct 2026 03:48:55 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 48/51] selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
Date: Fri,  9 Oct 2026 03:48:06 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-48-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Verifier tests for accessing arrays at a varying offset through a
PTR_TO_BTF_ID pointer, e.g. a[i].b where 'i' is a register with a
varying value:
- bpf_obj_new() is used to obtain a PTR_TO_BTF_ID to a program-defined
  struct
- bpf_get_current_task_btf() is used to obtain a PTR_TO_BTF_ID from
  the kernel BTF.

The cases cover:
- in-bounds access to a field of an array of structs;
- out-of-bounds access where the maximal offset runs past the array;
- a scalar (long) array with a matching stride;
- a byte array (step 1);
- a 4-byte read whose maximal offset spills past the array end;
- an unaligned step that is not a whole number of elements;
- both dimensions of a 2D array;
- an array of pointers within a program-allocated object, where reading a
  pointer member yields a SCALAR_VALUE but the varying offset is still
  validated against the array bounds (in-bounds and out-of-bounds);
- a varying access into an array embedded in a kernel BTF type
  (task_struct's comm[]), covering the non-allocated, trusted-pointer path
  (in-bounds and out-of-bounds);
- an array nested below a struct member at a non-zero offset, exercising
  the offset telescoping done while walking across a struct boundary
  (in-bounds and out-of-bounds);
- a trailing flexible array member, whose unbounded tail makes a varying
  access have no upper bound to exceed. A program-defined struct cannot be
  used here because bpf_obj_new() forbids flexible array members, so a
  kernel type (struct vring_used, with its 'ring[]' tail) is used
  (in-bounds, and an unaligned step that is not a whole number of
   elements).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../bpf/progs/verifier_btf_array_access.c          | 576 +++++++++++++++++++++
 2 files changed, 578 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4f3af1cb998b..2f05a0ce829f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -27,6 +27,7 @@
 #include "verifier_bpf_get_stack.skel.h"
 #include "verifier_bpf_trap.skel.h"
 #include "verifier_bswap.skel.h"
+#include "verifier_btf_array_access.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_flex_array.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
@@ -213,6 +214,7 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_u
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
 void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
+void test_verifier_btf_array_access(void)     { RUN(verifier_btf_array_access); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
new file mode 100644
index 000000000000..be001cc77f81
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+/*
+ * Variable-offset access into arrays within a BTF access chain, e.g. a[i].b,
+ * where 'i' is a register with a varying offset. The register's step has to
+ * match the stride of one of the arrays crossed while walking the access
+ * chain, and the maximal possible offset has to stay within that array.
+ *
+ * A program-allocated object (bpf_obj_new) is used as the source of a
+ * PTR_TO_BTF_ID with a shape we fully control.
+ */
+struct inner {
+	int a;
+	int b;
+};
+
+struct outer {
+	struct inner arr[8];	/* off 0,   stride 8, size 64 */
+	char bytes[32];		/* off 64,  stride 1, size 32 */
+	long longs[8];		/* off 96,  stride 8, size 64 */
+	int grid[4][4];		/* off 160, 16 ints,  size 64 */
+};
+
+/* arr[i].b, i in [0, 7], 4-byte read: stays within arr. */
+SEC("syscall")
+__success
+int arr_field_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 7;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 4);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/* arr[i].b, i in [0, 15]: max offset runs past the end of arr. */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct outer")
+int arr_field_out_of_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 15;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 4);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/* longs[i], i in [0, 7], 8-byte read: scalar array with stride 8. */
+SEC("syscall")
+__success
+int long_array_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	long val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 7;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u64 *)(r1 + 96);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * bytes[i], i in [0, 31], read as 4 bytes: min_off is valid within the array,
+ * but the 4-byte read at max_off runs past the array end. Exercises the
+ * size-aware bound in btf_struct_access().
+ */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct outer")
+int byte_array_size_spanning(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 31;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 64);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/* bytes[i], i in [0, 31], 1-byte read: step 1 matches the char array stride. */
+SEC("syscall")
+__success
+int byte_array_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 31;						\
+	r1 += r2;						\
+	%[val] = *(u8 *)(r1 + 64);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * arr[] accessed with step 4 (half of sizeof(struct inner)): the step is not
+ * a whole number of elements, so no crossed array has a matching stride.
+ */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct outer")
+int arr_unaligned_step(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 7;						\
+	r2 *= 4;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 0);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * grid[i][0], i in [0, 3]: steps along the outer dimension of a 2D array
+ * (stride 16). __btf_resolve_size() linearizes the array; the step is a
+ * multiple of the innermost element size (4).
+ */
+SEC("syscall")
+__success
+int grid_outer_dim(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 3;						\
+	r2 *= 16;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 160);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * grid[0][i], i in [0, 3]: steps along the inner dimension of a 2D array
+ * (stride 4, the innermost element size).
+ */
+SEC("syscall")
+__success
+int grid_inner_dim(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct outer *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 3;						\
+	r2 *= 4;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 160);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * An array of pointers within a program-allocated object. Reading a pointer
+ * member of a local object yields a SCALAR_VALUE, but the varying offset still
+ * has to be validated against the array bounds.
+ */
+struct with_ptrs {
+	struct inner *parr[8];	/* off 0, stride 8 (sizeof ptr), size 64 */
+};
+
+/* parr[i], i in [0, 7], 8-byte read: stays within parr. */
+SEC("syscall")
+__success
+int ptr_array_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct with_ptrs *o;
+	long val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 7;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u64 *)(r1 + 0);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * parr[i], i in [0, 15]: max offset runs past the end of parr. Without the
+ * variable-offset check on the WALK_PTR path this would be wrongly accepted.
+ */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct with_ptrs")
+int ptr_array_out_of_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct with_ptrs *o;
+	long val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 15;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u64 *)(r1 + 0);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * The cases above all use bpf_obj_new() (PTR_TO_BTF_ID | MEM_ALLOC). Exercise
+ * the trusted kernel-BTF path too, using a task_struct from
+ * bpf_get_current_task_btf() and its embedded char comm[] array. The comm
+ * offset is folded into the pointer as a constant before the varying index.
+ */
+
+/* task->comm[i], i in [0, 15], 1-byte read: stays within comm. */
+SEC("syscall")
+__success
+int kernel_btf_array_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct task_struct *task;
+	int val = 0;
+
+	task = bpf_get_current_task_btf();
+	asm volatile ("						\
+	r1 = %[task];						\
+	r1 += %[off];						\
+	r2 = %[i];						\
+	r2 &= 15;						\
+	r1 += r2;						\
+	%[val] = *(u8 *)(r1 + 0);				\
+"	: [val] "=r"(val)
+	: [task] "r"(task), [i] "r"(i),
+	  [off] "i"(offsetof(struct task_struct, comm))
+	: "r1", "r2");
+	return val;
+}
+
+/* task->comm[i], i in [0, 31]: max offset runs past comm. */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct task_struct")
+int kernel_btf_array_out_of_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct task_struct *task;
+	int val = 0;
+
+	task = bpf_get_current_task_btf();
+	asm volatile ("						\
+	r1 = %[task];						\
+	r1 += %[off];						\
+	r2 = %[i];						\
+	r2 &= 31;						\
+	r1 += r2;						\
+	%[val] = *(u8 *)(r1 + 0);				\
+"	: [val] "=r"(val)
+	: [task] "r"(task), [i] "r"(i),
+	  [off] "i"(offsetof(struct task_struct, comm))
+	: "r1", "r2");
+	return val;
+}
+
+/*
+ * Array nested below a struct member at a non-zero offset. The walk descends
+ * through 'm' (resetting the running offset) before reaching 'arr', exercising
+ * the array_start = min_off - arrays[i].off telescoping across a WALK_STRUCT
+ * dive.
+ */
+struct mid {
+	struct inner arr[8];	/* stride 8, size 64 */
+};
+
+struct nest {
+	long pad;		/* off 0 */
+	struct mid m;		/* off 8 */
+};
+
+/* m.arr[i].b, i in [0, 7], 4-byte read: stays within m.arr. */
+SEC("syscall")
+__success
+int nested_struct_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct nest *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 7;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 12);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/* m.arr[i].b, i in [0, 15]: max offset runs past the end of m.arr. */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct nest")
+int nested_struct_out_of_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct nest *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 15;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 12);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+/*
+ * A trailing flexible array member makes the struct tail an unbounded region,
+ * so a varying access into it has no upper bound to exceed (mirrors how
+ * unix_address.name[] is accessed via sun_path[i]).
+ *
+ * A custom (program) BTF struct can only be reached as a PTR_TO_BTF_ID through
+ * bpf_obj_new(), which does not allow flexible array members. So use a kernel
+ * type via an untrusted PTR_TO_BTF_ID (bpf_core_cast()). struct vring_used ends
+ * with a flexible array 'ring[]' of struct vring_used_elem { __virtio32 id, len; },
+ * mirroring a 'struct foo { int a; int b; }' flexible array.
+ */
+
+/* ring[i].len, i in [0, 63], 4-byte read: the flexible array has no upper bound. */
+SEC("syscall")
+__success
+int flex_array_field(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct vring_used *o;
+	int val = 0;
+
+	o = bpf_core_cast(bpf_get_current_task_btf(), struct vring_used);
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 63;						\
+	r2 *= 8;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 8);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	return val;
+}
+
+/*
+ * ring[] accessed with step 4 (half of sizeof(struct vring_used_elem)): the
+ * step is not a whole number of elements, so the flexible array stride does
+ * not match.
+ */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct vring_used")
+int flex_array_unaligned_step(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct vring_used *o;
+	int val = 0;
+
+	o = bpf_core_cast(bpf_get_current_task_btf(), struct vring_used);
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 7;						\
+	r2 *= 4;						\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 4);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i)
+	: "r1", "r2");
+	return val;
+}
+
+/*
+ * Access either name[0].sun_path[0] or one byte past sun_path.
+ * Step 108 does not match sizeof(struct sockaddr_un), which is 110.
+ * It matches the inner char array's stride, but exceeds its bounds.
+ * The flexible-tail exemption must not apply to that fixed array.
+ */
+SEC("syscall")
+__failure
+__msg("invalid variable offset access into struct unix_address")
+int flex_array_inner_array_out_of_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct unix_address *o;
+	int val = 0;
+
+	o = bpf_core_cast(bpf_get_current_task_btf(), struct unix_address);
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 1;						\
+	r2 *= %[len];						\
+	r1 += r2;						\
+	%[val] = *(u8 *)(r1 + %[off]);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i),
+	  __imm_const(len, sizeof_field(struct sockaddr_un, sun_path)),
+	  __imm_const(off, offsetof(struct unix_address, name) +
+			   offsetof(struct sockaddr_un, sun_path))
+	: "r1", "r2");
+	return val;
+}
+
+typedef int array_element_t;
+typedef array_element_t array_type_t[4];
+
+struct typedef_array {
+	array_type_t values;
+};
+
+/*
+ * Resolving values' size crosses both the array and element typedefs.
+ * Record the array ID, not the int ID left by element-type resolution.
+ * values[i], i in [0, 3], must pass the variable-offset array check.
+ */
+SEC("syscall")
+__success
+int typedef_array_in_bounds(void *ctx)
+{
+	unsigned long i = bpf_get_prandom_u32();
+	struct typedef_array *o;
+	int val = 0;
+
+	o = bpf_obj_new(typeof(*o));
+	if (!o)
+		return 0;
+	asm volatile ("						\
+	r1 = %[o];						\
+	r2 = %[i];						\
+	r2 &= 3;						\
+	r2 *= %[elem_size];					\
+	r1 += r2;						\
+	%[val] = *(u32 *)(r1 + 0);				\
+"	: [val] "=r"(val)
+	: [o] "r"(o), [i] "r"(i),
+	  __imm_const(elem_size, sizeof(array_element_t))
+	: "r1", "r2");
+	bpf_obj_drop(o);
+	return val;
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
