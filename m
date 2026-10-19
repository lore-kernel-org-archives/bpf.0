Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880433B5839
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387143; cv=none; b=SgmAXBqiLXLZ0YLV1r0EJsL7Mt1KynfOSOtLfjUSzB208ZngJT0Hb3oeiA29ApKnG07RGqhpp7tSoHCFFtW0/5M/DbyBUjKsVhPUuRhP6gslx8+k1GbVxVCiQdz0/kBOYivT2y0X5QeHdyzSqp9QYhPoFMsdEJduinU99TOjcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387143; c=relaxed/simple;
	bh=sfnZ8VWO8Zy/OT2oSPr1wAS3F650bpKrCOnESQfoQ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBanBXWN957I0Vu4rv6VlUb5r+ISmMhl3R4fyJ8fnR8rFhHCiyrdnR0G7W017wHtMePJgO8jSWRnfSEZF3QlwD1qPHvC2KoyhRxP+Xc8iYCcilwxQ1NKpm5+pIIxeEdsfI7RSA5ugu51nO1sPMXz7OKMHa+92A+04PWoidHlvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIhFThPh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIhFThPh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so862771a91.2
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 22:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792387137; x=1792991937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSRShArdgBjwCdyQz33/nb4ZxlISjNlVVrywjSGL91o=;
        b=lIhFThPhgpnILeSnx35gOK+4WnQHvGVGKMfsk9iKW739YTD/haQZUfz3KoOpgA8tKT
         qpet5MIKcIj+zt1aOjZVUrX9y7THbE0nLTTRfCcIXJx43A+QcLzNYNLZftLa6bSF/oG5
         n8eEP0Bfv24oO7YdOXEDDN0EpdTq9Xwifj9b4Akx4zu8LT4mUmpGhbhOD1ItRimXg8dM
         zaJEh8VKJyIzi33GkZlGaduD9CZLT6h7eresWo43zuVePVbAK0hcidDfOE+Zew6ZgLbw
         ZJCjqGOkmGpnbSxk7l5prDPNJ6c1yphi7X0JwnBsHnZRK3a6kHlEccpVBiF68bi+h5Nr
         Z1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792387137; x=1792991937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSRShArdgBjwCdyQz33/nb4ZxlISjNlVVrywjSGL91o=;
        b=QY4+0mZm7wicpf5k2l4jvFD6u1UD8C0lSy/ACNxwJixKrYvOnrB+sNvNejVGXmMrMS
         CDw2BQefo9pRpu9w4PPj8Wi56y3czQr360YnoeUjJUB7gX5QRxvxVkyeG88DLfBEw2bh
         okqugI0RIvWyD9jxMatSyMpNFHAB8gqUhlj/tA59dfgHWB7k+LU5Rk/wey6/Zr4sDoAI
         p2Gq2o6pT6RFc1p7vVqB2Z5EOWTCGb+MSj/JQTX/Y+bGinpgbCjhCFUpJjnokpL+0Q9C
         jzcRKZFuuFrt/b2rNpIHS6G38Bs9gFSszG1ego5EQq/+QX6c2tyQIdk929g3E30/Lm7H
         JJLA==
X-Gm-Message-State: AFq9FYJQ6F5okk6JPzuAZnXlzu+8a5WXIJGYfYqy6PD3CB6QMULEEYUs
	AuF8v9pOTqcLey0I+U6Yy+JLfyXRDH/0ZJfLZKnNFiAk0DPRxQ1t3el/Kz3LZg==
X-Gm-Gg: AYBFou1MEss5H4mfx/W/dj8Wq4ZxaWEWdcshqGZiqXEHPRUlkHC/oATyE2871Ky06jT
	Gh9kSyQVNF9NswXIYEjfNF+TGntgO1ItpTCoLhAsi+c/fDYAKQxBQEZq2be2OoMioqS5wz/9eOL
	fyDHIXTgXrSVEOAns8q1Oo4gOCIcba1M7PppEHM3ykhMWDCPt2nxg02sitjMVlAVD1rX1ZGIbB8
	+dfFahQqJ4inCB2JAwFmZezefim7nBXouI8aGJYoYHZsqojm2zXncyZoPul8tX0+FPHCuKTm0Xh
	fX7vOWh17sNUTb/KFtKYjSJEbOpJkQRvb92YJyj4aIxAu6/ybIP89yid1Id81/q4uOUtkSEoPUv
	uWYuC7ncPVTTZfdXSAltZuOzFT+W1wDnjL97f14UUvyuQOScO6LIWyXgJzLzjh58C8iHQZ4jT7W
	tmlIX5Z1wZWuTzN/nkMRUyzuvJh2x7ORKyX7Hq2SbcHeXe+IBbi6wlCnJdEn+iU45DBvejG+Z2l
	7pYUk3RKIfWMJt/Q3R7j85OkJVgWyS+wCW2iu0mYp00Wn0JaN0ajo/25tK1pOxBttYNmiEJmV1R
	6znggH8FwVeepDG4UTlow5/NPr8OKk1QCM4gG2ZU+JA=
X-Received: by 2002:a17:90b:5630:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3aceeea8ed2mr5507506a91.33.1792387136261;
        Sun, 18 Oct 2026 22:18:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm8237610a91.0.2026.10.18.22.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:18:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 1/5] bpf: Add unwind_goto and unwind_exit insns
Date: Mon, 19 Oct 2026 05:18:42 +0000
Message-ID: <20261019051846.3012089-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
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

v1 [1] did it with a flag in r3 and 'if r3 != 0 goto pad' after the call.
Three bugs that the bots found there had the same cause: r3 is an ordinary
register, and JITs guessed the meaning from the shape of the code.
Kumar suggested new insns instead [2]:

  unwind_goto pad    BPF_JMP | BPF_JCOND, src_reg = BPF_UNWIND_GOTO
  unwind_exit        BPF_JMP | BPF_EXIT,  src_reg = BPF_UNWIND_EXIT

'call foo; unwind_goto pad' goes to the pad when foo left with unwind_exit
and falls through when it left with exit. No register says which one it
was. In everything else unwind_exit is exit.

llvm lowers unwinding to them [3]:

  ret                            exit
  invoke foo unwind pad          call foo; unwind_goto pad
  resume                         r0 = 0; unwind_exit
  call _Unwind_RaiseException    r0 = 0; unwind_exit
  invoke _Unwind_RaiseException  goto pad

Landing pads are ordinary blocks, so the verifier checks them like any
other code. A pad that forgets to drop a lock or a reference is a leak on
that path. There are no tables, no stack walk, no kfuncs, no BTF and
nothing to do for libbpf and other loaders.

In the verifier:
- unwind_goto has to follow a call or callx of a subprog and cannot be
  a jump target. For cfg, liveness and the rest it's one more conditional
  jump, like may_goto.
- How the callee left is one bit of the verifier state. It lives from
  the exit of the callee to the next insn. states_equal() looks at it,
  since the registers can be the same either way.
- unwind_exit is rejected when unwind_goto doesn't follow the call.
- A global subprog that has unwind_exit can leave either way. Both are
  explored after the call, like it's done for might_throw.
- Callbacks cannot unwind: sync, async and exception ones. Whoever calls
  them doesn't expect that.
- unwind_exit of the main prog is exit.
- Of tracing progs only fentry can attach to a subprog that has
  unwind_exit. It would return to the trampoline that called it.
- unwind_goto goes away together with a pad that turned out to be dead
  code. It stays when what follows it is dead code.

JITs don't emit a branch:

  unwind_goto:
	extable[n++] = { ret_addr - 1 -> pad }
  unwind_exit:
	my_ret_addr = bpf_unwind_target(my_ret_addr)
	epilogue

So exit and the normal path after the call cost nothing. Every frame fixes
only its own return address. There is no stack walk. The lookup is what
the page fault handler does for bpf progs.
The interpreter cannot do that, so the prog has to be JITed, and JITs opt
in with bpf_jit_supports_unwind(). x86-64 and arm64 are in the next
patches.

Compared to v1 there is no BTF decl_tag and no 'r3 = 0' before every exit.
Tail call and ld_abs are fine in a subprog that can unwind, since they
leave it like exit does. So is freplace: an extension leaves with exit and
the callers are ready for that.

In [4] I wrote that unwind_exit sets r0 = 0. It doesn't. An implicit
definition of r0 needs special cases in backtracking, in liveness and in
the check of the return value of the main prog. A plain 'r0 = 0' in front
of it needs none.

Rust

rust-bpf [5] builds with that llvm as it is. The programs are built with
-C panic=unwind. The panic handler prints the message and calls
_Unwind_RaiseException().
exc_cleanup.rs panics three frames deep, with preemption disabled in one
frame and rcu_read_lock held in another. All Drop impls run and the prog
returns 0.
scx_simple.rs is 2195 insns with 48 unwind_goto, 20 of them after callx,
and 16 unwind_exit. With r3 it was 2216 insns. scx_cosmos.rs is 3694 insns
with 68 and 18. It was 3716.

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
unwind_goto:

  inner:
    w6 = w1
    call bpf_rcu_read_lock
    if w6 s< 101 goto ret
    r1 = exc_obj ll
    *(u32 *)(r1 + 0) = 1
    goto pad
  ret:
    call bpf_rcu_read_unlock
    w0 = w6
    exit
  pad:
    call bpf_rcu_read_unlock
    r0 = 0
    unwind_exit

  prog:
    w6 = *(u32 *)(r1 + 0)
    w1 = w6
    call inner
    unwind_goto catch
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

[1] https://lore.kernel.org/bpf/20261018010246.1643877-1-alexei.starovoitov@gmail.com/
[2] https://lore.kernel.org/bpf/DM7KR7J8VY2T.1CZIRUF6QRCWG@gmail.com/
[3] https://github.com/llvm/llvm-project/pull/233140
[4] https://lore.kernel.org/bpf/DM8G3O0ZTUM9.MMBWXXQ7OP98@gmail.com/
[5] https://github.com/4ast/rust-bpf

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/linux/bpf_verifier.h   |  3 ++
 include/linux/filter.h         | 12 +++++
 include/uapi/linux/bpf.h       | 11 ++++
 kernel/bpf/const_fold.c        |  2 +-
 kernel/bpf/core.c              | 24 +++++++++
 kernel/bpf/disasm.c            |  7 ++-
 kernel/bpf/fixups.c            |  7 +++
 kernel/bpf/states.c            |  3 ++
 kernel/bpf/verifier.c          | 93 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 11 ++++
 11 files changed, 170 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aeb8b9b97052..641d1e82aace 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1895,6 +1895,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool can_unwind;
 	bool kprobe_write_ctx;
 	struct {
 		s32 keyring_serial;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7a72bb06fe56..4974bea905a4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -532,6 +532,8 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
+	/* The callee left with unwind_exit. Next insn is unwind_goto. */
+	bool unwound;
 
 	/*
 	 * First and last insn idx of this verifier state.
@@ -949,6 +951,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool can_unwind: 1; /* has unwind_exit */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8f..62a6a2880de7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -254,6 +254,16 @@ static inline bool insn_is_mov_percpu_addr(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = 1 })
 
+static inline bool bpf_is_unwind_goto(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_UNWIND_GOTO;
+}
+
+static inline bool bpf_is_unwind_exit(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_EXIT) && insn->src_reg == BPF_UNWIND_EXIT;
+}
+
 static inline bool insn_is_zext(const struct bpf_insn *insn)
 {
 	return insn->code == (BPF_ALU | BPF_MOV | BPF_X) && insn->imm == 1;
@@ -1244,6 +1254,8 @@ bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
+bool bpf_jit_supports_unwind(void);
+u64 bpf_unwind_target(u64 ret_addr);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f70db7515dd..6efe0ca03624 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -56,8 +56,19 @@
 
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
+	/*
+	 * Follows a call of a bpf subprog. Taken when the subprog left with
+	 * BPF_EXIT that has src_reg == BPF_UNWIND_EXIT.
+	 */
+	BPF_UNWIND_GOTO = 1,
 };
 
+/*
+ * When bpf_exit->src_reg == BPF_UNWIND_EXIT, it's the same as bpf_exit, except
+ * that BPF_UNWIND_GOTO after the call is taken.
+ */
+#define BPF_UNWIND_EXIT	1
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index 8dd8c5958eb8..f9edfde965dc 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -357,7 +357,7 @@ int bpf_prune_dead_branches(struct bpf_verifier_env *env)
 
 		if (!bpf_insn_is_cond_jump(insn->code))
 			continue;
-		if (bpf_is_may_goto_insn(insn))
+		if (BPF_OP(insn->code) == BPF_JCOND)
 			continue;
 
 		if (!(aux->const_reg_mask & BIT(insn->dst_reg)))
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e32db9777c2..da3691b47cc7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -804,6 +804,24 @@ const struct exception_table_entry *search_bpf_extables(unsigned long addr)
 	return e;
 }
 
+/*
+ * JITs don't emit a branch for unwind_goto. They add an extable entry
+ *   { .insn = ret_addr - 1, .fixup = pad - ret_addr }
+ * where ret_addr is the return address of the call in front of it. unwind_exit
+ * replaces the return address of its frame with what this function returns.
+ * ret_addr - 1, because what follows the call can have an entry of its own.
+ * No insn starts there, so a fault cannot hit the entry.
+ */
+u64 bpf_unwind_target(u64 ret_addr)
+{
+	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
+
+	/* The verifier made sure that unwind_goto follows the call */
+	if (WARN_ON_ONCE(!e))
+		return ret_addr;
+	return ret_addr + e->fixup;
+}
+
 int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		    char *sym)
 {
@@ -3342,6 +3360,12 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return false;
 }
 
+/* unwind_goto and unwind_exit */
+bool __weak bpf_jit_supports_unwind(void)
+{
+	return false;
+}
+
 /*
  * How this arch places a by-value kfunc argument, or NULL for one that has
  * not opted in and so only takes an argument of a single eightbyte, which
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 36d3228d7745..889fc074496f 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -375,11 +375,16 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			   insn->src_reg == BPF_MAY_GOTO) {
 			verbose(cbs->private_data, "(%02x) may_goto pc%+d",
 				insn->code, insn->off);
+		} else if (insn->code == (BPF_JMP | BPF_JCOND) &&
+			   insn->src_reg == BPF_UNWIND_GOTO) {
+			verbose(cbs->private_data, "(%02x) unwind_goto pc%+d",
+				insn->code, insn->off);
 		} else if (insn->code == (BPF_JMP32 | BPF_JA)) {
 			verbose(cbs->private_data, "(%02x) gotol pc%+d",
 				insn->code, insn->imm);
 		} else if (insn->code == (BPF_JMP | BPF_EXIT)) {
-			verbose(cbs->private_data, "(%02x) exit", insn->code);
+			verbose(cbs->private_data, "(%02x) %s", insn->code,
+				insn->src_reg == BPF_UNWIND_EXIT ? "unwind_exit" : "exit");
 		} else if (BPF_SRC(insn->code) == BPF_X) {
 			verbose(cbs->private_data,
 				"(%02x) if %c%d %s %c%d goto pc%+d",
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 713f14d73b06..9e5439ae04f8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -666,6 +666,10 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 		if (!bpf_insn_is_cond_jump(insn->code))
 			continue;
 
+		/* unwind_exit of a callee that never exits needs it too */
+		if (bpf_is_unwind_goto(insn) && aux_data[i + 1 + insn->off].seen)
+			continue;
+
 		if (!aux_data[i + 1].seen)
 			ja.off = insn->off;
 		else if (!aux_data[i + 1 + insn->off].seen)
@@ -1402,12 +1406,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			if (BPF_CLASS(insn->code) == BPF_STX &&
 			     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
 				num_exentries++;
+			if (bpf_is_unwind_goto(insn))
+				num_exentries++;
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->can_unwind = env->subprog_info[i].can_unwind;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index b3d250caaaa6..d7df6632a5c4 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1046,6 +1046,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
+	if (old->unwound != cur->unwound)
+		return false;
+
 	if (!refsafe(old, cur, &env->idmap_scratch))
 		return false;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74e5ac248a10..14bc69ec04e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1769,6 +1769,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return err;
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
+	dst_state->unwound = src->unwound;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
@@ -3430,6 +3431,45 @@ static int next_callx_callee(struct bpf_verifier_env *env, int caller, int from)
 	return bit < end ? bit - caller * cnt : -1;
 }
 
+/*
+ * 'call foo; unwind_goto pad' goes to the pad when foo left with unwind_exit.
+ * JITs don't emit a branch for it. unwind_exit finds the pad by its return
+ * address. So unwind_goto has to follow the call and nothing may jump to it.
+ */
+static int check_unwind_insns(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	bool seen = false;
+	int i;
+
+	for (i = 0; i < env->prog->len; i++, insn++) {
+		if (bpf_is_unwind_exit(insn)) {
+			bpf_find_containing_subprog(env, i)->can_unwind = true;
+			seen = true;
+		}
+		if (!bpf_is_unwind_goto(insn))
+			continue;
+		seen = true;
+		if (!i || !(bpf_pseudo_call(insn - 1) || bpf_is_callx(insn - 1))) {
+			verbose(env, "unwind_goto at insn %d doesn't follow a call of a subprog\n",
+				i);
+			return -EINVAL;
+		}
+		if (bpf_is_jump_target(env, i)) {
+			verbose(env, "jump to unwind_goto at insn %d\n", i);
+			return -EINVAL;
+		}
+	}
+	if (!seen)
+		return 0;
+	if (!bpf_jit_supports_unwind()) {
+		verbose(env, "JIT does not support unwinding\n");
+		return -ENOTSUPP;
+	}
+	env->prog->jit_required = 1;
+	return 0;
+}
+
 /*
  * Sort subprogs in topological order so that leaf subprogs come first and
  * their callers come later. This is a DFS post-order traversal of the call
@@ -11489,6 +11529,19 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			}
 		}
 
+		if (env->subprog_info[subprog].can_unwind) {
+			struct bpf_verifier_state *branch;
+
+			if (!bpf_is_unwind_goto(insn + 1)) {
+				verbose(env, "no unwind_goto after the call of %s()\n", sub_name);
+				return -EINVAL;
+			}
+			branch = push_stack(env, *insn_idx + 1, *insn_idx, false);
+			if (IS_ERR(branch))
+				return PTR_ERR(branch);
+			branch->unwound = true;
+		}
+
 		if (env->subprog_info[subprog].might_throw) {
 			struct bpf_verifier_state *branch;
 
@@ -11962,6 +12015,19 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 
 	caller = state->frame[state->curframe - 1];
+	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx])) {
+		/* the helper or the kfunc that called it doesn't expect that */
+		if (callee->in_callback_fn) {
+			verbose(env, "callback cannot unwind\n");
+			return -EINVAL;
+		}
+		if (!bpf_is_unwind_goto(&env->prog->insnsi[callee->callsite + 1])) {
+			verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d\n",
+				callee->callsite);
+			return -EINVAL;
+		}
+		state->unwound = true;
+	}
 	if (callee->in_callback_fn) {
 		if (r0->type != SCALAR_VALUE) {
 			verbose(env, "R0 not a scalar value\n");
@@ -18663,6 +18729,13 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	if (bpf_is_unwind_goto(insn)) {
+		if (env->cur_state->unwound)
+			*insn_idx += insn->off;
+		env->cur_state->unwound = false;
+		return 0;
+	}
+
 	if (opcode == BPF_JCOND) {
 		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 		int idx = *insn_idx;
@@ -19890,6 +19963,12 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	 * Exit from async callback implies return code restrictions
 	 * that depend on async scheduling mechanism.
 	 */
+	if ((cur_frame->in_async_callback_fn || cur_frame->in_exception_callback_fn) &&
+	    bpf_is_unwind_exit(&env->prog->insnsi[env->insn_idx])) {
+		verbose(env, "callback cannot unwind\n");
+		return -EINVAL;
+	}
+
 	if (cur_frame->subprogno &&
 	    !cur_frame->in_async_callback_fn &&
 	    !cur_frame->in_exception_callback_fn)
@@ -21092,14 +21171,14 @@ static int check_jmp_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return 0;
 	case BPF_EXIT:
 		if (BPF_SRC(insn->code) != BPF_K || insn->imm != 0 ||
-		    insn->src_reg != BPF_REG_0 || insn->dst_reg != BPF_REG_0 ||
+		    insn->src_reg > BPF_UNWIND_EXIT || insn->dst_reg != BPF_REG_0 ||
 		    class == BPF_JMP32) {
 			verbose(env, "BPF_EXIT uses reserved fields\n");
 			return -EINVAL;
 		}
 		return 0;
 	case BPF_JCOND:
-		if (insn->code != (BPF_JMP | BPF_JCOND) || insn->src_reg != BPF_MAY_GOTO ||
+		if (insn->code != (BPF_JMP | BPF_JCOND) || insn->src_reg > BPF_UNWIND_GOTO ||
 		    insn->dst_reg || insn->imm) {
 			verbose(env, "invalid may_goto imm %d\n", insn->imm);
 			return -EINVAL;
@@ -22299,6 +22378,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/* unwind_exit would return to the trampoline that called the subprog */
+		if (aux->func && subprog && aux->func[subprog]->aux->can_unwind &&
+		    !prog_extension && prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (aux->func_info_aux[subprog].linkage != BTF_FUNC_GLOBAL ||
@@ -23673,6 +23758,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = check_unwind_insns(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_postorder(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6f70db7515dd..6efe0ca03624 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -56,8 +56,19 @@
 
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
+	/*
+	 * Follows a call of a bpf subprog. Taken when the subprog left with
+	 * BPF_EXIT that has src_reg == BPF_UNWIND_EXIT.
+	 */
+	BPF_UNWIND_GOTO = 1,
 };
 
+/*
+ * When bpf_exit->src_reg == BPF_UNWIND_EXIT, it's the same as bpf_exit, except
+ * that BPF_UNWIND_GOTO after the call is taken.
+ */
+#define BPF_UNWIND_EXIT	1
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
-- 
2.55.0

