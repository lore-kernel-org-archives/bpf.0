Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77105393DCD
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314784; cv=none; b=vFF0qzArgo3PNFKR3fBjtJ7knhyFafOoXKMRMatPiFk+3BcWsMC3lOD0wW4X9zcL6vCWITM6fqYNk2ZrJsFbwufystLlVq9MaWlKWjHtpxW2X7fYGaZ9h1y6qw33GDh6lVsPRO6khf99w9mcBdQ/lr24ztOgj9RxvnN/ZeheGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314784; c=relaxed/simple;
	bh=EYQIaZ3A4q0ebofoa2tPMojl/Yb7GuuRT7cG/iAa0RQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SicZOEDqkMVqq7YfoX7GITm3cb3V5P9D7Q3D49MAnXAM5N/GBahVPYIXP4jkEenVuqj9Riwx5yvYbVVfT1+EteoQh9C81h0Hs4ZH1Z1ZVRF3WOSbX32jZ2gTWDc9bZrvcjx62dLwVBj9SDSH13nPCysczYqOqKjPVkKluSPJkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nA23rtAg; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nA23rtAg"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so2187222a12.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314783; x=1791919583; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIJViJbeZ2d0tGGmC71/G+qYvIaVqTh8ul3BWVuPZFo=;
        b=nA23rtAgWoTLtwGfEP+RFEfIpQsJhG4sHbILdVLKxwCJlz+p3W0CEVrak95qqIWRtV
         IBsm6ONDhl71DwS1lFVVKQqPXf8zDaVn8/Hx5CF8lz8F0wE6oOHSGgoV/ocqDP/1kC6+
         l7gmMzkG3xI3LrIk5+sCthwX0ogRTObr1CeMPoih8QPb1he8IHtJULh9QtIfSCl0QS/J
         hYayuKwzQP1xro3tmnQloJVTPFrHmsY4SV2UbUNCIpRxjKorQYjW2TuK+6vgaSqUCC5I
         rrviJyouMOI3yODINsZp/eKXrP94mGFO3b6uj/ZqCbhfwcf+SpZqeDFed3pSYsuj5EXu
         o1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314783; x=1791919583;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cIJViJbeZ2d0tGGmC71/G+qYvIaVqTh8ul3BWVuPZFo=;
        b=YAVjnGncjj64ColDQCvqSA2zBz1L5Bge+KPzsBBmaspPRslY6xQtP5o6uT+AC+msNz
         GhAXqWVdsf9Wkno1SqSd2U5yFpQwxHphKp/Pzv+n3wyk2BX/JyoHTGzkIz2kv0cpJA19
         xEdymxC1v2VhN3fBN8rX7wDYTG7hAfQ7Pyn4lXrK3qNObMbncyWrYTt/50rj28EJgb/M
         he0KOVt/LRJYFkCjqsmMSekjQh8uKk4PfWvJeej44GHFyrR8RbM+QWkmIPSEUTqSapKY
         JLiCxWCO35ecS4BpuDvcrDmNkb4B4Ls0ZxwpvNwJOR3laE5SSuCqTw783gjkYi88TeR4
         Rk+Q==
X-Forwarded-Encrypted: i=1; AKwUvBw9cpL7QyAWYfgIh1btmsJ9JSJmuq0FW8BGO8MpZbRuSqdA5kUIdFsNFmJPX48JcqIV2bI=@vger.kernel.org
X-Gm-Message-State: AFuF++nPSWNRcocxidwcMr1ZAv/dNdpQbYBBIj4yXG96utDhFrhTqUHQ
	3c8I9pfEni31DYzrfuR4kkY2P5zdGAhVKXe6AFJaibFT+1XEIwmsgheEEcR9NaPymLDL4J9tHcu
	mkFWmPA==
X-Received: from pgaa3-n2.prod.google.com ([2002:a05:6a02:6483:20b0:cca:dcca:4599])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5493:b0:3dd:9483:48cf
 with SMTP id adf61e73a8af0-3e133d96f5cmr81553637.6.1791314782473; Tue, 06 Oct
 2026 12:26:22 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:29 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-4-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 03/10] selftest: bpf: Use bpf_tcp_ops_set_flags()
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

