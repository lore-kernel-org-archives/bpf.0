Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301F262BD
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706429; cv=none; b=p/Ou+DxfXggvhIqNG8XhPLjw5/liArYiIO992vJJoYHoJ0N904hJ+eXsFa4K5jkeDM++1LpXtOzwQu4IcluT08kVdbN3YtzmPIDAKvpxL9MHfDiUnRI0lnFlHSpUYlhpwU5hcZ0h/iM81kwSkPm+j5xEPUJeY2PCAQQALVPY1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706429; c=relaxed/simple;
	bh=Z6kCAd3PZmTY34NZbXo7MOt/07SCQLy6Q1Jf80M6hPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhklWM/CUDJMo4Mgjo+tkp1sfkLwNm806gK7xdevUuPouuqn85eyAHbq0LIPHO/SrhgMJGJD9MSrNjWJc7Vc9VTWO7SFYKE2Jm6WwLE1xkfD7qOs9tGaKA4L5XOKF8GTX0RC2eELk3FIcLH+q42rYbxL+kbRF0fqWbtL2Q5gBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NIagJz+n; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NIagJz+n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773706425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8pYRSNxcrpNrMjXMnrg8L3bYz23unQuXWVI3qt6qhCw=;
	b=NIagJz+nHdzZzPZb5h4OEy3ML3qq4W4mJFa6xWGyRrZqDGvoBFAFAEyAXVmO5jwL6AbCDx
	OTByNdTt6tAcKD5JkEYxMAKGSdvL7TefG6Un6USm/oVn/NgVyCcii/zgFUN/Tubx3PQAhT
	z5eEOPU0KkdAlaDikvKshY+y/9/Ia90=
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
Subject: [PATCH bpf v1 1/2] bpf: Fix exception exit lock checking for subprogs
Date: Mon, 16 Mar 2026 17:13:24 -0700
Message-ID: <20260317001325.318004-1-ihor.solodrai@linux.dev>
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
exits to distinguish them from normal BPF_EXIT. Update relevant
existing selftests to match the new message.

The spin_lock case is not affected because they are already checked [1]
at the call site in do_check_insn() before bpf_throw can run.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c?h=v7.0-rc4#n21098

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

This bug was discovered by an AI bot. You can find the original
AI-generated investigation here:
https://github.com/theihor/bpf/commits/ai-tinkering-20260310-0745/

---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/exceptions_fail.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
index 8a0fdff89927..1dd2703c7676 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -131,7 +131,7 @@ int reject_subprog_with_lock(void *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
@@ -147,7 +147,7 @@ __noinline static int throwing_subprog(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_rcu_read_lock-ed region")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
 int reject_subprog_with_rcu_read_lock(void *ctx)
 {
 	bpf_rcu_read_lock();
-- 
2.53.0

