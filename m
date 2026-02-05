Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB311ACEDE
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251115; cv=none; b=gn8aRwlW+UYHHGQ2/aX4fwfqLSSbIvhP+PmmMJbKYlg+1SxqXNnNzaH7WCr4bEJ6+gewEkADGhImp7e53/n/XlobErMBBOnv1Va6mvXdgGk87kqVTQi9viSmXVI7mbehvcXECPlztoWGmqzOrXqzyhNEb3Q3KSeKRd3Zo25VMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251115; c=relaxed/simple;
	bh=BDdpJYuJdd0epWEAaoyiivp8WAXiJ4h2CaUNgDindKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSohecxvOacqyJhawlT845Z14fORtXTrq4JQ6erUfbcxXt/tKbf1wniFWrt2moQsIdmQe2QM5lhxEYTsRr/vqZBI/5GXfvp83osg8kqiNZcF6XqeI77flac5lxKtul6mN4/1cFwbSuWAE5Vcf72J8KS7iPe3+Vn83vmdHPw7tRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsuE+VCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsuE+VCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918B8C4CEF7;
	Thu,  5 Feb 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770251114;
	bh=BDdpJYuJdd0epWEAaoyiivp8WAXiJ4h2CaUNgDindKU=;
	h=From:To:Cc:Subject:Date:From;
	b=NsuE+VCTM7/Dw35G7hYHxxHI01JgTLSxx7WUi3lnrCdzIV3Okyqv9Csb0DbAf8EmG
	 Z5/vgTqJwgAOPAW3MQ10RXktQITLV7lWSQ+hfKe5J2ZYsQuJxpvTZ7UZxibttzaLww
	 W+BqtAvHgwr8bJwNS4jqah9KRMHSZ8l7OWlUYCT3Bwr0vCQy0x25LLUkvGJiGsoIVQ
	 AowK68pFx7JGrQdbqiB6op5lZIJn6NBTcaEVRX9ZDX8FdSOi1PYEAvNbgx/UEyLZKs
	 JHPATm8UgZ1JoUGxuBCuAKFZCB+kUb4NEoOcraHyaHBvOgPDKQOWKRIJFP/erklQBA
	 nq7EyFWs/Bdeg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Remove unnecessary volatile and barrier_var()
Date: Wed,  4 Feb 2026 16:24:22 -0800
Message-ID: <20260205002508.808963-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the verifier learns new patterns, some of the volatile qualifiers for
local variables and some barrier_var() calls can be removed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_gotox.c          |  4 ++--
 tools/testing/selftests/bpf/progs/exhandler_kern.c     |  6 ------
 .../testing/selftests/bpf/progs/freplace_global_func.c |  2 +-
 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c  | 10 +++++-----
 tools/testing/selftests/bpf/progs/test_global_func1.c  |  6 +++---
 tools/testing/selftests/bpf/progs/test_global_func17.c |  1 -
 tools/testing/selftests/bpf/progs/test_global_func2.c  |  4 ++--
 tools/testing/selftests/bpf/progs/test_pkt_access.c    |  4 ++--
 tools/testing/selftests/bpf/progs/test_spin_lock.c     |  8 ++++----
 .../testing/selftests/bpf/progs/test_spin_lock_fail.c  |  4 ++--
 tools/testing/selftests/bpf/progs/test_sysctl_loop1.c  |  5 +----
 tools/testing/selftests/bpf/progs/test_sysctl_prog.c   |  2 +-
 12 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
index 216c71b94c64..9cb40d3d9379 100644
--- a/tools/testing/selftests/bpf/progs/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -252,7 +252,7 @@ int one_jump_two_maps(struct simple_ctx *ctx __attribute__((unused)))
 	void *jt2[2] = { &&l3, &&l4 };
 	unsigned int a = ctx->x % 2;
 	unsigned int b = (ctx->x / 2) % 2;
-	volatile int ret = 0;
+	int ret = 0;
 
 	if (!(a < 2 && b < 2))
 		return 19;
@@ -278,7 +278,7 @@ int one_map_two_jumps(struct simple_ctx *ctx __attribute__((unused)))
 	void *jt[3] = { &&l1, &&l2, &&l3 };
 	unsigned int a = (ctx->x >> 2) & 1;
 	unsigned int b = (ctx->x >> 3) & 1;
-	volatile int ret = 0;
+	int ret = 0;
 
 	if (ctx->x % 2)
 		goto *jt[a];
diff --git a/tools/testing/selftests/bpf/progs/exhandler_kern.c b/tools/testing/selftests/bpf/progs/exhandler_kern.c
index 20d009e2d266..8c509971b39c 100644
--- a/tools/testing/selftests/bpf/progs/exhandler_kern.c
+++ b/tools/testing/selftests/bpf/progs/exhandler_kern.c
@@ -37,14 +37,8 @@ int BPF_PROG(trace_task_newtask, struct task_struct *task, u64 clone_flags)
 	 */
 	work = task->task_works;
 	func = work->func;
-	/* Currently verifier will fail for `btf_ptr |= btf_ptr` * instruction.
-	 * To workaround the issue, use barrier_var() and rewrite as below to
-	 * prevent compiler from generating verifier-unfriendly code.
-	 */
-	barrier_var(work);
 	if (work)
 		return 0;
-	barrier_var(func);
 	if (func)
 		return 0;
 	exception_triggered++;
diff --git a/tools/testing/selftests/bpf/progs/freplace_global_func.c b/tools/testing/selftests/bpf/progs/freplace_global_func.c
index 96cb61a6ce87..6770bbc3cbc1 100644
--- a/tools/testing/selftests/bpf/progs/freplace_global_func.c
+++ b/tools/testing/selftests/bpf/progs/freplace_global_func.c
@@ -5,7 +5,7 @@
 __noinline
 int test_ctx_global_func(struct __sk_buff *skb)
 {
-	volatile int retval = 1;
+	int retval = 1;
 	return retval;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
index 99c8d1d8a187..b50dc92b2126 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
@@ -14,7 +14,7 @@ struct {
 __noinline
 int subprog_tail2(struct __sk_buff *skb)
 {
-	volatile char arr[64] = {};
+	char arr[64] = {};
 
 	if (load_word(skb, 0) || load_half(skb, 0))
 		bpf_tail_call_static(skb, &jmp_table, 10);
@@ -29,7 +29,7 @@ int subprog_tail2(struct __sk_buff *skb)
 static __noinline
 int subprog_tail(struct __sk_buff *skb)
 {
-	volatile char arr[64] = {};
+	char arr[64] = {};
 
 	bpf_tail_call_static(skb, &jmp_table, 0);
 
@@ -41,7 +41,7 @@ int subprog_tail(struct __sk_buff *skb)
 SEC("tc")
 int classifier_0(struct __sk_buff *skb)
 {
-	volatile char arr[128] = {};
+	char arr[128] = {};
 
 	__sink(arr[sizeof(arr) - 1]);
 
@@ -51,7 +51,7 @@ int classifier_0(struct __sk_buff *skb)
 SEC("tc")
 int classifier_1(struct __sk_buff *skb)
 {
-	volatile char arr[128] = {};
+	char arr[128] = {};
 
 	__sink(arr[sizeof(arr) - 1]);
 
@@ -61,7 +61,7 @@ int classifier_1(struct __sk_buff *skb)
 SEC("tc")
 int entry(struct __sk_buff *skb)
 {
-	volatile char arr[128] = {};
+	char arr[128] = {};
 
 	__sink(arr[sizeof(arr) - 1]);
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index fc69ff18880d..1fdeb2246e12 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -18,7 +18,7 @@ int f0(int var, struct __sk_buff *skb)
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
@@ -30,7 +30,7 @@ int f3(int, struct __sk_buff *skb, int);
 __attribute__ ((noinline))
 int f2(int val, struct __sk_buff *skb)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
@@ -40,7 +40,7 @@ int f2(int val, struct __sk_buff *skb)
 __attribute__ ((noinline))
 int f3(int val, struct __sk_buff *skb, int var)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
index 5de44b09e8ec..a32e11c7d933 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -5,7 +5,6 @@
 
 __noinline int foo(int *p)
 {
-	barrier_var(p);
 	return p ? (*p = 42) : 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 2beab9c3b68a..20ceb8a390eb 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -16,7 +16,7 @@ int f0(int var, struct __sk_buff *skb)
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
@@ -34,7 +34,7 @@ int f2(int val, struct __sk_buff *skb)
 __attribute__ ((noinline))
 int f3(int val, struct __sk_buff *skb, int var)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..4ae55df19487 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -50,7 +50,7 @@ int test_pkt_access_subprog2(int val, volatile struct __sk_buff *skb)
 __attribute__ ((noinline))
 int get_skb_len(struct __sk_buff *skb)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
@@ -74,7 +74,7 @@ int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
 __attribute__ ((noinline))
 int get_skb_ifindex(int val, struct __sk_buff *skb, int var)
 {
-	volatile char buf[MAX_STACK] = {};
+	char buf[MAX_STACK] = {};
 
 	__sink(buf[MAX_STACK - 1]);
 
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index d8d77bdffd3d..59efa32a61aa 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -49,7 +49,7 @@ struct {
 SEC("cgroup_skb/ingress")
 int bpf_spin_lock_test(struct __sk_buff *skb)
 {
-	volatile int credit = 0, max_credit = 100, pkt_len = 64;
+	int credit = 0, max_credit = 100, pkt_len = 64;
 	struct hmap_elem zero = {}, *val;
 	unsigned long long curtime;
 	struct bpf_vqueue *q;
@@ -107,7 +107,7 @@ struct bpf_spin_lock lockA __hidden SEC(".data.A");
 __noinline
 static int static_subprog(struct __sk_buff *ctx)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	if (ctx->protocol)
 		return ret;
@@ -117,7 +117,7 @@ static int static_subprog(struct __sk_buff *ctx)
 __noinline
 static int static_subprog_lock(struct __sk_buff *ctx)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	ret = static_subprog(ctx);
 	bpf_spin_lock(&lockA);
@@ -127,7 +127,7 @@ static int static_subprog_lock(struct __sk_buff *ctx)
 __noinline
 static int static_subprog_unlock(struct __sk_buff *ctx)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	ret = static_subprog(ctx);
 	bpf_spin_unlock(&lockA);
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index f678ee6bd7ea..a4bbc66e2302 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -204,7 +204,7 @@ CHECK(innermapval_mapval, &iv->lock, &v->lock);
 __noinline
 int global_subprog(struct __sk_buff *ctx)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	if (ctx->protocol)
 		ret += ctx->protocol;
@@ -214,7 +214,7 @@ int global_subprog(struct __sk_buff *ctx)
 __noinline
 static int static_subprog_call_global(struct __sk_buff *ctx)
 {
-	volatile int ret = 0;
+	int ret = 0;
 
 	if (ctx->protocol)
 		return ret;
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 548660e299a5..919e95dbff10 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -43,10 +43,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	unsigned long tcp_mem[TCP_MEM_LOOPS] = {};
 	char value[MAX_VALUE_STR_LEN];
 	unsigned char i, off = 0;
-	/* a workaround to prevent compiler from generating
-	 * codes verifier cannot handle yet.
-	 */
-	volatile int ret;
+	int ret;
 
 	if (ctx->write)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
index bbdd08764789..f799bffb40dd 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -44,7 +44,7 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	unsigned long tcp_mem[3] = {0, 0, 0};
 	char value[MAX_VALUE_STR_LEN];
 	unsigned char i, off = 0;
-	volatile int ret;
+	int ret;
 
 	if (ctx->write)
 		return 0;

base-commit: 6e951a9b1af5dc063dfe9e17ca433be099527c43
-- 
2.47.3

