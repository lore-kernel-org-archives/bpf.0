Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806337;
	b=nNJ/UThOnBNiwbV1vKQh2uHfH//mD1SNy71TwJr5piQBAzVc0hc/n9J9pNf6MEOoGLb2
	 I7t3KKs24D9DGBQf/9tcMvW1pBvmj4tZAwhzLlnbPM1A6q+G3dLu1trJGlqfXYra4cJw8
	 ywaWaZU0J3z4GJk5U2PAPRSLjOGnCXRfGoafkYqNJmEnhO3og2ZutC/R9/dbn1MkOg+6q
	 C+h9dqDkiCX/CPUIzkwRBZidUtDMnxyhRl+LdIzHxzxA22rcxsm0nCn0v5aJW3Id1Oh89
	 qDlSIG8KGzG8VNnocC83hdWN47i4iWnoM79q7HwCTfboBX/LaEAKAF+Fm/kJA3/U9Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FnW7LHDCaJO/Tije09dUAIJ6uatx2ooCBq5K+FHuvfk=;
	b=W5YJIbR/e8IRZLC6QSnIa/RouBwhTR3azWa3pz2GLt3cxr+Bop1Q64WfSNLFLwQCh9OW
	 ZP6ERffFJnEUkLB1Bcgl6eqHoRxjpmJRFba512wChvHTJXFZygOAAJLUMdW+Xn42kvFvk
	 XZ0t7ecUKShmrH0H1Xku9qIj2KubBSAmxXvyuwc7GvRrMmn0WMqhxKSDhPCJwrn0A2OmR
	 tkhRfIwMK8U2/qSYimbyR7sSZLuZq/DX9Eb9ZjN6JhFOhsyIQxcQFSuHiFVJMeFplLJLc
	 vr/0HKioEPdypPdUWp/Bl9+jl01Uo2PIkpN0X+R2CQro5agv+2ixrwT30Y1N7yfhLRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=PxbM54wV;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA8606A336
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DA8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=PxbM54wV
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O1c6nk3411319;
	Sat, 24 Oct 2026 01:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=FnW7LHDCaJO/Tije09dUAIJ6uatx2ooCBq5K+FHuvfk=; b=PxbM
	54wVfoORFxHzegzfbUF+dDgMZFyqQMBfcuIGVhOGN/9ieZvgbdLqRJpTHAoOF77k
	pKmGbU10YeaCULBIQf796BeuCnvcN3w/62G64i+et/f7rNDXisV+eAjJoTydN/dZ
	mPi74xhA0Khcq0fFNECfqSxP2DmBN8lgn2P541a+VHdHuehqczA/A5n00G8HftY4
	cfuK3OeopL/iHA7RjzqrRvm7I4yXgNdWwpCSzk+Mb/T6tzaZokce3WdYkBMeLIMW
	VYxaunUM7It9j+qGmcbwlzL9q/Oh3wbbPNMuFfUgeIBZ0jBo+lKCKacv7uGPDigf
	h6clAQ6OEiS5pZEVpg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hfvhpv735-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 01:45:22 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sat, 24 Oct 2026 01:45:20 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v8 4/7] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Fri, 23 Oct 2026 21:45:11 -0400
Message-ID: <20261024014514.2959514-5-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
References: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH007.crowdstrike.sys (10.100.11.74) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: rZn-c2fp33RcurrGQCCw9B5wAz9CFPsw
X-Authority-Analysis: v=2.4 cv=DvXDa2/+ c=1 sm=1 tr=0 ts=6adc0db2 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T_vuX43d8AknE0woFHgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfXw5oLOX8lkUkI
 Pt4Vo4frDHB+GUQC/IhCIPzrbgxpTd/WRjMzJAEeHjzoOg5R1xN/XGFkOacpcvKeYqaKSvdCg2n
 ErxMYbDdhlEseMjqrO0ofRXeEE/QPW91Dg7KkmC9vF6P00mayzpjZCCPcZ2UvQwiRjt9+BlXeQD
 7VaiDe5SXHu2CrPLhgTnjjpUQ5HPkX8Rdz4aArr7AFdb5fhu/+gCa2MiE+T7w22/g8vDcXX/NCN
 fsBJsJ4dMWZHHyGSjsprLW7XTZBA3xCSijeOCjxYqYs/iZ31hjqmIjzDnovZdy46Qt/1excYV5L
 tbHpHuQbH/y8dPIefbEADo80UggtpLCM8C677G7CjUf6lFi/TXlD5dn8x/QcvBAqgbNCvtcM4gf
 PXERuq/MaU1JXZZ5FHEXYow7PHgznwtzOuoC6TtCAEpw88aQs7v+dLpPL9xma3rX5tOLjT6zTM5
 HVb3seEcPqDPH9SHrYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX4CMvot0W94cT
 K6TL3rgPpSbSBfQfCJYXq2Mllzvp+qKMLSzvM18z5y5tSloz4GnkgYYLbySnvqCeVUJpH21LpDW
 2oaGckgdNvHBdWy+CFnOl0eu6vCyaNoz7pjq2fNIh0cP+98nyBCE
X-Proofpoint-ORIG-GUID: rZn-c2fp33RcurrGQCCw9B5wAz9CFPsw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240006

Add a SEC("!...") section-name prefix, letting a program declare
itself manually loaded in its source following the exact
convention already used for SEC("?...").

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1d5d59b95c4e..ad260cc13203 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -974,11 +974,19 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
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

