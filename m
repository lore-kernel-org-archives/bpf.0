Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9328640B
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285376; cv=none; b=R4rqVGkxuNxHfoIutjsPJ3TPc/a6jGN4PQwGuyyRV0SM6BaSV3pmKkExuOzJmInFVaZ2F5+xV4U1KTTj9g7L5AyoB2+40uiS4FqqRbjKgr26RngYBuOQzZBtQ2NGh42Zjuqadn+XiVI0JDlDLk8f/nEDXR1qoCXf+vOmPlsYFLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285376; c=relaxed/simple;
	bh=QOv6OI22Gmt8lvo3HJLECdko8G18xh9FYvVV0d3DVuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MirCXExSPy2XeflzIw2YczQRcEgdUDE8WDy3mWUkl2l5sjRlWTCVFO7bydXQCDGl9QtTSqQoj0SQGIJRcjat+Ydd+EQ9HJnmlhvTIufxaHcn7hBOt4qIcpr/2onZUW6B/2rrfQ9mptFfhYJkigOri/NvJ7nXy8NtkQFU3XKAqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL25LHfK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL25LHfK"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so812176a91.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792285374; x=1792890174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuqIy61RYjGSSa/2SzJ+efDB2VrQDO9/PJ3AGJ3QMXQ=;
        b=dL25LHfKzmQZjrFNKXZCrp8eoma8TosmIlSz57urfmcSGDf2HKjZj3c65gY40qaWm7
         aAiznY6JKEbf4Sz/oekMlnuOhD7k37HN2/Bm95kf8F3bmD5xliiHUbq8pY+3jtDA4Nve
         bgHvyo85e3IDGbFYKHxo6ibJUPeuWy/Iz+nMRKwiQGYlrdbQ5E+fDzEgcSFVV4fFn25L
         H1HuUoSuBdis3Fb/0HsFlYhd9oVu+r1ckFvra9QsOUVBE6rOBDly1IY4ti4BgNSiFVtq
         b5s/sUvQjJJ5STYNfoQA6V54TM7NOhcatbXGiXToBL/SlQ8uJ6bQGfPUrSolhkB1Hk9H
         N0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285374; x=1792890174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuqIy61RYjGSSa/2SzJ+efDB2VrQDO9/PJ3AGJ3QMXQ=;
        b=KbjRO5FElKw4D/PDEQRa06GD3fZzA/d1ZpaJIbYAwRQMdwL0QseqNtw9Y2qcOmlQlJ
         KQ1VGgGnwfcvB+dsLoG9JYIXyYrJmOZLukdAtsoDFDODAAF649oH2bMwjAOV/5q7MR85
         YLvSsT3Rnv/1/yVYWOwJEGCW7nPo9k22Kgnc6dsM5MsrnWVdu69EaMKMRVZa7P1LrfDa
         3SS+w/xE7++STXmH61IKtC6hboTHD80QebkJB9arBwdWhR4mq16FQLQCvJMRrXPt3WOy
         rGYtN/gaKzFPWFXx69cxBhXHHGaF60agVN04pV/2IamB62qu0Ei/Lfv1v1Chj86UJbTd
         Ff6w==
X-Gm-Message-State: AFq9FYIL7Ds9jgHUoKq8wNJ1TmhtRMeRbKbmRuIu9dZV/9OEWByLogW+
	9gRXPYkwo+gzGwutfZ10D7TibHhpGijEWQgWurFZ8VHDB+6xFOH5XJPYDcYn3g==
X-Gm-Gg: AYBFou3aNjv1AccSvILIXXzgTgmcTAFDf+1QA58dAknrRdQ5rwauZ3KcriZTmFKM/3c
	UAqlwafxySW9hrp3O0aGiyfIU4kxnvm1eL6l7CbrJJ9ZRsVZF+9vjxV5N2wObzErWuxDe/lDPTn
	am4wYa9YF8nbOzHOicB8+Mb6SdHh4f4YYjL6FtGJr73ASocI1IXF1LHRSCRTLASMKCu4XoZirT2
	3933Nt1p3hv2jgW4qBQ7qTSL95Q0Lkt/VtEFBMPTC5m1ekJBnnTh7jtxQ0Tb8YWno1M9uUwHIyr
	eu145dgw/Yb62zN8Wv5nDMs6azsRrQ8s5/90h3foE149b2RA+Nx81Vwy1o/l1zn7q3z7Qqj0eEp
	jrce+FirJ/hRcr+VFdKhv48xIA/Ra58PN4ntJkdVXglrpPcBsW+bT/bFr/q6Q0FYbRXBhBHkqU1
	J5CyVr2DWHHP/pO9V1Zo1V5kknJNP2vsJunxT5lysUqinDlPSOAG7eZ3fmSZ9sMnwEU35qhrhh4
	hjsQGnF2FPxTn++WVT9wB5TXFV+QWcjxPX6PI2t4i97qO8hf+H7sq4ld1qcpd8cgH8kQeYClm/1
	kPutQZQqHnXhC0SAL32CHNOdlPOkYcydo9d5ooTe5x0=
X-Received: by 2002:a17:90b:2e85:b0:3ac:aa8d:19eb with SMTP id 98e67ed59e1d1-3acee29585cmr2984680a91.3.1792285374142;
        Sat, 17 Oct 2026 18:02:54 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm14717677a91.5.2026.10.17.18.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:02:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/5] bpf: Support unwinding via r3
Date: Sun, 18 Oct 2026 01:02:41 +0000
Message-ID: <20261018010246.1643877-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Rust Drop, C++ destructors and __attribute__((cleanup)) in C have to run
when a panic or an exception passes through a frame.

llvm lowers unwinding to plain insns [1]. A function that can unwind says
in r3 how it returns, and its caller looks at r3 after the call:

  ret                            r3 = 0; exit
  invoke foo unwind pad          call foo; if r3 != 0 goto pad
  resume                         r0 = 0; r3 = 1; exit
  call _Unwind_RaiseException    r0 = 0; r3 = 1; exit
  invoke _Unwind_RaiseException  r0 = 0; goto pad

Landing pads are ordinary blocks reached by ordinary branches, so the
verifier checks them like any other code. A pad that forgets to drop
a lock or a reference is a leak on that path. There are no tables, no stack
walk, no uapi, no kfuncs and nothing to do for libbpf and other loaders.

The kernel only has to know which subprogs say something in r3.
llvm marks them with BTF decl_tag "unwind". For such a subprog:
- It has to exit with a scalar in r3, which reaches the caller like r0
  does. After a call to a global subprog it's an unknown scalar.
- As a callback it has to exit with r3 == 0. The helper that calls it
  doesn't look at r3.
- Tail call and ld_abs are rejected. Both return to the caller of the
  subprog with whatever is in r3.
- Only fentry can attach to it. A trampoline that calls the subprog and
  an extension that replaces it don't keep r3.
- The prog has to be JITed. The interpreter returns r0 only.
Without the tag r3 is not readable after a call, as before.

r3 steers control flow. A JIT that loses it between 'exit' and the insn
after the call would skip a pad that the verifier saw running. So JITs opt
in with bpf_jit_supports_unwind(). x86-64 does: r3 is rdx and the epilogue
doesn't touch it.

Rust

rust-bpf is switched to it [2]. The programs are built with
-C panic=unwind. The panic handler prints the message and calls
_Unwind_RaiseException(). The IR post-processing used to turn invoke into
call and drop the pads. Now it leaves invoke, landingpad and resume to
llvm.
A panic that cannot unwind, e.g. one that reaches an extern "C" function,
still ends in bpf_throw().
exc_cleanup.rs panics three frames deep, with preemption disabled in one
frame and rcu_read_lock held in another. All Drop impls run and the prog
returns 0.
scx_simple.rs is 2216 insns. 13 of 37 direct calls of subprogs and all 20
indirect calls are followed by the branch. In scx_cosmos.rs it's 21 of 61
and 20 of 20 in 3716 insns.

C++

Exceptions work too. This compiles, loads and runs:

  struct rcu_guard {
          rcu_guard() { bpf_rcu_read_lock(); }
          ~rcu_guard() { bpf_rcu_read_unlock(); }
  };

  static __noinline int inner(int len)
  {
          rcu_guard guard;

          if (len > 100)
                  throw 1;
          return len;
  }

  SEC("tc") int prog(struct __sk_buff *skb)
  {
          try {
                  return inner(skb->len);
          } catch (...) {
                  return 42;
          }
  }

It returns 64 for a packet of 64 bytes and 42 for a packet of 200 bytes.
The destructor runs in both cases, otherwise the verifier would reject
the prog. 'throw' is a jump to the pad with the destructor. 'catch' is
the branch after the call:

  inner:
    w6 = w1
    call bpf_rcu_read_lock
    if w6 s< 101 goto ret
    goto pad
  ret:
    call bpf_rcu_read_unlock
    w0 = w6
    r3 = 0
    exit
  pad:
    call bpf_rcu_read_unlock
    r0 = 0
    r3 = 1
    exit

  prog:
    w6 = *(u32 *)(r1 + 0)
    w1 = w6
    call inner
    if r3 != 0 goto catch
  out:
    w0 = w6
    exit
  catch:
    w6 = 42
    goto out

It needs -fexceptions -funwind-tables and four one line __cxa_*()
functions, where __cxa_throw() calls _Unwind_RaiseException().
Every pad is entered whatever was thrown, so llvm takes catch (...) only.
It's a selftest in the last patch.

[1] https://github.com/llvm/llvm-project/pull/233140
[2] https://github.com/4ast/rust-bpf/commit/b3225d1

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c  |  5 +++
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  3 ++
 include/linux/filter.h       |  1 +
 kernel/bpf/backtrack.c       | 10 ++++--
 kernel/bpf/core.c            |  9 +++++
 kernel/bpf/fixups.c          |  1 +
 kernel/bpf/liveness.c        |  7 ++--
 kernel/bpf/verifier.c        | 66 ++++++++++++++++++++++++++++++++++--
 9 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 11a4e4f87aac..16e847c615bc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -5025,6 +5025,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
 
+bool bpf_jit_supports_unwind(void)
+{
+	return true;
+}
+
 const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
 {
 	return &x86_arg_abi;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 22947fa192e4..5f824c4242be 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1894,6 +1894,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool ret_unwind;
 	bool kprobe_write_ctx;
 	struct {
 		s32 keyring_serial;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e420d211f423..0f25454094a7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -949,6 +949,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool ret_unwind: 1; /* says in r3 whether it returns or unwinds */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
@@ -1219,6 +1220,8 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
 
+#define BPF_REG_UNWIND BPF_REG_3
+
 static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
 {
 	return subprog_info(env, subprog)->ret_reg_pair;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8f..15600d0e1b57 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1244,6 +1244,7 @@ bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
+bool bpf_jit_supports_unwind(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0..0f8dbacdf9ca 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -448,6 +448,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				bt_clear_reg(bt, BPF_REG_0);
 				/* and if it does not set R2, main pass would catch it */
 				bt_clear_reg(bt, BPF_REG_2);
+				bt_clear_reg(bt, BPF_REG_UNWIND);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -548,7 +549,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
-			bool from_subprog_call, r0_precise, r2_precise;
+			bool from_subprog_call, r0_precise, r2_precise, r3_precise;
 
 			/* BPF_EXIT in subprog or callback always returns
 			 * right after the call instruction, so by checking
@@ -565,6 +566,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 
 			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
 			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
+			r3_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_UNWIND);
 
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -578,8 +580,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * might be a precise helper argument as well, so leave it set.
 			 */
 			bt_clear_reg(bt, BPF_REG_0);
-			if (from_subprog_call)
+			if (from_subprog_call) {
 				bt_clear_reg(bt, BPF_REG_2);
+				bt_clear_reg(bt, BPF_REG_UNWIND);
+			}
 			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
 				verifier_bug(env, "backtracking exit unexpected regs %x",
 					     bt_reg_mask(bt));
@@ -593,6 +597,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				bt_set_reg(bt, BPF_REG_0);
 			if (r2_precise)
 				bt_set_reg(bt, BPF_REG_2);
+			if (r3_precise)
+				bt_set_reg(bt, BPF_REG_UNWIND);
 			/* r6-r9 and stack slots will stay set in caller frame
 			 * bitmasks until we return back from callee(s)
 			 */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e1216927373a..b16d74d2681a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3322,6 +3322,15 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return false;
 }
 
+/*
+ * What a subprog leaves in r3 has to reach its caller: nothing from 'exit' to
+ * the insn after the call may clobber it.
+ */
+bool __weak bpf_jit_supports_unwind(void)
+{
+	return false;
+}
+
 /*
  * How this arch places a by-value kfunc argument, or NULL for one that has
  * not opted in and so only takes an argument of a single eightbyte, which
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fe59e3114d82..5e3e3cd378ee 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1383,6 +1383,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->ret_unwind = env->subprog_info[i].ret_unwind;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..51ccb8b080a9 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2482,7 +2482,7 @@ static int callee_subprog(struct bpf_verifier_env *env, const struct bpf_insn *i
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info,
-				   bool ret_reg_pair)
+				   bool ret_reg_pair, bool ret_unwind)
 {
 	struct bpf_call_summary cs;
 	const u8 class = BPF_CLASS(insn->code);
@@ -2616,6 +2616,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_EXIT:
 			def = 0;
 			use = ret_reg_pair ? (r0 | r2) : r0;
+			if (ret_unwind)
+				use |= reg64_mask(BPF_REG_UNWIND);
 			break;
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
@@ -2698,7 +2700,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		ret_reg_pair = bpf_ret_reg_pair(env, subprog);
 
 		for (i = start; i < end; ++i)
-			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
+			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair,
+					       subprog && env->subprog_info[subprog].ret_unwind);
 	}
 
 	/* Forward pass: resolve stack access through FP-derived pointers */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c812a5f1da8..7f1aefafa0b9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -440,7 +440,7 @@ static const int ret_regs[] = { BPF_REG_0, BPF_REG_2 };
 static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 {
 	const struct btf *btf = env->prog->aux->btf;
-	const struct btf_type *type;
+	const struct btf_type *type, *func;
 	int subprog;
 	u32 size;
 
@@ -454,8 +454,26 @@ static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 	 * refuses to replace a function returning more than 8 bytes.
 	 */
 	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
+		struct bpf_subprog_info *sub = subprog_info(env, subprog);
+
 		type = subprog_ret_type(env, subprog);
-		if (!type || btf_type_is_void(type))
+		if (!type)
+			continue;
+		func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
+		if (btf_find_next_decl_tag(btf, func, -1, "unwind", 0) > 0) {
+			if (!bpf_jit_supports_unwind()) {
+				verbose(env, "JIT does not support unwinding\n");
+				return -ENOTSUPP;
+			}
+			/* They return to the caller with whatever is in r3. */
+			if (sub->has_tail_call || sub->has_ld_abs) {
+				verbose(env, "tail call or ld_abs in a subprog that can unwind\n");
+				return -EINVAL;
+			}
+			sub->ret_unwind = true;
+			env->prog->jit_required = 1;
+		}
+		if (btf_type_is_void(type))
 			continue;
 		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
 				    "cannot size return type of subprog %d", subprog))
@@ -11471,6 +11489,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			}
 		}
 
+		if (env->subprog_info[subprog].ret_unwind)
+			mark_reg_unknown(env, caller->regs, BPF_REG_UNWIND);
+
 		if (env->subprog_info[subprog].might_throw) {
 			struct bpf_verifier_state *branch;
 
@@ -11923,13 +11944,14 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	bool in_callback_fn;
+	bool in_callback_fn, ret_unwind;
 	u32 i, nregs;
 	int err;
 
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	ret_unwind = subprog_info(env, callee->subprogno)->ret_unwind;
 	for (i = 0; i < nregs; i++) {
 		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
 			continue;
@@ -11961,6 +11983,16 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					       "At callback return", "R0");
 			return -EINVAL;
 		}
+		/* the helper that called it does not look at r3 */
+		if (ret_unwind) {
+			if (!bpf_register_is_null(&callee->regs[BPF_REG_UNWIND])) {
+				verbose(env, "callback cannot unwind\n");
+				return -EINVAL;
+			}
+			err = mark_chain_precision(env, BPF_REG_UNWIND);
+			if (err)
+				return err;
+		}
 		if (!bpf_calls_callback(env, callee->callsite)) {
 			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
 				     *insn_idx, callee->callsite);
@@ -11979,6 +12011,22 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			caller->regs[regno] = callee->regs[regno];
 			bpf_diag_mod_end(env);
 		}
+		if (ret_unwind) {
+			struct bpf_reg_state *r3 = &callee->regs[BPF_REG_UNWIND];
+
+			err = check_reg_arg(env, BPF_REG_UNWIND, SRC_OP);
+			if (err)
+				return err;
+			if (r3->type != SCALAR_VALUE) {
+				verbose(env, "At subprogram exit the register R%d is not a scalar value (%s)\n",
+					BPF_REG_UNWIND, reg_type_str(env, r3->type));
+				return -EINVAL;
+			}
+			bpf_diag_mod_begin(env, &caller->regs[BPF_REG_UNWIND], r3,
+					   BPF_DIAG_MOD_WRITE);
+			caller->regs[BPF_REG_UNWIND] = *r3;
+			bpf_diag_mod_end(env);
+		}
 	}
 
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
@@ -19335,6 +19383,12 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 	u32 i, nregs;
 	int err;
 
+	if (subprog_info(env, subprog)->ret_unwind) {
+		err = check_global_ret_scalar_reg(env, BPF_REG_UNWIND);
+		if (err)
+			return err;
+	}
+
 	if (subprog_returns_void(env, subprog))
 		return 0;
 
@@ -22226,6 +22280,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/* Neither a trampoline that calls the subprog nor an extension keeps r3. */
+		if (aux->func && subprog && aux->func[subprog]->aux->ret_unwind &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (conservative) {
-- 
2.55.0

