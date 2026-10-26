Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983903;
	b=AkUIO2c8ifUPaIK4vb5EmJgUNMEGBVen1r9cheVoixoxXWiOs1+UVWyqB2lsyMXT6ixp
	 Jv3abXvoakEljbtTaig71DoUAlJK6YhgzVs9CeRKFOA1je6PeLKT2TBazVUlvp4Bt+o4e
	 i1YaPCupV0SmqSRRk5yBNhQcao1vy+EEdgoOsvrTMIZS9Ue+fdu/0iYCkdAUExSBDuweJ
	 V7kNzkt6fro7bXiw+jzS4fGrWeyzKkdGjuCrK5yUBerueZ3wnRQHAfxpCVqEKOFcyknC8
	 J+1GZLa2Zwk2O5wJMEWZJ+z4mgWOoCCeMLC27Fsbr18tUMCatSa1lYL0VwdiUQ8fxLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IqdQ5slnBs1+RTcvfDTU0cDTw4oDvCovJMz8OQrb8bc=;
	b=5Id/mhBY00O1BeisYd7G4wowHe6ywS7xQZ+ILN6X//vS1q9qciBb3zuLltUdyf9qbR7w
	 N9AGzQV7UI354RAXQV9zjXBHRS7wtnPK2wwvJub6QnaXh5FcMJ2Ftvd/1R6X6IQAJagHw
	 ChL5qrLyoAUW2lxLxuqLS0XW8gUsZUA4o5uVhwBnNTrz+/ayzupU4pkCazOFNGqkkxQIv
	 wj/cWj2pky6Mz+CqtjmDZZXcJm9/DJAoljxK0lcWopSFg+tELXZYdwXku848EJDkXgTYR
	 y0ivdPiU2COWWC+n18DvZFVrYeexUaq9yS1kUJn6HfEvPvWlUdtIHSVFhEhvgS820cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gAEDoxDQ;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70508606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70508606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gAEDoxDQ
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so748445a12.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983903; x=1793588703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IqdQ5slnBs1+RTcvfDTU0cDTw4oDvCovJMz8OQrb8bc=;
        b=gAEDoxDQxCLVVg0Xw13Mo6MrZEBVBYgeKzLBeNKfbnd8kzkWQIlfTf0ME+gFT5ZXTl
         yao2TdgqeyzCGS5ajLzaCYLu7UEWG1a/PxbcB/OLoxO1EKMznfGRvOSj+PdUBmlAyBpY
         7r+lmy4v9FUNGzZ9IWKjeHTkC9qphjknLPao4Y2H4XH+pj46ThUW/clrh79NJIGsNSwt
         z2XOEOKAdgY0WpMThaYBhbDZQ5B6nqFnzkwwiLJ+9TCspg5/wtmVghDHvd1FdhIqqkvV
         I2TmHg5IVpmy8H3Cp+doOe9gtx0lUQ9eRBClyS7m5k/BaCK1PAxJqTPvR1W6eoqdABn6
         mChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983903; x=1793588703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IqdQ5slnBs1+RTcvfDTU0cDTw4oDvCovJMz8OQrb8bc=;
        b=YTvt4AALASTbVGrVLPCgSi6xByteYLl0JayIonSYDkLpqkJY65Xyse4GbyscWrMupC
         /T3ldGHJcIOI+ohKfLIYlAYJng4fNDd534nl5D6w0/thSQ6IKnHB5MNZM/YuE+RBs4y/
         k1l0XCJLJPgmw5+xt2KKhUWtDRy65qqhDpVVOHexa2M6F12lCrJ6KFigwLeBvTc16vCO
         er5bO9uF7w59iROK9mIeWtX4o/MtPxO4SYEZex4Sk3wrpL7BaiMMVCBz4+xsKiGCAB+j
         41rAlkxx8d+lt1rIfwzwv7vO+zpHTQjdU6TskoKFU3Mp+QMUaQPDf2605P4K4IslCJFX
         B4wQ==
X-Gm-Message-State: AFq9FYLE3H5Got2PJqe1/pSFqQmcFLuSVqEiR6kD+RvffR/z2CZWzGgS
	+ZQi+USS/B7cLarkhatBzEJWSJqMUbTtEaaj1Pp/9CogxgZWZo4/idVUP52Akg==
X-Gm-Gg: AYBFou0LDmEvLGnJ9bMg36jctVBQq2HbwxbMg5KERXx/M+6AYYCC5nd7RR4w+Y0Kewt
	tBhLGMdj6uuNHyXpGlyPZBsbDVTJqWSU8R01WEDKixYSE76Z5Rkr4Nb3PFnjcYbBu1haZCfQ7B8
	sroGAbPt/Uoar+Hejy2KaccrEEoZcPuo7I9FYEpkPK+BQZb4D9uth8Ysca0y8OaFpiY1XPUOVE+
	vqoGThQE1+YXvfELbcIsFx87IkqyFlgS4iXhbMqfMyl9dH8i1g1zk06ERboUKSYnwaQ6DsSXQHS
	GR/72xNs4c0Z75ZPrK4grp5tooNSLjW96IJ0Z9AxsZDPTbrR++HFkuGVQpE8dQXvDirTRWNnvp+
	Dg2wXMBrKDOpQqKmmgtB9bJZfWSK+QRprhHpU+kOeHWNfTe+6KPYg5SeLN4nDn4EaOrob/Mz/Ua
	fsfaPKS4GpxvUDgoerzCVOc5Y+m870w3UTz2aBp/vHyXp6mo3jIhhgmIu0HCgpNTq/YD1RwEF/W
	DR1eOk9conclNbxAvx2MmU9YTxhOwBw3OzToPlrIw7VnFeLUxOLakCgCbHvyC3HoQuEv8kfy5OX
	F5mygp1VJCXly3IGYzKqwa0UHk0PXQyEXmslZso6PzIlRz8SVuSKhYaau7TJ399KzHP+tJQC2oy
	T3/EgDljzYFdavNeHN/YVnte2
X-Received: by 2002:a17:90b:4e83:b0:3a8:6a04:80ef with SMTP id 98e67ed59e1d1-3ade9b2cf01mr4575739a91.6.1792983902601;
        Sun, 25 Oct 2026 20:05:02 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfa82sm6361593a91.8.2026.10.25.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 54/81] bpf: Allow 24 arguments of static subprogs
Date: Mon, 26 Oct 2026 02:59:15 +0000
Message-ID: <20261026025943.404450-55-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A BPF function takes 12 arguments at most: 5 in registers and 7 in stack
slots. Rust needs more, because it passes a slice or a trait object in two
slots. For a struct with 5 fields derive(Debug) calls
core::fmt::Formatter::debug_struct_field5_finish(), which takes up to
23 slots.

The limit of 12 is for calls in which the kernel takes part. Only BPF code
calls a static subprog. Thus a static subprog can have a different limit:
MAX_BPF_STATIC_FUNC_ARGS.

  callee               arguments
  -------------------  ----------------------------------------
  kfunc, trampoline    12, no change
  global subprog       5, no change
  static subprog       12 -> 24: 5 registers and 19 stack slots

The verifier counts the stack arguments of a static subprog from its code,
and JITs get the number of stack slots from the verifier. Thus JITs do not
change.

BTF of a static subprog can now show more than 12 parameters. Before this
patch that was an error. Now the verifier marks such BTF as unreliable and
continues.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          | 9 ++++++++-
 include/linux/bpf_verifier.h | 8 ++++----
 kernel/bpf/backtrack.c       | 2 +-
 kernel/bpf/btf.c             | 5 ++++-
 kernel/bpf/verifier.c        | 4 ++--
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2ff1a2c97328..d8cd7c63f157 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1035,13 +1035,20 @@ static_assert(__BPF_RET_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  *
- * Also reuse this macro for maximum number of arguments a BPF function
+ * Also reuse this macro for maximum number of arguments a global BPF function
  * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
  * stack arg slots. The JIT may map some stack arg slots to registers based
  * on the native calling convention (e.g., arg 6 to R9 on x86-64).
  */
 #define MAX_BPF_FUNC_ARGS 12
 
+/*
+ * A static BPF function is called by BPF code only, with what the compiler
+ * makes of its arguments. A slice or a trait object of Rust takes two slots. The
+ * function that derive(Debug) calls for a struct with five fields takes 23.
+ */
+#define MAX_BPF_STATIC_FUNC_ARGS 24
+
 /* The maximum number of arguments passed through registers
  * a single function may have.
  */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 41ffe9b694a6..c0227e74899b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -499,7 +499,7 @@ static_assert(MAX_CALL_FRAMES <= (1 << 4));
 static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
-#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
+#define MAX_STACK_ARG_SLOTS (MAX_BPF_STATIC_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
 			 MAX_CALL_FRAMES)
 
@@ -1061,8 +1061,8 @@ struct bpf_subprog_info {
 	bool bail_unwinds: 1;
 	/* some call of it is not followed by unwind_goto */
 	bool plain_call: 1;
-	u8 code_stack_args:4;
-	u8 arg_slot_cnt:4;
+	u8 code_stack_args;
+	u8 arg_slot_cnt;
 
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
@@ -1089,7 +1089,7 @@ struct backtrack_state {
 	u32 frame;
 	u32 reg_masks[MAX_CALL_FRAMES];
 	unsigned long stack_masks[MAX_CALL_FRAMES][BITS_TO_LONGS(MAX_BPF_STACK_SLOTS)];
-	u8 stack_arg_masks[MAX_CALL_FRAMES];
+	u32 stack_arg_masks[MAX_CALL_FRAMES];
 };
 
 struct bpf_id_pair {
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 98539c7e42c5..a42b8b830b0b 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -226,7 +226,7 @@ static inline unsigned long *bt_stack_mask(struct backtrack_state *bt)
 	return bt_frame_stack_mask(bt, bt->frame);
 }
 
-static inline u8 bt_stack_arg_mask(struct backtrack_state *bt)
+static inline u32 bt_stack_arg_mask(struct backtrack_state *bt)
 {
 	return bt->stack_arg_masks[bt->frame];
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 274ef78b6e1c..955bb65a71f6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8819,12 +8819,15 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	sub->arg_slot_cnt = nargs;
 	if (nargs > MAX_BPF_FUNC_ARGS) {
+		/* what a static function takes is seen in its code */
+		if (!is_global)
+			return -EINVAL;
 		bpf_log(log, "kernel supports at most %d parameters, function %s has %d\n",
 			MAX_BPF_FUNC_ARGS, tname, nargs);
 		return -EFAULT;
 	}
+	sub->arg_slot_cnt = nargs;
 	err = btf_check_arg_slots(log, tname, is_global, nargs, sub);
 	if (err)
 		return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0c1de0f24b85..50e24237a6b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4625,7 +4625,7 @@ static void end_stack_arg_loads(struct bpf_verifier_env *env, struct bpf_func_st
 static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_state *state,
 				 int off, struct bpf_reg_state *value_reg)
 {
-	int max_stack_arg_regs = MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
+	int max_stack_arg_regs = MAX_STACK_ARG_SLOTS;
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	int spi = -off / BPF_REG_SIZE - 1;
 	struct bpf_reg_state *arg;
@@ -15836,7 +15836,7 @@ static void prepare_subprog_args(struct bpf_verifier_env *env)
 				j++;
 		}
 		sub->stack_args_from_code = true;
-		sub->code_stack_args = min(cnt, MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS);
+		sub->code_stack_args = min(cnt, MAX_STACK_ARG_SLOTS);
 		/* incoming + max outgoing. Calls add the latter. */
 		sub->stack_arg_cnt = sub->code_stack_args;
 		if (env->prog->aux->func_info_aux)
-- 
2.55.0

