Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022852;
	b=Pcn/m4zeLtHRiAm4YPs/QUOWapUXGpOZN/t1cpMOgIoiANlnUuuH5ApGMtEabA+dZ97M
	 Znt7srGz/byi1GmB1ESMyP6XvwwLPadgGwJFLqgHYxG7b40UDpwnDkjPVZ+MNlvrHX52D
	 UjCmE/prnx+E03HucoKnz/XTrl6Y3T6Hrc/7e9X67ujyvVqU2TgAdfvgazAbD9ukMfnPF
	 4lxmEMfjGjWPvw3k8NvIPdm4LZSNiBqSyTr0iKmQjSDDhiA4F3rQWErAHsleWzpbIjoEa
	 hF33kgfqDk1ZxJugvzC6mHClEWF52O5zQ6b4ZYhWDdbH4F/rQ8aS0R9SnZtaYpTw6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6hwYvA2FWjPpnzyrYDTkwkOvG5Ldt3dFzLh/LlZTicI=;
	b=vrU6MOjHmMBEv759yb5cF4cKAAfAE0ogRAvEiHdmCBpsHE5M6szqkrt6l0QkgWWV0dXc
	 66poBbWKFG3HGn9y/hFhx3oyf+Mq3jMbcpoDp7sSO/A1BvjNdmBHiXm42Tsc6D6VxkluW
	 wxDkIfSZ9ECdFWeBy/ASDKIXMQW1Pn3JZstt1sCbFExPBGArTX9O09Ryv6PlGO1Bi2ItE
	 eRV6//kE7RyUewIU5ucJXo5kuTzmkgPteBIznUAC7BQQ3+fTxfVzEn7nGALIxVcD2h7Hn
	 XQUwVk5GO7yZ9xPeF36VIANWonw5wC8Jx4EZBF1zbFnmV+oYKqSrTRdP0gpuzJpJo8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWho7ueK;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92894606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92894606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bWho7ueK
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb684859cbso806448a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022852; x=1794627652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hwYvA2FWjPpnzyrYDTkwkOvG5Ldt3dFzLh/LlZTicI=;
        b=bWho7ueKxk+ZF2tuYwbrMCrwVv3SlSVNkspgCkp0VB3jFKV3zfJdooSXrp5zFz2Cnl
         AjPQ8nFHEschhrtfbhkn7a4+u4w3TKgPZKeA8/wYtRALVxDnPsFUry4iAHAy54jmzHOT
         lGJ7QQCxn7ggL31kGSd1bd3cSA/eKAfVm8+n4InNcRjNRs5lgBiW//iXTHbkGGXM/nXH
         JPvhNaULIAMriCJHxYQxDph0SLpmeEhUr0cd/RsbeAbJeG4cp25Rpjq6IOz1hct6WSYy
         oImI8rSykPxkyQRom5v4ZobdjtMrwy7A+kJtP9l5mSE97hEo9IU/2qnbkoR5eEajnwo5
         jiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022852; x=1794627652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hwYvA2FWjPpnzyrYDTkwkOvG5Ldt3dFzLh/LlZTicI=;
        b=H1HWk6sZz/ZxpiyqwX07dIKbX36vwDOf4R859R7PZWje6PMJo+E8t/y3Q4OmypRoLw
         XVycJKn4pCPjxd5kNEIKvcDsVUqL6ffbR6m25NnJyh7GpsePTnMKIyvoc36i52Td/73U
         R7i2i7YXhLbQbX1U9SkFyEH8nE2oCF8CIoc7WEJQpZFepqCyh/JIW2fsIW/a/7CoOj+g
         bdG3uCGznh9+HLXGV2Q+mShZEW7y61vFvgXEwM2wqkyMLcmi2x7lPt76DayNRRqTXE7R
         Tv5/gOkQocue6xwKKCsEr5LQIKO3yjjeIVVu+lLtN9lO4Eqk+CDUbSErDMefMWtDoSKI
         K7Ew==
X-Gm-Message-State: APuU4Z8gw1IpHSdEVhF2fu/uJWasQ3PRMfgbZFMv+MJCTfjY9S/hj2UX
	aYvfRuU2ODdWGvldtLo9ceKNhT9BMM1FKMdahS4yhTVpKBy1Qw2MiRMCmGkXXw==
X-Gm-Gg: AYBFou2mHMJPHR6XUpaRi3XfcmtxCzr2raLfs5EvEpXUj8I9eE9YiFPSGJelYSGHSLc
	LiyXZOqAcmkI6HJFM42q21cL6fAtKYQN5BFkKe+UWk0QHA9QVaBYqrbH2VRlRumzLuBf2rmGC6W
	kp4phLZMBldCKtkUR/lfnSzXyrSkjYQWgPB023qOJrn081x/0t8KTqporw3YdLk1KwaHA1GPxej
	ZprfA6iDhZ7ZZ+YfGpK7/njbbdZJUZJrkl5KGMAhkFUtz/O65x8rjfa/FgSiji2GryL8Qd+6BqX
	B3iZiSAgqVepWOiFxv57LvVj4ftA5aWWAvAn6gZaUI/H+1j6l+8qZjaiSX364t/2TdWZkDL7ww3
	qbQFhIjcwOIV30/pp4YnvJKgqzUmOTbf8gJn/WOfCFWCEb7Dc5p+H20WhlNem5WE0w+h9yujf+M
	W1kJy+vttZEk1ZloyNR/wIgsfuINSXeYcMrEe9WHcPnCjffEV8oo6KgfeeFCK/bPWLVPdJ/f3IL
	TOx8dAXU7KFyBdWng7ONlyJAYIFdyVdqgG8JjGBSaV7CB5N1rM5quLfcjYW1NPcMnuR9kLs1nO0
	2VyCheDeVmkbEDpBDU6L/EX/wnYBFiciUr5y1rgzSiiAjoYFEU91WwnJVdAPh9Mt4TgliQiYfwb
	vEeEkalfX89qzS8l8JKOUE0ydGz5xqm7ZhYb7uKz4ClocRK1/AIZaXBNTeWxYzsQkVI2m6qweQA
	==
X-Received: by 2002:a05:6a21:7008:b0:3e2:8c23:4db3 with SMTP id adf61e73a8af0-3ebb1f6e0eemr5172573637.0.1794022851743;
        Fri, 06 Nov 2026 19:40:51 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a058b4sm1078286a12.16.2026.11.06.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 28/46] bpf: callx reads what the subprogs whose address is taken read
Date: Sat,  7 Nov 2026 03:37:36 +0000
Message-ID: <20261107033758.1547725-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

bpfland_stopping of scx_bpfland.rs: -13 % insns, -19 % states. 99 of the
225 progs of the schedulers of rust-bpf change: -5 % insns, -9 % states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 28 ++++++++++++++++++++++++++--
 kernel/bpf/verifier.c | 11 ++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 318db60ae230..e930d928afa5 100644
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
index a5c3e86f3f87..a3095efb1ee0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6116,6 +6116,8 @@ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
 	}
 	for_each_set_bit(s, callx, cnt)
 		bitmap_or(calls + s * words, calls + s * words, taken, cnt);
+	for_each_set_bit(s, taken, cnt)
+		si[s].addr_taken = true;
 
 	/*
 	 * Callers of a global subprog look at can_unwind before the subprog is verified.
@@ -11377,7 +11379,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 
 /*
  * The argument slots that the code of a static subprog takes, whatever its BTF says.
- * Liveness errs on the safe side: a callx in the subprog counts as a read of r1-r5.
+ * Liveness errs on the safe side: a callx in the subprog counts as a read of all that the subprogs
+ * whose address is taken read or declare.
  * But it misses r3-r5 of bpf_trace_printk() and the flags of bpf_get_branch_snapshot(), which
  * their protos do not declare. Such a subprog prints or passes a wrong number under a tracer.
  * The helpers are safe with any value there: the verifier never checks these registers.
@@ -12096,6 +12099,12 @@ static int check_func_callx_one(struct bpf_verifier_env *env, int subprog, int *
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

