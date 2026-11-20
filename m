Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208026;
	b=jbUz3KrcyHEwd1c0aocdeMc5LL0RgQDZo0rc8nG7ghvyUohRt6AET51znRP8mSmOKgfW
	 Eeacc8xyyO6b1TNBdOvgkl18j7He4qzpeq5+JO/KyLNOrdFGWAXFrMbKWRJC/0FnzD/W2
	 T/EdVDlQP9bMcTOTH+nPkFUjklEQZ0aa5S9XqFwOl2UKY/ZIC/gT3xYmUGrB2MUg6Lyq5
	 akUUoUMfqeX+7PGsQ4qEcT29UerIl9owa+Mko0/7ZOjCbcGpFmCEMnsYOQUuWPTJRYhYa
	 HbvyglUsem0kbZ9KeZasfxxG2VFk9ObqsubVolngw3tQ8xcqD3zJk0pPPA9i1phcLWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nAERYcRW6PuyJY91DuCVO2ffvdSl2O9PQwu4YoEVQ3M=;
	b=wHRURlnJBCHIwNBjnkRvOefeDVo1FxSI8BnoHjJJFnfipym4gTNDCP3Mn9SVjnypIoAn
	 OXQY5PLgIF8ernPiuXl3mvj7mBPm9WAngIiKXTZbrcLio9FNJCgpH+GfBx53sNvPoXlLW
	 c2jjqvo5oX/TTvB3f6Rr/gliLUmXmJKKt2NZANuZzsr7BF2YU6KP7wc50J90iz4n8OHKa
	 v0ReGtpxvrncpXKi8fmW5EJmmRFJYztTrzUBh/WFYQRcg7l19k4AmOoOxAxPqpGtY0CgF
	 pCRnHk4xZpN66J5w5/u3QZxYsZscj0y4C3R7gMpNHEpEK6zBSI1a40YEYVMkDZR81Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEv1d1HZ;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEB606A6A6
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59BEB606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEv1d1HZ
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f0621eec70so979905ad.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208022; x=1795812822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAERYcRW6PuyJY91DuCVO2ffvdSl2O9PQwu4YoEVQ3M=;
        b=sEv1d1HZ8P4Z09I8+8oRxcLCPcQAt3mHR7CtpMvBJjhW6RrV/mX/NpYB8Kk2/gHSj4
         1/Pnm3w2NR+9inFDMdH+mAwpZV5Azf11JkTgDaN13D4dOjCXrH57duTu2TItIy8jb39V
         DSe5FKTMxk00GZNSAPXZU/awHYds9asBcRjud+n7FRt7Ibdagy+mM52B3pxmhHxprBio
         U+oMLIT4uwuVAhT6J0K0i0AXJKlmZygo9xB69Dr1gX+sMFweEC+vHVbqRBwgjtbaJQ39
         PDUKkU7hZt2q2FqU6dyW6RsU7D3gChMvVXQSytXqFDLCeuXr2snqrEHDhk4UtT4/s13Y
         bpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208022; x=1795812822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAERYcRW6PuyJY91DuCVO2ffvdSl2O9PQwu4YoEVQ3M=;
        b=qPPzK6Y0tC8C+sGbatLBx6CDD+SAe71cS3hMcF6FD7OZm4Qm7VQ+5beJfgG4CYo5fT
         +yDKoqRv3nISPfvhrS5UHjimmSBH5LDJ+KinIr5EAYAZMyoe+UGjMIt81X2Y+lQdPhoo
         HbMWPxc6CPZEGSfkageOmXfyfi/WRhTr5Unhv4KfOgDcFE7FbPW9cPx7iOekLXZtj4jZ
         20WozYWfJjT1ahGm8r/YSUgBpOFjIK/mmhpbFFQ7GqF3tIoJQBBATfZHt88wRE3CX6U8
         /fKzDjMvJU6sqBWU1MlBPZEvaOt0SBVg2Idg1TqDp8UhlCMpqxOTLksobUGzTcoPaZJu
         4Ttg==
X-Gm-Message-State: APuU4Z+9sFFyTP++3mzk1nEgk5ykfcS4MdSv6z76plA8fx2mVxrwTtW+
	tPA28P0vOTvcxFlwUAGghunjFggUBIrl7gFnHV10wqZqU1ZHa5fFi0srghu5kw==
X-Gm-Gg: AZFdTZexOMbej/fjCABRfFNOpMMs/khWwcQwfg8LP2UwMOW9SD0fY8cAx5blwxnExfr
	ZOMmYuyEV6lMp2j+OB88DG1jOdDdGGuWI4ReATZt4jlNhhYKFmCFhvsVPRbwWzPA2+qvORQ0loM
	LFG+FwrEEf0YOQkXw2Jxl/4P7BmREvoku/bcsERFEASnF0aWq1kH7nODDaeKZiOJNGQPFOpqUUL
	ikdOUyL4Gb3LYL0THM/iAjXGyd0lDcP3m4HzaTE2iNQKK9/9/xtdoTJ4o6WO/Oz/Ujflt+UZBdf
	JofvPZ+RnjSodcVSWZkD6V/2CZw2n8Eb2DP8CdJweWMF0Sy4/4g+YzKqu+KBaGEZQJSWOzf7qb6
	HqIBTQYvABDXHCvFmhBNctYhB4OQOg+DPKK4fMACWxfsai3rTAGkfpl7y0ezmnDcfgh6XBv+Buv
	rj9Ajiq/Jeuubri+x/SGDVQKOPR3wKuhiM0S3waZqkKD+DU6c0sEDwiJV/X6Zs381rexpxJgAIX
	mk7igpnUQ/8ZSGVX3iFYjnRDPbzfFgxNKerQXzhELlQtvYWs3xcJ9HXfW3IHRafLCl16w0SoyyZ
	BxAsZsCPDw66UFPIi8C9agPqj75bcADW2LOEIVZB5Dzs5/+O49oTsTJ5HF1V0RlNvUvLXgpyI15
	K9CjwFGOH+dgcdSRL7+/B/cxwf8pzjVgtjb8xpV0CF/JIeA7pByQWHb+QcgXk35pMAa8hUQVuQA
	==
X-Received: by 2002:a17:902:e802:b0:2e9:a16b:c251 with SMTP id d9443c01a7336-2f03efb1099mr48272125ad.3.1795208021420;
        Fri, 20 Nov 2026 12:53:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee843d2sm19044705ad.11.2026.11.20.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 37/49] bpf: Verify in passes
Date: Fri, 20 Nov 2026 20:49:45 +0000
Message-ID: <20261120204959.614908-38-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

Put the parts together. do_check_all() runs passes until a pass has no
error, or until there is no more precision:

        pass 0: join all numbers
                  |
  +---------> run a pass
  |               |
  |            error ? --- no ---> pessimized ? --- no ---> ACCEPT
  |               | yes                 | yes
  |               v                     v
  |       good pass before ?      save the good pass,
  |          | no      | yes      partition, cut the budget
  |          |         v                |
  |          |   ACCEPT, use that pass  +---> run a pass
  |          v
  |      partition
  |          |
  |  failing path ? --- yes ---> log it; if no guess, cut the budget
  |          | no                       |
  |          +<-------------------------+
  |          v
  +- yes - is more kept apart ? --- no ---> REJECT

A good pass has no error. It is a complete proof, with any precision.
If no state before the error was imprecise, the error is real and the
verifier stops. The path-sensitive run needs the deps, so it comes after
the partition. A failing path with a guess does not cut the budget. If a
pass has a real error, the log has that error and not the guess.

A valid program that no precision can prove must not use up the limit.
After the first error the limit is the larger of BPF_PARTITION_BUDGET
and two times the cost so far.

A program of 1M insns needs 1.2 GB for its tables, so BPF_MAX_MEM is
large. If the states of a small program explode, they must not use all
of it. With 2 GB a program of 500 insns takes 30 seconds before it is
rejected. So the passes can add 256 MB to the tables, and 32 KB for each
insn. That is one state with a full stack.

The later passes and the path-sensitive runs have no log, and make no
text for diagnostics. The one that gives the log runs once more. That
work is not in the limit on cost. Log level 2 has all of them.

A later pass must not hide a bug of the verifier. bpf_note_bug() sets
env->bug and turns the log on. The load ends with -EFAULT.

Programs load again: remove the refusal in bpf_check() and
-Wno-unused-function. Rename round_is_dropped() to pass_needs_restart().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  14 +-
 kernel/bpf/Makefile          |   1 -
 kernel/bpf/diagnostics.c     |   4 +-
 kernel/bpf/failing_path.c    |   8 ++
 kernel/bpf/precision.c       |   4 +
 kernel/bpf/verifier.c        | 247 ++++++++++++++++++++++++++++++-----
 6 files changed, 243 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8c5eecf7501..c1ddcf6d7c4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -12,6 +12,7 @@
 #include <linux/math64.h> /* for div_s64_rem() */
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
+#include <linux/sizes.h>
 
 /* No memory fails the load. It does not wake up the OOM killer. */
 #define BPF_GFP_MAYFAIL (__GFP_RETRY_MAYFAIL | __GFP_NOWARN)
@@ -1436,6 +1437,7 @@ struct bpf_verifier_env {
 	bool no_rcu_read_lock;
 	bool signature;
 	u8 bug:1;			/* ends the load, see bpf_note_bug() */
+	u8 log_level:7;			/* of the user */
 	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	struct bpf_patch_list patch_list;
@@ -1605,6 +1607,13 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
 
+/* No later pass can hide a bug of the verifier. Its message goes into the log. */
+static inline void bpf_note_bug(struct bpf_verifier_env *env)
+{
+	env->bug = true;
+	env->log.level = env->log_level;
+}
+
 #define verifier_bug_if(cond, env, fmt, args...)						\
 	({											\
 		bool __cond = (cond);								\
@@ -1615,6 +1624,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 #define verifier_bug(env, fmt, args...)								\
 	({											\
 		BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args);				\
+		bpf_note_bug(env);								\
 		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
 	})
 
@@ -1768,6 +1778,9 @@ void bpf_precision_free(struct bpf_verifier_env *env);
 #define BPF_COST_STATE	512	/* make, order and free a state */
 #define BPF_MAX_COST	(1ULL << 33)
 #define BPF_MAX_MEM	(1ULL << 31)
+/* What the passes can add to the tables. A loop keeps a state at each join point. */
+#define BPF_PASS_MEM_BASE	SZ_256M
+#define BPF_PASS_MEM_PER_INSN	SZ_32K	/* a state with a full stack */
 /* The floors of the cost after the first error, and of the budget of a partition */
 #define BPF_PARTITION_BUDGET	(BPF_MAX_COST / 3)
 #define BPF_MIN_BUDGET	(BPF_MAX_COST >> 12)
@@ -1806,7 +1819,6 @@ void bpf_flow_next_is_no_bound(struct bpf_verifier_env *env, int insn_idx, int h
 bool bpf_flow_loops_lost_bound(struct bpf_verifier_env *env);
 void bpf_flow_new_pass(struct bpf_verifier_env *env);
 void bpf_flow_drop_guards(struct bpf_verifier_env *env);
-void bpf_flow_new_round(struct bpf_verifier_env *env);
 int bpf_flow_place_guards(struct bpf_verifier_env *env);
 /* verifier.c, for flow.c */
 int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **backedge_loop,
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 389e78b0bc4..03f0539490c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -5,7 +5,6 @@ ifneq ($(CONFIG_BPF_JIT_ALWAYS_ON),y)
 cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
-ccflags-y += -Wno-unused-function
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o loops.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0e12078ffe1..8972b429bbc 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -255,7 +255,7 @@ static char *diag_fmt_alloc(struct bpf_verifier_env *env, size_t size)
 	size_t capacity, available;
 	char *buf;
 
-	if (!diag || !size || size > INT_MAX)
+	if (!diag || !bpf_diag_enabled(env) || !size || size > INT_MAX)
 		return NULL;
 
 	if (!list_empty(&diag->fmt_chunks)) {
@@ -406,6 +406,8 @@ void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos)
 	if (!diag)
 		return;
 
+	/* no text is in use between two blocks */
+	diag_fmt_restore(env, (struct diag_fmt_mark){});
 	log = &diag->log;
 	end_seq = log_end(log);
 	if (WARN_ON_ONCE(log_pos > end_seq))
diff --git a/kernel/bpf/failing_path.c b/kernel/bpf/failing_path.c
index 0aebd7bfe8f..677ec423622 100644
--- a/kernel/bpf/failing_path.c
+++ b/kernel/bpf/failing_path.c
@@ -252,7 +252,15 @@ bool bpf_failing_path_is_due(struct bpf_verifier_env *env)
 int bpf_failing_path_prepare(struct bpf_verifier_env *env, bool repeat)
 {
 	struct bpf_precision *prec = env->precision;
+	struct bpf_loop *loop;
+	u32 i;
 
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		if (repeat)
+			loop->infinite = loop->was_infinite;
+		loop->was_infinite = loop->infinite;
+	}
 	prec->failing_path_due = false;
 	if (prec->seen)
 		memset(prec->seen, 0, sizeof(*prec->seen) << prec->seen_bits);
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index ae9559a6e30..bb71d31c45c 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1550,6 +1550,7 @@ void bpf_restore_precision(struct bpf_verifier_env *env)
 void bpf_precision_new_pass(struct bpf_verifier_env *env)
 {
 	struct bpf_precision *prec = env->precision;
+	u32 i;
 
 	bitmap_zero(prec->this_pass.unproven_insns, env->prog->len);
 	bitmap_zero(prec->this_pass.bad_read_insns, env->prog->len);
@@ -1560,6 +1561,9 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env)
 	if (prec->apart_xregno)
 		memset(prec->apart_xregno, 0, env->prog->len * sizeof(u16));
 	if (prec->data_deps && !env->replay && (prec->budget_grew || env->for_log)) {
+		/* the last error came before the last partition */
+		for (i = 0; env->for_log && i < 5 * prec->words; i++)
+			prec->kept[i] &= prec->undo[i];
 		keep_precision(prec, false);
 		prec->partitioned_by = prec->pass_cost = 0;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f34c0101384..92b0f4bbf89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2443,6 +2443,8 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 
 	return 0;
 out:
+	if (env->test_reg_invariants)
+		bpf_note_bug(env);
 	verbose(env, "REG INVARIANTS VIOLATION (%s): %s r64={.base=%#llx, .size=%#llx} "
 		"r32={.base=%#x, .size=%#x} var_off=(%#llx, %#llx) step=%u+%u\n",
 		ctx, msg,
@@ -21813,8 +21815,8 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	}
 }
 
-/* All is done again, whatever came out, see do_check_all() */
-static bool round_is_dropped(struct bpf_verifier_env *env)
+/* What the pass assumed about loops does not hold, see do_check_all() */
+static bool pass_needs_restart(struct bpf_verifier_env *env)
 {
 	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late;
 }
@@ -23397,6 +23399,23 @@ static int check_funcs(struct bpf_verifier_env *env, struct bpf_snapshot *initia
 	return ret == -EINTR ? ret : env->err ?: ret;
 }
 
+static int check_pass(struct bpf_verifier_env *env, struct bpf_snapshot *initial)
+{
+	int ret;
+
+	if (env->pass && (env->log.level & BPF_LOG_LEVEL2))
+		verbose(env, "pass %u\n", env->pass);
+	bpf_precision_new_pass(env);
+	ret = check_funcs(env, initial);
+	if (ret || pass_needs_restart(env))
+		return ret;
+	ret = check_after_pass(env);
+	if (ret)
+		bpf_find_unproven_after_pass(env);
+	env->err = ret;
+	return ret;
+}
+
 /*
  * If the error of a pass is real, do_check_all() limits the next passes and logs a path to it.
  * To see if it is real, reproduce it with no joins. Check one path after another, depth first
@@ -23408,6 +23427,7 @@ static int check_funcs(struct bpf_verifier_env *env, struct bpf_snapshot *initia
  * ranges too, and a check can fail on it where the joined state is proven.
  * run_has_guess: the run made a guess, on any of its paths. Then the failing path can be false,
  * see fast_forward_trips() and check_loop_guard().
+ * @repeat: see log_failing_path()
  * Returns the error on the path, 0 if there is none.
  */
 static int run_path_sensitive(struct bpf_verifier_env *env, struct bpf_snapshot *initial,
@@ -23424,6 +23444,8 @@ static int run_path_sensitive(struct bpf_verifier_env *env, struct bpf_snapshot
 	/* for the repeat */
 	if (env->err)
 		env->failing_path_budget = budget;
+	if (env->err && env->run_has_guess)
+		verbose(env, "this path has a guess, its values can be wrong\n");
 	return ret == -EINTR ? ret : env->err;
 }
 
@@ -23466,40 +23488,202 @@ static int find_failing_path(struct bpf_verifier_env *env, struct bpf_snapshot *
 	}
 }
 
+/* Level 2 has the log of all passes. Else the log has one pass, or the failing path. */
+struct pass_log {
+	u32 level, len_max;
+	u64 pos;
+};
+
+static void restart_log(struct bpf_verifier_env *env, struct pass_log *log)
+{
+	env->log.level = log->level;
+	/* the log is dropped when a function is found to be safe */
+	log->pos = min(log->pos, env->log.end_pos);
+	if (log->level & BPF_LOG_LEVEL2)
+		return;
+	bpf_vlog_reset(&env->log, log->pos);
+	env->log.len_max = log->len_max;
+}
+
+/* Repeat the last run. The verdict does not depend on the log, so it has no cost. */
+static int log_failing_path(struct bpf_verifier_env *env, struct bpf_snapshot *initial,
+			    struct pass_log *log)
+{
+	u32 insns = env->insn_processed, states = env->total_states;
+	u64 cost = env->cost;
+	int i, ret;
+
+	restart_log(env, log);
+	ret = run_path_sensitive(env, initial, true);
+	env->log.level = 0;
+	env->cost = cost;
+	env->insn_processed = insns;
+	env->total_states = states;
+	/* @initial has the sums from before the run, see copy_snapshot() */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		env->subprog_info[i].insns_total = initial->subprogs[i].insns_total;
+		env->subprog_info[i].insns_self = initial->subprogs[i].insns_self;
+	}
+	return ret;
+}
+
 /*
- * What stops a loop is assumed before the main pass and checked in it, see flow_is_bound(). The
- * main prog and global functions may get to the same loop. It has may_goto for all of them or
- * for none, so all are done again when the assumption doesn't hold, whatever came out.
+ *          pass 0: join all numbers
+ *                    |
+ *    +---------> run a pass
+ *    |               |
+ *    |            error ? --- no ---> pessimized ? --- no ---> ACCEPT
+ *    |               | yes                 | yes
+ *    |               v                     v
+ *    |       good pass before ?      save the good pass,
+ *    |          | no      | yes      partition, cut the budget
+ *    |          |         v                |
+ *    |          |   ACCEPT, use that pass  +---> run a pass
+ *    |          v
+ *    |      partition
+ *    |          |
+ *    |  failing path ? --- yes ---> log it; if no guess, cut the budget
+ *    |          | no                       |
+ *    |          +<-------------------------+
+ *    |          v
+ *    +- yes - is more kept apart ? --- no ---> REJECT
+ *
+ * Each pass starts from the snapshot @initial. The good pass is in the snapshot @good_pass.
+ * The path-sensitive run needs the deps, so it comes after the partition.
+ * There is no more precision when the budget is used up, or when no state was imprecise.
  *
- * A round that is dropped counts as paths that never run. What it found out about the insns, the
- * subprogs and the prog stays. Each of these is made for more than one state that gets to an insn:
- * it grows to the safe side, or another value is refused, or the last one that gets there sets it.
- * Where the round got to is dropped with its verdict: the passes that follow take an insn that was
- * seen for one that passed its checks, and a function that is called has to be safe.
+ * A pass assumes what stops each loop, and checks it, see pass_needs_restart(). If the
+ * assumption is wrong, the pass starts again.
+ *
+ * The log has the failing path. If there is none, or if it has a guess and the error of a pass
+ * is real, the log has the basic block of an error. Below level 2 the later passes and the
+ * path-sensitive runs write no log. The one that gives the log runs once more.
  */
 static int do_check_all(struct bpf_verifier_env *env)
 {
-	struct bpf_func_info_aux *sub_aux;
-	u64 log_pos = env->log.end_pos;
-	int i, ret;
-
-	for (;;) {
-		bpf_flow_new_round(env);
-		ret = do_check_main(env);
-		ret = ret ?: do_check_subprogs(env);
-		if (!round_is_dropped(env))
-			return ret;
-		/* the log is dropped when a function is found to be safe */
-		bpf_vlog_reset(&env->log, min(log_pos, env->log.end_pos));
-		for (i = 0; i < env->prog->len; i++)
-			env->insn_aux_data[i].seen = 0;
-		for (i = 1; env->prog->aux->func_info && i < env->subprog_cnt; i++) {
-			sub_aux = subprog_aux(env, i);
-			memset(sub_aux->called, 0, sizeof(sub_aux->called));
-			memset(sub_aux->verified, 0, sizeof(sub_aux->verified));
-			sub_aux->called_with_pkt_ptrs = false;
-		}
+	bool offload = bpf_prog_is_offloaded(env->prog->aux), limit = false, last, replay;
+	struct pass_log log = { env->log.level, env->log.len_max, env->log.end_pos };
+	bool quiet = log.level && !(log.level & BPF_LOG_LEVEL2), logged = false, replayed = false;
+	struct bpf_snapshot *initial, *good_pass = NULL;
+	int ret, more, path_err = 0, err = 0;
+	bool guess = false, real;
+	u64 max_cost = 0;
+
+	initial = save_snapshot(env, NULL);
+	if (!initial || bpf_precision_init(env)) {
+		bpf_precision_free(env);
+		kvfree(initial);
+		return -ENOMEM;
 	}
+	env->max_mem = min(env->max_mem, env->mem + BPF_PASS_MEM_BASE +
+			   (u64)BPF_PASS_MEM_PER_INSN * env->prog->len);
+	for (;; env->pass += !env->for_log) {
+		if (!env->pass || !quiet)
+			restart_log(env, &log);
+		ret = check_pass(env, initial);
+		if (quiet)
+			env->log.level = 0;
+		replay = env->replay;
+		env->replay = false;
+		if (ret == -EINTR || env->bug || env->no_mem) {
+			err = ret;
+			break;
+		}
+		if (bpf_undo_precision(env))
+			continue;
+		if (ret && good_pass) {
+			restore_snapshot(env, good_pass);
+			err = 0;
+			if (!offload)
+				break;
+			bpf_restore_precision(env);
+		} else if (!ret) {
+			bpf_flow_drop_guards(env);
+			if (pass_needs_restart(env))
+				continue;
+			if (env->for_log && (!offload || replay))
+				break;
+			max_cost = good_pass ? max_cost : env->max_cost;
+			if (!replayed && !env->for_log && bpf_partition_for_pessimized(env) > 0) {
+				env->max_cost = min(env->max_cost, env->cost + BPF_MIN_BUDGET);
+				good_pass = save_snapshot(env, good_pass);
+				if (good_pass)
+					continue;
+			}
+			if (!offload || replay) {
+				err = 0;
+				break;
+			}
+		}
+		if (!ret || good_pass) {
+			/* The driver sees a pass without errors. It can refuse an insn. */
+			kvfree(good_pass);
+			good_pass = NULL;
+			env->max_cost = max_cost;
+			env->replay = replayed = true;
+			ret = bpf_prog_offload_verifier_prep(env->prog);
+			if (!ret)
+				continue;
+			err = ret;
+			break;
+		}
+		if (env->for_log)
+			break;
+		err = path_err ?: ret;
+		limit = !env->err;
+		if (limit)
+			goto reject;
+		/* a valid program that no precision can prove must not use up the limit */
+		env->max_cost = min(env->max_cost, max(2 * env->cost, BPF_PARTITION_BUDGET));
+		last = real = !env->imprecise;
+		more = bpf_partition_more(env);
+		if (more < 0 && more != -E2BIG)
+			err = more;
+		limit = more < 0;
+		last |= more != 1;
+		if (!limit && !path_err && (last || bpf_failing_path_is_due(env))) {
+			path_err = find_failing_path(env, initial, last);
+			if (path_err) {
+				err = path_err;
+				guess = env->run_has_guess;
+				logged = quiet && log_failing_path(env, initial, &log) == err;
+			}
+			if (path_err && !guess)
+				env->max_cost = min(env->max_cost, env->cost +
+						    2 * bpf_precision_first_budget(env));
+		}
+		if (real && guess && err == path_err && err != -EINTR) {
+			err = ret;
+			logged = false;
+		}
+		if (err == -EINTR || env->bug)
+			break;
+		if (!last)
+			continue;
+reject:
+		if (logged || !quiet || (limit && !env->pass))
+			break;
+		/* Run a pass with an error once more, for the log. It has a limit of its own. */
+		env->for_log = true;
+		quiet = false;
+		env->max_cost = 2 * env->cost;
+	}
+	env->log.level = log.level;
+	/* after an abort the error and the log can be wrong */
+	if (err && env->aborted)
+		err = -EINTR;
+	if (env->bug)
+		err = -EFAULT;
+	if (!err)
+		restart_log(env, &log);
+	if (err && (!path_err || guess) && (limit || (env->for_log && !env->err)))
+		verbose(env, "the limit on cost or memory ended pass %u\n", env->pass);
+	if (!err && env->sleepable_async_cb)
+		mark_sleepable_async_cb(env);
+	bpf_precision_free(env);
+	kvfree(initial);
+	kvfree(good_pass);
+	return err;
 }
 
 /*
@@ -25316,8 +25500,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
 		return -EINVAL;
-	/* the main pass is being rewritten */
-	return -EOPNOTSUPP;
 
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
@@ -25347,6 +25529,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	 * and supplied buffer to store the verification trace
 	 */
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
+	env->log_level = env->log.level;
 	if (ret)
 		goto err_free_env;
 	ret = bpf_diag_init(env);
-- 
2.55.0

