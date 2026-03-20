Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68C13777E
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965306; cv=none; b=iePNRT9O6Ig3s+0hNaz6ccA1PbQQ1QUK9kzDH6kY5UWO8Q/a1lx5BlUEcFuZjeYW/5bqGrZIZ3pNwcwinhkk4BGESOSLMPUTEQhgU89XMltdg0s42sf5iSueXXVwsCVXsNHMragE2c2h7DFbq3Eq2sTNBaTkSeOPq0I5VKGOv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965306; c=relaxed/simple;
	bh=2jJhJS/gsetzKR5TGbZCcvesZkAnpC8v+8gpyRP1CB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXdQxMqBnTfqGTJeDVyJz6cgkYppEe/Uz1LoDRhU43Yf4UPb0pF33630kra5v/5AsboMu/PM0W8H9UfhQLxeovcm2Nc8azo6b+PujI+SnArHZln8yzHKaqhUqWwNb54x4aSp7hzcVPs7fYw2dSxwx8/K0saUdeoRTSbwoNW3aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DK2bafAe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DK2bafAe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773965302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wefqSMns5islEg+vDsdqLdu9OcNzZoGGKIEOglSKT1w=;
	b=DK2bafAe1qlGlFiTzdyNwXLL7jTIqnJqpAJJzsT2iYbBtDP/nlq2fVMBahfO9JCkincg1X
	pIrHk1vigm3vgQ89b2ANkb7nIhGAmk8asTVGkz/xKOkoC8+KVzQrY88nEUkvTlGZDvyuCJ
	/9o/Ah2dDdBG0UK1q4HGBlBUKrIxAn4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Fix exception exit lock checking for subprogs
Date: Thu, 19 Mar 2026 17:08:08 -0700
Message-ID: <20260320000809.643798-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

process_bpf_exit_full() passes check_lock = !curframe to
check_resource_leak(), which is false in cases when bpf_throw() is
called from a static subprog. This makes check_resource_leak() to skip
validation of active_rcu_locks, active_preempt_locks, and
active_irq_id on exception exits from subprogs.

At runtime bpf_throw() unwinds the stack via ORC without releasing any
user-acquired locks, which may cause various issues as the result.

Fix by setting check_lock = true for exception exits regardless of
curframe, since exceptions bypass all intermediate frame
cleanup. Update the error message prefix to "bpf_throw" for exception
exits to distinguish them from normal BPF_EXIT.

Fix reject_subprog_with_rcu_read_lock test which was previously
passing for the wrong reason. Test program returned directly from the
subprog call without closing the RCU section, so the error was
triggered by the unclosed RCU lock on normal exit, not by
bpf_throw. Update __msg annotations for affected tests to match the
new "bpf_throw" error prefix.

The spin_lock case is not affected because they are already checked [1]
at the call site in do_check_insn() before bpf_throw can run.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c?h=v7.0-rc4#n21098

Assisted-by: Claude:claude-opus-4-6
Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

v1->v2:
  * fix reject_subprog_with_rcu_read_lock test (Kumar)
  * add test case with irq lock (Kumar)
  * remove reject_subprog_throw_rcu_lock test from patch #2, since
    it's essentially a duplicate now

v1: https://lore.kernel.org/bpf/20260317001325.318004-1-ihor.solodrai@linux.dev/

This bug was discovered by an AI bot. You can find the original
AI-generated investigation here:
https://github.com/theihor/bpf/commits/ai-tinkering-20260310-0745/

---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/exceptions_fail.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df22bfc572e2..5c0e6809024f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20911,7 +20911,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	 * state when it exits.
 	 */
 	int err = check_resource_leak(env, exception_exit,
-				      !env->cur_state->curframe,
+				      exception_exit || !env->cur_state->curframe,
+				      exception_exit ? "bpf_throw" :
 				      "BPF_EXIT instruction in main prog");
 	if (err)
 		return err;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 8a0fdff89927..d7f1c492e3dd 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -8,6 +8,7 @@
 #include "bpf_experimental.h"
 
 extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
 
@@ -131,7 +132,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,11 +148,13 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
-	return throwing_subprog(ctx);
+	throwing_subprog(ctx);
+	bpf_rcu_read_unlock();
+	return 0;
 }
 
 static bool rbless(struct bpf_rb_node *n1, const struct bpf_rb_node *n2)
-- 
2.53.0

