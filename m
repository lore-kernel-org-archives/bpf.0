Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491927;
	b=vHvBc19pvY/PM045naLGv+E4kDxWKZNy9lfZW4YRyY0OianvrTz5fHeMDs1z6EB5E8tR
	 5fe7e+jCdcf/NxnES7UYNWPKw5SoEHrXx+5mvfWbvS3R5V6ThTzcmSj8HX5oUGCUGcwKo
	 mhewYnB77IN7d2MtkzfHFnwPRMq6Hpatm7oYb7nhTSX+yxa0U6HE/2QYw5FL6EACCcUM5
	 6DJ1qbeSSWu1iok9imvzhgGcI9r/Wps48gEk9I3StN4yQZXzDMFKODObwaRcUGlLCTcYc
	 TsCYjB7hfYJWdcURRGwN9KyjPaUer5Py+yaHsYYB2q/Ot4UGmIKBAo59thhxeM28dkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tj/xhp8eO5mteFOQm/83WBlltt447nmI1KW5Yxilil4=;
	b=RWX1tqS2ax7rBiTCK9Qb6kWpZKS5Pq2zZI+Hds7TkwKfAPTsHMk+QdRyS43DqGmL1pr5
	 dEgmfXQNpIekxFtLfOPZkKi3ePC2e5G0rVcCQV6D5n4ORtvAL2ggNJScg4iQ/bAyg4mui
	 HiWDL5eqptZUFt8d2YwopAhONw9otka/9PLiv9PrJYW9wBggyW0So7ek/d6L6tdP+SNX8
	 OHhIPG2CzpmOn7I2/tfYqhar1DEzTNRVEODnR4DqLPOSQAzlgza3ueCawhKfBfGgRoo01
	 MR2Y4Nqn5t9pukc9JvuN0Ujt3TZ2rClQ8irQ3xMtTIJrDGxgt7dtLWsxJfzq8gRLNQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j4hTvYuP;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6960A2612
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A6960A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j4hTvYuP
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1ddc7c9beso14425635e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491925; x=1793096725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tj/xhp8eO5mteFOQm/83WBlltt447nmI1KW5Yxilil4=;
        b=j4hTvYuPLNfyDBDbJizvNiuMcA2oY43YtEk073ByNMa2aK8bGry1sbkTt7rjn9xgo5
         1+w7hlmJPHAgkob2hAzu9yz8uKeHbnYvMyL0fkYGSJRDD9sEe+s/Y+aTouzUYrUbmGSp
         jHYPQA+Mg7MoqjSHpNytvbettrrqoZVMA/K8kJvedx/uDntC9u+tsRxdYQZZSIMbAFMX
         2eN2Z2rilh9mKU+LK/jAMxgNG86LC+F8KW9p7k0gGSsyFZMQpd0RkPdOOxk2WINvH5/R
         dPfFTwL8WMl7ABI0FJrVGfrKB/V9rtT+3Xn1sQLg4BBFaWBN5PLro5U0SL4w6hPmAADo
         l1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491925; x=1793096725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tj/xhp8eO5mteFOQm/83WBlltt447nmI1KW5Yxilil4=;
        b=IafG3DZ40Me0GyNBD2hvubs6ib/+S0K2qExpJJYz2j6CFVTCEGaok+jRAvhGc3FEbN
         mCdErAN5sIUVGIu4fJnBI5ZhMyFjZANzdivWpBvPtYLlwxFERaGj4RCJ4ZY9EPSwdRzO
         34mfvXLyicYul0cfMJFcekDtyhh+tXS39fLsVluJuZR2nDF/ZOChmqKxzxKZuOh87dU5
         6vYxhz+SgalE6Z+jWddAEHVtsUtQdTXD8S5Mn6aXur3rOW/f7mVORB41guHDkzos0jIG
         Q2fPjNlJ77bh74fTSdc4YyVnpigIsvrZTwLtBg9RTuFGimWLAZrlxf7Z9sjQeLKwMDXH
         Laaw==
X-Gm-Message-State: AFq9FYIYFv7+TiO25JlG8JUBB2F7yJ5MShcos52Htrd6jpBX+4dMS0sL
	55gLOqBkBoPmKgc7ts1zeMAj8fcQUg7Gqy4ZA9eXI7jJ5fwF8wbCZ0+VMdwyLe39gp1hBQ==
X-Gm-Gg: AYBFou0yCEAZ2XOFbl7muAfYPXLuIlxOMP6mZpE7KZCpfH1ivDebq0F4vrmqYHAuifk
	wzCOWB5fVutjIeprUd1GOcfsjtpnLlZXLFmirp94NaNtVoYiyfrckWOQOhwn0SNIG5xW3aAsPxJ
	x4fgziGbaOudtYehxPR30NxAsqP76zxN9z5TAvUfwlocvTtOH8Q2VVboFYukhs4kR+LQsG4W6hJ
	IRi0OcxgAmafnV8P0tTnMiR3LciVpOTAXfoO8JJTwRxAKi6so9a7Zjo4QB6B7j1UDBRn7DY33na
	7SaVbaWj+Yg+M0Jg+JEwS0E133aOLtsZXixs+KOeq//faU42KH+IHu+idH4Ceouh4vUXN3M+e6t
	ts2bBO0lBGfsiXBpRMvjrGJFRSq4yWTbk2HIv0UphBurn4B4S6+JOGFkerp+ojhU8MYzg5l/1fm
	s8Q4aEkTYt6Pr4eObfCfHU5gZMV4Om3vaVHICbWv0hGvl+7NdZmJ9C2TYiea98ZJyzM7MWJT3Vj
	ReqYqRCYjHATdn2a6n5v5HN+QCvg9itv9QR+yk77NVVPg==
X-Received: by 2002:a05:600c:5248:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4a1e57b67e1mr140123695e9.26.1792491925013;
        Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:24 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/8] selftests/bpf: Test verifier filter for ksock connect on LSM attach
Date: Tue, 20 Oct 2026 10:25:08 +0000
Message-ID: <20261020102512.518479-5-mahe.tardy@gmail.com>
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

Tests that the verifier filter prevents bpf_ksock_connect() to be called
in a LSM program attached to security_socket_connect() as it would
create a direct recursion. Also checks that the other LSM hook unrelated
kfuncs can be called.

Moreover, checks that calling bpf_ksock_connect() is prevented also from
security_socket_sendmsg() as it would allow to create two BPF programs
that would call each other in a cycle through LSMs.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
index 740ed370d28f..7b5d118e5750 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -48,5 +48,64 @@ int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
 	return ret;
 }

+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock_connect is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_connect is not allowed")
+int BPF_PROG(socket_sendmsg_ksock_connect, struct socket *sock,
+	     struct msghdr *msg, int size, int ret)
+{
+	struct bpf_ksock *ks;
+	union bpf_ksock_addr addr = {};
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_connect(ks, &addr, sizeof(addr));
+	bpf_ksock_release(ks);
+	return ret;
+}
+
+SEC("lsm.s/socket_connect")
+__description("bpf_ksock_connect is rejected from socket_connect LSM hook")
+__failure __msg("calling kernel function bpf_ksock_connect is not allowed")
+int BPF_PROG(socket_connect_ksock_connect, struct socket *sock, struct sockaddr *address,
+	     int addrlen, int ret)
+{
+	struct __ksock_ctx_value *v;
+	union bpf_ksock_addr addr = {};
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
+	bpf_ksock_connect(ks, &addr, sizeof(addr));
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+SEC("lsm.s/socket_connect")
+__description("bpf_ksock operations other than connect are allowed from socket_connect LSM hook")
+__success
+int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
+	     struct sockaddr *address, int addrlen, int ret)
+{
+	struct bpf_ksock *ks;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		return ret;
+
+	bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+	return ret;
+}

 char __license[] SEC("license") = "GPL";
--
2.43.0

