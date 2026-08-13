Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2746983F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619169; cv=none; b=ZGBFRsQp43PiGghWLDSQj6BdQf+zniCGa/YjDElOtVE6f6Jre4+/6kSRCgKxaVZUygoHDRkoW1uOmuw8wC6aVaKqJpHXJZL9okJYFQz8Y75Wm9MXtbglbHVpkE47r619IxxTg8Y+SsidiWhBFIKUWU/0wYivNTlYhyX1p+T8IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619169; c=relaxed/simple;
	bh=/yYGJkeLFvj6Y/LJGIkrIrRkkps5bX6o9nrpAAlAySc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmxuKZUZ0TKitTbx1Af8INKGn8DbOJ6D12jy4tn8aWpFEr1eACjBe9UhqcIfgmBCFOWQf5A0nU10tOxP82zLTxFF6s7BfCh0AGnB3twM9sdevbkzHgvhjEZYCDER+1/KhaKkTBS1X1V9xKCkxzaU7A4JKLxfhAJqq9Y56tSEXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzunGJa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzunGJa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495590dde14so24079505e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619157; x=1787223957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qkGJ5VeeBBVHFBA4qv8+apvvRtJwiCLF/FlNU51i34=;
        b=JZzunGJav6eDfwvMzG7CP1bp/ZbjIIgObe49lf3IRc4SxfPR04OwyjsucEx7J8UoHp
         bYjpxzM5sKjHR7QpAirBZX430WG/U6jKW1fp/0JLcrPZWyAC6d7BzaKU+Z3i7oxKorjY
         +n3/1tq3ulbFupEofPifbJJCR1Vd2X9PkslIwdLO5XZgrEg58xCcmbaUvlvMX2aSA2fy
         LMJaBO+fTAdckgbXk4zn6xcLgNXigHaumcKb398DC7fgyVK18UZn3htDelM1gSjgUE02
         4r/Dnm20qa8Jfrgz57m+5Hg7dCtk9rKWk7jo/xmEFzPcUJtqYNtXk5nlBOimPNcWf4hg
         QSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619157; x=1787223957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0qkGJ5VeeBBVHFBA4qv8+apvvRtJwiCLF/FlNU51i34=;
        b=I3dPh/cW9ude107mJcPCohlF8AfxB6aFpl60hzzVZotxjOpliJLjpVlWtS5IUc6muB
         NpvCH6T8ELlHRvHBFx9OZR/ZSIFas0GbH/eRUgaBz6FoI4xj142J+E0Tn4QJgqk/EWap
         PQawOJOe1+B2isJlHXNMGjugZyfAlFLvnDHAmeQ/T3tsX2jZ5g0EzFm3TRyORGDjFQYA
         HSIWqh49NIQfmHJq6OXA1+XHO8ayW0FeIWUPy2NxBdAgAXio3tYqp2QsuEhyCeLdrKsc
         rPPCgguJaVf26cydQjhW1kmii30bdSHauQUN7x5/W2AhC/EVuP7+2QnK96sJfIFZMhxk
         M+LA==
X-Gm-Message-State: AOJu0YxpL/bfU854cEu69UU5TvF91Oe5cICSv1wwvjdobZuoMUHkVrgP
	T3za6sSktLnbejsV5JQbzegBxd3mKAkHqBWBWGzTMnduDBnri5/HJ+cV+9e88E3LkFZSNw==
X-Gm-Gg: AR+sD12MT7+8yRpIZvBmHF/x2ZHz67RZh0rOG9LE8a2RSm1RqBBn4mNfI2Q5ovx4t5B
	e9EEXZzGGOIm9NOc2gadhOA4WBB082Qt42PIXWbGtKtYtAK1SNHQCoY6IAYK/bcILC94T/RunS4
	cs/WuZf053fG5oES0ugSSCsi6Pft4jUnlT5cp7MReWjXp7dM1R5RjLqs0JMQNzjFexz37r4PatP
	9oBSAiOeCfLAC7Rorg8BvAZzyGNT3MCGp82IVmPagKmTj4CMSlTpIJzE3dDqTY6JTLUiUCHHDzO
	mn/IBy8m64NobFEuWrA/svx2Qvk+8jCMEYibHiD+P30a8e2CUjSnkpc6FRLOC0NpO+wy1fqmJny
	Iv3JUWZMKKtZSzV7SwsuDaiwr9npIxqsOMKswEyHIZjIyeLPQeJ72BA4Q/vzOdqvEw4b1GfGw6Y
	soYYaScXTqT6LGL5aQY4gMvq6iBBimkd136gKc1n7xQ2zaN0dT9b7gnyFvMbWvVTSCzOcndpwxF
	8MAV0DzqbAtozp/+iKCOdli0g2aDqJN3g==
X-Received: by 2002:a05:600c:820a:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-499821acb31mr62643955e9.10.1786619156704;
        Thu, 13 Aug 2026 04:05:56 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm93841285e9.8.2026.08.13.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:05:55 -0700 (PDT)
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
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v7 1/5] net: Add connect_socket() helper
Date: Thu, 13 Aug 2026 11:05:36 +0000
Message-Id: <20260813110540.103550-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813110540.103550-1-mahe.tardy@gmail.com>
References: <20260813110540.103550-1-mahe.tardy@gmail.com>
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
missing. This will be used in the next commit for a new BPF kfunc that
needs to connect a socket and trigger the LSM hook.

Acked-by: Song Liu <song@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/linux/socket.h |  2 ++
 net/socket.c           | 32 ++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 2a8d7b14f1d1..5a5eb1250103 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 			     int addrlen);
+int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
+		   int addrlen, int flags);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..5b02e6217c68 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
 	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
 }

+int connect_socket(struct socket *sock, struct sockaddr_storage *address,
+		   int addrlen, int flags)
+{
+	int err;
+
+	err = security_socket_connect(sock, (struct sockaddr *)address,
+				      addrlen);
+	if (err)
+		return err;
+
+	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
+					     addrlen, flags);
+}
+
 /*
  *	Attempt to connect to a socket with the server address.  The address
  *	is in user space so we verify it is OK and move it to kernel space.
@@ -2119,23 +2133,13 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
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
+	return connect_socket(sock, address, addrlen,
+			      sock->file->f_flags | file_flags);
 }

 int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
--
2.34.1

