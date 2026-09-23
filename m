Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38940EB8E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139559; cv=none; b=c3WSRKTx2nWGWXCOJ2yw5X72yV2h7WfColQit4nOaISFyJyJzzZO44o7i3jJV9xM6qceY218BIrBRrZ8R6XAgQL8fowRe+/wlp3twZUmwJHcTCJUN4cWAkEJCAHTcNfodaEVfdnz+0WNRcZsDOb8/e9SbtXMlYTXpcePe3K0Hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139559; c=relaxed/simple;
	bh=8RHiCfxXAV/88eXHdjvD9hTHvC1f5BZU1n65VKeWJug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifcuaRypc2lFxfqkuSEwZgSrWqmHjZZps3r05PCTuf1vMby4mjn/g96wjIKGtvK/CYY0I7F5RLzhviz5fAzO9J/r/4iLXWCDyw/FE6wh7kA2GYCamChNmRavZkZeAX88QCL59IoYPnrnvXd4/D2AkXeQKy6SYliibvgu79XiKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9EDD82C8DA164D; Tue, 22 Sep 2026 21:58:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 01/21] bpf: Pack bpf_insn_aux_data flags into bit fields
Date: Tue, 22 Sep 2026 21:58:51 -0700
Message-ID: <20260923045851.2415163-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

struct bpf_insn_aux_data spreads its flags over three places: seven bools=
 a
byte each, a u8 carrying three bit fields, and a u32 group with 25 of its
32 bits spare. Put them all in one u64 word, alu_state with them, and mov=
e
orig_idx below it. The structure goes from 144 bytes to 128 with no holes=
,
and 34 bits are left for later flags.

No functional change: a one-bit unsigned field holds 0 and 1 the way the
bool did, and nothing takes the address of any of them.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92f528c45605..15bc61de61ef 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -675,40 +675,41 @@ struct bpf_insn_aux_data {
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt *=
/
-	bool nospec; /* do not execute this instruction speculatively */
-	bool nospec_result; /* result is unsafe under speculation, nospec must =
follow */
-	bool zext_dst; /* this insn zero extends dst reg */
-	bool needs_zext; /* alu op needs to clear upper bits */
-	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
-	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
-	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog perc=
pu alloc */
-	u8 alu_state; /* used in combination with alu_limit */
+	u64 nospec:1; /* do not execute this instruction speculatively */
+	u64 nospec_result:1; /* result is unsafe under speculation, nospec must=
 follow */
+	u64 zext_dst:1; /* this insn zero extends dst reg */
+	u64 needs_zext:1; /* alu op needs to clear upper bits */
+	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable c=
ontext */
+	u64 is_iter_next:1; /* bpf_iter_<type>_next() kfunc call */
+	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog per=
cpu alloc */
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

