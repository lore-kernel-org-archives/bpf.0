Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B630BB88
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505646; cv=none; b=ZSiK+RnQFjWLNR0LT11kMyr+V0qN+W4DwSPg8Wk9fo5X5EmhBY6ShgKexTez3SMIwnSBf3OLF6RzlzhH/03Ps82xtACrGAQ++NSaTGKEV3QKzBWBanRXW3BNJR2bmE069qmIjMw9cPML4z0vAGPdl60N8nwwQA6Ir1xgMmEafNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505646; c=relaxed/simple;
	bh=C41IRFijtQzRZlauXeIIR/4sndA4xOV88VT65gcUTFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UcWEx75ZsnJYKvI+rBqcaYF7UgMnQ+s5eRAvCUP0hyh9bBjuM0i9VFs2EW19wqq9VxZtmhVuuJXoMjRBmS36YR3Eks5fXPd3KEz1/pC8afT3T02qA+UxoI4hbAfYnWpsQxqPDQSOCDAuptpINlMKBzhMjJPG/rXO9232oEtyRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPlLADHL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPlLADHL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a76f2d7744so33949075ad.3
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505645; x=1771110445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bv9HC4USag0VbcfoeIn7GkYivkoa06qGH0wzz89UHc=;
        b=gPlLADHLrtuA2ODrGwpKDrd6sKkwgNE41C2lRpoXrEdaDwu1aSycTpoY1trxISUla0
         3DiZOWZdUhLxFPhCmW3tqI5av5T7B1vdF3b1VdWXoCKW+1Hp4dRKD+vtetXGxnscyeEr
         6TJAjElmk/ohT3Wo6Q6KvJe0pc223V1behlU1fAdaUVU/n7bQGRLArtmx9wUf5MqwVZP
         u12OzQ7b0jR5yHYdzqYabtZ8WQxx6m3gzFEDLVTb258HpZfUeutPY3XsZLzBuXmQ5ti6
         KTcqLh5QkN2fmvBzQkFH52wzoAClkYYrBW/o80aeCZx0mrq1CqFZnaTBbVIi0ha1t3wC
         gXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505645; x=1771110445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bv9HC4USag0VbcfoeIn7GkYivkoa06qGH0wzz89UHc=;
        b=X9cFS6/RLfAL2l2g8oVu8+rMgUhucStkJsJMyMgxEo8rbKxUSuXM5MKfJft4L85HLa
         eP/f39sIMv3dYpnFJvfN5NpewIQOQpMPJXyWgX2sDN04LWnr3VYLabhBnyGqCSb6xynv
         fgAmCOtIZjSUC6N7/N3A1PJ9BtB3t6IVLslo3lYBHOs6l3iUbvk9aQAmuHI6fl7x0o90
         IcBfPAPiEstnuZgxv2Bhzu4LGIOb8tcdnvAQr0apua7KYTrCKcpnOFZ2hiFVMs/AgBKs
         jzGjodUDRXqpt+Jsw3LWeSMQukDEUDBv1t0PWlmvCMcFQtG9JCsba73vX4/JcAccMryr
         05wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUoULxEE2bmD4iMxG98CWnSrEtaXpOTa3/k4JhCX09uz2NE3D0BXJ6NGi8WZNNGYOPlzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziCinzDGcRGTf7BSbYlDllk4oHzn/FTc6Lgk5MsX+OyXY7vHfj
	w4oododkNxOop/LkP/LvybWwX/GIwmK6yO0KKLWxOULholYxK0XIFg5Rd4w4wNuu8ibzC3Wm4CX
	4ohecHw==
X-Received: from plbkj6.prod.google.com ([2002:a17:903:6c6:b0:2a9:5e41:3b0a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0f:b0:2a2:d2e7:1601
 with SMTP id d9443c01a7336-2a9519428c7mr68235285ad.48.1770505645223; Sat, 07
 Feb 2026 15:07:25 -0800 (PST)
Date: Sat,  7 Feb 2026 23:07:10 +0000
In-Reply-To: <20260207230720.2542943-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207230720.2542943-2-kuniyu@google.com>
Subject: [PATCH v1 bpf 1/2] bpf: Reject access to unix_sk(sk)->peer.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Michal Luczaj reported use-after-free of unix_sk(sk)->peer by
bpf_skc_to_unix_sock(). [0]

Accessing unix_sk(sk)->peer is safe only under unix_state_lock(),
but there are many functions where bpf prog can access the field
locklessly via fentry/fexit.

unix_dgram_connect() could clear unix_sk(sk)->peer and release
the last refcnt of the peer sk while a bpf prog is accessing it,
resulting in use-after-free.

Another problematic scenario is that unix_sk(sk)->peer could
go away while being passed to bpf_setsockopt() in bpf iter.

To avoid such issues, let's reject access to unix_sk(sk)->peer
by marking the pointer with PTR_UNTRUSTED.

If needed, we could add a new helper later that uses unix_peer_get()
and requires bpf_sk_release().

[0]:
BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
Read of size 2 at addr ffff888147d38890 by task test_progs/2495
Call Trace:
 dump_stack_lvl+0x5d/0x80
 print_report+0x170/0x4f3
 kasan_report+0xe1/0x180
 bpf_skc_to_unix_sock+0xa4/0xb0
 bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
 bpf_trampoline_6442564662+0x47/0xab
 unix_shutdown+0x9/0x880
 __sys_shutdown+0xe1/0x160
 __x64_sys_shutdown+0x52/0x90
 do_syscall_64+0x6b/0x3a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 9eeb3aa33ae0 ("bpf: Add bpf_skc_to_unix_sock() helper")
Reported-by: Michal Luczaj <mhal@rbox.co>
Closes: https://lore.kernel.org/all/408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co/
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/bpf/verifier.c                         | 18 +++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 25 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3135643d5695..b328a1640c82 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7076,6 +7076,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
 #define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_trusted_or_null)
+#define BTF_TYPE_SAFE_UNTRUSTED(__type)  __PASTE(__type, __safe_untrusted)
 
 /*
  * Allow list few fields as RCU trusted or full trusted.
@@ -7154,6 +7155,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
+	struct sock *peer;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7201,6 +7206,16 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 					  "__safe_trusted_or_null");
 }
 
+static bool type_is_untrusted(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg,
+			      const char *field_name, u32 btf_id)
+{
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock));
+
+	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
+					  "__safe_untrusted");
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -7343,6 +7358,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	} else {
 		/* Old compat. Deprecated */
 		clear_trusted_flags(&flag);
+
+		if (type_is_untrusted(env, reg, field_name, btf_id))
+			flag |= PTR_UNTRUSTED;
 	}
 
 	if (atype == BPF_READ && value_regno >= 0) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index a2132c72d3b8..8de4d3ed98d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -3,6 +3,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
 struct {
@@ -1166,4 +1167,28 @@ int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+SEC("fentry/unix_dgram_sendmsg")
+__failure __msg("R1 type=untrusted_ptr_ expected=sock_common, sock, tcp_sock, xdp_sock, ptr_, trusted_ptr_")
+int BPF_PROG(trace_unix_dgram_sendmsg, struct socket *sock, struct msghdr *msg,
+	     size_t len)
+{
+	struct unix_sock *u, *u_other;
+
+	if (!sock)
+		return 0;
+
+	u = bpf_skc_to_unix_sock(sock->sk);
+	if (!u)
+		return 0;
+
+	/* unix_dgram_connect() could clear u->peer
+	 * and the peer could be freed.
+	 */
+	u_other = bpf_skc_to_unix_sock(u->peer);
+	if (!u_other)
+		return 0;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0.rc2.204.g2597b5adb4-goog

