Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498828;
	b=RZw1+HMzrgyvR7/nL/+ak9afob4aOZi26T1UZNLS+3FzaUkZByPKxTW4QXYoCdCxOFrH
	 NYefXRYX5P/uTHUpTv1KST32F0oDA8X6x0iASAN/dHi9j09oJ/10YTtxAbAFwv1y7S7uj
	 Xw1nbr4GgnQN9F3VOTKodM6s5S/KNTp6jhtt+y4Qx7n/1yPwxMQfRK6FOA28WSfKRmOP0
	 kraA3tGE/MfNVAgQLeoHyEH+7Rdz0lxpXSP00MUTU4bfSO4tgLwyDHtDPDmrA3FuMOf5P
	 MP5BgVQnHCOj9Cr4EeVh5HB/seD+JZxWSdGyzbbCDR1GcGs2KUAqllYu2nfIQ3GRI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YISA9AO1snzIN4QQpRofBhGbS16LSCvvvt24Vq9rzFg=;
	b=mambt14nqVYEX2FW9ciPA7cJ+YKJXdJVuymG8T1laeJrlVU2CDSsIh1IfO/Dmlm7J6yT
	 fdow7K1NTubszzLo/Sp+7x4+a9+v11PD1rydgq3Cd2q8UkyzmdzlXT0/GjKr8pTVILEt0
	 vZ7VNQip+0hplo2IgH4T8nLZUo8o9c82IPsV/NEad3h+ISWXce8KTit4snyxnraKbnd2B
	 FAf7hsVySNvIIwikxwDIoBcAeNqfKhhB07Atzscf+gGDDxEpFPk77yUGWXBQgW/4wv2Jt
	 cUOhIWGupgrS7YVadjZouPrsefbvipqwMy7SmLXAoycCoKN2bmBp6Sk4jMbDc68Y6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ou8muxzD;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E8606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E81E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ou8muxzD
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso2421036a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498827; x=1795103627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YISA9AO1snzIN4QQpRofBhGbS16LSCvvvt24Vq9rzFg=;
        b=ou8muxzDBQkLshsBt8iVZYzdUJ8CBbu9bBP6zqLPS2kJQO6p/iGEyYsyIFT9lhNnM0
         7t+Z+aJEwLC5kyK0GBx2yS3zU66WnGIY0Hu6GT3EFIYNfvRCLYI7LDmbouq5jPuOLPkC
         +8jryKCXOJIsy7/vhUsxG9TrUGV1wK3aubF+4Us0jWb3AOXtmmlW2evpq2SYqe9N6K1G
         /JNSJYS6yM0N72AI/MSWe3i43U3muW5UbiKKxdtL7o5uSvSyS9JniwcKi+aDZvEDhCVW
         iAXIk+c6Lp7l7htfoND1kDEoSQBa0+P+Lp/LljUX/Z7LGT++ploiKTFVExT/USd2Q79h
         ZiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498827; x=1795103627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YISA9AO1snzIN4QQpRofBhGbS16LSCvvvt24Vq9rzFg=;
        b=1fB/s7GM58NR23O2Sz64YSntjYPf1oNR6rjagtu7l+GzL+HfNBKw9P9T+/izHtPhGt
         vWdD9dXw1BPmMFyHKKZ3ad3Dy69wV99K+UnG+1R47Fk0SxN0Cdhf9IrJiijuKYUUD0bL
         iJWo15elRVsVAicrRLokA6Gj26bLdVV7D/usM/NSY5hFKvC+PjznmWs3pCSYRRPfeeGm
         sqNRu4AsOkENQjV0UNXiECG70yhESobILOdF0lfcRHlS9463Ccd+NXA0L5sS9zkmqrs3
         ui4oPqJeuVVk4VJ9bu/2lbPRvwvkJpMO1UlZRzOf+eNevuMmLN+gze1pVBsl1d4s9lGB
         72sQ==
X-Gm-Message-State: APuU4Z8r5HebmYrLH0G1oY44HWsbdFM/e7JGfzN2j4rXmD8RU4Qi6nIN
	Ml8jpTonjFXD5N/NnWQ5Oh+D418z1YWQByJx6iOENN9GBV0u5v8FUfee127C2Q==
X-Gm-Gg: AYBFou1F6ap2kieXI4oU1qBzsKCvhYVG/8XbJcTJTbKep5KoaUbkUZwjcZ+WPVYQHRh
	b1Fr9Dhtu7rHGDod29DV7kJuvD6KtkU6duHHlcvVy60og7jj1JtcrZoMSOT0LLafc5ymk9GvQtY
	AIyqe+t1WRi5RbNingCtHVIxgg3HLq2ltTWELWMd961TDDQU/rBsRdnN3noFAS7nDIQUq1/Lfy2
	WYWXdIRVYwzUyytt21FRl4kgpFwMEKGB++7B6Sp5o68UNTwl95gh1fbeP+EU3L6Q8z7P4G2Qaki
	/ftssmWTwn3G92xkRaPMX2YIpvJfeWMNtIojmAQdp+1fVdsQMd5316eeCKP9Sk1emcK6dgg+eGz
	HUROnGmysObPUQ2NmR1/5+wZ8mbhfXwFg4YGQIyHDlmw5/XfgVKtJMCfgHSz+PMfQuOF6m0DHtB
	mRHnLHm0CaW3QxHl1r7DOUOIazRjJ828VYorLbG/UIIxe58oeoWRnb5mQLjabSf9kMk0mgtbt9z
	TcTf0bzpdJsTbWOWzCMEh1dnxKgFFqrQbMy5LJmG+SZ3jMk/8RW0JQCQ/hgDzYn7nkdc3rqBn22
	9vLCNdadC6tkKLsmFhlcgbfJMuQMap21Pz2FJ5pyMtzr84LQyxgUTpPYSGNGkX7Gu6o5DhyobU+
	rZcD+6UPxa6HxWSM/5DOXllkgbjgzfp2D5tywH/HN0TzykzGCML0JdAyqPKAXCnX0yeDUb690Dq
	0=
X-Received: by 2002:a17:90b:3a10:b0:3b0:aaa3:ce8c with SMTP id 98e67ed59e1d1-3b182f660f8mr5471226a91.14.1794498826578;
        Thu, 12 Nov 2026 07:53:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm5228858a91.10.2026.11.12.07.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:53:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 01/12] bpf: Don't keep a spilled pointer for a read that sees only bytes
Date: Thu, 12 Nov 2026 15:53:26 +0000
Message-ID: <20261112155337.1040699-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
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

auxmap__store_socktuple_param() of Falco copies from a struct on the stack:

  struct sockaddr_in6 addr = {};
  bpf_probe_read_user(&addr, size, usrsockaddr);
  bpf_probe_read_kernel(&ipv6_remote, 16, addr.sin6_addr.in6_u.u6_addr32);

  r3 = 8
  r3 += r8                            ; R3=fp-144 R8=fp-152
  call bpf_probe_read_kernel#113      ; use: fp0-8..-2048

The liveness pass loses the offset of r3, as it does at 'c = buf[i]'. All
slots of the frame are live up to this insn. That includes the slots in
which the compiler left a pointer that no insn loads again. Two pointers
to different places have no join. A pointer and a number have no join.
States that differ in such a slot stay apart. K such slots with two values
each give 2^K states at a join point.

The read does not need the pointers. A helper, a kfunc or a global subprog
that gets a pointer to the stack reads memory. A load of 1, 2 or 4 bytes
does not give a spilled pointer back: the result is an unknown number.

Calculate a second set in the liveness pass: the slots from which a later
insn can fill a register. It has the equation of the live slots, without
the reads above. If a slot is live and is not in the second set,
bpf_clean_verifier_state() replaces a spilled pointer with STACK_MISC. The
bytes stay readable. States that differ only in such a pointer are equal.

STACK_MISC stands for any content of a slot, see stacksafe(), and the
verifier goes on with the cleaned state. Thus an error in the new set can
reject a valid prog, not accept an unsafe one. These reads count as a fill:

 - A load of 8 bytes at any offset. An offset that the liveness pass lost
   is frequently a constant in the main pass: a[n++] = p; p = a[--n];
 - A short load at a known offset. The main pass rejects it if the slot
   has a pointer: invalid size of register fill
 - An atomic insn, callx, a helper that calls one of two callbacks.

A short load at an offset that only the main pass knows got this error too.
Now it reads unknown bytes if the state was cleaned between the spill and
the load. States that only such a pointer kept apart are joined now, as in
the same code without the pointer. Without CAP_PERFMON no state changes:
a helper must not read a pointer.

The insns that the verifier processes. Falco and Tracee: the code of Nov 9
with the flags of the projects, clang 17:

  Falco   recvmsg_x                         13267 ->  1954
  Falco   send_x                             3125 ->  1880
  Tracee  trace_security_file_mprotect      17872 ->  8515
   8 such pointers, then 'c = buf[i]'        5000 ->   118
  12 such pointers, then 'c = buf[i]'    rejected ->   162

All progs pay for the second set when they are loaded: Cilium takes 1% more
instructions in the kernel and 3% more memory, Tetragon 2% and 4%.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/liveness.c        | 108 +++++++++++++++++++++++------------
 kernel/bpf/states.c          |  14 +++++
 3 files changed, 86 insertions(+), 38 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d4fdb724cc1b..ff560e4899e1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2050,6 +2050,7 @@ struct arg_access_info {
 	u8 may_read:1;		/* Incoming contents or initialization may be needed. */
 	u8 may_write:1;
 	u8 must_write:1;	/* Prior verifier state is destroyed throughout size. */
+	u8 bytes_only:1;	/* The read cannot fill a register with a spilled pointer. */
 };
 
 struct arg_access_info
@@ -2084,6 +2085,7 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
 bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
+bool bpf_stack_slot_filled(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 bool bpf_half_slot_live_before(struct bpf_verifier_env *env, u32 insn_idx, u32 half_spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 63d23d28f2a5..06f739610c73 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -24,6 +24,8 @@ enum {
 	FM_MUST_WRITE,	/* stack slots written by this instruction */
 	FM_LIVE_BEFORE,	/* stack slots that may be read by this insn and its successors */
 	FM_MAY_WRITE,	/* stack slots that may be written by this instruction */
+	FM_MAY_FILL,	/* FM_MAY_READ without the reads that see nothing but bytes */
+	FM_FILL_BEFORE,	/* FM_LIVE_BEFORE of these reads, see bpf_stack_slot_filled() */
 	FM_MASK_CNT,
 };
 
@@ -253,11 +255,15 @@ static int mark_stack_range(struct func_instance *instance, u32 frame, u32 insn_
 	return 0;
 }
 
-/* Accumulate may_read for half-slots [lo, hi] of @frame at @insn_idx */
+/* Accumulate may_read, and may_fill if @fill, for half-slots [lo, hi] of @frame at @insn_idx */
 static int mark_stack_read(struct func_instance *instance, u32 frame, u32 insn_idx,
-			   s32 lo, s32 hi)
+			   s32 lo, s32 hi, bool fill)
 {
-	return mark_stack_range(instance, frame, insn_idx, FM_MAY_READ, lo, hi);
+	int err = mark_stack_range(instance, frame, insn_idx, FM_MAY_READ, lo, hi);
+
+	if (err || !fill)
+		return err;
+	return mark_stack_range(instance, frame, insn_idx, FM_MAY_FILL, lo, hi);
 }
 
 /* Accumulate must_write for half-slots [lo, hi] of @frame at @insn_idx */
@@ -282,10 +288,10 @@ static int mark_stack_may_write(struct func_instance *instance, u32 frame, u32 i
  * widen a frame's masks further, which is harmless.
  */
 static int mark_stack_read_all(struct bpf_verifier_env *env, struct func_instance *instance,
-			       u32 frame, u32 insn_idx)
+			       u32 frame, u32 insn_idx, bool fill)
 {
 	return mark_stack_read(instance, frame, insn_idx, 0,
-			       env->stack_limit / BPF_HALF_REG_SIZE - 1);
+			       env->stack_limit / BPF_HALF_REG_SIZE - 1, fill);
 }
 
 static int mark_stack_may_write_all(struct bpf_verifier_env *env, struct func_instance *instance,
@@ -318,12 +324,6 @@ static int mark_stack_mask(struct func_instance *instance, u32 frame, u32 insn_i
 	return 0;
 }
 
-static int mark_stack_read_mask(struct func_instance *instance, u32 frame, u32 insn_idx,
-				const unsigned long *src, u32 src_words)
-{
-	return mark_stack_mask(instance, frame, insn_idx, FM_MAY_READ, src, src_words);
-}
-
 int bpf_jmp_offset(struct bpf_insn *insn)
 {
 	u8 code = insn->code;
@@ -413,8 +413,8 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 
 __diag_pop();
 
-static inline bool update_insn(struct bpf_verifier_env *env,
-			       struct func_instance *instance, u32 frame, u32 insn_idx)
+static inline bool update_insn(struct bpf_verifier_env *env, struct func_instance *instance,
+			       u32 frame, u32 insn_idx, u32 read, u32 before)
 {
 	unsigned long new_after[FRAME_MAX_WORDS] = {};
 	unsigned long *may_read, *must_write, *live_before;
@@ -432,13 +432,13 @@ static inline bool update_insn(struct bpf_verifier_env *env,
 	for (s = 0; s < succ->cnt; ++s) {
 		unsigned long *succ_live;
 
-		succ_live = rel_mask(fm, relative_idx(instance, succ->items[s]), FM_LIVE_BEFORE);
+		succ_live = rel_mask(fm, relative_idx(instance, succ->items[s]), before);
 		for (w = 0; w < fm->words; w++)
 			new_after[w] |= succ_live[w];
 	}
-	may_read = rel_mask(fm, rel, FM_MAY_READ);
+	may_read = rel_mask(fm, rel, read);
 	must_write = rel_mask(fm, rel, FM_MUST_WRITE);
-	live_before = rel_mask(fm, rel, FM_LIVE_BEFORE);
+	live_before = rel_mask(fm, rel, before);
 	/*
 	 * New "live_before" is a union of all "live_before" of successors
 	 * minus slots written by instruction plus slots read by instruction.
@@ -474,20 +474,25 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 			if (!instance->frames[frame])
 				continue;
 
-			for (i = po_start; i < po_end; i++)
-				changed |= update_insn(env, instance, frame, insn_postorder[i]);
+			for (i = po_start; i < po_end; i++) {
+				changed |= update_insn(env, instance, frame, insn_postorder[i],
+						       FM_MAY_READ, FM_LIVE_BEFORE);
+				changed |= update_insn(env, instance, frame, insn_postorder[i],
+						       FM_MAY_FILL, FM_FILL_BEFORE);
+			}
 		}
 	} while (changed);
 }
 
-static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi)
+static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi,
+			   u32 kind)
 {
 	struct frame_masks *fm = instance->frames[frameno];
 
 	/* No recorded access reaches past the masks, so nothing there is live */
 	if (!fm || half_spi >= frame_mask_bits(fm))
 		return false;
-	return test_bit(half_spi, rel_mask(fm, relative_idx(instance, insn_idx), FM_LIVE_BEFORE));
+	return test_bit(half_spi, rel_mask(fm, relative_idx(instance, insn_idx), kind));
 }
 
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
@@ -528,7 +533,7 @@ static bool callee_stack_access_at_callsite(struct bpf_verifier_env *env, u32 ca
 	       bpf_is_callx(&env->prog->insnsi[callsite]);
 }
 
-bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
+static bool stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_spi, u32 kind)
 {
 	/*
 	 * Slot is alive if it is read before q->insn_idx in current func instance,
@@ -548,7 +553,7 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 	cur_delta = (int)curframe_instance->depth - (int)q->curframe;
 	rel = frameno + cur_delta;
 	if (rel <= curframe_instance->depth)
-		alive = is_live_before(curframe_instance, q->insn_idx, rel, half_spi);
+		alive = is_live_before(curframe_instance, q->insn_idx, rel, half_spi, kind);
 
 	if (alive)
 		return true;
@@ -567,8 +572,8 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 		callsite = q->callsites[i];
 
 		alive = callee_stack_access_at_callsite(env, callsite)
-			? is_live_before(instance, callsite, rel, half_spi)
-			: is_live_before(instance, callsite + 1, rel, half_spi);
+			? is_live_before(instance, callsite, rel, half_spi, kind)
+			: is_live_before(instance, callsite + 1, rel, half_spi, kind);
 		if (alive)
 			return true;
 	}
@@ -576,6 +581,25 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
 	return false;
 }
 
+bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
+{
+	return stack_slot_alive(env, frameno, half_spi, FM_LIVE_BEFORE);
+}
+
+/*
+ * Can what is spilled to the slot get back into a register? A load of less than 8 bytes doesn't
+ * fill a pointer, and a helper, a kfunc or a global subprog that gets a pointer to the stack reads
+ * memory. Such a read keeps the bytes of the slot alive, not what the verifier knows about them.
+ *
+ * A short load at an offset that is known here counts as a fill: the main pass rejects it when it
+ * finds a pointer. If only the main pass knows the offset, the load doesn't count. It is rejected
+ * too, or it reads unknown bytes if the state was cleaned between the spill and the load.
+ */
+bool bpf_stack_slot_filled(struct bpf_verifier_env *env, u32 frameno, u32 half_spi)
+{
+	return stack_slot_alive(env, frameno, half_spi, FM_FILL_BEFORE);
+}
+
 static char *fmt_subprog(struct bpf_verifier_env *env, int subprog)
 {
 	const char *name = env->subprog_info[subprog].name;
@@ -768,7 +792,7 @@ bool bpf_half_slot_live_before(struct bpf_verifier_env *env, u32 insn_idx, u32 h
 
 	hash_for_each(env->liveness->func_instances, bkt, instance, hl_node)
 		if (insn_idx - instance->subprog_start < instance->insn_cnt &&
-		    is_live_before(instance, insn_idx, instance->depth, half_spi))
+		    is_live_before(instance, insn_idx, instance->depth, half_spi, FM_LIVE_BEFORE))
 			return true;
 	return false;
 }
@@ -1616,7 +1640,8 @@ static int record_stack_access_off(struct func_instance *instance, const struct
 		  ? 0
 		  : max_t(s32, (-fp_off - info.size) / STACK_SLOT_SZ, 0);
 	if (info.may_read) {
-		err = mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
+		err = mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi,
+				      !info.bytes_only);
 		if (err)
 			return err;
 	}
@@ -1646,7 +1671,7 @@ static int record_stack_access(struct bpf_verifier_env *env,
 		return 0;
 	if (arg->off_cnt == 0) {
 		if (info.may_read) {
-			err = mark_stack_read_all(env, instance, frame, insn_idx);
+			err = mark_stack_read_all(env, instance, frame, insn_idx, !info.bytes_only);
 			if (err)
 				return err;
 		}
@@ -1677,7 +1702,8 @@ static int record_imprecise(struct bpf_verifier_env *env, struct func_instance *
 			continue;
 		if (f <= depth) {
 			if (info.may_read) {
-				err = mark_stack_read_all(env, instance, f, insn_idx);
+				err = mark_stack_read_all(env, instance, f, insn_idx,
+							  !info.bytes_only);
 				if (err)
 					return err;
 			}
@@ -1770,6 +1796,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 	info.may_write = write;
 	info.must_write = write;
 	info.size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+	info.bytes_only = class == BPF_LDX && info.size < BPF_REG_SIZE && !ptr->off_cnt;
 	if (ptr->frame >= 0 && ptr->frame <= depth)
 		return record_stack_access(env, instance, ptr, info, ptr->frame, insn_idx);
 	if (ptr->frame == ARG_IMPRECISE)
@@ -1800,7 +1827,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		info = bpf_global_subprog_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else {
 		for (int f = 0; f <= depth; f++) {
-			err = mark_stack_read_all(env, instance, f, insn_idx);
+			err = mark_stack_read_all(env, instance, f, insn_idx, true);
 			if (err)
 				return err;
 			err = mark_stack_may_write_all(env, instance, f, insn_idx);
@@ -1812,6 +1839,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 	if (!info.size)
 		return 0;
 
+	info.bytes_only = true;
 	if (frame >= 0 && frame <= depth)
 		err = record_stack_access(env, instance, at, info, frame, insn_idx);
 	else if (frame == ARG_IMPRECISE)
@@ -2196,7 +2224,7 @@ static bool has_fp_args(struct arg_track *args)
 
 /*
  * Merge a freshly analyzed instance into the original.
- * may_read: union (any pass might read the slot).
+ * may_read, may_fill: union (any pass might read the slot).
  * may_write: union (slots written on ANY pass).
  * must_write: intersection (only slots written on ALL passes are guaranteed).
  * live_before is recomputed by a subsequent update_instance() on @dst.
@@ -2237,14 +2265,17 @@ static int merge_instances(struct func_instance *dst, struct func_instance *src)
 			unsigned long *dst_read = rel_mask(d, i, FM_MAY_READ);
 			unsigned long *dst_write = rel_mask(d, i, FM_MUST_WRITE);
 			unsigned long *dst_may_write = rel_mask(d, i, FM_MAY_WRITE);
+			unsigned long *dst_fill = rel_mask(d, i, FM_MAY_FILL);
 			unsigned long *src_read = rel_mask(s, i, FM_MAY_READ);
 			unsigned long *src_write = rel_mask(s, i, FM_MUST_WRITE);
 			unsigned long *src_may_write = rel_mask(s, i, FM_MAY_WRITE);
+			unsigned long *src_fill = rel_mask(s, i, FM_MAY_FILL);
 
 			for (w = 0; w < d->words; w++) {
 				dst_read[w] |= w < s->words ? src_read[w] : 0;
 				dst_write[w] &= w < s->words ? src_write[w] : 0;
 				dst_may_write[w] |= w < s->words ? src_may_write[w] : 0;
+				dst_fill[w] |= w < s->words ? src_fill[w] : 0;
 			}
 		}
 	}
@@ -2406,7 +2437,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 				if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
 					continue;
 				for (int f = 0; f <= depth; f++) {
-					err = mark_stack_read_all(env, instance, f, idx);
+					err = mark_stack_read_all(env, instance, f, idx, true);
 					if (err)
 						goto out_free;
 					err = mark_stack_may_write_all(env, instance, f, idx);
@@ -2461,19 +2492,20 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 
 		/* Pull callee's entry liveness back to caller's callsite */
 		{
-			u32 callee_start = callee_instance->subprog_start;
 			struct frame_masks *callee_fm;
 
 			for (int f = 0; f < callee_instance->depth; f++) {
 				callee_fm = callee_instance->frames[f];
 				if (!callee_fm)
 					continue;
-				err = mark_stack_read_mask(instance, f, idx,
-							   rel_mask(callee_fm,
-								    relative_idx(callee_instance,
-										 callee_start),
-								    FM_LIVE_BEFORE),
-							   callee_fm->words);
+				err = mark_stack_mask(instance, f, idx, FM_MAY_READ,
+						      rel_mask(callee_fm, 0, FM_LIVE_BEFORE),
+						      callee_fm->words);
+				if (err)
+					goto out_free;
+				err = mark_stack_mask(instance, f, idx, FM_MAY_FILL,
+						      rel_mask(callee_fm, 0, FM_FILL_BEFORE),
+						      callee_fm->words);
 				if (err)
 					goto out_free;
 			}
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 9ff067dba497..b2daad5e78c7 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -108,6 +108,19 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < bpf_stack_nr_slots(st); i++) {
 		bool lo_live = bpf_stack_slot_alive(env, frame, i * 2);
 		bool hi_live = bpf_stack_slot_alive(env, frame, i * 2 + 1);
+		struct bpf_stack_state *slot = bpf_stack_slot(st, i);
+
+		/*
+		 * Nothing ahead gets the pointer back into a register. What reads the slot sees
+		 * unknown bytes, whatever the pointer is.
+		 */
+		if (env->allow_ptr_leaks && bpf_is_spilled_reg(slot) &&
+		    slot->spilled_ptr.type != SCALAR_VALUE &&
+		    !bpf_stack_slot_filled(env, frame, i * 2) &&
+		    !bpf_stack_slot_filled(env, frame, i * 2 + 1)) {
+			bpf_mark_reg_not_init(env, &slot->spilled_ptr);
+			memset(slot->slot_type, STACK_MISC, sizeof(slot->slot_type));
+		}
 
 		if (!hi_live || !lo_live) {
 			int start = !lo_live ? 0 : BPF_REG_SIZE / 2;
@@ -140,6 +153,7 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 			 * when their high half is dead. Pointer spills need the
 			 * saved spilled_ptr metadata so partial fills keep
 			 * rejecting as non-scalar register fills.
+			 * The code above replaces only pointers that no insn ahead can fill.
 			 */
 			if (!hi_live) {
 				struct bpf_reg_state *spill = &bpf_stack_slot(st, i)->spilled_ptr;
-- 
2.55.0

