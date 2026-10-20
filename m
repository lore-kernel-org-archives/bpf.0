Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511942;
	b=R12RXYhJTlKpM+KYCCVLJ3mP61a6qKXZNERP+L8JS9GdQmqrXCXXDTfrR/2hFWiZUb7j
	 vxNwXnYx5C0ZDfDH9Bk//9mH6hd92issPsaulA3jsDzlXTBidnbaWMFqsWYleQsDl3AhU
	 UxUjL9qUJpTle8u1rc++ldBUdCfScBSOVxFCiT+bBXkuPT7+5fZsKy7i34Auf5gUprUwZ
	 F1ZZbL5PG9bv9m0CsOiQPDtZwxO91UPrCafJMrwjrHF5vDWXI4N3oAgubTwNvCJGLXAQe
	 e2Me/0i2FGEe6MP3CJ4zDjRSkRbZFgIcwVA9Tk7il6M6SnyFvfNOFpwPXS05vFCOP6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hkgVqWYUuUzLDP7QxqnS40Mb5Zrh1ZPW2NmRfQG0dH8=;
	b=0OzQN4r6wqskerLEp4pAsIHM2QuNLvBpRF7+sb2W32P3aw8gBdX8fGB25gZHNJgYbda8
	 sBWwEHbHpOQHOLz+4rtCKSUbZ1cKSz4z78FxkMxqmXWpYNBFsW3sm6XRu+28kHYZ0pwPc
	 DAjEutM2YP29oz8I+Pw129LnKXFlIn2xwyiYTSUuYOmZYeWY08UH1cN5rVdZbWJjCQKtO
	 UOIBATOQI9nRr+eOh+WiOHr7UdN696EtJwwbYzL64GoXnbokJSyVRXiYdwgqTfoxN0Zs7
	 IzeUlhrirT2DuWpBBp547ZKhzLcTGvd49AIQDgtTLp9q7KZA9MXK2EHN+6ZN5u41P+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YB/kKZf+";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434C60A260A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2434C60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YB/kKZf+
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so32276565e9.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511940; x=1793116740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkgVqWYUuUzLDP7QxqnS40Mb5Zrh1ZPW2NmRfQG0dH8=;
        b=YB/kKZf+2zDLE0l1rDMj1rAlhC89gSpo8PQV+lHjiAidCvrYVVX1tz4U2xUJ9TQU5g
         WLZ0l67wZFln/UoDptumliUJBACbySqbNGqz2pn97nLTAiHH6Owr0ML3hj5yVWB5nfeA
         /x7Ajw+ljLaCrlfyCKJhc539APZkC6jQgNQMQ6i+il+RLhPKtQt1Z0/Khad7IbYiHBSA
         AIIPqqSeI0pGdHy1DL6JF82eCe7hqNkW8RtcEt/x+oBl9pJQ3rmcSxJUY67LNt4C8n2i
         SCGpypZIBEz6X85qas5DHIc5L0GBKCGpM3HVlhDqU33GLjzjdphigz/AviV0MkY6pFgs
         L1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511940; x=1793116740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hkgVqWYUuUzLDP7QxqnS40Mb5Zrh1ZPW2NmRfQG0dH8=;
        b=pVzCLg+m4jpWnCGcRvi/09eXWpJ6VV1cZgz6tTEYsiN5WJsNp37XWnl37Lvc7j7huY
         g3A+8PFtPN0BBgZ+2RKZS2FxhwVFfLDhOkw4nF5mH7HlgXzqKIRgS3VdA4dcd+vQT5Al
         GUMr80eRv/I/FUCmucxC6+pLH2ecteTWC+ZkvbMz94zIvs6x3B8rr48PUMKfGnr2l27S
         fFPkqoJ3fIvf8ex+Jd3ZQy8cSiSAohctvAlTqsop64ttFWO6rpoTy5WTPfgNJxw5wVKf
         d18jfjzi8c5Em3OfvlFGK6nBZnafIu5UCn8aIArJh8Sgsy6mQdT0Q5DUQy97clb52exS
         nfTw==
X-Gm-Message-State: AFq9FYIrfZal07+CrW8c37WXhQdlUgXnVjpW7WMvpSPbBBY9WPoaPTIm
	yHO73JRhU6yotY8tPy6swNOEiUo830suEMyIA1MXm7+MvShl5SICOtjCSHFz5JqiTcpAmg==
X-Gm-Gg: AYBFou0/3c3ZkKmOxGL3DTRFX5m+AdUfXkgsDsj2oJDkAoIjxmUevqQs30/NnZ+yMpS
	0Snf2Nqae7X5FN3NGwLbq/cbeqgyn2injMzaJntl0kH4m3mykIWF6Qz2uJl2cRZTllL2Tz42hgG
	rtkdNBuOYgDXurcT4G20SiDr88D6GHYaWKnACdiF21I54GmxpQFj078sno3jOI8f1FCXYGxo5E3
	svOtzZs9/jSGYDRCBlJCwclILrqI84IMp1t/Fk8RhR08DlV3SAuPPgUFfL0mhVCFwd7EBIZVx/c
	fVuAu2LMVD8sUnLZzvYHlk0BRHxZ7BL4xx8jev0gpr4fi4oVhavZJDctBTmP8nqjisauR0LdSj+
	DyTYyYK621A8t93f3bulZnkNUvSiBQnITuPkVS25QB1YOIyryE73Yx2xxSz8GMdJLlCwUlIYPHx
	1yaBrOLNJChyi1EDkkxoWMAJNEpw6c7WOCUoLWYX7o4uyWqUt0v1v8UY85zZOJHxIrFMFe7m4eS
	nEhxEOE2K/9NGqKWN2MeMtiZ5uok12/9+RnMDPFkEcPwIDY+6VyR46d
X-Received: by 2002:a05:600c:3b1c:b0:4a1:9a97:c88 with SMTP id 5b1f17b1804b1-4a1d7600183mr239776625e9.5.1792511940352;
        Tue, 20 Oct 2026 08:59:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fb83ff02sm5627335e9.6.2026.10.20.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:58:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
Date: Tue, 20 Oct 2026 15:58:48 +0000
Message-ID: <20261020155848.75711-4-mahe.tardy@gmail.com>
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

Similarly to '7b0dfbf5776b ("selftests/bpf: Test forbidden
bpf_ksock_send() LSM attach")', tests that the verifier filter prevents
bpf_ksock_sendto() to be called in a LSM program attached to
security_socket_sendmsg() as it would create a direct recursion.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index fd2ccfdb5802..9533570eb340 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -12,7 +12,7 @@ char send_data[11] = "dummy data";
 SEC("lsm.s/socket_sendmsg")
 __description("bpf_ksock_send is rejected from socket_sendmsg LSM hook")
 __failure __msg("calling kernel function bpf_ksock_send is not allowed")
-int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
 	     int size, int ret)
 {
 	struct __ksock_ctx_value *v;
@@ -32,4 +32,27 @@ int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
 	return ret;
 }

+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
+int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return ret;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return ret;
+
+	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
 char __license[] SEC("license") = "GPL";
--
2.43.0

