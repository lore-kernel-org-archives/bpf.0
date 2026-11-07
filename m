Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074383;
	b=vz13mwikPPVqIz41HrDtmPKBHRSRxx5m76B2+FI/4BW4ukkZiu9RNAQmyYfk3HVoxy2w
	 vSnuDR2l1Rk3AA8gchWKmfwxKeZVX7faAhwWjxaz3MA6Asiv6LFG6t4ovSZzt1UQbI+2S
	 pCI4BI3ucDvB3pLahxpXprHaF2COt8hWfQ51TzzhmA/rk0p1gXQOHQgN+46NqxxsOP46L
	 IhekLzc68N/vd5tEKRW2F3JD7eryHtMmQm7HAUwBjeuszKPhETdJHS0zkjItpDHbkBaYC
	 FtrrcLF9Sb9qVoyaaH2I/cyncQY2AR7NV54LAuIcCBd4qImvooYylZMMK8t6XuRueww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074383;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+sOGB5lb2oiDR2pVte8gE4CcBLvveiaJEtksFCZ6wwI=;
	b=3QoRDEoheqVEm8EjFlaFC3z9CxadzOgGaooK+shyEMFhe9G2JGr0FZeu1hMFwp2Jxo7P
	 Bg0BdqzxxkShnWZAFNyKgl1CgzGrVSZOy1z6VtBd/CMDl7RSXlwpCnyWdEvgUX72KvJKs
	 pO4oUiwdzsfE5xJzHjIPKMGkFpsEZWPhAKjEoZefWw0VzyMQ1UZWQB/E8hfcyKputrLGp
	 TYCNi0nkhILMpCdp1aSV45KilG2tz1pl/rLBtpvWYLOyx5eWAtsSOUbPvCGAFhY8Ob6Lt
	 ElNi7q8ttOksDWA0erFEzjZnsbwb4qCD2BAX9aBmOkfyF8ehNf2tV/yuYFvE9Ioui0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=xDY+Dzg7;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EE606A330;
	Sat,  7 Nov 2026 17:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A26EE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=xDY+Dzg7
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhN-007j5l-G9; Sat, 07 Nov 2026 18:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=+sOGB5lb2oiDR2pVte8gE4CcBLvveiaJEtksFCZ6wwI=; b=xDY+Dzg720FHSgO6gJscshGB1F
	iEGBF5XtYLBoeSPg+5+9pG5Q9MHbDH1wNhh9Vu5PZkvD6D2n8uCqrwkbNhi1/u1CK6If6e002EwNu
	1L9VrG03D+8cQBxGQsFim8qs3gH7STN1ZA8RTvT3M908BXtVm/OAptwK4WHlZu7ES/tNGfTD+rkHL
	hM09NtFYZyPqgwAq1DWMF1XMeen1Ftt2ctJbn+7eIPdnFSbvCLP22aVTNddSWr+mfLOHgronrVV1p
	m+getDbUhjameJbwET2jR9yBoSjmr466DK1bi2sMtKMzd4rzxs9q5C5ka3Tpjukp//322RUfNRt3x
	yrSc/AAA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhC-0006az-Og; Sat, 07 Nov 2026 18:59:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkhB-007LnK-1s;
	Sat, 07 Nov 2026 18:59:17 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:30 +0100
Subject: [PATCH bpf-next v3 8/8] bpf: Fix "unresolved symbol
 tcp_request_sock" build error
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
Message-Id: <20261107-sockmap-update-limit-iter-v3-8-7c0bad1ad036@rbox.co>
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

CONFIG_WERROR=y CONFIG_NET=y CONFIG_INET=n build fails:

    WARN: resolve_btfids: unresolved symbol tcp_request_sock
    Failed to generate BTF for vmlinux
    Try to disable CONFIG_DEBUG_INFO_BTF
    make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
    make[1]: *** [.../Makefile:1379: vmlinux] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

Handle it in the style of commit d82a532a6115 ("bpf: Fix "unresolved
symbol" build error with resolve_btfids"): force BTF generation.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Technically, since tcp_request_sock embedds inet_request_sock there's no
need to explicitly emit for inet_.
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6a67bc2a0c4b..b86529dead65 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12391,6 +12391,10 @@ const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto = {
 
 BPF_CALL_1(bpf_skc_to_tcp_request_sock, struct sock *, sk)
 {
+	/* Ensure BTF for the structs exists even with CONFIG_INET=n. */
+	BTF_TYPE_EMIT(struct inet_request_sock);
+	BTF_TYPE_EMIT(struct tcp_request_sock);
+
 #ifdef CONFIG_INET
 	if (sk && sk->sk_prot == &tcp_prot && sk->sk_state == TCP_NEW_SYN_RECV)
 		return (unsigned long)sk;

-- 
2.56.0

