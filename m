Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC5547040
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175475; cv=none; b=nNHEsf+ZSvlHQqeTTeHVV2AKSqlk8B2UJLzzHP4Tw4lv8PZ7UvhFlVYiJZWYorvGF+IpmvFDP2twW6yJ/E1xYmLehafEiQgmhQcMBFe/FeaMHIhsFHWLN9um7AU9ABBvR7QFDsiXRTQJcGf2si+cQ769/0h1MHB5Om+VFuhN27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175475; c=relaxed/simple;
	bh=5AwpaYdHq/QwZdFzBPzKAHEvgvjgB54bJTeByk83W6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXVhn0vj1eG7zBa4mk0hi0irejL73DRkkUPm5OXFs5BhiZWWYsXXgj5MAEfRyVVhIxjwSJQrRUevVYVfA/RXweyrT2UM5y0GJJlGkkpDFjB+Dw5P5zw+pe/W4d4bAYqJ6CDSZMmZSxP8RtQ+tKUn82FoY2yXFulXE2cagfjNAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2535031A0DA99D; Fri, 16 Oct 2026 11:31:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 5/9] bpf, x86: Place trampoline arguments by the x86-64 calling convention
Date: Fri, 16 Oct 2026 11:31:05 -0700
Message-ID: <20261016183105.1134967-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016183039.1132126-1-yonghong.song@linux.dev>
References: <20261016183039.1132126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

save_args() numbers the on-stack argument slots consecutively, and the
area built for the original function is sized the same way, while the
x86-64 ABI rounds the stack slot up to an even one for an argument
aligned to 16 bytes: an __int128, or an aggregate holding one. When such
an argument lands on an odd stack slot, it and every argument after it
are read from the wrong place, so a bpf program attached to the function
reads a neighbouring eightbyte, and the arguments handed on to the
original function are shifted. For example:

	/* s holds an __int128 */
	void foo(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f, u64 g,
		 struct s h, u64 i)

x86-64 puts g in the first stack slot, leaves the second empty and puts
h in the third and fourth, while the trampoline reads h from the second
and third.

Take the position of each argument slot from bpf_jit_place_args(), which
knows the x86-64 rules, backfill included. save_args() then reads each
slot from its register or incoming stack slot, restore_regs() puts back
only the register slots, and the area built for the original function
mirrors the incoming one, holes included.

A trampoline on a BPF function is not changed by this: since the
previous patch, the function's model has one u64 per argument slot,
which bpf_jit_place_args() places in slot order, so the trampoline still
takes the arguments where BPF code put them.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 189 ++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 93 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fc4c67fc201c..e31638770003 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2222,6 +2222,16 @@ static const u8 x86_arg_reg[] =3D {
 	BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5, X86_REG_R9,
 };
=20
+static bool x86_arg_on_stack(u8 pos)
+{
+	return pos >=3D x86_arg_abi.nr_arg_regs;
+}
+
+static s32 x86_arg_stack_off(u8 pos)
+{
+	return (pos - x86_arg_abi.nr_arg_regs) * 8;
+}
+
 /*
  * Move the arguments the x86-64 ABI places somewhere other than the arg=
ument
  * slot the BPF calling convention gave them. @stack_base addresses the
@@ -3752,21 +3762,17 @@ static void clean_stack_garbage(const struct btf_=
func_model *m,
 	}
 }
=20
-/* get the count of the regs that are used to pass arguments */
-static int get_nr_used_regs(const struct btf_func_model *m)
+/* the eightbytes taken by the on-stack arguments, alignment holes inclu=
ded */
+static int get_nr_stack_slots(const u8 *pos_of_slot, int nr_slots)
 {
-	int i, arg_regs, nr_used_regs =3D 0;
+	int slot;
=20
-	for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
-		arg_regs =3D (m->arg_size[i] + 7) / 8;
-		if (nr_used_regs + arg_regs <=3D 6)
-			nr_used_regs +=3D arg_regs;
-
-		if (nr_used_regs >=3D 6)
-			break;
+	for (slot =3D nr_slots - 1; slot >=3D 0; slot--) {
+		if (x86_arg_on_stack(pos_of_slot[slot]))
+			return x86_arg_stack_off(pos_of_slot[slot]) / 8 + 1;
 	}
=20
-	return nr_used_regs;
+	return 0;
 }
=20
 /*
@@ -3796,20 +3802,21 @@ static void emit_arena_arg_conv(u8 **pprog, u32 s=
rc_reg, bool nullable, u32 base
 }
=20
 static void save_args(const struct btf_func_model *m, u8 **prog,
-		      int stack_size, bool for_call_origin, u32 flags,
-		      u64 arena_base)
+		      const u8 *pos_of_slot, int stack_size,
+		      bool for_call_origin, u32 flags, u64 arena_base)
 {
-	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
+	int arg_regs, first_off =3D 0, nr_stack_slots =3D 0;
 	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
 	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16=
 : 24;
-	int i, j;
+	int bargs_off =3D stack_size;
+	int i, j, slot, off, doff;
=20
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
+	for (i =3D 0, slot =3D 0; i < m->nr_args; i++) {
 		bool arena_arg =3D arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_A=
RG);
 		bool nullable =3D m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
=20
@@ -3831,8 +3838,36 @@ static void save_args(const struct btf_func_model =
*m, u8 **prog,
 		 *
 		 * the arg1-5,arg7 will be passed by regs, and arg6 will
 		 * by stack.
+		 *
+		 * An argument aligned to 16 bytes, an __int128 or a struct
+		 * holding one, also starts at an even stack slot, which can
+		 * leave a hole before it. bpf_jit_place_args() worked out
+		 * where each eightbyte is.
 		 */
-		if (nr_regs + arg_regs > 6) {
+		for (j =3D 0; j < arg_regs; j++, slot++, bargs_off -=3D 8) {
+			u8 pos =3D pos_of_slot[slot];
+			u32 src;
+
+			if (!x86_arg_on_stack(pos)) {
+				/*
+				 * Only copy the arguments on-stack to
+				 * current 'stack_size' and ignore the regs,
+				 * used to prepare the arguments on-stack for
+				 * origin call.
+				 */
+				if (for_call_origin)
+					continue;
+
+				/* copy the arguments from regs into stack */
+				src =3D x86_arg_reg[pos];
+				if (arena_arg) {
+					emit_arena_arg_conv(prog, src, nullable, (u32)arena_base);
+					src =3D BPF_REG_0;
+				}
+				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -bargs_off);
+				continue;
+			}
+
 			/* copy function arguments from origin stack frame
 			 * into current stack frame.
 			 *
@@ -3842,53 +3877,33 @@ static void save_args(const struct btf_func_model=
 *m, u8 **prog,
 			 * entered through the fentry call, so rbp + 24, and
 			 * a single one when it is entered with a jmp or
 			 * called indirectly, so rbp + 16.
+			 *
+			 * The area for the origin call mirrors the incoming
+			 * one, hole and all; only the bpf program takes the
+			 * arguments packed.
 			 */
-			for (j =3D 0; j < arg_regs; j++) {
-				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
-					 nr_stack_slots * 8 + stack_args_off);
-				if (arena_arg)
-					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
-							    (u32)arena_base);
-				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
-					 -stack_size);
-
-				if (!nr_stack_slots)
-					first_off =3D stack_size;
-				stack_size -=3D 8;
-				nr_stack_slots++;
-			}
-		} else {
-			/* Only copy the arguments on-stack to current
-			 * 'stack_size' and ignore the regs, used to
-			 * prepare the arguments on-stack for origin call.
-			 */
-			if (for_call_origin) {
-				nr_regs +=3D arg_regs;
-				continue;
-			}
-
-			/* copy the arguments from regs into stack */
-			for (j =3D 0; j < arg_regs; j++) {
-				u32 src =3D nr_regs =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs;
-
-				if (arena_arg) {
-					emit_arena_arg_conv(prog, src, nullable, (u32)arena_base);
-					src =3D BPF_REG_0;
-				}
-				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -stack_size);
-				stack_size -=3D 8;
-				nr_regs++;
-			}
+			off =3D x86_arg_stack_off(pos);
+			doff =3D for_call_origin ? stack_size - off : bargs_off;
+			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
+				 stack_args_off + off);
+			if (arena_arg)
+				emit_arena_arg_conv(prog, BPF_REG_0, nullable,
+						    (u32)arena_base);
+			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -doff);
+
+			if (!nr_stack_slots)
+				first_off =3D doff;
+			nr_stack_slots++;
 		}
 	}
=20
 	clean_stack_garbage(m, prog, nr_stack_slots, first_off);
 }
=20
-static void restore_regs(const struct btf_func_model *m, u8 **prog,
+static void restore_regs(u8 **prog, const u8 *pos_of_slot, int nr_slots,
 			 int stack_size)
 {
-	int i, j, arg_regs, nr_regs =3D 0;
+	int slot;
=20
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
@@ -3897,23 +3912,10 @@ static void restore_regs(const struct btf_func_mo=
del *m, u8 **prog,
 	 *
 	 * The logic here is similar to what we do in save_args()
 	 */
-	for (i =3D 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
-		arg_regs =3D (m->arg_size[i] + 7) / 8;
-		if (nr_regs + arg_regs <=3D 6) {
-			for (j =3D 0; j < arg_regs; j++) {
-				emit_ldx(prog, BPF_DW,
-					 nr_regs =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 BPF_REG_FP,
-					 -stack_size);
-				stack_size -=3D 8;
-				nr_regs++;
-			}
-		} else {
-			stack_size -=3D 8 * arg_regs;
-		}
-
-		if (nr_regs >=3D 6)
-			break;
+	for (slot =3D 0; slot < nr_slots; slot++, stack_size -=3D 8) {
+		if (!x86_arg_on_stack(pos_of_slot[slot]))
+			emit_ldx(prog, BPF_DW, x86_arg_reg[pos_of_slot[slot]],
+				 BPF_REG_FP, -stack_size);
 	}
 }
=20
@@ -4172,7 +4174,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 					 struct bpf_tramp_nodes *tnodes,
 					 void *func_addr)
 {
-	int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
+	int i, ret, nr_regs, stack_size =3D 0;
+	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
 	int regs_off, func_meta_off, ip_off, run_ctx_off, arg_stack_off, rbx_of=
f;
 	int tcc_off =3D 0;
 	struct bpf_tramp_nodes *fentry =3D &tnodes[BPF_TRAMP_FENTRY];
@@ -4196,12 +4199,12 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
=20
 	arena_base =3D bpf_tramp_arena_base(m, tnodes, flags);
=20
-	for (i =3D 0; i < m->nr_args; i++)
-		nr_regs +=3D (m->arg_size[i] + 7) / 8 - 1;
-
-	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
-	 * are passed through regs, the remains are through stack.
+	/*
+	 * x86-64 supports up to MAX_BPF_FUNC_ARGS argument slots, six in
+	 * registers and the rest on the stack, where bpf_jit_place_args()
+	 * puts them.
 	 */
+	nr_regs =3D bpf_jit_place_args(&x86_arg_abi, m, pos_of_slot);
 	if (nr_regs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
=20
@@ -4213,11 +4216,11 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
 	 * RBP - 8         [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
 	 *                                      BPF_TRAMP_F_RET_FENTRY_RET flag=
s
 	 *
-	 *                 [ reg_argN        ]  always
-	 *                 [ ...             ]
-	 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
+	 *                 [ arg slotN       ]  always, packed, whether
+	 *                 [ ...             ]  in a register or on the
+	 * RBP - regs_off  [ arg slot1       ]  stack; program's ctx pointer
 	 *
-	 * RBP - func_meta_off [ regs count, etc ]  always
+	 * RBP - func_meta_off [ slot count, etc ]  always
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
@@ -4227,10 +4230,10 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
 	 *
 	 * RBP - tcc_off   [ tail_call_cnt_ptr ]  BPF_TRAMP_F_TAIL_CALL_CTX
 	 *
-	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
-	 *                     [ ...        ]
-	 *                     [ stack_arg2 ]
-	 * RBP - arg_stack_off [ stack_arg1 ]
+	 *                     [ stack slotN ]  BPF_TRAMP_F_CALL_ORIG,
+	 *                     [ ...         ]  the incoming stack
+	 *                     [ stack slot2 ]  arguments, alignment
+	 * RBP - arg_stack_off [ stack slot1 ]  holes included
 	 */
=20
 	/* room for return value of orig_call or fentry prog */
@@ -4241,7 +4244,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	stack_size +=3D nr_regs * 8;
 	regs_off =3D stack_size;
=20
-	/* function matedata, such as regs count  */
+	/* function matedata, such as the argument slot count */
 	stack_size +=3D 8;
 	func_meta_off =3D stack_size;
=20
@@ -4268,7 +4271,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
=20
 	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
 		/* the space that used to pass arguments on-stack */
-		stack_size +=3D (nr_regs - get_nr_used_regs(m)) * 8;
+		stack_size +=3D get_nr_stack_slots(pos_of_slot, nr_regs) * 8;
 		/* make sure the stack pointer is 16-byte aligned if we
 		 * need pass arguments on stack, which means
 		 *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
@@ -4324,7 +4327,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
=20
 	func_meta =3D nr_regs;
-	/* Store number of argument registers of the traced function */
+	/* Store number of argument slots of the traced function */
 	emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
=20
 	if (flags & BPF_TRAMP_F_IP_ARG) {
@@ -4332,7 +4335,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
=20
-	save_args(m, &prog, regs_off, false, flags, arena_base);
+	save_args(m, &prog, pos_of_slot, regs_off, false, flags, arena_base);
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -4373,8 +4376,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags, 0);
+		restore_regs(&prog, pos_of_slot, nr_regs, regs_off);
+		save_args(m, &prog, pos_of_slot, arg_stack_off, true, flags, 0);
=20
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -4427,7 +4430,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	}
=20
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_regs(m, &prog, regs_off);
+		restore_regs(&prog, pos_of_slot, nr_regs, regs_off);
=20
 	/* This needs to be done regardless. If there were fmod_ret programs,
 	 * the return value is only updated on the stack and still needs to be
--=20
2.53.0-Meta

