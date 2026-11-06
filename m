Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937239;
	b=lENDE+7flr3YffgqUEawnEnY0opW6imKmVDs5k9njceiPGsyeDcb6qmVJ2WGNwB4z/qW
	 ijEjIHgxHx1Xg+syyRjzAT96iytuvFFQkVYUfK9/IvOne9SVpQqSu2EhubzphKQ0NpT5+
	 yZFuUdwsVBPZbu58j9fLspSrup3XqPoKa9qSK+UoBdEvJxAiVbFoUzuETASqStC145Lc/
	 yGZKMWK0tInfnZqpqLZOwO/P4MGMDawLHBzQ4pPtr7o4ok9A1a8Z8fkLGaL+aUMoocHWm
	 LYAncegG2kFJ+CvZNSaYoArUvs/ubdl3f5/BR7RlF80q8+cXPO7klyPBm6W9BgUR14Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m19wZcUPEmlU5qFcYs9chL9NYPG7PezQqLA1LxUyMkQ=;
	b=SbGc5chcSLhArJYZTVU3t+kD5u3282f+4W3C1YyyZDRKquGy6Yq3oAQO4DtDNByVgTuB
	 E/8BR1QbEBPeiHcolZPFsPyvWoHYZ/2NlXoLy/4cM9jgEkG+NSTPel3/D4AONoi298a9R
	 xSUPyYn+MyxweusJ0M8c1QStKYX6sXNpa2Mv8V6kaxTnMK/dKaImLYNNqmWWwexU7gM9B
	 VX6u21zkDojT/+MxE5950PadEQTPvoBRobKyPUyzmnIEmPmKW2c/FBb4j94QOqXh2+dj6
	 Aoq0K2FCTleC6sgWRh4y8sQCTv7cJwOBGZEg5h3kS3swKdVbhKmpcgfHOTKf8QA5FUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sTV8fL2L;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B59606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3B59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sTV8fL2L
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed408b0d9dso702345ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937238; x=1794542038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m19wZcUPEmlU5qFcYs9chL9NYPG7PezQqLA1LxUyMkQ=;
        b=sTV8fL2L7rBPtUaaARntaFnGGma+r18yKWidVjQBnDH82ZHDmV0FMcGqeibfA6mVrv
         bUkUqCm71B7P23Jnd5h5J7gY5HnyBCvAQoBRLqNwDbvoy+t3AsiRtOKfZkHBHdUuDZHm
         PHgjTZQbBJlceRkqUAVUOlfq2u1OsIPMw3OIYgzhayFHTWBCT/+rfnEQH4VyhtnbuJ1C
         eyIhfY2POUc8jxK+FBJmzSkCEANq3+fSTX+Y/Y07zS+53Oc/bONBs2o/f3GBOj+p1C/2
         n9S0G/yOAJs3kBh3tnFiR5DpqyuKPXPwOSWgNmho+LiegzHNil8OhbNBJpsDu3Kx6tDE
         gW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937238; x=1794542038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m19wZcUPEmlU5qFcYs9chL9NYPG7PezQqLA1LxUyMkQ=;
        b=jjmJVBXeoFOvXn6svNC9X2r//qN8fbAv1GaBkr3aAs0+7dWOoGD2mrLTVVNb4Zo1q+
         6t6DsOkXnrFeD/UWUAI4fUl68Iah0BcQevzSeeNPsuuUf2KF4f5A9+tdDnAg40DON91X
         HGszr5nGzagLEDJ6YnzCLb1w51YiwZINBKd15rKQTvrSiR1j6wtB5OtKkWz30DBc2zkK
         XjPqJ8CeGFkz/8hEERLKtZbcQf0xNxPfx5mZlALONU4TELl2Ehy2c3HvKdYKnXuWVo0R
         RvwOLpnC+cZGkmOdUWmD5wnN3JcPc5vifaHp6yn8asB6qS5Gl0+4IpekqnQogeAZLEj+
         3/qw==
X-Gm-Message-State: APuU4Z+a+1P2oYjJUUWslQbCZMUglhlX0fFf6z39H1Da396F6sbzh/Kf
	Qk+U/D4Z9tezOHg+1RzofITrPjMk5lzPQzsZLI52JeiTIHiqBIeC6mHorHaWAQ==
X-Gm-Gg: AYBFou1ou3yhpE6nyKLeREyVevlzTXns2RFID0XV2jUDNTzv84Wa7qtacSXIyX3pE4F
	iy73FIjUkmDq1uN1C+h9HEeAHH+S2Jot3TvDMmmPv+yxN79AN5PxEwC9tnYtyPQkquif1FgOZyZ
	hXabpWnTgNo3rcn5rVwgfUJGi144DNm553Vur4KrJw21R2+JdBFPp+wcznZ7jd1yQhb66ONikqr
	45UEVPyJKASiydkZuIkpRcSdSRm3PMN5BqDyAHyTO2/Xupg0opNVtDdROEUQ/sTI1P0Twz3rI57
	U5H2o6RQ9sgjSWBAXNZBWbzRYnsqtK/Uz0Z5yU74ay6JIrvyxOIJtTNVKZCUTW9lYVyGUBTFQWu
	64V+vailE/xy79J4TJ+xAXg4iIU0LPQNXvxcGduF0dWSzLeE+doyn4PZeoNLkvEdd6+4WtfSEOL
	ce3vEBG958yXLQmgx+8TVzI7x4/uy+oZ5/WRNldCiUDxXRrHyzANB2NOeClRrTXUQTqXNGnk7T1
	BemHd24stdCyXgNj7eogg9pIhjJZUTtrGAROXcA0fqAvvyw1NPa4tiXR9GdpkpT/8e4l2YEcc26
	SdTbSPqzzKOzFyabVBCqzZWhg5z8n+OZ/F1esshDd4D/niY/yAbJKZ64lQoHZszvWxXvwsqNKJi
	L/IHOsqVD2zQvmHc3OCNNnmxvlbDwDItYqbjjUd3L9Y3VHEbqWdmEgyA7Baf2ZDkJfFjrpLtd3A
	==
X-Received: by 2002:a17:90b:4fd0:b0:3a4:945e:bc33 with SMTP id 98e67ed59e1d1-3b0db705ccbmr1211432a91.47.1793937238020;
        Thu, 05 Nov 2026 19:53:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b90def97sm5751608a91.7.2026.11.05.19.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:53:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 28/45] bpf: callx reads what the subprogs whose address is taken read
Date: Fri,  6 Nov 2026 03:50:52 +0000
Message-ID: <20261106035111.3315285-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

core::fmt::write() is in each Rust prog that prints. It reads the options
of a '{}' and calls the fmt() function of the argument through a pointer:

  if n & 8 != 0  { arg_index = ...(template.cast_array().read()); }
  if n & 16 != 0 { opt.width = args.add(opt.width)...as_u16(); }
  if n & 32 != 0 { opt.precision = args.add(opt.precision)...as_u16(); }
  args.add(arg_index).as_ref().fmt(&mut Formatter::new(output, opt))?;

The last line is callx with two arguments, r1 and r2. The pass that finds
the live registers does not know the callee: callx counts as a read of
r1-r5. What the branches leave in r4 and r5 stays live:

  w4 &= 16
  if w4 == 0 goto +4          ; r4 = 0
  r3 <<= 4
  r4 = *(u64 *)(r10 - 24)     ; r4 = args, a pointer to arena
  ...
  callx r3

r4 is 0 or a pointer, r5 is a byte or a pointer. A number and a pointer
have no join: 4 states go to callx in the first pass over the loop, 2 in
each later pass, where 1 is enough. A subprog with callx in it also seems
to take 5 arguments: what its callers leave in r3-r5 is a part of its entry
state, and it is verified again for each such leftover.

callx calls only a static subprog whose address the prog takes: with
ld_imm64, or in a table in a read-only map. mark_recursive_subprogs() has
this set. Store it in addr_taken of bpf_subprog_info. The passes in flow.c
that look through callx ahead of the main pass read the bit already.
Nothing set it so far: they took no subprog for a target of callx.

  insn                        the registers of r1-r5 that it reads
  --------------------------  ---------------------------------------------
  call of a static subprog f  live at the first insn of f, as before
  callx, before               all
  callx, this patch           live at the first insn of a subprog that has
                              addr_taken, or declared in its BTF

bpf_compute_live_registers() finds both in one loop, until nothing changes.
zext_dst comes from the same result, thus check_func_callx_one() reports
a verifier bug if the callee has no addr_taken.

bpfland_stopping of scx_bpfland.rs: -9 % insns, -15 % states. 99 of the 225
progs of the schedulers of rust-bpf change: -3 % insns, -6 % states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 28 ++++++++++++++++++++++++++--
 kernel/bpf/verifier.c | 11 ++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 290d6e8147de..c8f74063913c 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2732,9 +2732,12 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			}
 			def = mask_widen(def);
 			use = mask_widen(use);
-			/* callx reads the address of the callee from dst_reg */
+			/*
+			 * callx reads the address of the callee from dst_reg. What the callee
+			 * reads is added in bpf_compute_live_registers().
+			 */
 			if (bpf_is_callx(insn))
-				use |= dst;
+				use = dst;
 			break;
 		default:
 			def = 0;
@@ -2801,6 +2804,25 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 
 	changed = true;
 	while (changed) {
+		u32 args = mask_widen(GENMASK(BPF_REG_5, BPF_REG_1)), callx_use = 0, declared;
+		bool taken = false;
+
+		/*
+		 * callx calls one of the subprogs whose address is taken, see
+		 * check_func_callx_one(). It reads what they read, as computed so far.
+		 */
+		for (subprog = 0; subprog < env->subprog_cnt; subprog++) {
+			if (!env->subprog_info[subprog].addr_taken)
+				continue;
+			callx_use |= state[env->subprog_info[subprog].start].in & args;
+			/* and what its BTF declares: the BTF is unreliable when one is not set */
+			declared = env->subprog_info[subprog].arg_slot_cnt;
+			callx_use |= mask_widen(GENMASK(declared, 1)) & args;
+			taken = true;
+		}
+		if (!taken)
+			callx_use = args;
+
 		changed = false;
 		/* a cycle of calls takes a round for each link */
 		if (signal_pending(current)) {
@@ -2829,6 +2851,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			    !bpf_subprog_is_global(env, callee_subprog(env, &insns[insn_idx])))
 				use |= state[insn_idx + insns[insn_idx].imm + 1].in &
 				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
+			if (bpf_is_callx(&insns[insn_idx]))
+				use |= callx_use;
 			new_in = (new_out & ~live->def) | use;
 			/* may_goto that is added at the head of a loop goes there */
 			t = bpf_head_guard_target(env, insn_idx);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41500f03b41b..b0d4410076dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6105,6 +6105,8 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 	}
 	for_each_set_bit(s, callx, cnt)
 		bitmap_or(calls + s * words, calls + s * words, taken, cnt);
+	for_each_set_bit(s, taken, cnt)
+		si[s].addr_taken = true;
 
 	/*
 	 * Callers of a global subprog look at can_unwind before the subprog is verified.
@@ -11366,7 +11368,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 
 /*
  * The argument slots that the code of a static subprog takes, whatever its BTF says.
- * Liveness errs on the safe side: a callx in the subprog counts as a read of r1-r5.
+ * Liveness errs on the safe side: a callx in the subprog counts as a read of all that the subprogs
+ * whose address is taken read or declare.
  * But it misses r3-r5 of bpf_trace_printk() and the flags of bpf_get_branch_snapshot(), which
  * their protos do not declare. Such a subprog prints or passes a wrong number under a tracer.
  * The helpers are safe with any value there: the verifier never checks these registers.
@@ -12080,6 +12083,12 @@ static int check_func_callx_one(struct bpf_verifier_env *env, int subprog, int *
 	if (err == -EFAULT)
 		return err;
 
+	/* bpf_compute_live_registers() counts on it */
+	if (verifier_bug_if(!env->subprog_info[subprog].addr_taken, env,
+			    "callx of %s() whose address is not taken",
+			    bpf_subprog_name(env, subprog)))
+		return -EFAULT;
+
 	err = record_callx_edge(env, cur_func(env)->subprogno, subprog);
 	if (err)
 		return err;
-- 
2.55.0

