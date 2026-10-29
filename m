Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313251;
	b=SDDqb2QOqagJDVT6MLet8HSh+PX5GO85gkk/9STaBUMcHfUKQf7cxWzU3B1Pk88QK+Yc
	 EK848P7H84lKGk/WaGkYi9LgO/CmiIkT9Sh2E+AVylIyAdfEbrJy2fyYevGEx5FsPsb4k
	 R9mwd57TENrAtey8JxWz0jQUVYyVHBBctVF1yqA1KKjAivyoqFH6VNY035TbhBPYVKqNl
	 b9kAvSU27iYNACcVrawj6eObgnZGwLuDM8Ci2ZKCYVie6bn2qr1sgrDr7J6HdhOCNdl18
	 VQ2oN7sgdU5WA7qrR2Y27hdaelnPyYLDzMXl5yilDhsZ3UTHHX5czogNOm6wEjePg6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Bd++66olPxTF2bzPC2J7mDkOkcXahFsXHFDDiasGwvM=;
	b=bj4CHtJxdaBfJkAVYqThG/rPZNNgJoW8WgNZHu9GYrjljgkZSYZJfkDLwTfvIO2pPchi
	 AH3QrbUczv2AJiyQitvfigkbf+mmpqs415qcR70Cr988dZByjgI3rcbtCeuE3C1dKwVh/
	 hzrBMpLW6GNlaOWt/SoA7zCJENZdQLdmSPRzTvaRH0cBmNgvl0UG+BUQoYAq1JXpzoo1a
	 MqZg5Gi+vaXz7rcQGoT3GzmPsJ/pjQTHgwtvhtQpLX0mAjWXFzuYQTH7U2BHvqhY65GAh
	 Bb+MlXPU/0n23IM7kvrWlUPNRzl244TeJ3BpMtIYAb9H4uhbQqSQS6sM7GTDZ3F+C+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=t+NzUmFB;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB260A2618
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAEB260A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=t+NzUmFB
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXBgE272652;
	Thu, 29 Oct 2026 22:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Bd++66olPxTF2bzPC2J7mDkOkcXahFsXHFDDiasGwvM=; b=t+Nz
	UmFBvk0D4c61Ihr4lXewj9seDMldIeFQiWREd5f/5qFj1b8l159BIpakBpRjQCBg
	BogWe7gCgXZc9L/B+G35r2lr13W622rS1hAN81gtKoKo4jyv3gqKhGlum0ekSPO/
	nymdkKI1uezAABftCBqMuol2UobZpWRGoGDUxhdQLHMDaYt7EkOERopFYH+Fep0H
	nPyQOe2EShOGksol8/IwyAuzRJVMULUfvRVvYxG3ZmzKPb6Fv24P2uysYcobyyNp
	qOkHVIh/N0XhHg/WiWn2Pr7ASdd8T161umtU2ZVRhorfD56zP2JQ3YpDTpdnV7k1
	h2zDA5lXqIPdBIZ3fg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hme5kr5qw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:56 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:54 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 5/7] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Thu, 29 Oct 2026 18:33:46 -0400
Message-ID: <20261029223348.3730738-6-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
References: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX8XMVNorZP3Um
 pvuMpu+P8Nca7WFnP0iDaJc6cG8BN1UR8R8qXIZiXa6tksYb2asBBiQVN3DsDPJu/CtAUPSK9DA
 ONnjcRPLS0JexsPhoWhlsv6Olg7vXOMRESkUcpsljMuLqv/Skde5
X-Proofpoint-ORIG-GUID: gm2dSTG2DXHFWVXdbe4gpxGThoWtPlIQ
X-Authority-Analysis: v=2.4 cv=Ys+a1IYX c=1 sm=1 tr=0 ts=6ae3c9d4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T_vuX43d8AknE0woFHgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX4j7L86uRYJRD
 buZoYYJDd1PL6HYItdClCZqh2Vt3KhwaxGFymydPXjGdRTm3Gl4+6Vg+72yPFzZqSVYVIykys+5
 x/fll+AHS6DjbhCYy92zYU6DAfdUWN9AeQK84C4bsMkdhNtEd70o8nGF7A6MQ+TO5OVzGUXHIK0
 yHyKiMpUbhSO5COnU6TQGD8Zw9H8wGjy/W25NoLTHNdzy8pq3MS75ww7qlENnEYGIkz1Qqsxdc2
 F3pv8jZ5IoNeXuvZS/yTHs+mVPXSBdKSPZ6+YNp3tYJ66hSryQ4Zc8jZl5/JGQLwzLSaAxfFh+m
 x/1VsEBDgvaM9O5W3oYGvWmrujuQUoy2hGtyL4ZeW+S38qjriJDdHM4DEyIooOf8ihq9zmdv0Ph
 W8FOonvxcKtkFayS26gQK+GVk91qytvC3OZbf4JJ+g6NMuTfXH7TsOkVcew2fu4qsdJKjA2cx2Q
 AvbxdcF4AEqKzoT2Kfw==
X-Proofpoint-GUID: gm2dSTG2DXHFWVXdbe4gpxGThoWtPlIQ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290088

Add a SEC("!...") section-name prefix, letting a program declare
itself manually loaded in its source following the exact
convention already used for SEC("?...").

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1a5b582d63b2..bddc18f8eeff 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -955,11 +955,19 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
 	 * autoload set to false.
+	 *
+	 * Similarly, SEC("!abc...") marks the program for manual loading:
+	 * it is skipped by the bulk auto-load pass and must be explicitly
+	 * loaded via bpf_program__load().
 	 */
 	if (sec_name[0] == '?') {
 		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
+	} else if (sec_name[0] == '!') {
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
+		/* from now on forget there was ! in section name */
+		sec_name++;
 	} else {
 		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_AUTO;
 	}
-- 
2.34.1

