Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1EE20010C
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505647; cv=none; b=G8HBR2OVAHoMQLT8gda72gtYAJbwqyYy/Tgy827z9E1rZTffOlpum3ahrPILIPUg0Oum8mWj1O6k62NpxAav+r1Icmnn4mZ27XcYpuMmE3um6aevENEQIUC7jWz+rP9ziEZwkSscQ38WfsRAkMr7ni78Add54s9ob4mAQ92LEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505647; c=relaxed/simple;
	bh=v2w/95JyMlM9u7kuRCBiMeO91FSb+A/FLHxYMcrbkFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W7ho6XEtMT8ZxzXMwgzEMHwuDuU1DebX2TS9YIhZglhR75xIJjqQlS47F+GW6SCrVSuDqx7b7dDYr7UO4l65HfdVj/zCPM/JmbDw10M+JrFLjW1hLAMTpTYgZjAfTcLi8hPIu2yQsxgG3rEbbZOhy6txKPhTjXA5xIofCRI2ERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAIN2TB/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAIN2TB/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad60525deso12510915ad.1
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 15:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505647; x=1771110447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=903pwS9Qmgkjn0WanGDgQP7chQ6S3IJyQ8D1TpFC1CA=;
        b=nAIN2TB/l2eXpsbEM4BKP0B/KyCHOJFF4UkqIPUB0L4y2zQN8htSI+QT+dKwQcfG5V
         b9tyntwgkyht1AVLny1flVqlW3XnGPfDqEFkswQtWn4iQAJ8y5qh7rty6FCKm551t4rb
         Cpyrr8JH1oHCtBxDEU1FBU+lAawlp56WTGc/BV0fsM4bfMEBWFpgFsbHsMxsnONc87q6
         qMik5TjOhVWkDK74Ly+eOM+AGeTNp9Nam+MhVOWicXf6JRBZgFLuXV1tAETaQ+ERQJcV
         woyGNGK3Z9FfnYggShPKAahZk/8ET8iQ0nj5D9FXGhi/h/Fex+57WPuN13uYLzH6HDvD
         SeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505647; x=1771110447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=903pwS9Qmgkjn0WanGDgQP7chQ6S3IJyQ8D1TpFC1CA=;
        b=gD3Lg1u3a9ckPKxH6RRSTWGpNjfiZYx3iKv1NH8oYpOIS+8wn9t8lmiYi8wSTT9d6B
         f3c3IsocFMuXaj+mqnwe0eO6XHs37fVKaLKtcKqRBcl8cScayl0AfdOTQZQIa0NMgQ5b
         YnBAkTlaSCF9Ss6X3DQ4RKwfJM50WiWiag//1KgjgdZr97x5ts7eoWVjW8pqIACzojdg
         i9GcbAfDzpHHzzrEb/8sWQVXce4rsesmg5P39SWAC4xpKY678szVuGwl/l6RLZJ2tx3p
         0Gt+MrxwjQ89gmrDNxwGv0apj70j7Wqyb/GaB2UUsqNr0UK/3AmrYR3WYB4BA1XITH9j
         6cVg==
X-Forwarded-Encrypted: i=1; AJvYcCUA+wVHHGwTsvtbyP3yAxdfnCoWggTgYnwf6Timd/eeV33INi2qw6Ku81xcGKz4i91p9tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywskz+BGA8pZw64ua9ikW53i/oYFxHQY+b+N0DcdxRl7F3dTYpX
	Ci0Ev3U/7gqp3qWV2JWji9pU8whKcbOtD048LDr/v8tdA3CO82autfuQ5dfn36DshZ8xmoXY4D2
	MLnkLMA==
X-Received: from plok7.prod.google.com ([2002:a17:903:3bc7:b0:2a7:6d75:fafa])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d1:b0:2aa:d67b:ef96
 with SMTP id d9443c01a7336-2aad67bf3b6mr16859935ad.31.1770505646720; Sat, 07
 Feb 2026 15:07:26 -0800 (PST)
Date: Sat,  7 Feb 2026 23:07:11 +0000
In-Reply-To: <20260207230720.2542943-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207230720.2542943-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207230720.2542943-3-kuniyu@google.com>
Subject: [PATCH v1 bpf 2/2] bpf: Reject access to unix_sk(sk)->listener.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the previous patch, bpf prog cannot access unix_sk(sk)->peer.

struct unix_sock has two pointers to struct sock, and another
pointer unix_sk(sk)->listener also has the same problem mentioned
in the previous patch.

unix_sk(sk)->listener is set by unix_stream_connect() and
cleared by unix_update_edges() during accept(), and both are
done under unix_state_lock().

There are some functions where unix_sk(sk)->peer is passed and
bpf prog can access unix_sk(unix_sk(sk)->peer)->listener locklessly,
which is unsafe.  (e.g. unix_maybe_add_creds())

Let's reject bpf access to unix_sk(sk)->listener too.

Fixes: aed6ecef55d7 ("af_unix: Save listener for embryo socket.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/progs/verifier_sock.c       | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b328a1640c82..2ffc6eff5584 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7157,6 +7157,7 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 
 BTF_TYPE_SAFE_UNTRUSTED(struct unix_sock) {
 	struct sock *peer;
+	struct sock *listener;
 };
 
 static bool type_is_rcu(struct bpf_verifier_env *env,
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 8de4d3ed98d4..730850e93d6d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1191,4 +1191,28 @@ int BPF_PROG(trace_unix_dgram_sendmsg, struct socket *sock, struct msghdr *msg,
 	return 0;
 }
 
+SEC("fentry/unix_maybe_add_creds")
+__failure __msg("R1 type=untrusted_ptr_ expected=sock_common, sock, tcp_sock, xdp_sock, ptr_, trusted_ptr_")
+int BPF_PROG(trace_unix_maybe_add_creds, struct sk_buff *skb,
+	     const struct sock *sk, struct sock *other)
+{
+	struct unix_sock *u_other, *u_listener;
+
+	if (!other)
+		return 0;
+
+	u_other = bpf_skc_to_unix_sock(other);
+	if (!u_other)
+		return 0;
+
+	/* unix_accept() could clear u_other->listener
+	 * and the listener could be close()d.
+	 */
+	u_listener = bpf_skc_to_unix_sock(u_other->listener);
+	if (!u_listener)
+		return 0;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0.rc2.204.g2597b5adb4-goog

