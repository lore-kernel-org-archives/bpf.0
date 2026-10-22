Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708354;
	b=eG3aaJmGM+ngR1UxY1Bnszhtwh3fb1rbQdzHtkHElaJvKX5ISrhw/eASq2YghFAsNf2X
	 +hvafijoYKfijRc0GsPZYySFwR4qZ1c/5p2LgPWfolLBROILuRtwPChS8Lf3Xf/h4iNfB
	 419he2A97JVERw1FYdeoMYNNDq+UMpweMiE4gMHlJpPChS9sxFDoV9Ld+8pHwAkrcaNKR
	 SBmzeY0GDJmO2CH5M8/hqrrlGrGVAzZFNHD7QgkE1/Dwt3MQT0DwH1vN7KiGJzyNXJIW4
	 VEKnrBbRReZW1yz0VhLjSpQEOhh3x1iLSfuVw3F7WXH/csBgYkf1njv9P5u9dymPu2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708354;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FnW7LHDCaJO/Tije09dUAIJ6uatx2ooCBq5K+FHuvfk=;
	b=M7oBCsZ5gUybadfHMBom4w8/YS1k7wLGCQlWGavqTsAnP04KkIkUoYkfPystJGuGhZVY
	 Wo5YAGLdlB37ZzN7zaWII3NORedPe2NvufPmG+DwSx0/weXqwDFy4ZsJIX8rEs2ABuA0o
	 uttg75z4XzleEwt7XWZFA3F+7lh4CfaFxgRq9H4F+MjkiwXv0iOSbMFkfON7TohR0XVbT
	 S6NFmgzfemZnpmKiaRjIxxpN5OHvFLkG6P8xx7oMTHgo2vv07bNgFYReckpKLKeaeGQ2G
	 5lmXUA5cF3ZoU4sPfFbVVDFFidnuIlW3EKoMV8mZWf6yYRmSFEujuO4GRRJ5TntBWjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=P4apu9eb;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFCA606A321
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFCA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=P4apu9eb
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHMjI33482995;
	Thu, 22 Oct 2026 22:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=FnW7LHDCaJO/Tije09dUAIJ6uatx2ooCBq5K+FHuvfk=; b=P4ap
	u9eblEoQ0267QhuIXOk4vMmxCwAHQWEcRrkS9lTXyJEvMT+aS34Bj6Qk+WZ1KSgH
	VHHTSwY/3/abInWVPnlCM0wJnx3zbLEkGCZKtRrDSg/fx1Vj4kAkL6fW474oIfeC
	YMzQMY09XM9ORGS/U0I22gHxpmZufudjDqxtvU3yd2T0Gr2LGycZbYb3dVZq+hc+
	SiAshr+TQCn0toNrrOOhibcb6HHrX+tZCRX2z7tiopJ0Ux9tYzcDA2XFQBNjDVlD
	M4SJz8KVxSUXSyXlYLY6uX9RHFVZiS6NboONn7sAm5KGA9ktuTrIziAeA8JUXXV8
	bJ3exiWkXGXdIP6mQg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hf97kvjya-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 22:32:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 22:32:17 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v7 4/7] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Thu, 22 Oct 2026 18:32:09 -0400
Message-ID: <20261022223212.1217849-5-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
References: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH015.crowdstrike.sys (10.100.11.67) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: 3SLp5e8YCJ-srZ_-kSLjVVRJLKmbEhJP
X-Authority-Analysis: v=2.4 cv=Q7dHcI2a c=1 sm=1 tr=0 ts=6ada8ef3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T_vuX43d8AknE0woFHgA:9
X-Proofpoint-ORIG-GUID: 3SLp5e8YCJ-srZ_-kSLjVVRJLKmbEhJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX6LluLcGhC4P5
 Q1Mq9D9P7oaAfMUX0nTTKreUcvH1GFWPw+CuAk4AkWL7mkMFunrhGbEN4F4vauSUvnQFMg1dVJ4
 6aLwJY9W0rqoAKVaTpnbuWWyjk5J1ufRiOhlknoEDd9fSspwehlcKWzCnbbR+DDjTxgAQm2qaTw
 3Z1a9TsPGUhKj3tYncMQNxMr22wr6KoHzdk6bBxPA68cPDitMBJ6dKUNDL/FRFWXhGvMGHC5IGg
 rYvAKM3ILnaZFECciDYYa5jb6qioJuKYvxAZSv7++SgU5rhhoAM3oHUSYd+vv32FrTnbSpdEfGV
 LSuT++oFQayKJchoxv4g8LkCYPj+36Hy0u3Qwlb416MhLNk2v1F9PLOHdYX2W5HhQc60BCtSCSO
 eN4Z0mtebnDosGVh61MkfDBOqbh0EHacX3+83UPvx7+Mo8y+bBeqMsU6RGrb+518Y5jkj1Fmv9e
 m5j3UpNY+IIbrkfLTpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfXxFaGylpI9w9N
 X/O8gJ91deGpbVjtl4Lo4Qe6zSWqDAtn4f/DuFJLw2TAsXu/EbALWDcOegc0I+sjjyTt1eIHJV8
 jlqoi2290kKfAUxlgauLkSuAgdLaUb59iPBoh7HpczHiCzvgM9x3
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11943
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220089

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

