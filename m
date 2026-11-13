Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546623;
	b=SjOXyLQ+hxmBTrAd7qurnNZFvXmOdtPrYvDN6KYYMyPfejQPq9+NA01HGqTT2bvJKhsn
	 24r2Ka5/z1YtzZM+iaanWBVmiqOmf0tkDwOBVc0aiXtahrUs/yTCk8X7zMpeC/nd1Zcsx
	 eWI58H8vykgXQjwTRlmVH2nlDcTa/vXzidXJBv3/2FcTJIkAa62Ff3vObhLFbmn7M9GFB
	 /8mddWLcQBKSVyszaD03myVAK1n7ixf8Wgu6nNkTWdMwGWPOCznxKPa1xqJ0SJrbyt8an
	 qHQkQe84DIcGUWPULMPWIzCUPwZupb6lyMKpIFtjI86xxHROjcGS6te4suFtcncH2lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NMH97Fk3PWPVn+P/iaoukHh1wzl243PKREFzHGmF3II=;
	b=gIX5oaPsbknA54Lx21qFO7N/V6IdFERz4zbwq7j46+WAyHD+hsrFBNJ7GOF5A0u+WOhM
	 CSVpdni2r6TtxRRQdmwftxStxBVLenS4pRoTWIRlvL/rgnBDILueJBg2FX3MK4YvNLWuG
	 zMqz/fddT1yyVMhQpsXiJXuF2uwHfbArV8jpDKS7qU3r9lO8X+juOddvrjeyavWYXShLn
	 Cyhf0kfUwBQFG8k9kNGFfwJKVB6EPNLWEz3WX33eabGTMyNiBvPReq6lnoH6ho77JJ8G0
	 Q5u0/uQz9XNPLridi1dj3fKemUiVuFFbGOWw62lC6MoegwF5fPZCHWo7iGoRJ6qWLaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXWKCeZT;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC02606A31C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BC02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eXWKCeZT
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so227072a12.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 21:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794546623; x=1795151423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMH97Fk3PWPVn+P/iaoukHh1wzl243PKREFzHGmF3II=;
        b=eXWKCeZTfJ1h2HXVpmVsI2a7XcvljNaCpkUdGD+lXBWToms9CQ2yCA0oLuIoKKPBSd
         fiBGtA6YdIlGsXK7DE0ndyDOOxchHhRrPIKVatz9H0xgjAo2BYrRXE5EHyDXoIwIrYVp
         vXvWv5c344sq8Xtug5rSqPyduU2433esWtVzcqG+Kim3/524smwCtAG50PIt7IBEp8JV
         CxRfnXDDnJ/iYxy0wK85aPWmj04yuyL4giiUswGTSR/q+xxFDaJLf4IyZ3ruSYw7m1l1
         mt5TaGuWhdqmJ7yDoAKRruY1I1JIsbHMMl6+cuThfJS5YsWSboFQKCWw9oHrUNbVZ8nF
         VmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546623; x=1795151423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMH97Fk3PWPVn+P/iaoukHh1wzl243PKREFzHGmF3II=;
        b=wDgRuN4FDwx5IzHg8cUUA5VDmwTvDSTeXQxwbRuqI5kI4UvjonI1Zh/qtPqRqCgcCm
         1u0KGrHtarAeBko2DZAROEZB1MhZ2Eg7KjR5Ym6h1QpvJJFzLaCXU5noPtCFDti3f4Vc
         q9NEtDpLWaT0bfGLJK9IfjkI9aQAcPs7KVJMpJYePsIFQ0MIV5H/N4rEHE6v2/ORfTyf
         uUxdgSpOHRmVa6TULKUbzTxC59G1FZSGnwNBgKCfHRonlkLg+j2vpIVvSjMZQOy7nIOG
         Q7s1n3Fjbg/OdNUzKICxc3QBYszJBwgpK5ObdduY0Hh8vC/zo30VfVZnLqownqGRytGM
         vfbg==
X-Gm-Message-State: APuU4Z9YRGUpEpT9KsO7oW1HveGPcwtSV+17ms7EGEj0z76wdwBZq1CO
	IFKx1Afyxb2NR6inmCrty0My6Ik+vnAGtcpgJZJl3RjonxtmFZKvP1koadIpOg==
X-Gm-Gg: AYBFou0PgNP1TCE7b7szut0n2QK6seTV/jis76XTcd8Czk2/Cw8qYNnSnU0uFhQTe9Y
	FZTqWt1hzS5jhuPiFPy8UhyqetZ5uyQuTO0QUX1FO4ibPGeEIQMHT36BnA4j3+zEBiyOzqu1aDg
	lpqeZk+uhc2H+1ci7E+HMHmABwkKJr0jTem8Nba30QOAUcxAHx734OzJk62qJJUsaUEkbaz0VAT
	e2DMpCluyE4nVfdh4k471UvC18cjw9eOaqNDWIWTW5v5vBsHO/tGzfhHMVebXXnyYSFpfyFdne3
	ugU+lu52349BeQsG08zqnSh6v6SiWp9qdpfK4Q+eV4UKoDtT6bqrl8QevOXKOZ2qHcrE4nt7vAi
	gZldxX0igz1nS9yfBIjaliOt3ed63Edof1pK+Nce4W6WT9ID9h/cssLIIAyXWtQGYO+8CyQy+iz
	tOYcPjN2ZbL0OwQoug4AJH12eHEd5sXoLtbqr/zeTzKLTYZ1My0M6f9/wwK581n+vvoBHmUTNWI
	pGbgWNnBqEKulQhN9jdEa5i3+0ghHxgIOBIdVWgT4ck4N4T1XlqM9XOETZxsyW2UNDJ7B4So7Cd
	1fbpFXcZji9X77lptpEHUBM3WO/7h2M+ehQfIYz7g8pPHvw9uxNeNE2OjxJeAkXJMGWe3/3cxkg
	MYmW256JwULwyn9wgEweX67wIl2y4ToSQ9lMSoZh+RN0VVVwpkHZB8Y2aeA3Ho4vUc3eUilZUeQ
	==
X-Received: by 2002:a17:90b:4f85:b0:3b0:91ce:6720 with SMTP id 98e67ed59e1d1-3b1b0a1ef3emr1052753a91.30.1794546621449;
        Thu, 12 Nov 2026 21:10:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm2599412a91.12.2026.11.12.21.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:10:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH v2 bpf-next 13/13] selftests/bpf: Test untrusted pointers in fmod_ret progs
Date: Fri, 13 Nov 2026 05:09:01 +0000
Message-ID: <20261113050901.1399091-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-1-alexei.starovoitov@gmail.com>
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

Helpers refuse an argument of an fmod_ret prog and what is loaded through
it. tcp_sk(sk)->snd_una, container_of(), a part of a pointer and an index
behind a pointer load and give a number. The number is no pointer. A store
and a store-release are refused, a trusted pointer is checked against its
type as before.

Two progs run: container_of(task->tasks.next->prev, ..)->prio, a load at
a negative offset, gives the prio of current. A load at NULL - 8 gives 0.

The progs attach to security hooks. These are targets in each kernel, with
and without CONFIG_BPF_FMODRET_SCAN.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_btf_untrusted.c        | 112 ++++++++++++++++++
 .../bpf/progs/verifier_store_release.c        |  23 ++++
 3 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_untrusted.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4d77b8fd4eab..e6e4a13117dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -36,6 +36,7 @@
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_flex_array.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
+#include "verifier_btf_untrusted.skel.h"
 #include "verifier_call_large_imm.skel.h"
 #include "verifier_calls_in_a_row.skel.h"
 #include "verifier_callx.skel.h"
@@ -245,6 +246,7 @@ void test_verifier_btf_array_access(void)     { RUN(verifier_btf_array_access);
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
+void test_verifier_btf_untrusted(void)        { RUN(verifier_btf_untrusted); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_calls_in_a_row(void)       { RUN(verifier_calls_in_a_row); }
 void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_untrusted.c b/tools/testing/selftests/bpf/progs/verifier_btf_untrusted.c
new file mode 100644
index 000000000000..5b2e74277dc8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_untrusted.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+#undef container_of
+#define container_of(ptr, type, member) \
+	((type *)((void *)(ptr) - __builtin_offsetof(type, member)))
+#define tcp_sk(sk) ((struct tcp_sock *)(sk))
+
+long out;
+
+/* Nobody vouches for an argument of a function that fmod_ret attaches to */
+SEC("fmod_ret/security_sock_rcv_skb")
+__failure
+__msg("R1 type=untrusted_ptr_ expected=sock_common")
+int BPF_PROG(arg_to_helper, struct sock *sk)
+{
+	out = bpf_get_socket_cookie(sk);
+	return 0;
+}
+
+SEC("fmod_ret/security_socket_listen")
+__failure
+__msg("R1 type=untrusted_ptr_ expected=sock_common")
+int BPF_PROG(member_of_arg_to_helper, struct socket *sock)
+{
+	out = bpf_get_socket_cookie(sock->sk);
+	return 0;
+}
+
+/* A load that the type does not describe gives a number */
+SEC("fmod_ret/security_sock_rcv_skb")
+__success
+int BPF_PROG(past_the_end, struct sock *sk)
+{
+	out = tcp_sk(sk)->snd_una == tcp_sk(sk)->snd_nxt;
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int negative_offset(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf(), *self;
+
+	/* next->prev points to task->tasks. prio stands in front of tasks */
+	self = container_of(task->tasks.next->prev, struct task_struct, tasks);
+	return self->prio != task->prio;
+}
+
+SEC("fmod_ret/security_sock_rcv_skb")
+__success
+int BPF_PROG(part_of_a_pointer, struct sock *sk)
+{
+	out = *(u32 *)&sk->sk_socket;
+	return 0;
+}
+
+SEC("fmod_ret/security_sock_rcv_skb")
+__success
+int BPF_PROG(no_array, struct sock *sk, struct sk_buff *skb)
+{
+	struct net *net = sk->__sk_common.skc_net.net;
+
+	out = !net->dev_index_head[skb->len & 255].first;
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int bad_address(void *ctx)
+{
+	struct sock *sk = bpf_core_cast(NULL, struct sock);
+
+	return *(int *)((void *)sk - 8) + tcp_sk(sk)->snd_una;
+}
+
+/* The number is no pointer */
+SEC("fmod_ret/security_sock_rcv_skb")
+__failure
+__msg("invalid mem access 'scalar'")
+int BPF_PROG(number_is_no_pointer, struct sock *sk)
+{
+	out = !tcp_sk(sk)->out_of_order_queue.rb_node->rb_left;
+	return 0;
+}
+
+SEC("fmod_ret/security_sock_rcv_skb")
+__failure
+__msg("only read is supported")
+int BPF_PROG(no_store, struct sock *sk)
+{
+	tcp_sk(sk)->snd_una = 0;
+	return 0;
+}
+
+/* The type of a trusted pointer is no hint */
+SEC("tp_btf/sys_enter")
+__failure
+__msg("access beyond struct task_struct")
+int trusted_past_the_end(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return *(int *)(task + 1);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index 0abbee5ce109..b108fcd54437 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
@@ -223,6 +224,28 @@ __naked void store_release_to_sock_pointer(void)
 	: __clobber_all);
 }
 
+struct task_struct {} __attribute__((preserve_access_index));
+
+SEC("socket")
+__description("store-release to untrusted_ptr_ pointer")
+__failure __msg("only read is supported")
+int store_release_to_untrusted_btf_id(void *ctx)
+{
+	struct task_struct *p;
+
+	p = bpf_core_cast(0, struct task_struct);
+	asm volatile (
+	"r1 = %[p];"
+	"r2 = 0;"
+	".8byte %[store_release_insn];" // store_release((u64 *)(r1 + 0), r2);
+	:
+	: [p] "r" (p),
+	  __imm_insn(store_release_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, BPF_REG_1, BPF_REG_2, 0))
+	: "r1", "r2");
+	return 0;
+}
+
 SEC("socket")
 __description("store-release, leak pointer to stack")
 __success __success_unpriv __retval(0)
-- 
2.55.0

