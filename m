Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CC388E7A
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465734; cv=none; b=q/CNAorqLn1dm9dE+qzYxaEPj7e8I2C68Vv/e3QrRIfLEoFl4oW52J5/1aobrngE9sc9kB/BWCF8kaE39WOYohV0SiW4d3bGWJT/wdYiunLsELqnlpChQ0HBZEJvgvPo3G5/Uv5cypC2GvVXTAYkIAAs5sd096uSSG8JTHUAAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465734; c=relaxed/simple;
	bh=orYbZJ8RVoQeiKThgyzp+0gtZuB0HV/YtXjcc6IQ8/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBYJ4jWILn8isvgIznHmY9qgYzpquYNkQ158r/IFd9/41sgFkmDj3asKaBPbWCj0+vDH5qGIpDYbxVU0TFB32hUjW+N5viU86PB4VUGJZiUbBUYJH36r+TyGEr4NEM4KpbmSokguApuAGqdXTvoKbCjOy03IRhZfG5hcECgNyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9PQHGmx; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9PQHGmx"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4a001db39abso115815e9.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465730; x=1791070530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UHMqiQFjCtPwqP9pY2XiSkzNFE780y+QNflbnd2RVQ=;
        b=r9PQHGmxSUoYg3fNEWiH73PgB9W+YaWCkLIwlmSmkSaX9K5OT0uwoMnILkcRpQ0SI5
         H5kXWHNhR+nsJxMWWbqKA9AsPmSd56mchcP9ZqyxZtxaLLkfUfQauFpBPmT1iBtMNAl2
         p8X3rh4QnR8ouVsg7DAXE+8+8NCAi1WuWftUrXgqUhYonBU5+SZHCLGo2xbNbGlVzpw2
         y5FqI+nM9/szoRfxOEQmHRpHu3vgX2FdgMoKt0r667XY0a/4ZfSLPurfAHKUSEOaVBkF
         rvArBOpeD1ExTgX0CTTT/rDN0RYne0YTJkfZMpC7zF/Gy4bTJFDVKcXFSCLpl6qmobUN
         Drtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465730; x=1791070530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UHMqiQFjCtPwqP9pY2XiSkzNFE780y+QNflbnd2RVQ=;
        b=WkHk5L4yb5l2xHLpbwf1GwF8FQtg+49zwP+0jEv80Ojv3TOmAqlr5BeFwUUWxpw3wJ
         SC1naVbasz4fFIY7BJidf0XZlwpOJuKhEszGW9EjCszbqVCxebnftPLQXq1qEba3a2CC
         bz4usR4Q+0ky1NN5ZGIsG50MwpX0sYcqmv0tGt8e2D1WQLn2IHm/t+o+cjdsLG8KAvvy
         Rlr3O1C0u5N7ZUYVhQZUodyERkeQ+oO/6jdbAIoXcnUqtfpVvDal5SDL6aZXzJ9l1O/o
         xZ3ucwYo2zNxnJas2vifZ0lxD90GnMmIIuundOXEmfjRa7g+SvkUMcaiyGFpwqZbPWre
         WZ7Q==
X-Gm-Message-State: AFuF++mwr/uDIwt9RG90XrDAThBZO/0hDHNF5WDanS3UEgnPhbru5vNF
	h0wB+YA/fj7Szq0yvFkO1oeKANpf7rLhQWABWD8805nrAlfx1Klb08sJf7dBlRlH
X-Gm-Gg: AYBFou0SPcSx6EdH6Y7IlwonIgvlkTgwM0pdedzYiOVaGmeMJbWZcB8UPD/5hVR3xpU
	fKo6MOgXwrr5WL9zioHrc90ELEprGNiTkyr4v7MDhfEX2ZZEWymElalQfihvkoqbSCBob84l4Dw
	MMFD4M/GuaHJik3ls3nRq0B3dESd3a/2wIH2zm1sU/ldbw3Gx2Ui3MZ5E7sOpp4Uk+2rvUF9+t7
	nGJaEVoiXV1MQ/oamROUh7cl7icqluCuiPjSNL0Zqp4EjwyNmTOEAj2asxRr4L0ueKmfcPKnA/E
	BhVSOvNm+XplR0Pvn2/Bh1vbrL7A5dr6lUmrf2W5Fsv2hWQiehmgcvIoP/hCt8g6AgMWTdvS//X
	/SCbW2jDGs59mZ6tEWeYlevOndC+ibHmo/w8yDkIyVJZDLUtTekrPyRP5BRBuy89zMVlwuV7p4D
	xl69FVKjIPznK+YSgMZdFoBKAtN2qSvCyBmLM7LzwRAqzUB2twR79MaSif8B13f/fEC9TFXLFX8
	2qy8y7AuNflP5e15hPnxA8AlST3fyw1tz0vpCA0lVpPGJmP7OnwJOp7FC5pGjnR08VlxeUcUlWU
	MKAMJDssw8wOVKFJw+r+S0OgITt1zEeEawgpRQ==
X-Received: by 2002:a05:600c:4f12:b0:49f:ce78:356b with SMTP id 5b1f17b1804b1-49fe6700d0cmr184417565e9.28.1790465730037;
        Sat, 26 Sep 2026 16:35:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ffd137346sm52585365e9.1.2026.09.26.16.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 14/16] selftests/bpf: Test typed arena object access, kptrs and typed pointer fields
Date: Sun, 27 Sep 2026 01:34:52 +0200
Message-ID: <20260926233503.3114147-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926233503.3114147-1-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18737; i=memxor@gmail.com; h=from:subject; bh=orYbZJ8RVoQeiKThgyzp+0gtZuB0HV/YtXjcc6IQ8/A=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWMKM198i9909xRDKeUTzEINB66up9xeF+uqps/1jf bJGeN/djlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzEnoORYZraU8PGh2sX/me4 I/HoOMPEaWZxs783XrTOOcL7RFXTKYORoZmrf51c8XevqzXOe06kJGffYr2md0ay4JrRnscfZKv VuAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Write and read a scalar field natively on a chunk faulted to scratch, run an
atomic on it, and move the pointer within the object; reject an access
beyond the object, a negative offset and a variable one. Walk a nested
struct and see a pointer to a kernel struct load as a scalar. See helpers
refuse the pointer as memory.

Exchange a kernel kptr into an object and out again, leave a local kptr in a
dummy object for the map to drop, and reject direct loads and stores of a
kptr field, an exchange on a scalar field and one with the wrong type.

Load a typed pointer field and see the pointer stay unsanitized until it is
used as an address: the dereference carries the mask, base load and add in
place, a compare of the value does not, a store of the raw value written by
hand is accepted, a second dereference through the same register does not
sanitize again, and pointer arithmetic sanitizes before it adds. A NULL
dereferences object 0 of the slice, whether held directly or loaded from
the field. The field takes a typed pointer, a loaded pointer or NULL, and
the compiler casts what a program assigns to it, so a scalar and a pointer
to another typed struct are accepted from C and rejected only when stored
by hand; reject a narrow load or store and an atomic. The same member in
raw arena memory is data: a stored pointer loads as a scalar and casts back
to its object where it is used. A struct whose only special field is a
pointer to a typed struct gets a typed arena of its own. One instruction
sanitizes one typed arena: reject it when two paths bring pointers of
different types, or a typed pointer on one path only, and reject the cast
the compiler inserts when one path brings a loaded arena pointer and
another an allocated object.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_typed_arena.c          | 634 ++++++++++++++++++
 1 file changed, 634 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_typed_arena.c b/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
index 22a8c3bfd493..808a65611d4e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_typed_arena.c
@@ -523,6 +523,640 @@ int narrow_store_is_invalid_spill(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__description("a scalar field is written and read natively, on a chunk faulted to scratch")
+__success __retval(7)
+__stderr("ERROR: Typed arena WRITE access to unallocated struct typed_obj at 0x{{[0-9a-f]+}}")
+int access_scalar_field(void *ctx)
+{
+	struct typed_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	obj->value = 7;
+	return obj->value;
+}
+
+SEC("syscall")
+__description("atomics run natively on a scalar field")
+__success __retval(3)
+int access_atomic(void *ctx)
+{
+	struct typed_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	obj->value = 1;
+	__sync_fetch_and_add(&obj->value, 2);
+	return obj->value;
+}
+
+SEC("syscall")
+__description("pointer arithmetic stays inside the object")
+__success __retval(9)
+int access_after_arithmetic(void *ctx)
+{
+	struct typed_obj *obj;
+	void *p;
+
+	arena_bind();
+	obj = ptr;
+	p = obj;
+	asm volatile("%[p] += 8" : [p] "+r"(p));
+	*(__u64 *)p = 9;
+	return obj->value;
+}
+
+SEC("syscall")
+__description("an access beyond the object is rejected")
+__failure __msg("access beyond struct typed_obj")
+int access_beyond_object(void *ctx)
+{
+	struct typed_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	((__u64 *)obj)[2] = 1;
+	return 0;
+}
+
+SEC("syscall")
+__description("a negative offset is rejected")
+__failure __msg("invalid negative access")
+int access_negative_offset(void *ctx)
+{
+	struct typed_obj *obj;
+	void *p;
+
+	arena_bind();
+	obj = ptr;
+	p = (void *)obj - 8;
+	return *(__u64 *)p;
+}
+
+SEC("syscall")
+__description("a variable offset is rejected")
+__failure __msg("{{variable (offset|typed_arena_ptr_ access)}}")
+int access_variable_offset(void *ctx)
+{
+	struct typed_obj *obj;
+	void *p;
+
+	arena_bind();
+	obj = ptr;
+	p = (void *)obj + (bpf_get_prandom_u32() & 8);
+	return *(__u64 *)p;
+}
+
+struct mixed_obj {
+	struct task_struct __kptr *task;
+	struct {
+		__u32 a;
+		__u32 b;
+	} inner;
+	struct task_struct *ptr;
+};
+
+SEC("syscall")
+__description("nested structs are walked and pointers to kernel structs load as scalars")
+__success __retval(3)
+int access_nested_and_kernel_pointer_fields(void *ctx)
+{
+	struct mixed_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	obj->inner.b = 3;
+	if (obj->ptr)
+		return 1;
+	return obj->inner.b;
+}
+
+SEC("syscall")
+__description("helpers do not take typed arena pointers as memory")
+__failure __msg("R1 type=typed_arena_ptr_ expected=")
+int helper_rejects_typed_pointer(void *ctx)
+{
+	struct typed_obj *obj;
+	__u64 src = 0;
+
+	arena_bind();
+	obj = ptr;
+	bpf_probe_read_kernel(&obj->value, sizeof(obj->value), &src);
+	return 0;
+}
+
+struct arena_node {
+	__u64 v;
+};
+
+struct kptr_obj {
+	struct task_struct __kptr *task;
+	struct arena_node __kptr *node;
+	__u64 value;
+};
+
+SEC("syscall")
+__description("a kernel kptr is exchanged into and out of an object")
+__success __retval(0)
+int kptr_xchg_task(void *ctx)
+{
+	struct task_struct *task, *old;
+	struct kptr_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 2;
+	old = bpf_kptr_xchg(&obj->task, task);
+	if (old)
+		bpf_task_release(old);
+	old = bpf_kptr_xchg(&obj->task, NULL);
+	if (!old)
+		return 3;
+	bpf_task_release(old);
+	return 0;
+}
+
+SEC("syscall")
+__description("a local kptr left in a dummy object is dropped with the map")
+__success __retval(0)
+int kptr_xchg_local(void *ctx)
+{
+	struct arena_node *n, *old;
+	struct kptr_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	n = bpf_obj_new(struct arena_node);
+	if (!n)
+		return 2;
+	n->v = 42;
+	old = bpf_kptr_xchg(&obj->node, n);
+	if (old)
+		bpf_obj_drop(old);
+	return 0;
+}
+
+SEC("syscall")
+__description("a kptr field is not read directly")
+__failure __msg("direct access to kptr is disallowed")
+int kptr_read_directly(void *ctx)
+{
+	struct kptr_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	return obj->task != NULL;
+}
+
+SEC("syscall")
+__description("a kptr field is not written directly")
+__failure __msg("direct access to kptr is disallowed")
+int kptr_write_directly(void *ctx)
+{
+	struct kptr_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	obj->task = NULL;
+	return 0;
+}
+
+SEC("syscall")
+__description("an exchange needs a kptr field")
+__failure __msg("off=16 doesn't point to kptr")
+int kptr_xchg_scalar_field(void *ctx)
+{
+	struct kptr_obj *obj;
+
+	arena_bind();
+	obj = ptr;
+	bpf_kptr_xchg(&obj->value, NULL);
+	return 0;
+}
+
+SEC("syscall")
+__description("an exchange checks the value against the field's type")
+__failure __msg("invalid kptr access, R2 type=ptr_arena_node expected=ptr_task_struct")
+int kptr_xchg_wrong_type(void *ctx)
+{
+	struct kptr_obj *obj;
+	struct arena_node *n;
+
+	arena_bind();
+	obj = ptr;
+	n = bpf_obj_new(struct arena_node);
+	if (!n)
+		return 2;
+	n = bpf_kptr_xchg(&obj->task, n);
+	if (n)
+		bpf_obj_drop(n);
+	return 0;
+}
+
+/* 32-byte slot, linked through a typed pointer field: the sanitize mask is 134217696 */
+struct node_obj {
+	struct task_struct __kptr *task;
+	struct node_obj *next;
+	__u64 value;
+};
+
+/* The same layout as node_obj, a different typed arena */
+struct pair_obj {
+	struct task_struct __kptr *task;
+	struct pair_obj *next;
+	__u64 value;
+};
+
+/* 8-byte slot, typed only by its pointer to a typed struct: the cast mask is 134217720 */
+struct head_obj {
+	struct node_obj *first;
+};
+
+SEC("syscall")
+__description("a typed pointer field loads unsanitized, and a dereference sanitizes it in place")
+__success __retval(0) __log_level(2)
+__msg("R{{[0-9]}}=unsanitized_typed_arena_ptr_node_obj(")
+__xlated("r{{[0-9]}} &= 134217720")
+__xlated("r12 = 0x{{[0-9a-f]+}}")
+__xlated("r{{[0-9]}} += r12")
+__xlated("...")
+__xlated("r{{[0-9]}} = *(u64 *)(r{{[0-9]}} +0)")
+__xlated("r{{[0-9]}} &= 134217696")
+__xlated("r12 = 0x{{[0-9a-f]+}}")
+__xlated("r{{[0-9]}} += r12")
+__xlated("r{{[0-9]}} = *(u64 *)(r{{[0-9]}} +16)")
+int ptr_field_deref_sanitizes(void *ctx)
+{
+	struct head_obj *h;
+	struct node_obj *n;
+
+	arena_bind();
+	h = ptr;
+	n = h->first;
+	return n->value;
+}
+
+SEC("syscall")
+__description("a compare and a store of a loaded typed pointer use the raw value")
+__success __retval(0) __log_level(2)
+__msg("R{{[0-9]}}=unsanitized_typed_arena_ptr_node_obj(")
+__msg("if r{{[0-9]}} == 0x0 goto")
+__msg("R{{[0-9]}}=unsanitized_typed_arena_ptr_node_obj(")
+__msg("*(u64 *)(r1 +8) = r2")
+int ptr_field_compare_and_store_stay_raw(void *ctx)
+{
+	struct node_obj *n, *m;
+
+	arena_bind();
+	n = ptr;
+	m = n->next;
+	/* Opaque to the compiler, so that the compare is emitted. */
+	barrier_var(m);
+	if (!m)
+		return 0;
+	/* The store is written by hand: the compiler would cast the value first. */
+	asm volatile("r1 = %[n];"
+		     "r2 = %[m];"
+		     "*(u64 *)(r1 + 8) = r2;"
+		     :: [n] "r"(n), [m] "r"(m)
+		     : "r1", "r2", "memory");
+	return 0;
+}
+
+SEC("syscall")
+__description("a register sanitized by one dereference is not sanitized again by the next")
+__success __retval(5)
+__xlated("r1 = *(u64 *)(r1 +8)")
+__xlated("r2 = 5")
+__xlated("r1 &= 134217696")
+__xlated("r12 = 0x{{[0-9a-f]+}}")
+__xlated("r1 += r12")
+__xlated("*(u64 *)(r1 +16) = r2")
+__xlated("r0 = *(u64 *)(r1 +16)")
+int ptr_field_second_deref_not_sanitized_again(void *ctx)
+{
+	struct node_obj *n;
+	__u64 ret;
+
+	arena_bind();
+	n = ptr;
+	/* Written by hand: the compiler would cast copies rather than reuse the register. */
+	asm volatile("r1 = %[n];"
+		     "r1 = *(u64 *)(r1 + 8);"
+		     "r2 = 5;"
+		     "*(u64 *)(r1 + 16) = r2;"
+		     "r0 = *(u64 *)(r1 + 16);"
+		     "%[ret] = r0;"
+		     : [ret] "=r"(ret) : [n] "r"(n)
+		     : "r0", "r1", "r2", "memory");
+	return ret;
+}
+
+SEC("syscall")
+__description("pointer arithmetic on a loaded typed pointer sanitizes it first")
+__success __retval(0)
+__xlated("r{{[0-9]}} = *(u64 *)(r{{[0-9]}} +8)")
+__xlated("...")
+__xlated("r1 &= 134217696")
+__xlated("r12 = 0x{{[0-9a-f]+}}")
+__xlated("r1 += r12")
+__xlated("r1 += 16")
+__xlated("*(u64 *)(r1 +0) = r2")
+int ptr_field_arithmetic_sanitizes(void *ctx)
+{
+	struct node_obj *n, *m;
+
+	arena_bind();
+	n = ptr;
+	m = n->next;
+	asm volatile("r1 = %[m];"
+		     "r2 = 0;"
+		     "r1 += 16;"
+		     "*(u64 *)(r1 + 0) = r2;"
+		     :: [m] "r"(m)
+		     : "r1", "r2", "memory");
+	return 0;
+}
+
+SEC("syscall")
+__description("a NULL typed pointer dereferences object 0 of the slice, held directly or loaded from a field")
+__success __retval(42)
+int ptr_field_null_lands_on_object_zero(void *ctx)
+{
+	struct node_obj *zero = NULL, *n, *m;
+
+	arena_bind();
+	/*
+	 * The compiler treats a NULL dereference as undefined and would drop
+	 * the store, fold the stored NULL into the load and the load into
+	 * nothing; the barriers keep each value opaque so that the accesses
+	 * are emitted.
+	 */
+	barrier_var(zero);
+	zero->value = 42;
+	n = ptr;
+	n->next = NULL;
+	barrier_var(n);
+	m = n->next;
+	barrier_var(m);
+	return m->value;
+}
+
+SEC("syscall")
+__description("a typed pointer field takes a typed pointer, a loaded one, or NULL")
+__success __retval(0)
+int ptr_field_store_accepted(void *ctx)
+{
+	struct node_obj *n, *m, *p;
+
+	arena_bind();
+	n = ptr;
+	m = ptr2;
+	n->next = m;
+	p = m->next;
+	n->next = p;
+	n->next = NULL;
+	return 0;
+}
+
+SEC("syscall")
+__description("a typed pointer field does not take a scalar")
+__failure __msg("store into typed pointer field of struct node_obj expects a typed arena pointer to struct node_obj or NULL")
+int ptr_field_store_scalar_rejected(void *ctx)
+{
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	/* Written by hand: the compiler would cast the value before the store. */
+	asm volatile("r6 = %[n];"
+		     "call %[bpf_get_prandom_u32];"
+		     "r1 = r6;"
+		     "*(u64 *)(r1 + 8) = r0;"
+		     :: [n] "r"(n), __imm(bpf_get_prandom_u32)
+		     : "r0", "r1", "r2", "r3", "r4", "r5", "r6", "memory");
+	return 0;
+}
+
+SEC("syscall")
+__description("a scalar assigned to a typed pointer field is cast by the compiler first")
+__success __retval(0)
+__xlated("call unknown")
+__xlated("...")
+__xlated("r{{[0-9]}} &= 134217696")
+__xlated("r12 = 0x{{[0-9a-f]+}}")
+__xlated("r{{[0-9]}} += r12")
+__xlated("*(u64 *)(r{{[0-9]}} +8) = r{{[0-9]}}")
+int ptr_field_store_scalar_cast_by_compiler(void *ctx)
+{
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	n->next = (void *)(long)bpf_get_prandom_u32();
+	return 0;
+}
+
+SEC("syscall")
+__description("a typed pointer field does not take a pointer to another typed struct")
+__failure __msg("store into typed pointer field of struct node_obj expects a typed arena pointer to struct node_obj or NULL")
+int ptr_field_store_other_type_rejected(void *ctx)
+{
+	struct typed_obj *other;
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	other = ptr;
+	/* Written by hand: the compiler would re-cast the value to node_obj first. */
+	asm volatile("r1 = %[n];"
+		     "r2 = %[o];"
+		     "*(u64 *)(r1 + 8) = r2;"
+		     :: [n] "r"(n), [o] "r"(other)
+		     : "r1", "r2", "memory");
+	return 0;
+}
+
+SEC("syscall")
+__description("a pointer to another typed struct assigned to a typed pointer field is re-cast by the compiler")
+__success __retval(0)
+int ptr_field_store_other_type_recast(void *ctx)
+{
+	struct typed_obj *other;
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	other = ptr;
+	n->next = (struct node_obj *)other;
+	return n->next == NULL;
+}
+
+SEC("syscall")
+__description("a typed pointer field is loaded whole")
+__failure __msg("typed pointer field of struct node_obj must be accessed with a 64-bit load or store")
+int ptr_field_narrow_load_rejected(void *ctx)
+{
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	asm volatile("r1 = %[n];"
+		     "w2 = *(u32 *)(r1 + 8);"
+		     :: [n] "r"(n)
+		     : "r1", "r2");
+	return 0;
+}
+
+SEC("syscall")
+__description("a typed pointer field is stored whole")
+__failure __msg("typed pointer field of struct node_obj must be accessed with a 64-bit load or store")
+int ptr_field_narrow_store_rejected(void *ctx)
+{
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	asm volatile("r1 = %[n];"
+		     "w2 = 0;"
+		     "*(u32 *)(r1 + 8) = w2;"
+		     :: [n] "r"(n)
+		     : "r1", "r2", "memory");
+	return 0;
+}
+
+SEC("syscall")
+__description("a typed pointer field takes no atomic operation")
+__failure __msg("typed pointer field of struct node_obj")
+int ptr_field_atomic_rejected(void *ctx)
+{
+	struct node_obj *n, *m;
+
+	arena_bind();
+	n = ptr;
+	m = ptr2;
+	__sync_val_compare_and_swap((__u64 *)&n->next, 0, (__u64)m);
+	return 0;
+}
+
+/* The same member outside a typed object is data */
+struct raw_holder {
+	struct node_obj *n;
+	__u64 v;
+};
+
+SEC("syscall")
+__description("a pointer stored in raw arena memory loads as a scalar and casts back to its object")
+__success __retval(0)
+int ptr_field_in_raw_memory_is_scalar(void *ctx)
+{
+	struct raw_holder __arena *h;
+	struct node_obj *n, *again;
+
+	h = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!h)
+		return 1;
+	n = ptr;
+	n->value = 7;
+	h->n = n;
+	again = h->n;
+	return again != n || again->value != 7;
+}
+
+SEC("syscall")
+__description("a struct typed only by a pointer to a typed struct gets a typed arena of its own")
+__success __retval(0) __log_level(2)
+__msg("typed arena for struct head_obj: slot 8 bytes")
+int ptr_field_makes_struct_typed(void *ctx)
+{
+	struct head_obj *h;
+	struct node_obj *n;
+
+	arena_bind();
+	h = ptr;
+	n = ptr2;
+	h->first = n;
+	return h->first != n;
+}
+
+/*
+ * The cast the compiler inserts is one instruction on every path through it:
+ * a loaded typed pointer needs the sanitizing sequence there, an allocated
+ * object needs the identity, and the two cannot share a lowering.
+ */
+SEC("syscall")
+__description("one cast cannot both sanitize an arena pointer and pass an allocated object")
+__failure __msg("casts values that need different treatment on different paths")
+int cast_conflicts_between_arena_and_allocated(void *ctx)
+{
+	struct node_obj *n, *a;
+	struct head_obj *h;
+
+	arena_bind();
+	a = bpf_obj_new(struct node_obj);
+	if (!a)
+		return 1;
+	h = ptr;
+	if (bpf_get_prandom_u32() & 1)
+		n = h->first;
+	else
+		n = a;
+	n->value = 1;
+	bpf_obj_drop(a);
+	return 0;
+}
+
+SEC("syscall")
+__description("one instruction sanitizes one typed arena: two types on two paths are rejected")
+__failure __msg("sanitizes typed arena pointers of different types on different paths")
+int ptr_field_sanitize_two_types_at_one_insn(void *ctx)
+{
+	struct node_obj *n;
+	struct pair_obj *p;
+
+	arena_bind();
+	n = ptr;
+	p = ptr;
+	asm volatile("call %[bpf_get_prandom_u32];"
+		     "if r0 == 0 goto 1f;"
+		     "r1 = %[n];"
+		     "r1 = *(u64 *)(r1 + 8);"
+		     "goto 2f;"
+		     "1: r1 = %[p];"
+		     "r1 = *(u64 *)(r1 + 8);"
+		     "2: r2 = *(u64 *)(r1 + 16);"
+		     :: [n] "r"(n), [p] "r"(p), __imm(bpf_get_prandom_u32)
+		     : "r0", "r1", "r2", "r3", "r4", "r5", "memory");
+	return 0;
+}
+
+SEC("syscall")
+__description("one instruction sanitizes one typed arena: a typed pointer on one path only is rejected")
+__failure __msg("sanitizes a typed arena pointer only on some paths")
+int ptr_field_sanitize_on_one_path(void *ctx)
+{
+	struct node_obj *n;
+
+	arena_bind();
+	n = ptr;
+	asm volatile("r2 = 0;"
+		     "*(u64 *)(r10 - 16) = r2;"
+		     "call %[bpf_get_prandom_u32];"
+		     "if r0 == 0 goto 1f;"
+		     "r1 = %[n];"
+		     "r1 = *(u64 *)(r1 + 8);"
+		     "goto 2f;"
+		     "1: r1 = r10;"
+		     "r1 += -32;"
+		     "2: r2 = *(u64 *)(r1 + 16);"
+		     :: [n] "r"(n), __imm(bpf_get_prandom_u32)
+		     : "r0", "r1", "r2", "r3", "r4", "r5", "memory");
+	return 0;
+}
+
 #endif /* __BPF_FEATURE_TYPED_ARENA_CAST */
 
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

