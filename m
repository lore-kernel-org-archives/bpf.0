Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498F22D4C3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744392; cv=none; b=jCzwWFH9UwoRKvuTz6IydcaDRex5xPYloqGcYegnrl4rlMn++T3b2Tjl1x7cl6TzKqKhV2scR2qmxis2wuvEwn41F6ck7m0aD4CqLLMbFWK7S9Qd7NkIqBjBtPlfgXOfRNmaITukW0HY1eq5Fazf1iE5NTdx+TpHcYR25CAgGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744392; c=relaxed/simple;
	bh=Z+6RI8Ht6TWJzVYM6+BVfVSRmIghdxwrDUbqULZaIiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RT7EIBVZBKCkVuZHU4JVTeRcFPNKZOSrMW03vrIz0SEkTIkmp27Xi1SsRD3RBL3tvko+9BsNK5UWliWxDds/Xm2qmz2R3OfLD2OoCvGGENZ94XTtvMhvkiIaIA0ETPRdHaRP3ESHE0yuiGif7qcz9iiKMpR7rWwJ7gYYrvZMJm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=AryffoKt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="AryffoKt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=TVe/3c9khS9NC2FkE6uOGyrgEPRIlP8OaHg+tdsb+4Q=; b=AryffoKtjy5/nSNHeJDqcZrrDl
	WIW6Z1v/eBa0z2Nxu/UIaKNYRxCLDasRBolFknWymSPcCT/z4dDh8Xbb3obXkAngex5oeQ9E/Hyu3
	MBckg5eX1RXf+E8373upfUI6l95wTXHMz3Dq7XBDdCMzhi8B0K10sB0T1WTav3MhX5J1IKD0YZWje
	nhatuR+YJ8UXM13Fq01YCQhZMd3fmURwtcO5MQyqDkGAGJrpIm/E+BCdw99LSPGOL6GEeOstIQY8H
	87k8HuxJH8+mIiIBo/o+Mf/W5MDOfiz8U6zrUAx7Y84pXqDC/vxUWyegVWFJYiCnlj89Us1iSRMck
	efy7Cc3w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wuzpl-000F8g-2D;
	Fri, 14 Aug 2026 23:53:01 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] bpf: Keep fault protection when merging pointer types
Date: Fri, 14 Aug 2026 23:52:55 +0200
Message-ID: <20260814215301.709827-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

When the same BPF_LDX instruction is reached through paths that yield
different pointer types, save_aux_ptr_type() merges them into a single
type which is later used by bpf_convert_ctx_accesses() to decide whether
the load has to be rewritten into a BPF_PROBE_MEM one.

Before f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
the merge only accepted two PTR_TO_BTF_ID pointers and unconditionally
fell back to PTR_TO_BTF_ID | PTR_UNTRUSTED, so the merged type was always
one that gets the BPF_PROBE_MEM rewrite. However, the mentioned commit
widened the merge to also cover a PTR_TO_MEM base and replaced the
fallback by a union of the PTR_UNTRUSTED and MEM_RDONLY flags.

A union of flags though cannot express the property the later rewrite
is built upon, some examples:

  - PTR_TO_MEM merged with PTR_TO_BTF_ID | PTR_UNTRUSTED gets
    PTR_TO_MEM | PTR_UNTRUSTED but only the MEM_RDONLY variant is valid
  - PTR_TO_MEM merged with a plain PTR_TO_BTF_ID gets PTR_TO_MEM
    dropping the rewrite the latter type would have gotten
  - PTR_TO_MEM | MEM_RDONLY merged with a plain PTR_TO_BTF_ID gets
    PTR_TO_MEM | MEM_RDONLY which is not rewritten either since only
    its PTR_UNTRUSTED variant is

In all three cases a program can take the unsafe path at runtime with a
NULL or otherwise bad pointer and panic the kernel on the faulting load:

  BUG: kernel NULL pointer dereference, address: 0000000000000038
  RIP: 0010:bpf_prog_77531a87032eeaf1_mixed_mem_btf_id_type+0x4b/0x65
  Call Trace:
   <TASK>
   bpf_test_run+0x20b/0x460
   bpf_prog_test_run_skb+0x650/0xbe0
   __sys_bpf+0xb96/0x3140
   __x64_sys_bpf+0x2c/0x40
   do_syscall_64+0xba/0x590
  Kernel panic - not syncing: Fatal exception in interrupt

Note that the last two shapes have to be fixed right here, otherwise
the merged type retains nothing which marks the load as fault prone,
thus no rule in bpf_convert_ctx_accesses() can recover it. Fix it by
normalizing the merged type instead.

Reuse it in is_load_acq_unsafe() to avoid open coding, and trim the
overly verbose comment which is more of an implementation detail of
bpf_convert_ctx_accesses() anyway.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - update commit msg that this commit is still needed

 include/linux/bpf_verifier.h | 10 ++++++++
 kernel/bpf/verifier.c        | 49 +++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 93f7c2075eea..114ae4540d2c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1297,6 +1297,16 @@ static inline u32 type_flag(u32 type)
 	return type & ~BPF_BASE_TYPE_MASK;
 }
 
+static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
+{
+	/*
+	 * The pointer types which must not be dereferenced without fault
+	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
+	 * turn a BPF_LDX into a BPF_PROBE_MEM one for.
+	 */
+	return type == PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
+}
+
 static inline bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
 {
 	int i;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61ef43325c6f..a3d165e92175 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4828,19 +4828,11 @@ static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
 	 * A BPF_LOAD_ACQ is not rewritten to a BPF_PROBE_MEM load by the
 	 * verifier, unlike a regular BPF_LDX. The JIT would emit a plain load
 	 * with no exception table entry, so a fault (e.g. NULL deref) crashes
-	 * the kernel instead of being handled.
-	 *
-	 * Reject the source pointer types that a BPF_LDX would have had that
-	 * fault protection applied to, i.e. the ones bpf_convert_ctx_accesses()
-	 * turns into BPF_PROBE_MEM: a bare PTR_TO_BTF_ID and any PTR_UNTRUSTED
-	 * pointer (untrusted btf ids, untrusted MEM_ALLOC, rdonly untrusted
-	 * memory). A PTR_TRUSTED pointer is not among them, is not converted,
-	 * and stays allowed. Same for the other flagged PTR_TO_BTF_ID variants
-	 * (MEM_ALLOC, MEM_RCU, ...), hence the exact match on the base type.
+	 * the kernel instead of being handled. Reject the source pointer types
+	 * that would have needed that protection, the remaining ones stay
+	 * allowed.
 	 */
-	return insn->imm == BPF_LOAD_ACQ &&
-	       (reg->type == PTR_TO_BTF_ID ||
-		(type_flag(reg->type) & PTR_UNTRUSTED));
+	return insn->imm == BPF_LOAD_ACQ && bpf_may_fault_on_deref(reg->type);
 }
 
 /* Return false if @regno contains a pointer whose type isn't supported for
@@ -17021,11 +17013,24 @@ static bool is_ptr_to_mem(enum bpf_reg_type type)
 	return base_type(type) == PTR_TO_MEM;
 }
 
+static enum bpf_reg_type merge_ptr_types(enum bpf_reg_type type_a,
+					 enum bpf_reg_type type_b)
+{
+	bool to_mem = is_ptr_to_mem(type_a) || is_ptr_to_mem(type_b);
+	enum bpf_reg_type type_merged = to_mem ? PTR_TO_MEM : PTR_TO_BTF_ID;
+
+	if (bpf_may_fault_on_deref(type_a) || bpf_may_fault_on_deref(type_b))
+		type_merged |= to_mem ? MEM_RDONLY | PTR_UNTRUSTED :
+					PTR_UNTRUSTED;
+	else
+		type_merged |= ((type_a | type_b) & MEM_RDONLY);
+	return type_merged;
+}
+
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch)
 {
 	enum bpf_reg_type *prev_type = &env->insn_aux_data[env->insn_idx].ptr_type;
-	enum bpf_reg_type merged_type;
 
 	if (*prev_type == NOT_INIT) {
 		/* Saw a valid insn
@@ -17046,20 +17051,12 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 		    is_ptr_to_mem_or_btf_id(*prev_type)) {
 			/*
 			 * Have to support a use case when one path through
-			 * the program yields TRUSTED pointer while another
-			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
-			 * BPF_PROBE_MEM/BPF_PROBE_MEMSX.
-			 * Same behavior of MEM_RDONLY flag.
+			 * the program yields a TRUSTED pointer while another
+			 * is UNTRUSTED. Merge them into a type which keeps
+			 * the BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when
+			 * either side needs it.
 			 */
-			if (is_ptr_to_mem(type) || is_ptr_to_mem(*prev_type))
-				merged_type = PTR_TO_MEM;
-			else
-				merged_type = PTR_TO_BTF_ID;
-			if ((type & PTR_UNTRUSTED) || (*prev_type & PTR_UNTRUSTED))
-				merged_type |= PTR_UNTRUSTED;
-			if ((type & MEM_RDONLY) || (*prev_type & MEM_RDONLY))
-				merged_type |= MEM_RDONLY;
-			*prev_type = merged_type;
+			*prev_type = merge_ptr_types(type, *prev_type);
 		} else {
 			verbose(env, "same insn cannot be used with different pointers\n");
 			return -EINVAL;
-- 
2.43.0

