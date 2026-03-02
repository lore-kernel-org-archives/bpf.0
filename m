Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82225DB12
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489553; cv=none; b=WmueLpYl+/l5qEjL5JQ+VofoFEeSfifHO3VpM7GwT1YlQCwXMNPbTni9AjLFKUwZsT+YbcJtsNFXEosDmR3R/iVcjDTvIGtWaJrPXyOEhdJNVetD4gGDJmatqLaMknCo/TxuQ6hBgzoCy/Eeiw+fKskAwD8mrMs0pQygNAGQ/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489553; c=relaxed/simple;
	bh=Q380u98hbbFKgMYSCXX1gCoIOyy9LbtqoKmjz+444Yo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kyFskotrdmKhm3lWxD2brXoX1ZOMt/JkPqQFyxH2i5TBbJD8U8LhBy58zkXMnwJpTysZuOaIx0QJfliaGCRL6rqBaxQMH+VsC5787GMIrrN3NS4JRRfflIPZ8xSnGkd7EZDSO6auVbuBUWj6cb1IYuYCAzTFaKU8FL+47yZGp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jqra6gIf; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jqra6gIf"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622IdfHo2582115;
	Mon, 2 Mar 2026 22:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=sqdcfV6CSkriM
	/AB1lGM8bn6ImxkK8+zee/gS+gcmLA=; b=jqra6gIfMK3UJMUV12eo5an2SXuOv
	lZzzHPSA+DF2CMMARwtSDzlAZJzLiJSBnGU2OePKS6x9e6SjlSz74fhxZ7cuih+O
	eWODS2sNrrYwvEBMVtspmqLQMNZzDJPbRo0FSJ27O+DH+OffsBnGnSW59utvAzws
	jQHBP0qA1Vc+jL4IS8y0BWJQ/6Dlt+t+W5fA842XctPa+HG87Uu2bTxt8pv6cfas
	/EK7iownVvotcPWtOEif0Ji+LPPdh46Tb1Hswgg6Fu0AUh7RA8Zhc/5sGgxXsdT7
	H0Ur1jTuHBXW+yi/RosKTOQfuwK/VoPlWnljW3bvFhJ2piiwXvvwGnWag==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmbahpgm7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 22:12:15 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 22:12:13 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 0/2] Handle duplicate kprobe symbols
Date: Mon, 2 Mar 2026 17:12:05 -0500
Message-ID: <20260302221207.409151-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH010.crowdstrike.sys (10.100.11.80) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NSBTYWx0ZWRfXy2lIUemy/q9R
 phbQAaJ5Bdnd08h7uno/7RFcluyI+pf2ZNtLwBM3SYMZBGW4GuPa+eC/Qi1NLeCc+ztsApPPeal
 k8rZr+uj1u+iBMU2cwI465dZGsMOuysT/8rd12jYDQCjRvoacQQxKoanT/HarUow4bibZOI2yWr
 w9x6kLDx3e8TuiJ9J4hZXKorlIW6o22oLxHrIB/0Vvibf5Jx3VqPvfM3l1gjojgHZ0BEDtjZbEe
 JD4xwb3gCTXWNTzCHHFV2mIzRNL0LL7HbrgTWjwYQlUkeyvlvJU4p9lgHriloTVC+1IJ9pmvkzY
 Sb2FE09ijanYG5WxmDs/PgLHql8fH6wX6mxe6IZ3KUleAQ6ZuQAqPVQxPXE5EjtH8Bc+8lgB8ve
 5wHPn3iomoxeJRarxpCNSlVj4pGZ9ibclyp362VMhbqymGpQpwaH2vAWW53QIEdorK8/xhSRIKq
 SHArzizkjGMhj7iLQ5g==
X-Authority-Analysis: v=2.4 cv=UNbQ3Sfy c=1 sm=1 tr=0 ts=69a60b3f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=pNwn3ynNfXSQ7a8Z-kcA:9
X-Proofpoint-GUID: PkGOqpEuhIXK6jFugqNeJ1Kq5A2s_H08
X-Proofpoint-ORIG-GUID: PkGOqpEuhIXK6jFugqNeJ1Kq5A2s_H08
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020165

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
tracefs path)
                                                                                                                                                                                                               
This series implements a fallback mechanism that, on such failures,
resolves the vmlinux address through /proc/kallsyms - filtering out
module symbols - and retries probe attachment using the absolute address,
bypassing kernel symbol name validation.

Patch 1: Core libbpf changes - kallsyms parser restructuring, duplicate
       symbol detection, and address-based retry logic.
Patch 2: Selftests with bpf_testmod_dup_sym.ko test module validating
       kprobe attachment across all four attach modes.

Changes since v4 [1]:
- Fix tabulation (CI bot review)

[1] https://lore.kernel.org/bpf/20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
  selftests/bpf: Add tests for duplicate kprobe symbol handling

 tools/lib/bpf/libbpf.c                        | 155 ++++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  63 +++++++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      |  48 ++++++
 5 files changed, 250 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

-- 
2.34.1

