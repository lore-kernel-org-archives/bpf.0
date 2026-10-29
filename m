Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313247;
	b=uqLQVhMZqQdTyg6LvH809aWHupHAjV6Rpwq9A5tUv/Av7naWiNFe70pJS713SDvUpifk
	 f1H7arn7B3wLkqfj/DsTaEwTaIBB3W8uP+NnzCeuzrG84BKd25TSy5mxdcfWIqIOLYpkv
	 mXhqzmFCGTy4RkVjDuoTaEdiFu7nh9Y4EuON3QpZ3/dmBnebCf4DW0ppCDC8LeLJDOHNN
	 KX/h+gzd4ww9pJKXEqMLa8l7X6isnuYVSxzQ1mxYjKdbIFNjcl76oC9hDrcrLwVVMmAEx
	 EJjhU7oR5sjHioXH+iNBRgHi35+ZgoxK48vdxiiABKd/FsjJvbsDXHd0U4CYKodo1bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hy/IEOsyNmELT39hwrpCjmnJFtEYz2dqXSLzzsn4juw=;
	b=u06YM9YdRmsdEzNhlzImEAfaZtyFk+gjNoFO/9LQDiP1t2zuW0VSyu38fUu+oKLnq1M0
	 gUVAw0//MSVW3e9nn4Y1N9BBLKyFWXcUDkDqbbz3D3HkiOK3Yghe7PrXcQHljWcs2gM7m
	 BZiVFdNl0O7qVZqObRhwbhntNNcAJO4T/qXcHlRBFQ/oNJAw1F9hTO//k+GUVZqgE3iAf
	 oJn3o0K5T4JWBW7nDIvMk3uy/pg98AQ7NipnWmdytOq/ykMU0UASNUeX1M0kU6TVYnPIk
	 GahTUicikxxE/558u35CvwZhvAIoodJBX8YCNrewn6mg0lDBNNm9EyQG3rUxz56JF0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=H2MlZpdy;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCFC606A338
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCFC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=H2MlZpdy
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXQ8l725569;
	Thu, 29 Oct 2026 22:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=hy/IEOsyNmELT39hwrpCjmnJFtEYz2dqXSLzzsn4juw=; b=H2Ml
	ZpdySwtQiEg1L5N4EnYphQdcxciPyKVsqCGbbJ/QK8GOPNkuxPLY279ld5Zz4VPj
	YkOF1sK2WZE7s4eV+6CQQnwvchZ7CQMOem3r52r+gsktqxMSQ8sp8JhwQ++KNupg
	XVdhsEGWxc93iqEKtN3z6g3/nQWlbnzBJxk0kPv7TEhhg+p8vcpWYunsYsipqMKx
	3XwqlVHNAot/fx+Z7W3ScMwHkgmTOINzDnBZk3ueVB+7ZH3jZH3uB8i16ainjsmM
	0v3SccmOx8LahEirhKge+lVymE8kRevfADX6/KgM/r132EK+RzG5TWKBnmhbZnx3
	OMMtA7mReGSET3Dngg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hme5pr5wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:53 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:51 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 2/7] libbpf: Free func_info, line_info and subprogs in bpf_program__exit()
Date: Thu, 29 Oct 2026 18:33:43 -0400
Message-ID: <20261029223348.3730738-3-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=cL91IVeN c=1 sm=1 tr=0 ts=6ae3c9d1 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pGLkceISAAAA:8
 a=pl6vuDidAAAA:8 a=H8M5Plh0NyvfGOiNpB0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX02P14Wu1Hb6b
 OsVi8jz3r44qfXT3J4LvI5ZCmGQsEOCtjTGEQRLzGlFV2RYBKm1LUo+J/kdpGkx10R8xV+ynuxA
 tVabJ4O1EldUAseJxrSlRj/CZ/AzDv9ch36L7ijJuGmiKY1p/b19KuK69vJe8YyHBMeGnSyqICV
 5DKhzF4HvCWBvmltYKK/AuJWf4Yuo7aMHS8biZRvCEpGV/BTeXg1QRve/2V4i5g4yHHArvlihkX
 FoeJNCUfi84pbdYu132Emqv35gWvGgV8hI+0KTRhSSRLUNkGfCRNHkmRQpTQTfKEHHfkqPC5IbJ
 lkBa0rFicIQ/bNSSoBngf+DGmhyyE8gQBJKAfHz3nhV1sGeMzC0Ze4CVRONwkP0Xo6NY7yqhTux
 vmcMR2I+OASPYWpAWAexxJBbNa1UlLx3gh088B2ub7xlaQLWK4mnvDoAhrrmsalMa4ZRo4iR3+Y
 1AV4x6eOrmP8ohCJrGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfXxUrRmeurpYnG
 M4ICRh8ytrMyZ3UH/2vcJzua3pbkZF4Dk8iE7oQU2cTUpkFQlfVjlUXynOPUUcbCTIEccT0TYOm
 rod56tnLue9RHw1KCibif5e4bMMgL+ru0qWOm9SSMkVBWvIf8zwH
X-Proofpoint-ORIG-GUID: 6x_1pHE-v5LxC6P1ks0Ms54TzEzK2S8t
X-Proofpoint-GUID: 6x_1pHE-v5LxC6P1ks0Ms54TzEzK2S8t
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088

Nothing depends on them being freed in bpf_program__unload. Free
them in bpf_program__exit() together with the rest of the
per-program data instead. This is a clenaup step in preparation
for manual program loading work that follows.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6bb5887090cd..ff04718d47c1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -876,10 +876,6 @@ void bpf_program__unload(struct bpf_program *prog)
 		return;
 
 	zclose(prog->fd);
-
-	zfree(&prog->func_info);
-	zfree(&prog->line_info);
-	zfree(&prog->subprogs);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -888,6 +884,9 @@ static void bpf_program__exit(struct bpf_program *prog)
 		return;
 
 	bpf_program__unload(prog);
+	zfree(&prog->func_info);
+	zfree(&prog->line_info);
+	zfree(&prog->subprogs);
 	zfree(&prog->name);
 	zfree(&prog->sec_name);
 	zfree(&prog->insns);
-- 
2.34.1

