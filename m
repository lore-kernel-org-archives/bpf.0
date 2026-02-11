Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B5280A5B
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833580; cv=none; b=ggh+2qgnAZiELZHF20cjtfq9TpS9z055PNON+FD+8Dw41g2DygbKuXbbcOnqZcafKSWd9B+y4nDJVZZD0UnB8/mHu6obIu17THaBBxDl2H8kELkfpAXBgeHFiKWRwos+as4dtPM8ICRfF7xATtAYfDHd9LEv7im1QnJG6tCaoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833580; c=relaxed/simple;
	bh=nMMNRiRqxx8j7Ls0PBQQblPl/rGv87FdvzTogB5S28I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUgqlKJNy1KdM2Dhfo7wrjUEVvbqecb5QtoLyzZwwlUAxukHPndTP5LKNZLZF4qRyvVKH2B2PpbLVM+lEisClgpNWD949iYqKMx0kAn8UfYPvaKkYUf8ta3IdTS/4KTWfNriJhKzSy1mjlGHSD0nL0q5tY+EqSPTLeMv89dXsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMBLuuCI; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMBLuuCI"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d1851d85daso2128776a34.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833577; x=1771438377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp/VF9gXasq4F82ZvBcfmVzlHS06UYDywTgtQgFKO7o=;
        b=YMBLuuCICKL6EEtwUAhTMAGhRv3JQyheYIyGLv4yUYDnvyhOBMHYl9LiwscGFJrsCT
         FETgMaMc9pwkHYLO8msK6rOz7pf2A8J1xnj7sF3spXmYQN8YL9Fa1mDfhFqiCmeCsaz3
         gf+c0m0goZ2/dGE0QTIg5uddTwtj3btAT8Yltr/R3VOQxpGB6wyGsiJQY1EJ5nEDjGK/
         KAOjXrhBNKPln89CJuqcUOVkESDIZN0OIr2SHaDnjB762wy5QwRuNhw60rUzKvkQUPzR
         GFVcKBCVpvGn0kgif0KkKuB+FC84RmCoMcB4uakQb/gVrIK/9bFGdgwSPMhMy+1v5YHl
         J30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833577; x=1771438377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lp/VF9gXasq4F82ZvBcfmVzlHS06UYDywTgtQgFKO7o=;
        b=Pgb94+cx22eI997MdHAJQMUB5f65uIBlOFKLDTBnyH0oItFfHmZ+Hg4dYEPPJCcSe9
         Ax4lX3ApQ3KX/pzWn1hFF8K+q25Uy2YHejblcn4ofzFSNsllMZI3fCbRP5YeAGMhtKHf
         +tvscpATt4S340Uh4L0bES00jsPGEE1gT5aTn3JM6UlWgwVicbBuEVHt3DMm82XvhVO6
         /2oqCCHgz84ylWxj5j7cage2dwuwu6dXWwTZ17kjl87FWU3VZxNSLc1USi4Wad2V8jO2
         C7Wq/KQryZBzA2hCZ0fcF7zxXSoe8u1QOs4Cto6QTcA1X9GG5Z958bzwP+5aeK3FTNlh
         QGGA==
X-Gm-Message-State: AOJu0Yxdk6p+igTo76xBvI09yQsG5/cwv61QcCTK2nFMAzMhM5PGudGh
	ynpT8+VNLCLcdbET+UGsINYUe1Sa0CB5gQ7HWtJWJ5FnD+1gDNT6AaUx6DcJE+d/GBAvfw==
X-Gm-Gg: AZuq6aICXQYJy/9Wp+YxtIl+CsM6K1/gx8tysef9bmSYP0E8ql5Fkqt+Ly8GFBqzUPW
	CwNB83lx5eSmI8+SOifYFJPQb+J4N3ZHSP4Ol0rEvcPnvsg+XK2dBtVnDyVqPEDqlY1pnDnazRu
	Jlq8jd4qlIWaMCQelfDTHXuxNox3Md+kHShljQFuLThy4yYBtmjJgZMvZ6zAKCMWAJY1BXE1YBt
	wNdsZkWbPXZMa9yQBQPPW9KvnaWCnuDkSZAYsXjdV3ZaZGrJ8b+sSdhCJV5Mzec8EIRty0QkysD
	aroc6aQNeuR/gubeyIpZiFkF5PqEYW/vub4Pr7mS2Ura87rSmtFNa6WzODJO0iFShG3WHJ+jOAj
	6WwfKPBlzWQIIJUvBwBgFgB7yI3uXq5GaIDLD9teZ+vIBwFwUkaJjTMuif4o3uQv7yOwTeXy149
	sicyusLRg7MMIfRCeKbhrCaeeXb7ygl+wVJgfIAFfOjLph
X-Received: by 2002:a05:6830:6610:b0:7cf:d189:2a8b with SMTP id 46e09a7af769-7d4a56a747cmr1778877a34.2.1770833576997;
        Wed, 11 Feb 2026 10:12:56 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530d08sm1753216a34.2.2026.02.11.10.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:56 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 5/6] selftests/bpf: Generate various conctest permutations
Date: Wed, 11 Feb 2026 10:12:45 -0800
Message-ID: <20260211181248.3040142-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211181248.3040142-1-memxor@gmail.com>
References: <20260211181248.3040142-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19817; h=from:subject; bh=nMMNRiRqxx8j7Ls0PBQQblPl/rGv87FdvzTogB5S28I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUf/jsFV/drAe0pTu2bDeo7UbPx1fVQ9kqbndxb XDR6ecOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHwAKCRBM4MiGSL8RymAcD/ 98HfSCKSdciVtJUOzorBVMv8+86bTfefiwf41Q4SOQyZDFscXav3QvachUr7nbvj1cay1RvV5DDQLf BrPX+sP1vnL/npjan6VkM0WEiUo1718r/gcQzyDzTVjGr1E94Leb8JQDknkDyPt4JQAy4RKu6mp/Cq PB/bprP2febxySVn70ZRxg7ef2ahaCqG3S9/6SnNe+XX0oTNEHbND4v0tdpkwC7vdWYIXs4ACXzuZr Et0ggy6h3sBEvyOyBAQYSmuyjJRKXDljU2siXLv1L4OlMNAmOR3I7J1c1IxjoKEGDvchP9f0y2F5Jx mpj83E1bAKxOmE2Nwkjn9swNV8E6MUkXn9exO7vvRgJGblu2lg3Wns4sl3DLD5ak0Zy7nZHX9LnLlg MHCcLwl7GlfwwJt5+EXi6c1EyxemNMibI42fM+UVCF2DzltXNCahxYyldxkR8PyCzgBQ2yPc3jeCwN ZS/mcilzrhmz+hwWWIXXN/hpweRfYdrk4al50+iICTuON6f308nEo5HeDDT0EWdgGN9rAiqQRRfAIV vpVcCd0qd9Qw7FQki50tQiVj29zuGLCJVV/skrDXNS2I0Iouia3k1r93W3G1CkPTENJjrZZ4dxx6S4 11SPCTl79fq2hywGhHgQl04t+xVjibfZa1XajWr2QGmoZy+0FsGlJIcGRU/Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce support for testing various permutations given a list of a
operations for an async primitive. This unburdens the user from setting
up various cases and thinking through all possible interleavings. The
allowed context for each operation and the number of operations are
specified and the various permutations in both directions (vertical,
i.e. on the same CPU, and horizontal, i.e. across CPUs in a flat context)
are generated automatically. Further, symmetric operations that won't
improve coverage (e.g. flat AvsB and BvsA cases) are pruned to reduce
test time.

Add support for timer operations testing in this commit to show its
usefulness. Unlike rqspinlock, the number of operations extend to 6
(start, cancel, cancel_async, init, delete, set_callback) which must
be tested in various combinations to approach completeness. To bound
the number of generated cases bound the maximum parallelism to 4 for
timer and 3 for rqspinlock.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/conctest.c       | 319 ++++++++++++++-----
 tools/testing/selftests/bpf/progs/conctest.c | 230 ++++++++++++-
 2 files changed, 476 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/bpf/conctest.c b/tools/testing/selftests/bpf/conctest.c
index e4b333aff419..be6d3864d455 100644
--- a/tools/testing/selftests/bpf/conctest.c
+++ b/tools/testing/selftests/bpf/conctest.c
@@ -300,92 +300,237 @@ struct conctest_cfg {
 	for (struct conctest_cfg *cfg = (arr); cfg->type != CT_INVALID; cfg++)
 
 struct conctest_test {
-	const char *name;
-	struct conctest_cfg *cfgs;
-	void (*init)(struct conctest *skel);
+	char name[128];
+	struct conctest_cfg cfgs[4];
+	void (*init)(struct conctest *skel, struct conctest_test *test);
+	const char **extra_progs;
 	int nr_cpus;
+	bool vertical;
 };
 
-struct conctest_cfg rqspinlock[] = {
-	{
-		.type = CT_TASK_PROG,
-		.task = { "conctest_rqspinlock_task" },
-	},
-	{
-		.type = CT_NMI_PROG,
-		.nmi = { "conctest_rqspinlock_nmi" },
-	},
-	{}
+static int find_prog_fd(struct conctest *skel, const char *prog_name);
+
+#define CTX_TASK_OK	(1 << 0)
+#define CTX_NMI_OK	(1 << 1)
+
+struct conctest_op {
+	const char *name;
+	const char *task_prog;
+	const char *nmi_prog;
+	unsigned int ctx_mask;
 };
 
-struct conctest_cfg rqspinlock_shift[] = {
-	{
-		.type = CT_TASK_PROG,
-		.task = { "conctest_rqspinlock_task" },
-	},
-	{
-		.type = CT_NMI_PROG,
-		.nmi = { "conctest_rqspinlock_nmi_shift" },
-	},
-	{}
+struct conctest_suite {
+	const char *name;
+	struct conctest_op *ops;
+	int nr_ops;
+	void (*init)(struct conctest *skel, struct conctest_test *test);
+	const char **extra_progs;
+	int max_cpus;
 };
 
-static void __rqspinlock_init(struct conctest *skel, int err, int delay)
+static struct conctest_op rqspinlock_ops[] = {
+	{ "lock",       "conctest_rqspinlock_task", "conctest_rqspinlock_nmi",       CTX_TASK_OK | CTX_NMI_OK },
+	{ "lock_shift", "conctest_rqspinlock_task", "conctest_rqspinlock_nmi_shift", CTX_TASK_OK | CTX_NMI_OK },
+	{},
+};
+
+static void rqspinlock_init(struct conctest *skel, struct conctest_test *test)
 {
 	struct conctest_op_state state;
-	int key;
+	bool same_lock, is_vert;
+	int key, nmi_err;
+
+	is_vert = test->vertical;
+
+	/*
+	 * Horizontal: don't set expectations.
+	 * Vertical, same lock: always -EDEADLK.
+	 * Vertical, different locks: -EDEADLK for <3 CPUs, -ETIMEDOUT for >=3.
+	 */
+	if (!is_vert) {
+		key = CONCTEST_STAT_SYSCALL;
+		memset(&state, 0, sizeof(state));
+		state.delay_thresh_ns = 10000000;
+		bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key),
+				     &state, sizeof(state), 0);
+		return;
+	}
+
+	same_lock = (test->cfgs[0].task.prog_name == test->cfgs[1].nmi.prog_name) ||
+		    (strcmp(test->cfgs[0].task.prog_name, "conctest_rqspinlock_task") == 0 &&
+		     strcmp(test->cfgs[1].nmi.prog_name, "conctest_rqspinlock_nmi") == 0);
+
+	if (same_lock || test->nr_cpus < 3)
+		nmi_err = -EDEADLK;
+	else
+		nmi_err = -ETIMEDOUT;
 
 	key = CONCTEST_STAT_SYSCALL;
 	memset(&state, 0, sizeof(state));
 	state.expect_ret = 0;
-	state.delay_thresh_ns = 1000000 * delay;
-	bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key), &state,
-			     sizeof(state), 0);
+	state.delay_thresh_ns = (test->nr_cpus >= 3) ? 300000000ULL : 10000000ULL;
+	bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key),
+			     &state, sizeof(state), 0);
 
 	key = CONCTEST_STAT_NMI;
 	memset(&state, 0, sizeof(state));
-	state.expect_ret = err;
-	state.delay_thresh_ns = 1000000 * delay;
-	bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key), &state,
-			     sizeof(state), 0);
+	state.expect_ret = nmi_err;
+	state.delay_thresh_ns = (test->nr_cpus >= 3) ? 300000000ULL : 10000000ULL;
+	bpf_map__update_elem(skel->maps.state_map, &key, sizeof(key),
+			     &state, sizeof(state), 0);
 }
 
-static void rqspinlock_init(struct conctest *skel)
+static struct conctest_suite rqspinlock_suite = {
+	.name = "rqspinlock",
+	.ops = rqspinlock_ops,
+	.nr_ops = 2,
+	.init = rqspinlock_init,
+	.max_cpus = 3,
+};
+
+static void timer_init(struct conctest *skel, struct conctest_test *test)
 {
-	return __rqspinlock_init(skel, -EDEADLK, 2);
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int fd;
+
+	fd = find_prog_fd(skel, "conctest_timer_init");
+	if (fd < 0)
+		return;
+	bpf_prog_test_run_opts(fd, &opts);
 }
 
-static void rqspinlock_init_delay(struct conctest *skel)
+static struct conctest_op timer_ops[] = {
+	{ "init",         "conctest_timer_task_reinit",     "conctest_timer_nmi_reinit",     CTX_TASK_OK | CTX_NMI_OK },
+	{ "start",        "conctest_timer_task_start",      "conctest_timer_nmi_start",      CTX_TASK_OK | CTX_NMI_OK },
+	{ "cancel",       "conctest_timer_task_cancel",      NULL,                            CTX_TASK_OK },
+	{ "cancel_async", "conctest_timer_task_cancel_async","conctest_timer_nmi_cancel_async",CTX_TASK_OK | CTX_NMI_OK },
+	{ "set_cb",       "conctest_timer_task_set_cb",      "conctest_timer_nmi_set_cb",     CTX_TASK_OK | CTX_NMI_OK },
+	{ "delete",       "conctest_timer_task_delete",      "conctest_timer_nmi_delete",     CTX_TASK_OK | CTX_NMI_OK },
+	{},
+};
+
+static const char *timer_extra_progs[] = { "conctest_timer_init", NULL };
+
+static struct conctest_suite timer_suite = {
+	.name = "timer",
+	.ops = timer_ops,
+	.nr_ops = 6,
+	.init = timer_init,
+	.extra_progs = timer_extra_progs,
+	.max_cpus = 4,
+};
+
+static struct conctest_suite *suites[] = {
+	&rqspinlock_suite,
+	&timer_suite,
+	NULL,
+};
+
+#define MAX_GENERATED_TESTS 1024
+
+static struct conctest_test generated_tests[MAX_GENERATED_TESTS];
+static int nr_generated;
+
+static void add_test(const char *suite_name, const char *a_name, const char *b_name,
+		     const char *task_prog, const char *nmi_prog,
+		     const char *task_prog_b,
+		     void (*init)(struct conctest *skel, struct conctest_test *test),
+		     const char **extra_progs, int nr_cpus)
 {
-	return __rqspinlock_init(skel, -EDEADLK, 10);
+	struct conctest_test *t;
+
+	if (nr_generated >= MAX_GENERATED_TESTS)
+		return;
+
+	t = &generated_tests[nr_generated++];
+	if (nmi_prog)
+		snprintf(t->name, sizeof(t->name), "%s:%d:vert:%s_vs_%s",
+			 suite_name, nr_cpus, a_name, b_name);
+	else
+		snprintf(t->name, sizeof(t->name), "%s:%d:flat:%s_vs_%s",
+			 suite_name, nr_cpus, a_name, b_name);
+
+	t->init = init;
+	t->extra_progs = extra_progs;
+	t->nr_cpus = nr_cpus;
+	t->vertical = (nmi_prog != NULL);
+
+	t->cfgs[0].type = CT_TASK_PROG;
+	t->cfgs[0].task.prog_name = task_prog;
+
+	if (nmi_prog) {
+		t->cfgs[1].type = CT_NMI_PROG;
+		t->cfgs[1].nmi.prog_name = nmi_prog;
+		t->cfgs[2].type = CT_INVALID;
+	} else if (task_prog_b) {
+		t->cfgs[1].type = CT_TASK_PROG;
+		t->cfgs[1].task.prog_name = task_prog_b;
+		t->cfgs[2].type = CT_INVALID;
+	} else {
+		t->cfgs[1].type = CT_INVALID;
+	}
 }
 
-static void rqspinlock_init_timeout(struct conctest *skel)
+static void generate_suite_tests(struct conctest_suite *suite, int max_cpus)
 {
-	return __rqspinlock_init(skel, -ETIMEDOUT, 300);
+	int i, j, cpus;
+
+	if (suite->max_cpus > max_cpus)
+		suite->max_cpus = max_cpus;
+
+	for (cpus = 1; cpus <= suite->max_cpus; cpus++) {
+		for (i = 0; i < suite->nr_ops; i++) {
+			struct conctest_op *a = &suite->ops[i];
+
+			if (!(a->ctx_mask & CTX_TASK_OK))
+				continue;
+
+			for (j = 0; j < suite->nr_ops; j++) {
+				struct conctest_op *b = &suite->ops[j];
+
+				if (!(b->ctx_mask & CTX_NMI_OK) || !b->nmi_prog)
+					continue;
+
+				add_test(suite->name, a->name, b->name,
+					 a->task_prog, b->nmi_prog, NULL,
+					 suite->init, suite->extra_progs, cpus);
+			}
+		}
+
+		/* Horizontal: task(a) vs task(b), needs at least 2 CPUs */
+		if (cpus < 2)
+			continue;
+
+		for (i = 0; i < suite->nr_ops; i++) {
+			struct conctest_op *a = &suite->ops[i];
+
+			if (!(a->ctx_mask & CTX_TASK_OK))
+				continue;
+
+			/* j = i to skip symmetric pairs (A vs B == B vs A) */
+			for (j = i; j < suite->nr_ops; j++) {
+				struct conctest_op *b = &suite->ops[j];
+
+				if (!(b->ctx_mask & CTX_TASK_OK) || !b->task_prog)
+					continue;
+
+				add_test(suite->name, a->name, b->name,
+					 a->task_prog, NULL, b->task_prog,
+					 suite->init, suite->extra_progs, cpus);
+			}
+		}
+	}
 }
 
-static struct conctest_test all_tests[] = {
-	{
-		.name = "rqspinlock:AA",
-		.cfgs = rqspinlock,
-		.init = rqspinlock_init,
-		.nr_cpus = 1
-	},
-	{
-		.name = "rqspinlock:ABBA",
-		.cfgs = rqspinlock_shift,
-		.init = rqspinlock_init_delay,
-		.nr_cpus = 2
-	},
-	{
-		.name = "rqspinlock:ABBCBA",
-		.cfgs = rqspinlock_shift,
-		.init = rqspinlock_init_timeout,
-		.nr_cpus = 3
-	},
-	{},
-};
+static void generate_all_tests(int max_cpus)
+{
+	int i;
+
+	nr_generated = 0;
+	for (i = 0; suites[i]; i++)
+		generate_suite_tests(suites[i], max_cpus);
+}
 
 struct task_ctx {
 	int prog_fd;
@@ -466,11 +611,6 @@ static struct conctest_ctx *alloc_ctx(int nr_cpus, struct conctest_cfg *cfgs)
 		}
 	}
 
-	if (nr_task > 1) {
-		fprintf(stderr, "Only one CT_TASK_PROG entry allowed\n");
-		return NULL;
-	}
-
 	if (nr_nmi > 1) {
 		fprintf(stderr, "Only one CT_NMI_PROG entry allowed\n");
 		return NULL;
@@ -603,7 +743,9 @@ static int run_test(struct conctest_test *test, int nr_cpus, int duration)
 	if (!ctx)
 		return -ENOMEM;
 
-	printf("Running test '%s' on %d CPU(s) for %d seconds\n", test->name, nr_cpus, duration);
+	if (verbose)
+		printf("Running test '%s' on %d CPU(s) for %d seconds\n", test->name, nr_cpus,
+		       duration);
 
 	skel = conctest__open();
 	if (!skel) {
@@ -639,6 +781,20 @@ static int run_test(struct conctest_test *test, int nr_cpus, int duration)
 		}
 	}
 
+	if (test->extra_progs) {
+		struct bpf_program *ep_prog;
+		const char **ep;
+
+		for (ep = test->extra_progs; *ep; ep++) {
+			ep_prog = bpf_object__find_program_by_name(skel->obj, *ep);
+			if (!ep_prog) {
+				fprintf(stderr, "Extra program '%s' not found\n", *ep);
+				goto out;
+			}
+			bpf_program__set_autoload(ep_prog, true);
+		}
+	}
+
 	err = conctest__load(skel);
 	if (err) {
 		fprintf(stderr, "Failed to load BPF skeleton: %d\n", err);
@@ -648,17 +804,30 @@ static int run_test(struct conctest_test *test, int nr_cpus, int duration)
 	stop = 0;
 
 	if (test->init)
-		test->init(skel);
+		test->init(skel, test);
 	/* Pass the test nr_cpus to rotate between objects, but use passed in nr_cpus otherwise. */
 	skel->bss->nr_cpus = test->nr_cpus;
 	skel->bss->delay_seed = delay_us;
 
 	for_each_conctest_cfg(cfg, test->cfgs) {
-		int cpu;
+		int cpu, nr_task_cfgs = 0, task_idx = 0;
+		int cpu_start, cpu_end;
+
+		for_each_conctest_cfg(c, test->cfgs)
+			if (c->type == CT_TASK_PROG)
+				nr_task_cfgs++;
 
 		switch (cfg->type) {
 		case CT_TASK_PROG:
-			for (cpu = 0; cpu < nr_cpus; cpu++) {
+			for_each_conctest_cfg(c, test->cfgs) {
+				if (c == cfg)
+					break;
+				if (c->type == CT_TASK_PROG)
+					task_idx++;
+			}
+			cpu_start = task_idx * nr_cpus / nr_task_cfgs;
+			cpu_end = (task_idx + 1) * nr_cpus / nr_task_cfgs;
+			for (cpu = cpu_start; cpu < cpu_end; cpu++) {
 				struct task_ctx *tc;
 				int prog_fd;
 
@@ -747,7 +916,8 @@ static int run_test(struct conctest_test *test, int nr_cpus, int duration)
 	}
 
 	sleep(duration);
-	printf("Test '%s' completed\n", test->name);
+	if (verbose)
+		printf("Test '%s' completed\n", test->name);
 	err = 0;
 out:
 	stop = 1;
@@ -814,7 +984,7 @@ int main(int argc, char **argv)
 	int max_cpus = libbpf_num_possible_cpus();
 	int duration = DEFAULT_DURATION;
 	int nr_cpus = DEFAULT_NR_CPUS;
-	int opt, ran = 0, failed = 0;
+	int opt, ran = 0, failed = 0, i;
 	struct conctest_test *test;
 
 	if (max_cpus < 0) {
@@ -870,14 +1040,19 @@ int main(int argc, char **argv)
 	delay_us = delay_seed % (delay_max_us + 1);
 	printf("Seed: %u, delay: %u us (max: %u us)\n", delay_seed, delay_us, delay_max_us);
 
-	for (test = all_tests; test->name; test++) {
+	generate_all_tests(max_cpus);
+	printf("Generated %d tests\n\n", nr_generated);
+
+	for (i = 0; i < nr_generated; i++) {
+		test = &generated_tests[i];
 		if (!test_selected(test->name))
 			continue;
 
 		ran++;
 		if (run_test(test, nr_cpus, duration))
 			failed++;
-		fprintf(stderr, "\n\n\n");
+		if (verbose)
+			printf("\n");
 	}
 
 	if (!ran)
diff --git a/tools/testing/selftests/bpf/progs/conctest.c b/tools/testing/selftests/bpf/progs/conctest.c
index aca36320caf9..703fd65c6ce3 100644
--- a/tools/testing/selftests/bpf/progs/conctest.c
+++ b/tools/testing/selftests/bpf/progs/conctest.c
@@ -6,6 +6,7 @@
 #include <bpf_experimental.h>
 
 #define EDEADLK		35
+#define EBUSY		16
 #define ETIMEDOUT	110
 #define CONCTEST_HIST_BUCKETS 28
 
@@ -184,7 +185,7 @@ static __always_inline void conctest_record(int stat_id, __s64 ret, bool ctx_adj
 
 	if (ret == 0) {
 		stats->success++;
-	} else if (ret == state->expect_ret) {
+	} else if (!state->expect_ret || ret == state->expect_ret) {
 		stats->failure++;
 	} else {
 		stats->failure++;
@@ -286,4 +287,231 @@ int conctest_rqspinlock_nmi_shift(void *ctx)
 	return __conctest_rqspinlock_nmi(1);
 }
 
+#define CLOCK_MONOTONIC	    1
+#define BPF_F_TIMER_CPU_PIN (1ULL << 1)
+
+struct timer_elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_elem);
+} timer_map SEC(".maps");
+
+static int timer_callback(void *map, int *key, struct timer_elem *val)
+{
+	bpf_timer_start(&val->timer, 0, BPF_F_TIMER_CPU_PIN);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_timer_init(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return -1;
+
+	ret = bpf_timer_init(&elem->timer, &timer_map, CLOCK_MONOTONIC);
+	if (ret && ret != -EBUSY)
+		return ret;
+
+	ret = bpf_timer_set_callback(&elem->timer, timer_callback);
+	if (ret)
+		return ret;
+
+	return bpf_timer_start(&elem->timer, 0, BPF_F_TIMER_CPU_PIN);
+}
+
+SEC("?syscall")
+int conctest_timer_task_reinit(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_init(&elem->timer, &timer_map, CLOCK_MONOTONIC);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_timer_nmi_reinit(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_init(&elem->timer, &timer_map, CLOCK_MONOTONIC);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_timer_task_start(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_start(&elem->timer, 0, BPF_F_TIMER_CPU_PIN);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_timer_task_cancel(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_cancel(&elem->timer);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_timer_task_cancel_async(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_cancel_async(&elem->timer);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_timer_task_set_cb(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_set_callback(&elem->timer, timer_callback);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_timer_task_delete(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	/* Delete the element (cancels + frees timer) */
+	conctest_begin();
+	ret = bpf_map_delete_elem(&timer_map, &key);
+	if (ret == 0) {
+		/* Re-init so subsequent ops still work */
+		elem = bpf_map_lookup_elem(&timer_map, &key);
+		if (elem) {
+			bpf_timer_init(&elem->timer, &timer_map, CLOCK_MONOTONIC);
+			bpf_timer_set_callback(&elem->timer, timer_callback);
+			bpf_timer_start(&elem->timer, 0, BPF_F_TIMER_CPU_PIN);
+		}
+	}
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_timer_nmi_start(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_start(&elem->timer, 0, BPF_F_TIMER_CPU_PIN);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_timer_nmi_cancel_async(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_cancel_async(&elem->timer);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_timer_nmi_set_cb(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&timer_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_timer_set_callback(&elem->timer, timer_callback);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_timer_nmi_delete(void *ctx)
+{
+	struct timer_elem *elem;
+	int key = 0, ret;
+
+	conctest_begin();
+	ret = bpf_map_delete_elem(&timer_map, &key);
+	if (ret == 0) {
+		elem = bpf_map_lookup_elem(&timer_map, &key);
+		if (elem) {
+			bpf_timer_init(&elem->timer, &timer_map, CLOCK_MONOTONIC);
+			bpf_timer_set_callback(&elem->timer, timer_callback);
+			bpf_timer_start(&elem->timer, 0, BPF_F_TIMER_CPU_PIN);
+		}
+	}
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

