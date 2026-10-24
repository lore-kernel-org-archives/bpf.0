Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806333;
	b=s10gwzr0txmPIUGKFXwBZiVSL1Du65tP3XgXIq84822xdEUHacOaNu8anvET9Z8k/Asi
	 MJnoJ14pj4T4mPCloc/DD1ACPbNZJxBww3ZZPq6PNMdsg+msMpwjvlW9oAsJeylYwdOkR
	 OMWOqC4QoroCDXgoM/kKBRa+rcEkfDoz7yHGcw+nLAn5Zdauzkxzr7aUegc4pLzZRRpOT
	 GH0Q7Ce05vJJ+lX7xKYJ1hGBnaGM+/9nOtPC2yG5ry/0YOX1DRAJOR82guzLUEZEK2l3R
	 tUlwpxz3pGxT2rHltCX44nt8dbZcXF/Tn3+Y8WCxh+mYVCvDZ2fChv6pQRTocpwfuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UJWPwNKtGiCZj1X2hJ2nZgMG1fzERRtv7qWYjsCeSYU=;
	b=iALQ5DV+foeivBtbK3AOZYyAf2cJHLUe4HEPMd2v9csIeDRzrjE6iukxrM90IDGdpKD+
	 qrS/4kODtU5Ge3tQSyZYLPqqGZcp2Mdq64ZeyNYBEQGlliOGHzrwmwncvkFXnIuZwedZw
	 5unHTLJLt8j9QBsu0nC1rVssfZBUq36XXYMO34546wFa7FoJSxPKnpYLubY9KFlHlIQ4f
	 J7HYAMyW6FoxZC4pK/Z8rj+D0y7Ac1VPtYPq4CXWCs+m24WIpETMBf+lQ9zaUSM/qPiQl
	 xAS7jS9LI/oTA8F2xrbAhI9FcyzIOyWUhbrDGDQkWsMs0PmJUlRc/gpBFfUzOSDHSQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=ezhbZmeE;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C82606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C82606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=ezhbZmeE
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O1j5Bu3294896;
	Sat, 24 Oct 2026 01:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UJWPwNKtGiCZj1X2hJ2nZgMG1fzERRtv7qWYjsCeSYU=; b=ezhb
	ZmeEkuMwtEX7/JCm50YiPf8od9zgQTh8yjOTOED2bJy2/kgWrJ9ctLCz7sLil6s5
	GZZNlVM4E7UTpKi2gxQJ+U1HET9BSu10DQkoRqcPO9K9QxOUnZC21Bm72kaGDB+W
	wYSXmwNt/S2ESWGypUlZjJUp59nUmt3tZHCMv9jCxNNUdp8uAt6uylpOwrQpmDgn
	Rra2+P1DYOIZRMZvELnlm2T42n++FW+WuGkeE9CijD5Kfc7barhpPL/sucq4gcHJ
	BDnNj1lbU6RMWvm9OpJ1OKD9A8+HRjyWnOrEMAJQ+xZj5P/puWApqTNUxwOLGN9W
	NP/yDUNH3fDihWRJSg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hfw62v85d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 01:45:18 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sat, 24 Oct 2026 01:45:17 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v8 1/7] libbpf: Reject gen_loader set after PREPARE step.
Date: Fri, 23 Oct 2026 21:45:08 -0400
Message-ID: <20261024014514.2959514-2-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=I7fw19gg c=1 sm=1 tr=0 ts=6adc0dae cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=JR1emnCqaZKiK-aq2YQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfXy3RakrpcFRq8
 gsdIAV+19tmFpAog7WbD25QyaIk4Q6QsxiqdiNNLCI5l/ERatnD5EQf3lMi31LVbVR2bnUzrDr2
 tDksin9zywx4aSNQ8wMO/zgr8D4ABXG0tZQeBy/bWTQK+lQVk/8e694fwy2fIlBLBSzX4hMZ3MY
 knuq4jmZ1tmuGZ/k1cmWAgXVmYpv2wPriPqlLpH64EMCvSqLGW4UK3G0bCh3cEsUfBrXZaRiUrX
 dhEAA9K2D03KqrKQIvaCn8BMWDgczKBbbH5m0GoDzJB748Y5MqI0jBz763kMCOeeF6tr664xSek
 wijm1iUEM6R0wYwi4Cy5f6F7ERlVTfEjax8pC8PULRU74Wdpw+na+I6vOcZJlyMnaxJGjZFMgog
 GB2Q9LDo367kTT/4rbhDxLsahjAMzMEmZZEiCO3Hsw9qXE7MVDQfHea+1zmsVVSq0W2QLiYng9q
 yqeMTTB1XYmVMh2rHHQ==
X-Proofpoint-ORIG-GUID: LcOA4pf7mNgm2iFHxi2808llGnk14zIK
X-Proofpoint-GUID: LcOA4pf7mNgm2iFHxi2808llGnk14zIK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX1dEi5gMOzDO7
 MY5EQOPUen+B0VIHmdn5WNuPYusz5XLlVL0yLaTHK+Bo5WDfHXKyBfo/5DmK7yH7gUcMJaxuaHV
 HT4MVoOCfwamRPk7NssO5WqFndHGrXvHZig/qTzFyRR8WR7jN7kW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240006

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

