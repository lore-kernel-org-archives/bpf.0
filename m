Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598952;
	b=SC0L72VQEzNsrO0NN3YF4tcfnQ7Urdoh1plcz+K1NUCfiucvSEvMf3tMezPcZnWoWn8f
	 ACZvDOKO0Y9cpQ9vJkUsWWu08w/UM9FW26zOS+MJDTN/4PCGM/pzjekT/iVYRgGsxF16Y
	 6WhAQdPevoxs8113IKFOy0q7zFAp9WcN7+U7f5AyridgwFv9+l7i3MZFzTT5OTlLweFlZ
	 2wphLCB1oGl7VHXrLtJPpvCJgeHFyJFZBF4nICxjcvpb3KoI+YFnbSaLJQ2xOc+C/+279
	 Dtnwn2eaj1viDn1jTWA74QS4EOrTbm7BMVYOIyoC8pGgeFydywM2FH3NnnSFDcut0pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h3EANbHhUc/s0WfqasahYXcexzhDG/kRhHDmbtEorN0=;
	b=eqjIWm9q55pY3NK3WcwtDHNUIVb/HZJfsp7kZEiYwRkqpN3p7NwTCBHby2JiM7jL4iC6
	 GYPOdHkFRSKA+x8krM1eUiQiKOy0sONj07NMwlQ3oJ49+d9OGWuZ3XclAJvzorldxJ41K
	 PrKVxg33yLQuF17OBfSkJlpaknraQVjZdJwg8XauHV79DG8a3s2bfGSK3gEv6lCsKwWri
	 gOZkpeJolH7xGQiwmap4dyISFw4rq2m8OqH91UUq39j2A+3vuOctK9g9sBFzX2fC8YnX/
	 6m4+dRH4ISGLdH8yjMzeUiEVJuDvdrcyd0U9M3z1BbFoc2fm4si9rqVBJvlvQdtBHLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgKKh8H1;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86F606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA86F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgKKh8H1
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso815133a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793598951; x=1794203751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3EANbHhUc/s0WfqasahYXcexzhDG/kRhHDmbtEorN0=;
        b=wgKKh8H1JLPR+Hx4DiDKor6Q1xzx+q/JIsOlzqc6mzrShMATrYau+GD/I4C87xsKF3
         R0X2j5XISHUuNX9Nb0gvj0xzSbsX1O5+1G1AKx8zDkanb5raevDazvOwhDDNznDYt5KQ
         RGYN9K1DXkA9R7/x1IxrjyUtEtq6hr3myIZ3ecj6EUuG4+dipVZzccugwMpFybNfa2qV
         tTG7a5CUDsv3+Wz5MFeSHC+JIxjMcJ4TjFhWK/RD5hd+YVuXXR4HQzPxLdo/8QI79EGR
         fTlhuWzUv6uXJfkozWlG3O47s0k2Y9PNJWdsFnQGoCyM/joZy5+Xf393aUkZ0Y36Wszo
         BqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793598951; x=1794203751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3EANbHhUc/s0WfqasahYXcexzhDG/kRhHDmbtEorN0=;
        b=EWo6OEVX8DAHq7qNmxV/g1Yd8GMmV4ngN1JfS9LDgnv7BOnwvZz0wfNyXX5O8PJ6lE
         k2WmWF38oqSvTr22QVypONtL++DOooVmvoOrPtP4b1r+92+vbeTUAEcrH6BlWq0i0doB
         CLpGqFAHtxAmcjE0PWrCZpedmnLY7qjvSm7eLJ0xA2XvfbVq7QLPrza3Obn2U8gq5r4w
         sRCPvTYjJV03mUt4D2j8mjFNd4sazxWqgjYCA7Wyg0ePMjEj+gvbtOFYRTBgNSjS7Emc
         ZcATkRw7kz+ubHS2BskPhaIKPTbShPd6DIxs7xqRPEb79IKNhtSmoMo5c4ytwFtdumnQ
         0BLA==
X-Gm-Message-State: APuU4Z85tJ+z7Jk5AWTdKPdH/PXMlVCdErN0BnH98Aw77ol7148TSCDu
	tvngZ2p2UTeUBxqkZx8rWjLz4s3QUwJUHYBcaw6k7+yyj+uCffDhiJ6fgFnEBg==
X-Gm-Gg: AYBFou2NhHVYgSP5uZXysghf8R9apBwSSnBKC7kAk1HOwAbwwuoKiw0nUsXLSHDOuU8
	gFsKDsIJBFGVgA3NkD0cCJNvH6/u0n+PE/MAB9wCbC8pnAWc5NLFyTLXNWbkJrGisGTe0sd335y
	b4ykEc89BekjXMq83yGYO7OK5V6OkJOikOE5MXkZNmZ8T9cgYUUyY7+jPgIyRI72h+Puk18Z2I3
	c75vZOcz87A/5W7syQNMENaysX7yfznm90FhFmWWLpKWr4gBfQJwlYA/CNuIowfGnlXAql4e5EN
	UQxVyCCh0EVHsEm+n2rqC5keNAWu3i7k4p3nlXw1P9mZnggXGndFae6S56iwCAHgx9eheuNrPM/
	kR6Ms14hjXkt9SfmlxEN8ilXhYeLfoOCMKxcZ2onFZR3BrmgKbuf7UqEjUAeKGeRrZSoffngwlu
	IJ21GYbddKkKOlIuqcWa9Se1TQweJZB02zmd8LEu3lddj34NlmTIctTPRRqQDlQ7m7DTVoYCCcR
	Zn6liSyyI/1NEaIDjVNtIFONHNcune3t1ghexNn8NwK2NSIVSzNt2pAUH5gsqvVDQhzv/t3XPcs
	Q5asLswNiRkFWFPMj+gcam8055JkeIrdol6djR6tdeQD1RlI4OQ2Vu9+ZFnz3txITAy1//gOx/g
	KHO5IUMeQt8bek83hqGGdLxqr91DU6/5a4WBDGnSWkPBp1PWLhhBbnr350dlJP8RdcNNHQR3MXQ
	==
X-Received: by 2002:a17:90b:4a45:b0:3a4:e735:b39d with SMTP id 98e67ed59e1d1-3ae897d28eemr7021001a91.64.1793598950913;
        Sun, 01 Nov 2026 21:55:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b8323sm2746600a12.6.2026.11.01.21.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:55:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 1/2] bpf: Invalidate a dynptr slice when its stack buffer is written
Date: Mon,  2 Nov 2026 05:55:42 +0000
Message-ID: <20261102055543.3584718-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102055543.3584718-1-alexei.starovoitov@gmail.com>
References: <20261102055543.3584718-1-alexei.starovoitov@gmail.com>
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

bpf_dynptr_slice_rdwr(&ptr, off, buffer, size) returns a pointer to the
data of a dynptr. When the data is not contiguous, for example in a
non-linear skb, it copies the data to 'buffer' and returns 'buffer'.
Usually the buffer is on the stack. For the verifier the result is plain
memory (PTR_TO_MEM), and a store through it is not a write to the stack.
After such a store, what the verifier tracks in the slots of the buffer is
wrong: a known scalar, a spilled pointer, a dynptr, an iterator, irq flags.

The store is not a problem while the buffer contains only unknown bytes.
The call leaves the buffer in this condition. Thus keep this rule: the
buffer contains no tracked data while a slice that can be the buffer
exists. The slice remembers the frame, the offset and the size of its
buffer. The verifier invalidates the slice at each event that breaks it:

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
Scalar evolution changes only slots that have a tracked value already.

The range of the buffer is in the part of bpf_reg_state that the verifier
copies with the register and compares for pruning. A slice that is the
buffer of a second call passes its range on. Local, ringbuf and skb
metadata dynptrs never return the buffer: no range. A dynptr argument of a
global function counts as an skb dynptr. bpf_dynptr_slice() does not
change: a prog cannot store through a read-only slice.

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
 kernel/bpf/helpers.c         |  6 ++++
 kernel/bpf/log.c             |  2 ++
 kernel/bpf/scev.c            |  6 +++-
 kernel/bpf/verifier.c        | 64 ++++++++++++++++++++++++++++++++++--
 7 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 33dc3d402057..630681949813 100644
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
+			 * bpf_dynptr_slice_rdwr() returns its buffer when the data
+			 * is not contiguous: the register may point to this part
+			 * of the stack.
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
+	/* The buffer of bpf_dynptr_slice_rdwr() */
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
index 3cbee140ede8..f4936c483f6b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3173,6 +3173,12 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u64 offset,
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
index 217bcfa6ebfe..b34f7321eaaf 100644
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
+ * A store through a slice that may be the buffer on the stack, see bpf_reg_state::buf, is
+ * not seen as a write to the stack. That's fine as long as nothing is tracked in the buffer.
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
@@ -15668,6 +15711,21 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ref_convert_owning_non_owning(env, id);
 	}
 
+	if (is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) &&
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

