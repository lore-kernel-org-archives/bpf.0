Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F642E013
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653640; cv=none; b=LMsHWFoCZoO2II7/M5vgWya55pFp68Cwd4pCoKUTqHiXZCTxFvxjdIai3uOqbzCdNsEhDS7Nxz2ibMem5FTOzqvYqZ1VoEQ2b8AvRLHFPtwpbDHxA2b8TSldhtptUmY4sVocWf+4vTgryriq21bnSveN/OkQW4lH2ct4EOS47J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653640; c=relaxed/simple;
	bh=QkfCUT8hcrBF0UtCHmQqZtzvvsUZX5JFMb/1M6lLP4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqGtRYbzBgF+8FPhOE3HnXLa37jM3+JjU9kDUEKtXXMh0/qD9tOSGMfgCsjm+0jSCispHTrwVo4MrYhrMZPW9Dafc7OR31DbA+aT87rMlZNz9IRTD92oNuEFrTJv1kfeFCxQXVdyUgMvuhLulqXoR4VhKqi+rjlEuyfUEYGvqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XayzTciI; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XayzTciI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=1UhkXaL82imVzq7QaP+KR2LhIy74eSdmB078FUmMPZk=; b=XayzTciITRup9dHLDiSK6a9Dfg
	SPmraTHcfR+ZXAtWNBPLiBrVFBAyS3T7EE+CiP5L9LNYFhK9phHIXQ2ZY9ycZRtModeuDWVYaEh7V
	GOg5faRcLRNc8IUG57DJslqm26CEJ9fRqGuU+J7r8BCNTOKnrTtBPkNlKPNp8yqmwclXqH7wj96TU
	tYg6ymzc5hXTswFuKmQf7fktDi/YBSkOJ1rO30ydW/zHht48iFVa0tNnGwerfTpRU2h22VQvFUs6l
	rg+6RWBbdPyQVt2As7LPaBhm5KmmDhykyihYfvMj///UfJJ6n9RZxaipto17bYbk6KMOn/FfQGqFP
	O+6KEufg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wucE5-0009uC-1S;
	Thu, 13 Aug 2026 22:40:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/4] bpf: Keep fault protection when merging pointer types
Date: Thu, 13 Aug 2026 22:40:29 +0200
Message-ID: <20260813204032.644949-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28091/Thu Aug 13 08:25:54 2026)

When the same BPF_LDX instruction is reached through paths that yield
different pointer types, save_aux_ptr_type() merges them into a single
type which is later used by bpf_convert_ctx_accesses() to decide whether
the load has to be rewritten into a BPF_PROBE_MEM one.

Before commit f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
the merge only accepted two PTR_TO_BTF_ID pointers and unconditionally
fell back to PTR_TO_BTF_ID | PTR_UNTRUSTED, so the merged type was always
one that gets the BPF_PROBE_MEM rewrite. However, the mentioned commit
widened the merge to also cover a PTR_TO_MEM base and replaced the
fallback by a union of the PTR_UNTRUSTED and MEM_RDONLY flags.

The union can produce types which bpf_convert_ctx_accesses() does not
rewrite, and the load then stays a plain one without an exception table
entry, e.g.:

  - PTR_TO_MEM merged with PTR_TO_BTF_ID | PTR_UNTRUSTED
   => PTR_TO_MEM | PTR_UNTRUSTED but only the MEM_RDONLY variant is valid
  - PTR_TO_MEM merged with a plain PTR_TO_BTF_ID
   => PTR_TO_MEM dropping the rewrite the latter type would have gotten
  - PTR_TO_MEM | MEM_RDONLY merged with a plain PTR_TO_BTF_ID
   => PTR_TO_MEM | MEM_RDONLY which is not rewritten either since only
    its PTR_UNTRUSTED variant is

In all three cases a program can take the unsafe path at runtime with a
NULL or otherwise bad pointer and panic the kernel on the faulting load.
Fix it by normalizing the merged type: if either side needs the rewrite,
pick the one rewritten form the merged base type has.

Reuse the may_fault_on_deref() helper in is_load_acq_unsafe() as well to
avoid open coding, and trim the overly verbose comment which is more of
implementation detail of bpf_convert_ctx_accesses() anyway.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61ef43325c6f..0d3b76d7820e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4819,6 +4819,18 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
+static bool may_fault_on_deref(enum bpf_reg_type type)
+{
+	/*
+	 * The pointer types which must not be dereferenced without fault
+	 * protection, that is, the ones bpf_convert_ctx_accesses() has to
+	 * turn a BPF_LDX into a BPF_PROBE_MEM one for. Slightly wider than
+	 * the list matched there, which relies on an untrusted PTR_TO_MEM
+	 * always carrying MEM_RDONLY as well.
+	 */
+	return type == PTR_TO_BTF_ID || (type_flag(type) & PTR_UNTRUSTED);
+}
+
 static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
 			       struct bpf_insn *insn)
 {
@@ -4828,19 +4840,11 @@ static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
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
+	return insn->imm == BPF_LOAD_ACQ && may_fault_on_deref(reg->type);
 }
 
 /* Return false if @regno contains a pointer whose type isn't supported for
@@ -17021,11 +17025,24 @@ static bool is_ptr_to_mem(enum bpf_reg_type type)
 	return base_type(type) == PTR_TO_MEM;
 }
 
+static enum bpf_reg_type merge_ptr_types(enum bpf_reg_type type_a,
+					 enum bpf_reg_type type_b)
+{
+	bool to_mem = is_ptr_to_mem(type_a) || is_ptr_to_mem(type_b);
+	enum bpf_reg_type type_merged = to_mem ? PTR_TO_MEM : PTR_TO_BTF_ID;
+
+	if (may_fault_on_deref(type_a) || may_fault_on_deref(type_b))
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
@@ -17046,20 +17063,12 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
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

