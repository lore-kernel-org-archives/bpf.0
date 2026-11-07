Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074387;
	b=W6P2RXI4PFC82B7BjRIQoHvo5A0AnUA6dQNeVpI1fbkDmdBsO8VcDQt6K3BICUWiy7QK
	 h1PWlnb4mlWGDn8Ea7+AAZ3VxDOgKON3pVnEQe4CZc7AMQNiKsomr38Y3xH8scu9+YhGE
	 M1omEx+x0IqdPiWOcWWU8VzRvPTRL8vBEoDo2uAfKARYcm5BNsUfonQzmulbfBT+2TFzB
	 p7PNCZStdz7dF6Njq9H9m3bibW/QvRfeatLWqXSfC+keL4959gKIEqQq8A26FXBWdQO32
	 S2fO6RJCKu1qbueksQni9w3njD5f33wZuN7OT9ubVzmzEGud17U2BMn94c8XYnF2fZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074387;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+cJ3MC7LUXBbC4N5bF/0Djg1Hg9lFmBTuLmxj+Rq3SI=;
	b=y4w4ZSRgTT9K/GZFSwPWyHyDLHWyRdJRIDXcYeG3yAZ74JoAqrTm5xDY+j6fikp41h4A
	 uvS9D8KSR/XWIZaJcB6vnA9PeTWGD+zbWXlgnBWK51BJVSazG2kzz/r2P59g6nxWaRvYW
	 1Z73NjXouTlj30UPYJPvpTfC+TaAy9nSgM5EUnmg4wicCmBH28jqR5iLrX6qVi753YPw3
	 MOs8H6XLS19HcYQfZX19kLRu9XQBjf1GFjC9bfiL1BV50vkFEXHub3Dzw26hht8uPuXfi
	 Lzz5kgg2WRhBxMrrxK4a3aOFF3QiLO2rcJ9RsCRIZPSNDw4qkptAFke5LVDOooQBaFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=wpYScCIz;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B60606A33E;
	Sat,  7 Nov 2026 17:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B60606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=wpYScCIz
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhM-007oTx-S6; Sat, 07 Nov 2026 18:59:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=+cJ3MC7LUXBbC4N5bF/0Djg1Hg9lFmBTuLmxj+Rq3SI=; b=wpYScCIzPC97U4nSU5l2hXFrnK
	okbOpkoNYSPUm7S23aDRjtE6AaJzWO5f65ERMT5E5JTGw+xKtFNAAcJdxSmGLpwrIVOjOYnMogf73
	q9TLrqKY3HIOPSbi+1WWvYHM0a2/MswqKtwY/h+0aHPy7dtLZaioF9SN7p3KR4kYFOUCLopJdfoNp
	f0Wc4/X2Wtys2nhkTRCE+laTyEniv9qfqQwt/nmak/DyyoBnNOs6t7uQHG/ruKU4DCLgp1VNCdIJ5
	tczqFqPrs6l3kblhBrrrOYWJxEuWu8LGYTG82/29PQtUuaL4pCpISaTpcXfje5JrJok3HXpa83EJZ
	Fxubv+fg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhC-0006av-7l; Sat, 07 Nov 2026 18:59:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh3-007LnK-Ez;
	Sat, 07 Nov 2026 18:59:09 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:25 +0100
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: Add negative test for
 sockmap update from non-sockmap iter
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
Message-Id: <20261107-sockmap-update-limit-iter-v3-3-7c0bad1ad036@rbox.co>
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

Iterator-context sockmap updates are now restricted to iter/sockmap. Add a
test that attempts an update from iter/unix and expects it to fail.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../testing/selftests/bpf/progs/verifier_sockmap_mutate.c  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
index 20332a731d4e..1516fe1524bb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -19,6 +19,12 @@ struct bpf_iter__sockmap {
 	};
 } __attribute__((preserve_access_index));
 
+struct bpf_iter__unix {
+	union {
+		struct sock *unix_sk;
+	};
+} __attribute__((preserve_access_index));
+
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKHASH);
 	__uint(max_entries, 1);
@@ -113,6 +119,14 @@ int test_trace_iter(struct bpf_iter__sockmap *ctx)
 	return 0;
 }
 
+SEC("iter/unix")
+__failure __msg("cannot update sockmap in this context")
+int test_trace_iter_unix(struct bpf_iter__unix *ctx)
+{
+	test_sockmap_mutate(ctx->unix_sk);
+	return 0;
+}
+
 SEC("raw_tp/kfree")
 __failure __msg("cannot update sockmap in this context")
 int test_raw_tp_delete(const void *ctx __always_unused)

-- 
2.56.0

