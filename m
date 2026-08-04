Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C447DD7B
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862045; cv=none; b=RoFqda+a7i1Ytt8Q1iZz+VgxWzCTCbI0vEFgcTFzHr0gBRZT5XZTU1cQZwRiwDojhZlBgsRg8unlPtGhzTrUC9iNe7WoDMlcV8bN+0nnzF3N082iOiRaptfd5LhMDdb0IvWjYkKrV74zuU03/c12jJk1Tgmfq9B2oLXw7SlRRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862045; c=relaxed/simple;
	bh=XV0B/JhCsG40H9ag/PHxTNYCI0x+JONwkI59bxqGKMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l31trYPErtDJyq6pXuYKj0RoEt+FPlTHc+AwOPn3LHyfHLPJfhU8B1e8KMexRA6xoOd072D4Cpp1XOdQE1ctiw5gqOo0SIXizt+uqp0DqzQkQyKeTLQ1Cd5SuV0JqYJoe/QlsNl9fzOCRo++QL52lIvE+LgTX3FiShsMbLlqMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAT5shlp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAT5shlp"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4956869750eso129945e9.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862026; x=1786466826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=FAT5shlpzlKMdMyn68N0l2a8Xtqxu1ZS0eYBJ4NyrLfkd6PFvObcpXzHZepI4YudT3
         K0G39a3nFqrhnrq8KHttO9o18HOXHzYY9Ep0qguYZ091J9R2Z/ozbXASlvYLp1TIV1is
         9pq9SgGs6cdjyigWagzFNW/YjoRrbl3fTo21bARl/PSRVNPEpH89Nqfoq3yLpHl6O1rY
         6B9MDc98xc3QBHvwMfgDHPvlL/8B8Agt+TekLEBCWHbLQRad8SxKoN9dHhmgLyAOYsEe
         rPkczLw43Ltm3EFORizcwn/L+ZIR4a0r9w16V0XFxj9LoQXmQ/RK7WRqsET5WCjGijWQ
         1zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862026; x=1786466826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rwrdJxGLamDKuaEmMI5UrE7st//n0E96F1Xn4wpyT0=;
        b=ez/i/ox2IoQT5BARNKoMblEtQOnWpnMqkoLZtdaZOS2+mfHqYJRih0cSHdI/OkjBbG
         dnMbQJAPATI9l23rGZFfr2Z+mu/od5AY2REyyTBX46wAV/LzT7djN10XYLZKyfots/QW
         orWMa9nZSMt8RUjrkNzQRjQ3jumAl6ojUw+rGctq8W5/8VErP5ztZB1+uDRKMoPSeH89
         J8aEhwvpvrEu5QBkIhdxFniOnlt34O9upGnkGwR5GpwdZfly+7VZRIbXw+D49WMClqbf
         DmkFlhK0iU4JJfmJJJqhKKiOUEgY9UcgwEmP/yAvGH1rWDi1xSSsxZKdGUWaDyp8qzHy
         wUUw==
X-Gm-Message-State: AOJu0Yw5OgnJiBRgZWs6FP7yPM1aaNdNmf61f6NHIFg1dnb41ajgk367
	N6fsUjSfFJVqVttuqmER/GsQYpKfFr9JFUKZmsAFfPkAUr4BrgenH0zLQSg5uJ7mIl8=
X-Gm-Gg: AR+sD10FtvCCnVPDddZ1Poq8wuu2SEegNgH+Ah7XinoX0dCLbJEx4a5Ypz7ss3wwLxZ
	1eX3dWlzQKCQWSrPIsvI3CyZqxiiwFk6niehPrJ4QvJveuWNRSgh1YR1KRXFsqG42qzGIMbRQH+
	5kItb2lch+pRb1Jz8y1jL7j/+45rAG7nJrADv7etdc1xsBuvm1MaYBhnZINs9sxS5IyvSvtKuLL
	buneg2N95E7vJwDgIp6L8y5nDthTWOsUhjGJwqw7FasVlE4ZX8TGznGmj2UZaDKQJBKUK8sJUfZ
	oZunH1XndhgkxyNbNqRGVUsCWX9OYyYp6Zlk7gymyu6a2g7OVOmeqDO30EhapZE7HOez8OJC1/x
	kroP9jK6cVh08RxeB/APle2reJo9smZtlwaEjco+yURxY24RxHjkIgaIXYe91y51OTwUSS3EMTO
	Sr8TTmTxJSD/FRb/Hnyj5gNQjs8y0ZC+IwE7gDdccbDQy6iXL4qk+xLvnQWMrETAhdzz3UT/TWn
	uf21GS7r+djtN6z9R3nK9aYw5pp0hjJag==
X-Received: by 2002:a05:600c:840f:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4980c64520fmr314174835e9.2.1785862025962;
        Tue, 04 Aug 2026 09:47:05 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/5] net: Add __sys_connect_socket() helper
Date: Tue,  4 Aug 2026 16:46:48 +0000
Message-Id: <20260804164652.296919-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804164652.296919-1-mahe.tardy@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
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

