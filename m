Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577623;
	b=Q3Hvdlh4QOzftywZk3IdpKOqOJwAGg7xl++VdhIlGUFyvlJPiqQVa9+8A8U8E5FFvrL7
	 f7eRe0ZZ9wxZNO3VcoMcvCK/eisHQ+Pok3GB7pdDKKLkgypryfiJyPqtjVkABOrP0F7ud
	 2mwzITG15IFiPGclqvvE+ViS2SaRpzJe6u+UI424Kswj3J9MR3kNU5iX2Zz8snOSWWIYh
	 Q43KfIZPB3qNoX1WmqTm2RYOKehr5q7ooGp4XrHBhgDNWs8Z7k1ilrLAT41j4/PdWuAn8
	 IHujDbesJmD2XhCdNmXa0GiWXDp2dKMxIuUlsJZMkw/4ez2EtaKos/vmqJKhO+CmB6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I7VVNQb+CMXSEh7yNtfPHJ7+1vEtiXOGdD+I/0XonW0=;
	b=ZZ9jb2FXQPkInk9lrdshXZe/MV/qDaxOAGeBoL9Fbd7uuKyddVjRBfES2Uyox8yEyU5F
	 TKyveZop2Wi2m2zCjkg5C13kKk9ozrl7kBUqj9ObVQjQE54iSXQs6wX0WNBdQP5eh9X3j
	 HQghArn5+GVDIVMqaFy1psrAYTvQdBmNiOysybVbVXixvm5m2BA3ai87Nq+iCoNxNuohI
	 Vq9rr74uh0uUjXVhiXH1P1nJmxIJbyUBaooRsoyTcLx8DyAtNuKyXUNV3tza1GECPob0s
	 n2q6d1Jl6azyyeEjC3Ymy2gSOysGzNzWaIeMNT5FSIdZdVx8SVAUoY6awIzudo4omLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yE/ts8qZ";
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E029A606A326
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E029A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yE/ts8qZ
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso3252318a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577622; x=1796182422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7VVNQb+CMXSEh7yNtfPHJ7+1vEtiXOGdD+I/0XonW0=;
        b=yE/ts8qZn5PPBDT+G5ZbmeFzg1HApJsKynSgn9Ou7Lf46rCUB5TmcfjKs9GrZMSCkY
         gOxjKdoZ/yT3QvZYu1ugkM9b6QT85SYEr7gQNy/yYIXtNFyPgxGlMyMqJHbwRtnUSSGa
         60h/1UVhSnha3JzlwQBXZ+TKwl4Eqp/QIayyffTp8OPnCkOsWayvrTc7QH3qTPwlEeus
         OBldseZOFnW3eqJsAOHsxpYXTL029JO1/r0PaURSRANV1bg9G1jQj4HAEGKnLaFQ/D7O
         q2PHrm8NTj5CQjeLgPrPkqpsHVKp6++wnb22uyG5NBctJyzQ0coKDwEu2cT9fOEu6hVF
         D3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577622; x=1796182422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7VVNQb+CMXSEh7yNtfPHJ7+1vEtiXOGdD+I/0XonW0=;
        b=EHRZ8zGIS1l5cfko9xn73G0w9WiMhzAUPm5k9IsG+/A5YA6WtkMo6Ix8FIgr2XYOjK
         sc3AEjAp+XMsYZvx6bXxBmNjAzTSkL0fikQ1aTurI3th84PYuqMoxwDeC1qRdKAfGW6R
         Z3Rfhixp3ecBR4U1i3p/HgEFISJEX2TgL4DVLjOJ5UFpm/afvGyPTuLOZK2yqKejC+bg
         qH9GRF11Z+NUy80IDDcfuuGxZI6qkCvgbQqXJ4QMZdvzkjL0Ua6nZpAAMrWquhjmTeqf
         cyt5k6r2UfYY8rDBzavjY9U+ipSDVABb6neAaPkOiQKerrRMMRYrO0BU93D4GudaIzD+
         srzw==
X-Gm-Message-State: APuU4Z++z0zaa6T4iraketSB94/0UYwkFxPNA3wr/5LVDQAm+h6qno2v
	6+HWKrC7BCLFkaE8tgvzoRoAXQ17DiWCl1cFvw9B2XkX7aNIOUO/sGmb3eR+NvMn
X-Gm-Gg: AZFdTZcMGbFIJJNi52l7RMmm6rDybyGeKMaZ80FhtI83d9fTloraQUgZNMkU2IsGLwe
	19KU1Qt0vmCd/FckhNFxTSk7xsS960o2FGiizQZYDiLMg0eJljB66jk7lM2KXPZcVCoZFOEEOc0
	Z8H3hIFe0h9+y2CYafKVocFPmSjn5105iT4wNyozH2We6JpdPqG+7lW31n5lnKnI9yl5Qv0crJR
	j7KlosmQwhvnrLLSEoAYCUaeZ5JxCzSxwLDwb7XeCdiGm2dBrIKhn4ckP5cyi0p1tKZ0JKbDmng
	7TR/Hm8SH5X/e9dZ3lmXfrNsNgwGgHsJfVMUZSuZyqhuOFPkaydJaoMOr7piQcf3tnp3MZS6kr6
	qMrN7FA60uiSGNs/OpEq3XL/F8qLtE8iKOCjCU2ymOSilb1elPo8AHUjRcd4Luk5sUp0RBadF01
	2LlIWvMjXBgmFnDpy2ts/keBn4I8WTuSQ4KxMhqjZZN/J7T7WPlWXqd65iZjCSnCVXp6wNBkM53
	inr4y8TnbK/DbZixOQOp2h22fcpUYhXjQU6P8EqdDD+GkjTzzTLa5wAEMWTSFoJ9oVtJmd/MijV
	b+HP0TcxRdILnGU0TcJjFe5gTDTOtVnUcmY8owbQSofKNphqvwa4JJnVzHJxtjOz9xcWZ0UVNMJ
	PEXHlrAMLAJLebkc3yUQlymjG2GdOfE1zg7l32R6mfk/dY8T6FtnDIz99bJCf0t/ZyzKWAs40IQ
	==
X-Received: by 2002:a17:90b:5543:b0:3b0:a1af:e4fa with SMTP id 98e67ed59e1d1-3b41c9e4290mr16455186a91.24.1795577622247;
        Tue, 24 Nov 2026 19:33:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d1361fsm27952137a91.6.2026.11.24.19.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 41/47] bpf: Clear family and port of a short address for cgroup sockaddr hooks
Date: Wed, 25 Nov 2026 03:29:32 +0000
Message-ID: <20261125032938.670542-42-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

recvmsg() from a unix socket that has no name leaves the buffer of the
address as it is, and that is on the stack of the kernel. The program
reads user_family and user_port whatever the length is.
bpf_sock_addr_set_sun_path() sends the family to user space.

Clear the bytes from the length up to 4. Write AF_UNIX next to the path
in the kfunc.

Fixes: 859051dd165e ("bpf: Implement cgroup sockaddr hooks for unix sockets")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cgroup.c | 4 ++++
 net/core/filter.c   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4e388d994d80..1ff030f4314f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2010,6 +2010,10 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 		ctx.uaddrlen = 0;
 	} else {
 		ctx.uaddrlen = *uaddrlen;
+		/* Programs read the family and the port also of a short address. */
+		if (ctx.uaddrlen < offsetofend(struct sockaddr_in, sin_port))
+			memset((void *)uaddr + ctx.uaddrlen, 0,
+			       offsetofend(struct sockaddr_in, sin_port) - ctx.uaddrlen);
 	}
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
diff --git a/net/core/filter.c b/net/core/filter.c
index 97f5d60ec817..eb6aeabb410e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12633,6 +12633,7 @@ __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
 		return -EINVAL;
 
 	un = (struct sockaddr_un *)sa_kern->uaddr;
+	un->sun_family = AF_UNIX;
 	memcpy(un->sun_path, sun_path, sun_path__sz);
 	sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
 
-- 
2.55.0

