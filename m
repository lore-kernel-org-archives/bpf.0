Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2136F905
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040567; cv=none; b=sDXjuC6yAUYujoMbJubyFI5YrSbrk6EPK2oGVAz9fvpKQ45ojNVcs8W0a+Y4WicKgdIBsdKYI0bkeUIPcQhBkKL56G+1Ipxlr/LpA/vSuiLEsnOEQFl9eu5XzfCJXmLpFoi9gYqX04caD91fQL8tk16Oa/n50Z014/x8cShTlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040567; c=relaxed/simple;
	bh=jU6ImcnG39KSRY44FUjxOzQtdQIvUvOx6S5NC8Xp2EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fjdu+YIX+IW8f/0mS4n43JGhfg7Kf1yxkxyObBWzvxOVH3ezT0eJU2/b45+FtKSktbIY64WL1MyoKLOYEPRGqJ5+o6TgVXVoBVfAZ9YIo7274BmajCdq7ot5Pr4WB/1WJApnil+a3u14b/kA3dv92YMsp1BqEz6uvNSSJCsIgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlCW9yfj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlCW9yfj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so15519905e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040564; x=1786645364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRH7ictljX+Db7X9swEemGW/RtamwsxlpJnMAdaNhbw=;
        b=BlCW9yfjtBhesTWpi38CyorveR+yBghpCK2hPn6aaRCrCsj8vE9vc7pBs5LPAZCyiZ
         JqpVfr7EnIU36UIXdsYne8QiZaLToNfILwwE8SCYdnR66jX1qxNAVO3u9VhbzqEDHTmf
         MjsQKaoBlBlrg6Ub2cWAzov39QqpvSQZkfAc5GAzdQdbuogGkPYLHSwNfDancwoK0I0Q
         CNZ+KdteIQ7qCCGw9GBwJio2mA1mdD4cIyorjxmmGcTx1uMuGPeYqLcW6GWIlBP87srr
         eizwi3G6LZamS5XT9ZPvGVhV+kYzWQL2Lnp8hJdixxC0jtfXkszUV8Ko7uaDnfLiyYq+
         rjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040564; x=1786645364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xRH7ictljX+Db7X9swEemGW/RtamwsxlpJnMAdaNhbw=;
        b=Ne4cnQ9PPipYyV6D0VwdM5CCuPezW/G6zT00AHAP1lSgNBHV3Cg3z445qwaqcnoJSQ
         OKdqJ7E+1pfg7zLZRZJEo19nMzWp5nt9LNbH04odFbSgnWWWNHik9JSd5ovbI2LPXwf9
         W06QzEf+U85Dv+ykYKlnDx9DmXSifXv3UBFmd2tU71jVSAdDksCx5A3Ag8y0HRmJcKSS
         8X6oGvZzlhgvYKR4mvEgXtW5I+dcYqcc0vutm0+GAZjEMEGFlUCQcXq4h6G+NgAzBSgB
         FwiEQGSwsaKt0biZ5qo0ndhFee4jhCSezcYrzq5Tk2hXPDoiQ/VjYFyZWFQ1zQrtBhMy
         h1DA==
X-Gm-Message-State: AOJu0YyT64AXiVadPNa9Jwgy0YP1tvMa/CCZhCSzeYExoY5WWjJ5f75m
	gKPRDPruzdbZ5VCxzXgYDi9g7VkSuDeseQk86W03cjvlPM510+PtM6eY/qxIv+GrGBc=
X-Gm-Gg: AR+sD13N1NaaRJGUiiBEjOTy59aTwzSSZmVrdtfKQaq6mWcyV7TBqYU2pXXz3MrZaRl
	ic+PtgVH+3lxoxXHaFrRf65i8YOaUdnmPo9GdWiURUAop6eaifoZdJ5ah1mZ9REpWnd03i3iXJt
	ErrzdpocSd0r+N11EE9I3DuAYdNV8j2hm7Vwfhv9cNgfxIMXFzfsCcj/peTCMrpNamaEkdh3ypH
	Lu4q9Cf4i0yWBnQXld906mFPzq7j1eYgarRS2mjN98w6WXTpN74Auv41441IavkxdNtrQDbPJTr
	845nJCQa22VAZ1i02SVl50ikhK9Bt5llPaa1aME+U94XeOr/KRY4cBlTekSakwzXF6iKq1paS5w
	FwmktRHox3iNz15TUkMrzsBCZJzs758v7V9Qz9XTZbz12Ha3l5MlGi9J+nrndW5xpw+ug0AxKzS
	IZLrveWHbgJpdBW2sO489TF8zaT7JkL3olpvuLTTSabhpCRbCEBWf01p9uKXEoJX48irvT2Z3B7
	tyc/Grwdqr8AEx4MwIbqvThYy+wZiLlOw==
X-Received: by 2002:a05:600c:e557:10b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-4994e7cbbd0mr192727495e9.14.1786040564376;
        Thu, 06 Aug 2026 11:22:44 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm82214425e9.3.2026.08.06.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:22:44 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v4 1/5] net: Add connect_socket() helper
Date: Thu,  6 Aug 2026 18:22:30 +0000
Message-Id: <20260806182234.380833-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806182234.380833-1-mahe.tardy@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
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
index 2a8d7b14f1d1..8964528e3823 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 			     int addrlen);
+extern int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
+				int addrlen, int flags);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
diff --git a/net/socket.c b/net/socket.c
index 63c69a0fa74e..126a674f534d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
 	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
 }

+int connect_socket(struct socket *sock, struct sockaddr_storage *address,
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

