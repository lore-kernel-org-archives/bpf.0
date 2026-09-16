Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2513C062D
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535320; cv=none; b=eeCOYnB+tKl/NwihUWBWxe2rkbOtSz9zd9FLv9u9/X2U88/P2K36l7/CuButpmofD28hBSQ/fSGK5dwn3CYHu1nzOcG8i0dohtAiL5pmRkVDsMXFnFh3JpNlIQ2uIskhYTNuMz70taeLozRRateO0ohIcCW6yLogXG5nzXuYSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535320; c=relaxed/simple;
	bh=UyVsKi/z/KsUsM+tJ57iW2vmtY2QlPdWiKWL4HrNgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxoxxRdeuEniIkkH54EGz4s1dAFwE4drPq+OJNdFmMsk/kvPYJuZxtRUELIjxcaWeIRlr0dC/KfP97XDNqlxjH/e5QRGePTLJJAIVIritJhAyM7xb3FxGilmYgztY60OIDQVy5FNrp19JNqA/ODj9iItLF7N6iPRAZzrkmlNZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qR3omIE3; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qR3omIE3"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2d747f0135fso5118025ad.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535319; x=1790140119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jvocuGAG0VoEVU1ra59j3nMXDz9/LzPeuMPZJ7bQhE=;
        b=qR3omIE3i2b//8R1jZSwzAhhoeAqucjeBZVGf6PZ9AmB2ixvwfyOs3TLGbXSplBDWk
         MeZVBG889TAr25ekx0iQ6UipvoJ2AUydzTGqJP837L2O/LpryvNQpNf/aYScyvIuYWgo
         RthQvZCIqz7c4NuQmg7idKH95a7iL8I/6/b5bhHKw9KxKNeZ80ODWa98JqnPMZKpLQsV
         YVBwZLFG/HHgEwvrjs9rBqp9PX2j0Y0zGorns/YyqgMrfQAqZG8J1Tu5mJJpvwJj0yLp
         vLLu+8gcOS/Kh/i9SMMucdhkH5K4b8KNtiGuE0LwBhfRKPbjh0Pw6NjO+wP6Ssv53SwK
         p8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535319; x=1790140119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jvocuGAG0VoEVU1ra59j3nMXDz9/LzPeuMPZJ7bQhE=;
        b=QwLxPDVX7DPt+dUTjiFadcRbAq6ya8HSb0sD51lxQNQIOR4Ogx8PTiC06NEFH3LVaq
         W2CPj/COxYG8+nQ9wF1oqDl7zd0aSs77vkZmqAIx35nSGbMLlf0kLWtPwrB1GdEO5Ruu
         avnjpOXV5whBln0/EEFBtyKHemiT2mA1sktMmL4WV14U/c+SF8otC+sDymVze3Q54UyD
         RKF1ANpzDyhN1Gqq1Cso0APPbgU/zihwcJw1/UnGh4MwjdcPhPQN34Pfe/y/99WOQaPY
         uaQnrqzHRUletamoEikKYDkr0RXPK12VjQSS3no7VSw2gMu0yAVguz5QU8RQJVACWMN/
         RdVQ==
X-Gm-Message-State: AFuF++ktlQoLWPMfZhke1J+zMHyxAV1UQJ/TkQpFsEP4oMAPkBQNjfj2
	rfHFrMjzuo4BCGBJllJGB1X806K06XdV4LcqhG5darEnxTlRgcmqOmgecnBakaUIbspQKK3AtrY
	/oSz8yNc=
X-Gm-Gg: AYBFou32PC46ju2kkP07V3sFGCOoGNf8WjNX/+Cx1H0cm+NMifU9bddI13D0lgsArUA
	P0Y99D3mXt0UtQrkKxKivuzz52sGWzuojECHlfAWgrRdTUbXoc33sbZ3O7RfFSHHw4cMch17jvi
	1nmG72KxXZQ01/hW6NjOobtcYGUhRhLcKHDynVFrJjuy12kwNiGpyls4kLfhI3XW9fgXranf+gJ
	KY4U1ItwsLCVUefFnHejk3MJx3PvfTovYNlt/NzQrLOL3cnSAL4BgywBY4D/jO6QqiA+eleryH7
	IeSpohbzMXGMxzrAw1LjCKcg/YH8E0knFV9AapgzP494qPtKsinJopLeS4w0Svpj0o99R7cJwT5
	mhrXsBmx5fnvycClhMsFWDL9w1obd4GOVaQuHAq6kp3TrAODRq+SDO5UmU2KUR8M5eWM0uoWGfK
	DQiInfOqEvqs8JKFZ4SC9Cz2Yl7iG9LDbpAxuCM7PY4xW0Laju674ENpyvvIuuBUrwnDEmr58US
	haV07p+iecACbw6JGU6QHRcd6KMNcyX3oFSIA==
X-Received: by 2002:a17:90b:5105:b0:39d:eca3:e296 with SMTP id 98e67ed59e1d1-39e1e49a1e1mr2791049a91.17.1789535318721;
        Tue, 15 Sep 2026 22:08:38 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 04/11] selftests/bpf: Add selftests for rx_queue_mapping context access
Date: Wed, 16 Sep 2026 05:08:22 +0000
Message-ID: <20260916050830.8774-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to ensure the verifier properly tracks the 0 bit state
and width of the rx_queue_mapping field read from struct sock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 2a136c917..565c4d8bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -88,6 +88,44 @@ l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_family]);		\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("skb->sk: sk->rx_queue_mapping [no sign extension]")
+__success __success_unpriv __retval(0)
+__naked void sk_rx_queue_mapping_no_sign_ext(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0xdead;					\
+	exit;						\
+l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_rx_queue_mapping]);	\
+	r0 >>= 32;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_rx_queue_mapping, offsetof(struct bpf_sock, rx_queue_mapping))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("skb->sk: sk->rx_queue_mapping [narrow load mask]")
+__success __success_unpriv __retval(0)
+__naked void sk_rx_queue_mapping_narrow_load_mask(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0xdead;					\
+	exit;						\
+l0_%=:	r0 = *(u16*)(r1 + %[bpf_sock_rx_queue_mapping]);	\
+	r0 >>= 16;					\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_rx_queue_mapping, offsetof(struct bpf_sock, rx_queue_mapping))
+	: __clobber_all);
+}
+
 SEC("cgroup/skb")
 __description("skb->sk: sk->type [fullsock field]")
 __failure __msg("invalid sock_common access")
-- 
2.54.0

