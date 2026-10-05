Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A4C9DF9
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215149; cv=none; b=BGu7QRSwhlkk6ABQukRk+a0PhxtOcObd36hFPTQkIaPuF+y8bFTc3B7SqN2Rdqon0ZnsmHdwyZO0uK3VTVhm/sU/iDiy9m8F3bBf5UEONu3mWm0HTmx73md+UdPUu4fqt6KmnO7dTcyGT1ZnK63l7msGdav5+RID7n5vv9AORL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215149; c=relaxed/simple;
	bh=+E7mPdx805XfQTCk2NPM7Kx3HHK5rWGT8dm9GXhUgAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExTGReFDbNU7vrztICLp/YGiPkyjjfZ0d39b+5tkGHszpDDfFPV8An7kOVX/Mkm/eyCSIXKckoQt6OpIye1COMwC0/zsbqvz45S/+kWFxTkTEHAX+hbZMrFa4FoJdRy2bIgnM2HCauev3VrL5YcWZ6/UbAeke7C+O73DDOG1pIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpKf70ja; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpKf70ja"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e2d4a8623bso16798935ad.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215141; x=1791819941; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xX/5Nb02C2YtE1qy0ZgFtgKe+shT+yhzLU2+lEQOc0=;
        b=NpKf70ja+gdkVmkl8JsWlJARBUGzC/4Wl0fGA++ywYUWoKKZBRER5Vcqo4H2zKnr7L
         MbOseKyQu/hagXs0FmDk4Ep5s2vwWey1b3K1om+/TU+4nmewLNKNLPRstgmbqfB97Hfo
         Ik6qRVMzTNo2IDr36d5XHPtHzRlkFOI7E0Rmw8vk52KuWz+ouN4K7aioThouvJ9JpBay
         kjsSHjkYVHJfTesKXdsCp6xXpVS9dwADEr2GhsjKBaPX0kpRllFfjWm01YLqwAJbbHoK
         tOyJ/t+u8JkKobWeba3hgCy8hDvj17KOlzmH6r1C13iAj57BU2dz3RzbrPrtoTUBwVqS
         Lpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215141; x=1791819941;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xX/5Nb02C2YtE1qy0ZgFtgKe+shT+yhzLU2+lEQOc0=;
        b=iQVSWlawNmGRZE03wkcPrwPDQj4vjygSlSwGTtQvPgKdjImYq4vx6pdZZoppziGTlv
         o7DasIHbQXF1qw1ifkqhcR4NIM7rEGMclGMJ9LpFB3M6/JtBb5vB1ydfbLYwfEopmL6v
         Sp0+O6eDkrCgLQUY8QdAj/9UbWxqywiHBB5N0D2ocvesEvGP7PGE9Tb0aywtmpRbj/Xx
         2zoz7hm3UMzNB0KBBNEGig1VZMYStAleeoeHYEifWqegIB+hFo7zLu9Zjfw9KH7V5NZ0
         zyqaqv8jdqWmJnUdV1+M5PFwHWVbw1PIPLqokp36Uz4yR4IigbGelE96mnEv1Xt5Un/2
         h55Q==
X-Forwarded-Encrypted: i=1; AKwUvByoeZe/kYk7YEWg3opo+7PkPbC/SigsVE0zePqdhaAy49Tb6pxmH6iqJAtQ9eXJp39zQCg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3vjwRNh/tAKUZ/qyvRuOiRsm3fK+6wWtQHL/nbUSsAZDyQ4pS
	Un/1Lgq+Ub+2PbOgNF46p9xpvjh6nhRHK/G9zFZmxbxGtGexcpuuNeP/FN87hooE2bBTZzmgSCh
	qkR/3PQ==
X-Received: from pleb9.prod.google.com ([2002:a17:902:d409:b0:2cf:bf3e:41f0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22cb:b0:2dd:c053:e669
 with SMTP id d9443c01a7336-2e49b6af535mr101155685ad.47.1791215140670; Mon, 05
 Oct 2026 08:45:40 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:45 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-4-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 3/9] selftest: bpf: Use bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
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

The next patch guards bpf_tcp_ops callbacks in the fast
path with per-socket flags.

Let's use bpf_tcp_ops_set_flags() to enable flags for
parse_hdr, write_hdr_opt, and hdr_opt_len.

Note that BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL and
BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN are used on the
server and client, respectively, for better coverage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
index f3e3dff13784..706e94d794e4 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
@@ -18,6 +18,24 @@ int found_cnt;
 __u8 found_d0;
 __u8 found_d1;
 
+SEC("struct_ops")
+void BPF_PROG(test_listen, struct sock *sk)
+{
+	bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
+			      BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL |
+			      BPF_TCP_OPS_FLAG_WRITE_HDR_OPT,
+			      0);
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_connect, struct sock *sk)
+{
+	bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
+			      BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN |
+			      BPF_TCP_OPS_FLAG_WRITE_HDR_OPT,
+			      0);
+}
+
 SEC("struct_ops")
 void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
 	      struct request_sock *req, struct sk_buff *syn_skb,
@@ -78,6 +96,8 @@ void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
 
 SEC(".struct_ops.link")
 struct bpf_tcp_ops test_hdr_ops = {
+	.listen		= (void *)test_listen,
+	.connect	= (void *)test_connect,
 	.hdr_opt_len	= (void *)test_hdr_opt_len,
 	.write_hdr_opt	= (void *)test_write_hdr_opt,
 	.parse_hdr	= (void *)test_parse_hdr,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

