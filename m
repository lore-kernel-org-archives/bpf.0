Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB305650F0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190720; cv=none; b=D5XcJpPUyETGCaw1XBQc55igsTaSANpxiZl72s5Yk6Ymx5aWUWc0GZyKQ2X7PsD44xC8cOpky0TaTmxoHm7wkB6dDxs1GiAcFkuAFGeHVvi/Esvas1qMddauup+vdRfgTcDPqH8S3+mpsBP5SauTb86W8Zss/HimTGvYJfQlz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190720; c=relaxed/simple;
	bh=mB7a2b37GudHMZg0vV1wdSdDqX7CCk1ohldJkl28YyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIBfDws96/rjJ3AJRDmBp5BVK0h9yeQrCRQqi1a2jeGvUK4Ht0z/qDncuZI8k1eGFT/+JH7+inFp+o81j48sf6jm9+YRzC1iWrrBVK1/LjT+F7LYQ5mK8N9UHnrv+1anktUWlgyCVX3HIdZ1bZ+geaAUEXCUKYlBr/QkrCy8RX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7I2vJmZ; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7I2vJmZ"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so2638065e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190715; x=1790795515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FiWg2jOmwoqrZr2fT0PJO4E9lqFp0TxO5dATuoZqrIM=;
        b=b7I2vJmZgSSnC34Hi6xhXr05AT9gG3VfISmGqyY/yM80LcOLYB9b/OcJRn4I7o5prI
         YB/eJK6qdFvtDlqHSFta31bgXSGqrKlXQeuB/ybddVhhC4ZJRIokQQ7OToQ4DCEf2vxX
         EV9Zpz+UqqkNsMChvhSeZFjyuNYLnt39DdYsoL+3uyc0ti8/Q74H1fkTN5vVmeefWB4s
         aT1wiKHEtqQKEVMzTui4S94kJmaaQ3hTPC7kjH0a7u6vqCKUx3WO/2uDJMBDb4NzmODF
         vbdfqSu/SZg7nZ+LuS9VHEiT+TK6D1KLt2j7lLjiUfAiBSvVQ020BNMji2UEm+gMYSgi
         vq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190715; x=1790795515;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FiWg2jOmwoqrZr2fT0PJO4E9lqFp0TxO5dATuoZqrIM=;
        b=nZY9P9Y63DiorWlcg9i7PI9Eld88LwBnGOHZ1kejRevyjUC5FFE1iWOqs7XNevoYxC
         elhYbmLfbwl8hdSQArQFBQ3HnnUnXKTpQ538jYX7cdBikYhpwa2ahAQzsL5ywzjWP4Cz
         /mdTye4W2T4J/R4pRCsUNgZhN4mJ5eHyaB4b2S5hIdmfULBixjA0acTQEPcwNm+XXulG
         ovriIJ8/peqlCkz+9pJDj4YtTwTYwIvLSWeEqI5hJt9m265ljVwFs7iNq4cAg+rKC6Su
         CEu8/GMN8J8EzptofuRvUNCmfQbvOHwxAoNDq4B7wqc8Jya/nG7RJjZen4tkUmjS/9Uu
         7XFw==
X-Gm-Message-State: AFuF++lUt6EM8LTe7348QRa57md8t3Im52A5kpMXTwG5op0jY4bQmmnm
	JaP/oIXcx7gPRqJDu17wjDg404TrenXYu2YVKTVgJtR9AGzBUWYWobjgvuFmDDU1
X-Gm-Gg: AYBFou3C11qmmEp7LT2curkCwhEoXtQNoIqyvAsPbETgh1nmu4+Aly75PiIl/RYGvlE
	MkySoi8qJzs/MUNnFoJaa0sqiSsic9Vhaxh0xwHoh7xdRQSsGmtqxChV1kPp8vi6NkUS7o7gK7x
	cJ8nLzS2MOIGSoiuyrK5FwM6Fc76xJQhyUbJGTHUm06LgwDrNwgH3tkbJxFfwhSGZ3S1ejsPCjX
	RibPARY8Q2As/ROcsVArBe0rRoUmuKgX53FlGRlBuJGIDKkfE7Uq27C6jdiOzvp3gxD3b07Q5lS
	EUuyzzQvp2y8N8und1N84FXdErrAruFTbygzPzHPcKcVh59Maw7QB9g9H4LwCB0iZiej86rYlb1
	MyyOZnOYsTT+0w8MZVCOOux7zpzmkGDCAgKl34LD5X+fVph2VVLR3erEs/ajSmDEZxWpRDkDdYp
	LRW1FTtBFRhm/x5827rMZy2VcI13kk0v8+rLlz4ca2kS7+ai53k3D9e0nrPFECkNXH13lqm5zqz
	ztRHBFBnf2i9gPsaNdUi+2zeikkfHEOz+mFIror5VcEKPWvzK9J/pOsPsErJADL/imChPIbso0p
	gCD/0g7dn/fvUqwEYpqOrEhnqnBifsUiTsyquQ==
X-Received: by 2002:a05:600c:8b86:b0:49f:ce73:7a9 with SMTP id 5b1f17b1804b1-49fe6701ed1mr2647015e9.34.1790190715086;
        Wed, 23 Sep 2026 12:11:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c5c41asm63002065e9.4.2026.09.23.12.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/18] bpf: Size liveness stack masks by the stack each frame uses
Date: Wed, 23 Sep 2026 21:11:14 +0200
Message-ID: <20260923191139.2816206-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26485; i=memxor@gmail.com; h=from:subject; bh=mB7a2b37GudHMZg0vV1wdSdDqX7CCk1ohldJkl28YyE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4teA9d+nLr3qz88ZvdHo4gqeMjuLhXsfNB1duPFnP lN6SnJrRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbC6cLI8DH5zt0f21Zc3rhb XG3+ypbdhadWZ0q8+edYq2644ppFgCsjw0IOMQ6HqS9Sl7aHfd5sqp4YsHS/3ZTrTI177Xfrq4p eZwQA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stack liveness tracks three masks of 4-byte stack slots - may_read,
must_write and live_before - for every instruction of every frame of
every function instance. Each mask used to be a fixed 128-bit spis_t,
wide enough for the deepest frame MAX_BPF_STACK allows, so an
instruction paid 48 bytes per frame no matter how little stack the frame
actually touched. These per instruction arrays are the largest liveness
allocation: a 40k instruction program spends ~2 MiB on each frame array.
Sizing them for a larger stack budget would multiply that cost for every
program, while most frames use a fraction of the budget.

Replace the fixed masks with a variable width bitmap array per
(instance, frame). struct frame_masks holds the width shared by all of
its masks in @words plus a flat unsigned long array, where mask @kind of
the instruction at relative index @i lives at
&bits[(i * FM_MASK_CNT + kind) * words]. An array starts at the width
the first recorded half-slot needs (minimum one word, that is 256 bytes
of stack with 64-bit words) and is reallocated into a wider stride once
a deeper half-slot shows up. Only the marking functions widen an array,
and they all run during the static analysis before do_check(), so no
verification time path can move one.

The marking API now takes an inclusive half-slot range, which is what
record_stack_access_off() computed anyway, and clamps the upper end to
the deepest half-slot a frame can have. An access below the stack bound
is rejected by the main verifier pass later; liveness only has to stay
inside the masks. A range that covers no whole half-slot, as a byte
store at fp-1 produces, marks nothing.

A "read everything" mark, used for calls that are neither helpers nor
kfuncs and for pointers whose offset or frame identity was lost, widens
the array to the maximum width and sets every bit: recorded at a
narrower width it would lose the half-slots a later widening adds, and
no write can cancel it as no write covers the whole frame. A half-slot
past the width of the masks was never read by the frame and is never
live.

merge_instances() may see a different width on each side, so it widens
dst to cover src and counts a word only dst has as zero on the src
side, which unions into may_read as a no-op and intersects must_write
to empty, never claiming a write that did not happen.

The rest is mechanical: update_insn() propagates live_before word by
word over the array's width (all instructions of one array share it,
hence so do an instruction's successors), is_live_before() answers
false past the width, and the use:/def: log printing iterates up to the
width.

Liveness results are unchanged. A half-slot only ever gets a bit from a
recorded access and recording one widens the array to cover it, so every
bit the fixed masks could hold still fits. Frames whose deepest recorded
half-slot fits in a single word now cost 24 bytes per instruction per
frame instead of 48.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  46 -----
 kernel/bpf/liveness.c        | 345 ++++++++++++++++++++++++-----------
 2 files changed, 238 insertions(+), 153 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 354463a74292..0f348ce81fe2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -253,52 +253,6 @@ enum bpf_stack_slot_type {
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
 #define STACK_SLOT_SZ		4
-#define STACK_SLOTS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)	/* 128 */
-
-typedef struct {
-	u64 v[2];
-} spis_t;
-
-#define SPIS_ZERO	((spis_t){})
-#define SPIS_ALL	((spis_t){{ U64_MAX, U64_MAX }})
-
-static inline bool spis_is_zero(spis_t s)
-{
-	return s.v[0] == 0 && s.v[1] == 0;
-}
-
-static inline bool spis_equal(spis_t a, spis_t b)
-{
-	return a.v[0] == b.v[0] && a.v[1] == b.v[1];
-}
-
-static inline spis_t spis_or(spis_t a, spis_t b)
-{
-	return (spis_t){{ a.v[0] | b.v[0], a.v[1] | b.v[1] }};
-}
-
-static inline spis_t spis_and(spis_t a, spis_t b)
-{
-	return (spis_t){{ a.v[0] & b.v[0], a.v[1] & b.v[1] }};
-}
-
-static inline spis_t spis_not(spis_t s)
-{
-	return (spis_t){{ ~s.v[0], ~s.v[1] }};
-}
-
-static inline bool spis_test_bit(spis_t s, u32 slot)
-{
-	return s.v[slot / 64] & BIT_ULL(slot % 64);
-}
-
-static inline void spis_or_range(spis_t *mask, u32 lo, u32 hi)
-{
-	u32 w;
-
-	for (w = lo; w <= hi && w < STACK_SLOTS; w++)
-		mask->v[w / 64] |= BIT_ULL(w % 64);
-}
 
 #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
 			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 44ecdc5b4ec2..07eb84ae0b7f 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -10,10 +10,39 @@
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
-struct per_frame_masks {
-	spis_t may_read;	/* stack slots that may be read by this instruction */
-	spis_t must_write;	/* stack slots written by this instruction */
-	spis_t live_before;	/* stack slots that may be read by this insn and its successors */
+/*
+ * Stack liveness is tracked with a 4-byte (half register) granularity.
+ * Half-slot 0 covers [fp-4, fp), half-slot 1 covers [fp-8, fp-4), and so on,
+ * hence FRAME_HALF_SPIS - 1 is the deepest half-slot a frame can have.
+ */
+#define FRAME_HALF_SPIS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)
+#define FRAME_MAX_WORDS		BITS_TO_LONGS(FRAME_HALF_SPIS)
+
+/* Masks tracked for each instruction of a frame */
+enum {
+	FM_MAY_READ,	/* stack slots that may be read by this instruction */
+	FM_MUST_WRITE,	/* stack slots written by this instruction */
+	FM_LIVE_BEFORE,	/* stack slots that may be read by this insn and its successors */
+	FM_MASK_CNT,
+};
+
+/*
+ * Per instruction stack masks for one frame of a function instance.
+ *
+ * Most frames use only a fraction of the stack budget, so instead of masks
+ * wide enough for every half-slot of the largest possible frame, all masks
+ * of one array share the width @words, and the marking functions widen the
+ * array as deeper half-slots are recorded. Mask @kind of the instruction at
+ * relative index @i is at &bits[(i * FM_MASK_CNT + kind) * words]. A
+ * half-slot at or past @words * BITS_PER_LONG is never read by this frame,
+ * hence never live. An instruction that may read the whole frame, such as a
+ * call passing a frame pointer to another subprog, widens the array to
+ * FRAME_MAX_WORDS, so that the read cannot lose half-slots to a later
+ * widening.
+ */
+struct frame_masks {
+	u32 words;
+	unsigned long bits[];
 };
 
 /*
@@ -29,7 +58,7 @@ struct func_instance {
 	u32 subprog_start;	/* cached env->subprog_info[subprog].start */
 	u32 insn_cnt;		/* cached number of insns in the function */
 	/* Per frame, per instruction masks, frames allocated lazily. */
-	struct per_frame_masks *frames[MAX_CALL_FRAMES];
+	struct frame_masks *frames[MAX_CALL_FRAMES];
 	bool must_write_initialized;
 };
 
@@ -151,50 +180,118 @@ static int relative_idx(struct func_instance *instance, u32 insn_idx)
 	return insn_idx - instance->subprog_start;
 }
 
-static struct per_frame_masks *get_frame_masks(struct func_instance *instance,
-					       u32 frame, u32 insn_idx)
+static u32 frame_mask_bits(struct frame_masks *fm)
 {
-	if (!instance->frames[frame])
-		return NULL;
+	return fm->words * BITS_PER_LONG;
+}
 
-	return &instance->frames[frame][relative_idx(instance, insn_idx)];
+static size_t frame_mask_words(struct func_instance *instance, u32 words)
+{
+	return (size_t)instance->insn_cnt * FM_MASK_CNT * words;
 }
 
-static struct per_frame_masks *alloc_frame_masks(struct func_instance *instance,
-						 u32 frame, u32 insn_idx)
+/* Mask @kind of the instruction at relative index @rel */
+static unsigned long *rel_mask(struct frame_masks *fm, u32 rel, u32 kind)
 {
-	struct per_frame_masks *arr;
+	return fm->bits + ((size_t)rel * FM_MASK_CNT + kind) * fm->words;
+}
 
-	if (!instance->frames[frame]) {
-		arr = kvzalloc_objs(*arr, instance->insn_cnt,
-				    GFP_KERNEL_ACCOUNT);
-		instance->frames[frame] = arr;
-		if (!arr)
-			return ERR_PTR(-ENOMEM);
+/*
+ * Make sure @frame has a mask array at least @words wide, allocating it or
+ * copying the existing masks into the wider stride as needed.
+ * @words must be in range [1, FRAME_MAX_WORDS].
+ */
+static struct frame_masks *widen_frame_masks(struct func_instance *instance,
+					     u32 frame, u32 words)
+{
+	struct frame_masks *old = instance->frames[frame], *new;
+	u32 i, kind;
+
+	if (old && old->words >= words)
+		return old;
+	new = kvzalloc_flex(*new, bits, frame_mask_words(instance, words), GFP_KERNEL_ACCOUNT);
+	if (!new)
+		return NULL;
+	new->words = words;
+	if (old) {
+		for (i = 0; i < instance->insn_cnt; i++)
+			for (kind = 0; kind < FM_MASK_CNT; kind++)
+				memcpy(rel_mask(new, i, kind), rel_mask(old, i, kind),
+				       old->words * sizeof(*old->bits));
+		kvfree(old);
 	}
-	return get_frame_masks(instance, frame, insn_idx);
+	instance->frames[frame] = new;
+	return new;
 }
 
-/* Accumulate may_read masks for @frame at @insn_idx */
-static int mark_stack_read(struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
+/*
+ * Set the inclusive half-slot range [lo, hi] in mask @kind of @frame at @insn_idx.
+ * An empty range, including one with a negative @hi as computed for a write
+ * that does not fully cover any half-slot, marks nothing.
+ */
+static int mark_stack_range(struct func_instance *instance, u32 frame, u32 insn_idx,
+			    u32 kind, s32 lo, s32 hi)
 {
-	struct per_frame_masks *masks;
+	struct frame_masks *fm;
 
-	masks = alloc_frame_masks(instance, frame, insn_idx);
-	if (IS_ERR(masks))
-		return PTR_ERR(masks);
-	masks->may_read = spis_or(masks->may_read, mask);
+	/*
+	 * An access past the frame bottom is rejected by the main verifier
+	 * pass later, liveness only has to avoid running off the masks.
+	 */
+	hi = min_t(s32, hi, FRAME_HALF_SPIS - 1);
+	if (lo > hi)
+		return 0;
+	fm = widen_frame_masks(instance, frame, BITS_TO_LONGS(hi + 1));
+	if (!fm)
+		return -ENOMEM;
+	bitmap_set(rel_mask(fm, relative_idx(instance, insn_idx), kind), lo, hi - lo + 1);
 	return 0;
 }
 
-static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
+/* Accumulate may_read for half-slots [lo, hi] of @frame at @insn_idx */
+static int mark_stack_read(struct func_instance *instance, u32 frame, u32 insn_idx,
+			   s32 lo, s32 hi)
+{
+	return mark_stack_range(instance, frame, insn_idx, FM_MAY_READ, lo, hi);
+}
+
+/* Accumulate must_write for half-slots [lo, hi] of @frame at @insn_idx */
+static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_idx,
+			    s32 lo, s32 hi)
 {
-	struct per_frame_masks *masks;
+	return mark_stack_range(instance, frame, insn_idx, FM_MUST_WRITE, lo, hi);
+}
 
-	masks = alloc_frame_masks(instance, frame, insn_idx);
-	if (IS_ERR(masks))
-		return PTR_ERR(masks);
-	masks->must_write = spis_or(masks->must_write, mask);
+/*
+ * Mark every half-slot of @frame as possibly read by @insn_idx. This widens
+ * the masks to the maximum width: a full read recorded at a narrower width
+ * would leave the bits added by a later widening clear and lose part of it.
+ */
+static int mark_stack_read_all(struct func_instance *instance, u32 frame, u32 insn_idx)
+{
+	return mark_stack_read(instance, frame, insn_idx, 0, FRAME_HALF_SPIS - 1);
+}
+
+/* Accumulate @src, a mask @src_words wide, into may_read of @frame at @insn_idx */
+static int mark_stack_read_mask(struct func_instance *instance, u32 frame, u32 insn_idx,
+				const unsigned long *src, u32 src_words)
+{
+	u32 nbits = src_words * BITS_PER_LONG;
+	struct frame_masks *fm;
+	unsigned long *dst;
+	u32 last, w;
+
+	last = find_last_bit(src, nbits);
+	if (last == nbits)
+		return 0;
+	fm = widen_frame_masks(instance, frame, BITS_TO_LONGS(last + 1));
+	if (!fm)
+		return -ENOMEM;
+	dst = rel_mask(fm, relative_idx(instance, insn_idx), FM_MAY_READ);
+	/* @src has no bits set past @last, hence none past @fm->words either */
+	src_words = min(src_words, fm->words);
+	for (w = 0; w < src_words; w++)
+		dst[w] |= src[w];
 	return 0;
 }
 
@@ -272,33 +369,42 @@ __diag_pop();
 static inline bool update_insn(struct bpf_verifier_env *env,
 			       struct func_instance *instance, u32 frame, u32 insn_idx)
 {
-	spis_t new_before, new_after;
-	struct per_frame_masks *insn, *succ_insn;
+	unsigned long new_after[FRAME_MAX_WORDS] = {};
+	unsigned long *may_read, *must_write, *live_before;
+	struct frame_masks *fm = instance->frames[frame];
+	u32 rel = relative_idx(instance, insn_idx);
 	struct bpf_iarray *succ;
-	u32 s;
-	bool changed;
+	bool changed = false;
+	u32 s, w;
 
 	succ = bpf_insn_successors(env, insn_idx);
 	if (succ->cnt == 0)
 		return false;
 
-	changed = false;
-	insn = get_frame_masks(instance, frame, insn_idx);
-	new_before = SPIS_ZERO;
-	new_after = SPIS_ZERO;
+	/* All instructions of one frame array share the same mask width */
 	for (s = 0; s < succ->cnt; ++s) {
-		succ_insn = get_frame_masks(instance, frame, succ->items[s]);
-		new_after = spis_or(new_after, succ_insn->live_before);
+		unsigned long *succ_live;
+
+		succ_live = rel_mask(fm, relative_idx(instance, succ->items[s]), FM_LIVE_BEFORE);
+		for (w = 0; w < fm->words; w++)
+			new_after[w] |= succ_live[w];
 	}
+	may_read = rel_mask(fm, rel, FM_MAY_READ);
+	must_write = rel_mask(fm, rel, FM_MUST_WRITE);
+	live_before = rel_mask(fm, rel, FM_LIVE_BEFORE);
 	/*
 	 * New "live_before" is a union of all "live_before" of successors
 	 * minus slots written by instruction plus slots read by instruction.
 	 * new_before = (new_after & ~insn->must_write) | insn->may_read
 	 */
-	new_before = spis_or(spis_and(new_after, spis_not(insn->must_write)),
-			     insn->may_read);
-	changed |= !spis_equal(new_before, insn->live_before);
-	insn->live_before = new_before;
+	for (w = 0; w < fm->words; w++) {
+		unsigned long new_before = (new_after[w] & ~must_write[w]) | may_read[w];
+
+		if (new_before != live_before[w]) {
+			live_before[w] = new_before;
+			changed = true;
+		}
+	}
 	return changed;
 }
 
@@ -329,10 +435,12 @@ static void update_instance(struct bpf_verifier_env *env, struct func_instance *
 
 static bool is_live_before(struct func_instance *instance, u32 insn_idx, u32 frameno, u32 half_spi)
 {
-	struct per_frame_masks *masks;
+	struct frame_masks *fm = instance->frames[frameno];
 
-	masks = get_frame_masks(instance, frameno, insn_idx);
-	return masks && spis_test_bit(masks->live_before, half_spi);
+	/* No recorded access reaches past the masks, so nothing there is live */
+	if (!fm || half_spi >= frame_mask_bits(fm))
+		return false;
+	return test_bit(half_spi, rel_mask(fm, relative_idx(instance, insn_idx), FM_LIVE_BEFORE));
 }
 
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
@@ -430,17 +538,19 @@ static int spi_off(int spi)
  * When only one half is set, print as "-4h","-8h",...
  * Runs of 3+ consecutive fully-set SPIs are collapsed: "fp0-8..-24"
  */
-static char *fmt_spis_mask(struct bpf_verifier_env *env, int frame, bool first, spis_t spis)
+static char *fmt_spis_mask(struct bpf_verifier_env *env, int frame, bool first,
+			   const unsigned long *spis, u32 words)
 {
 	int buf_sz = sizeof(env->tmp_str_buf);
+	int spi_cnt = words * BITS_PER_LONG / 2;
 	char *buf = env->tmp_str_buf;
 	int spi, n, run_start;
 
 	buf[0] = '\0';
 
-	for (spi = 0; spi < STACK_SLOTS / 2 && buf_sz > 0; spi++) {
-		bool lo = spis_test_bit(spis, spi * 2);
-		bool hi = spis_test_bit(spis, spi * 2 + 1);
+	for (spi = 0; spi < spi_cnt && buf_sz > 0; spi++) {
+		bool lo = test_bit(spi * 2, spis);
+		bool hi = test_bit(spi * 2 + 1, spis);
 		const char *space = first ? "" : " ";
 
 		if (!lo && !hi)
@@ -450,16 +560,16 @@ static char *fmt_spis_mask(struct bpf_verifier_env *env, int frame, bool first,
 			/* half-spi */
 			n = scnprintf(buf, buf_sz, "%sfp%d%d%s",
 				      space, frame, spi_off(spi) + (lo ? STACK_SLOT_SZ : 0), "h");
-		} else if (spi + 2 < STACK_SLOTS / 2 &&
-			   spis_test_bit(spis, spi * 2 + 2) &&
-			   spis_test_bit(spis, spi * 2 + 3) &&
-			   spis_test_bit(spis, spi * 2 + 4) &&
-			   spis_test_bit(spis, spi * 2 + 5)) {
+		} else if (spi + 2 < spi_cnt &&
+			   test_bit(spi * 2 + 2, spis) &&
+			   test_bit(spi * 2 + 3, spis) &&
+			   test_bit(spi * 2 + 4, spis) &&
+			   test_bit(spi * 2 + 5, spis)) {
 			/* 3+ consecutive full spis */
 			run_start = spi;
-			while (spi + 1 < STACK_SLOTS / 2 &&
-			       spis_test_bit(spis, (spi + 1) * 2) &&
-			       spis_test_bit(spis, (spi + 1) * 2 + 1))
+			while (spi + 1 < spi_cnt &&
+			       test_bit((spi + 1) * 2, spis) &&
+			       test_bit((spi + 1) * 2 + 1, spis))
 				spi++;
 			n = scnprintf(buf, buf_sz, "%sfp%d%d..%d",
 				      space, frame, spi_off(run_start), spi_off(spi));
@@ -478,7 +588,8 @@ static void print_instance(struct bpf_verifier_env *env, struct func_instance *i
 {
 	int start = env->subprog_info[instance->subprog].start;
 	struct bpf_insn *insns = env->prog->insnsi;
-	struct per_frame_masks *masks;
+	struct frame_masks *fm;
+	unsigned long *mask;
 	int len = instance->insn_cnt;
 	int insn_idx, frame, i;
 	bool has_use, has_def;
@@ -501,10 +612,13 @@ static void print_instance(struct bpf_verifier_env *env, struct func_instance *i
 		pos = env->log.end_pos;
 		verbose(env, " use: ");
 		for (frame = instance->depth; frame >= 0; --frame) {
-			masks = get_frame_masks(instance, frame, insn_idx);
-			if (!masks || spis_is_zero(masks->may_read))
+			fm = instance->frames[frame];
+			if (!fm)
+				continue;
+			mask = rel_mask(fm, i, FM_MAY_READ);
+			if (bitmap_empty(mask, frame_mask_bits(fm)))
 				continue;
-			verbose(env, "%s", fmt_spis_mask(env, frame, !has_use, masks->may_read));
+			verbose(env, "%s", fmt_spis_mask(env, frame, !has_use, mask, fm->words));
 			has_use = true;
 		}
 		if (!has_use)
@@ -512,10 +626,13 @@ static void print_instance(struct bpf_verifier_env *env, struct func_instance *i
 		pos = env->log.end_pos;
 		verbose(env, " def: ");
 		for (frame = instance->depth; frame >= 0; --frame) {
-			masks = get_frame_masks(instance, frame, insn_idx);
-			if (!masks || spis_is_zero(masks->must_write))
+			fm = instance->frames[frame];
+			if (!fm)
+				continue;
+			mask = rel_mask(fm, i, FM_MUST_WRITE);
+			if (bitmap_empty(mask, frame_mask_bits(fm)))
 				continue;
-			verbose(env, "%s", fmt_spis_mask(env, frame, !has_def, masks->must_write));
+			verbose(env, "%s", fmt_spis_mask(env, frame, !has_def, mask, fm->words));
 			has_def = true;
 		}
 		if (!has_def)
@@ -584,9 +701,9 @@ static int print_instances(struct bpf_verifier_env *env)
  *   - same frame + different offset -> offset-imprecise
  *   - different frames          -> fully-imprecise (bitmask OR)
  *
- * At memory access sites (LDX/STX/ST), offset-imprecise marks only
- * the known frame's access mask as SPIS_ALL, while fully-imprecise
- * iterates bits in the bitmask and routes each frame to its target.
+ * At memory access sites (LDX/STX/ST), offset-imprecise marks the known
+ * frame as fully read, while fully-imprecise iterates bits in the bitmask
+ * and routes each frame to its target.
  */
 #define MAX_ARG_OFFSETS 4
 
@@ -1235,7 +1352,6 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
 				   s64 access_bytes, u32 frame, u32 insn_idx)
 {
 	s32 slot_hi, slot_lo;
-	spis_t mask;
 
 	if (fp_off >= 0)
 		/*
@@ -1247,27 +1363,19 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
 	if (access_bytes == S64_MIN) {
 		/* helper/kfunc read unknown amount of bytes from fp_off until fp+0 */
 		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
-		mask = SPIS_ZERO;
-		spis_or_range(&mask, 0, slot_hi);
-		return mark_stack_read(instance, frame, insn_idx, mask);
+		return mark_stack_read(instance, frame, insn_idx, 0, slot_hi);
 	}
 	if (access_bytes > 0) {
 		/* Mark any touched slot as use */
 		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
 		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
-		mask = SPIS_ZERO;
-		spis_or_range(&mask, slot_lo, slot_hi);
-		return mark_stack_read(instance, frame, insn_idx, mask);
+		return mark_stack_read(instance, frame, insn_idx, slot_lo, slot_hi);
 	} else if (access_bytes < 0) {
 		/* Mark only fully covered slots as def */
 		access_bytes = -access_bytes;
 		slot_hi = (-fp_off) / STACK_SLOT_SZ - 1;
 		slot_lo = max_t(s32, (-fp_off - access_bytes + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
-		if (slot_lo <= slot_hi) {
-			mask = SPIS_ZERO;
-			spis_or_range(&mask, slot_lo, slot_hi);
-			return mark_stack_write(instance, frame, insn_idx, mask);
-		}
+		return mark_stack_write(instance, frame, insn_idx, slot_lo, slot_hi);
 	}
 	return 0;
 }
@@ -1286,7 +1394,7 @@ static int record_stack_access(struct func_instance *instance,
 		return 0;
 	if (arg->off_cnt == 0) {
 		if (access_bytes > 0 || access_bytes == S64_MIN)
-			return mark_stack_read(instance, frame, insn_idx, SPIS_ALL);
+			return mark_stack_read_all(instance, frame, insn_idx);
 		return 0;
 	}
 	if (access_bytes != S64_MIN && access_bytes < 0 && arg->off_cnt != 1)
@@ -1314,7 +1422,7 @@ static int record_imprecise(struct func_instance *instance, u32 mask, u32 insn_i
 		if (!(mask & 1))
 			continue;
 		if (f <= depth) {
-			err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+			err = mark_stack_read_all(instance, f, insn_idx);
 			if (err)
 				return err;
 		}
@@ -1410,7 +1518,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		bytes = bpf_kfunc_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else {
 		for (int f = 0; f <= depth; f++) {
-			err = mark_stack_read(instance, f, insn_idx, SPIS_ALL);
+			err = mark_stack_read_all(instance, f, insn_idx);
 			if (err)
 				return err;
 		}
@@ -1772,36 +1880,52 @@ static bool has_fp_args(struct arg_track *args)
  * may_read: union (any pass might read the slot).
  * must_write: intersection (only slots written on ALL passes are guaranteed).
  * live_before is recomputed by a subsequent update_instance() on @dst.
+ *
+ * The two instances may have settled on different mask widths for the same
+ * frame, so @dst is widened to cover @src first. A word only @dst has counts
+ * as zero on the @src side: it unions into may_read as a no-op and intersects
+ * must_write to empty.
  */
-static void merge_instances(struct func_instance *dst, struct func_instance *src)
+static int merge_instances(struct func_instance *dst, struct func_instance *src)
 {
-	int f, i;
+	struct frame_masks *d, *s;
+	u32 f, i, w;
 
 	for (f = 0; f <= dst->depth; f++) {
-		if (!src->frames[f]) {
+		s = src->frames[f];
+		d = dst->frames[f];
+		if (!s) {
 			/* This pass didn't touch frame f — must_write intersects with empty. */
-			if (dst->frames[f])
+			if (d)
 				for (i = 0; i < dst->insn_cnt; i++)
-					dst->frames[f][i].must_write = SPIS_ZERO;
+					bitmap_zero(rel_mask(d, i, FM_MUST_WRITE),
+						    frame_mask_bits(d));
 			continue;
 		}
-		if (!dst->frames[f]) {
+		if (!d) {
 			/* Previous pass didn't touch frame f — take src, zero must_write. */
-			dst->frames[f] = src->frames[f];
+			dst->frames[f] = s;
 			src->frames[f] = NULL;
 			for (i = 0; i < dst->insn_cnt; i++)
-				dst->frames[f][i].must_write = SPIS_ZERO;
+				bitmap_zero(rel_mask(s, i, FM_MUST_WRITE), frame_mask_bits(s));
 			continue;
 		}
+		d = widen_frame_masks(dst, f, s->words);
+		if (!d)
+			return -ENOMEM;
 		for (i = 0; i < dst->insn_cnt; i++) {
-			dst->frames[f][i].may_read =
-				spis_or(dst->frames[f][i].may_read,
-					src->frames[f][i].may_read);
-			dst->frames[f][i].must_write =
-				spis_and(dst->frames[f][i].must_write,
-					 src->frames[f][i].must_write);
+			unsigned long *dst_read = rel_mask(d, i, FM_MAY_READ);
+			unsigned long *dst_write = rel_mask(d, i, FM_MUST_WRITE);
+			unsigned long *src_read = rel_mask(s, i, FM_MAY_READ);
+			unsigned long *src_write = rel_mask(s, i, FM_MUST_WRITE);
+
+			for (w = 0; w < d->words; w++) {
+				dst_read[w] |= w < s->words ? src_read[w] : 0;
+				dst_write[w] &= w < s->words ? src_write[w] : 0;
+			}
 		}
 	}
+	return 0;
 }
 
 static struct func_instance *fresh_instance(struct func_instance *src)
@@ -1916,7 +2040,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 				if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
 					continue;
 				for (int f = 0; f <= depth; f++) {
-					err = mark_stack_read(instance, f, idx, SPIS_ALL);
+					err = mark_stack_read_all(instance, f, idx);
 					if (err)
 						goto out_free;
 				}
@@ -1955,13 +2079,18 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		/* Pull callee's entry liveness back to caller's callsite */
 		{
 			u32 callee_start = callee_instance->subprog_start;
-			struct per_frame_masks *entry;
+			struct frame_masks *callee_fm;
 
 			for (int f = 0; f < callee_instance->depth; f++) {
-				entry = get_frame_masks(callee_instance, f, callee_start);
-				if (!entry)
+				callee_fm = callee_instance->frames[f];
+				if (!callee_fm)
 					continue;
-				err = mark_stack_read(instance, f, idx, entry->live_before);
+				err = mark_stack_read_mask(instance, f, idx,
+							   rel_mask(callee_fm,
+								    relative_idx(callee_instance,
+										 callee_start),
+								    FM_LIVE_BEFORE),
+							   callee_fm->words);
 				if (err)
 					goto out_free;
 			}
@@ -1969,9 +2098,11 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	}
 
 	if (prev_instance) {
-		merge_instances(prev_instance, instance);
+		err = merge_instances(prev_instance, instance);
 		free_instance(instance);
 		instance = prev_instance;
+		if (err)
+			return err;
 	}
 	update_instance(env, instance);
 	return 0;
-- 
2.53.0

