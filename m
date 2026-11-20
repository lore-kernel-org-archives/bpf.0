Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207850;
	b=QTd4+O+bWyoIgVPMAfYT6MKGuGGzkGE52mKBuyLeYdSF0wqBK7SjFIGFPrW8kFYftubJ
	 dC4TImNaR9TJz+ZNCN5cOuc3gwGQPXaEz9kC5Eqd9iLG/Cvllck3CAtfsqdrcxvJ+1kuR
	 BfupLSqwNGPB72fQxQErAzlDb4/JCmAUNOxHPnmDuqW9mldC/koZHcA4+SPPg2zr7mt/8
	 IfhdMLBYfCQRzgOI/oeBwa08GoGO2nkbJMi3HBNF559FlHaAVh8SevitaTiGB8c61ouVo
	 6vHQ6QUQ+riyVruG2CIBA8Fn8t7iQqNBABKu+A7N/bjyCDV+4djw/Ib96gN4a00Tu9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1LJXhHVfGcJwKk/aE+w4wlqExvx/CNWKMnzhuiLM/KU=;
	b=ciOSGLZ0HdIMPrEeom8vIc7z6D32kLmi1jdOpCe59mFFWW36DTSBbBuSMgkLlvDeI+bn
	 69gW3QepmbKBDMSnvH0ZgjyrdWKvYi0Dr4k2172v2pGx+Gew/AB7Jl127Or5+k2oqQLNR
	 SZwl/REQAb7C/aO1XlKuDk4NUDV1jaRhH6O+vHnheZ/qymsgsQwZ6T3Szmxhq1rzcfwG5
	 oUXDFROzLeYDNupF2JaUatyun8AEWlAMFuSLLHxUpTBaRD/qNEk+ijQVPQgUNVQKgXXYP
	 BrO21UZrFJUCWgYV7hKO8/r/RnU8jRC8o4fNqTsrx3N2RvWXkTLF5AV5F1KgneUKCDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGLvTEdV;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F0606A69F
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 163F0606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FGLvTEdV
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso723937a91.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207845; x=1795812645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LJXhHVfGcJwKk/aE+w4wlqExvx/CNWKMnzhuiLM/KU=;
        b=FGLvTEdV6xAqB1sWH0wGQyZ/q+m41DkHOnkeEhsOC50MCmVRog209X2kslV5QNFwkD
         Lz/acOZgD/5A415Ocp6teLx6FfowzxnXcaxjeDtq2ZCcOHvAGKNH8omFshou2Z0heKak
         /5xD9up/6GpokcqSM5RiA/JvQ3r8ku/k1ICLh/xs2uT/cmd3ABYGT8ha6pMuxlR5tUWE
         Vk23EgGik7Ilc39+KuSvRt7UCWJX0gI80VKwonae6y9Dp2hF6yg7rt/J2kMF+3nHZ4OK
         N+ZmFNYWVmXR4M6ZAO3pvGSJdjgfK5UMsk3jqdTCq4kUwivGYtVhVTT5U5lxbOYqaJNF
         LWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207845; x=1795812645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LJXhHVfGcJwKk/aE+w4wlqExvx/CNWKMnzhuiLM/KU=;
        b=KNCo7+nvN1bGqDOn6jze+lMlbY5QGqnWcNM4YPJDEX4vCd6FKiBRPRerXgXFGnO0s0
         ILM/ihspsfcq06rp+pi8Qz5NI4MTaZH/d1ntPZY2eK0PogQq2qRVR6XExKHEsbw4MRgC
         jYMIAtoHFgdrXfv+PW+wzLE4MAOgGCT8SnwU1K3lYsYJXVTcPNYIPCoe1p+EmE+VHIvq
         cdiOHNS2TAo/UpG9Zrqh7Xe2390/PekqR7DE++41S3Z78vxlLAmvFaGnq89KPS1pptVO
         y2DoLovwBzM63Ic5/DfBItu+XP63NPpCnIJqt7JzHxUmDYbslRj+4QMjbAwtBZ0HdKuB
         Sp/w==
X-Gm-Message-State: APuU4Z/y0hJm4PI+0x68muYor2wjfwiesuR1nv262HuV2X4IYg/LgzS9
	MLpYg/IYluwTKwoyQhHfNHaaVSVGfw9OPyBAIY07g3l+zkNKIOhzongxG0qi+A==
X-Gm-Gg: AZFdTZfcwfgdK1yp7M3ETTElDPBdVeB9miZYsocnGUu+156PetSijekqMuPhNNdbc0b
	wlhAoWlhlU9rklcGzXNcd8WDxldoVAWVG/3Liljv2JV7Zjao7YeQ4dK7hxOWlBNlk4/8WYT1JIN
	34mjh3ogV2IYrGIMqnXLPUClNuOf70lAtGzTMgWqQ1eHyh7qlWnnnpAaI+JgcYt8U8VmpqapjdA
	ljkRQmjsl82fxpNJD1yt+sRDds8F1Fp1gy74/cv7H1m4smQZRS006UREsXxpfDD0eUa02AwWazX
	IMCMEV7mGmZEEsoFM02BmmuDBkINqYIlFdBirsSKNUYmy2D5c19FIVPFGp/5fhM2HdW0ge+zds+
	FPA0AxDFOkl1ssSFyIoKPX4Ip3n4yshpQISSd4Swck0fAGnUIpM+BEzYDy8Hnkva0DPXXcDs3uU
	gF//ybGH/+yGGRsnCSUPfI1pLe7SjprbLV5dlc+A5iHdu3IXnFTqXlDoctSMVA7enzvgkucZdg4
	VVvs8N/Hchqg5liXnzaxqIkSGJLgLmbo8uWoOPxJq+/w6Ljq7fvQhJwKgs9sTA2V1yMdCkRODl1
	HnL2wvfFSfnlwb5fvfHFZDm7E2zEJeE3HAoN7UgAc7oCHQrRJPZntph/MQ6f5Nx8t/j9BXRdYBJ
	r1AU6tYCmij4XglJS4USC1OxReiGVJ/1qhBoIcGoa0Qdbp0IPhYxYHd+Vkc55aLSLVtbST3KxzA
	==
X-Received: by 2002:a17:90b:134e:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3b41c7b5dbfmr3940688a91.9.1795207844774;
        Fri, 20 Nov 2026 12:50:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm5538685a91.14.2026.11.20.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:50:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 07/49] bpf: Name an id after the xreg that has it
Date: Fri, 20 Nov 2026 20:49:15 +0000
Message-ID: <20261120204959.614908-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

An id stands for the set of xregs that have it. Its number depends on
the path. Two states with the same sets have other numbers:

  state 1:  r1=ptr(id=17)  r6=ptr(id=17)  r7=ptr(id=4)
  state 2:  r1=ptr(id=3)   r6=ptr(id=3)   r7=ptr(id=9)

So the compare, the join and the return from a function each had a map
from one set of ids to another.

bpf_renumber_ids() names each id after the first xreg that has it:

  both:     r1=ptr(id=r1)  r6=ptr(id=r1)  r7=ptr(id=r7)

Equal sets have equal ids now, and reg_object_equal() is a memcmp().
If r1 = r6 in one state and r1 is not set in the other, r6 has two
names and counts as two objects. The maps saw one object.

The ids are renumbered at the end of a basic block and before the call
of a function. The low bits tell the origin:

  bpf_new_id()       an insn of this basic block made it
  BPF_REF_ID()       it is held, named after its index in refs[]
  BPF_XREG_ID()      named after an xreg
  BPF_RETURNED_ID()  a function returned it

A caller and its callee have the same refs[], so they have the same
names. inherited_id(), fresh_id() and BPF_MAX_ID go away. check_ids()
stays until "bpf: Compare states by join_key, then by value".

The id of a __ref argument is not constant any more. refs[].ctx_arg
tells which argument a reference came with. The report of a leak finds
the acquire by refs[].diag_id, which is not renumbered. A reference
that leaks has no release, so the events of a release go away.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   4 +-
 include/linux/bpf_verifier.h |  57 +++++---
 kernel/bpf/btf.c             |   2 +-
 kernel/bpf/diagnostics.c     |  56 +++-----
 kernel/bpf/diagnostics.h     |   6 +-
 kernel/bpf/states.c          |  79 +++++++++-
 kernel/bpf/verifier.c        | 271 ++++++++++++-----------------------
 7 files changed, 230 insertions(+), 245 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f2cb37c19..dee0cca907b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1189,7 +1189,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
-			u32 ref_id;
+			u32 ref_arg;	/* see struct bpf_ctx_arg_aux */
 		};
 	};
 	u32 mem_size;
@@ -1827,7 +1827,7 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
-	u32 ref_id;
+	u32 ref_arg;	/* a number for a __ref argument, else 0 */
 	u32 mem_size;
 	bool refcounted;
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7977f8452e9..d63a522b465 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -241,6 +241,12 @@ static inline bool reg_fixed_part_equal(const struct bpf_reg_state *ra,
 	return ra->type == rb->type && !memcmp(&ra->raw, &rb->raw, sizeof(ra->raw));
 }
 
+/* That and the ids, see bpf_renumber_ids() */
+static inline bool reg_object_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
+{
+	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, var_off));
+}
+
 /* All but the ids */
 static inline bool reg_value_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
 {
@@ -366,9 +372,13 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
+	u32 diag_id;	/* finds the acquire in the report of a leak, it is not renumbered */
 	union {
 		/* For REF_TYPE_PTR */
-		int parent_id;
+		struct {
+			int parent_id;
+			u32 ctx_arg;	/* it came with that __ref argument, the first is 1 */
+		};
 		/* Use to keep track of the source object of a lock, to ensure
 		 * it matches on unlock.
 		 */
@@ -548,15 +558,17 @@ struct bpf_verifier_state {
 	u32 insn_idx;
 	u32 curframe;
 
+	struct_group(held,
+	void *active_lock_ptr;
 	u32 acquired_refs;
 	u32 active_locks;
 	u32 active_preempt_locks;
+	u32 active_rcu_locks;
 	u32 active_irq_id;
 	u32 active_lock_id;
-	void *active_lock_ptr;
-	u32 active_rcu_locks;
 
 	bool speculative;
+	);
 	bool in_sleepable;
 	/* a global function or an extension, and what it calls: exit of frame 0 is not the end */
 	bool callers_unknown;
@@ -1095,21 +1107,29 @@ struct bpf_id_pair {
 };
 
 /*
- * A function that is verified on its own, see func_is_on_its_own(), has no ids of its caller.
- * It has names for the ids of what is held: BPF_INHERITED_ID + i is the id of refs[i] at the call.
- * - A name depends only on the place. Each id in the state at the entry is replaced with its name.
- *   The ids of the caller can be names that it got from its own caller: they are replaced too.
- * - A name stands for the same thing in all states of the function. It is equal only to itself:
- *   check_ids() and jid_note() do not rename it. So two calls share a state at the entry, and what
- *   comes out for it, only if the same places have the same names.
- * - bpf_flow_return() puts the ids of the call that waits back. All other ids get new values.
- * - What comes out has the ranges of all calls that share the state at the entry. So a name is good
- *   for what holds whatever the ranges are: the same object. Other ids have no name: such an
- *   argument keeps the frames of the caller, see arg_needs_caller().
- * - env->id_gen stays below BPF_MAX_ID. So no id is a name.
+ * At a join point each id is named after the xreg that has it, see bpf_renumber_ids().
+ * The low bits give the origin of the id:
+ *
+ *  bpf_new_id()       an insn made it. It is renumbered at the end of the basic block.
+ *  BPF_REF_ID()       it is held. The number comes from the index in refs[].
+ *  BPF_XREG_ID()      the number comes from the first xreg that has it.
+ *  BPF_RETURNED_ID()  a function on its own returned it. No xreg of the caller has it.
+ *
+ * A function on its own, see func_is_on_its_own(), and its waiting call have the same ids for
+ * what is held. An exit state has the ranges of all calls of the instance. So such id shows
+ * only what holds for all ranges: the same object. An argument with another id keeps the
+ * frames of the caller, see arg_needs_caller().
  */
-#define BPF_INHERITED_ID	0x20000000
-#define BPF_MAX_ID		(BPF_INHERITED_ID / 2)
+#define bpf_new_id(env)		(((env)->id_gen += 4) - 3)
+#define BPF_REF_ID(i)		(((i) + 1) << 2)
+#define BPF_XREG_ID(i)		((i) << 2 | 2)
+#define BPF_RETURNED_ID(id)	((id) | 1)
+
+/* @id is 0 or renumbered: BPF_REF_ID() or BPF_XREG_ID() */
+static inline bool bpf_id_is_xreg(u32 id)
+{
+	return id & 2;
+}
 
 struct bpf_idmap {
 	u32 cnt;
@@ -1509,6 +1529,8 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state *old,
 			struct bpf_verifier_state *cur);
 
+int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
+
 /*
  * The two limits of the verifier, for the whole load. The unit of cost is one step of a scan,
  * about a dozen insns of the CPU. Memory is the bytes of states and tables at a time.
@@ -1553,6 +1575,7 @@ void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h
 bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env);
 void bpf_flow_new_round(struct bpf_verifier_env *env);
 int bpf_flow_place_guards(struct bpf_verifier_env *env);
+#define BPF_EXIT_NEEDS_CALLER	1	/* verify the call in the frames of the caller */
 int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		    const struct bpf_verifier_state *exit, int call_idx);
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2f28b418a7f..3d278a2c29c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7645,7 +7645,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
-			info->ref_id = ctx_arg_info->ref_id;
+			info->ref_arg = ctx_arg_info->ref_arg;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 5783fa20f56..25d7982327d 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -114,7 +114,6 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
 	BPF_DIAG_HISTORY_MOD,
 	BPF_DIAG_HISTORY_REF_ACQUIRE,
-	BPF_DIAG_HISTORY_REF_RELEASE,
 	BPF_DIAG_HISTORY_CONTEXT,
 };
 
@@ -134,7 +133,7 @@ struct bpf_diag_history_event {
 			bool origin_valid;
 		} mod;
 		struct {
-			u32 ref_id;
+			u32 diag_id;
 		} ref;
 		struct {
 			u32 depth;
@@ -157,7 +156,7 @@ struct bpf_diag_history_opts {
 	u32 frameno;
 	int regno;
 	int stack_arg_slot;
-	u32 ref_id;
+	const struct bpf_reference_state *ref;
 	enum bpf_diag_context_kind ctx_kind;
 	u32 ctx_depth;
 };
@@ -220,6 +219,7 @@ struct bpf_diag {
 	struct list_head fmt_chunks;
 	struct bpf_diag_mod_scope mod;
 	u32 frame_id_gen;
+	u32 ref_id_gen;
 };
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env)
@@ -1693,29 +1693,19 @@ void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env,
 			reason, NULL, NULL, NULL);
 }
 
-static void diag_record_ref(struct bpf_verifier_env *env, u32 insn_idx, u8 kind, u32 ref_id)
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, struct bpf_reference_state *ref)
 {
 	struct bpf_diag_history_event event = {
-		.insn_idx = insn_idx,
-		.kind = kind,
-		.ref = {
-			.ref_id = ref_id,
-		},
+		.insn_idx = ref->insn_idx,
+		.kind = BPF_DIAG_HISTORY_REF_ACQUIRE,
 	};
 
+	if (!env->diag)
+		return;
+	event.ref.diag_id = ref->diag_id = ++env->diag->ref_id_gen;
 	diag_append_history(env, &event);
 }
 
-void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id)
-{
-	diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_ACQUIRE, ref_id);
-}
-
-void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id)
-{
-	diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_RELEASE, ref_id);
-}
-
 void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
 			     enum bpf_diag_context_kind ctx_kind, bool enter, u32 depth)
 {
@@ -1864,7 +1854,7 @@ static int diag_history_start_idx(const struct bpf_diag_log *log,
 
 		event = &log->events[log_pos(log, i - 1)];
 		if (event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE &&
-		    event->ref.ref_id == opts->ref_id)
+		    event->ref.diag_id == opts->ref->diag_id)
 			return i - 1;
 	}
 
@@ -1882,9 +1872,8 @@ static bool diag_history_event_visible(const struct bpf_diag_history_event *even
 	case BPF_DIAG_HISTORY_MOD:
 		return filter->lineage_valid && event->in_lineage;
 	case BPF_DIAG_HISTORY_REF_ACQUIRE:
-	case BPF_DIAG_HISTORY_REF_RELEASE:
 		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
-		       event->ref.ref_id == opts->ref_id;
+		       event->ref.diag_id == opts->ref->diag_id;
 	case BPF_DIAG_HISTORY_CONTEXT:
 		return opts->scope == BPF_DIAG_HISTORY_SCOPE_CONTEXT &&
 		       event->ctx.kind == opts->ctx_kind;
@@ -2071,21 +2060,22 @@ void bpf_diag_irq(struct bpf_verifier_env *env, u32 insn_idx, const char *proble
 	diag_suggestion(env, "%s", suggestion);
 }
 
-void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn)
+void bpf_diag_leak(struct bpf_verifier_env *env, const struct bpf_reference_state *ref,
+		   u32 fail_insn)
 {
 	struct bpf_diag_history_opts opts = {
 		.scope = BPF_DIAG_HISTORY_SCOPE_REF,
-		.ref_id = ref_id,
+		.ref = ref,
 	};
 
 	bpf_diag_header(env, RESOURCE_LIFETIME_SAFETY, "unreleased resource");
 	diag_reason(
 		env, "Owned resource (id=%u) was acquired at instruction %u and still needs to be released before this exit path.",
-		ref_id, alloc_insn);
+		ref->id, ref->insn_idx);
 
 	diag_section(env, "At");
 	bpf_diag_source(env, fail_insn, "error",
-			"owned resource (id=%u) still needs release", ref_id);
+			"owned resource (id=%u) still needs release", ref->id);
 
 	diag_print_history(env, &opts);
 
@@ -2258,16 +2248,6 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 			old, new);
 }
 
-static void diag_print_ref_event(struct bpf_verifier_env *env,
-				 const struct bpf_diag_history_event *event)
-{
-	const char *label;
-
-	label = event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE ? "acquired" : "released";
-	bpf_diag_source(env, event->insn_idx, label, "owned resource (id=%u)",
-			event->ref.ref_id);
-}
-
 static const char *diag_context_name(enum bpf_diag_context_kind kind)
 {
 	switch (kind) {
@@ -2362,8 +2342,8 @@ static void diag_print_history(struct bpf_verifier_env *env,
 			diag_print_mod(env, event);
 			break;
 		case BPF_DIAG_HISTORY_REF_ACQUIRE:
-		case BPF_DIAG_HISTORY_REF_RELEASE:
-			diag_print_ref_event(env, event);
+			bpf_diag_source(env, event->insn_idx, "acquired", "owned resource (id=%u)",
+					opts->ref->id);
 			break;
 		case BPF_DIAG_HISTORY_CONTEXT:
 			diag_print_context_event(env, event);
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index e155d2588a5..f6380137e9a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -77,7 +77,8 @@ void bpf_diag_lock(struct bpf_verifier_env *env, u32 insn_idx, const char *probl
 		   const struct bpf_reference_state *active_lock);
 void bpf_diag_irq(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
 		  const char *reason, const char *suggestion, u32 depth);
-void bpf_diag_leak(struct bpf_verifier_env *env, u32 ref_id, u32 alloc_insn, u32 fail_insn);
+void bpf_diag_leak(struct bpf_verifier_env *env, const struct bpf_reference_state *ref,
+		   u32 fail_insn);
 void bpf_diag_call_type(struct bpf_verifier_env *env, u32 insn_idx, int argno, int regno,
 			int stack_arg_slot, const char *call_name, const char *arg_name,
 			const char *reason, const char *suggestion);
@@ -104,8 +105,7 @@ void bpf_diag_record_scrub(struct bpf_verifier_env *env, const struct bpf_reg_st
 void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state, s16 min_off, s16 max_off,
 				 enum bpf_diag_mod_reason reason);
-void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
-void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, struct bpf_reference_state *ref);
 void bpf_diag_record_context(struct bpf_verifier_env *env, u32 insn_idx,
 			     enum bpf_diag_context_kind ctx_kind, bool enter, u32 depth);
 
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5d78a10dd29..854db8ee6a2 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -35,6 +35,83 @@ static bool range_within(const struct bpf_reg_state *old,
 	       (cur->base - old->base) % old->step == 0;
 }
 
+static void renumber_id(struct bpf_verifier_env *env, u32 *id, u32 new_id)
+{
+	struct bpf_idmap *map = &env->idmap_scratch;
+	u32 i;
+
+	if (!*id)
+		return;
+	for (i = 0; i < map->cnt && map->map[i].old != *id; i++)
+		;
+	bpf_add_cost(env, 2 * i, BPF_COST_SCAN);
+	if (i == BPF_ID_MAP_SIZE)
+		return;
+	if (i == map->cnt)
+		map->map[map->cnt++] = (struct bpf_id_pair){ *id, new_id };
+	*id = map->map[i].cur;
+}
+
+static void renumber_reg_ids(struct bpf_verifier_env *env, struct bpf_reg_state *reg, u32 xreg)
+{
+	renumber_id(env, &reg->id, BPF_XREG_ID(3 * xreg));
+	renumber_id(env, &reg->parent_id, BPF_XREG_ID(3 * xreg + 1));
+	renumber_id(env, &reg->map_uid, BPF_XREG_ID(3 * xreg + 2));
+}
+
+/*
+ * An id stands for the set of xregs that have it. Name it after the first one. What is held goes
+ * first. Then states with the same sets have the same ids, and ids are compared as they are.
+ * The name is the xreg, not a number in a sequence. So an xreg that is not set does not change
+ * the names of other sets. But if only one state has r1 = r6, r6 has two names.
+ * Visit an xreg once: a name can be the old id of another xreg.
+ */
+int bpf_renumber_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	u32 mask[] = { BIT(STACK_SPILL),
+		       BIT(STACK_DYNPTR) | BIT(STACK_ITER) | BIT(STACK_IRQ_FLAG) };
+	struct bpf_idmap *map = &env->idmap_scratch;
+	struct bpf_reg_state *reg;
+	struct bpf_func_state *f;
+	u32 fr, i, xreg;
+	int held;
+
+	map->cnt = 0;
+	for (i = 0; i < st->acquired_refs && i < BPF_ID_MAP_SIZE; i++) {
+		renumber_id(env, &st->refs[i].id, BPF_REF_ID(2 * i));
+		if (st->refs[i].type == REF_TYPE_PTR)
+			renumber_id(env, &st->refs[i].parent_id, BPF_REF_ID(2 * i + 1));
+	}
+	/* they are among these */
+	renumber_id(env, &st->active_irq_id, 0);
+	renumber_id(env, &st->active_lock_id, 0);
+	for (held = 1; held >= 0; held--) {
+		for (fr = 0; fr <= st->curframe; fr++) {
+			f = st->frame[fr];
+			/* registers, the frame, slots, arguments */
+			xreg = fr * (BPF_ID_MAP_SIZE / MAX_CALL_FRAMES + 1) + MAX_BPF_REG;
+			if (held)
+				renumber_id(env, &f->frame_id, BPF_XREG_ID(3 * xreg));
+			for (i = 0; i < bpf_stack_nr_slots(f); i++) {
+				reg = bpf_get_spilled_reg(i, f, mask[held]);
+				if (reg)
+					renumber_reg_ids(env, reg, xreg + 1 + i);
+			}
+			if (held)
+				continue;
+			for (i = 0; i < MAX_BPF_REG; i++)
+				renumber_reg_ids(env, &f->regs[i], xreg - MAX_BPF_REG + i);
+			for (i = 0; i < f->out_stack_arg_cnt; i++)
+				renumber_reg_ids(env, &f->stack_arg_regs[i],
+						 xreg + 1 + MAX_BPF_STACK_SLOTS + i);
+		}
+	}
+	if (map->cnt < BPF_ID_MAP_SIZE && st->acquired_refs < BPF_ID_MAP_SIZE)
+		return 0;
+	bpf_log(&env->log, "too many ids\n");
+	return -E2BIG;
+}
+
 /* If in the old state two registers had the same id, then they need to have
  * the same id in the new state as well.  But that id could be different from
  * the old state, so we need to track the mapping from old to new ids.
@@ -189,7 +266,7 @@ int bpf_clean_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_s
 
 		__clean_func_state(env, st->frame[i], live_regs, i);
 	}
-	return 0;
+	return bpf_renumber_ids(env, st);
 }
 
 static bool regs_exact(const struct bpf_reg_state *rold,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c1aeec4069..d43009b41bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -205,8 +205,7 @@ struct bpf_verifier_stack_elem {
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id);
-static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
-static int release_reference_nomark(struct bpf_verifier_env *env, int id);
+static int release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static int invalidate_reference(struct bpf_verifier_env *env, int id);
 static u32 reg_lifetime_id(struct bpf_verifier_env *env,
@@ -717,7 +716,7 @@ static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg2,
 				   enum bpf_dynptr_type type, int parent_id)
 {
-	int id = ++env->id_gen;
+	int id = bpf_new_id(env);
 
 	__mark_dynptr_reg(sreg1, type, true, id, parent_id);
 	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
@@ -727,7 +726,7 @@ static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
+	__mark_dynptr_reg(reg, type, true, bpf_new_id(env), 0);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@ -1439,13 +1438,7 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	if (!dst->refs)
 		return -ENOMEM;
 
-	dst->acquired_refs = src->acquired_refs;
-	dst->active_locks = src->active_locks;
-	dst->active_preempt_locks = src->active_preempt_locks;
-	dst->active_rcu_locks = src->active_rcu_locks;
-	dst->active_irq_id = src->active_irq_id;
-	dst->active_lock_id = src->active_lock_id;
-	dst->active_lock_ptr = src->active_lock_ptr;
+	dst->held = src->held;
 	return 0;
 }
 
@@ -1556,9 +1549,9 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	if (!s)
 		return -ENOMEM;
 	s->type = REF_TYPE_PTR;
-	s->id = ++env->id_gen;
+	s->id = bpf_new_id(env);
 	s->parent_id = parent_id;
-	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
+	bpf_diag_record_ref_acquire(env, s);
 	return s->id;
 }
 
@@ -1592,7 +1585,7 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 	if (!s)
 		return -ENOMEM;
 	s->type = REF_TYPE_IRQ;
-	s->id = ++env->id_gen;
+	s->id = bpf_new_id(env);
 
 	state->active_irq_id = s->id;
 	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true,
@@ -2504,7 +2497,7 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 		regs[regno].btf = btf;
 		regs[regno].btf_id = btf_id;
 		if (type_may_be_null(flag))
-			regs[regno].id = ++env->id_gen;
+			regs[regno].id = bpf_new_id(env);
 		return 0;
 	case PTR_TO_MEM:
 		mark_reg_known_zero(env, regs, regno);
@@ -4758,7 +4751,7 @@ static int mark_uptr_ld_reg(struct bpf_verifier_env *env, u32 regno,
 	reg = reg_state(env, regno);
 	reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
 	reg->mem_size = t->size;
-	reg->id = ++env->id_gen;
+	reg->id = bpf_new_id(env);
 
 	return 0;
 }
@@ -4974,6 +4967,17 @@ static bool is_var_ctx_off_allowed(struct bpf_prog *prog)
 	return resolve_prog_type(prog) == BPF_PROG_TYPE_SYSCALL;
 }
 
+/* The id of the reference that came with __ref argument @arg. 0 if there is none. */
+static u32 ctx_arg_ref_id(const struct bpf_verifier_state *st, u32 arg)
+{
+	u32 i;
+
+	for (i = 0; arg && i < st->acquired_refs; i++)
+		if (st->refs[i].type == REF_TYPE_PTR && st->refs[i].ctx_arg == arg)
+			return st->refs[i].id;
+	return 0;
+}
+
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets only */
 static int __check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off, int size,
 			      enum bpf_access_type t, struct bpf_insn_access_aux *info)
@@ -4988,8 +4992,7 @@ static int __check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int of
 		 * type of narrower access.
 		 */
 		if (base_type(info->reg_type) == PTR_TO_BTF_ID) {
-			if (info->ref_id &&
-			    !find_reference_state(env->cur_state, info->ref_id)) {
+			if (info->ref_arg && !ctx_arg_ref_id(env->cur_state, info->ref_arg)) {
 				verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n",
 					off);
 				return -EACCES;
@@ -7366,12 +7369,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
-					regs[value_regno].id = info.ref_id;
+					regs[value_regno].id =
+						ctx_arg_ref_id(env->cur_state, info.ref_arg);
 				} else if (base_type(info.reg_type) == PTR_TO_MEM) {
 					regs[value_regno].mem_size = info.mem_size;
 				}
 				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
-					regs[value_regno].id = ++env->id_gen;
+					regs[value_regno].id = bpf_new_id(env);
 			}
 			regs[value_regno].type = info.reg_type;
 		}
@@ -10873,7 +10877,7 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
-static int __release_reference_nomark(struct bpf_verifier_state *state, int id)
+static int release_reference_nomark(struct bpf_verifier_state *state, int id)
 {
 	int i;
 
@@ -10888,16 +10892,6 @@ static int __release_reference_nomark(struct bpf_verifier_state *state, int id)
 	return -EINVAL;
 }
 
-static int release_reference_nomark(struct bpf_verifier_env *env, int id)
-{
-	int err;
-
-	err = __release_reference_nomark(env->cur_state, id);
-	if (!err)
-		bpf_diag_record_ref_release(env, env->insn_idx, id);
-	return err;
-}
-
 static int idstack_push(struct bpf_idmap *idmap, u32 id)
 {
 	int i;
@@ -10994,7 +10988,7 @@ static int invalidate_reference(struct bpf_verifier_env *env, int id)
 static int release_reference(struct bpf_verifier_env *env, int id)
 {
 	if (find_reference_state(env->cur_state, id))
-		WARN_ON_ONCE(release_reference_nomark(env, id));
+		WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
 
 	return invalidate_reference(env, id);
 }
@@ -11035,7 +11029,7 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_nomark(env, id);
+	err = release_reference_nomark(env->cur_state, id);
 	if (err)
 		return err;
 
@@ -11374,40 +11368,23 @@ static void account_current_path(struct bpf_verifier_env *env);
  * callers have: nothing points to their stack.
  *
  * What the callers hold, references, locks and so on, is a part of that state:
- * it matters for what the function may do. Calls that differ in ids only
- * have to get to the same state, so the ids of what is held are replaced with
- * BPF_INHERITED_ID + the position for the function, and put back at the return.
+ * it matters for what the function can do.
  */
 
-/* 0 if it is not held */
-static u32 inherited_id(const struct bpf_verifier_state *state, u32 id)
-{
-	int i;
-
-	/* the first one: a lock in an object that the caller owns has the id of the reference */
-	for (i = 0; id && i < state->acquired_refs; i++)
-		if (state->refs[i].id == id)
-			return BPF_INHERITED_ID + i;
-	return 0;
-}
-
 /* What func_is_on_its_own() asks of an argument, be it in a register or on the stack */
 static bool arg_needs_caller(struct bpf_verifier_env *env, const struct bpf_verifier_state *state,
 			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *reg)
 {
-	/* the id of a __ref argument is kept in ctx_arg_info[], see __check_ctx_access() */
+	/* it can load a __ref argument from the context and release it */
 	if (reg->type == PTR_TO_CTX && state->acquired_refs &&
 	    env->prog->type == BPF_PROG_TYPE_STRUCT_OPS)
 		return true;
-	/* only the ids of what is held have names */
-	if (reg->type != SCALAR_VALUE &&
-	    ((reg->id && !inherited_id(state, reg->id)) ||
-	     (reg->parent_id && !inherited_id(state, reg->parent_id)) ||
-	     (reg->map_uid && !inherited_id(state, reg->map_uid))))
+	/* only the ids of what is held mean something without the caller */
+	if (bpf_id_is_xreg(reg->id | reg->parent_id | reg->map_uid))
 		return true;
 	/*
-	 * Pointers to the packet that share an id have ranges of the same size, see
-	 * find_good_pkt_pointers(). What comes out of the function has the range of all calls.
+	 * Packet pointers that share an id have ranges of the same size, see
+	 * find_good_pkt_pointers(). The result has the range of all calls of the instance.
 	 */
 	if (reg_is_pkt_pointer(reg) && reg->id)
 		return true;
@@ -11438,9 +11415,6 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 	/* what must not be done in that callback is refused by looking at the frames */
 	if (in_rbtree_lock_required_cb(env))
 		return false;
-	/* there are that many names for what is held, and bpf_flow_return() has room for them */
-	if (state->acquired_refs > BPF_ID_MAP_SIZE / 2)
-		return false;
 	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
 		if (!(live & BIT(i)))
 			continue;
@@ -11494,29 +11468,9 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 		bpf_free_verifier_state(env, &entry, false);
 		return err;
 	}
-	for (i = 0; i < entry.acquired_refs; i++) {
-		/* the id of a lock is the id of the pointer to it, which may have none */
-		entry.refs[i].id = inherited_id(state, entry.refs[i].id);
-		if (entry.refs[i].type == REF_TYPE_PTR)
-			entry.refs[i].parent_id = inherited_id(state, entry.refs[i].parent_id);
-	}
-	entry.active_irq_id = inherited_id(state, entry.active_irq_id);
-	entry.active_lock_id = inherited_id(state, entry.active_lock_id);
 	callee->entry_refs = entry.acquired_refs;
 	callee->entry_rcu_locks = entry.active_rcu_locks;
 	callee->entry_preempt_locks = entry.active_preempt_locks;
-	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
-		callee->regs[i].id = inherited_id(state, callee->regs[i].id);
-		callee->regs[i].parent_id = inherited_id(state, callee->regs[i].parent_id);
-		callee->regs[i].map_uid = inherited_id(state, callee->regs[i].map_uid);
-	}
-	for (i = 0; i < callee->out_stack_arg_cnt; i++) {
-		callee->stack_arg_regs[i].id = inherited_id(state, callee->stack_arg_regs[i].id);
-		callee->stack_arg_regs[i].parent_id =
-			inherited_id(state, callee->stack_arg_regs[i].parent_id);
-		callee->stack_arg_regs[i].map_uid =
-			inherited_id(state, callee->stack_arg_regs[i].map_uid);
-	}
 
 	account_current_path(env);
 	env->subprog_info[subprog].on_its_own = true;
@@ -11554,39 +11508,39 @@ static int exit_func_on_its_own(struct bpf_verifier_env *env)
 	return err ?: PROCESS_BPF_EXIT;
 }
 
-static u32 fresh_id(struct bpf_verifier_env *env, struct bpf_idmap *idmap, u32 id)
+static u32 returned_id(u32 id)
 {
-	u32 i;
-
-	if (!id)
-		return 0;
-	for (i = 0; i < idmap->cnt; i++)
-		if (idmap->map[i].old == id)
-			return idmap->map[i].cur;
-	if (idmap->cnt == BPF_ID_MAP_SIZE)
-		return 0;
-	idmap->map[idmap->cnt].old = id;
-	idmap->map[idmap->cnt].cur = ++env->id_gen;
-	return idmap->map[idmap->cnt++].cur;
+	return bpf_id_is_xreg(id) ? BPF_RETURNED_ID(id) : id;
 }
 
 /*
- * @caller waits at the call at @call_idx and @exit is what came out of the
- * function. Make @caller what it is after the call.
- * Returns 1 if the call has to be verified in the context of the caller.
+ * @caller waits at the call at @call_idx. @exit is the state at the exit of the
+ * function. Make @caller the state after the call.
  */
 int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
 		    const struct bpf_verifier_state *exit, int call_idx)
 {
 	struct bpf_func_state *frame = caller->frame[caller->curframe];
 	const struct bpf_func_state *callee = exit->frame[0];
-	struct bpf_idmap *idmap = &env->idmap_scratch;
-	u32 caller_rcu = caller->active_rcu_locks, caller_preempt = caller->active_preempt_locks;
-	struct bpf_reference_state *held;
+	u32 i, nregs, nheld = caller->acquired_refs;
 	struct bpf_reg_state *reg;
-	u32 i, j, nregs, nheld, kept = 0, id;
 	int err;
 
+	/*
+	 * Keep only what the function held all the time. The state at its exit looks the same if
+	 * the function released a lock and acquired it again. Else verify the function in the
+	 * instance of the caller.
+	 */
+	if (callee->entry_refs < nheld || callee->entry_rcu_locks < caller->active_rcu_locks ||
+	    callee->entry_preempt_locks < caller->active_preempt_locks) {
+		if (exit->speculative)
+			return -EACCES;
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "func#%d releases what its caller holds at insn %d\n",
+				callee->subprogno, call_idx);
+		env->subprog_info[callee->subprogno].releases_inherited = true;
+		return BPF_EXIT_NEEDS_CALLER;
+	}
 	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + 1])) {
 		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d\n",
 			call_idx);
@@ -11601,7 +11555,7 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 	 */
 	if (exit->changed_pkt_data) {
 		env->subprog_info[callee->subprogno].changes_pkt_data = true;
-		return 1;
+		return BPF_EXIT_NEEDS_CALLER;
 	}
 
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
@@ -11610,70 +11564,20 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		bpf_mark_reg_not_init(env, &frame->stack_arg_regs[i]);
 
 	/* what is held now is what was held at the call and what the function took */
-	held = caller->refs;
-	nheld = caller->acquired_refs;
-	caller->refs = NULL;
-	caller->acquired_refs = 0;
-	err = copy_reference_state(caller, exit);
-	if (err) {
-		kfree(held);
+	err = resize_reference_state(caller, exit->acquired_refs);
+	if (err)
 		return err;
-	}
+	for (i = nheld; i < exit->acquired_refs; i++)
+		caller->refs[i] = exit->refs[i];
+	caller->held = exit->held;
 
-	/*
-	 * The same state comes out for every call. Ids in it have to be new
-	 * every time, or two calls in a row return the same object.
-	 */
-	idmap->cnt = 0;
-	for (i = 0; i < nheld; i++) {
-		idmap->map[idmap->cnt].old = BPF_INHERITED_ID + i;
-		idmap->map[idmap->cnt++].cur = held[i].id;
-	}
-	/*
-	 * What is taken is added at the end. What is released leaves no hole. Only what the
-	 * function held all the time is kept: the state at its exit looks the same when it
-	 * released a lock and took it again, or took another lock that has no id either.
-	 */
-	for (i = 0; i < nheld && i < callee->entry_refs; i++) {
-		/* see inherited_id() */
-		for (j = 0; held[j].id != held[i].id; j++)
-			;
-		id = held[i].id ? BPF_INHERITED_ID + j : 0;
-		if (caller->refs[i].id != id || caller->refs[i].type != held[i].type)
-			break;
-		caller->refs[i] = held[i];
-		kept++;
-	}
-	kfree(held);
-	/* What it means for the caller is found out in the context of the caller. */
-	if (kept != nheld || callee->entry_rcu_locks < caller_rcu ||
-	    callee->entry_preempt_locks < caller_preempt) {
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "func#%d releases what its caller holds at insn %d\n",
-				callee->subprogno, call_idx);
-		env->subprog_info[callee->subprogno].releases_inherited = true;
-		return 1;
-	}
 	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
 	for (i = 0; i < nregs; i++) {
 		reg = &frame->regs[ret_regs[i]];
 		*reg = callee->regs[ret_regs[i]];
-		reg->id = fresh_id(env, idmap, reg->id);
-		reg->parent_id = fresh_id(env, idmap, reg->parent_id);
-		reg->map_uid = fresh_id(env, idmap, reg->map_uid);
-	}
-	/* those that were held are the first */
-	for (i = nheld; i < caller->acquired_refs; i++) {
-		caller->refs[i].id = fresh_id(env, idmap, caller->refs[i].id);
-		if (caller->refs[i].type == REF_TYPE_PTR)
-			caller->refs[i].parent_id = fresh_id(env, idmap, caller->refs[i].parent_id);
-	}
-	caller->active_irq_id = fresh_id(env, idmap, caller->active_irq_id);
-	caller->active_lock_id = fresh_id(env, idmap, caller->active_lock_id);
-	/* fresh_id() had no room for an id, or there are no ids left */
-	if (idmap->cnt == BPF_ID_MAP_SIZE || env->id_gen >= BPF_MAX_ID) {
-		verbose(env, "too many ids at the call at insn %d\n", call_idx);
-		return -E2BIG;
+		reg->id = returned_id(reg->id);
+		reg->parent_id = returned_id(reg->parent_id);
+		reg->map_uid = returned_id(reg->map_uid);
 	}
 	return 0;
 }
@@ -12033,7 +11937,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 
 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_1], PTR_TO_MAP_KEY);
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
-	callee->regs[BPF_REG_3].id = ++env->id_gen;
+	callee->regs[BPF_REG_3].id = bpf_new_id(env);
 
 	/* pointer to stack or null */
 	callee->regs[BPF_REG_4] = caller->regs[BPF_REG_3];
@@ -12045,7 +11949,7 @@ void mark_frame_scoped_arg(struct bpf_verifier_env *env,
 			   struct bpf_func_state *callee, u32 regno)
 {
 	if (!callee->frame_id)
-		callee->frame_id = ++env->id_gen;
+		callee->frame_id = bpf_new_id(env);
 	callee->regs[regno].id = callee->frame_id;
 	callee->regs[regno].parent_id = callee->frame_id;
 }
@@ -12131,7 +12035,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_1], CONST_PTR_TO_MAP);
 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_1], PTR_TO_MAP_KEY);
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
-	callee->regs[BPF_REG_3].id = ++env->id_gen;
+	callee->regs[BPF_REG_3].id = bpf_new_id(env);
 
 	callee->in_async_callback_fn = true;
 	return 0;
@@ -12222,7 +12126,7 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_3], CONST_PTR_TO_MAP);
 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_3], PTR_TO_MAP_KEY);
 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_3], PTR_TO_MAP_VALUE);
-	callee->regs[BPF_REG_3].id = ++env->id_gen;
+	callee->regs[BPF_REG_3].id = bpf_new_id(env);
 
 	callee->in_async_callback_fn = true;
 	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
@@ -12369,7 +12273,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 				continue;
 			verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 				state->refs[i].id, state->refs[i].insn_idx);
-			bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, *insn_idx);
+			bpf_diag_leak(env, &state->refs[i], *insn_idx);
 			return -EINVAL;
 		}
 
@@ -12590,7 +12494,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
-		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->insn_idx);
+		bpf_diag_leak(env, &state->refs[i], env->insn_idx);
 		refs_lingering = true;
 	}
 	return refs_lingering ? -EINVAL : 0;
@@ -13098,7 +13002,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
 		if (type_may_be_null(ret_flag) ||
 		    btf_record_has_field(meta.map.ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
-			regs[BPF_REG_0].id = ++env->id_gen;
+			regs[BPF_REG_0].id = bpf_new_id(env);
 		}
 		/* requires regs[BPF_REG_0].id to be set because of the map-in-map case */
 		refine_map_lookup_value(&regs[BPF_REG_0]);
@@ -13200,7 +13104,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (type_may_be_null(regs[BPF_REG_0].type) && !regs[BPF_REG_0].id)
-		regs[BPF_REG_0].id = ++env->id_gen;
+		regs[BPF_REG_0].id = bpf_new_id(env);
 
 	if (is_ptr_cast_function(func_id) &&
 	    find_reference_state(env->cur_state, meta.ref_obj.id)) {
@@ -14670,7 +14574,7 @@ static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_nomark(env, id);
+	err = release_reference_nomark(env->cur_state, id);
 	WARN_ON_ONCE(err);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
@@ -16048,7 +15952,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (is_kfunc_ret_null(&meta)) {
 			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
-			regs[BPF_REG_0].id = ++env->id_gen;
+			regs[BPF_REG_0].id = bpf_new_id(env);
 		}
 		if (is_kfunc_acquire(&meta)) {
 			id = acquire_reference(env, insn_idx, 0);
@@ -16060,7 +15964,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
-			regs[BPF_REG_0].id = ++env->id_gen;
+			regs[BPF_REG_0].id = bpf_new_id(env);
 	} else if (btf_type_is_void(t)) {
 		if (meta.btf == btf_vmlinux) {
 			if (is_bpf_obj_drop_kfunc(meta.func_id) ||
@@ -16674,7 +16578,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
 			if (!known)
-				dst_reg->id = ++env->id_gen;
+				dst_reg->id = bpf_new_id(env);
 			/*
 			 * The range is what umax of the pointer may get to, see
 			 * check_packet_access(). umax of the addend was added to it
@@ -16725,7 +16629,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		dst_reg->raw = ptr_reg->raw;
 		if (reg_is_pkt_pointer(ptr_reg)) {
 			if (!known)
-				dst_reg->id = ++env->id_gen;
+				dst_reg->id = bpf_new_id(env);
 			/*
 			 * Clear range if the subtrahend may be negative since
 			 * pkt pointer could move past its bounds. A positive
@@ -18835,7 +18739,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(__release_reference_nomark(vstate, id));
+		WARN_ON_ONCE(release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
@@ -20493,10 +20397,13 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			mark_reg_scratched(env, BPF_REG_0);
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
 				end_stack_arg_loads(env, cur_func(env));
+			/* func_is_on_its_own() uses the names of the ids */
 			if (bpf_is_callx(insn))
-				return check_func_callx(env, insn, &env->insn_idx);
+				return bpf_renumber_ids(env, env->cur_state) ?:
+				       check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_CALL)
-				return check_func_call(env, insn, &env->insn_idx);
+				return bpf_renumber_ids(env, env->cur_state) ?:
+				       check_func_call(env, insn, &env->insn_idx);
 			/* a callback is one function */
 			for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
 				err = split_func_set(env, i);
@@ -20809,11 +20716,6 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		struct bpf_insn_aux_data *insn_aux;
 		int err;
 
-		/* no insn makes as many ids as there are from here to BPF_INHERITED_ID */
-		if (env->id_gen >= BPF_MAX_ID) {
-			verbose(env, "too many ids\n");
-			return -E2BIG;
-		}
 		err = bpf_check_limits(env);
 		if (err)
 			return err;
@@ -22168,7 +22070,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 				 * Take it for that of an skb, so that a write
 				 * through it and its slices are treated with care.
 				 */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_SKB, true, ++env->id_gen, 0);
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_SKB, true,
+						  bpf_new_id(env), 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
@@ -22176,7 +22079,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 				mark_reg_known_zero(env, regs, i);
 				reg->mem_size = arg->mem_size;
 				if (arg->arg_type & PTR_MAYBE_NULL)
-					reg->id = ++env->id_gen;
+					reg->id = bpf_new_id(env);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
 				reg->type = PTR_TO_BTF_ID;
 				if (arg->arg_type & PTR_MAYBE_NULL)
@@ -22188,7 +22091,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 				mark_reg_known_zero(env, regs, i);
 				reg->btf = bpf_get_btf_vmlinux(); /* can't fail at this point */
 				reg->btf_id = arg->btf_id;
-				reg->id = ++env->id_gen;
+				reg->id = bpf_new_id(env);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
 				/* caller can pass either PTR_TO_ARENA or SCALAR */
 				mark_reg_unknown(env, regs, i);
@@ -22232,7 +22135,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 			if (ret < 0)
 				goto out;
 
-			aux->ctx_arg_info[i].ref_id = ret;
+			aux->ctx_arg_info[i].ref_arg = ret ? i + 1 : 0;
+			if (ret)
+				state->refs[state->acquired_refs - 1].ctx_arg = i + 1;
 		}
 	}
 
-- 
2.55.0

