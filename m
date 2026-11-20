Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166315;
	b=bP1KSV4NLXSsukS9Sj0845A4JFk7kVA+ycQOJ87jjTLmC9zOM/9WqFv4Tr/aEs9caO7j
	 bo49j3S48uR4tZp16VltB0T2/toKw0aiM87fA6jpeo1Yr66PwdM98WBAS8k+gdCqi+oRr
	 oYi2R3CdOVquWuB1GJYl08u0KMHMI4NLs8jFU0ubRbznNOQUL3VbDPWZiuai/dZmxyPSm
	 MZ+XQeeTWRLVvBbhLg9g4sQ4jMQvutl2l9/Sz9bpoh7ojq20pZMLdovIZJTELBWZbDoYI
	 MyIS59us/X9n/aXCQf+G2bXlpO58sBGfZhLhqu+XtkdtVlrBhC423/jHZq2APxPLhNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166315;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=F8c0szBg9qBHwMYngo+k10AIndbBzGKinqqurrP/q1M=;
	b=Wyk0DcYmnsbPhhf4liw8aX1EvMoWCT2e2ekPauildCInf+N2vocHJIk7RknUoYbSEsdZ
	 AlUSOGelCyYaCoAOInquXBkepFt0FiPFow941/FNW1iOvkaz3rREIOpoJVutzPaGLWMej
	 ZByxim0tcFx14Oif71FFFTuHYJFv1fNmA8c+lfhtW4P7Uc1X6m4bjZzqk7Q+0dCbnTnDY
	 4JAEW6/HSCmmI+xLvdNkLihFDSYZl7AjbAIGXTYvUfIKoNaoju5Ze8zYQk9lziVxTA+D5
	 QDJzCwjYJucKV6bRH2wtVuBSH93ds/Pwj07NoiRJ0oV0K2VxBXcJpbmj6yG4xxwSDfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B13606A325;
	Fri, 20 Nov 2026 09:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B13606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 56812648e4c311f19a56ed5b684f684d-20261120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0a05b280-e42b-4f50-97dc-55faa032f0cf,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:0a05b280-e42b-4f50-97dc-55faa032f0cf,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:b1673874644b880c8c8dde93e9a7f8fb,BulkI
	D:261119223002FMBWSIFN,BulkQuantity:3,SF:10|66|78|81|82|83|101|102|127|153
	|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 56812648e4c311f19a56ed5b684f684d-20261120
X-User: sunshaojie@kylinos.cn
Received: from sunshaojie-pc [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1708704801; Fri, 20 Nov 2026 17:18:24 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: arighi@nvidia.com
Cc: bpf@vger.kernel.org,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	sunshaojie@kylinos.cn,
	tj@kernel.org,
	void@manifault.com
Subject: Re: [PATCH] tools/sched_ext: Add "arena" BTF type tag to the __arena qualifier
Date: Fri, 20 Nov 2026 17:18:12 +0800
Message-ID: <20261120091812.968482-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <av_lQuuL5lgbW1BW@gpd4>
References: <av_lQuuL5lgbW1BW@gpd4>
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

Hi Andrea,

Thanks for the review.  I'll add the tag to the fallback definition of
__arena in v2 as you suggested.

Thanks!
Shaojie
