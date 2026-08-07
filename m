Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EC2D97B7
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122953; cv=none; b=F9ADBg0jkJZW9WVO19k2/LEqiDGNQE3lHtSCgT81gftJnu1TAdK0eNfmhCy71fKfU6BAaBqwullyz9IUdcD+Copl0J9FaQzH96clRBZKglJSfm+/K5NPIaUE4qEx2nJ5e0PlvQGsY1yjFX2uvXvcS1FKL7HyyXGuilqNSbyPCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122953; c=relaxed/simple;
	bh=mc8Kcpbanc6kRAe3d36YKz/STBTBT7+QMuwxL2Gz/gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6fN8G/g6YXZUIDWB5KGTZO1oWhtvkFDOzLfpfNflt1Vun0al7VoqNTLFgI2mZkQq+CV8mH70Zq3Iy6xB2Es7gqJL107M4zpDCc84RSKRRh8zFzPWye6O9qLD+eDBRWUpQL58A2whe3J0Boc37NF2w3THxl1GjVliy2zebiMU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbFYwmW4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbFYwmW4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so38580075e9.2
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 10:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122947; x=1786727747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzE4FNBfM9pugES/g1CSxQ7z8K7sge5OuzK7XfajAuY=;
        b=FbFYwmW4bdK39vqlxeV/6M78gaZKgFWd3Pn8Hx7ua4SrmO7IbZYidUYM1/WfWp+9XW
         k0xZ8oWqaQNyEKnfVC7+yD5YAGT55mE/pqH+Z8FXP0jGol/WWTivpBnEMZQmPnKri5Tc
         /B7SfXt970Jkag2pYHfz9i0dkT+1xVP5c6cfZHASXq1ONYZYpyAaOR7bCrWRm0XqF1YP
         MzesWxn2UOyRbCkDOLXBf9ARi9k06XKa2aTGVEUhS3C1V8mgzOZOISsZ0pLKTBvqFWKj
         6kKBOLQ9nqr9OrRheRqr5ia/d711jD1TrwK0o0VjpDITy5wKo3f4dvwcCfe+Thh3tFYT
         BX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122947; x=1786727747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzE4FNBfM9pugES/g1CSxQ7z8K7sge5OuzK7XfajAuY=;
        b=j0sj2cAFDBRM2g2ZuVG/EggBIJGkU7gHu4VDKdlxASFcS+erLp0XRSqpN9/dBl0dEp
         4RJi3UZG3vnMSLMchujeR4lvAtMJRbjRDh1Uq6jhhj9+6BxwZEwINgRAnKK0dpzkUSNX
         o8FL/IPvvlh2HiQ4NE9lPbJ82lwSt5m17IhZSmdIFaaaHmtnstanPuWXT9e2/aGNaBpG
         /EqclDuTwbA36Tbp1OhgxsxFQUZhJF4WTggFpUZ01/4sD5Om2DOwqPBtAvuYr7h32upw
         I573rlB0sO/LBfLsO/OhSW4As++rvIZF0smZLm97IrBa9CEHhg5wGXwovQgifRqUQNVG
         lbOg==
X-Gm-Message-State: AOJu0YzqaFMldyEFj6ESnctZpRVTdYUVg852zK4Se5uQeDY4zAUHyV7E
	FYTCss2K5303k0ImedaNbErVfa2Xx1f/sgm11ygYneS+07euNJlH8WGQLXs7AFKFZ+6iAA==
X-Gm-Gg: AR+sD11pfLdZtmuaINIgoGfevvheWP4nyV3xejVrwECtvl3YC791iFQJGV1RK6EGrj7
	6Foa/I6R6zJ39uR1+s93ubOazLgtuYVWYcx6OeRC4G5948EzUL9m2DQOyU3gN8RFhu4w7qGYLVq
	R8mvGX7QHNM88D1eqyxNuixnLdlFSWwTSsgnXtbsvClk6Mo4tV/ZITNQjTuqDsspHd0qiIDlRWX
	lC9Qanh2rn9wXoOIpoy9NrY/kIP1QvsqswbnpFLsTz/sm5IBw5KV/1W+MBE7os4FQioIBjFXYH4
	XFR9gE1I9y003rl7Lqnmj5RUvsrIVTteHfdUWKvplwrPQuyL7qp184ln6ibl5ciyd6wVpa0/bH2
	FODF3D/oWJlhun102hWNeZgywceTqgq3MUNuvCIZdP+M0BJv3bE1RjUUkd+TEN8e9WkZRr3U63i
	qIrLOryAk/yOFXmtGbbUbPqTQFMlPs12ijW7q0UpmzM0yj1CYhwxiM4QSIwgMR5iOvDcJQdKCi4
	No9MOFb28Y7+NEtKj8E1hUl+wEXbzmoRkY=
X-Received: by 2002:a05:600d:8492:b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-4994e7bb193mr251025295e9.11.1786122946924;
        Fri, 07 Aug 2026 10:15:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995d85b96csm27737425e9.2.2026.08.07.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:45 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
Date: Fri,  7 Aug 2026 17:15:28 +0000
Message-Id: <20260807171532.125149-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807171532.125149-1-mahe.tardy@gmail.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
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

Acked-by: Song Liu <song@kernel.org>
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
index 63c69a0fa74e..8f18f124d92a 100644
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
+	err = security_socket_connect(sock, (struct sockaddr *)address, addrlen);
+	if (err)
+		return err;
+
+	return READ_ONCE(sock->ops)->connect(sock,
+				    (struct sockaddr_unsized *)address,
+				    addrlen, flags);
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
+				    sock->file->f_flags | file_flags);
 }

 int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
--
2.34.1

