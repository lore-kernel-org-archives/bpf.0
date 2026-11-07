Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074388;
	b=ZM0NyZQQ+dbQcxZ8+3Aink/N3w/7jNBnMaDe54IFJEvXmlVPPzfDvTJcDN2EgbKD31o0
	 /GCpHGsRk0yvoCH1ZDufPlJuQ9WWKDthZKvIa/xq0SCq8Ur6CfJaZcVOXn6h7GcrstiFk
	 bGnWCFaog5Wwe0tNoidQwdHBgvroaBaSY0PfQWnwiPqXjl3TUo7tV9Vnwk+X9j9UQT/8N
	 Vb/We7yXRXsiuhbDOTwglGezqpA/BgGr09qKOMi+g/AvCdddWwTREyvtUpFDaVcOCP/ri
	 /D9DFO0MJpld3qEs2L9Z8mXJ0gP5sqblFxXYYXxTqUWXGu5n/Xxwl6JHX9oDTLZJ1ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074388;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mYH1R7Aw1iVn3adjIX8WOzgpUmMHsc4YqOxn33DMKdI=;
	b=vQ2+kfEQKsm/yDK96up8C3iG4nzBfa57iK3cgXYdFb37Iasy47Pao3+rGJggekEErVGl
	 WI+XUhGXyVrTvt0YyoC1lHtYVjRctlvn//AGpHNs4WXAcA0vMUjM41tjhVCS19I2P/IXg
	 wvhuBIHmWRPf7hBcdpHC54gFkwQ7iKv/o/JdWwXTf5NlblzaO/ZfGMcM9ozEE93NO/E8b
	 nESx9vANDfBzQ228IVCSYS71h2yY+lePk+Sk3PL5lkkjTdrEJdo+ZQFMTyW/j9lRSG4+I
	 1aFq61BU7cXyPRamy0fioePFXToA2BJ8Epxt8Ymu4SAvpmd5Ea6+jC6daJr1BzSrokQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=ApioPmNb;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC141606A33B;
	Sat,  7 Nov 2026 17:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC141606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=ApioPmNb
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhN-007oU7-A0; Sat, 07 Nov 2026 18:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=mYH1R7Aw1iVn3adjIX8WOzgpUmMHsc4YqOxn33DMKdI=; b=ApioPmNb4g0URfQcNo+bHmOHqK
	lTCpz72XYQOXsE8r37ukCxxZ4ct+0WxzIa4l00p+FMV/HJL8SiVqkyr/c/Fhwg6MoDLA8xmdJgHqs
	CX2Z7ubgIt1YCHwDT2M+n5A19z2aLGCnBS3FG0OhL/t68ExBOyWnq/tFFhBey0b298x39vlMdFml9
	3VxLa23xI+dNwM9Vjboi9zM1sy+ZJYFp0v3ZYCD5kjRnaGn5TBWZ/Uq6F90pJT+bxFEZW/l3cGHtp
	5i4D+qUGhYfc0qz03AFQUrrk6KZ3iFHcRIZGqic9cWP8Da+UVZzyQ9U4MbuRzJxTyKmwsPDlak+3J
	KmWPG5TA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhB-0006ar-Ri; Sat, 07 Nov 2026 18:59:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh9-007LnK-Hh;
	Sat, 07 Nov 2026 18:59:15 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:29 +0100
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: Add iter/sockmap
 bpf_sock_destroy() negative test
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-sockmap-update-limit-iter-v3-7-7c0bad1ad036@rbox.co>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

bpf_sock_destroy() is restricted to socket-locked iters, TCP and UDP.
Fail attempting it from iter/sockmap.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
index dd6850b58e25..7b9f5779a184 100644
--- a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
@@ -20,3 +20,14 @@ int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
 	return 0;
 }
 
+SEC("iter/sockmap")
+__failure __msg("calling kernel function bpf_sock_destroy is not allowed")
+int iter_sockmap_destroy(struct bpf_iter__sockmap *ctx)
+{
+	struct sock *sk = ctx->sk;
+
+	if (sk)
+		bpf_sock_destroy((struct sock_common *)sk);
+
+	return 0;
+}

-- 
2.56.0

