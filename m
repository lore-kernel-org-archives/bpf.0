Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582302;
	b=lmp0vH6cuHonB3wxwWZjfzWsaVEKiDCFdzjzGGuSiKLnpmBt/VM3zaBrwJyO4Ob5tudo
	 vZ/sKYJ9/YJ3B/4+F5LGQ8cD9WhhCWGwWW0lZrX0j8aAbRtAMz43iyDE+9Ku9skgw3pY9
	 PgSSifculq21j+Nggtk200neYKKs3CRy1I8tQUYZICiLFXtwTn/dL7TaOJGq+lqs3wd38
	 59ZuumrSkEWAw/33B3YUDqh0cFyIfD++mXh+OLl6wc8Ts6ySYG9k+sGZ3PxNW/7TdQkgy
	 Uj78BIVD4+7uTPpVrNVmKqdDO8CncQPibWntvLG7m+wMwT647BzGRwA9VVm7F+6tkPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=abDysjfJOJSeYcrksOHfSG7PBUExgzQghoPikxkeJYw=;
	b=NPkwBRlsJMT5/GMBckrhgJaJIpvZXo650xqgP8vsj/wiZqjRGwBAZQ+KGDP3kahFSaOk
	 6QtEGNVzgIxOXhSS4Aa6e3h5W/GpUV/VX5tdNIZnas5Hkz4sGtxKoK7c/9BrbUFBWtzDE
	 TDpDoqKvyrKNG2K51Gbr2nd24CWZqqKic2ZRchKO42ctdfJRx0fvjEJPt8RR69Z7VTYNK
	 +D3HxFBi5GS3548A7Pk2YCnVvfhu/f65YNF/qPIoOXn5itrr/HJZh65FzdhHc43n1BSob
	 ogjxNOAYEksQp/C8jk+SipEYzwm4rw4GWUYQJczkdQ6kL3FBHtbEfUQ9dzy7sa2vJzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=QEP3kDFT;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB599606A32E;
	Mon,  2 Nov 2026 01:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB599606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=QEP3kDFT
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNggX-00AGXd-7L; Mon, 02 Nov 2026 02:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=abDysjfJOJSeYcrksOHfSG7PBUExgzQghoPikxkeJYw=; b=QEP3kDFToa87gPnr8gtagi/Agu
	7v3wk+Nv+ov+Aix46JRYvBB+goLTUmhDPZCxbYHbh7h4DS2RLiIfLmfSvDSrrPqEcTGMsq/tFKDCA
	5ptVRBQRWQFyHr1UgsBYZDvJJoRWvoFSAvyRbhPLxI4PjLBEhp/I2ALMvP3Z2XYHykR/PNggQCqYo
	FWIjrq/b9My0Rf1RzwXBVzxt8d36QiPNBL1qbALQbo5Y/cc5giD0kGtsNIsku9YljuKjBhexJ/PEY
	zc0J1d5Fg38QvVZ3KtJ4aS5Ir4qXOKFoHZ4hkYYIZI/pBciCpuh6vtZF2Ayvz+cWQPBuHxdfbSZvr
	DCaX7WUw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNggR-0005sF-OW; Mon, 02 Nov 2026 02:17:59 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNggM-008JiF-Qe;
	Mon, 02 Nov 2026 02:17:54 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 02 Nov 2026 02:16:01 +0100
Subject: [PATCH RFC v2 4/4] bpf: Mark bpf_iter__sockmap::sk as PTR_TRUSTED
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
Message-Id: <20261102-sockmap-update-limit-iter-v2-4-e96a63c43b39@rbox.co>
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

In preparation for plain-PTR_TO_BTF_ID removal: allow calling bpf helpers
with sk provided by iter/sockmap.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://msgid.link/DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 057e2f3c0265..2a2a07372818 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1989,7 +1989,7 @@ static struct bpf_iter_reg sock_map_iter_reg = {
 		{ offsetof(struct bpf_iter__sockmap, key),
 		  PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY },
 		{ offsetof(struct bpf_iter__sockmap, sk),
-		  PTR_TO_BTF_ID_OR_NULL },
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
 	},
 };
 

-- 
2.56.0

