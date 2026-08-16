Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0B2D877A;
	Sun, 16 Aug 2026 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913166; cv=none; b=WFffT2agmFqkrC4E6OciUe8JOHIP7GLGxS04WbhOSb1kAmbwnUmgVbWbFL7FIn6jborIL+gRjdhge3Y/bXGYEfVm0zqKaDo28J2N8YlHLdX2yeuc8EG58TTmUg4vqfXNU8etwEXeuNuz9y5C2vSlltjR/RQJIjeR4Wkav25sL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913166; c=relaxed/simple;
	bh=+vbmDQjyHdvOJM0g9AkHaKvncDjH+6SOqUc0vnGD0GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=huHfEgZgGEBIu6a0SgfvSVTeD1QgeuT7EGMW9hmuVLTj8CWk9tBumd7ccR1Q1EwX7OuytrWxPfRZDY80Rv3B+zCBqQpJOn4UYTE/YFSFEPkC9TvxhiqbEyLz4q4kLe60tmxk3CA6rI5dL6Cf6rz2dbfGQD/tWoC9XDtP4LpW+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=BkcV2Geh; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="BkcV2Geh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z8PE2QwmRoYXLYZc03fkDtCQdTD7ol+eYcE4/BDCVwU=; b=BkcV2GehtrDP+W/+hdPrpyDbxb
	dxlvt/Nyi1c8heVonYJPrcU/4E0ruXA1TyA/LwmkJ/RU6uVysZpAeBqj3/3Zoffv+Oo8oFvTFAn2S
	AxlMSN5Aa6WsNH0vo/u5O4fKBZKWQqlqjHoeROuoVvTlqzowGZUbAwGXKme3NX4MddjRSf6q5zwWB
	iIX1WXPPzgBEb9Y19xYTEZ7UDsAbqtwEFkez/p5oDH8Ut5mfhBuvcIaKY3TI54ls31mpUcCpdybJl
	zZ7fFyFn8gfc0dJcUMUer6l1pGR5mztHzN6zO3xTp0NlVoFsSFQjNnVTqobsST3wR6flJBJAewSjf
	p7pCgERw==;
Received: from [151.115.150.205] (port=49152 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wvhjw-0000000938B-1bOJ;
	Sun, 16 Aug 2026 22:45:56 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] bpf: reject stack-argument callback subprograms
Date: Sun, 16 Aug 2026 20:45:02 +0000
Message-ID: <20260816204501.493914-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Helper callbacks enter BPF subprograms through bpf_callback_t, whose
runtime ABI supplies five arguments. BTF validation nevertheless permits
static callback subprograms to declare more than five arguments when JIT
stack arguments are supported.

This lets verifier state for a callback use outgoing stack argument slots
prepared at the helper call site. The helper does not pass those slots. On
x86-64, callback loads of arguments seven and later therefore read the
helper native frame instead of the synthetic values checked by the
verifier. KASAN reports a slab OOB write.

Reject callback subprograms with incoming stack arguments when processing
callback calls. Add a verifier regression test using bpf_loop() and a
nine-argument callback.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/bpf/verifier.c                         |  4 +++
 .../selftests/bpf/progs/verifier_stack_arg.c  | 33 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdc5fbb1f78c..29aa4911c7f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9285,6 +9285,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
+	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog])) {
+		verbose(env, "callback subprog cannot have stack args\n");
+		return -EINVAL;
+	}
 
 	/* set_callee_state is used for direct subprog calls, but we are
 	 * interested in validating only BPF helpers that can call subprogs as
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 7e0ce5db28a0..5acc3b63ca84 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -27,6 +27,13 @@ static int subprog_7args(int a, int b, int c, int d, int e, int f, int g)
 	return a + b + c + d + e + f + g;
 }
 
+__noinline __used
+static int callback_9args(__u32 index, void *ctx, long a3, long a4,
+			  long a5, long a6, long a7, long a8, long a9)
+{
+	return a9;
+}
+
 __noinline __used
 static long subprog_deref_arg6(long a, long b, long c, long d, long e, long *f)
 {
@@ -79,6 +86,32 @@ __naked void stack_arg_two_subprogs(void)
 	);
 }
 
+SEC("tc")
+__description("stack_arg: callback with incoming stack args")
+__failure
+__msg("callback subprog cannot have stack args")
+__naked void stack_arg_callback_many_args(void)
+{
+	asm volatile (
+		"r6 = 0;"
+		"*(u64 *)(r11 - 32) = 0;"
+		"*(u64 *)(r11 - 24) = 0;"
+		"*(u64 *)(r11 - 16) = 0;"
+		"*(u64 *)(r11 - 8) = 0;"
+		"r1 = 1;"
+		"r2 = %[callback_9args];"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_ptr(callback_9args),
+		  __imm(bpf_loop)
+		: __clobber_all
+	);
+}
+
 SEC("tc")
 __description("stack_arg: read from uninitialized stack arg slot")
 __failure
-- 
2.47.3
