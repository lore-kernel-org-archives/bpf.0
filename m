Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9E04AD4A8
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314788; cv=none; b=bl+XtFTRRQqtOVpPOXo9kzFSIqsonhanDHKcoWWgv0c55Es+ijro7tXk/rfLN0sV8F0uXaMwvAEIQ8Tag4ug6u+aYRJwEEmbJeigxdEDUj/nV5eZKkxmXqpanj0vGgB/N34tOQI5nAyuC/Vsh28d8VGXXMaIJDGVnQR8+Ndz3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314788; c=relaxed/simple;
	bh=3bImbomy1Bx+UYI0C3P1Damw8NznuLPk7pmUKe6tdzs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gew6Fw8SnuQg+s7+fdhhubMShMEa+RCB0NiscA+r5GmT0g9Z7UrMbDyweBkmx3qyC0AUPzBXMux8AbKlnhe/YArmyvFqNIa3cBgjeHDJMozQ5cSxXLfrC3XPe799PMJ9JJAbgvchqMmpiaxLzPwWT/TqdYLTrQOY0yYKJvhbQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PatqJMLm; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PatqJMLm"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e5df3b58a4so6570785ad.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314787; x=1791919587; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n8ceNHOoiaGNrICuagOz0HePQu8nin8rJueIIhtOqUQ=;
        b=PatqJMLmEPB39SzsN1U6FjNrRG+CpGLuVyIH6mQtwwlXIQClxG4Ktd/GL3YZxg3mYb
         u3dUbrjiEY8WEes3jLNhTI5sXODyU5ve6dPCgKXjghjNgSLqprx9nHo9hNiiKujJoZNK
         KUr5EueJ3s8JWZrTqK17kBGFpyt3iocLsCT94KewRJg2YUf9a1IkZxhWeeWCjigMSkig
         7bnqgt8uqyb6MSMGAsUZsPtvPjhkINNy8Rx2Bu4hHYvONH5F0AedO/AbGLP2Rd1qjpH1
         yCdfDzv/12Uu7VjHIuPrd1y255onaBLDqPFzOYC3JgcnxWuy6y50fHTAM5OlBcOQx4Zh
         CP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314787; x=1791919587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8ceNHOoiaGNrICuagOz0HePQu8nin8rJueIIhtOqUQ=;
        b=oVzRal6r3wqrrOLEQIImrxdCnbC16Rx+kpjl3XMtUwOCrL6sJwBE+TZl5laMBaBjkB
         H1fKz2PSObiR0JVIsTIwIZaAwBUrUgCK9/UOwYtIvds8U0OSM+OXmYMYK4ZbAn6XYzoa
         t/uB6elh/+igm6qz6xh2NFn1tvK97nNGMA5FSOqvOktVjKNQGQyGkXNxsArfM0ez4DOF
         fELXyjXzTwkQa49CS38r0B/8wALrFzxOorYFESm3Okj5gHLMH/iVSV3zM41J9HY10FQu
         obB5OhHyjexMUam/iUf+f+2k5gQAAaPGV91RA/jSTibu6QMhdI30Q2TAz3dtSDwCVmOE
         ATYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxb+sVYFiX39+pmF6jqA65GYq72Yg4wZhC+4/WcS0aDXUZj1Kw+CCpOUz6xgCdnBaqxL7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwDkhrxnz+KMe8kU0bgF+FFai+HJVm/qllA8UIOuoIAuZ76Vba
	rKQy1jpXa/oyF/LI6dqR1E5dsJjP6BACjinyR+A9ySL+UuALJXUPsf/FtukCB6RVQmefAqhrgvt
	rS7H2PQ==
X-Received: from plhe8.prod.google.com ([2002:a17:903:1c8:b0:2e2:cd01:aaca])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:2e2:e3aa:7a35
 with SMTP id d9443c01a7336-2e600500652mr3004675ad.36.1791314786385; Tue, 06
 Oct 2026 12:26:26 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:34 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-9-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 08/10] bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
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

The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
to bpf_tcp_ops.

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
so we should not allow calling __tcp_set_rcvlowat() on MPTCP
subflows.

Let's disable BPF_TCP_OPS_FLAG_RCVQ for MPTCP for now.

If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/bpf_tcp_ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 9a6e1c47d7c0..8182037c4269 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -347,6 +347,9 @@ __bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_sock *tp, u32 enable, u32 disab
 	if ((enable & disable) || (enable | disable) & ~BPF_TCP_OPS_FLAG_ALL)
 		return -EINVAL;
 
+	if (sk_is_mptcp((struct sock *)tp) && (enable & BPF_TCP_OPS_FLAG_RCVQ))
+		return -EOPNOTSUPP;
+
 	old = READ_ONCE(tp->bpf_tcp_ops_flags);
 
 	do {
-- 
2.56.0.360.g66cac248cb-goog

