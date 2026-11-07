Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074388;
	b=A24mBejIrmQyZg/3/zAHLuNukODVf/x0FjWRSpCBZyX9aN4UtMlqJcxPy3bX/dl3tyh9
	 LWXVAxSo5sgwryfQQZaKVawz0zmI3Sxc3tWD7IIBsQNiGBdyKis2BQOwHv3z4x1MBwHIn
	 8UI9EquEAsuhPOqDNlnJJnzYt+Qs+NQ3YHASzFBei2oOfASIR/fM1odhq39ThKnJ4FvnO
	 zC41rGdCLW0P6sInq1ORLYuu7Z4/DPKsijSaTmvUVmgEDEuXdCD7WY0aZ9IAQzuLpZtPu
	 4d5ECHaofcXHrj6pG4Cy5XBZFjj2bJSvRClxVwcejjPqM2W01819758BQq1pA7YlYIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074388;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=79FysFjd2dyWM4cbOMbQLuIbKRWCojV53uV/DjjCXlA=;
	b=NcwqSsgsnDwauxp13UjD8t2sljT9VmehuujX+qhjiRE65Wezy2el0Ij9zVwNH4jrIcCa
	 aNeME0uZcvWEJCcuLKcib9mr4A2KHPviMf77/Qp6xza4i8VpHSVXqHXQwPbTW//rBTP+G
	 Q6CfcWSnqX3v4sxGm+l16MGD0naKW3wbBEKTM/9oYKmzivHZqrI4Ia9CKgtHRA72mWWpU
	 4zqglAd3+Z4szJU8JTIXrX1omEWWAutBFv3+HJuzTVOwM9CZZmuRz3KzU2TBUfOYuJEdR
	 /NYasGTvveQSZ5rtKG8JOrqS2J2982JJauxeosd6lB53taD89MyZ1BiDVckqSFSANkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=CfYeAE4O;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC5606A338;
	Sat,  7 Nov 2026 17:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFC5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=CfYeAE4O
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhM-007oTz-Sb; Sat, 07 Nov 2026 18:59:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=79FysFjd2dyWM4cbOMbQLuIbKRWCojV53uV/DjjCXlA=; b=CfYeAE4OX5KfHBKRVmKR+1EMv/
	WCUDdgYn/LemlW0AK5ua22B5SOjTKOsRov3VZsr4+lGiBa8Thc3ub9NXdWukhHzfBv8BL6VlbjdHs
	uz+KNYO9g5wzNwWkURgu5lxSDIsLFOJuiQe6rxqa6s8BUzU1lr/SlWgUSCQILEGDKDl+fYJwPGSB5
	OvJnA/QKJox5KMW2i4qDBqmmX2P7Nf2w79G9cwNkdAWCJ6r8ngDFTaRPJ0PU0iYLpEHZKI6j6Cj4/
	0XREUBGFxyc69nyLyD8U93rxRF346xt+ZKYiCTN//puCA+f6YmExXw3ZprNrvM2j8dym5tvHjyPt+
	7kESatKA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhC-0006I8-Gl; Sat, 07 Nov 2026 18:59:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh6-007LnK-Ee;
	Sat, 07 Nov 2026 18:59:12 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:27 +0100
Subject: [PATCH bpf-next v3 5/8] bpf: Restrict bpf_sock_destroy() to
 iter/{tcp,udp}
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
Message-Id: <20261107-sockmap-update-limit-iter-v3-5-7c0bad1ad036@rbox.co>
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

A subsequent patch will mark bpf_iter__sockmap::sk as PTR_TRUSTED, making
bpf_sock_destroy() callable from the iter/sockmap. Unlike iter/{tcp,udp},
the sockmap iterator does not run progs with the socket lock held, so
destroying a socket from that context is unsafe. Restrict the allowed
callers of bpf_sock_destroy() to iter/{tcp,udp}.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/filter.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..6a67bc2a0c4b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -13072,11 +13072,20 @@ BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_sock_destroy)
 BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
 
+BTF_SET_START(bpf_sk_iter_locked_ids)
+#if defined(CONFIG_INET) && defined(CONFIG_PROC_FS)
+BTF_ID(func, bpf_iter_tcp)
+BTF_ID(func, bpf_iter_udp)
+#endif
+BTF_SET_END(bpf_sk_iter_locked_ids)
+
 static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (btf_id_set8_contains(&bpf_sk_iter_kfunc_ids, kfunc_id) &&
-	    prog->expected_attach_type != BPF_TRACE_ITER)
+	    (prog->expected_attach_type != BPF_TRACE_ITER ||
+	     !btf_id_set_contains(&bpf_sk_iter_locked_ids, prog->aux->attach_btf_id)))
 		return -EACCES;
+
 	return 0;
 }
 

-- 
2.56.0

