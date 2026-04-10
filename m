Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0C225417;
	Fri, 10 Apr 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785463; cv=none; b=LwAUUWQJShPLVOWF+ToMsG/razDqrCFctO53qriOLK7qL/qoBufjEZkpp/O8QFBRgdfFgc4VnojrF8zBRRgrObwToDcL4AghZhdinzfwBnsIjfX7XDtlDiaA/gc6RoGXKZn+JGK7uU5L2ZBshm/FAKZeZyLxMiu4TCZlZ2M34PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785463; c=relaxed/simple;
	bh=aLPPxdkHWSTxMGERxDQ6Hz8oUK9gClGFiW+/4k/qV2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEmPH8CtSwx9r2WGhY/7dJJ/iZXSm/BcgE5adkBhjsQ3hBaxA4D6feCDyKrbZhJQeWtlx7kj0TijUn8/peKxFiYOv/WiA3nwBJygjR+578eyFCBn8ojaMmdY9oLQEWRlzqxP7v8kVPnae/nN+/ttF1w9GFboypOyLB5qJnuAbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=E3HpjW3u; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="E3HpjW3u"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639NgHEE275074;
	Fri, 10 Apr 2026 01:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aLPPxdkHWSTxMGERxDQ6Hz8oUK9gClGFiW+/4k/qV2Q=; b=E3Hp
	jW3unf4xgktY7G5Tbsov+dmP6NBPujAKwuOg/mvQvNdGObnCEjMxAV/POa02Cl4F
	s9jvrht1zX+MJ7EEpsgFelAvoq6a4VTzOOj+1a3MunIpczhCen/xs7S1VFfJaCeW
	tuOlTVPADnRBhw+tWSR4Z14r0T9qUnDAJ+uiqSr7BiZyerO7NJYdcrpFgodOyahh
	u6UJj1LDOPfOgBJHWM3uEH6SVAFll/GrBcytwSJQSrONTdZUC5G2NhkxUvi7K+l8
	ZsjYTiTQPyF17OpaHjd+gsSOtd6uj4Athngle2Jkxdhg0XI0KWH/lX5Kd3Blt2fe
	N6/oK3JMyjvkxvet9Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dehv0sf94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 01:43:50 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 10 Apr 2026 01:43:46 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <ameryhung@gmail.com>
CC: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@meta.com>, <kpsingh@kernel.org>,
        <martin.lau@kernel.org>, <memxor@gmail.com>, <netdev@vger.kernel.org>,
        <song@kernel.org>, <yonghong.song@linux.dev>,
        <linux-open-source@crowdstrike.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage
Date: Fri, 10 Apr 2026 11:43:41 +1000
Message-ID: <20260410014341.47043-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251114201329.3275875-5-ameryhung@gmail.com>
References: <20251114201329.3275875-5-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: RcXIRzfMWFawyeH2AQxMufBQSFniYC7_
X-Proofpoint-GUID: RcXIRzfMWFawyeH2AQxMufBQSFniYC7_
X-Authority-Analysis: v=2.4 cv=VPHtWdPX c=1 sm=1 tr=0 ts=69d855d6 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VpCBGzChIgXs0OzVo5AA:9
 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDAxNCBTYWx0ZWRfX7ltmy9VraLnZ
 fbPzYGT+ZnAtykRYxzCrEzoN+vMh2GUMVe4atfbWIZ1Af0nNiOQEMwNZDNJTGfY6YNT6syaFgK9
 sV7uhcJPpuo0agk632fwMLWfJ5Ob4ScSCvMRMcSHXqUroKFit4eA3PAYD98w5Rx2dZca1Z7TD+y
 OhfJZqjR0NjtHZRUCxo3Ija5otxf59NdhCQsU+SSZV6gqgW5uJBJrAYYBnFs3yONDzT9g6O197R
 Oql2k6qxBNlxg9MtOQnUQYg4JkWj7j3trR7d+BIivh67V5kXDmr3C1UDkbWq5rFeq8Jsyq30pqq
 3oZz1zDOs9g8j3zjZzFl/xC5umbRlFMHUb13HxNHL5CJ7vEldlYAuvkRtdX6HdpSOU4Achj7amg
 u0VJlaysYxw8PDmO3vvauAIjLWnlhr/ekc1ytBW8z7MCzrVIEdMvWYmAmhgRMSONRlns6DntlJZ
 vkMjr+2Dua/0oxKZ10g==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100014

I found that this patch restricts task storage value allocation to
KMALLOC_MAX_CACHE_SIZE on any system regardless of CONFIG_PREEMPT_RT,
which is 8KB on many systems, as use_kmalloc_nolock is set to true
always for task storage by task_storage_map_alloc. Before this patch
there was no such restriction and task storage supported at least 64KB
allocation for value, restricted only by
BPF_LOCAL_STORAGE_MAX_VALUE_SIZE. Was this KMALLOC_MAX_CACHE_SIZE
restriction added deliberately by this patch?

