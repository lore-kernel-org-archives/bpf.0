Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD293E559C
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371611; cv=none; b=rWvIGOTU9e78mlYiUjOQfQ/ZADr47R8gbFLs2Y9P63W9C0gr2SoG6H23aIDb67saYvYYeuNKzSFiZvXxAyJdgwCjFkwu5ZFD1ORi7sj3HpH5/Y2peTzX4jpQTMUErHGj26ld3e15jKjZ9mqIS0xchredax1XgEoCnIgUCj2WZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371611; c=relaxed/simple;
	bh=7dRN2lVYiQcHQj85FKXslQHT95uAqRClKyLM9OSsglg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GnORwUS1LRV+Ify8XSeqRIxPTP4AbF1Q/AfLafhkc/AUMb9oC6rldpK+J71BIODL7WND+LFBo0fiJtxEtNdQrYHUAOzJ87ZyrO1pabkHBNfoQueXl/pmv8HbDhfPcQm3lXi579iuKPbsUoG2+fBBv2nCfahqeRp4UOZaMr4tpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq5wjpIn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq5wjpIn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b45cb89f7eso41206355ad.0
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779371609; x=1779976409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=Mq5wjpInx02XZj4i+RW0C7p5t+kYP1DX461Qqgjzo8QEYTDAJdxXCft8djRxudXGIv
         EX3yTHRdHOp7WniHFQjYcoimWtk+IcOQQUuhVdyZ798rxVuz48mnw+UJOQXXH2CAhUkA
         7KECSc3PKXWpfXVqifjB/LI4EoG4FVr7sSyqFS6yajbpwzWVMoOfA/8fFk104RxOQkAR
         GGmqJ9J0YCNfsO2CcIulbbNrFDMlabvpofb8j3FqSzQGKvAd3BrGJzpfZ6Y+SfEnAhaD
         0+90GO+1Ot7DHJgQn7wMcMTgdaKwRc3VL/if56fhgphPu1e2B+q+NG9/OVZ27Gsgm1Lu
         6RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371609; x=1779976409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uxNYLIbpi8gIXuY+ONhzYZBPNfuEelESGS8WTu/ln4=;
        b=TCao5Bqn9zWnIn2gIhcMqACaBJTHccjuu74eWFf/N+raAnX+4NZBpvXEd+HDQ8DcQW
         qGw+O4eH0u/WqciCQ0QXX6HTAHAwnvQOiYqxrx/1eRxSe47EqSLpJ25RqKR4HaDnCoNM
         C6KYmuo1BIiHZdHKGzQp1ha64nX4ZC5x8+ct+SiDBoUy6DysiMUZwAp1lCFpNw77MtGT
         0QUCLY6DoVZYH3ilWzbAPbRXcmY92AXGqX0EFgwbTV6tLteEnS51FoMxHZlYd/DSDXyS
         KT1tUpKtgXN/nl0llIZQdfb0Pi0+pzxONHOZqAqRZ8aPimvXmHpL+KTbuP9j8VrZOmJk
         qtLA==
X-Forwarded-Encrypted: i=1; AFNElJ8UKTpaGE5fyiEBXwveBAc1T8My/QZGEL9HOLG9rMwSPGUiU0tp5X9MXieliYjNVGabcoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXceD0cZVTc5d/i8G5MW5s1y9F44c1P2WX48N+FYBHH0dTv3rv
	scr7O5VX6oY6FfzSD2XteIx+wifsJQo6T5j1BCfVprrbAgJvPoySJpzE
X-Gm-Gg: Acq92OGeCkhD3etwawTwPSnRQuBipWD4M2feIJnW1QUk5/wonyEu5dPV9zpmiIYzLGN
	uWWtJlg9QvFPhtbcIwdEcUtshSlsA9DAUVinCdDsavo6U0wP4FEpg9KI26v65fKj788oz5vpj3j
	fpTHa/UCSzW93n5wT6yIZL93pi+oz2RFE0j2aGFNf2oKwI7kVdp3GManQ3IB8NNqyV9oVSP4+Lf
	GFEukfKa35Lkdhq3eFOXy/xmsm+Rf0AxKLYAY5D8pOCpUCoSPM6ddMoZvLSZ+9wtShz2d3T2e0W
	oCu4YOu5BsN2KSinxlQpkA7WU7cyYVMVS3+ZuLG9Vq8nBFOp7/WnvuC7csM5SWKbzcuwjFnkhyn
	zz0RBGmjr1BB5ynN7OcTMKLMcqespI5b/VvSZAFkvc0V7zs6dT7x/oOsjmM+m8xKEutFxFCAJ7p
	/nsTSmIsXfs+IddvhWUgc13F68jFFzu3+/rvb5ksbunN2WAEME8sQ86Wg8SfQoVxIkvxqE7wltL
	S86XyS0CRzxUQhUj+kqh9ehAkFt0MPReCCqBcY4bQ==
X-Received: by 2002:a17:903:2f8e:b0:2bd:7191:5708 with SMTP id d9443c01a7336-2bea30889bbmr29386365ad.29.1779371609075;
        Thu, 21 May 2026 06:53:29 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:2035:4b1f:d540:7ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98fcb09sm12957365ad.56.2026.05.21.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:53:28 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/6] net: export sock_disable_timestamp() declaration
Date: Thu, 21 May 2026 21:52:40 +0800
Message-Id: <20260521135244.40869-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260521135244.40869-1-kerneljasonxing@gmail.com>
References: <20260521135244.40869-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In the series, sock_disable_timestamp() will be shortly used by bpf
timestamping rx feature to dynamically turn off the global time record
function. So remove the static label.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h | 1 +
 net/core/sock.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e0263bae8da9..a579d5b09207 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3047,6 +3047,7 @@ static inline bool sk_listener_or_tw(const struct sock *sk)
 }
 
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
+void sock_disable_timestamp(struct sock *sk, unsigned long flags);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index f362e3ce1efb..f3d78da3aeba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -474,7 +474,7 @@ static bool sock_needs_netstamp(const struct sock *sk)
 	}
 }
 
-static void sock_disable_timestamp(struct sock *sk, unsigned long flags)
+void sock_disable_timestamp(struct sock *sk, unsigned long flags)
 {
 	if (sk->sk_flags & flags) {
 		sk->sk_flags &= ~flags;
-- 
2.43.7

