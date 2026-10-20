Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511941;
	b=m2YB0NO9qKBml/L8lpNT/NSiaUjYYVu3oEa/rbQzxMUJb5QK8usKgtRJ39A6T8+/aJID
	 otOfqRNy9zx2NRSBm0DhdnmAkS5uK47U4rg/GxdVgd7T04JeqffCb/Y/yJ2s6da7MFe9i
	 sL8IK45eg8boVbKiqIWScJhitRpbjjNa3Bbzs1J6FDci5T7eCd8YZDTzd182UBOGVEJMW
	 3p3WH4deFs6EWVWmXKe3zQInGKKdssRblRAtdBde6g/OKSG+k7m2uZcRkwatTrw1uziSK
	 qSZgLCNl8FWuDp8VaxJLF5IFKAB95nnTkjpHvm4z1klrZE+OViU2H1oxu9sICBTjqMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7OId8RJ5d9QD0eD16AKrMXmzoMAteLxYLWOYcbZVb2A=;
	b=Cv3DYKcfmDajjZE1S3/k6EUYCWHkvCfT51FTNcVZc3cdO8/kRqQeRgANktpZDsEW1cOo
	 MhCJUKt8qXRIjVaiFl8D1DhG+Rb9eOoburpb7oVYMPgPYmw2g/LS9hoo8mEdH6yPNkPcQ
	 bYVZERMlDhp3xOWUgK8PAfRWjstZ+PcSNZBUiG0ZS6v9DTtwYVYcPeYbCaLsLjSzx6SnW
	 62fWCbnJeOcq4fvTmJ+l6Llb9v1GlsAHUDAaxP/PMfzwepQJikaM2fGEk7o3j5g1M0WDR
	 LPN3HW1L6sqfxXbR1aJCs3TULlKWYl2BLfcH9CnWgnndhxczLWnxQgnuAS5JOoDq/zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=itgc0umX;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC84606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC84606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=itgc0umX
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso40385565e9.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511939; x=1793116739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OId8RJ5d9QD0eD16AKrMXmzoMAteLxYLWOYcbZVb2A=;
        b=itgc0umXTf7OyExxknwmQf9gwtXN/BXakhLmirFMBrYCVUlXX7PhhibEFGhQlcw4TL
         dGacBS8pO2xsvXAG/qXr9hxZP74fQRLX/yuBDffoWoX4090NeXSiuYRuZMI8Z/I0ZW2t
         J2xS/41pLbpWZuDB9S2FRZwLVDqDqdKcRFyusw20nWH3MLD2QB/m70cNr75sMRF9bpfd
         ZUyjhL3o6rm4pxJxS+XJhkXsYwepgJ0MMK7wBEC5jFVMwXvgkfVwvre9Oezc7kzS90mL
         o83Absvy1iRVfGx4l/NnqKh3VnIvlVhqZnts8hfWx9Ga6INJUI7XoLSKndG7qgymwIyi
         8nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511939; x=1793116739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OId8RJ5d9QD0eD16AKrMXmzoMAteLxYLWOYcbZVb2A=;
        b=bSWeXgQ/VMSgzAWntHh2qopG17XUO8Lyc/oY3gPmMP+kEpUo+wagYjnYUK9CE6Ua6L
         TcFxGlq2izPEL6yMyPkBJRH7YiOcDqrDlMm5twtIHxt6JSZU+7A6Z4vbF6YzZf5XdXLS
         yE8H1M+61xHSvEXAcPWZ0nbp3sY+zOJqeX9gl7+e9WXTxf/vMokTG3Bk0Hc5DqV2sZOo
         7upNBfJiJrcLfQ3Q+fd16q3wSrptBi5QOBVIC41nnkkU+1Y1gl63aN1kIUdZMj/nn3e/
         JCh3D0mTf34INwC0OMsLCNdbKQ8S02edB/oKjVQZPrKTfMsaOjAqqLhX1ID3fqkesYdy
         NHWQ==
X-Gm-Message-State: AFq9FYJQQ2fRuUtOLGtg9p/Alva6JZYK7WjyVQn4lKWi9WmzWQS9RdqV
	EPHS/VFoSYcGSec/CSae2DGlwTxMXpFXUqQyyWI68Vzzcv2TsMLdO0HBHm3j1U9cFjxnfg==
X-Gm-Gg: AYBFou1fCSf60UbV4+ExiB84ToGi8dJnEPbOV/6xIjHQxCKSKRNKMn1ovPX7hdKYthS
	YXhu2PK43nmLrH/nM39Gm6D7IAiT6xkhUuph6wf8tDjsjEXQTRviEGtVqlKb2Oljr79bv7n5BgG
	rn233bQjmoLxRlcf6sYo/U5Y6EJ1TPVVxdxJVQq6mES5J1lFzcXCVFx0vbzEm9YTOjACc2mRdwj
	LL0JACi7jm/hU+sTV0wTG30RSJCKOpaq5VMW0dQofiUwwKkNwHjTAlrTVYVWGbc2apEzZ8ofbWC
	2iOT+1hsF7wt9vZ9GDiHL1Zz39RDcYVKeCZxE6RW19QDhOK8P7i3Oo3uh/62r3lXU4rWplmzfyC
	OIZjdH+AWmxq2A85d6p3hIMEWuPbway+M2Ylj2q46Fy1cRqAL7WkA2YS39QtqOHG25alExj2MEX
	xc0pzLTqeU/3N2mBy2GN3bRz0FKsSWrfWlS5/72suUTuPtb9X7Ohb/A1c7MuVmuJfIse2P3kSIt
	ATtiEk1gmfA3vrjZBCqsXtZfbtGTacK6MF8az57KBgfzSbf2wNz9PuQ
X-Received: by 2002:a05:600c:81c8:b0:4a1:9661:14b5 with SMTP id 5b1f17b1804b1-4a1d7616576mr221716865e9.29.1792511939046;
        Tue, 20 Oct 2026 08:58:59 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff02sm5627335e9.6.2026.10.20.08.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
Date: Tue, 20 Oct 2026 15:58:46 +0000
Message-ID: <20261020155848.75711-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020155848.75711-1-mahe.tardy@gmail.com>
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
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
 net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 27 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 48a2e2327ace..37168f43c16c 100644
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
@@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_kfunc_btf_ids)

 #ifdef CONFIG_BPF_LSM
--
2.43.0

