Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982D3F076F
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853796; cv=none; b=E+5FDY63gKE6TwVlaivVQDwbTHKtjmFR5Li71s/O9OCvrgUZsEZxZR2Ffu2hYIQH8urYgm4Kl49jqm1niCJ9HPjcBAyT9DTqksfnufN6wmqaFlV+6QNTSgoX8ZUExZ0uZKsIAJEzA+r/FU+Hu/qYrahMtwjyL92zS4ITv8NIQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853796; c=relaxed/simple;
	bh=ruf5sMxreReMwQaIQKSAQblQ/Q/x7RT3lTJ+YvAyFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buGL98ac6ws4nRN/IxOZ7XJS5h6J6M1DG7OKa6zaU9vtmDOFVrUYls/TUQFVo5xj+57rWjyuO4EYxUAMrF/9dDQJ6ifTNI8jwrydZZ3gTagvbTt5eYkqXvlH4uXohyQnmHmFERQcSVPgme3Lr8hOl1VU9dkP3jxT99MaCCzqb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXNNU+Ex; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXNNU+Ex"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fd66a094eso1479279f8f.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785853776; x=1786458576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt5TtSlsS1iDkROg1uOIa6AAAcNAVrK5bbtBRy35vPA=;
        b=QXNNU+Ex2BrP1zwaRxLGFIsIonYi9w9e1PD69fRgdPWhZQy8ll8vxirQJx0qwFj3ge
         hVKYgvYQcjZmCcr8P+0AObecbeqnekhR+WziGPh7gR2f7xDblt0qe7wd9yqQmE/+/bLz
         AZBG59x6LrXWmO+MeCse/U0bu9Xe4TASSIcek/49HjJcSN6KtxMggpUFngUMdGn5nCjD
         EKpwX6HEiMmCDrz5WKgBEa0JVuA3MT+ZrpKdRnPUUaB9BUs/KkYFifh1KQEZ1ZUPBJhM
         iR7nvc/Vb6Tto+/8KEZv3jXmqV16Ti9JsBxp1mH6AhfCpQeJM6Ux9EEQQQagUCks/GG4
         dfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853776; x=1786458576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jt5TtSlsS1iDkROg1uOIa6AAAcNAVrK5bbtBRy35vPA=;
        b=J2QPEyzOeK0ygGVDE1uMj2rdXHyxWqXpfQQDaMaweo/MNxmwizBK7sHBvLG8cynlT0
         0a/lDsl8buQdLxhQWEbco/7B4hNF8RA5iq9uEITZ45jndCghOzqNCKfrwUApX6nUm2jy
         c4nnZNWeqI2Eo+BVUcAtlhTeQCPKOrS4BpDRIrVOAzXIAr2GBi+Rd1wu6AqzMjsIrhZY
         Rv1plUUfyTKwpky9DxvdLcd0Bn2osM8V06bY4GsyVFo0FeeTtvLovNUrYQVdmsgClZik
         hRW15hgEWyuMbKogqR+KZvjntxU1b0p+nlKNqFoLy1eWlusCpmhxK0OAh8a+ryJh1Zpx
         3Lyg==
X-Forwarded-Encrypted: i=1; AHgh+RrjDRHCkFuhH2+IRALsV0x7TaPTr6sOQndo3Nz/FRACDa+xyXZEJYMkDp83ydNEEUs/HWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYR5i1sA85WTYUj35e+WN85eEpWNDPIVV+ksXUq5Bmy07y/2E
	+lI1eyEzMxlG1kSOVSb5SeA7JaY/t8J0zQZN21XL6OL08bBeitX87sPI
X-Gm-Gg: AR+sD11UsW8w3wJ2g3YrkflSbhyIT1q8Pl1G7Uj9xLhbSoui7ruiGhOZW+EOrIogsaW
	2ujFSeYiMzmHkmdJ95c6m+MOA73ymqaOhQx2er5a4vDTPmJnJWIGlk194srG2HxRzyir07RuSyK
	i/e4lKzeBy2ALuLjYzeaKzXdXtnwU6dXrp4jVug2Z0ZnUVxzjxAMH1fKxIeS6CzJ8y40q5JaPdV
	x3au1xhjN5SwbLMiwM3/fysUZY4P5JBi7xQBBKZIWYzsMxuOo8qOqKVniQ0euFqDsIH+r32JVYI
	jJ+irT47d0eJovsiz4dfMV4hjJ6mv/lUmEBpWtsh+DVbr2QzwOJDxpsvH0wzJELxbZelED27eNH
	7hW5VwINp2PqGwVeuuMaiBhoyKfG6slZJp0Ksks0SgW+sYacmN+cmfBXAyGAsNh2qmCzNIgN55+
	2Zct6JtL6JzdBzJl77HDsneDegnHVHCSxHSX2Xt9aizsaU2HhWLUL8U6sJ9iEHn5LGKUeGPDYtk
	eX52oWj7rWkB2e7xUXhl7F++F1VHQ0X
X-Received: by 2002:a05:6000:41ec:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47fd72c4d4dmr35160284f8f.16.1785853775675;
        Tue, 04 Aug 2026 07:29:35 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([194.156.154.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d74sm5088f8f.17.2026.08.04.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:29:35 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	ppenkov@google.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
Date: Tue,  4 Aug 2026 22:29:01 +0800
Message-ID: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785823138.git.rakukuip@gmail.com>
References: <cover.1785823138.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they access
sk->sk_protocol without validating whether 'sk' represents a full socket.

When a BPF program passes a mini-socket (such as struct request_sock or
struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
is located beyond the memory boundary allocated for mini-sockets.
Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
kernel read.

Fix this issue by checking sk->sk_state != TCP_LISTEN before inspecting
sk->sk_protocol in both bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie.
Since mini-sockets are never in the TCP_LISTEN state, the condition
short-circuits and prevents dereferencing fullsock-specific fields.

Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---

changes in v2:
v1 Link: https://lore.kernel.org/all/ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com/
- Check sk_state before sk_protocol instead of adding sk_fullsock() check (Kuniyuki Iwashima)
- Correct Fixes tags to point to 399040847084 and 70d66244317e (CI bot)

 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..1a5f1bac0a75 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7679,7 +7679,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		return -EINVAL;
 
 	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
-	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
+	if (sk->sk_state != TCP_LISTEN || sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies))
@@ -7752,7 +7752,7 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 	if (unlikely(!sk || th_len < sizeof(*th) || th_len != th->doff * 4))
 		return -EINVAL;
 
-	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
+	if (sk->sk_state != TCP_LISTEN || sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies))
-- 
2.43.0
