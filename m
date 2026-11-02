Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639409;
	b=F5MhtTTUFrEzuO2Ji/Zmej+tLfHyYy+HQtqvwFRFLfR893gOzDfM671bowKERRh+CvlB
	 Nah3EDapjkR/ejGkzu+P0rkok4APvbz6K5jENQprLz/RcrREJgJLgivU2U5manzfJLbBK
	 OKE01l86AwC5PAwDZU/nzPoI0WdI1ZJ3SLWjyuzjBIriAR2pO16wPwGNwKAHz6/BsPkwV
	 iJWzQ39oIubYpoBgQwWGayM70yhiTi2YX8bJC4T0IwVklYOHp8StdU2BCdRzb9A2E370j
	 0oCBcEPcDnO6AaoLpdiB78e8oxwq6L4glx3hVNhD4PSK+xAlW4ZCumSsQ8DrVGW8Vrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IhmQsubs9sUpEeNsontQiJ3xgbS2IIJ4iXe8OkTOW3U=;
	b=2qVVo+FXxV+jyIYfpXhsMN606bb7M8GzJzD02+CCS7ejqLkDVHcAUB9xFwEDfi47C2oF
	 2MquEwA51DjHoyGF/J+GHo/iH5UaPADEpv67DPN1IUOV/Ovzl5bPsO4aPPYW2GygnACnc
	 Y6qPRUQpes+jOf13YfwEiO85qPZ9ut4aR8SjSa52VbW7o73NLJkkd4+vEQIgd35oZ3ntC
	 mnxGXGxcI2BcunY1SmzBVYEsQ1D0b6BD9OxCVodnc25g4fsA/C9r0iyyD//ENgQjM8VlL
	 WbOPptUB53M93o61fvAmmylqzeQEv8Z6jOWIhVXfB9y8lnT2kWePN4/ZtSj8t4odgOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgXI8D8i;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC2606AB80
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FBC2606AB80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JgXI8D8i
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae486f8a27so1862010a91.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793639408; x=1794244208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhmQsubs9sUpEeNsontQiJ3xgbS2IIJ4iXe8OkTOW3U=;
        b=JgXI8D8i46OmAgxQZtFYhVwcZSR357axsw0SyUOvUzWusFTAfTm6WUQYlzmbOD6eW4
         1MGEzCPilLzHCTb1fGGTocHbjMwbw3q5ODTAebFn0cfKh2llHhq4zFEA3414i5lTxc1z
         oSKQx/pHTIPEXzp/yKm/G0t6j4j5FJ5zRLtLXmaJBjZNMoOplIrRwhnrm8xxbXSPG6Mr
         GaKHIsG7RcG1JW/SWD85tkYbIsqHaSuqBM2Umr1pcZo4F+JFrTBMrGn2nhDSZiayPEzo
         2zVg8jcW25FBQiJbukNVzVnJ+sz5XeS2+s7sIP4JOVM88hX9ItBVHOmvz2NOhU3PnQt5
         8Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639408; x=1794244208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhmQsubs9sUpEeNsontQiJ3xgbS2IIJ4iXe8OkTOW3U=;
        b=S67yDtlLYVOxCqlyrCPLCbCpDu+GINTd+Jpq04xyMYPE86fvGpQri5and8q1ONf7B1
         y9e1HjSUGAap98ADGOshhC/zdECCPW5XXpxSD7hbwDmQ/DP3d3+8nNPgKTjkIpLISpvw
         JetQSs7uUSkdQ5D2qZLi+WOLPe3sE+F7MlQlNy/b9AYMuJDMkigk0cguDsyRCHSCNRVr
         JVriqWi6yEXPShVcLbOA+dj2RRY7Y1rRw2i3UDvpaqJKcs4yv4GLA1U0uT4LnXjkHs/m
         nIrV6iGudsfQFn02HQ88zEY17oZnbZkbS0hDp+aTGH6kZuo4Owu5IIsNZbMwYrThvzPZ
         DLXw==
X-Gm-Message-State: APuU4Z/A/zi1KBW/4GWfXl7goZc/P0NKTva9uwElDR20OVni+Ua8cwi5
	tc0oMIOLQHZMCrjZB16UzIdM4x7jyn/5DhBvQfNXAlUuryqhK0TW/+aCuSUoow==
X-Gm-Gg: AYBFou1ereL103tuuyRTROep/30NT1z/maO3/f9Jcxbl9/tulVRw1yFjO1pVAnZqiY9
	65RVvK0wp5dU9eerRI1wNXFopJvT3t3zAaa28OzmXvB6mGmydsYEGMNLe9006wNJYymdQsQ3v88
	R4OlM62N9UtVIK9cvb6CsQORyZ0oX0ZhWJpf0bQANxYCXi6rpRN1owGM42jEvqwlE39q+JLFXRu
	kQ1P8xzZlyd6kYYR25cdOsgw0nZNBc2lYJF9Ya6WjLIcHmnRLSaZT/lHMFyeG/U8mOV3ndb7PZD
	9ge8j5pGAK/2o/4lwDMIp074zCHwJ372e5C2XyLuZF27vpiLziFJ0ctphUfQmwxCU4Geh6jwBCt
	ou/Pn9laHwpnlCvmaLydLNR/aqsFNrGKSHUPQqqmyBn0+w5RZ4gFsIju34VKSrFUi53zRO4Wrgy
	h59NDnPyQmQg0M1iMhtWupAGqnhQ72YNg8FDrKoWmr6lgvl16BfP2Ndh1Ru9xtUMx4DkGX2IYjV
	cTJ1WKz1QM0DbaSIhAq/buoaK3doTtByQKSDRu8CWLgWdN4OqIEDnpe9OqIpZXHmPk7g8keB25s
	NVqXerxztjBPkDhTxdf6pPdO77RcpZy7lxqcBZaFucPBKSrLULmofi7ZVXdvZnZTwOEh5AtzLQx
	zgIrzV8U7i3ySl1WkfbKTzEdO4Fv89TppsL2jfrBQIs8+ArHegN9/RU0uSRqhDM/d1erOfUU80Z
	Q=
X-Received: by 2002:a17:90b:3944:b0:3ad:4a8b:c703 with SMTP id 98e67ed59e1d1-3ae896f8649mr8432095a91.19.1793639407198;
        Mon, 02 Nov 2026 09:10:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b6f91sm310a91.17.2026.11.02.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:10:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 1/2] bpf: Invalidate a dynptr slice when its stack buffer is written
Date: Mon,  2 Nov 2026 17:09:57 +0000
Message-ID: <20261102170958.3586893-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
References: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
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

bpf_dynptr_slice(&ptr, off, buffer, size) and bpf_dynptr_slice_rdwr()
return a pointer to the data of a dynptr. When the data is not contiguous,
for example in a non-linear skb, they copy it to 'buffer' and return
'buffer'. Usually the buffer is on the stack. For the verifier the result
is plain memory (PTR_TO_MEM), and an access through it is not an access to
the stack:
 - A store makes wrong what the verifier tracks in the buffer: a known
   scalar, a spilled pointer, a dynptr, an iterator, irq flags.
 - A load gives the bytes of a spilled pointer or of a dynptr as a scalar.
 - Both are possible after the frame of the buffer returned.

The accesses are safe while the buffer contains only unknown bytes, as it
does after the call. Thus keep this rule: the buffer contains no tracked
data while a slice that can be the buffer exists. The slice remembers the
frame, the offset and the size of its buffer. The verifier invalidates the
slice, read-only or not, at each event that breaks the rule:

  event                                              slices of the buffer
  -------------------------------------------------  --------------------
  the prog stores to bytes of the buffer             invalid
  a dynptr, an iterator or irq flags are made there  invalid
  the frame of the buffer returns                    invalid
  a helper or a kfunc fills the buffer               no change
  a store next to the buffer, a read of the buffer   no change

Tracked data gets into a stack slot in check_stack_write(), also the bytes
of a new dynptr, iterator or irq flags. Thus one call there, and one call
in prepare_func_exit(), are sufficient. Each is one walk over the
registers, only in progs that have such a slice. Helpers and kfuncs leave
only unknown bytes: mark_raw_stack() goes around check_stack_write().

The range of the buffer is in the part of bpf_reg_state that the verifier
copies with the register and compares for pruning. A slice that is the
buffer of a second call passes its range on. Local, ringbuf and skb
metadata dynptrs never return the buffer: no range. A dynptr argument of a
global function counts as an skb dynptr.

The usual pattern only reads the buffer, and it continues to load:

  if (p == buffer)
          bpf_dynptr_write(&ptr, 0, buffer, sizeof(buffer), 0);

A prog that stores to the buffer and then uses the old slice is rejected:
"R7 invalid mem access 'scalar'". The diagnostics name the reason, and the
log shows the buffer of a slice: R7=mem(sz=8,buf=fp[0]-8+8).

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 17 ++++++++++
 kernel/bpf/diagnostics.c     |  6 +++-
 kernel/bpf/diagnostics.h     |  1 +
 kernel/bpf/helpers.c         | 10 ++++++
 kernel/bpf/log.c             |  2 ++
 kernel/bpf/scev.c            |  6 +++-
 kernel/bpf/verifier.c        | 65 ++++++++++++++++++++++++++++++++++--
 7 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 33dc3d402057..228a3f6889c2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -50,6 +50,13 @@ enum bpf_iter_state {
 	BPF_ITER_STATE_DRAINED,
 };
 
+/* Bytes [off, off + size) of the stack of frame frameno. Nothing when size is 0. */
+struct bpf_stack_range {
+	u32 frameno;
+	s32 off;
+	u32 size;
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -83,6 +90,12 @@ struct bpf_reg_state {
 
 		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
 			u32 mem_size;
+			/*
+			 * bpf_dynptr_slice() and bpf_dynptr_slice_rdwr() return the
+			 * buffer when the data is not contiguous: the register may
+			 * point to this part of the stack.
+			 */
+			struct bpf_stack_range buf;
 		};
 
 		/* For dynptr stack slots */
@@ -1091,6 +1104,8 @@ struct bpf_verifier_env {
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
 	bool seen_direct_write;
+	/* a register may point to the stack and is not PTR_TO_STACK, see bpf_reg_state::buf */
+	bool seen_stack_slice;
 	/* a global function is verified for BPF_FUNC_CTX_NO_RCU_LOCK */
 	bool no_rcu_read_lock;
 	bool seen_exception;
@@ -1815,6 +1830,8 @@ struct bpf_call_arg_meta {
 	struct arg_constant_desc arg_constant;
 	/* The type of the dynptr that the kfunc writes through */
 	enum bpf_dynptr_type dynptr_write_type;
+	/* The buffer of bpf_dynptr_slice() or bpf_dynptr_slice_rdwr() */
+	struct bpf_stack_range slice_buf;
 
 	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index b5204798231d..08e12714bb95 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1561,7 +1561,8 @@ static void diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 	if (origin) {
 		event.mod.origin = *origin;
 		event.mod.origin_valid = true;
-	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
+	} else if (reason != BPF_DIAG_MOD_SLICE_BUF && /* the insn writes the buffer */
+		   diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin)) {
 		event.mod.origin_valid = true;
 	}
 	if (old_reg && new_reg && reason == BPF_DIAG_MOD_WRITE &&
@@ -2237,6 +2238,9 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 	case BPF_DIAG_MOD_PKT_DATA_CHANGE:
 		reason = "packet data may have moved";
 		break;
+	case BPF_DIAG_MOD_SLICE_BUF:
+		reason = "the stack buffer of this dynptr slice was written, or its frame returned";
+		break;
 	case BPF_DIAG_MOD_NON_OWN_REF:
 		reason = "leaving the protected region invalidated this borrowed pointer";
 		break;
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index a4102fb049ec..490decc133f6 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -23,6 +23,7 @@ enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_VAR_WRITE,
 	BPF_DIAG_MOD_REF_RELEASE,
 	BPF_DIAG_MOD_PKT_DATA_CHANGE,
+	BPF_DIAG_MOD_SLICE_BUF,
 	BPF_DIAG_MOD_NON_OWN_REF,
 	BPF_DIAG_MOD_CALLER_SAVED,
 };
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3cbee140ede8..22b46f7d0043 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3088,6 +3088,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
  * bpf_dynptr_slice will not invalidate any ctx->data/data_end pointers in
  * the bpf program.
  *
+ * Please also note that when the buffer is on the stack, the verifier invalidates
+ * the returned pointer when the program stores to the buffer (helpers and kfuncs
+ * may fill it), or returns from the function that has it.
+ *
  * Return: NULL if the call failed (eg invalid dynptr), pointer to a read-only
  * data slice (can be either direct pointer to the data or a pointer to the user
  * provided buffer, with its contents containing the data, if unable to obtain
@@ -3173,6 +3177,12 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
  * Please note that, as in the example above, the user must check that the
  * returned pointer is not null before using it.
  *
+ * Please also note that when the buffer is on the stack, the verifier invalidates
+ * the returned pointer when the program stores to the buffer (helpers and kfuncs
+ * may fill it), or returns from the function that has it. Change the data through
+ * the returned pointer, and before the comparison with the buffer, as in the
+ * example above: after it the compiler may use one pointer in place of the other.
+ *
  * Please also note that in the case of skb and xdp dynptrs, bpf_dynptr_slice_rdwr
  * does not change the underlying packet data pointers, so a call to
  * bpf_dynptr_slice_rdwr will not invalidate any ctx->data/data_end pointers in
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index fa29d9b994e4..916408c63355 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -684,6 +684,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	if (base_type(t) == PTR_TO_MEM) {
 		verbose_a("sz=");
 		verbose_unum(env, reg->mem_size);
+		if (reg->buf.size)
+			verbose_a("buf=fp[%u]%d+%u", reg->buf.frameno, reg->buf.off, reg->buf.size);
 	}
 	if (t == CONST_PTR_TO_DYNPTR)
 		verbose_a("type=%s",  dynptr_type_str(reg->dynptr.type));
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 1123a14e7389..06dee7e421ea 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1831,7 +1831,11 @@ scev_reg_for_read(struct bpf_verifier_env *env, const struct bpf_func_state *st,
 	return zero ? &env->scev->zero_reg : &env->scev->unknown_reg;
 }
 
-/* Materialize a writable value in the current state, growing its stack if needed. */
+/*
+ * Materialize a writable value in the current state, growing its stack if needed.
+ * This does not go through check_stack_write(). The callers skip is_unbound_scev_reg() slots,
+ * thus the buffer of a live dynptr slice, see bpf_reg_state::buf, does not become a spill here.
+ */
 static int scev_reg_for_write(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			      u32 r, struct bpf_reg_state **out)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 217bcfa6ebfe..fb96c61ebec0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1010,6 +1010,13 @@ static bool dynptr_write_changes_pkt_data(enum bpf_dynptr_type type)
 	return type == BPF_DYNPTR_TYPE_SKB || type == BPF_DYNPTR_TYPE_SKB_META;
 }
 
+/* The data of the other types is contiguous: bpf_dynptr_slice() does not use the buffer. */
+static bool dynptr_slice_may_be_buffer(enum bpf_dynptr_type type)
+{
+	return type != BPF_DYNPTR_TYPE_LOCAL && type != BPF_DYNPTR_TYPE_RINGBUF &&
+	       type != BPF_DYNPTR_TYPE_SKB_META;
+}
+
 static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    enum bpf_arg_type arg_type)
 {
@@ -4558,6 +4565,31 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	return err;
 }
 
+/*
+ * An access through a slice that may be the buffer on the stack, see bpf_reg_state::buf, is
+ * not seen as an access to the stack. That's fine as long as nothing is tracked in the buffer.
+ * The output of helpers and kfuncs is not tracked. Here an insn stores to [min_off, max_off)
+ * of frame @frameno, a dynptr, an iterator or irq flags are made there, or the frame is gone.
+ */
+static void invalidate_stack_slices(struct bpf_verifier_env *env, u32 frameno,
+				    int min_off, int max_off)
+{
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+
+	if (!env->seen_stack_slice)
+		return;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+		if (base_type(reg->type) != PTR_TO_MEM || !reg->buf.size ||
+		    reg->buf.frameno != frameno || reg->buf.off >= max_off ||
+		    reg->buf.off + (int)reg->buf.size <= min_off)
+			continue;
+		bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_SLICE_BUF);
+		mark_reg_invalid(env, reg);
+	}));
+}
+
 /* check_stack_write dispatches to check_stack_write_fixed_off or
  * check_stack_write_var_off.
  *
@@ -4572,6 +4604,8 @@ static int check_stack_write(struct bpf_verifier_env *env,
 			     int value_regno, int insn_idx)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
+	int min_off = reg_smin(reg) + off;
+	int max_off = reg_smax(reg) + off + size;
 	int err;
 
 	if (tnum_is_const(reg->var_off)) {
@@ -4586,6 +4620,8 @@ static int check_stack_write(struct bpf_verifier_env *env,
 						reg, off, size,
 						value_regno, insn_idx);
 	}
+	/* After the write is modelled: the insn may store a slice to its own buffer. */
+	invalidate_stack_slices(env, state->frameno, min_off, max_off);
 	return err;
 }
 
@@ -10466,15 +10502,18 @@ static int mark_raw_stack(struct bpf_verifier_env *env, struct bpf_call_arg_meta
 	 */
 	for (slot = 0; slot < MAX_BPF_FUNC_ARGS; slot++) {
 		struct bpf_reg_state *reg;
-		argno_t argno = argno_from_arg(slot + 1);
 
 		if (!meta->arg_raw_mem.size[slot])
 			continue;
 		reg = get_func_arg_reg(caller, cur_regs(env), slot);
 
+		/*
+		 * check_stack_range_initialized() checked the range, its offset is a constant.
+		 * Not check_stack_write(): unknown bytes in its buffer leave a dynptr slice valid.
+		 */
 		for (i = 0; i < meta->arg_raw_mem.size[slot]; i++) {
-			err = check_mem_access(env, insn_idx, reg, argno, i, BPF_B,
-					       BPF_WRITE, -1, false, false);
+			err = check_stack_write_fixed_off(env, bpf_func(env, reg),
+							  reg->var_off.value + i, 1, -1, insn_idx);
 			if (err)
 				return err;
 		}
@@ -12176,6 +12215,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					     callee->allocated_stack / BPF_REG_SIZE - 1);
 	if (err)
 		return err;
+	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit. If iteration
@@ -15411,6 +15451,9 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 			return -EFAULT;
 		}
 		regs[BPF_REG_0].parent_id = meta->dynptr.id;
+		regs[BPF_REG_0].buf = meta->slice_buf;
+		if (meta->slice_buf.size)
+			env->seen_stack_slice = true;
 	} else {
 		return 0;
 	}
@@ -15668,6 +15711,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ref_convert_owning_non_owning(env, id);
 	}
 
+	if ((is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice]) ||
+	     is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice_rdwr])) &&
+	    dynptr_slice_may_be_buffer(meta.dynptr.type)) {
+		struct bpf_reg_state *buf = &regs[BPF_REG_3];
+
+		if (buf->type == PTR_TO_STACK) {
+			meta.slice_buf.frameno = buf->frameno;
+			meta.slice_buf.off = reg_smin(buf);
+			meta.slice_buf.size = reg_smax(buf) - reg_smin(buf) +
+					      meta.arg_constant.value;
+		} else if (base_type(buf->type) == PTR_TO_MEM) {
+			/* a slice is the buffer of the next one */
+			meta.slice_buf = buf->buf;
+		}
+	}
+
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
 		if (!bpf_jit_supports_exceptions()) {
 			verbose(env, "JIT does not support calling kfunc %s#%d\n",
-- 
2.55.0

