Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160891;
	b=4fdfjfasweE9diMIbrETKKjl0+mY+x/ePWM8nlxZ0C/gjB8TSJ27/yT4cdfNYEU6odrB
	 fzLSSwECIgIg0MttTYUx5YfdK0YkVNy0ag/h+YWiS5ooccFl+sD3TQW5LxXKyrSXXPfyw
	 xfoxjmJbLAEDWADvMdioPUKOkSTzjqsowJfiTVDVfkQQ6XlE9u2uqmsFKw62ixcuFcgWM
	 u+6gsQ9opbX8Dt4vCpBJVEvigetuux9DkRdKOGLnfTnyrjlJbO/jrzccH/EApz3VwVb+d
	 3iDXmoy9MFNBW+o/el5e5VjQEdknlde6jgSBl1Hj16x7yyqn+FDw72v++GY+PGpKV1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U7S3JiUdgkXsaLn5kJc9PNsnOJLELMs6/QXUZCkTnQM=;
	b=OBkM4iJOGcrBa+JhTNpiv0s5e32nwesEtyVMO2ZDNig8il+Zb6WSHSSSB7J/RIXjP462
	 Dixe23Nb4rbCeiQGHhxv7ackYE+5jTzVpG7uVt70NZu2TClxhL7Ujwj8ozQ7nKWGCrs/v
	 5JAW2BZK0MYEBfoBsKHK+RgKO7Y7nsrYKRqL1EK7MjQ57ycx3mQcv2yh1QhCOvgb+01n3
	 PmxPPZJ4bWFdT2uvRhlMgsGQ8MQ6L3MhQ/jNv4kGc6p+W4Dl8079crMKqokPJcdFGk1od
	 qnoHANOSTYd1JKwssrf3N/Y4uAERZfXofM1aQghuShXBLeEyHNcOuxfLw+8HHxZ7TzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVISqqr6;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DF606A33A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 761DF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CVISqqr6
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so477180a91.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160890; x=1795765690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U7S3JiUdgkXsaLn5kJc9PNsnOJLELMs6/QXUZCkTnQM=;
        b=CVISqqr6sUlAV7DLDZTVn7M2UgrzZahFDu/0H320Zz4nkhNQP9V4hF2naHYejMjoPn
         uCtPoPettoChyGsmR80KP0PrxrVNQDNnK3rGy9+r/4GsDyaWHb38vuF8JqKA92wdr7ko
         iiIHMsvBJOeJdPspz23Mt2yfOgqgc6mHV5T80p2c2F46HlyMzBHlEZSTuWDKjkEL1r0V
         5xfr393omeivGpLybLxAsBqRbPA1z1V3riyiY0WV+H3qNQnCwHOqiMSvgqJcEYdZORNr
         6mUGGalrUYR9XKkim5+lUEQJcYi5FKZH3Hleu+MTplF1HritLP1W789Z9apqQpNKBmrt
         KpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160890; x=1795765690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U7S3JiUdgkXsaLn5kJc9PNsnOJLELMs6/QXUZCkTnQM=;
        b=HaxMMcEzdGHR+axPQwvOHZmaehPnBiIniDnsakqGmvqz19DXu17U2caqLwIuNJ5r5y
         U0PHr/XI8KiKoNYby/u7F4CvddFuUlcJjsmyFtfwiUeErCQPfy81XbQzpV92gIZte46y
         bdk75MUWOqmDCebrsnKMx/y5ExEEX6TRaNUIUcN4onvia30CrgusinR0aMWpP4kXWk4q
         5z9hPqzgpAbCetCICDKiytIPKwAHpWqlOLQatN1nfZZOQrIfZXB4xjGDqoNCpzx+4CgR
         ZOi3jm/htqR0kEo5eYX2xgakugCaK5VqkwHl3iWMgSSYbJ4cHUR7k7RQnUegMgDhhJJY
         3hUg==
X-Gm-Message-State: APuU4Z/GjnrMfJkuKLleRl8eCZD1Wo3wnWCxvOfB7dx3r11i+F9RE//E
	XTs5ZuWRHJJdqmxeYR5HvBOrCBDYGDFoIFp6DR5sLG3nOgMj97AsLIYE679IAg==
X-Gm-Gg: AZFdTZcH+YnZjtr2XD2X36rOCEYRm3g5rVRvvLs0jINhpwZd+5yz/JCKnOMcNsccqki
	7yPBgZbKcHx+nzvNJ+IiqgI+SOKujMF47Hgx5HZHlw4YCmQ4IofWN+BrcyKB5g70K3By/QqjiX6
	8RjJRp6YuecMiYoDsOB3dr74ZdFXPgEKLcNAgebmxHXGJJJ++yaKzLcN9Y6yZ5vLor7Sx8nkjBW
	UVC+ssIuvSmJF8Q5LTvNxDP/Ty/lPj85A8z/JqVYaQRBMihwz/srN68GdYl2EInJ0unb7vWa6j1
	qlgZ9j9BFckGmoy3QYrOIy4kSZSfzH3+rO0y6cAQqv7hXCNLSH4G0Z2uY24J+pjMj2TcvxsbTdr
	9fkGtJqJ+dSoT0miyWYVg7WsTKz7Lra9e7P+3EENyfHiazWyKz5JjnGA8cD3g8mh92O4jjLX3pp
	D9K9xUGDIur38byMuem9GIgHfKqtINqx9EqbVQkwgvhqrm4+vTpqChNMvRu9HWeTQddXjbrK9D4
	29QfZvyAoKlVwv7tg1Uo1ByVeXsDuZLFNfaRxMsYz0QArAl58d5jCyFCui+0gYnGlgCVwPjrlGD
	bwBDo+jK+rlxJLHTm8/7URGA+Vt2ePBBkItZkgi/WRlo2Dlt81jBl+VV0aIVviuC6PIGJpAetjj
	kPkQ0M4I8xbupM9E6MhxXNrzKXF3jefTSX3I02mby/AtIUw+gq7gLJulLdugI7EZsK2hcDkY/Nr
	c=
X-Received: by 2002:a17:90b:2648:b0:3ab:189b:6980 with SMTP id 98e67ed59e1d1-3b41c952ebdmr1790138a91.39.1795160889784;
        Thu, 19 Nov 2026 23:48:09 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm6548592a91.2.2026.11.19.23.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 37/49] bpf: Verify in passes
Date: Fri, 20 Nov 2026 07:42:09 +0000
Message-ID: <20261120074430.2704488-38-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  13 ++
 kernel/bpf/diagnostics.c     |   4 +-
 kernel/bpf/failing_path.c    |   8 ++
 kernel/bpf/precision.c       |   4 +
 kernel/bpf/verifier.c        | 239 +++++++++++++++++++++++++++++++++++
 5 files changed, 267 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b60662593ef..40faa1b3f39 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -12,6 +12,7 @@
 #include <linux/math64.h> /* for div_s64_rem() */
 #include <linux/freezer.h>
 #include <linux/sched/signal.h>
+#include <linux/sizes.h>
 
 /* No memory fails the load. It does not wake up the OOM killer. */
 #define BPF_GFP_MAYFAIL (__GFP_RETRY_MAYFAIL | __GFP_NOWARN)
@@ -1435,6 +1436,7 @@ struct bpf_verifier_env {
 	bool no_rcu_read_lock;
 	bool signature;
 	u8 bug:1;			/* ends the load, see bpf_note_bug() */
+	u8 log_level:7;			/* of the user */
 	u32 insn_aux_data_len;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	struct bpf_patch_list patch_list;
@@ -1604,6 +1606,13 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
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
@@ -1614,6 +1623,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 #define verifier_bug(env, fmt, args...)								\
 	({											\
 		BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args);				\
+		bpf_note_bug(env);								\
 		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
 	})
 
@@ -1767,6 +1777,9 @@ void bpf_precision_free(struct bpf_verifier_env *env);
 #define BPF_COST_STATE	512	/* make, order and free a state */
 #define BPF_MAX_COST	(1ULL << 33)
 #define BPF_MAX_MEM	(1ULL << 31)
+/* What the passes can add to the tables. A loop keeps a state at each join point. */
+#define BPF_PASS_MEM_BASE	SZ_256M
+#define BPF_PASS_MEM_PER_INSN	SZ_32K	/* a state with a full stack */
 /* The floors of the cost after the first error, and of the budget of a partition */
 #define BPF_PARTITION_BUDGET	(BPF_MAX_COST / 3)
 #define BPF_MIN_BUDGET	(BPF_MAX_COST >> 12)
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
index 6f3be5d900c..76278529202 100644
--- a/kernel/bpf/failing_path.c
+++ b/kernel/bpf/failing_path.c
@@ -250,7 +250,15 @@ bool bpf_failing_path_is_due(struct bpf_verifier_env *env)
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
index c46f18f04f1..7fc1e93aef1 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1545,6 +1545,7 @@ void bpf_restore_precision(struct bpf_verifier_env *env)
 void bpf_precision_new_pass(struct bpf_verifier_env *env)
 {
 	struct bpf_precision *prec = env->precision;
+	u32 i;
 
 	bitmap_zero(prec->this_pass.unproven_insns, env->prog->len);
 	bitmap_zero(prec->this_pass.bad_read_insns, env->prog->len);
@@ -1555,6 +1556,9 @@ void bpf_precision_new_pass(struct bpf_verifier_env *env)
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
index cde5c14e730..33f7b17b2bf 100644
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
@@ -23352,6 +23354,41 @@ static int check_after_pass(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* Returns the first error */
+static int check_funcs(struct bpf_verifier_env *env, struct bpf_snapshot *initial)
+{
+	u32 level = env->log.level;
+	int ret;
+
+	restore_snapshot(env, initial);
+	kvfree(env->callx_edges);
+	kvfree(env->callx_index.slots);
+	env->callx_edges = NULL;
+	env->callx_index = (struct bpf_index){};
+	bpf_flow_new_pass(env);
+	ret = do_check_main(env) ?: do_check_subprogs(env) ?: bpf_check_limits(env);
+	env->log.level = level;
+	env->pass_max_cost = U64_MAX;
+	return ret == -EINTR ? ret : env->err ?: ret;
+}
+
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
@@ -23363,6 +23400,7 @@ static int check_after_pass(struct bpf_verifier_env *env)
  * ranges too, and a check can fail on it where the joined state is proven.
  * run_has_guess: the run made a guess, on any of its paths. Then the failing path can be false,
  * see fast_forward_trips() and check_loop_guard().
+ * @repeat: see log_failing_path()
  * Returns the error on the path, 0 if there is none.
  */
 static int run_path_sensitive(struct bpf_verifier_env *env, struct bpf_snapshot *initial,
@@ -23379,6 +23417,8 @@ static int run_path_sensitive(struct bpf_verifier_env *env, struct bpf_snapshot
 	/* for the repeat */
 	if (env->err)
 		env->failing_path_budget = budget;
+	if (env->err && env->run_has_guess)
+		verbose(env, "this path has a guess, its values can be wrong\n");
 	return ret == -EINTR ? ret : env->err;
 }
 
@@ -23421,6 +23461,204 @@ static int find_failing_path(struct bpf_verifier_env *env, struct bpf_snapshot *
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
+/*
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
+ *
+ * A pass assumes what stops each loop, and checks it, see pass_needs_restart(). If the
+ * assumption is wrong, the pass starts again.
+ *
+ * The log has the failing path. If there is none, or if it has a guess and the error of a pass
+ * is real, the log has the basic block of an error. Below level 2 the later passes and the
+ * path-sensitive runs write no log. The one that gives the log runs once more.
+ */
+static int do_check_all(struct bpf_verifier_env *env)
+{
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
+	}
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
+}
+
 /*
  * What it took to verify a static subprog on its own is not in insns_total of its callers.
  * Add it, once per caller. The main prog and global subprogs have all of it already.
@@ -25264,6 +25502,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	 * and supplied buffer to store the verification trace
 	 */
 	ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
+	env->log_level = env->log.level;
 	if (ret)
 		goto err_free_env;
 	ret = bpf_diag_init(env);
-- 
2.55.0

