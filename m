Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27635A39D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036922; cv=none; b=k8ltJ2YaChDV6idf6nNWBm4KMYFT8347Je1q5uDtIfuwJA+5YbbJ47dFzy7kNYxHVQYsLu+HtRtEl7rlLfHHgpyY4s9J8AOXFQACVwrh+QeX9vxVxjGJ9vjxw1O8DnLDVnsZpKzkapvCh9I3EHJhZr/yQrjxQQTdEo47WjZN+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036922; c=relaxed/simple;
	bh=TmD/0EE0e7wiQqklwrWQiAOwU2Nlf7iWoeuDgcsl2pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilq5PdOmcQPlaIteM0q5DNxjVe34xeX44XRwDETm6r5KDNEqRXvK5oerU2tJSTL0VlKFRsRYNnUm/ftpbsEo5Al6salpPxKkdVNUtcxvQq5r3bFStNMJQ0VfW8pmBBPnokrDNNhG3qy5ADaXW/qBJu7xOidRgRcHcmNZIP+nwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E330931498BC72; Wed, 14 Oct 2026 21:01:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 01/26] bpf: Pack bpf_insn_aux_data flags into bit fields
Date: Wed, 14 Oct 2026 21:01:48 -0700
Message-ID: <20261015040148.854746-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

struct bpf_insn_aux_data spreads its flags over eleven bools, a u8 of
three bit fields and a u32 group with 25 of its 32 bits spare. Put them
all in u64 bit fields, alu_state with them, which fit in the 32 bits
beside seen, so orig_idx starts the next word. The structure goes from
216 bytes to 200, and stays there when a later patch adds a u32, which
takes a hole further down.

alu_state was a u8, but it only ever holds BPF_ALU_* flags, the highest
of which is BPF_ALU_IMMEDIATE (1U << 4), so it gets five bits. With
eight, the flags would take 34 bits, more than fit beside seen, so they
would start a word of their own, and the later u32 would grow the
structure to 208 bytes. A new BPF_ALU_* flag has to widen it.

No functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 49 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 791398e14962..112ca1511da4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -767,44 +767,45 @@ struct bpf_insn_aux_data {
 	u16 stack_ptrs; /* bitmask of regs that may hold a frame pointer here (=
arg_track) */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt *=
/
-	bool nospec; /* do not execute this instruction speculatively */
-	bool nospec_result; /* result is unsafe under speculation, nospec must =
follow */
-	bool zext_dst; /* this insn zero extends dst reg */
-	bool needs_zext; /* alu op needs to clear upper bits */
-	bool prevent_zext; /* alu op cannot be zext (already used with 64-bit s=
calars) */
-	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
-	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
-	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog perc=
pu alloc */
-	bool arena_scalar; /* ldx/stx/st/atomic through a number, it's an addre=
ss in arena */
-	bool bb_end; /* last instruction of a basic block */
-	bool need_scev;
-	u8 alu_state; /* used in combination with alu_limit */
+	u64 nospec:1; /* do not execute this instruction speculatively */
+	u64 nospec_result:1; /* result is unsafe under speculation, nospec must=
 follow */
+	u64 zext_dst:1; /* this insn zero extends dst reg */
+	u64 needs_zext:1; /* alu op needs to clear upper bits */
+	u64 prevent_zext:1; /* alu op cannot be zext (already used with 64-bit =
scalars) */
+	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable c=
ontext */
+	u64 is_iter_next:1; /* bpf_iter_<type>_next() kfunc call */
+	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog per=
cpu alloc */
+	u64 arena_scalar:1; /* ldx/stx/st/atomic through a number, it's an addr=
ess in arena */
+	u64 bb_end:1; /* last instruction of a basic block */
+	u64 need_scev:1;
+	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
 	 */
-	u8 fastcall_pattern:1;
+	u64 fastcall_pattern:1;
 	/* for CALL instructions, a number of spill/fill pairs in the
 	 * bpf_fastcall pattern.
 	 */
-	u8 fastcall_spills_num:3;
-	u8 arg_prog:4;
+	u64 fastcall_spills_num:3;
+	u64 arg_prog:4;
=20
-	/* below fields are initialized once */
-	unsigned int orig_idx; /* original instruction index */
-	u32 jmp_point:1;
-	u32 prune_point:1;
+	/* below flags are initialized once */
+	u64 jmp_point:1;
+	u64 prune_point:1;
 	/* ensure we check state equivalence and save state checkpoint and
 	 * this instruction, regardless of any heuristics
 	 */
-	u32 force_checkpoint:1;
+	u64 force_checkpoint:1;
 	/* true if instruction is a call to a helper function that
 	 * accepts callback function as a parameter.
 	 */
-	u32 calls_callback:1;
-	u32 indirect_target:1; /* if it is an indirect jump target */
-	u32 non_stack_access:1; /* instruction can access non-stack memory */
+	u64 calls_callback:1;
+	u64 indirect_target:1; /* if it is an indirect jump target */
+	u64 non_stack_access:1; /* instruction can access non-stack memory */
 	/* true if some jump or call instruction targets this instruction */
-	u32 jump_target:1;
+	u64 jump_target:1;
+
+	unsigned int orig_idx; /* original instruction index, initialized once =
*/
 	/*
 	 * CFG strongly connected component this instruction belongs to,
 	 * zero if it is a singleton SCC.
--=20
2.53.0-Meta

