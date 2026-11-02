Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582302;
	b=xstvkCHepVTEQClq2Yqjpf4GXVICDnYQ1ffi0Ev/hhsPyE2FJmXxFI2RYWRJwbn/KwRN
	 oEVyPMWcIDSllNIPSLoSnHxZhIcDvN+4WrvwkGnchLfxSgHtWXEw3QsqsHHxODD7AlzUw
	 G3Z0x2a9API4zcJCU9xdqHfSKZ2OiL2iRSkumr09xQt7PzGeD+5ssqiryfRRkr4gxNw1A
	 h+B+sJaUDDvbsDl4WLyQK47AIEWUJ+fxPMAihbt300Ucm9hj7FdRVoxfZoT5WUBiX3zLL
	 MJKfimjUGiD0M8UgTS2TurZD5Uz0Oi9nFogNc5ZikxW66S506xeQj/SIz9hz8kUgGTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+cJ3MC7LUXBbC4N5bF/0Djg1Hg9lFmBTuLmxj+Rq3SI=;
	b=HTU8uXGPzULwydIERqOxuMrYUR3dYIDKaC++HQEvMzNj8GnX14fUpQtYTSxluoiZsZEJ
	 CrPK3oHM8XIN+O+bpXyBlXW8BkkKNkkB/g1nrF+7b0w/e77t15KO7+Dy8G1faIXbITwo5
	 C8GdOgeT4F7ucuHgvP+HlYWz9wJfprfnAkGPxOgG+mrbImWiS82FHth92huHfIAw3q7WF
	 EdZiUkC7r1LzIVqpJA5PBFOrAgX1udbTy5vRlHb7Dwe/NTV1YW2G235Qo1lMlF+DnmpmK
	 WeBOn4U8WdarEtpqGPutcnPXwiCY3szi1Tkwo7VVwXJCe4DbzZNkIOR0W+jSopGq+qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=c2PXHs8K;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA1D606A324;
	Mon,  2 Nov 2026 01:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA1D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=c2PXHs8K
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNggX-008AQq-Bd; Mon, 02 Nov 2026 02:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=+cJ3MC7LUXBbC4N5bF/0Djg1Hg9lFmBTuLmxj+Rq3SI=; b=c2PXHs8KRsgW9UWcr2KfQHUaQE
	NNuvf3fwHRDgFlsPa01PTWBxCE9iCcqTLOjl5pGwfKFCufXOtSMCcu+ZUbGAX5bET2OkvXaQMFJAf
	NpU+jSHm5V2jwdapglOjf/F3mM3N1sUFbgOTi2raWCk3W+VryXuMz+XjvgCdGr4tuaeZo4t/wigaX
	PG7tm/p2XKpb1NvH/9oGvtM3Ux8wO4nbDpXNBcy41tMtKICFKvHapzDaGO2+gs5tbCxrnBd94aI3u
	vZ3ugY739fK39fwMGQN7bG5uvHfk9U4hGiWazMVNDTvT/NqL2djYvYzWO13CGWKe3KtatmxIMRAB9
	dhcXKSjA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNggR-0005s7-B4; Mon, 02 Nov 2026 02:17:59 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNggL-008JiF-Id;
	Mon, 02 Nov 2026 02:17:53 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 02 Nov 2026 02:16:00 +0100
Subject: [PATCH RFC v2 3/4] selftests/bpf: Add negative test for sockmap
 update from non-sockmap iter
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
Message-Id: <20261102-sockmap-update-limit-iter-v2-3-e96a63c43b39@rbox.co>
References: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
In-Reply-To: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenz Bauer <lmb@cloudflare.com>, Eric Dumazet <edumazet@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 netdev@vger.kernel.org
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

