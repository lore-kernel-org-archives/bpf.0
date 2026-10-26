Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041433;
	b=abDCGiRR96k72/KhmMF6E8Wh4Q6qA+ElAYSqWLk1u4tJW6caV+OlkNFSbC0OIHcfi8bg
	 R5tRhr9Z/ykinsnPmvO+K93eAQRSZQWn5KtWtvvw8gQhxsMPuo8lLjM4g1QEPVy8PvuPC
	 47I7dEIpCJnvjIwnKL4j+xWEupduofCQF+oo3rjvLdIVYQzT5eq1RD82VPm4BWs8mw/RH
	 Uv9WaX6l/7LFhoCutHdHTRfHeYb0/bosE/fAOo4jnrJZUa3BEnX9NOJ4LVw+hDGqvx3WN
	 bH/tlAKFrJkjyxKrJRjx5r1rzV9FkFRkTXU/TSjxEuakM3nGWOAeTXWldF3dgK2DPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DOZJrjKX63ZevYgJMuO7XQKY8YyD3Ep4iAtbpx4Y4is=;
	b=VKZsUymNq4uTRFqowFzEgwYcT/P79IzwPsmq6B8LJOvfPiVBKQRq6rgJ2YGt1CIh7lS5
	 xL4ovtNQBKT2/R0iBQPkUNKxjPmNQj98pfAml6Nm4DwKzwAfrlPI5v1jenvOVHezTGuV5
	 sOF1tRGMKq2HqDNuqaFd6fjgSBL7UqWI3MBWnzPnIroUC+mwtj2DsEm6kfdb1ro5zfgyJ
	 4sO8hNrtwfCifsTGapvnaR/oLha1rfvdttlCdujPCNQP5mhkVtVRAbpRre719bu9uXy5G
	 gsge9F0MZI3yx/sC6LUzOUMiw6pEmrubVL6WBkE0JpiyUnObm1bJ4HxtW5v7GeL1wog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TucQYsfO;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA56606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 19:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA56606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TucQYsfO
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so21709415e9.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041431; x=1793646231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOZJrjKX63ZevYgJMuO7XQKY8YyD3Ep4iAtbpx4Y4is=;
        b=TucQYsfO6gw6O2eXXY6yhDRXPe+AFkM8MRluiZeiMaP415jhVwdH+vwDuaPsXx3d/a
         apKVsIYyDfucp16PujRxv7sL/Z4kov6GaCDaiUNTV/+cRt49WVrpibi1V7c2rcgJfdLs
         Mytqn9PEbiPwu+DOZu1Bi9GJdY7uNyj/YPEV6Q2ImOlv9oiAlDNwAgB0mnjqOda0Jp2M
         SYvbuawLhTKVqmheMyhW+y1hKJY8bRb1CR3SYbWJJ/WA21zveh4TizfLePQqfCm+Vw0q
         rvTogdLQLaCU8OjkOEZVGFw4bWu7PAN2M95fSj3YF0bAxqM5Y5Q6gaZjlYOUOXzoGoU0
         S9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041431; x=1793646231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOZJrjKX63ZevYgJMuO7XQKY8YyD3Ep4iAtbpx4Y4is=;
        b=ee1aLBffAo4eJ0Q4XpATHsDVL8pR6gsr4BeiQt6I+Q9G6NaCZiUEWk/ndToS7XkBDR
         jxaAK23VR8ZmoshVRzUG1p7L02B3NJfkmZOJ/YAa27HiV1tl7xEn4e3NDaZsjO6zVB1k
         6k0Lcp5YqdKg2INqZwG7/ltWcFSKmOCj+18Zh4VfleRjd3rAgKfD/jiKKCO4Zx+39It9
         88rjehHqE9sdbEhbV/IdN3r6s5IW/iOL1lxPJ0Pb0dj8+3HGVCvERAur9O6RVUbZwJZv
         HOcs9eYnPbFiK/Il6aNZuvkihUxed0X0PFwX74UBLl9I+2jTwgOJCCRNQSrcoFfoqw1s
         M0pQ==
X-Gm-Message-State: AFq9FYJqZUyMSM8S1T+Lb3CccEYrmAcJoy9+ZRzzSj4YCgg/MqPLW6RX
	Iw3wZl79mER5jF4W2BdoCtNBrPKDw0k9n+VspD+X5iDL1tVOlMDjPohNntnzhJPKW24=
X-Gm-Gg: AYBFou3UKoPz65wu4BFdeSnL3ME9VnLrT2LmV1Ohb4kR+Vw0lTrNloNIkEftLy7bP4P
	hYWhRNl2lpKbU3ERHd4H3iMT64OBbF8C2PHtsAF4V+AG8OMK8dboCZIXkMh1syO9/+VyAa3ooof
	Zfk25l14kiK7xpTq2HEQMlDjZcauHu4cAbS9vqDXUN3xi+PIR4oOgQMjPaWGT1s3yTLxUMKnWRd
	hXIJU+5nivWBx5qNLsjdfKAEvesKqHhhVjmyCizveGSGV1NX6yzAaW5lP73P+pQGA/swKAaZ9M0
	Ng8eb+qEOpiZiNTJ7f9X1za0L4/HXQWICG6/SrqU7KLNLS9v+uPH7Y6rYoan1KfrEu0wyAk/JMi
	ZOJ2r8KfF4zgYhWp+REQ2rLeAN4QwYJqs1qH65bI2lzY2YnYgwzyWyJ/3tk93N+HznM3o5CQfwz
	jicvZYUiDXyF6Jxiyq3GIkZp67owUPeX/tQne1XVON/tKtxKEc05VGMg3KS7TgasZYePAYKlJlI
	DNZIHxXRbeYz6cwmOGyC+KRRGv+Am7XVuaf6IdQ+TO042eBYf5nyXarrKJX9UctTVVlCW9xKPPy
	VQ4tYIoTWpXVa8YbTBpmTMS8v8c=
X-Received: by 2002:a05:600c:190c:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4a35ac394afmr147153975e9.1.1793041430904;
        Mon, 26 Oct 2026 12:03:50 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm21145713f8f.44.2026.10.26.12.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:03:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Add bpf_ksock_bind() kfunc
Date: Mon, 26 Oct 2026 19:03:41 +0000
Message-ID: <20261026190342.137069-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Part of the effort to make ksock have all basic socket operations. This
is for example useful when replying to a peer which expects a message
from a particular source port.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index 37168f43c16c..25111712b944 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -178,6 +178,37 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	return NULL;
 }

+/**
+ * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
+ * @ks:		The BPF kernel socket context.
+ * @addr:	Pointer to an IPv4 or IPv6 socket address.
+ * @addr__sz:	Size of the address union.
+ *
+ * Binds the socket to the specified local address and port. A port of zero
+ * selects an ephemeral port.
+ *
+ * This function may sleep, so it can only be used in sleepable BPF programs
+ * (SYSCALL).
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
+			       const union bpf_ksock_addr *addr, u32 addr__sz)
+{
+	struct sockaddr_storage sa;
+	int addrlen;
+
+	/* Prevent wq kthread context for CAP_NET_BIND_SERVICE check */
+	if (current->flags & PF_KTHREAD)
+		return -EOPNOTSUPP;
+
+	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
+	if (addrlen < 0)
+		return addrlen;
+
+	return __sys_bind_socket(ks->sock, &sa, addrlen);
+}
+
 /**
  * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
  * @ks:		The BPF kernel socket context.
@@ -285,6 +316,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(ksock_init_kfunc_btf_ids)
 BTF_ID_FLAGS(func, bpf_ksock_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_ksock_connect, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_ksock_bind, KF_SLEEPABLE)
 BTF_KFUNCS_END(ksock_init_kfunc_btf_ids)

 static const struct btf_kfunc_id_set ksock_init_kfunc_set = {
--
2.43.0

