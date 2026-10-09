Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197233B6F8
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519317; cv=none; b=DcoNu3UumBdGwB8kh32SAKGW+9VcrRmr53RS90wWN+QUgj0/ccjyDjsWljCBEH2WXkIGs9zxg/0CE2+wczIj2awUVvs3IBYH5mIdcGYOeDQ7LT6a54BHcEZDKCppnq5529wCKEDJpNu+Zk8HMy+tVpi3475S8uaQXZBkiFtyhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519317; c=relaxed/simple;
	bh=7LurUQy4l1R5WJIecHEoo5hCb3p9iggCAUd43GB/lsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVaHilQ/1AmnPctQNa17rcLsV6kRCMpyHBXJta0gN0Q4j6wu18aVtnt416A4LK8SyUstgdUowAQqXmvIlM3dXRQyRa88lBPq369pgw9xV5etdMagqvTRGeZkXFOWK3aC9PhTyTGsiHh5288OBeA1STdM5qhYMEDU2bgcqjH2BDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1BA783008BF162; Thu,  8 Oct 2026 21:14:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v10 01/24] bpf: Pack bpf_insn_aux_data flags into bit fields
Date: Thu,  8 Oct 2026 21:14:53 -0700
Message-ID: <20261009041453.17533-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

struct bpf_insn_aux_data spreads its flags over nine bools, a u8 of three
bit fields and a u32 group with 25 of its 32 bits spare. Put them all in
one u64 word, alu_state with them, with orig_idx packing into the word's
upper half. The structure goes from 128 bytes to 120, and stays there
when a later patch adds a u32, which takes the tail padding.

No functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 45 ++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c51083c761cf..68636e1f048b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -664,42 +664,43 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
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
+	u64 alu_state:8; /* used in combination with alu_limit */
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

