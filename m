Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193443B3C9
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121155; cv=none; b=a+6aL+9nePHFypbSL/pAeZALopK8FCK2iInvP0pOnGMmyjFkaVR8oxxgp05FmRlPVy8/BE1JQS2G0lfUOj6E+qKb2LQzXqXxjxpbv3xnD/x3s43ew8/y/0vcP2nrpHo+a826oy/fncmTuWzIDTmr1YrS8V7C+FFitWom/65rV5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121155; c=relaxed/simple;
	bh=asrPNVecqBKsz8l1FwyKttv+JmBGABRZyVnbgvcs5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt53cJf+Z2QZafsGsFo7rJESdvxpNwIsS+hxoHhrBtjvAd+MYbkUZjhVODAMmJw1d9qwdc+qMqKiCUiSD3LcpeSDFdY69TflC60uoQYtm/6SF3aMz0QRPi87ZWQu3OK+xQPRFt0xsfb8BU2giNxLl4bNOlB/+m3EBLcYdTNZsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWwAUd1r; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWwAUd1r"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09dso298350a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121152; x=1791725952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jZ02jkCSNXJG5CzHYwQ0hrRF+4ADTBRlf66BlnVTr8=;
        b=YWwAUd1r5iPxq+qqNBeyXpyS5C59qbKqFqTgA18OJIbjJSWLg+xQvz3FNNGPQNuJDY
         Mk34MzTvuy+v1yj0IkiuP+3aLFRKsa+Ndq+w30BVPxxqHB2UpqKIe8QoYRHFsnqiNHlh
         HiC3gHERlriUfdWLQG0ewf55G8VV+3rfi79HMthv0E6nmqBcNIztGjlKzFFpcZjx++Mv
         i0b/iF2LK45ors3EO0AL1ma9isiT1Y1a8fNHki3ONncFeijjmL/WGNoJ7aL9JrmGoYwb
         0gzwKeC657XmgL4cjEpufgyO+6sLjxiBDqIECDavRp0vVi+4ucg2FiLDXAMjiYQ8iLYE
         W/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121152; x=1791725952;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jZ02jkCSNXJG5CzHYwQ0hrRF+4ADTBRlf66BlnVTr8=;
        b=SnZlaZ8AyNCEv7RRFCGOIuTp67igNkXKZgbDJI0YMm9c6Hmv3x0zvzCsg4wEG/Vv0q
         eqpcr4jzRztdcnYx/xa8Ri6pgxbn3I/vvbN4EKm4K8Cszq7fHh2pdS9Sej5avurm7x2c
         S/gsDZIBVNcTHB9N8OweO1XNRfgfGgjm2hwPOfJ6zY6gOiQchdDPYtv/dIFTWDWXDrWE
         27LqX//2Qh493GvFJCSjy6qgOpYMyIsQu5Md3o6rIjthiUtCqIXztrWZK1FWXeujhUiM
         EA6WbDzBKcKqgUx7M8rfcFShENQGDwW7eOcgm5UM9vl7uzUaZbnhbdxWREm6QKmzSqEk
         hTog==
X-Gm-Message-State: AFuF++km5TuuL26GOPhcLFJHugzgCCvbxPUUnxNLek9togT15Z0IrIag
	50klbJv93gsijixu1guwSy2e/W5a84/owmGDUEyKWG8Efkbd7kvUndorLz9t5Q==
X-Gm-Gg: AYBFou3pJ5jBXSN5vCzmUdd8qMWrlUxJoQkJnWCwbkxIxNWX3TIZzyCW5VoTaVihrCX
	+eGECaAluE9X+qgOQoG96Zl+igS8H0YOEqRllUrNHEmMrwjldaocZ+a1uuJgk3udPEnuZlylvmy
	CVCDKcKGVYUTzhGiIPBsRoMYRr5f3CRYBl+y+540n3C5pkTBj8gnwxWHvy9NFfTlOVpew3OYBEy
	b10lGJLNKn43S6IP8UizcQlv2zFd38XbgfLTiaj9RP1QAESFx1c7rLLbokZJ/1sEBlUALKpe+No
	QMB0ypCl8twe50edCmCZY8FScqVUT07tMyasJjy6vHZhgkPy+FqDgIg8yESDnlWniBK/eVS1fzY
	2JVFC8+t9cYNgdpXAtv5aoYG5IcBBwy18wmBbR1dqBd2SmK+6aT4pxDkoBReqt7i7Z+8cAlacXo
	GpeDLLcpJrmfxjqKonsEb019W7i8g/EJX06lPzQEPS83mTbNc6LgmaryjqzxlBBq2PKdLk0j5xv
	vOZYSepzfJB1rM=
X-Received: by 2002:a05:6a21:a344:b0:3de:74ee:c04c with SMTP id adf61e73a8af0-3e0bd44ae31mr6706323637.60.1791121152394;
        Sun, 04 Oct 2026 06:39:12 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 40/43] selftests/bpf: tests for varying offset access to PTR_TO_BTF_ID
Date: Sun,  4 Oct 2026 06:38:22 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-40-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
