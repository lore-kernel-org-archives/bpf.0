Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB2946A
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965308; cv=none; b=n4yBmkCsd8e82ZU2ocE/4VEwniadGn6BOnl+jkEUZFUyk3NHdCcS99EQmxBxvYHB6VjieQalvfh/OK77Kjb+UmI8hiAr0TjXzn/UgACpdIW9yZUqUhpspZV+gJI+55Ammwk5eKNWG7dpvfC+rf8gnPo2RjEt4aqiuHpq2JyhadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965308; c=relaxed/simple;
	bh=N7zW9MTwRn/LA6kK6L7yrbmYk9SkgjLkPb64CkuO7tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grtorq7dtud15ekFgnYNTxAy77X5To2g2X1cQome/+h/zqfat94MYirm06HapfJI8bRiW6usXHBVFjxA5gDp5rAUEfnqtS8bkD25Zoxe2MiLU3F2nbCX4vw2vP7nFqklaQrEbjZL86YKcZKgNVQwVU+At4yQdUnxvfgsvPofoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U3DTRztP; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U3DTRztP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773965304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlJAz/MS2GqrFQaBqGoSqbQAjVawX3I4YWIFnTBvWNg=;
	b=U3DTRztPUk6qeWQy53TuJbyEn3ntfMGnQE73DHJXxHhUKOzA521NXKugNy2Yv4Wijr1PCB
	BpRwdvykzc/Y6DpC/qeUP7XNMOhwie7neb/0t0ftTdympb5Vnxv5TAjC6knIW63ioGyUXe
	OsE05UIqwnnZ4FGSgMg++G8fZuptvyk=
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add tests for bpf_throw lock leak from subprogs
Date: Thu, 19 Mar 2026 17:08:09 -0700
Message-ID: <20260320000809.643798-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260320000809.643798-1-ihor.solodrai@linux.dev>
References: <20260320000809.643798-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test cases to ensure the verifier correctly rejects bpf_throw from
subprogs when RCU, preempt, or IRQ locks are held:

  * reject_subprog_rcu_lock_throw: subprog acquires bpf_rcu_read_lock and
    then calls bpf_throw
  * reject_subprog_throw_preempt_lock: always-throwing subprog called while
    caller holds bpf_preempt_disable
  * reject_subprog_throw_irq_lock: always-throwing subprog called while
    caller holds bpf_local_irq_save

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/progs/exceptions_fail.c     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index d7f1c492e3dd..9ea1353488d7 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -9,6 +9,10 @@
 
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
+extern void bpf_preempt_disable(void) __ksym;
+extern void bpf_preempt_enable(void) __ksym;
+extern void bpf_local_irq_save(unsigned long *) __ksym;
+extern void bpf_local_irq_restore(unsigned long *) __ksym;
 
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
 
@@ -349,4 +353,47 @@ int reject_exception_throw_cb_diff(struct __sk_buff *ctx)
 	return 0;
 }
 
+__noinline static int always_throws(void)
+{
+	bpf_throw(0);
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
+SEC("?tc")
+__failure __msg("bpf_throw cannot be used inside bpf_local_irq_save-ed region")
+int reject_subprog_throw_irq_lock(void *ctx)
+{
+	unsigned long flags;
+
+	bpf_local_irq_save(&flags);
+	always_throws();
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

