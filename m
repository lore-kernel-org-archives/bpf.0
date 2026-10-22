Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708351;
	b=uRj+KekEFzZkFbDrV8Rsr0kF0fRql8EUrERhihdE3q3HKGymtO/tEH93TEI9rDvuTrXR
	 +w7TfW2A+IXcAnclOcqiyrNdYFJjKycqxg24lFa9ZgjP+c2GYSnTjOV+r887yTm83IELH
	 zS+wvgChf8VR3Th3zjhPJRkPxfmn7V7+3kKTo2ZCvUrRCg1fB8SfSVl1YlzNIaYS0OMXe
	 SIKw3x3a6z9H/7xtYb9CqcTgsb47oj9+XyVTTZrgC1B9w9KQIKYZECrltRF8RUy8WMmNg
	 jtsHAHzHpCZ06rq1eleR4Il74J4qGV2wNbOS8CSiJW2NcYRGqUlClmCNJGBqzPWIYnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708351;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UJWPwNKtGiCZj1X2hJ2nZgMG1fzERRtv7qWYjsCeSYU=;
	b=qts4qA1M6oFghFQcgPNO/VCNQpr61yDNiLB0+4QfWyrZl4CfJiydQeoKGW508FabKmei
	 wsw9+FRf8/A6OvZcw2klYHR9e/Ds4eXCWark6IzjfosdwqRvgK4qohm07bTO7C2gBV+/P
	 mSj6KsvwIw3RV6dq8Beb/lWrVJE1eoWIHpgl8DYJ7/2VE332DN0l4MXy/5UWPVEaLg0zi
	 X49EKyC7oS3HI5BWEjCnhMDHOSQ0ieTNaE64jdqZUl4JxMO1orLxTkYo9UnPJFPiCIcEI
	 XruGiFoy525GuHlU4KmwqEOsiX1W83u4zHnz9JdP3ZPeElQ/2EJUdh1xw74N+Q4CFzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=GBSURbed;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD70606A31D
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD70606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=GBSURbed
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHN7Sc3008702;
	Thu, 22 Oct 2026 22:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UJWPwNKtGiCZj1X2hJ2nZgMG1fzERRtv7qWYjsCeSYU=; b=GBSU
	RbedXiG6Fp3rAIsQPG6iWFjpBr/ys6w4RfNJDOw2fouYs0tRSiP4AizhSv8SwKKW
	SBRgMbinineJefuPbCtRFJ8ysCZGf8p91ehyA77g7SkDs3vLhPSoyBVRMBB59jmD
	Db6512Y0RztVOWN03YfAtbqz0ZfiBhMo6Cp3zUBqclrBfT73k4dkiqc6n7yb1QpA
	vwDyblgV6JA8zSHMANLBagAjnujK6CeYthsu1NXqj+90+8yyEQIypq4qNIIZ0nvX
	e7qMEwTcL7ueU3lq36NiCFGCyLwEvHHgxd9n05FuB37O+fGZwTowTILrXPcr5PMF
	grS5LfswYIt7PEZ96A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hf97mvktg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 22:32:16 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 22:32:15 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v7 1/7] libbpf: Reject gen_loader set after PREPARE step.
Date: Thu, 22 Oct 2026 18:32:06 -0400
Message-ID: <20261022223212.1217849-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: J_aZ_9apN9fXIXLgoyaMD0PrHclFyWEF
X-Proofpoint-GUID: J_aZ_9apN9fXIXLgoyaMD0PrHclFyWEF
X-Authority-Analysis: v=2.4 cv=CMW/zhrD c=1 sm=1 tr=0 ts=6ada8ef0 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=JR1emnCqaZKiK-aq2YQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfXy6bOfkTqV5Dx
 PqrPa3ACDX99YC1v2IKXa4Et0AHGjtc1UOCFDzr4vJZxswuOo32jayK85jJpyBXtdV0Il3n+z+O
 gokzyeiwQGlBIlv+Lk3YQ0xRHOCvJvzWzuMwPhOzAUV+fC1JD/csn2d4SXC8AS95NMZoGjXXdS5
 MzrwsiW2Sqexy7mO6LxWQbZCNyNrKi7Zx37k7VoPeSr1d1eG86KqziEEan2knT28jNqXHpJxYYH
 C3pREAdNz/+NhEG3DaumjbHeP+CLfSMcykl0MKdDAjo7n14NiYHAXHvLCZNP8NeamLDCZp3vlJ/
 Sx0ecwfod5haPTUAEI2bhmcHczEETVLOCWDmfgLvYJhpkYSzYdBhjkmRnzez0xn72LAgyYUfhg8
 9k8Bcb8MeWoUMOwVOPKc4i8Y2G8q4i5m5FGI/gK9k+f6BmU59WaWlY12zSyy6TYDf9FXWHdI5KB
 qa6hmFIoKJFDT7zqoig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX4VHGTPeRk5AI
 4A9W+UEn48F1Iu0ef2Ce1YF8RR5doYIgI/VU+Vl1Pzcxpfo0BFfUqUaL2L1NI67HGdHE27159eB
 Lf6C/QPfQ1VDHGlr8RUOE3hUOHbee5iQ7m4PNirwXxxidgIrH63y
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11943
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220089

It's wrong running the loader post prepare because
gen_loader records the BTF load, map creation and extern/CO-RE
relocation steps while the object is being prepared. If it is enabled
after bpf_object__prepare(), those steps are never recorded.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8fcb8cf39cc0..6bb5887090cd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10698,6 +10698,9 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
 		return libbpf_err(-EINVAL);
+	if (obj->state >= OBJ_PREPARED)
+		return libbpf_err(-EINVAL);
+
 	gen = calloc(1, sizeof(*gen));
 	if (!gen)
 		return libbpf_err(-ENOMEM);
-- 
2.34.1

