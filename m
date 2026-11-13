Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596194;
	b=IRN04ByGaeIb/eQbfmoqTaD+IV/Cn5i/ATsVHKUyM2Ikk91K60PkejDah+GPZEVlkMZB
	 7fcZCWZL0kyhAXFpdSzUgr6dMimG0AfraUxyCkU9yiJtcbncFy0kOHEVTdjb5iRBZv3oK
	 K+b2Cwttnc3lOdLOM7zMWefvBD6LZW77DxEKhdXNrSrYmksreNUXNkSe2++jL9NMyLVEh
	 jYO7L9hB8ZVib3e1pB7cLK7Zgk4kxfgPd64o65/K6/UsJVsN9KSLSqmjToTBpW93n7cGz
	 6aY1QNs4Oa4WM8QnF26/NJFzPCPeXDsncoY8zCSO80HP4+IjslN/ExChpEQoYs5j7Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=CL4DK10DW5k/WPXah4xIbdozQuFXRdBBG8thXN24xkw=;
	b=sXXIs5xn8Si625FRrbvOQLaHRjv4NZi73dpkjhqZ5U/Qq8+opBS/do/C63st9Yjd41mI
	 pOvS77CYs8GNyDHjwuld1nQn40OyKXFDea1p5m0Z6GwDjyv5mDzpHnoLYJzgb39XKafzU
	 fyZuRa/i4BK0L/odsy3ol0X2rpGyPXEjtCT8JJ9txtppgv8InP0o8sR8O3x/S2PxRnHCl
	 K1PeJfwkV4s2Lp33GM20n2j+b5g6kh/LGvE0BdsQp6N3UG8vNsINY5kDi3d5aETR9a0qO
	 ALXL2z1MmfUSuz3rUnuiCP7mo+Kn9KhTEMii4xUVmP16FXYvqVEZgWwjTVc2e0aJ2rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dVeSBFiR;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFD60A6F50;
	Fri, 13 Nov 2026 18:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DAFD60A6F50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dVeSBFiR
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFSmhM2007105;
	Fri, 13 Nov 2026 10:56:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=CL4DK10DW5k/WPXah4xIbdozQuFXRdBBG8thX
	N24xkw=; b=dVeSBFiRg4xGT3aDoy3aA/YbXFtlHhC0Hd+dIinsJ2UuHe3Da+3E1
	R7D/Kqt3+cEUyrbkFCpG6J6WGmYnNCnMPGBWRLnP8Ot1aQ1J4Uv7Yzi51nNxUARp
	SpAfYMvHSfrgRJ4MSDVXVSZbsFbK/utbb56BiRFa55mVkxRvWkFkp52IQ0o1sw1e
	wdw5isR5oF9Lu19/7PB08LzGMQ2u1+d0c7oimOAWhxhh/MUKapFaS27i8CeBzm+9
	jy8MKAyLxWtEwr8lmdhBJ5AfDXzFx/XzLaNmfPpuY/tj38ewDF9xEz7jQDvnGqtr
	o+8N6+Nfo6QpD6Q0C9zWMdDcxJ6Sh0Okg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwj8cg3gv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 10:56:03 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 18:56:01 +0000
From: Todd Freed <toddfreed@meta.com>
To: <netdev@vger.kernel.org>, <toddfreed@meta.com>
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
        "Stanislav
 Fomichev" <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "Boris
 Pismenny" <borisp@nvidia.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/3] psp: only give time-wait sockets of PSP connections a validator
Date: Fri, 13 Nov 2026 10:55:53 -0800
Message-ID: <20261113185553.171059-4-toddfreed@meta.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261113185553.171059-1-toddfreed@meta.com>
References: <20261113185553.171059-1-toddfreed@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfXxQPV4vVc9aFo
 +CRljNkzSWm48HXdKh/1zAlc/6gTRbhotscX3XNBo7PYhUkfIVi4iHRP7L489hZTamdW/rcl+GE
 bv5QTWgcLETpqM3Q2z1IskDtUQefRisl8/zumrl/BcAsy0EkndZavVBtmxiDgFQlfea9As2AO/i
 7jn8ULLefChWIHcibxoFJhBQmpaDc7AD/Vv8GmuvFPoTqoy7rWsAzUaS/nKcwXrnPrPSmj6Mqx2
 xG2WnW6kF5e/qZ6l3uYC1QKi/ufEFrjnTq31m/SlZJDtXE0Z4UrFACLAzj+IlLXixqlaCY9FzCD
 pSSyFM9UBjlbDPcYrQXvq6CHBvelV0XNUREGwStZHs72uIi2FejMhDU4UQb+/IKpk1gHDB7SGCm
 oRCATXckcOxHlT3NDDJugQk4UoeQg2wm7aWb9qTAFReZxKSbmiWqaBHldySAjWY+SzzGv4bOQv4
 RGBTvEwKR0kAH/j0M9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX21oULmicUOUe
 /Cwu8dzJqX+AnFnvtRzGYdEwHbZ9oxJ7pDO2vP9YRuMqRSv7HhPWMYero4D3kzw2drWX9tgic5a
 ZIR+QSPCJ+djUpHIauanZD+RDl/l68M=
X-Authority-Analysis: v=2.4 cv=DuvDa2/+ c=1 sm=1 tr=0 ts=6af75d43 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=lPjtF5NPWS3-9_hsH0QA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 3iuuzk2g_e_DY33Y6Cs2z8z5hi3ErO-P
X-Proofpoint-ORIG-GUID: 3iuuzk2g_e_DY33Y6Cs2z8z5hi3ErO-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01

psp_twsk_init() sets tw_validate_xmit_skb on TCP time-wait sockets.
Today, that becomes set whether or not the socket has PSP offload, which
is not needed but is harmless. psp_validate_xmit() passes such packets.

But a validator makes a socket look like it has an encryption offload of
its own. The tc psp action in the net-next series "psp: introduce
socket-less associations" relies on the presence of the validator to
determine whether the socket has an encryption offload.

Set the validator only when the socket has a PSP association with a Tx
key, as psp_sock_set_tx_key() does for full sockets.

Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Todd Freed <toddfreed@meta.com>
---
 net/psp/psp_sock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a6b1c42dd626..1df65505f1c6 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -314,10 +314,13 @@ void psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk)
 {
 	struct psp_assoc *pas = psp_sk_assoc(sk);
 
-	if (pas)
+	if (pas) {
 		refcount_inc(&pas->refcnt);
+		/* like the full socket case in psp_sock_set_tx_key() */
+		if (pas->tx.spi)
+			tw->tw_validate_xmit_skb = psp_validate_xmit;
+	}
 	rcu_assign_pointer(tw->psp_assoc, pas);
-	tw->tw_validate_xmit_skb = psp_validate_xmit;
 }
 
 void psp_twsk_assoc_free(struct inet_timewait_sock *tw)
-- 
2.53.1-Meta

