Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006737;
	b=X6y4cDWoPR1puAf++05ZqF3njo1XAn2SL4+nKevQbaEFeH0QJ2lAmNKh7sCnsBIKkc3E
	 xu80ggdFRibkCG335hCH2CLQOgl88r0Un2cTg33wzh1/SvwwiMc9nNskb3HAVrSdQCWJz
	 QCQanOA2NcmfFziUwrwylUIBzX01HHZQiAKyL7nc/osB6oMz+6Lxnc4mcOVmX/pMPn+wM
	 2r2LhJDHZka4ltjOeqJBvk2SaaA4bdkGywS0J2j3t4MMDbbwdiuY+o+vJsV25ERldJIWS
	 jpQUY1QXO4ol7ZmqbKAu1sXwySCkNR89v2fjQk76Ck2ICVJhcSgw+3QDqQPJfmwssPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006737;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jnGioh87gWlEmtGWli1y3neDt1GK+Ypc7KPSHRbg4yE=;
	b=tatsmzDLkfduSrgpw2S69BLsxMHtJdPEsB4WAGCyQG2GpFtaTvyShRdpR5i331YklZy5
	 rbLCypjmoARJb018oxFRQ4lh0XFeGSLCTWnTEvgr3XOsqv8zobckqcT82312YdzoYXkjq
	 7zxXdO23YvKg7JgAFnDWyh9pnK1KTLq84jmLJUtxdfiu+/eKsd51XhBYBWz9aSdRSj+8N
	 nZJPQ5GgUYL8UNE/JBRC+a7sx1Zh0mJfRX3qa+xlpE2JG1+G0BMyI5NsInHxC+sEPjyj3
	 3QEyghIjyrc5sAM3DosCr86IpXTPeKbVFR3fOVMmQ3cafrWnGeFbqluHi4XVEoqXjHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VJQ5B1Oo;
	arc=none smtp.remote-ip=95.215.58.124
Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA6606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AA6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VJQ5B1Oo
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7Yu6+rrOPANaEoxxfFHcNS87o/Sd4Syb4FBkRa0tru0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006734; v=1; x=1794611534;
 b=VJQ5B1OoILzS38G+YIr+imMuHgrf8tp19E5RRNFqSr5fz/Wgv2kthp1ZpCduiDdrp9aUab/5
 L7YN2UEwVDeaFOvuURrWqL9HakXO6VLkz/KlDkvcdwgnJHQ3QN05cPDlcSKXTj009k+Qo36/t+M
 m8Nxm9xXElI0zY0KyPxg5s8A=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id fe5d74df9d92ac50;
	Fri, 06 Nov 2026 23:12:14 +0000
X-Mizu-Trace-ID: fe5d74df9d92ac50
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/4] bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
Date: Fri,  6 Nov 2026 16:11:54 -0700
Message-ID: <20261106231157.2840635-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
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

The dynptr argument to a bpf_user_ringbuf_drain() callback points to a
descriptor on the helper's stack. The descriptor and the sample it
describes are valid only during that callback invocation.

The callback can save the dynptr pointer, a slice, or a clone in the
caller's frame and use it after the drain returns. An escaped descriptor
pointer can allow arbitrary kernel read/write once the helper's stack
is reused.

The verifier assigns the dynptr a type and an id, but does not tie it
or its descendants to the callback's lifetime.

Give the callback frame an id and make it both the id and the parent_id
of R1, then invalidate that id and everything derived from it when the
frame is popped. R1 has to be its own parent: slices take the dynptr's
id as their parent_id, and bpf_dynptr_data() clobbers R1, so with a
separate dynptr id nothing would connect a slice to the frame.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Fixes: 1f737e46ca6a ("bpf: Remove artificial limitations on pointer types eligible for spilling")
Cc: stable@vger.kernel.org
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/states.c          |  3 +++
 kernel/bpf/verifier.c        | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b43eb97bcd44..dabdd286182c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -377,6 +377,8 @@ struct bpf_func_state {
 	 * reused after returns, while this ID is preserved across state clones.
 	 */
 	u32 diag_frame_id;
+	/* parent_id of the args that are gone when this frame returns */
+	u32 frame_id;
 	/* subprog number == index within subprog_info
 	 * zero == main subprog
 	 */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 50480c42bcad..d8ad497f9b4b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -998,6 +998,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (old->in_rcu_callback_fn != cur->in_rcu_callback_fn)
 		return false;
 
+	if (!check_ids(old->frame_id, cur->frame_id, &env->idmap_scratch))
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e4700fda66b..a801b8da2b63 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11804,6 +11804,16 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* The arg points into the stack frame of the helper that calls the callback */
+static void mark_frame_scoped_arg(struct bpf_verifier_env *env,
+				  struct bpf_func_state *callee, u32 regno)
+{
+	if (!callee->frame_id)
+		callee->frame_id = ++env->id_gen;
+	callee->regs[regno].id = callee->frame_id;
+	callee->regs[regno].parent_id = callee->frame_id;
+}
+
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx)
@@ -11955,6 +11965,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	 */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
 	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
+	mark_frame_scoped_arg(env, callee, BPF_REG_1);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	/* unused */
@@ -12223,6 +12234,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	if (err)
 		return err;
 	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
+	if (callee->frame_id) {
+		err = invalidate_reference(env, callee->frame_id);
+		if (err)
+			return err;
+	}
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
-- 
2.56.0

