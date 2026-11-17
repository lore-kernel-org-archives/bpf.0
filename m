Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943831;
	b=larqVKovQ53YPUHh+PXJDUXr7PmZOsdkxyGCusWhdT+vq1Fovny7tfzE5olZj59dZKOS
	 SacuNfdiLnF4NEW8lqCm9CC/Q0KOSotSO0mIcFzypFKetFwlqCZVZr1bMxGlKODhpLlbP
	 76m/OPhi544cblDljdiNLP7/Fa8u23dq3WZvcOrjRg32r5boyYtjBpsg5m+tqSkyyeh/C
	 6eY3TiCwGTRgdHvtO1iw/wICmDKIqELq1QodKkEJX7u3MGExx87f5tuSgBNUqUNy9EDG+
	 WjwHy+LpwvqLkvBt2TVzJ6TShw2pH1FvpNAN6hduL96cYaR0uNG3GsOFR+1v/+iMSbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943831;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=vDzK/5X2Ogr9kNQjuXLS2GZMirjcfJzOOHYV6KRLP44=;
	b=E009wSk1iPPDuTzEoEB+f+C3+zc1b5FwGPAoYpf41sPQcHqe7WLWwQTU0bzDvLRH/bL9
	 ii1bvHMOZa0zCYXZPI3q89U2uASrLA/jmL6awtukd3YGHcTP+4iUQZw+zg7utEcPZ67sG
	 sav5CFCY2wxT3Uo1xrFPsi5Iqj2j3e9Ihxb+W/+gTniBXOfi/XtkE24LOyIohvYe5QA+z
	 yHQLzJZYhi0oFdaWprotqeLJEvPzGoR5qcnsfRuyaUK6wpT98YBWjSQ37Df7VgvnvRGEI
	 Lp2TLKU4yPobYf4V4bVaN9nAO5Qe8NRGENBKIQotoADU+ZwT+V8DixBBhvIbQMvufxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="Lnh/w4Rl";
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91EF606A33F;
	Tue, 17 Nov 2026 19:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91EF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Lnh/w4Rl
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ9Wh8740559;
	Tue, 17 Nov 2026 11:29:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=vDzK/5X2Ogr9kNQjuXLS2GZMirjcfJzOOHYV6
	KRLP44=; b=Lnh/w4RlRhaG4N6nyc1DFwrGcMiXkUsXKgukNwGbMh+xnsaMTuQpx
	ZHdb+ka7mmOcwlTF9BGMO5zfbqKHvwTic2WkcDXQEcTbfddU3GiyoHTxnuHcsn+R
	aihgLE2NU/HuQBy4nZlRBmJfcUriXX8gUuvbma1HN+Dr3U7VJSn6G7ogtEwoiYCP
	iP4W9dgtY85RI+P/RuCiZpVNlTyqDG28f2fMHDmDPdw2hyfsQyfpB3OZgX8VJvKR
	cgH7Lf4+FIIzbOBLQEXl3ZeUUvTnbzySWJ2b2NJzMS3QdixRjcKxA6DM8jAkL+Mp
	fGrgAzdO+Aucw/ZXtKP+lNcSrczs0xpyA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0r2u3nnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 11:29:31 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 19:24:22 +0000
From: Todd Freed <toddfreed@meta.com>
To: <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Wei Wang <weiwan@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko
	<jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav
 Fomichev <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Boris
 Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2 3/3] psp: only give time-wait sockets of PSP connections a validator
Date: Tue, 17 Nov 2026 11:24:11 -0800
Message-ID: <20261117192411.247117-4-toddfreed@meta.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261117192411.247117-1-toddfreed@meta.com>
References: <20261117192411.247117-1-toddfreed@meta.com>
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
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fuhJ914f c=1 sm=1 tr=0 ts=6afcab1d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8
 a=gxZvXKzzpFbKsGQtWD4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 7TGuGGhg92bHct8VuVKRvtKR4evfqnpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX47SlYJSEqV3x
 ZyoVtD+42qewQ7pHFPBtWwopul4QalVAcYw3IV0iCVaPMH3FAJ2bZTlEVBQi4qi55N6Vh8ZllVG
 ph9k+6IdkhBWtjyhhuhTuqaQ4+h/1gc46rh6HT35yR0kHM//mTva2orJi+ahrauwek0nUDvpt2Z
 PSgv9WzBNFIHVxGrVtiG496zOrfrCBp0QRNpoVkV0uk6ISBSGF3bJ7p0/OSauy+NyCqLHBV0qdg
 XxxhgUSQ2PpqB5i6hNoUQeFMtDwNw7zw/dmRwWXJO2bERuwFULTxKjd/qr8iza4PP+NmGvZZXtf
 WC5Sy/hEwcuYCzQr8TbrYo0WM2fM8LXwcHv9zOn/WaTQn70p/0bX/azs5w+aB8RnXazSSHFOX1T
 H1DDPraKsVExHsL+lJEg0fMM6S32LqRT2hMH9DgZwUVLqpjsFGVEvGBqzD9Zb+wNyJ+F9IbIgF2
 41LTkUndhJy/jUOQ3SQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX0vPdHjS6a2/i
 JNOkh+OtGn94rkeHeaoSQw8NtfPjZxz8EzWUqFuSMCy+3TfRxeUrIuGSZJwkm8cjVLXR+R/WRVT
 w+h5EP/3dndu7zYzAXRWWfIqQTbfH4A=
X-Proofpoint-ORIG-GUID: 7TGuGGhg92bHct8VuVKRvtKR4evfqnpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

psp_twsk_init() sets tw_validate_xmit_skb on TCP time-wait sockets.
Today, that becomes set whether or not the socket has PSP offload, which
is not needed but is harmless. psp_validate_xmit() passes such packets.

Set the validator only when the socket has a PSP association with a Tx
key, as psp_sock_set_tx_key() does for full sockets.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Todd Freed <toddfreed@meta.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp_sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a6b1c42dd626..5043df0bf711 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -314,10 +314,12 @@ void psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk)
 {
 	struct psp_assoc *pas = psp_sk_assoc(sk);
 
-	if (pas)
+	if (pas) {
 		refcount_inc(&pas->refcnt);
+		if (pas->tx.spi)
+			tw->tw_validate_xmit_skb = psp_validate_xmit;
+	}
 	rcu_assign_pointer(tw->psp_assoc, pas);
-	tw->tw_validate_xmit_skb = psp_validate_xmit;
 }
 
 void psp_twsk_assoc_free(struct inet_timewait_sock *tw)
-- 
2.53.1-Meta

