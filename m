Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596194;
	b=iw31aHPTNmhxF086ROHN73BSkE+s1hpPmmVqOlYGL5mWxX5hmJeKSXDt9835o6OGh6xj
	 kLGhvusqvmoHg9WM8gTpCJtwZEMlYUhZg4YjNRGdXz5LuTO1hIe0jXHVYFffAV7pUtbBX
	 /SEhl3YASsyND1qmFhVUtDFGPRfKa1eAy5xtiV1mlKfomV9fhUYXk7tYpUqF0SPBq8d9w
	 OW2ppDXxLY6ME36rPIhiU7eJ5eMMAYUsrWsMW3+dw+BT/th4e+wXIkchha0F5/Wt2DVsu
	 0biNjxCYeKLUSCQjBCvqQBGUZKHs/B/UycYfK4D+G00e35dHESW+9zoh4LCTN3h3pfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596194;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=0Odt5eAU6DCn218cfHnRmHnBSXJD+xBpr6lIOdgFlls=;
	b=5n6+L06+lTv3hIUBdAWt5wR747382F3r0FOOKPuViatFt0jDlB9X2+/IdiVXaXwbiX9H
	 l04rEg2CVMDZHaijUKAsJoOhPqa4jEy2R1Phx1BeHAId78/d5m2h8DtDGwOUNk/nhu73v
	 7QfO5v8uekuQluxZq9mLIMgGwYIU8jTnMALLeb9sxIvp/A5MtOEAWLyt756AqzYDqODS7
	 dpOCihcJ7YkPLOciXUjuf7dGTGw5AL9lpDPkX4nsqJjDtumltreFu7GMFmbc7uNBW+hws
	 vxWKpG0eHOz5baLcXvd/kVdZV37ZGCOglPNVczCk/E86Q+pck8UbJ72PPLVUvZhJYIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="K3w/+hjX";
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B16071076;
	Fri, 13 Nov 2026 18:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E2B16071076
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=K3w/+hjX
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFShxI2379543;
	Fri, 13 Nov 2026 10:56:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=0Odt5eAU6DCn218cfHnRmHnBSXJD+xBpr6lIO
	dgFlls=; b=K3w/+hjX/YfTlbyWJtYykF2M8oVyFMhC/91W3qIzySeCYnPPAoGXx
	cVVHhjNO96yjesirTDfROojFPmEQ9XZli8vKZ6Tn8+8GrXr2a1Ra67oFYAXcWtnN
	asCaS8kDDgVbmgvyHCLl21OyrS3GM2SVPUsXc5Rn1BkBh1PjQJaelQajHmixhwhK
	2j+kj2p/Tu8VTJV2TvDYudSu1dZc0DuuHYwYLZ/aPbVU6qGSjqJEuFECIxOeG20i
	5KWi52ig7OcSAFh3owIQDbYw5k1aQW2diVvpZmIkCQ6z7xoC1NfOeK0BKe8DeMw5
	M9uy8wNNifazqzCTj89JBHoKSLzTGOjBg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwnm16etv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 10:56:01 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 18:55:59 +0000
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
Subject: [PATCH net 1/3] net/sched: act_mirred: don't send decrypted skbs from egress to ingress
Date: Fri, 13 Nov 2026 10:55:51 -0800
Message-ID: <20261113185553.171059-2-toddfreed@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX95d7GKYfK5rZ
 TM2kvRnKGzRTUNjW+znRKGLx4cOCN0zBeQa73Swzdzeij2oTr04Ova3yWwGtoIbeIE6aw+m7mpq
 DIHvsrVrMi9qjpkTG1ktNVrjL8Qs9RQ=
X-Proofpoint-ORIG-GUID: 1EWEQP8KQcrHGdiMYVDH1R1suqxS51Fx
X-Authority-Analysis: v=2.4 cv=acv0Dhot c=1 sm=1 tr=0 ts=6af75d41 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=OYNTlRyxvniuHvjL9cQA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX15vq8irdOh8F
 jvqZ5vnPEVkg7PGc1V5JJ+FkRGE6JNKuUXmgxIR+H+0oLWy/a8NTSOrCtpT0uCaPU75CnOSIbeC
 Sa6WVnFjKUdrnIWTNGvv4LJU7eqbG4T0E6qvdT1WDciYcvlT4t6vUo5wDx9DnWaLjgqYa0u7WuY
 Sru1+DhGlq3AkbskkLwJ9zfLmJpUJO4UiyD8ILbENWPAni6QvE/J+BquVtHaVWoStq/Vmpgcewc
 xL36fdcpKibFDQ3yz5fQ6/wMNzHTds891TEwfpLpFo6JGAgVzKevvu0ghKnsUzXGLrhFVA0SA8t
 0mEoinNX4fFqlYnweU2SMw2sWEvvCkWhOSJVU+ejbnva5x7MTliEv5upI0qQ7febrfMl/6PHBOP
 utuMkvTx+/CMkd1imY1+SVRGexAZW31fxcDhP8Eax/nluz7TZB7jc88jkD2zFNI1pWeBmYr5kll
 ws0yRhsfvsbHp85J+RQ==
X-Proofpoint-GUID: 1EWEQP8KQcrHGdiMYVDH1R1suqxS51Fx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01

On transmit, skb->decrypted means that the device must encrypt the
packet, e.g. a packet of a kTLS or PSP device offload socket.

On receive, skb->decrypted means that the device decrypted the packet,
and kTLS device offload trusts it as such (tls_device_decrypted()).

A packet which mirred redirects or mirrors from egress to ingress keeps
the bit. On ingress, it then claims to have been decrypted by the device,
although it was never encrypted, and its payload, which was to be
encrypted before leaving the host, could then be forwarded in cleartext.

Clearing skb->decrypted would not work, because that is what indicates
intent to encrypt the packet.

Don't send decrypted skbs from egress to ingress: a redirected one is
dropped, a mirrored one isn't copied.

Fixes: 414776621d10 ("net/tls: prevent skb_orphan() from leaking TLS plain text with offload")
Signed-off-by: Todd Freed <toddfreed@meta.com>
---
 net/sched/act_mirred.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 1c98e4d81ebe..52c3eeab381a 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -285,6 +285,12 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		goto err_cant_do;
 	}
 
+	/* On transmit, decrypted asks the device to encrypt the packet. Sent
+	 * to ingress, the packet would read as decrypted by the device.
+	 */
+	if (unlikely(want_ingress && !at_ingress && skb_is_decrypted(skb)))
+		goto err_cant_do;
+
 	/* we could easily avoid the clone only if called by ingress and clsact;
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
-- 
2.53.1-Meta

