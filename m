Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491928;
	b=IOQlpPiMHgju6EvCNmt3jlks2FF37KJBZcP6c+6Prqu4kpofZN8+Czl8xgMCNIbyL45x
	 TA/ZVDr8XSaVM4oZwZr94UAG1ZG6CR7Se9PSM+dAsTn/y6gB3eaUI4EpZT0/hW03Ul2X1
	 Nz5BRD+Rx+EmM5uB7B6p9Fh0b7a5Y7CMQ8LeqZ2jpJyesOBdwc3sBFqP8Y2EGKScVsIvQ
	 pi0Hi9HZ6d7Qd5ugJA2ORaz1qnMhBL9xZ4yT5+1Mh1UhMghcA1ElXRcxoXqKn2FNwNX/k
	 qLOtA1pRgYWESEx34Ug4luXRPUuAVKCs9WGUdUzuwm/EMXO7/fgMoas9BNfWIXJPjXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hGAvaD5FraNbfMMFntkD8CACjxCj7f+xaJYrjp5/P9U=;
	b=M5hull1EQMptFDbrqbti1RL9LAb1aaEhx2KnO1JanLxrkR8NBFU6BHPlYOz9x5LblWi7
	 e/CFilOIEeO/ZS7QtAh8K/MZtJ9YxTmZOyZql21jWX7ar2eIwpMqwEFSDUmoCb6HNErcn
	 2GsqsddekbozEoOplFai0m8FaRTb3yVrqdoLlWHP+vaPqDR2mdwO5ZKTqol01+iRiFDLS
	 O6sac6vMq0SZJBFoY8jgaDHX6sDpAaCw4Bc8IqrCdAt4/ghmhd8Q9b+0oOa8UjlpkM9Vk
	 jIo/Gyv4fjuqVz2QEE13uFZLX6aisJtJT88IU6JVdKKFb0nj0GjxVlUuyO3P58YX7fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cYHKsHnA;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4C60A262C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE4C60A262C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cYHKsHnA
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so29139395e9.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491926; x=1793096726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGAvaD5FraNbfMMFntkD8CACjxCj7f+xaJYrjp5/P9U=;
        b=cYHKsHnAwCNUzF4Lfw4RofTAiQ+DdY0ztZV8T1RjQu6KF8hb2gr4LuHuNnhBjyMbNu
         FlMTwDZ66Y5cPras0ruUIcVvwUxBm279gTQwRwKGwPe4/pNceVXOHx+QHYD4KmdDtt1N
         Ln/8cUNlu1qh8sXuRMFWp+0+Rwo0cTrDMpM2xjvY3h1r5Ta81sPnN81vkxmlrFocaKur
         7oSwbKvg2EAwtzfBaoyLwZfm9nm9Vb7EZRxlTw3OnAA5dnbeX71IuS/G+lzi0mxvrMnJ
         P/6C2ll222vXTU+OPfoY7gug7hZGtsaW4KRQyujs+ji+z6NP3nZMhOG0CXTYMcLVStgK
         SC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491926; x=1793096726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hGAvaD5FraNbfMMFntkD8CACjxCj7f+xaJYrjp5/P9U=;
        b=lqMJE6yZfSEcOxTB+MisnrosAccZNe7ALXhHzD26ECkCdC5uCJWiwpx1MuEUVdxe/A
         dXgqBsGItBuVrkjoskx47uVJos97eDkHSON41sdGVPEFSXFRKHvzwHoH1a/biObQ6RzG
         I8TkrAJzMBMt8ENXAPGzhEYLKA4g+BwtLGL0XPSr5BbUa8K+SQnLzW02vmBwmOK77O/f
         2T77llyOBudVCqAkcQf0sEJigzGcHIh0D0fpBWItpBSuG+iTcgIKOrEdbQ0KhhKiKZap
         V0fQ2ccjLq0gvQ42ah47+qXjcYbZraP0nFfOSxQT6v1OsfplNUsDVZP0u+069niZR2mt
         fKHw==
X-Gm-Message-State: AFq9FYLo5PU8r6ewKyjULzCyp00UbBls/Tsh2DwHKkgxHNL+zl2dVzOj
	SMpeMPXQU2dhNOzH6Akyt12A12khbWB/ri7LbW6cg+DWm+E8SZRcQF+pfFyDf08B0e5zMg==
X-Gm-Gg: AYBFou0TT9zDFvUMopLoUe+GOaT9SYQUBCmt/ylOAmkd+07xuimLtZWZ2bS/8gg7nFW
	HbI+SwVF579JyeK+S9TadF02KroqiE/nsV9L52h1Wgb2fxsr1bVnToCM2qsAY69crSRtnJYAOv1
	l9wWnfv6+VgZ5Oc4WfwdL6Iz6QOPF6YwS1/6UQE0vAp3Ez/nmYMAIs5vQ517ZbOUGR4o/QhzF2Z
	vXlwp2ODdtauzwrIdlHV8VLdgRsolHl7k9AyemOP/MS0kvdr8NipcICxvXpjvkzMMlqlc1+P7aC
	qf9Yg1fe2w0KtjjrgmPlNXlRnmzmgl/bhiL1UlS0OVIKGWE8aIYCFE4mAVLUw9TsNOj7xzDDdNJ
	sVhjea/LF1Chbmj7tXjhh9vVSefl+Zs2QyuoKY+W28vtHVOBPNykuZXpO1QKWBiDbsLIx4m3pL/
	VbaTeAmB8JxsQ6g4O12KmzKQq3hwMuXyQDoxerwCcaBA+pqbtej48s/MqkxX9H3tMAqrXjd/edU
	pMTVcHbKlAHoQx+dO85ACO5bmwqnO4DLe6oCJlOVw3JHQ==
X-Received: by 2002:a05:600c:63cb:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-4a1d76356c9mr155492965e9.35.1792491926406;
        Tue, 20 Oct 2026 03:25:26 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:26 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 6/8] bpf: add bpf_ksock_sendto() kfunc
Date: Tue, 20 Oct 2026 10:25:10 +0000
Message-ID: <20261020102512.518479-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
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

The motivation is to plumb more of the socket API into ksock, thus
supporting sendto() in addition to send() which makes a lot of sense in
the context of UDP sockets which are the only type currently supported.
This is useful when ksock is used to reply to specific addresses or send
to multiple addresses.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 98 ++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 27 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 87329c4a2f8e..dda5aefb101e 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -37,6 +37,49 @@ static void ksock_release_work_fn(struct work_struct *work)
 	kfree(ks);
 }

+static int bpf_ksock_addr_to_sockaddr(const union bpf_ksock_addr *addr,
+				      u32 addr_sz, struct sockaddr_storage *sa)
+{
+	if (!addr || addr_sz != sizeof(*addr))
+		return -EINVAL;
+
+	/* Kfunc memory arguments may be unaligned. */
+	memcpy(sa, addr, sizeof(*addr));
+
+	switch (sa->ss_family) {
+	case AF_INET:
+		return sizeof(struct sockaddr_in);
+	case AF_INET6:
+		return sizeof(struct sockaddr_in6);
+	default:
+		return -EAFNOSUPPORT;
+	}
+}
+
+static int ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data_sz,
+			const union bpf_ksock_addr *addr, u32 addr_sz)
+{
+	struct sockaddr_storage sa;
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT,
+	};
+	struct kvec iov = {
+		.iov_base = (void *)data,
+		.iov_len = data_sz,
+	};
+	int addrlen;
+
+	if (addr) {
+		addrlen = bpf_ksock_addr_to_sockaddr(addr, addr_sz, &sa);
+		if (addrlen < 0)
+			return addrlen;
+		msg.msg_name = &sa;
+		msg.msg_namelen = addrlen;
+	}
+
+	return kernel_sendmsg(ks->sock, &msg, &iov, 1, data_sz);
+}
+
 __bpf_kfunc_start_defs();

 /**
@@ -155,22 +198,9 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!addr || addr__sz != sizeof(*addr))
-		return -EINVAL;
-
-	/* Kfunc memory arguments may be unaligned. */
-	memcpy(&sa, addr, sizeof(*addr));
-
-	switch (sa.ss_family) {
-	case AF_INET:
-		addrlen = sizeof(struct sockaddr_in);
-		break;
-	case AF_INET6:
-		addrlen = sizeof(struct sockaddr_in6);
-		break;
-	default:
-		return -EAFNOSUPPORT;
-	}
+	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
+	if (addrlen < 0)
+		return addrlen;

 	return connect_socket(ks->sock, &sa, addrlen, 0);
 }
@@ -225,18 +255,29 @@ CFI_NOSEAL(bpf_ksock_release_dtor);
 __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 			       u32 data__sz)
 {
-	struct msghdr msg = {
-		.msg_flags = MSG_DONTWAIT,
-	};
-	struct kvec iov = {
-		.iov_base = (void *)data,
-		.iov_len = data__sz,
-	};
-	int ret;
-
-	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
+	return ksock_sendto(ks, data, data__sz, NULL, 0);
+}

-	return ret;
+/**
+ * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remote address.
+ * @ks:		The BPF kernel socket context. Must be an acquired reference.
+ * @data:	Pointer to the data to send.
+ * @data__sz:	Size of the data to send.
+ * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL to use
+ *		   the connected destination.
+ * @addr__sz:	Size of the address union, ignored when the address is NULL.
+ *
+ * Sends data to the specified address, or to the connected destination when
+ * the address is NULL, best-effort and nonblocking. This may sleep
+ * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
+ *
+ * Return: Number of bytes sent on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
+				 const union bpf_ksock_addr *addr__nullable,
+				 u32 addr__sz)
+{
+	return ksock_sendto(ks, data, data__sz, addr__nullable, addr__sz);
 }

 __bpf_kfunc_end_defs();
@@ -255,6 +296,7 @@ BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)

 #ifdef CONFIG_BPF_LSM
@@ -265,6 +307,7 @@ BTF_ID(func, bpf_lsm_socket_sendmsg)
 BTF_ID_UNUSED
 #endif
 BTF_ID_LIST_SINGLE(bpf_ksock_send_id, func, bpf_ksock_send)
+BTF_ID_LIST_SINGLE(bpf_ksock_sendto_id, func, bpf_ksock_sendto)

 BTF_ID_LIST(bpf_lsm_socket_connect_id)
 #ifdef CONFIG_SECURITY_NETWORK
@@ -287,6 +330,7 @@ static int bpf_ksock_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (prog->type == BPF_PROG_TYPE_LSM) {
 		if (prog->aux->attach_btf_id == bpf_lsm_socket_sendmsg_id[0] &&
 		    (kfunc_id == bpf_ksock_send_id[0] ||
+		     kfunc_id == bpf_ksock_sendto_id[0] ||
 		    /*
 		     * Break the socket_sendmsg -> bpf_ksock_connect() ->
 		     * socket_connect -> bpf_ksock_send() -> socket_sendmsg'
--
2.43.0

