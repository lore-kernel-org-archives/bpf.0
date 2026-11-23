Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473158;
	b=2quWTRqC5RTKg6fu9dbQ0iNbTxbF9/g3/G5On916bLWdQjy9CFMWdkEGTQNayptlEkKy
	 BdOUrUrM3j4qjrQGJP6+BQBt/Ics7+iI5o28XGZGpKQ9meuArjbvI5fhB2S3IwKBirZhK
	 xJXvNfqQjzb99xNqEy+j0fb6Td0aPV+XgNr0QArOEv7Yy4K1t1JfGHkVhJ2oOZ+RXCSu4
	 gDvLIKXz4Z44xJzZLPfewCID4OKtRAIo/Mum49ZY9uQi9NDkZhepfPFNbxsW3rRApf1Js
	 MAD8WCRYq2n8JRaLL720fFFmd7iYIrpEhzTeiteUJg47nbBxAx20RlLX2czfqqMXI2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WaJO9Zo4rugtxfBJLot4OIoCOW1C7dCQ+LLsrLiopH0=;
	b=K5Lc6ll5dOfFvn3PU8z1TRqi+6Hk2LAcb3PqrVjt8+GqlNT7TLYE8B6KV4LhdlYPqPXZ
	 2IN+rvWE+ayjFPjdPxyjYAQ6IV03esGniKh2ZtOqOMLxblujQFnHlkAVBs26eh9/vd3rn
	 grKHvlEUIxsVeLkasxMOFxFtTu99CuzsQGfGCbG+g1Hielj+wF9Ktd7ZEx1pay1eegYCC
	 OAC/XV1qIc5bWEIhOVGUixT98Uxvn70VfIgpxsBiIpEfQEpJv28japwBY8PLB2XVzOLjU
	 ryEGLSZCAnxuabkoaq1pLx+o/n0AyxfYqalYLQMzBXAi5WOyoDU70OFAPlae2i/upwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF8DEJhn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA62A606A32D
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF8DEJhn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A761F000D1;
	Mon, 23 Nov 2026 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473157;
	bh=WaJO9Zo4rugtxfBJLot4OIoCOW1C7dCQ+LLsrLiopH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FF8DEJhnr5dKYwY0IBlSsVzER4NtD/cFeNnEjuyFbRSk6DvX6YVNHjRRozoKrImKi
	 LFBKGQSMTX+kh2ZWZGHm7Kl2ewsv+QJVCqVUT6w91x8k2IO01Gu7+E/jcuaao+GMAs
	 oZqJKo7nfjDbolEh4Y8OEILGC3s5zPpb0xy1WwTwJxstE7U/5Ify2NDz+0Tf92vSPO
	 tjwgj+2Po8oBVQSBAsnKtKKzlfaDFyMOUcz2JvIblgXD6oawk4p1Mm2EX0DAojOUUt
	 9xtqkSk8M8qA1EhgjKYA/tI0+HaxSQsS1smLusuEVCmXlUYUdDshwr/1+qE4AVUEic
	 lGiIiUKiZJ76Q==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next 1/7] libbpf: Support CO-RE relocation of tracing program arguments
Date: Mon, 23 Nov 2026 22:32:21 +0000
Message-ID: <20261123223227.745345-2-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123223227.745345-1-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
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

BPF_PROG() and friends access the arguments of fentry/fexit/tp_btf/LSM
programs by fixed position in the u64 context array. When a traced
function or tracepoint gains, loses or reorders parameters, programs
silently read the wrong argument (or fail verification), and there is
no way to check whether a given argument exists.

Provide a CO-RE-like experience for these arguments instead. A struct
marked __bpf_func_args (preserve_access_index plus a "bpf_func_args"
decl tag) describes the arguments of interest, with members named after
the target's parameters, in any order:

	struct my_args {
		struct filename *name;
		int dfd;
		int ret __bpf_func_ret;
	} __bpf_func_args;

	SEC("fexit/filename_unlinkat")
	int prog(struct my_args *args)
	{
		if (bpf_core_field_exists(args->dfd))
			...
	}

Clang emits field-based CO-RE relocations directly on the context loads.
For such structs, rather than searching for same-named target types, the
single CO-RE candidate is the program's attach target FUNC, flagged as a
function arguments candidate. Typedefs and modifiers are skipped when
looking for the tag, as clang uses the typedef as the root type of
relocations against typedef'd anonymous structs. relo_core then matches
the struct's members by essential name (ignoring ___flavor suffixes)
against the FUNC's parameters, placing each at its context slot as laid
out by the kernel's btf_ctx_arg_idx() (by-value structs > 8 bytes take
multiple slots), with the parameter's type. A member tagged
__bpf_func_ret maps to the return value slot for fexit-like programs.
Everything else (offset patching, bpf_core_field_exists(), type
compatibility checks and poisoning of unguarded accesses) works
unchanged, and nested accesses into by-value struct arguments continue
as normal member matching.

Parameter type changes are handled by CO-RE's usual field compatibility
rules, applied between each member and its parameter, plus a stricter
check for pointers:

- a member of a different kind than its parameter (e.g. integer vs
  pointer, integer vs enum, scalar vs struct) doesn't match, so the
  argument appears to be missing: bpf_core_field_exists() returns 0 and
  unguarded accesses fail to load;
- integers match regardless of size and signedness; when an unsigned
  integer changes size, the load size is adjusted and the value is read
  correctly, while a size change involving signed integers poisons the
  load (it exists, but can't be read correctly), as for struct fields;
- enums match if their essential names do; structs passed by value
  always match, with accesses to their members relocated as usual;
- unlike struct fields, where any two pointers are compatible, pointer
  arguments only match if the pointed-to types (ignoring typedefs and
  modifiers) are compatible: structs, unions and enums need the same
  kind and essential name (forward declarations matching structs and
  unions), integers the same size and other types the same kind,
  recursing through multi-level pointers, with void * on either side
  matching any pointer. Otherwise, a parameter changing from, e.g.,
  struct file * to struct inode * would silently have accesses through
  it relocated against the wrong type. Instead such an argument is seen
  as missing, and ___flavor members can describe both variants:

	struct my_args {
		struct vm_area_struct *vma;
		struct mm_area *vma___new;
	} __bpf_func_args;

btf_trace_xxx prototypes carry no parameter names, so for tp_btf
programs the candidate is the identically-typed __probestub_xxx()
function (Linux 6.5+) or, failing that, __traceiter_xxx() (Linux 5.10+),
ignoring its first ("void *__data") parameter. On older kernels, which
have neither, there is no candidate: the program still loads, with all
arguments appearing to be missing, rather than failing to load.

The matching lives in relo_core.c, which is shared with the kernel, so
that kernel-side CO-RE (used by light skeletons) can support it too.

BPF_PROG_CORE() wraps this in a BPF_PROG2()-like interface, declaring
the arguments struct from (type, name) pairs and passing the arguments
to the program body as typed variables:

	SEC("fexit/filename_unlinkat")
	int BPF_PROG_CORE(prog, struct filename *, name, int, dfd,
			  __bpf_func_ret int, ret)

Arguments that don't exist in the target read as zero, and
bpf_func_arg_exists() tells whether they exist. Structs larger than 8
bytes passed by value can't be copied out of the context as a whole, so
they need an explicit __bpf_func_args struct instead. The zero value of a
missing argument is hidden from the compiler, as otherwise GCC can prove
that, e.g., dereferencing a missing pointer argument is a NULL dereference
and replace that dead code path with a call to abort(), which can't be
linked.

GCC doesn't support BTF decl tags on types (it warns that the attribute
doesn't apply to types, which builds with -Wno-attributes don't show),
so with GCC a struct-level "bpf_func_args" tag would silently be dropped
and all arguments would appear to be missing. Hence also recognize the
tag on a member of the struct, which both compilers support, and provide
__bpf_func_args_marker, a zero-sized member carrying it. BPF_PROG_CORE()
always uses the marker, so it works the same with clang and GCC, while
structs declared explicitly need the marker for GCC; with GCC,
__bpf_func_args only applies preserve_access_index, to avoid the warning.

With libbpf applying relocations, accesses must be made from the entry
program (or inlined code), since a shared subprogram has no single
attach target. BPF program targets (freplace, fentry on BPF progs) and
multi-attach programs are rejected explicitly. On big-endian targets
sub-8-byte arguments, including structs and unions passed by value
(which, e.g., s390 passes in registers like integers of the same
size), are placed at the correct offset within their slot, but the
verifier currently only allows 8-byte-aligned context accesses for
these programs. Loads of integer and enum arguments (and return values)
are therefore widened to 8-byte loads of their whole slot: the calling
conventions of the big-endian architectures with BPF trampolines
(s390x, powerpc64) extend these to 64 bits, so that this yields what
the original load would for zero-extending loads of unsigned and
sign-extending loads of signed arguments, as BPF_PROG()'s conversion
from the slot's value does. Other loads of such arguments are poisoned,
and other accesses (including to members of structs passed by value)
fail to load, rather than reading the wrong bytes.

This is a significant limitation on big-endian targets: signed integer
arguments and return values smaller than 8 bytes, such as int, can
generally not be read there. Compilers use zero-extending loads for
them, unless the value is converted to a wider type when building with
-mcpu=v4 or later, and BPF_PROG_CORE() always loads arguments into
variables of their own type, so it can't be used with such arguments at
all. Programs reading them fail to load and need to use BPF_PROG() or
BPF_PROG2() instead. Lifting this requires the verifier to allow narrow
loads at the offset of such arguments within their slot.

Signed-off-by: Alan Maguire <almagui@kernel.org>
Assisted-by: LLM
---
 tools/lib/bpf/bpf_tracing.h | 176 ++++++++++++++
 tools/lib/bpf/libbpf.c      | 142 +++++++++++-
 tools/lib/bpf/relo_core.c   | 451 +++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/relo_core.h   |  29 +++
 4 files changed, 789 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index dbe32a5d02cd..24182b48fa4d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -654,6 +654,77 @@ struct pt_regs;
 #define ___bpf_ctx_cast12(x, args...) ___bpf_ctx_cast11(args), ctx[11]
 #define ___bpf_ctx_cast(args...)      ___bpf_apply(___bpf_ctx_cast, ___bpf_narg(args))(args)
 
+/*
+ * __bpf_func_args marks a struct describing (a subset of) the arguments of
+ * the attach target of a tp_btf/fentry/fexit/fmod_ret/LSM program, giving a
+ * CO-RE-relocatable alternative to BPF_PROG()'s fixed argument positions.
+ * Members are matched to the target's parameters by name (ignoring any
+ * ___flavor suffix) when the program is loaded, regardless of their order or
+ * position in the struct, so an argument being added, removed or reordered
+ * in the target function doesn't break the program. A member marked with
+ * __bpf_func_ret refers to the return value (for fexit-like programs).
+ *
+ * The program takes a pointer to such a struct as its context and uses
+ * plain member accesses; members that have no match in the target can be
+ * checked for with bpf_core_field_exists(). The usual CO-RE field
+ * compatibility rules apply between member and parameter types, except that
+ * pointers only match if the types they point to (ignoring typedefs and
+ * qualifiers) are compatible: structs, unions and enums need the same kind
+ * and name (forward declarations match structs and unions), integers the
+ * same size and other types the same kind, recursing through pointers to
+ * pointers, while void pointers match any pointer. A parameter changing to
+ * point to a different type thus appears as missing; ___flavor members can
+ * describe the different variants. For example:
+ *
+ *	struct my_args {
+ *		struct filename *name;
+ *		int dfd;
+ *		int ret __bpf_func_ret;
+ *	} __bpf_func_args;
+ *
+ *	SEC("fexit/filename_unlinkat")
+ *	int handle(struct my_args *args)
+ *	{
+ *		if (bpf_core_field_exists(args->dfd))
+ *			bpf_printk("dfd %d", args->dfd);
+ *		bpf_printk("%s: %d", BPF_CORE_READ(args->name, name), args->ret);
+ *		return 0;
+ *	}
+ *
+ * Accesses have to be made from the program itself (or __always_inline
+ * functions), not from subprograms. Compilers may access members of struct
+ * arguments passed by value by adding a (relocated) offset to the context
+ * pointer, which the verifier only accepts since Linux 7.1.
+ *
+ * On big-endian architectures (e.g., s390x), the verifier only allows loads
+ * of whole 8-byte context slots, so loads of integer and enum arguments (and
+ * return values) smaller than 8 bytes are widened to their slot. That only
+ * yields the right value for zero-extending loads of unsigned and
+ * sign-extending loads of signed arguments; other loads make the program
+ * fail to load. As compilers only use sign-extending loads when the value is
+ * converted to a wider type, and only with -mcpu=v4 or later, signed
+ * arguments smaller than 8 bytes, such as int, generally can't be read there;
+ * use BPF_PROG() or BPF_PROG2() for them instead.
+ *
+ * GCC doesn't support BTF decl tags on types, so with GCC the struct also
+ * needs to contain __bpf_func_args_marker, a zero-sized member carrying the
+ * tag instead; structs having both work with either compiler:
+ *
+ *	struct my_args {
+ *		__bpf_func_args_marker;
+ *		struct filename *name;
+ *		...
+ *	} __bpf_func_args;
+ */
+#if defined(__clang__)
+#define __bpf_func_args __attribute__((preserve_access_index, btf_decl_tag("bpf_func_args")))
+#else
+#define __bpf_func_args __attribute__((preserve_access_index))
+#endif
+#define __bpf_func_args_marker \
+	char ___bpf_func_args[0] __attribute__((btf_decl_tag("bpf_func_args")))
+#define __bpf_func_ret __attribute__((btf_decl_tag("bpf_func_ret")))
+
 /*
  * BPF_PROG is a convenience wrapper for generic tp_btf/fentry/fexit and
  * similar kinds of BPF programs, that accept input arguments as a single
@@ -790,6 +861,111 @@ typeof(name(0)) name(unsigned long long *ctx)					\
 static __always_inline typeof(name(0))						\
 ____##name(unsigned long long *ctx ___bpf_ctx_decl(args))
 
+#define ___bpf_core_mem0()
+#define ___bpf_core_mem1(t, x)			t x;
+#define ___bpf_core_mem2(t, x, args...)	t x; ___bpf_core_mem1(args)
+#define ___bpf_core_mem3(t, x, args...)	t x; ___bpf_core_mem2(args)
+#define ___bpf_core_mem4(t, x, args...)	t x; ___bpf_core_mem3(args)
+#define ___bpf_core_mem5(t, x, args...)	t x; ___bpf_core_mem4(args)
+#define ___bpf_core_mem6(t, x, args...)	t x; ___bpf_core_mem5(args)
+#define ___bpf_core_mem7(t, x, args...)	t x; ___bpf_core_mem6(args)
+#define ___bpf_core_mem8(t, x, args...)	t x; ___bpf_core_mem7(args)
+#define ___bpf_core_mem9(t, x, args...)	t x; ___bpf_core_mem8(args)
+#define ___bpf_core_mem10(t, x, args...)	t x; ___bpf_core_mem9(args)
+#define ___bpf_core_mem11(t, x, args...)	t x; ___bpf_core_mem10(args)
+#define ___bpf_core_mem12(t, x, args...)	t x; ___bpf_core_mem11(args)
+#define ___bpf_core_mem(args...)	___bpf_apply(___bpf_core_mem, ___bpf_narg2(args))(args)
+
+#define ___bpf_core_ld0()
+#define ___bpf_core_ld1(t, x)			, ___bpf_core_arg(x)
+#define ___bpf_core_ld2(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld1(args)
+#define ___bpf_core_ld3(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld2(args)
+#define ___bpf_core_ld4(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld3(args)
+#define ___bpf_core_ld5(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld4(args)
+#define ___bpf_core_ld6(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld5(args)
+#define ___bpf_core_ld7(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld6(args)
+#define ___bpf_core_ld8(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld7(args)
+#define ___bpf_core_ld9(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld8(args)
+#define ___bpf_core_ld10(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld9(args)
+#define ___bpf_core_ld11(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld10(args)
+#define ___bpf_core_ld12(t, x, args...)	, ___bpf_core_arg(x) ___bpf_core_ld11(args)
+#define ___bpf_core_ld(args...)		___bpf_apply(___bpf_core_ld, ___bpf_narg2(args))(args)
+
+/* 2 == BPF_FIELD_EXISTS from bpf_core_read.h */
+#define ___bpf_core_arg_exists(p, x)	__builtin_preserve_field_info((p)->x, 2)
+
+/*
+ * Missing arguments read as zero. The zero is hidden from the compiler, as
+ * otherwise it could prove that, e.g., dereferencing a missing pointer
+ * argument is a NULL dereference and replace that (dead) code path with a
+ * trap, which GCC turns into a call to abort() that can't be linked.
+ */
+#define ___bpf_core_arg(x) ({						    \
+	typeof(___args->x) ___v;					    \
+	_Static_assert(sizeof(___v) <= sizeof(unsigned long),		    \
+		       "BPF_PROG_CORE() arguments can't be larger than 8 bytes"); \
+	if (___bpf_core_arg_exists(___args, x)) {			    \
+		___v = ___args->x;					    \
+	} else {							    \
+		unsigned long ___zero = 0;				    \
+									    \
+		asm volatile("" : "+r"(___zero));			    \
+		__builtin_memcpy(&___v, &___zero, sizeof(___v));	    \
+	}								    \
+	___v;								    \
+})
+
+/*
+ * BPF_PROG_CORE is a CO-RE-relocatable variant of BPF_PROG2: arguments are
+ * specified as (type, name) pairs naming (a subset of) the parameters of the
+ * attach target, in any order, and are matched to the target's parameters by
+ * name when the program is loaded (see __bpf_func_args; BPF_PROG_CORE
+ * declares such a struct internally, using __bpf_func_args_marker so that it
+ * works with both clang and GCC). Specifying __bpf_func_ret as part of the
+ * type of an argument makes it refer to the return value instead.
+ *
+ * Arguments that don't exist in the target (or whose type isn't compatible)
+ * read as zero; bpf_func_arg_exists() tells whether an argument exists.
+ * Within the program, 'ctx' points to the arguments struct.
+ *
+ *	SEC("fexit/filename_unlinkat")
+ *	int BPF_PROG_CORE(handle, struct filename *, name, int, dfd,
+ *			  __bpf_func_ret int, ret)
+ *	{
+ *		if (bpf_func_arg_exists(dfd))
+ *			bpf_printk("dfd %d", dfd);
+ *		...
+ *	}
+ *
+ * Structs passed by value that are larger than 8 bytes can't be copied out
+ * of the program context as a whole, so they can't be used as arguments of
+ * BPF_PROG_CORE; use an explicit __bpf_func_args struct and access their
+ * members individually instead.
+ *
+ * On big-endian architectures, signed integer and enum arguments (and return
+ * values) smaller than 8 bytes can't be used either, as they are loaded into
+ * variables of their own type with zero-extending loads, which can't be
+ * relocated there (see __bpf_func_args); use BPF_PROG() or BPF_PROG2().
+ */
+#define BPF_PROG_CORE(name, args...)					    \
+name(void *ctx);							    \
+struct ___##name##_args {						    \
+	__bpf_func_args_marker;						    \
+	___bpf_core_mem(args)						    \
+} __attribute__((preserve_access_index));				    \
+static __always_inline typeof(name(0))					    \
+____##name(struct ___##name##_args *ctx ___bpf_ctx_decl(args));		    \
+typeof(name(0)) name(void *ctx)						    \
+{									    \
+	struct ___##name##_args *___args = ctx;				    \
+									    \
+	return ____##name(___args ___bpf_core_ld(args));			    \
+}									    \
+static __always_inline typeof(name(0))					    \
+____##name(struct ___##name##_args *ctx ___bpf_ctx_decl(args))
+
+#define bpf_func_arg_exists(x)		___bpf_core_arg_exists(ctx, x)
+
 struct pt_regs;
 
 #define ___bpf_kprobe_args0()           ctx
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..82408e3eafc4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5990,6 +5990,7 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 		cand = &new_cands[cands->len];
 		cand->btf = targ_btf;
 		cand->id = i;
+		cand->flags = 0;
 
 		cands->cands = new_cands;
 		cands->len++;
@@ -6256,11 +6257,134 @@ static const struct bpf_core_relo *find_relo_core(struct bpf_program *prog, int
 	return NULL;
 }
 
+static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
+			      enum bpf_attach_type attach_type,
+			      int *btf_obj_fd, int *btf_type_id);
+
+/* Single-entry cache of the CO-RE candidate for function argument structs
+ * (see __bpf_func_args) of a given program, i.e., of its attach target.
+ */
+struct bpf_core_args_cache {
+	const struct bpf_program *prog;
+	struct bpf_core_cand cand;
+	/* 0 if the attach target has no named parameters */
+	int nr_cands;
+	struct bpf_core_cand_list cands;
+};
+
+/* Find the BTF type of the attach target of a BTF-attached tracing program */
+static int bpf_prog_attach_target(const struct bpf_program *prog,
+				  const struct btf **btf, __u32 *btf_id)
+{
+	struct bpf_object *obj = prog->obj;
+	int btf_obj_fd = 0, btf_type_id = 0, i, err;
+
+	if (prog->attach_prog_fd) {
+		pr_warn("prog '%s': function argument relocations are not supported for BPF program targets\n",
+			prog->name);
+		return -EOPNOTSUPP;
+	}
+
+	if (prog->attach_btf_id) {
+		/* set via bpf_program__set_attach_target() */
+		btf_obj_fd = prog->attach_btf_obj_fd;
+		btf_type_id = prog->attach_btf_id;
+	} else {
+		const char *attach_name = strchr(prog->sec_name, '/');
+
+		if (!prog->sec_def || !(prog->sec_def->cookie & SEC_ATTACH_BTF) || !attach_name) {
+			pr_warn("prog '%s': function argument relocations require a BTF attach target\n",
+				prog->name);
+			return -EINVAL;
+		}
+		err = find_kernel_btf_id(obj, attach_name + 1, prog->expected_attach_type,
+					 &btf_obj_fd, &btf_type_id);
+		if (err) {
+			pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
+				prog->name, attach_name + 1, errstr(err));
+			return err;
+		}
+	}
+
+	*btf = NULL;
+	if (!btf_obj_fd) {
+		*btf = obj->btf_vmlinux;
+	} else {
+		for (i = 0; i < obj->btf_module_cnt; i++) {
+			if (obj->btf_modules[i].fd == btf_obj_fd) {
+				*btf = obj->btf_modules[i].btf;
+				break;
+			}
+		}
+	}
+	if (!*btf)
+		return -ESRCH;
+	*btf_id = btf_type_id;
+	return 0;
+}
+
+static struct bpf_core_cand_list *
+bpf_core_args_find_cands(const struct bpf_program *prog, struct bpf_core_args_cache *cache)
+{
+	const struct btf *btf;
+	__u32 btf_id;
+	int err;
+
+	if (cache->prog == prog)
+		goto out;
+	cache->prog = NULL;
+
+	/* there is no single attach target to relocate against in (shared)
+	 * subprograms; accesses need to be in the entry prog itself (or in
+	 * __always_inline functions)
+	 */
+	if (prog_is_subprog(prog->obj, prog)) {
+		pr_warn("prog '%s': function argument relocations are only supported in entry programs\n",
+			prog->name);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+	if (prog->type != BPF_PROG_TYPE_TRACING && prog->type != BPF_PROG_TYPE_LSM) {
+		pr_warn("prog '%s': function argument relocations are not supported for this program type\n",
+			prog->name);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	err = bpf_prog_attach_target(prog, &btf, &btf_id);
+	if (err)
+		return ERR_PTR(err);
+
+	err = bpf_core_func_args_cand(btf, btf_id, prog->expected_attach_type, &cache->cand);
+	if (err == -ENOENT) {
+		/* tracepoints on old kernels have no function with named
+		 * parameters to match against; rather than failing to load,
+		 * leave all arguments without a match, so that they appear
+		 * to be missing (and the struct, to bpf_core_type_exists(),
+		 * to be unsupported)
+		 */
+		pr_warn("prog '%s': attach target [%u] has no parameter names, function arguments will appear to be missing\n",
+			prog->name, btf_id);
+		cache->nr_cands = 0;
+	} else if (err) {
+		pr_warn("prog '%s': can't relocate function arguments against attach target [%u]: %s\n",
+			prog->name, btf_id, errstr(err));
+		return ERR_PTR(err);
+	} else {
+		cache->nr_cands = 1;
+	}
+	cache->prog = prog;
+out:
+	/* bpf_core_calc_relo_insn() may shrink the list, so (re)set it */
+	cache->cands.cands = &cache->cand;
+	cache->cands.len = cache->nr_cands;
+	return &cache->cands;
+}
+
 static int bpf_core_resolve_relo(struct bpf_program *prog,
 				 const struct bpf_core_relo *relo,
 				 int relo_idx,
 				 const struct btf *local_btf,
 				 struct hashmap *cand_cache,
+				 struct bpf_core_args_cache *args_cache,
 				 struct bpf_core_relo_res *targ_res)
 {
 	struct bpf_core_spec specs_scratch[3] = {};
@@ -6280,7 +6404,19 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 		return -EINVAL;
 
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
-	    !hashmap__find(cand_cache, local_id, &cands)) {
+	    !hashmap__find(cand_cache, local_id, &cands) &&
+	    bpf_core_is_func_args_type(local_btf, local_id)) {
+		/* candidate depends on the program's attach target, so it
+		 * can't go into the object-wide candidate cache
+		 */
+		cands = bpf_core_args_find_cands(prog, args_cache);
+		if (IS_ERR(cands)) {
+			pr_warn("prog '%s': relo #%d: failed to resolve function arguments for [%u] %s %s: %ld\n",
+				prog_name, relo_idx, local_id, btf_kind_str(local_type),
+				local_name, PTR_ERR(cands));
+			return PTR_ERR(cands);
+		}
+	} else if (relo->kind != BPF_CORE_TYPE_ID_LOCAL && !cands) {
 		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
 		if (IS_ERR(cands)) {
 			pr_warn("prog '%s': relo #%d: target candidate search failed for [%u] %s %s: %ld\n",
@@ -6307,6 +6443,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	const struct bpf_core_relo *rec;
 	const struct btf_ext_info *seg;
 	struct hashmap_entry *entry;
+	struct bpf_core_args_cache args_cache = {};
 	struct hashmap *cand_cache = NULL;
 	struct bpf_program *prog;
 	struct bpf_insn *insn;
@@ -6400,7 +6537,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			if (prog->obj->gen_loader)
 				continue;
 
-			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
+			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache,
+						    &args_cache, &targ_res);
 			if (err) {
 				pr_warn("prog '%s': relo #%d: failed to relocate: %s\n",
 					prog->name, i, errstr(err));
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623a4198..2f6627952220 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -41,6 +41,21 @@ static s64 btf__resolve_size(const struct btf *btf, u32 type_id)
 	return size;
 }
 
+static u32 btf__type_cnt(const struct btf *btf)
+{
+	return btf_nr_types(btf);
+}
+
+static s32 btf__find_by_name_kind(const struct btf *btf, const char *name, u32 kind)
+{
+	return btf_find_by_name_kind(btf, name, kind);
+}
+
+static bool btf_is_big_endian(const struct btf *btf)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+}
+
 enum libbpf_print_level {
 	LIBBPF_WARN,
 	LIBBPF_INFO,
@@ -65,6 +80,11 @@ enum libbpf_print_level {
 #include "bpf.h"
 #include "btf.h"
 #include "libbpf_internal.h"
+
+static bool btf_is_big_endian(const struct btf *btf)
+{
+	return btf__endianness(btf) == BTF_BIG_ENDIAN;
+}
 #endif
 
 static bool is_flex_arr(const struct btf *btf,
@@ -463,6 +483,319 @@ static int bpf_core_fields_are_compat(const struct btf *local_btf,
 	}
 }
 
+static bool btf_has_decl_tag(const struct btf *btf, __u32 type_id, int comp_idx,
+			     const char *tag)
+{
+	__u32 i, n = btf__type_cnt(btf);
+	const struct btf_type *t;
+
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(btf, i);
+		if (btf_kind(t) != BTF_KIND_DECL_TAG || t->type != type_id ||
+		    btf_decl_tag(t)->component_idx != comp_idx)
+			continue;
+		if (strcmp(btf__name_by_offset(btf, t->name_off), tag) == 0)
+			return true;
+	}
+	return false;
+}
+
+/* A struct tagged with btf_decl_tag("bpf_func_args") describes (a subset of)
+ * the arguments of the attach target of a tracing program; its members are
+ * matched by name against the target's parameters rather than against
+ * members of same-named target types. The tag can be on the struct itself or,
+ * for compilers that don't support decl tags on types (e.g., GCC), on one of
+ * its members (see __bpf_func_args_marker). The type may refer to the struct
+ * through typedefs and modifiers, e.g., as the root type of relocations
+ * against a typedef'd anonymous struct.
+ */
+bool bpf_core_is_func_args_type(const struct btf *btf, __u32 type_id)
+{
+	__u32 i, n = btf__type_cnt(btf);
+	const struct btf_type *t;
+
+	t = skip_mods_and_typedefs(btf, type_id, &type_id);
+	if (!t || btf_kind(t) != BTF_KIND_STRUCT)
+		return false;
+
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(btf, i);
+		if (btf_kind(t) == BTF_KIND_DECL_TAG && t->type == type_id &&
+		    strcmp(btf__name_by_offset(btf, t->name_off), BPF_CORE_FUNC_ARGS_TAG) == 0)
+			return true;
+	}
+	return false;
+}
+
+#define BTF_TRACE_PFX		"btf_trace_"
+#define BTF_PROBESTUB_PFX	"__probestub_"
+#define BTF_TRACEITER_PFX	"__traceiter_"
+
+static int find_tp_func(const struct btf *btf, const char *pfx, const char *tp_name)
+{
+	char func_name[128];
+
+	if (snprintf(func_name, sizeof(func_name), "%s%s", pfx, tp_name) >= sizeof(func_name))
+		return -ENAMETOOLONG;
+	return btf__find_by_name_kind(btf, func_name, BTF_KIND_FUNC);
+}
+
+/* Construct the CO-RE candidate for function argument structs of programs
+ * attached to attach_btf_id in btf, with the given attach type. Returns
+ * -ENOENT if the attach target is a tracepoint without a function having its
+ * parameters (with names) in btf, i.e., on kernels before Linux 5.10.
+ */
+int bpf_core_func_args_cand(const struct btf *btf, __u32 attach_btf_id,
+			    enum bpf_attach_type attach_type,
+			    struct bpf_core_cand *cand)
+{
+	const struct btf_type *t, *proto;
+	__u32 flags = BPF_CORE_CAND_FUNC_ARGS;
+	__u32 id = attach_btf_id;
+
+	switch (attach_type) {
+	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_FSESSION:
+	case BPF_MODIFY_RETURN:
+	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
+		flags |= BPF_CORE_CAND_RETVAL;
+		break;
+	case BPF_TRACE_FENTRY:
+		break;
+	case BPF_TRACE_RAW_TP:
+		flags |= BPF_CORE_CAND_SKIP_FIRST;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	t = btf_type_by_id(btf, id);
+	if (!t)
+		return -EINVAL;
+	/* the btf_trace_xxx typedef's FUNC_PROTO has no parameter names, but
+	 * __probestub_xxx(void *__data, proto) (since Linux 6.5) and
+	 * __traceiter_xxx(void *__data, proto) (since Linux 5.10) have the
+	 * same parameters, with names; only the parameters are used, as there
+	 * is no return value in the context of raw tracepoint programs
+	 */
+	if (btf_kind(t) == BTF_KIND_TYPEDEF) {
+		const char *name = btf__name_by_offset(btf, t->name_off);
+		size_t pfx_len = sizeof(BTF_TRACE_PFX) - 1;
+		int func_id;
+
+		if (!name || strncmp(name, BTF_TRACE_PFX, pfx_len) != 0)
+			return -EINVAL;
+		func_id = find_tp_func(btf, BTF_PROBESTUB_PFX, name + pfx_len);
+		if (func_id == -ENOENT)
+			func_id = find_tp_func(btf, BTF_TRACEITER_PFX, name + pfx_len);
+		if (func_id < 0)
+			return func_id;
+		id = func_id;
+		t = btf_type_by_id(btf, id);
+	}
+	if (btf_kind(t) != BTF_KIND_FUNC)
+		return -EINVAL;
+	proto = btf_type_by_id(btf, t->type);
+	if (!proto || btf_kind(proto) != BTF_KIND_FUNC_PROTO)
+		return -EINVAL;
+	if ((flags & BPF_CORE_CAND_SKIP_FIRST) && btf_vlen(proto) < 1)
+		return -EINVAL;
+
+	cand->btf = btf;
+	cand->id = id;
+	cand->flags = flags;
+	return 0;
+}
+
+/* Size of the program context slot(s) taken by a value of the given type;
+ * mirrors btf_ctx_arg_idx() in the kernel.
+ */
+static int func_arg_slot_sz(const struct btf *btf, __u32 type_id)
+{
+	const struct btf_type *t = skip_mods_and_typedefs(btf, type_id, NULL);
+	__s64 sz;
+
+	if (!t)
+		return -EINVAL;
+	if (btf_is_ptr(t))
+		return 8;
+	sz = btf__resolve_size(btf, type_id);
+	if (sz < 0)
+		return sz;
+	return (sz + 7) / 8 * 8;
+}
+
+/* Type of parameter idx of a FUNC, or of its return value if idx is one
+ * past the last parameter.
+ */
+static __u32 func_arg_type(const struct btf *btf, const struct btf_type *func, __u32 idx)
+{
+	const struct btf_type *proto = btf_type_by_id(btf, func->type);
+
+	return idx < btf_vlen(proto) ? btf_params(proto)[idx].type : proto->type;
+}
+
+/* Stricter compatibility check for pointer arguments than the one CO-RE
+ * applies to fields, where any two pointers are compatible: after skipping
+ * typedefs and modifiers, the types pointed to need to be structs, unions or
+ * enums of the same kind and essential name (forward declarations matching
+ * structs and unions, enums matching 64-bit enums), integers of the same
+ * size, or other types of the same kind, recursing through pointers to
+ * pointers, so that a parameter changing to point to a different type is seen
+ * as a missing argument (and different ___flavor members can describe
+ * different pointer types). void pointers on either side act as wildcards.
+ */
+static int bpf_core_func_arg_ptr_compat(const struct btf *local_btf, __u32 local_id,
+					const struct btf *targ_btf, __u32 targ_id)
+{
+	const struct btf_type *local_t, *targ_t;
+	const char *local_name, *targ_name;
+	size_t local_len, targ_len;
+	int depth = 32;
+
+	local_t = skip_mods_and_typedefs(local_btf, local_id, &local_id);
+	targ_t = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
+	if (!local_t || !targ_t)
+		return -EINVAL;
+	if (!btf_is_ptr(local_t) || !btf_is_ptr(targ_t))
+		return 1;
+
+	while (btf_is_ptr(local_t) && btf_is_ptr(targ_t)) {
+		if (--depth < 0)
+			return -EINVAL;
+		local_t = skip_mods_and_typedefs(local_btf, local_t->type, &local_id);
+		targ_t = skip_mods_and_typedefs(targ_btf, targ_t->type, &targ_id);
+		if (!local_t || !targ_t)
+			return -EINVAL;
+		/* void * */
+		if (local_id == 0 || targ_id == 0)
+			return 1;
+	}
+
+	switch (btf_kind(local_t)) {
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_FWD:
+		/* forward declarations match structs and unions */
+		if (btf_kind(targ_t) != BTF_KIND_STRUCT && btf_kind(targ_t) != BTF_KIND_UNION &&
+		    btf_kind(targ_t) != BTF_KIND_FWD)
+			return 0;
+		if (btf_kind(local_t) != BTF_KIND_FWD && btf_kind(targ_t) != BTF_KIND_FWD &&
+		    btf_kind(local_t) != btf_kind(targ_t))
+			return 0;
+		break;
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		if (!btf_is_any_enum(targ_t))
+			return 0;
+		break;
+	case BTF_KIND_INT:
+		return btf_is_int(targ_t) && local_t->size == targ_t->size;
+	default:
+		return btf_kind(local_t) == btf_kind(targ_t);
+	}
+
+	local_name = btf__name_by_offset(local_btf, local_t->name_off);
+	targ_name = btf__name_by_offset(targ_btf, targ_t->name_off);
+	local_len = bpf_core_essential_name_len(local_name);
+	targ_len = bpf_core_essential_name_len(targ_name);
+	return local_len == targ_len &&
+	       (local_len == 0 || strncmp(local_name, targ_name, local_len) == 0);
+}
+
+/* Match a named field accessor of a function arguments struct against the
+ * parameters (or the return value) of the FUNC of a function arguments
+ * candidate, using their location in the program context, which is an
+ * array of u64 slots, one per argument (two for structs passed by value
+ * that are larger than 8 bytes), followed by the return value.
+ */
+static int bpf_core_match_func_arg(const struct btf *local_btf,
+				   const struct bpf_core_accessor *local_acc,
+				   const struct bpf_core_cand *cand,
+				   struct bpf_core_spec *spec,
+				   __u32 *next_targ_id)
+{
+	const struct btf *targ_btf = cand->btf;
+	const struct btf_type *local_type, *func, *proto;
+	const struct btf_member *local_member;
+	const struct btf_param *params;
+	struct bpf_core_accessor *targ_acc;
+	__u32 i, idx, n, first, type_id, slot_off = 0;
+	const char *targ_name = NULL;
+	size_t local_len;
+	int sz, found;
+
+	if (!local_acc->name)
+		return 0;
+
+	local_type = btf_type_by_id(local_btf, local_acc->type_id);
+	local_member = btf_members(local_type) + local_acc->idx;
+	local_len = bpf_core_essential_name_len(local_acc->name);
+
+	func = btf_type_by_id(targ_btf, cand->id);
+	proto = btf_type_by_id(targ_btf, func->type);
+	params = btf_params(proto);
+	n = btf_vlen(proto);
+	/* variadic functions can't be traced, but be safe */
+	if (n && !params[n - 1].type)
+		n--;
+	first = (cand->flags & BPF_CORE_CAND_SKIP_FIRST) ? 1 : 0;
+
+	if (btf_has_decl_tag(local_btf, local_acc->type_id, local_acc->idx,
+			     BPF_CORE_FUNC_RET_TAG)) {
+		if (!(cand->flags & BPF_CORE_CAND_RETVAL) || !proto->type)
+			return 0;
+		idx = btf_vlen(proto);
+		targ_name = local_acc->name;
+	} else {
+		for (idx = first; idx < n; idx++) {
+			targ_name = btf__name_by_offset(targ_btf, params[idx].name_off);
+			if (targ_name && strlen(targ_name) == local_len &&
+			    strncmp(targ_name, local_acc->name, local_len) == 0)
+				break;
+		}
+		if (idx == n)
+			return 0;
+	}
+
+	for (i = first; i < idx && i < n; i++) {
+		sz = func_arg_slot_sz(targ_btf, params[i].type);
+		if (sz < 0)
+			return sz;
+		slot_off += sz;
+	}
+
+	type_id = func_arg_type(targ_btf, func, idx);
+	found = bpf_core_fields_are_compat(local_btf, local_member->type,
+					   targ_btf, type_id);
+	if (found > 0)
+		found = bpf_core_func_arg_ptr_compat(local_btf, local_member->type,
+						     targ_btf, type_id);
+	if (found <= 0)
+		return found;
+
+	if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
+		return -E2BIG;
+
+	/* sub-8-byte arguments live in the low-order bytes of their slot,
+	 * including structs and unions passed by value, which, e.g., s390
+	 * passes in registers like integers of the same size
+	 */
+	sz = btf__resolve_size(targ_btf, type_id);
+	if (btf_is_big_endian(targ_btf) && sz > 0 && sz < 8)
+		slot_off += 8 - sz;
+
+	spec->bit_offset += slot_off * 8;
+	spec->raw_spec[spec->raw_len++] = idx;
+	targ_acc = &spec->spec[spec->len++];
+	targ_acc->type_id = cand->id;
+	targ_acc->idx = idx;
+	targ_acc->name = targ_name;
+	*next_targ_id = type_id;
+	return 1;
+}
+
 /*
  * Given single high-level named field accessor in local type, find
  * corresponding high-level accessor for a target type. Along the way,
@@ -556,12 +889,15 @@ static int bpf_core_match_member(const struct btf *local_btf,
  * target spec (high-level, low-level + bit offset).
  */
 static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
-			       const struct btf *targ_btf, __u32 targ_id,
+			       const struct bpf_core_cand *cand,
 			       struct bpf_core_spec *targ_spec)
 {
+	const struct btf *targ_btf = cand->btf;
+	bool func_args = cand->flags & BPF_CORE_CAND_FUNC_ARGS;
 	const struct btf_type *targ_type;
 	const struct bpf_core_accessor *local_acc;
 	struct bpf_core_accessor *targ_acc;
+	__u32 targ_id = cand->id;
 	int i, sz, matched;
 	__u32 name_off;
 
@@ -570,6 +906,15 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 	targ_spec->root_type_id = targ_id;
 	targ_spec->relo_kind = local_spec->relo_kind;
 
+	if (func_args) {
+		/* only field accesses (args->x...) of the arguments struct
+		 * have a meaning for function argument candidates
+		 */
+		if (!core_relo_is_field_based(local_spec->relo_kind) ||
+		    local_spec->len < 2 || local_spec->spec[0].idx != 0)
+			return 0;
+	}
+
 	if (core_relo_is_type_based(local_spec->relo_kind)) {
 		if (local_spec->relo_kind == BPF_CORE_TYPE_MATCHES)
 			return bpf_core_types_match(local_spec->btf,
@@ -627,7 +972,20 @@ static int bpf_core_spec_match(struct bpf_core_spec *local_spec,
 		if (!targ_type)
 			return -EINVAL;
 
-		if (local_acc->name) {
+		if (func_args && i == 0) {
+			/* args[0], i.e., the context itself */
+			targ_acc->type_id = targ_id;
+			targ_acc->idx = 0;
+			targ_acc->name = NULL;
+			targ_spec->len++;
+			targ_spec->raw_spec[targ_spec->raw_len++] = 0;
+		} else if (func_args && i == 1) {
+			matched = bpf_core_match_func_arg(local_spec->btf,
+							  local_acc, cand,
+							  targ_spec, &targ_id);
+			if (matched <= 0)
+				return matched;
+		} else if (local_acc->name) {
 			matched = bpf_core_match_member(local_spec->btf,
 							local_acc,
 							targ_btf, targ_id,
@@ -734,10 +1092,17 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 		return 0;
 	}
 
-	m = btf_members(t) + acc->idx;
-	mt = skip_mods_and_typedefs(spec->btf, m->type, &field_type_id);
+	if (btf_kind(t) == BTF_KIND_FUNC) {
+		/* function argument (or return value), never a bitfield */
+		mt = skip_mods_and_typedefs(spec->btf, func_arg_type(spec->btf, t, acc->idx),
+					    &field_type_id);
+		bit_sz = 0;
+	} else {
+		m = btf_members(t) + acc->idx;
+		mt = skip_mods_and_typedefs(spec->btf, m->type, &field_type_id);
+		bit_sz = btf_member_bitfield_size(t, acc->idx);
+	}
 	bit_off = spec->bit_offset;
-	bit_sz = btf_member_bitfield_size(t, acc->idx);
 
 	bitfield = bit_sz > 0;
 	if (bitfield) {
@@ -893,6 +1258,38 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
  * with each other. Otherwise, libbpf will refuse to proceed due to ambiguity.
  * If instruction has to be poisoned, *poison will be set to true.
  */
+/* Whether a target spec refers to an integer or enum function argument (or
+ * return value), rather than to a member of a struct passed by value, that is
+ * smaller than 8 bytes on a big-endian target. Such arguments are in the
+ * low-order bytes of their context slot, where the verifier doesn't allow
+ * loads, but the calling conventions of big-endian architectures with BPF
+ * trampolines (s390x, powerpc64) extend them to 64 bits.
+ */
+static bool bpf_core_is_be_small_func_arg(const struct bpf_core_spec *spec,
+					  bool *is_signed)
+{
+	const struct bpf_core_accessor *acc;
+	const struct btf_type *t;
+	__u32 id;
+	__s64 sz;
+
+	if (spec->len != 2 || !btf_is_big_endian(spec->btf))
+		return false;
+	acc = &spec->spec[1];
+	t = btf_type_by_id(spec->btf, acc->type_id);
+	if (!t || btf_kind(t) != BTF_KIND_FUNC)
+		return false;
+	t = skip_mods_and_typedefs(spec->btf, func_arg_type(spec->btf, t, acc->idx), &id);
+	if (!t || (!btf_is_int(t) && !btf_is_any_enum(t)))
+		return false;
+	sz = btf__resolve_size(spec->btf, id);
+	if (sz <= 0 || sz >= 8)
+		return false;
+	*is_signed = (btf_is_any_enum(t) && BTF_INFO_KFLAG(t->info)) ||
+		     (btf_is_int(t) && (btf_int_encoding(t) & BTF_INT_SIGNED));
+	return true;
+}
+
 static int bpf_core_calc_relo(const char *prog_name,
 			      const struct bpf_core_relo *relo,
 			      int relo_idx,
@@ -909,6 +1306,9 @@ static int bpf_core_calc_relo(const char *prog_name,
 	res->fail_memsz_adjust = false;
 	res->orig_sz = res->new_sz = 0;
 	res->orig_type_id = res->new_type_id = 0;
+	res->widen_func_arg = false;
+	res->func_arg_signed = false;
+	res->func_arg_slot_off = 0;
 
 	if (core_relo_is_field_based(relo->kind)) {
 		err = bpf_core_calc_field_relo(prog_name, relo, local_spec,
@@ -919,6 +1319,12 @@ static int bpf_core_calc_relo(const char *prog_name,
 						      &res->new_type_id, NULL);
 		if (err)
 			goto done;
+		if (relo->kind == BPF_CORE_FIELD_BYTE_OFFSET && targ_spec &&
+		    bpf_core_is_be_small_func_arg(targ_spec, &res->func_arg_signed)) {
+			/* context slots are 8-byte aligned */
+			res->widen_func_arg = true;
+			res->func_arg_slot_off = res->new_val & ~7ULL;
+		}
 		/* Validate if it's safe to adjust load/store memory size.
 		 * Adjustments are performed only if original and new memory
 		 * sizes differ.
@@ -1100,6 +1506,38 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
 		}
 
+		if (res->widen_func_arg && class == BPF_LDX) {
+			__u8 mode = BPF_MODE(insn->code);
+
+			if (insn_bpf_size_to_bytes(insn) != res->orig_sz) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDX) unexpected mem size: got %d, exp %u\n",
+					prog_name, relo_idx, insn_idx,
+					insn_bpf_size_to_bytes(insn), res->orig_sz);
+				return -EINVAL;
+			}
+			/* An 8-byte load of the whole slot yields the argument
+			 * as extended to 64 bits by the calling convention,
+			 * which is what the original load yields only if it
+			 * extends it the same way.
+			 */
+			if (!(mode == BPF_MEM && !res->func_arg_signed) &&
+			    !(mode == BPF_MEMSX && res->func_arg_signed &&
+			      res->orig_sz == res->new_sz)) {
+				pr_warn("prog '%s': relo #%d: insn #%d (LDX) can't load function argument smaller than 8 bytes on big-endian target. "
+					"Make sure to use zero-extending loads of unsigned integers or sign-extending loads of signed ones.\n",
+					prog_name, relo_idx, insn_idx);
+				return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
+			}
+
+			orig_val = insn->off;
+			insn->off = res->func_arg_slot_off;
+			insn->code = BPF_LDX | BPF_MEM | BPF_DW;
+			pr_debug("prog '%s': relo #%d: patched insn #%d (LDX) off %llu -> %u, mem_sz %u -> 8 (big-endian function argument)\n",
+				 prog_name, relo_idx, insn_idx, (unsigned long long)orig_val,
+				 res->func_arg_slot_off, res->orig_sz);
+			break;
+		}
+
 		orig_val = insn->off;
 		insn->off = new_val;
 		pr_debug("prog '%s': relo #%d: patched insn #%d (LDX/ST/STX) off %llu -> %llu\n",
@@ -1356,8 +1794,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 	}
 
 	for (i = 0, j = 0; i < cands->len; i++) {
-		err = bpf_core_spec_match(local_spec, cands->cands[i].btf,
-					  cands->cands[i].id, cand_spec);
+		err = bpf_core_spec_match(local_spec, &cands->cands[i], cand_spec);
 		if (err < 0) {
 			bpf_core_format_spec(spec_buf, sizeof(spec_buf), cand_spec);
 			pr_warn("prog '%s': relo #%d: error matching candidate #%d %s: %d\n",
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 1c0566daf8e8..e51d33ba2d7f 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -6,9 +6,26 @@
 
 #include <linux/bpf.h>
 
+/* names of BTF decl tags marking function argument structs (and members
+ * referring to the return value) whose fields are relocated against the
+ * parameters of a tracing program's attach target, see __bpf_func_args
+ */
+#define BPF_CORE_FUNC_ARGS_TAG	"bpf_func_args"
+#define BPF_CORE_FUNC_RET_TAG	"bpf_func_ret"
+
+enum bpf_core_cand_flags {
+	/* id is a FUNC whose parameters are matched by name */
+	BPF_CORE_CAND_FUNC_ARGS		= 1 << 0,
+	/* first parameter isn't in the program context (raw tracepoints) */
+	BPF_CORE_CAND_SKIP_FIRST	= 1 << 1,
+	/* return value follows the arguments in the program context */
+	BPF_CORE_CAND_RETVAL		= 1 << 2,
+};
+
 struct bpf_core_cand {
 	const struct btf *btf;
 	__u32 id;
+	__u32 flags;
 };
 
 /* dynamically sized list of type IDs and its associated struct btf */
@@ -66,6 +83,13 @@ struct bpf_core_relo_res {
 	__u32 orig_type_id;
 	__u32 new_sz;
 	__u32 new_type_id;
+	/* loads of integer or enum function arguments smaller than 8 bytes on
+	 * big-endian targets, which are in the low-order bytes of their
+	 * context slot, are widened to the whole slot at func_arg_slot_off
+	 */
+	bool widen_func_arg;
+	bool func_arg_signed;
+	__u32 func_arg_slot_off;
 };
 
 int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
@@ -79,6 +103,11 @@ int bpf_core_types_match(const struct btf *local_btf, __u32 local_id, const stru
 
 size_t bpf_core_essential_name_len(const char *name);
 
+bool bpf_core_is_func_args_type(const struct btf *btf, __u32 type_id);
+int bpf_core_func_args_cand(const struct btf *btf, __u32 attach_btf_id,
+			    enum bpf_attach_type attach_type,
+			    struct bpf_core_cand *cand);
+
 int bpf_core_calc_relo_insn(const char *prog_name,
 			    const struct bpf_core_relo *relo, int relo_idx,
 			    const struct btf *local_btf,
-- 
2.56.0

