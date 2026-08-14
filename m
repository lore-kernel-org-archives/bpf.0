Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC83AF650
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744393; cv=none; b=ADAx9lgl/3/Pf2jusP6Wrc2HHxONId8QXs/aN9BKJ1rBFO42948mPY2+zi0OXbc49BNL/J8LezWYcF8Pjx1WbW0jtx0NCVxN7gtCcO9RYPb6xG+iJ5mRdSH+Sa3M7MVppXrT2aQ/bDf4yr2Zv5kBhLhq2mmZGxQLyn/PJHdM0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744393; c=relaxed/simple;
	bh=h/Y6kUwMOnWbRnDUTohQZSoC4odcxy8ZIrzTiRncN60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWlpX+s9nDv1n/p8HgSk27HcK7q8k5OqkrTncQUp9jI/wNohRUtlbIP2+OAZKAw2lhaScnX8lPE5bv/1jTfXekeMRrAqEfCF13sQtPo2TPzHFA80iM2+fX5tM5b88kqi8scDx9MJrLtTq6n1C0m1/V3EUa8dMDRP+EMOApsH6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LJt8W4f5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LJt8W4f5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H58IK9mFVXDPbH2UT/ZO2DI/MTLNE5QbiV8yf3FLrD8=; b=LJt8W4f5mHI35TXoYkMka9D9RW
	2SxB3onukSoCO4BLGTpj9lrMRWiE8vTB7RhwWfixFHgvaRqPVviJl44HT5Jupbnq/PYCOSh/eKnG6
	nb/N9fuwymCCzp5Kuhn7tGc+g6t+QteEIJABlaLn/7zekci5C40nMl6qDENE0aNUpi/1XpgZE4tdg
	a52hewk//6zyy41PcK35nHG2mF7eV0VJKmVeOmoj1K7v7jc1CXEIUYiAVSIJXwSSOVOlBiINKrPhi
	1drlIWlPTDDtKMsv0U4nwNUuR7b7EkhRPB3TDdKD0CigExuW8sX/8XzvVg60BygjUM1Vq5gOiX4Tw
	L8vx1D0w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wuzpn-000F9J-24;
	Fri, 14 Aug 2026 23:53:03 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/6] bpf: Rewrite any fault prone load out of a mem or btf_id pointer
Date: Fri, 14 Aug 2026 23:52:58 +0200
Message-ID: <20260814215301.709827-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814215301.709827-1-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

bpf_convert_ctx_accesses() turns a BPF_LDX into a BPF_PROBE_MEM one by
matching the type recorded for the insn against a list of exact pointer
types. The list cannot keep up with the flag combinations the verifier
produces, and a type which is missing from it ends up as a plain load
without an exception table entry, so a bad address panics the kernel
instead of being handled.

Two such types exist today and are reachable:

  - PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF
  - PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_RCU

Rather than adding the two, just drop the list and state the property
itself in the default case of the switch. This is a superset of what
the list matched, the untrusted PTR_TO_MEM does not have to carry
MEM_RDONLY for it anymore, and it stays in sync with the verifier side
which uses the same match in save_aux_ptr_type() and reg_type_mismatch_ok().

Assert that a fault prone type which does not get the rewrite for whatever
reason is rejected at load time rather than left to fault at runtime to
catch any future cases.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - new patch, don't match on full types (Eduard)

 include/linux/bpf_verifier.h | 11 +++++++++
 kernel/bpf/fixups.c          | 47 ++++++++++++++++++++----------------
 kernel/bpf/verifier.c        | 15 ++----------
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 114ae4540d2c..7239cffa7b51 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1297,6 +1297,17 @@ static inline u32 type_flag(u32 type)
 	return type & ~BPF_BASE_TYPE_MASK;
 }
 
+static inline bool bpf_is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
+{
+	switch (base_type(type)) {
+	case PTR_TO_MEM:
+	case PTR_TO_BTF_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static inline bool bpf_may_fault_on_deref(enum bpf_reg_type type)
 {
 	/*
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c4bd70befbb5..796fba0505dc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -811,6 +811,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
+		enum bpf_reg_type ptr_type;
 		u8 mode;
 
 		if (env->insn_aux_data[i + delta].nospec) {
@@ -903,7 +904,8 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			continue;
 		}
 
-		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
+		ptr_type = env->insn_aux_data[i + delta].ptr_type;
+		switch ((int)ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
 				continue;
@@ -919,26 +921,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		case PTR_TO_XDP_SOCK:
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
-		case PTR_TO_BTF_ID:
-		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
-		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
-		 * PTR_TO_BTF_ID, and an active referenced id, but the same cannot
-		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
-		 * any faults for loads into such types. BPF_WRITE is disallowed
-		 * for this case.
-		 */
-		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
-		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
-			if (type == BPF_READ) {
-				if (BPF_MODE(insn->code) == BPF_MEM)
-					insn->code = BPF_LDX | BPF_PROBE_MEM |
-						     BPF_SIZE((insn)->code);
-				else
-					insn->code = BPF_LDX | BPF_PROBE_MEMSX |
-						     BPF_SIZE((insn)->code);
-				env->prog->aux->num_exentries++;
-			}
-			continue;
 		case PTR_TO_ARENA:
 			if (BPF_MODE(insn->code) == BPF_MEMSX) {
 				if (!bpf_jit_supports_insn(insn, true)) {
@@ -952,6 +934,29 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog->aux->num_exentries++;
 			continue;
 		default:
+			/*
+			 * A pointer which may fault on a dereference must not
+			 * be loaded from without fault protection, hence turn
+			 * the BPF_LDX into a BPF_PROBE_MEM one so that a bad
+			 * address is handled rather than panicking the kernel.
+			 * A store through one is rejected earlier, there is no
+			 * probed counterpart to rewrite it into.
+			 */
+			if (bpf_is_ptr_to_mem_or_btf_id(ptr_type) &&
+			    bpf_may_fault_on_deref(ptr_type) &&
+			    type == BPF_READ) {
+				if (BPF_MODE(insn->code) == BPF_MEM)
+					insn->code = BPF_LDX | BPF_PROBE_MEM |
+						     BPF_SIZE(insn->code);
+				else
+					insn->code = BPF_LDX | BPF_PROBE_MEMSX |
+						     BPF_SIZE(insn->code);
+				env->prog->aux->num_exentries++;
+				continue;
+			}
+			if (verifier_bug_if(bpf_may_fault_on_deref(ptr_type), env,
+					    "access to a fault prone pointer is not rewritten as a probed one"))
+				return -EFAULT;
 			continue;
 		}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6610e2437047..6fff370749bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16999,17 +16999,6 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
 			       !reg_type_mismatch_ok(prev));
 }
 
-static bool is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
-{
-	switch (base_type(type)) {
-	case PTR_TO_MEM:
-	case PTR_TO_BTF_ID:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static bool is_ptr_to_mem(enum bpf_reg_type type)
 {
 	return base_type(type) == PTR_TO_MEM;
@@ -17049,8 +17038,8 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 		 * Reject it.
 		 */
 		if (allow_trust_mismatch &&
-		    is_ptr_to_mem_or_btf_id(type) &&
-		    is_ptr_to_mem_or_btf_id(*prev_type)) {
+		    bpf_is_ptr_to_mem_or_btf_id(type) &&
+		    bpf_is_ptr_to_mem_or_btf_id(*prev_type)) {
 			/*
 			 * Have to support a use case when one path through
 			 * the program yields a TRUSTED pointer while another
-- 
2.43.0

