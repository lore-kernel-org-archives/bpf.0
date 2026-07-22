Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629A473C7A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717105; cv=none; b=iABCBkB/+iA8rjK7S9/mXLu+R2qpuA8Y3wLpuK+ljwvwYy2ZALL+s1NPOvaNzc1xk/XU99ev3D5Zy4exlcDD9Im6flYqX8LzaEHm16wNqH48+IXn/Wr8O3iQJesr4cuOoB1cLxHt8iXJj0qYfgGm6E0w7PZQ70oUkjMp1jiYRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717105; c=relaxed/simple;
	bh=XV0B/JhCsG40H9ag/PHxTNYCI0x+JONwkI59bxqGKMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7ZEfAZLdvYTB+s/lhChVKcHxuvfqeD7SUtDalp43kOa9MPnv9hHA59Qvf44AGoqbJTfijyFXrTq3sVjp2VtSb9/H54Ma1WvRZY2jVtUaMAvowjuqozZugpRPnqvFvEjabl3O3nbQEnkW2ykyQq6ZhsG2C6XpQZpXHR9j/u6nBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alR4KjSs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alR4KjSs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso39828215e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717102; x=1785321902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=alR4KjSsUvsyJX4a8y8F563m5nzXLxi72VRfFHaPwqWzYs7fHOoe01Y1W3XW8UVToR
         lUUtg9vZgOLnVNZ3lJREr/6e7cT2vq2GZpJ+iJx1obmVdw8AQH+RmJNqKHs75H634Ozu
         m3iyIT2A/w0GKQeqHBhy+gHJ3dYk0PPdIK89Z6jJ+e8Zl/yjKHARnDCUCRpkkQOmb2sd
         mzmi1OYYNM9D/w7y33MjR2y5DTuL8NMZC4ZwPCzSrFicRSutAECqHv8H5IdqERwNXUcp
         Ag9z/CD8xtQYavsHTy+NoQ5ZF6D6G4yIahztG4I80MEcemViybW589nY0NkyHVdfg97V
         B/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717102; x=1785321902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=ICk908x7/VxVVVbyn/+QlvrbMX1rZZas3WjZBi8JyJONs1a3xhGo7jCIZbXKDSxxWO
         jV8K++H6IGrwjJkEpn3FvsqpGxucIuNiEG0u24lQexMZT1RRzpC7GmZoocO+VdUYTj6j
         3hhPSuKrs1ZfLSrf5tx1LwIqgrYxnooIgxGYgXkbG3MR0RVkcWZY5/937b/f0LcYGXAd
         HlbSdULAJkPdQzwnbbQId5zRKHi1jcG0h5eP5pbedBZW7O0T94E2wVsCcdJgflpD43Ts
         EvoU7zxEfdqAiCV7iXaw8ZkFlb7rOI1wxsG5tKqg9cICHc6Pa64xrFKZghx0+m9lcEdb
         858A==
X-Gm-Message-State: AOJu0YzC8QKE9oSbe/Ohybc37nKJwSbmAS0wloTw9WQa4QgWy9ccKKzn
	2eYwNekxihT7O9h1ZATcN3dmKaVxt/P4mliQtxQqzXG/9R2Xc7Hsbup8hHO/UK4bj/0=
X-Gm-Gg: AR+sD132IdtZrLrGWY8BAQy6194BQOFQqXrjdeuIgla1XHvVAs/uXhtP+EGn7LdZerb
	v3HD+k0XzFnxzVT9zOTl0sO7Y9lCZj1l3ROUx95xmSGPNn0SvyUs3wkkwrwQq9tGhMhOhjs1p1U
	VrHj1Jp9dxPoBdyh+ai5NSHVQuSM+PeGb0j/YySQfAWu4Ub0WkWz9Mjd/MxMiaRRPnb/4iKAL/a
	pk5UmbJttV4MHc4MIzp7vjHTB9MCEryEnoSn+oaTHTvBy3KLiQIuArvsByydI6rhOQ3R+VtQduF
	rSPQVcOT9SHFE1J4b3qihQYuUSFi1a3bIdwbgH0Dji1m6R+bpB5S76l8F+wsyotR2J6zdnbcqlT
	FyH+UAtXPYuSAt8TlxlslymrS1V8+4fyHJg2A8ySZ4Jw1V5yehNGaVIEDp0O3/+9OmSFS/t5I9X
	FIyx69ab1HsbvOGIZsQtvYRQQwCrUyay2lCBlUeRLvNG7MV+Ze6F7cYVXYuw==
X-Received: by 2002:a05:600c:3b88:b0:495:4d2d:82f2 with SMTP id 5b1f17b1804b1-4954d2d8335mr258235425e9.26.1784717102050;
        Wed, 22 Jul 2026 03:45:02 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm111090575e9.8.2026.07.22.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:45:01 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 1/5] net: Add __sys_connect_socket() helper
Date: Wed, 22 Jul 2026 10:44:50 +0000
Message-Id: <20260722104454.165911-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104454.165911-1-mahe.tardy@gmail.com>
References: <20260722104454.165911-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper that connects an existing socket while invoking the LSM
hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
logic. Other socket operations have equivalent helpers that trigger the
appropriate LSM hooks that can be reused, this one was the only one
missing.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/linux/socket.h |  2 ++
 net/socket.c           | 32 ++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a8d7b14f1d1..48f1eb8193de 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 			     int addrlen);
+extern int __sys_connect_socket(struct socket *sock, struct sockaddr_storage *addr,
+				int addrlen, int flags);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..c7427dd4dd52 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2115,27 +2115,31 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
  *	include the -EINPROGRESS status for such sockets.
  */

+int __sys_connect_socket(struct socket *sock, struct sockaddr_storage *address,
+			 int addrlen, int flags)
+{
+	int err;
+
+	err = security_socket_connect(sock, (struct sockaddr *)address, addrlen);
+	if (err)
+		return err;
+
+	return READ_ONCE(sock->ops)->connect(sock,
+				    (struct sockaddr_unsized *)address,
+				    addrlen, flags);
+}
+
 int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 		       int addrlen, int file_flags)
 {
 	struct socket *sock;
-	int err;

 	sock = sock_from_file(file);
-	if (!sock) {
-		err = -ENOTSOCK;
-		goto out;
-	}
-
-	err =
-	    security_socket_connect(sock, (struct sockaddr *)address, addrlen);
-	if (err)
-		goto out;
+	if (!sock)
+		return -ENOTSOCK;

-	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
-					    addrlen, sock->file->f_flags | file_flags);
-out:
-	return err;
+	return __sys_connect_socket(sock, address, addrlen,
+				    sock->file->f_flags | file_flags);
 }

 int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
--
2.34.1

