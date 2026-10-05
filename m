Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C54CCDE9
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215149; cv=none; b=VwRa2W9P4zuD25uftDIEKZic/3cRkdNi3uQ6ZSWGql+6qzfervPKz7dAKOCQSTza2wKUtN+MJF5j9V3+3EEi97G218Cu2FJcIMu5+8Z3l+q0/saR6N94+W+C8fSKdly/eyiKA+SOTKUmbBGoX4LWYmyOTQ77IFJt9l27t8lOzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215149; c=relaxed/simple;
	bh=Q2f1V0tkCx4yafzTY/KvIkrRmeVZtfjhPwTAlfBKWBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WbEd6KSpmzEJFYb+4B9UbdgOj5L37SqfSNGxbpiLrjwboCNOr7k8qo1eufK8x3lGX6rtz1WHrEWC9AyNwEf5m4AcILrPrIzgJtHzCFRIicE8Z+DElhUM+YY2qJgtsqeLY6H35uv/GXEsSKnJ03j+FK0QNF3IgUfiV49Z3rDvn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0p/D6aP; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0p/D6aP"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e564adf782so16057655ad.2
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215142; x=1791819942; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDYQAUOBWfVnW1p28OSO24KQlxjydl2jDmrw3Gs9NmE=;
        b=h0p/D6aP9199euwccwTPxEuGKIKGZePutEF97DZH+PXbzUlLC60/Jl7CakRgsD4mzx
         X/0zfx82qyGk/mpuIEl4d+xNuxE1NCDMEzeGHwmhvMGB4NqSRtTaKeTpFCzQQsEPevYm
         n23oF/f+KOBrrCHd4GRdPNQW6WxJSnGATAN0dgQkHScMP4r5G+wGIDOe6rDeQMeiN6x4
         Rkao9ipuUZe6mJouUw9Vy9LEmbu5tkpwU1XC8gheiZZumzWDAOB0f+2etKLxSNmt7rHB
         AIp6p4ZezQqjw9BAnBymDK6TMoRqzE0aaClFsZ+Lq2XivOpwy+z/lhFoCNpmN4xOYlhC
         qa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215142; x=1791819942;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDYQAUOBWfVnW1p28OSO24KQlxjydl2jDmrw3Gs9NmE=;
        b=0rFhBnZPP2izAdbRJarILiIKO8X+a6jMcaTxMtI4YxGOVjEQV+av/8pE+5YXarfqJ3
         Py3jAPax+nt6Kx1CHAZsUvA5S3rBuF1i/FZTHFK6rT4USPOdrey/kJy03BJUMXb8c86p
         qcDoE8FNeMmIZiTzfql6rFgaYMgZsxjMAmFW798xmwUf6NfCC1EK20M1LfpbAFtI8XGI
         FKrR2t0A/2h5kQXIqQ/9ND+yIjQBYuJ2M2VN4XMlOBLAC2qLqzpwOEqd2KJ2yJUcCmQp
         UAKTAxExBtm8lulVz/39h8JsjcsRma83RhX+2lB2Its2QKgatq2kFcC7kJd/NhMGTPLY
         xjcw==
X-Forwarded-Encrypted: i=1; AKwUvByY+AX5n2vuPlNX8gusHMNuF07wprgUDuisuPxl8OMzmcPbcYODZTobr7g9Y6jkLAI+neE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFjwhNRlN4w2W9nP8aK+5yPHIVr612e1VCSXCkdjNHXaK+UvAg
	/7QQ8AvSPer3jJ98d0vJOZdLdhiFOAHN5BW2UhyZf8HSHlV0zs2pr3fJd58PD5dwiLgVx3eaDnJ
	oZIc4ew==
X-Received: from pghs8.prod.google.com ([2002:a63:e808:0:b0:cca:5338:9514])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c8:b0:3a8:2046:7e5f
 with SMTP id 98e67ed59e1d1-3a82046834amr1775675a91.12.1791215142142; Mon, 05
 Oct 2026 08:45:42 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:46 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-5-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 4/9] bpf: tcp: Guard fast-path bpf_tcp_ops_call()
 under per-socket flag.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
incoming / outgoing skb.

bpf_tcp_ops.rtt is called once per RTT, which is every
incoming skb in ping-pong workloads like tcp_rr.

Even attaching NULL callbacks in the fast path hurts performance.

Let's guard them (and write_hdr_opt) with the new per-socket flags.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h     |  3 ++-
 net/ipv4/tcp_input.c  |  7 +++++++
 net/ipv4/tcp_output.c | 20 +++++++++++---------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f69091f5e01f..48487135c076 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3142,7 +3142,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
 	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
 		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
-	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
+	if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RTT))
+		bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
 }
 
 #if IS_ENABLED(CONFIG_SMC)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 222c7bf80542..79d721215f52 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -210,6 +210,13 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 
 static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!(tp->rx_opt.saw_unknown &&
+	      BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) &&
+	    !BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
+		return;
+
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
 	case TCP_SYN_SENT:
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 908944d409d6..3ec26ad347ef 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -576,13 +576,14 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		memset(skb->data + first_opt_off + nr_written, TCPOPT_NOP,
 		       max_opt_len - nr_written);
 
-	/*
-	 * bpf_tcp_ops portion is NOP-filled (everything past the sockops
-	 * writer's bytes). The writer finds the append point by scanning from
-	 * first_opt_off + nr_written to the first NOP.
-	 */
-	bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
-			 first_opt_off + nr_written);
+	if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)) {
+		/* bpf_tcp_ops portion is NOP-filled (everything past the sockops
+		 * writer's bytes). The writer finds the append point by scanning from
+		 * first_opt_off + nr_written to the first NOP.
+		 */
+		bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
+				 first_opt_off + nr_written);
+	}
 }
 #else
 static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
@@ -613,8 +614,9 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 {
 	unsigned int remaining_out = remaining, reserved;
 
-	if (!remaining)
-		return 0;
+	if (!BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT) ||
+	    !remaining)
+		return remaining;
 
 	/* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_out */
 	bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

