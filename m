Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491773D3307
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207935; cv=none; b=Khfw3qUMtHMRr2/kSt/7eX3prE01NvAYx4tyizXySmHK6+CuJZQICpfnJ15Xhn+CNxr+4cOk45sYl3zlRcSU6tBQ8c0V9g4yEoXy8j4x8dLDBvFSPTxPrsOdTqeegeh6+Kf6X6hyxy26J0p/GXYzNC3DB12FDMWGgGyOMJUD0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207935; c=relaxed/simple;
	bh=442GijrACNIyhOO1PCXlk5yOxBA5l2sO0BEtkSrO/ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qOQt9ysfLUWPcGvuE3pa3hFUTvSfzmXUoQZNs1Wkyw3u9xjldZibFtMSzN5kIh5WIfiNqvoxYEkMU1E4Q5sKd60FqX7V6NqCrVu6MO7UjJp+cSPVn21EWh4GXR98iDrwrlIE9DxXqjtnnDtV6qTG1/RK/RAKHbxDlU48u+uD5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PW9jpWSq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PW9jpWSq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so52390665e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770207934; x=1770812734; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yH8MXVCKtWqJdP7mij43Xe3QvXlt93YlWk5c/5DsI+Y=;
        b=PW9jpWSqEFr9vYeuiN1hEZNBDMAP07jDPrQVot+jcRcfJegIBAUAvqPFVp7nBjrQQI
         RcRvvRS1Y+fiGd7s69W7A0f0LWwQPy77iG6HMiUJ0gwA789dYIpkIEjTWNiuhG6ujT0b
         EwJvgAqMJpLi4o7lUxJAlAgjgNGjyWTAs0X+IiYYkrdyf4YmiYceQGpaVZGthYxXKxTZ
         BhB47D8lOh+ef4Yr5tVL4P26LAqdtzFj0X1KjVj6DBTAUD6yhQ60gjCgyRU3BihFfo/7
         jkeVDJzkiV84q6ClqArOmpmeMyawUu3Ti2iTIA7eebIk1fADUJFFRbKSMe+00e41LzD7
         C9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207934; x=1770812734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH8MXVCKtWqJdP7mij43Xe3QvXlt93YlWk5c/5DsI+Y=;
        b=tGy2yym4EseI+qwvWK/H9nhon+PoL/6eJVKYJLTWaLH+LxlyYUbQn+Iq+cJmJMtZ6i
         RVweJiJ2AMvV3mun7P328itNFdJLjXPs0okv5LlNolPs9KC7nXKI2QaTJwN95gzozc81
         OG/KmYdGv1R0yKRnLzTCsPuYrE6noc2Q1JYIGU2wgUHdRU8h8UjWu7rd909GBshAh0MY
         mo8WwXXgUO1/xlaVNEbHN4hEbGmlLVqykFSbM6hhVNL6URKEiqEVJ4Ju4Eipfozw9Pgv
         W3eBc7mHVHttYX6eiHsjdMd8ROfwIfkysX2dItUZ1r04cBMsT6qBU7INCN3wqpnK85xY
         x8yQ==
X-Gm-Message-State: AOJu0YyiFrhHsI1oDMBM9mcOeuIncpHcQco9jahVhue+s5LhCdeT/HxT
	78Z+qf5kpsx0lqd/8a1KJMy2+WoDWxZC5IQsLYItz5LymPzb+mkZkSP+2zbpbufSi6U=
X-Gm-Gg: AZuq6aJu6pcEm+S6HRW6vgsCCoDcdw4+lSb3xtDoTV1Vr3Bt98aExv8B09sjBlOp12M
	X4ZKYkBhfklONYJhgmTA/y6UVKBJrXkCH/MzcXAu3rjI1STvRYoTKnmFXmjZCSjH43r/qq/4k/F
	NQWB6HmIC1GJWWKzPCNR0n4fKrssOj61dP26WllDvfE+n7AEbqgGP7gFKQO4AL/AzIDroJUMFh5
	zkaWJQ9c/1rCId8RbHmkumdxs7UQrws/knVNuJJMOnapJmGJRz7cE1V7Tsik0G4MqDfZMZX1EUB
	KWuVAoe/6jy82oON25GUuospMdcUJz/1r7JUgo2ib+AtA6u9yhShD4+Ph/IX7vODzJxiLIJK4hi
	IJtse+WworjRA5dyDzBK4/pclH239Lh4atFvch339a2V+tS8H6VqkHddJVmCSF5vKmeugR/BPcF
	CE2zOORtDccA4SwIlh4mQmBaXq2ihA41bV+KnhG0SPjXcz
X-Received: by 2002:a05:6000:240b:b0:435:9a4a:9b79 with SMTP id ffacd0b85a97d-43618052a8bmr3855745f8f.31.1770207933548;
        Wed, 04 Feb 2026 04:25:33 -0800 (PST)
Received: from [127.0.1.1] (24.162.85.79.rev.sfr.net. [79.85.162.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f25dsm6377318f8f.29.2026.02.04.04.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:25:33 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
Date: Wed, 04 Feb 2026 13:24:56 +0100
Subject: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAJc6g2kC/x2MQQqAIBAAvxJ7bmHVKOgrEWG21hKYaEQQ/T3pO
 DAzD2ROwhn66oHEl2Q5QgFVV+A2G1ZGWQqDJt2Spgatt3NinKOfThenfLgdleoWMq71xAZKGRN
 7uf/rAMXEwPcJ4/t+BgR9928AAAA=
X-Change-ID: 20260204-afabre-bpf_tcp_sock-117d03c6f0e3
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
 wferguson@cloudflare.com, Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

We can already lookup sockets in XDP via the bpf_sk(c)_lookup_(udp|tcp)
helpers. This can be used to determine if a received packet is for an
established socket or not, for example in a load balancer.

But the TCP TIME-WAIT state needs special handling for this: packets
received for a TIME-WAIT socket can either belong to the current
incarnation of the connection, or a new incarnation. The only way to
determine this is to compare the sequence numbers.

Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
numbers to be read.

---
Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index f04982d79d72e92f1b46ccd87633391e38c3da81..5e3a1951130369f070c3a373ea649bd10db412b6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8506,6 +8506,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_release_proto;
 	case BPF_FUNC_skc_lookup_tcp:
 		return &bpf_xdp_skc_lookup_tcp_proto;
+	case BPF_FUNC_tcp_sock:
+		return &bpf_tcp_sock_proto;
 	case BPF_FUNC_tcp_check_syncookie:
 		return &bpf_tcp_check_syncookie_proto;
 	case BPF_FUNC_tcp_gen_syncookie:

---
base-commit: d95d76aa772bf94df353b015b1cb38303d4a415d
change-id: 20260204-afabre-bpf_tcp_sock-117d03c6f0e3

Best regards,
-- 
Arthur Fabre <afabre@cloudflare.com>

