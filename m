Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02D3A5452
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435985; cv=none; b=sqG0NvzRQxDstmVX8VTrhziajx139n5HBDz7Y/N1ErNnzOlxCczIhiNn30vWFBMP5QjeSVOVy12b5QL+R6gD2u2jxPgyx5yR8lYsdrvPH0nWnpG6jtmF3eog+qk1Dgto3NdfZ9iQXoKCF4O92vFmcVQLky5AidC8eNL5mpMcx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435985; c=relaxed/simple;
	bh=dc3cyu+G96Uz0mDs4rxrvr4WW2uo7W5uvC1JD1XZ3SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A6NzOvZWH6sfD4G3mAcG9Fmn6mGrwPaPxDCEaOlol45Xp+l+TiIKIUArJY+f13eB1x44UyN/GR9mvsgT+lVjMcRADvp+PHF8uWNH/YaNayLXNi+b27tMqxegSpsWYHDnquKyK8A9mY9eKWXZVD+U0BO2oa8asnUC5IyJNAABe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quU1R9h8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quU1R9h8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so72057525ad.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435973; x=1780040773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=quU1R9h8YkiXnbJ5Aov05DDXZ8WitU2kE4VXWfEnYj2mYKwzKLQCJfVAhvyDvi6AST
         FStpBjjQMrWvRy41ZccKcd1YAnivAmrj9IE1wI8az8VXm758gYEHhbfnl389o/cHPTmn
         wahROzd+QwkI1LRmqpCS8hXc3ufWsb9P9Yd2rFTOTddDJ6FwbzJbjUkxJRbyhd6+1Ong
         atutJRL8oSiPwDazqmx8ENhn86sS2ZPsVzRTtFJVJONVHQOrY+rjibCOmZ1Ikd5dr2SC
         /1bdD2FoGBbzFOyqS+16pNSWZVXmEve0I3bgtYDTsFw7AMXFaAUt574+vg7Z/2ErD2pI
         1H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435973; x=1780040773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BrgoOQVhpg7Rxx27XWaxTVhF4O9VIqN8X5Igv+HArY=;
        b=Op5RuSqfCktl+UuyctUaGH1whWNoKzwuDcz5zEQK4WrRcD29U4MXn62bPR5RjyTkPG
         YQay/LDPBzO/HKH7tow8XgwqIY9XpjbC1b23P99hQa1lQoOlqNl5pIHsPHbBoxTW5/y1
         agqcOCVs02ZIxFbEPdRjTic2QS5O088C1KlabUMkb3y+c5xjPJNPONGU9suXe95RDyyt
         W0fQeLO+VxpVkh2GwGQbVX+SVNfyUmTO/Vn6MhmYn0YyLtzKIGbUZcU46EOVi/UedkYV
         5EC0s7yFb1afok6ZsoebilyntupNxaSOeHNapZA7tEC0bnBsAcoz+oK+IXweBfuPj7Be
         aB7A==
X-Forwarded-Encrypted: i=1; AFNElJ+C1+fbnI9W9un1rUjmWE3AcgqMGwb89024o9OyToKXU0mYSe+HXbbRage36+MmO3Kh6uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnq2TGQJmDoggZsml8n7j5tsyAkb+imgSkysvBU9H7uh0Rfzw
	+mDR26snYYfPiyEudZ+pETyPmHmyKZt68EmVC4jxtmK7Z25483CvSyZuguLcOgFWB9AoRW4p5va
	MjplfRw==
X-Received: from plcd18.prod.google.com ([2002:a17:903:2092:b0:2b9:a1d0:9f13])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffce:b0:2bd:d97e:724c
 with SMTP id d9443c01a7336-2beb07498dcmr24548155ad.13.1779435973127; Fri, 22
 May 2026 00:46:13 -0700 (PDT)
Date: Fri, 22 May 2026 07:45:00 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-10-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 09/11] bpf: tcp: Factorise bpf_skops_established().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will call BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVQ_CB.

It requires a similar setup to bpf_skops_established(), and the
only difference is the skb data length.

Let's factor out the common logic into bpf_skops_common_locked().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9760..c4ba4f1e9d9e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -179,8 +179,9 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 
-static void bpf_skops_established(struct sock *sk, int bpf_op,
-				  struct sk_buff *skb)
+static void bpf_skops_common_locked(struct sock *sk, int bpf_op,
+				    struct sk_buff *skb,
+				    unsigned int end_offset)
 {
 	struct bpf_sock_ops_kern sock_ops;
 
@@ -191,12 +192,18 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	sock_ops.is_fullsock = 1;
 	sock_ops.is_locked_tcp_sock = 1;
 	sock_ops.sk = sk;
-	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	if (skb)
-		bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
+		bpf_skops_init_skb(&sock_ops, skb, end_offset);
 
 	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
+
+static void bpf_skops_established(struct sock *sk, int bpf_op,
+				  struct sk_buff *skb)
+{
+	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
+	bpf_skops_common_locked(sk, bpf_op, skb, skb ? tcp_hdrlen(skb) : 0);
+}
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
-- 
2.54.0.746.g67dd491aae-goog

