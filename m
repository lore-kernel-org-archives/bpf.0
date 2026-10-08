Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D476371CF4
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429372; cv=none; b=LS21d+X9tkXMRuPdbjrtiEI56UAEUT852dtA5NcY+nEdS9Cnt3tqvrrVo3MJYf3AI814oq2eSH1XWx2RKvvQxzkMIWuPsKxg1CuRwrUKYtyCrmyCPOpShy6shuTcOPSl8uyWXm7uml1L4S9WJp0WUVQVeJrzVxzd7zj5vF0cy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429372; c=relaxed/simple;
	bh=CPZHx6nPeBH37ffstlYZ4H23ROTe5Ar23zFui96a2SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bRr5rco9il+rhOBTWB3neuaSkZ5/V+hRA9VP9+HuTw20H7+ZNnZHXYb3zohHl8hJn/SzeLaHOA6T9neP6JYxTY/8KtaTKq9d9h2ERRN5cqH+hd7aEjKeTSB9IVtZFwvaGmIOMCgSI6Kw8scfbtX6yK3EBzuyCUt8vzg+HEdVsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSzpxdlu; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSzpxdlu"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d001671a54so57376285ad.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429370; x=1792034170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9Uw6ZReSMOu9UuqEeLaMzynTv5QJv73MooXkF1Ett4=;
        b=uSzpxdluCeutPUUpprB6S5FGm2R4oe6wQuL2/1W2qyA+11bZyvMRIhQ8YEmXqrrMba
         6DISD3ZmmTnKIXB++v9jVf1kYjLEK1rSGK+0aI8oILzh9IoJ5MYJl5vj6xIgK4slqJ1m
         32IgwMI5W8LhNT2YNmFu3ESixLBjGYvgdhztUtWPz1WTIG3kAR6lfq1iXAGroqi5Fphl
         bvOKrG2cXitU7kd9P5Qx5B8XFgyYMiRVxSUfJb7VARVO7qhxqC6Bzmszd+a1ny68gmPz
         yfCnRnHlo00ZZ14GqbWmSN6rUs8R/jdkisypUyDtFRYaerFymUj6PpwJBhLGQYTOwGGU
         eqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429370; x=1792034170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9Uw6ZReSMOu9UuqEeLaMzynTv5QJv73MooXkF1Ett4=;
        b=im7m+89lKCJpHF1BIpqxdUi94Bo/80kLPrULNfBNI5v8gs0DItPDub4SgCkRXh/XuA
         kHjlBvMk98G3JWmwyPbCCimbHsN/YRPf/8yCA4ildOAd34m+GZYIy+9FNFEHwHqClYGq
         JJcekmL33IAMLhjJmVI2bwACTWV4zBNdlZJTHcmS9w1vjrtFP2piGOC5QeIssDTKO7OE
         wwI9M+hFmeqUxJowk+jiH31DAma0kAsV91OLN4z/wKqWSTbFJSdTgTPmtDeQZqkk+FQJ
         Sr5XQr6NWHfEDFDycZ5OgYH33GVXs6YN8gpB04YKR+zCEjr5Pmo3YJpPmeIsjK84Sc1d
         QR4g==
X-Forwarded-Encrypted: i=1; AKwUvBzMHD+YpXZPeRZeYKxlnD6uPcCoI+h/bwPvXPX5njxrAFyAESMw+zknFlr6NgTKvJLTcwA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1sdU7/x6eR2GPLdYT4E3jmKWAeznXSirPDvktTo7gwVSocH7e
	h7ngLQurLODIv/qP3uS0iWrM4SkphWyGsbY61eGU1gz3uOaWMfBdYcLHUx8lLeexZ3lA8IcyOoX
	b6bpFZA==
X-Received: from plbjw19.prod.google.com ([2002:a17:903:2793:b0:2df:4aa4:16d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1209:b0:2e5:467a:7a6b
 with SMTP id d9443c01a7336-2e6003b6934mr35307855ad.10.1791429369352; Wed, 07
 Oct 2026 20:16:09 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:23 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-4-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 03/10] selftest: bpf: Use bpf_tcp_ops_set_flags()
 in bpf_tcp_ops_hdr.c.
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
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
2.56.0.360.g66cac248cb-goog

