Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F745253B42
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643972; cv=none; b=mEBNPwhjz941y1DDR9bQM7kVO/yV5A5UiHLEn0Tg8q0uFJYwe+j3pdBNku1BaSN12G07x5pVEQP6TPIH1CX+cNxm44XqyE3FkDAOr7I52X0mvNXZXRBrQi/3wODKYiClidZWcni8atDPtCvj2+aOv/uQ5nMuX1lGPu+rFTC0C2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643972; c=relaxed/simple;
	bh=AeM2PZvSpqM/Pqkdr9E4RpsA26gArP9LHLwDJeNBEro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT6HUn0dPQyulSefGRWu3PQNwfCIkAv3mcnknN5jKblpzs5cT7mEiAzOckWk0BG4tewDrCPKTOT7H5qPe1Vi060olhGgajK5lH1XFqgmlxb3XFGW6JTkN9PUgrNBHuRHFGgANfyZF0TYyrxVqrsM13Usw4diOclCywq7upR9TIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Zxll25+4; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Zxll25+4"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADLh4E3015047;
	Sat, 10 Oct 2026 14:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=qQfEIeJdAQpQAAsysYpvcLM9ZhcscDqyxImGD0VHjms=; b=Zxll
	25+4XKLE1LWdbPHAmKY9BXovXG5b5pqA+IEL+qQ7OId8mTOeLlG8oLzowzMW0RhF
	ogeylJC0cx97AkXjZ7F0EPcUakDFkfy/NxqSepmw40Q3KhcEZg1xVUNPfMD0jize
	WFUiXt96aTFb0o5oqzqrpd5Z1wNSAOU15cTOjX+zADYXICAB4AzhXYpujX6u8OIb
	OvsLKr53uFSeEdG49cTYl53IlMq8qOnzJnQAEfCAg+D0jlPiPFQqig7AAlIh//65
	X1Ug7dbJ7CMl1tH3u/gntzkd+sqBmsaK3ke3ujEb7a4PIjAL+Ruwb1ezoM9Em2d1
	ehU8j7yy4pBU9jgO5Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4h74uftuhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:00 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:31:58 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 1/7] libbpf: Reject gen_loader set after PREPARE step.
Date: Sat, 10 Oct 2026 10:31:50 -0400
Message-ID: <20261010143156.379864-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfXx16CWxiS+3G6
 NUBujUpjT0SPRseowDqZqwbqBcCW+N5vHpGZCdHKPqRwUa1OAZxW19zYiSqAtXA2vEgraq/Rd8J
 3uvusO721NKJyRIt15n1KkG+XsD5irpBQciTLAMf8aWBKtgk3nvsO9y+ONY8cvVPlRYce/robUb
 QOswa0eOoBpXZEUm9lTYOmJljdH0uphssbfgIo59XLJaTmx65nOwQsz88O3u6Ccdk4nlmlgemw4
 jV+sSpO8jdMWXjcv1DPUUAQsIaeXafpmh12SMPi+GOHdulmlh/gGBXtTBdxFjpy16VOQJqRrFlj
 em6EZnEJWhqlk0D0TM9PXsQWB2IZ66L4lV0tAqRo85aq9ILe4Gra3v9JWRv+AJ0TMqvPtrsjDth
 m0KSthnwaFP3rzElyVBzElWh5E4a8NEQUeXI3y29V3qUdLHkbKDZGZ+binBDmS3oOoaBNIyhn3q
 lf2Xg4xcZTLTb4apn6A==
X-Proofpoint-GUID: 3zrlxAZq7jN7Pgb0lfFmu8Klna6cIQ0B
X-Authority-Analysis: v=2.4 cv=Qv7LTlyd c=1 sm=1 tr=0 ts=6aca4c60 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=Hex6BOfvPCKN9fOGxmQA:9
X-Proofpoint-ORIG-GUID: 3zrlxAZq7jN7Pgb0lfFmu8Klna6cIQ0B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX9PkFgfOz9Hdc
 HgbE2UOI7OmqYM1tHXD4eZpLF2gvc1xHVhhyYVZyvA1pkard5x9WDmsg2jwg7fz3PbGn9943DnS
 +F/7/CJHmJbaTw2K17l5w86uOlDYTXV9sQgiEA7YjpXlfveplpXM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100057

It's wrong running the loader post prepare
as most of the recording happens there.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb09ded90773..647f205a354d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10637,6 +10637,9 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
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

