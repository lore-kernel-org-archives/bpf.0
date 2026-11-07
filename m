Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074384;
	b=iTAxVjuWIqljSu1Apj002l9fF1FgV7HAh/QYNZMgp7SCT39rtGP5h/C/NXJ+Z94ZBItg
	 ZLYLs4igdu0GZKebEs7UkKV/jEluRORd7GZTXpDS3PFHsHo3MfiC2epOVc+7biwpXHXaP
	 sdZqUu48L+tnKB6w2cF0ym6KtWbiWD2gallYd7pp7Bz0Nuy2/37tYkg/GXAX9scybCfRw
	 8g5BfJ/gT7jOjGjStbE/4kNAed3C23mTrb+d0emfquU2qlf1MM2iyBeSGID5NSCSUHODv
	 jbx4HPrNCEDvosnkw01H7MVfSNxGAPyQ9AbVjNE95Ba+53KWIQD/hKGlj0mYnkuv84A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZddAGYbDrtSr+CZdnQE/HLJuPzfHd++uOjWgRuABxX0=;
	b=HHCg7tVDrHDJ0kwW0h0J6w58QFkmVqYRQcd54EXH+TXKI0UkHEuU7rV3wNiFs3cyCY48
	 maHO3x8pDMktZzqNpUclE9Plk6qSkd6IAL/JhDAJK6/p1/LE8P2q66SNSR7UlbYM1VFZe
	 EEV/DvhSLw1939IpA5qjn4hWrMF0ISPLzPYHEVzMsn60hpngFiOCTR/RpjhJows9cIM6E
	 d+A0keMMA8F9LLqmJA/59Ee0f2kYaalBNApF4btChARZSd3jiWHlxkIBZSJ3ITJA/9XsZ
	 LAsouIRub7tpAvQyynyDUAd2CI0SzvfU/wDaGKAADf8+adsFtzT/mq+E93nttvM+6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=XSqh9Eil;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56499606A33C;
	Sat,  7 Nov 2026 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56499606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=XSqh9Eil
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhN-007oUB-Ku; Sat, 07 Nov 2026 18:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ZddAGYbDrtSr+CZdnQE/HLJuPzfHd++uOjWgRuABxX0=; b=XSqh9EilYmJJTJX9/aMObcVdwM
	Lbb6L5s5cCzVXLwEWNOSm3cYJ8Lm1c/4oDiCVTgBvPiPmlHHUWqouBfDa0n3OJXoIQuWwMxb5nrfe
	GXOGUFjr6boTr3DdcRSqb36LVX6OX/LcK55eTMgPITwflp9Ps4jo8+wK+6mAubfTxPNUWIX/uxkeR
	m3DrwkaNpb5dGqs0VwqZqnPSclxfGjjJVV4OvTDZcuBcuyAo2qIOviPwf/MBxkY9r+UL8Gpr8Ktym
	FxDp1+5FaevypkLqjEYZXYwubCjAy8jj0ksnOIxPndvwo+8g2HIFQIUqbIc3PwqoEZTltZ/sfTYuC
	o7IVq1Qw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhD-0006b3-0W; Sat, 07 Nov 2026 18:59:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh0-007LnK-Dn;
	Sat, 07 Nov 2026 18:59:06 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:23 +0100
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: Remove sockmap update from
 bpf_iter_unix
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
Message-Id: <20261107-sockmap-update-limit-iter-v3-1-7c0bad1ad036@rbox.co>
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

BPF iterator programs that can update sockmaps will be limited to
iter/sockmap. Remove the update from the unix selftest.

This reverts commit 997b8483d44c ("selftests/bpf: Extend bpf_iter_unix to
attempt deadlocking").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/selftests/bpf/progs/bpf_iter_unix.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
index 3061b148f338..90beada0386d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
@@ -7,13 +7,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-SEC(".maps") struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} sockmap;
-
 static long sock_i_ino(const struct sock *sk)
 {
 	const struct socket *sk_socket = sk->sk_socket;
@@ -82,8 +75,5 @@ int dump_unix(struct bpf_iter__unix *ctx)
 
 	BPF_SEQ_PRINTF(seq, "\n");
 
-	/* Test for deadlock. */
-	bpf_map_update_elem(&sockmap, &(int){0}, sk, 0);
-
 	return 0;
 }

-- 
2.56.0

