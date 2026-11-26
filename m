Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711342;
	b=UWjApRf9vuJKGJHF9e2VAkJ2baZoK8L2bzVHgG7RtQ/uWZTVn17yiA5dvjd6M9B7pd5k
	 +HKVJm8Gakw+NlUQLU2Pngfre9cKUm1K0981YFMG/ubNueLfxdTHyzyFGXFXtcH7ocXoE
	 +RbMnI6ObpljhPSANC9+y9Bw9I6wxPLjqPxnlukPOm4XTld8JzwFjoOwjihZXcBeLvmUJ
	 fsZs3+iz4F87KBInCIo97GYipYLLjzRBt+Q0E/JQ4YjxhzMmkkmv2OfRo4utML6zMYXQ/
	 y9xNn43tx0wb0ark0I893I19fFJF6LuIo6FVp893Q1k+0jq3sX2J2Jp8ilFGbw74QYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vYLe6Aye6cjPeLVGkLhVr6tiV642wkKY+G+lAL+UdWQ=;
	b=efOQN9c9D3i1S4vhhdzoeHHOat9rq8ghsx4ZAD4pqiHvwasUicUVcbKj9goQMAzoBtpw
	 YZntl99zFh90uRplhkKDThq2NbM/3mwhlPfMcl90SKaCQXh4i3PjYUIJhGW82igyTrCdX
	 ehCNjiTVHlN1jyzssHQVfvSFo1XdO92GNRPOsIEc0XrtweWVzVr6Zoyhjx9R+9MQLd4jN
	 Wi3j009E71Ud0gc0NQTrhn3xZ/KePFCZ6Ku+EIHpliHXZUwCZmYKH4pX9nUMWkT9sGsRW
	 YeQV+QFS1j+TWsTPDjl/aB5TcGvmygyefgQ/h2b1zZky7wmklyuerEhSmNWMoLDsGbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ItlsisZg;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B760A3808
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 16:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 870B760A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ItlsisZg
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso15255320eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 08:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795711342; x=1796316142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYLe6Aye6cjPeLVGkLhVr6tiV642wkKY+G+lAL+UdWQ=;
        b=ItlsisZgBsbLBK1VgS9ZB0PlWxT8mDUjm48+mrCX79lYJPOQ8c8rj5gbKOZZyF8KFM
         jVOKBW8PN0sYgzM7Wi03VpnArAY4AZH2Xk9NawKQQH//EEk9tKpTuORygFksVccHbxci
         MpeFeEYhAGypWCr/SmSEyOp+iyiJwNygswDunFOFPW/DSLJy1YzIqaNxtflbATlqzVK0
         sLtqS6AM+InztaTEtkj2pUySpHkWJVyp6EcXfTLb6cYjzuY1qViGLXM1rT4LAdJpw3s6
         5sxHptkWlX/8QJwLFOkHyesTb7NZ8DoceMB9axxcXNBHubMq129Y0H45vlCxabz05NI3
         cUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711342; x=1796316142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vYLe6Aye6cjPeLVGkLhVr6tiV642wkKY+G+lAL+UdWQ=;
        b=OrQzzbEm8iM1zN4nqdDK3w4nUu2PgCnbu01VeRvHUIyQZ0isxE7n0CwNucGpfxblaK
         eJ0k0Ier78KVLUrgXzhxYG0lkrlZf/6P7WCpDNK+H31UKZtlxLZsYQcWiZ0JykKBG5yc
         ZULWy9fQg4W8MtZaSmHGo9fXp0pSZ/H6NwGpZ9g6Fd7ASo1oDmL5srvKi9Iv5rxRcmDo
         4t7QO+ZrJjUPbTThSaDvg/BCfVLXwDJ/Xo2augvokeu1j9DAGyC9PicaqPLVv4gR9zq7
         CIk/Vbv1tT6Hu8UAT1NlvUYd9e2zMMAVAlvk3/5cKUPE2q2aZ+Ba+5qtOCHIVnwQl898
         G08A==
X-Forwarded-Encrypted: i=1; AL+hErHU2g6kaIIKKso8g7lw40KACd09RHE+vCQynWnBIqyoSGQ/X6UAbtJ8LQKLidaxnICK4Jk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xVOqICQOX2p/A3CaQhytwQoC+5Zb1EW+rfia54q6kfrB+/kP4
	a+H94SFbwrLJo9MrBBIRXSQ9Lntod//V8zBIhdKoxlBBMEc7fexQVOZD
X-Gm-Gg: AZFdTZeBM/OgtcYDWy8h5OhVlrfyLD+IP8dVvRovA5B5OtWDlVdWb4XhL190/cE0Pjk
	bJ7UECvZdumkp0g5HEGL2H7ELiu3e7mZnhgiR4kBNNF+AbEyayRuodT7ZxZjlCfi27liXRv/QLK
	J+Js2M7ECNFC5PKoW6AWh8B4Qjr0V0CpzY2pqGHwPa7l+XEt+PtKtkSNgXmGWkdrvIV6tEMWSuO
	4FKyg2651vZYbAGNDnBKhHzMpKFZThJyx4SBSkC477rOszr1kNvzUJNOou7wflDZuSk24s24RzO
	LgwftMk2bYRCTayGr+PdMxcptJQcon8iF42QFWIru6IpFnVVYyqsue9yjJ8gNv0ihoJ0PUdm66e
	+qSu2HVZPNcCtSaDu/ayXw9/3TO8QCyz86WwnJzMMVJhsQKcRrEFSB2+lbJ7KAyjWvI+jkAq0yl
	aroIH5UCtAyFIG68q1XQ+vxKC7tQCk8AAtZ9IR0OWR3V7qDPUi69LesA5o8YFYfGyfiN+Kzyn2Y
	ep0HXU9D1sVqoQNzU1Z7AUG9Yf2ODcr0ZASFUzmIDuxYLJkC4aF6pgymB0NfSz0VRIDVw/a057x
	RYv6tf2SS1NUFQRJX6/0RLjTEIYv
X-Received: by 2002:a05:7300:c3aa:b0:385:c28b:a4d5 with SMTP id 5a478bee46e88-385c28baffbmr22699614eec.17.1795711341575;
        Thu, 26 Nov 2026 08:42:21 -0800 (PST)
Received: from ubuntu.. ([2405:201:8026:213e:d3fe:57ef:a814:ecbc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm66709770eec.28.2026.11.26.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:42:21 -0800 (PST)
From: mdshahid03@gmail.com
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	willemb@google.com,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH net v2] tcp: fix division by zero in tcp_cong_avoid_ai()
Date: Thu, 26 Nov 2026 22:11:50 +0530
Message-ID: <20261126164150.8838-1-mdshahid03@gmail.com>
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

From: Mohammad Shahid <mdshahid03@gmail.com>

The tcp_cong_avoid_ai() function divides tp->snd_cwnd_cnt by
the argument w without checking whether w is zero.

Since w is an unsigned value, the condition tp->snd_cwnd_cnt
>= w does not prevent division by zero when w is zero.

The function is also exposed as BPF kfunc through the bpf-tcp-cc
allowlist. The BPF verifier does not enforce a nonzero value for
this argument.

Return early when w is zero to prevent division by zero.

Fixes: e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 net/ipv4/tcp_cong.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 8e83ef81fc18..f70f49b4b1e7 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -469,6 +469,9 @@ EXPORT_SYMBOL_GPL(tcp_slow_start);
  */
 __bpf_kfunc void tcp_cong_avoid_ai(struct tcp_sock *tp, u32 w, u32 acked)
 {
+	if (unlikely(!w))
+		return;
+
 	/* If credits accumulated at a higher w, apply them gently now. */
 	if (tp->snd_cwnd_cnt >= w) {
 		tp->snd_cwnd_cnt = 0;
-- 
2.43.0

