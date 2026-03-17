Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7E156661
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706430; cv=none; b=sWFBLSMZLXaYevU/rccf1mCgzhtXND0YIDAahNLTj4MCKtQvj66qkZAxn+Bu6R8jjVxKRQwuyh5dYle9VE0V2VEVQWMSOZ/iuxIWZa0RTeSg0cQ36mMQDbAjV5uHRLW7uQIBI4evRLZv1sE6IKHc3MbzHwEtfMQ6doKc0n/G8es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706430; c=relaxed/simple;
	bh=gJnOQSm8yBiNonlAAEniO16wUg2fEMm8bTs0PntsHHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td1DjFpywMiwQ4CieGP/2B+0YDw6N1TRKlUFG8nK6lZXExfINmwlwEero0/2/jOiwIUVTcGqrJmFGs9yqdUdU2ro7VgTBRux8tmD/A2Xt26229aPvAXlk6poxJdiIRskW9bg8qFEJgL3aDShAeNAqiWtX4P1tIQkaMjtPlUMXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JdNwAEnr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdNwAEnr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773706427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIy+xU7Dpbpw4tmyrdyKHHkWnyCzK8UDLQeLXyB75uU=;
	b=JdNwAEnrK32rcNXubG/fmjgTIWZp3LKZ/f1/zS79WCnS9D4Dcgi0YZtbaJ/0kAO3CVsy8H
	sPcyCRWUofQXTUQM1owhvtR/QvBTL6l4wxYtlbxEzIfH1ORbDeH57bDLJ9Fb5WttjKpFKy
	Gr0PWD37We6sCC53PGi0kjOWoRAnzzQ=
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
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add tests for bpf_throw lock leak from subprogs
Date: Mon, 16 Mar 2026 17:13:25 -0700
Message-ID: <20260317001325.318004-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260317001325.318004-1-ihor.solodrai@linux.dev>
References: <20260317001325.318004-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test cases to ensure the verifier correctly rejects bpf_throw from
subprogs when RCU or preempt locks are held:

  * reject_subprog_throw_rcu_lock: always-throwing subprog called while
    caller holds bpf_rcu_read_lock
  * reject_subprog_rcu_lock_throw: subprog acquires bpf_rcu_read_lock and
    then calls bpf_throw
  * reject_subprog_throw_preempt_lock: always-throwing subprog called while
    caller holds bpf_preempt_disable

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/progs/exceptions_fail.c     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 1dd2703c7676..9d1c560aac84 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -8,6 +8,9 @@
 #include "bpf_experimental.h"
 
 extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+extern void bpf_preempt_disable(void) __ksym;
+extern void bpf_preempt_enable(void) __ksym;
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
 
@@ -346,4 +349,45 @@ int reject_exception_throw_cb_diff(struct __sk_buff *ctx)
 	return 0;
 }
 
+__noinline static int always_throws(void)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
+int reject_subprog_throw_rcu_lock(void *ctx)
+{
+	bpf_rcu_read_lock();
+	always_throws();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+__noinline static int rcu_lock_then_throw(void)
+{
+	bpf_rcu_read_lock();
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_throw cannot be used inside bpf_rcu_read_lock-ed region")
+int reject_subprog_rcu_lock_throw(void *ctx)
+{
+	rcu_lock_then_throw();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_throw cannot be used inside bpf_preempt_disable-ed region")
+int reject_subprog_throw_preempt_lock(void *ctx)
+{
+	bpf_preempt_disable();
+	always_throws();
+	bpf_preempt_enable();
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

