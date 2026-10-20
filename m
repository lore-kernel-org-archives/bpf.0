Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470810;
	b=hV9o769V8GjO2yvQMiqbSDbLifcqgIAVhfW15WtIW8mHJ9s5d7yBD0i9kAejjoEf7J4P
	 ZURRVN5E27GlYLyzn/PziVa9OjgKOhKJut0RFlVxzNCD1O+qEk9K01GfrZWLw9BrtFcXm
	 CFv+NtS3N7/t3O8iWMSGQ7O7VSG2JBsns+Rph/Ok871qAcpHx7J71T3b+LOtYFqx91moW
	 aVW36tGQPgyeyhjCqXYm1t+UsNUFDt6o+e+t12YZ/gg2XEdnI2bTNLyGKmX+3yVzaVWuN
	 O5Dmbgfolts3i4YhQuCdRC0pjpPz4e/62LVMWOAAQkXIM73u55MSH9zCNTnS+TL+plw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y7AUKDNqFwfEpmqaISPInhbQniIkevbXBBU4Kej/oZg=;
	b=XgPaA/EtldICDzqVjrbAJXqWWKUSahU10YBVYIhwfpinasN3wBSRcyWkXihu/OOBhAGu
	 CPNrdMI7Gyo7ZuDn0tfB1lbkIgGP06aVTVfd3QRMwPonJh17gWo0dhjwMuHBDxLC72BqH
	 5oYBdA6fL/EbVdkmgunBjmpKUou+It2bjRpCLYRE3OJHIEeDg9tXEup5dHnkpMln5Jgex
	 5Dav4aSOyYlleU31hXU9SyqH9nJMsJB3FJO/9AigiuE6NmHYgLSd8CGyZQCWfNtDngPWg
	 Zm4EdInJGc/+6/bxFzdVnMHq/3UWbw2vHiW/0oqDsW9E//iQbaz0Ec5FxGpvZm7lH2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTjiZ7nQ;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F202606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F202606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTjiZ7nQ
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so2373104a91.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470809; x=1793075609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7AUKDNqFwfEpmqaISPInhbQniIkevbXBBU4Kej/oZg=;
        b=rTjiZ7nQh+35FLsWM/R1OumNfzc8YNyG6Yw/yQnDIPpwM2p4KfV5ANWwx+u1mF/ksJ
         Z9BBTjgf0PpzUeNAVwGHyt34T1lbWOYLv5rg03aIVwYXmbl9UIbN7cysPGVpnPT2ITye
         oa4+JnDWn0TmnhVvRKo1ZuBpcvn64Lq6CEXRm7GGBJE9z+Pb/r8+kgcWO8Zwc8so0gNw
         OF0etIGMLt48V97IgS4J8RE3F5OUw8XM+9tPMPVKi1qZJTff+0sRBiAjoYFw9i46PYkM
         p6lqkGpUANwYcJpAOq8u+4PoGpo3zg56+RDCypV0Hp5+zjwkhnSXepuLK0W7sVfzS9ro
         dopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470809; x=1793075609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7AUKDNqFwfEpmqaISPInhbQniIkevbXBBU4Kej/oZg=;
        b=bzN0XK7BYeEJoELIlom8Rj8mQ0FwVJMBDhYeIX+aX2VDdPiE+AIGTGfS0Yr2upsoF7
         Kr+GfatUO89FfVBwxdCbzp7DnaiHqjsOBUVLil59LODgDbACpgmnPrF8DhIoK5+8cana
         mgYUSkhjiz7Wvo89vSuF/KJmSL77il6vmt0KSACTxoxd41G1dJjpAdUCtV3vUv6bhA6G
         PI6GAZCNpoBFcs5mV6+26EPoDmt/ybnQTeayOjA2+MHhXlu5A+ocokLrNz4Hx6GIv2zQ
         jMrIKNnHlsM5ZAdoUrtwE9uvd8s4jB2UAkRmlafx22YjGdreS6vHlC991NSZ8MH3+O/1
         4xRQ==
X-Gm-Message-State: AFq9FYIAyimzKdepRhqsgSgV2gC535PhuEUJJ1vybHpsq4WanXMQm4Gc
	tSxSQqBWG+Cl6joBgBgfY4tVrFAGNdJQln+u1Qo8emtbXHJjObaB+4Cne9zXRw==
X-Gm-Gg: AYBFou1bgpxW0KR7NGUJxJGYzAL1o/bGbuyTnxJiyqTQxwx3h1zSVISUIHW8s0pjH/z
	s2r+bsrdCKyRg+nmvrQCFDJ2AEUn5vRbpysyDJ+Q1ybYTGxuiIZqRkrUPWXFNvlakgeSV+fD6NE
	gOIebdQYR0+B37HgvcjnA0Gc5bnHBCNsYvI1L8buzQChtJaQvsLmVNnJ3yJrNPRfvFxywa+wUCO
	SnULfqsO0hZnvqt/5jTX7DpUAqJgLqBckn2t7sC7uBOpWHzxAQGM5zLGbyWjy1bFxs4f1wclx35
	vRJJ6wvpepZJLSQZLaURWF1x3VL83WRuRoqfnY+pNiOv4dZxf9Q26pfw1hrDjwWyrK6s+FUdwDJ
	XlPbN5OoqAzZKuUJzzBPV5ULbyAUicn8SdtWxsYSJ/s2G1mzz8sB0Hrl5hJFhQFs45UPdQshmy2
	Il7Ddkla20X4HkXkK23F+2YUZEaKQbRSPRmWXddUiB4yzqHLULj3KPelV+fEktSlc2HD9H6qJjh
	tYg+BnhJJBVfOUIct8qwmAqa2ZzvxYH02RxeWWKvZ/DDnMScMzEmSxhlMhmtEhuz4X2Bss44Qc9
	6rBGAqfwGhsexyjvJOZ4msDjykMB2MlIYCim7TbviRio
X-Received: by 2002:a17:90b:4c85:b0:3ab:188b:c5bf with SMTP id 98e67ed59e1d1-3aceec79ae9mr8132351a91.18.1792470808346;
        Mon, 19 Oct 2026 21:33:28 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5c72df56sm2313004a91.0.2026.10.19.21.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 1/6] bpf: Add unwind_goto and unwind_exit insns
Date: Tue, 20 Oct 2026 04:33:14 +0000
Message-ID: <20261020043319.3031996-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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

In a function that returns 16 bytes it's 'r0 = 0; r2 = 0; unwind_exit'.

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
- unwind_exit of the main prog is exit, unless it's an extension.
- An extension leaves either way, like the subprog that it replaced.
  freplace is a jump, so the extension returns to the caller of
  the subprog. An extension that has unwind_exit can replace only a subprog
  that has it too. Otherwise there is no unwind_goto after the calls.
- Of tracing progs only fentry can attach to a subprog or an extension
  that has unwind_exit. It would return to the trampoline that called it.
- unwind_exit changes its return address, so the cpu mispredicts
  the return and runs what follows unwind_goto speculatively. Without
  CAP_PERFMON the verifier looks at that path too.
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

BPF_JCOND is the same opcode as BPF_CALL_ARGS of the interpreter, and
BPF_UNWIND_GOTO is the same number as BPF_PSEUDO_CALL. may_goto is gone by
the time a prog is dumped, unwind_goto is not. bpf_insn_prepare_dump()
tells them apart: a prog with unwind_goto is always JITed.

Compared to v1 there is no BTF decl_tag and no 'r3 = 0' before every exit.
Tail call and ld_abs are fine in a subprog that can unwind, since they
leave it like exit does.

unwind_exit doesn't set r0. An implicit definition of r0 would need
special cases in backtracking, in liveness and in the check of the return
value of the main prog. A plain 'r0 = 0' in front of it needs none.

Rust

rust-bpf [4] builds with that llvm as it is. The programs are built with
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
It's a selftest in patch 5.

[1] https://lore.kernel.org/bpf/20261018010246.1643877-1-alexei.starovoitov@gmail.com/
[2] https://lore.kernel.org/bpf/DM7KR7J8VY2T.1CZIRUF6QRCWG@gmail.com/
[3] https://github.com/llvm/llvm-project/pull/233649
[4] https://github.com/4ast/rust-bpf

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |   1 +
 include/linux/bpf_verifier.h   |   3 +
 include/linux/filter.h         |  20 ++++++
 include/uapi/linux/bpf.h       |  11 ++++
 kernel/bpf/const_fold.c        |   2 +-
 kernel/bpf/core.c              |   6 ++
 kernel/bpf/disasm.c            |   7 +-
 kernel/bpf/fixups.c            |   7 ++
 kernel/bpf/states.c            |   3 +
 kernel/bpf/syscall.c           |   6 ++
 kernel/bpf/verifier.c          | 115 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  11 ++++
 12 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7750df973494..580f89c450b5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1897,6 +1897,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool has_prologue;
 	bool might_sleep;
+	bool can_unwind;
 	bool kprobe_write_ctx;
 	/* has insns that work with the arena base, see bpf_prog_has_arena_insns() */
 	bool uses_arena_insns;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 54481da4ed2d..6606b341351e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -532,6 +532,8 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
+	/* The callee left with unwind_exit. Next insn is unwind_goto. */
+	bool unwound;
 
 	/*
 	 * First and last insn idx of this verifier state.
@@ -957,6 +959,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool can_unwind: 1; /* has unwind_exit */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 6f4c9bd024a0..fccd8db33647 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -254,6 +254,25 @@ static inline bool insn_is_mov_percpu_addr(const struct bpf_insn *insn)
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
+/*
+ * The caller of the main prog doesn't tell unwind_exit from exit. An extension
+ * is different: its caller is the caller of the subprog that it replaced.
+ */
+static inline bool bpf_prog_can_unwind(const struct bpf_prog *prog)
+{
+	return bpf_is_subprog(prog) || prog->type == BPF_PROG_TYPE_EXT;
+}
+
 static inline bool insn_is_zext(const struct bpf_insn *insn)
 {
 	return insn->code == (BPF_ALU | BPF_MOV | BPF_X) && insn->imm == 1;
@@ -1257,6 +1276,7 @@ bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
+bool bpf_jit_supports_unwind(void);
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
index fc22d66d194a..3030beb531d9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3399,6 +3399,12 @@ bool __weak bpf_jit_supports_kfunc_ret_reg_pair(void)
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
index 409b9104c723..9ae3a8160448 100644
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
@@ -1467,12 +1471,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 849bc9136299..90bc7230afa8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5087,6 +5087,12 @@ static struct bpf_insn *bpf_insn_prepare_dump(const struct bpf_prog *prog,
 			insns[i].imm = BPF_FUNC_tail_call;
 			/* fall-through */
 		}
+		/*
+		 * BPF_JCOND is the same opcode as BPF_CALL_ARGS. The latter is for
+		 * the interpreter, and a prog with unwind_goto is always JITed.
+		 */
+		if (prog->jited && bpf_is_unwind_goto(&insns[i]))
+			continue;
 		if (code == (BPF_JMP | BPF_CALL) ||
 		    code == (BPF_JMP | BPF_CALL_ARGS)) {
 			/* Restore the legacy xlated dump layout. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01434e1d23b5..6c56675c3298 100644
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
@@ -3430,6 +3431,46 @@ static int next_callx_callee(struct bpf_verifier_env *env, int caller, int from)
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
+	env->prog->aux->can_unwind = env->subprog_info[0].can_unwind;
+	return 0;
+}
+
 /*
  * Sort subprogs in topological order so that leaf subprogs come first and
  * their callers come later. This is a DFS post-order traversal of the call
@@ -11584,6 +11625,19 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 
@@ -12057,6 +12111,19 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
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
@@ -18759,6 +18826,23 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	if (bpf_is_unwind_goto(insn)) {
+		if (!env->cur_state->unwound)
+			return 0;
+		env->cur_state->unwound = false;
+		/*
+		 * unwind_exit changed its return address, so the return is
+		 * mispredicted and what follows unwind_goto runs speculatively.
+		 */
+		if (!env->bypass_spec_v1) {
+			err = sanitize_speculative_path(env, NULL, *insn_idx + 1, *insn_idx);
+			if (err)
+				return err;
+		}
+		*insn_idx += insn->off;
+		return 0;
+	}
+
 	if (opcode == BPF_JCOND) {
 		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 		int idx = *insn_idx;
@@ -19986,6 +20070,12 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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
@@ -21223,14 +21313,14 @@ static int check_jmp_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -22436,6 +22526,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		struct bpf_prog_aux *aux = tgt_prog->aux;
 		bool tgt_changes_pkt_data;
 		bool tgt_might_sleep;
+		bool tgt_can_unwind;
 
 		if (bpf_prog_is_dev_bound(prog->aux) &&
 		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
@@ -22464,6 +22555,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/* unwind_exit of the main prog is exit, unless it's an extension */
+		tgt_can_unwind = (subprog || tgt_prog->type == BPF_PROG_TYPE_EXT) &&
+				 (aux->func ? aux->func[subprog]->aux->can_unwind
+					    : aux->can_unwind);
+		/* unwind_exit would return to the trampoline that called the target */
+		if (tgt_can_unwind && !prog_extension &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (aux->func_info_aux[subprog].linkage != BTF_FUNC_GLOBAL ||
@@ -22511,6 +22612,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 					"Extension program may sleep, while original does not\n");
 				return -EINVAL;
 			}
+			/* There is no unwind_goto after the calls of the original */
+			if (prog->aux->can_unwind && !tgt_can_unwind) {
+				bpf_log(log,
+					"Extension program can unwind, while original does not\n");
+				return -EINVAL;
+			}
 		}
 		if (!tgt_prog->jited) {
 			bpf_log(log, "Can attach to only JITed progs\n");
@@ -23845,6 +23952,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

