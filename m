Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FC145348;
	Mon, 23 Feb 2026 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839972; cv=none; b=Ch7Sh7cBWlutgXTsWBZDYVea5oFWNjVsRLKa2dMQIgTHrTeJrIIQ6dXIwHK79Sp1JQbTVuuJln4x18DI8RauvbaDFDl9AN55ayuQgJ/9yED+Wj66GNdpTOE61YVB3OmM+bteNc0xWbdzjJ46/GKv5F3uoYuOo/qFeTBbHydinac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839972; c=relaxed/simple;
	bh=yPRkaRS6xCl+Ba/XYQOMFWH+i0o393KmfiXvx+ReNoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUNYhV05h97TA1L2Xb7cozaiGXv9/w+7/0Wv5h2GujE+NznGVT7wiRMrN6rzas9LHVtTOGCasoE+nT06ZxxTHq2ZOG9OGumdYg5tyDloBJT67qxCn+NTh15u0qm5wuOjskksUYTL9Vfs2gej6b9wIiiOL57oiAffObyrf0x+zLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HmII/pEq; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HmII/pEq"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N9FaWo912091;
	Mon, 23 Feb 2026 09:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yPRkaRS6xCl+Ba/XYQOMFWH+i0o393KmfiXvx+ReNoY=; b=HmII
	/pEqFkzPRukv7r2n3dB2AAqdw40A39IhgYy92ZW7jG8NStQjza9P2QKuatZmWIpc
	5U0NxvBz5XL3eBkki+CebhjdSZuTSBtyaK4RMjDOzS0v0aKC1gZdAAFgpGZQot1e
	byYuiWJkNrzT9RNXy9x11ME00kqJ524D4jSjUIvIcJC0pQEgNc7isFv9S6iQC7Vf
	Q9Kyk2+7uxzJwEmzq2ywwWT/l6M7Z6BAKo96mKR8N2Jya4+qOAhfll4w6JC8Zdjm
	RLlxgKRe3IWXhBmeqjtpbE43sMlPYEgcA8j6BUa064xGq7BM3kswJLmhR8+PYsYG
	O7zZlTwXWhnWkiyWDg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cftgxbrp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 09:45:33 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 09:45:11 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
        <edumazet@google.com>, <haoluo@google.com>, <horms@kernel.org>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kpsingh@kernel.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-open-source@crowdstrike.com>,
        <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <shuah@kernel.org>, <slava.imameev@crowdstrike.com>,
        <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: Re: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
Date: Mon, 23 Feb 2026 20:44:23 +1100
Message-ID: <20260223094423.26551-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com>
References: <CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com>
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
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4NCBTYWx0ZWRfXxKMhC26uW/sS
 VQhBnpPk/dLzBnOC0sWN4wR8pIttZ4R/qnnBuviPXEEbaEN0SCHqLdMw7rRunGIlNT29/HAJeDn
 0NfrNWJR43xo/hWkfnD9szVANc3WFIP69v8FZkp0SkYcb2Yv7GL69nGBQrXv2xxGSWEA/BBxPVP
 rc0tWUSc6S8kXZ9ni+/W8oN2nAd4rkv6ZZDAHwqNtrJGmB4BBb5hBVcaQBe57SK5HdYoajxLP5A
 40KC/BdDkgBhDv2u1ccopWfqXNi29+GPZsmufnWlU7Gmfs4rumASl9y9ghycEFlbum4h0gvaBrR
 /yGlmUHfJuXVYUDKJatq8nqzqz1YYipnYqcr2kvvxOrfYRghMcNJZe6Itj1oYw2Y6qyEyD3KkW/
 AyzAV+Pl6btm3X8ShR9JhCdG4FbeIYa11ENmvYcgsM0DiPIV01GBSZGGb4QW++89tC5Nf1CG2o2
 nN6M0iZBh/D5z2VZ/XQ==
X-Proofpoint-ORIG-GUID: -TQ0QlKj59_ApXtzOc_qSSDtCQL_w70e
X-Authority-Analysis: v=2.4 cv=S+XUAYsP c=1 sm=1 tr=0 ts=699c21bd cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=pGLkceISAAAA:8
 a=fhEmHalCemDr9p1Y7F8A:9
X-Proofpoint-GUID: -TQ0QlKj59_ApXtzOc_qSSDtCQL_w70e
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11709
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230084

On Wed, 18 Feb 2026 19:15:47 Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote

> so I suggest treating 'void **' as a scalar as Eduard suggested.
> This particular sb_eat_lsm_opts() hook
> doesn't have a useful type behind it anyway.
> I'm less certain about 'char **'. If we make it scalar too
> it will be harder to make it a pointer to nul terminated string later.

> So I would do 'void **' -> scalar for now only.

I changed to scalar in v3, keeping broader scope for pointer types.

We encountered double pointers of various types that required
workarounds, such as:

int __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)

Adding support for void** alone doesn't address the broader issue
with other double pointer types.

When annotated array support (including char**) is added in the
future, it should remain compatible with the scalar approach for
legacy (unannotated) parameters. Unannotated parameters will
continue using scalar handling.
