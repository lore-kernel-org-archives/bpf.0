Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E993F54B1;
	Wed,  1 Apr 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042500; cv=none; b=pRzrAZY839e7zSQ1dCBbAcHqRJ/+C1N9tl3V2ebXnyg8OHBD1rj8RUPz3fU1Xmk9vFwcpMJ/ScDqCN36RXe2yH2R9CgQfMznzDFGVprH9zD5HYaknvjyE0C0S8o1+Tvg1VXfVOrCeanjUpdnd+UpKGvpt9i3x/CnUXkzMSAwuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042500; c=relaxed/simple;
	bh=/m2H18mGBoe0ki0UlmuAdFCvHs2KBluZAA/HZaPaWE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8RhaXqtUBcPW5auqiHv3fPIq4fmOI9ITXwDq0e78Qp6qRa30B+Mjqg2ERnwWfJAzPZiCYVDZc5vcFs7mRjZrOkBqbRACQIDBw0mjriP5PiQB85l9DbGvHXkNwR2Dr2xbmfrhF96+b8sPMlaX5AWP2XOe0iGJwtAVTPhAgV1feo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4LCjVLA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4LCjVLA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319ZMpc4177299;
	Wed, 1 Apr 2026 11:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1gWu5swfhBndrAfvrNOR5ecjoMQCuxPVWMqjRl0uP
	qQ=; b=e4LCjVLAu7v1KbNYBG0uw7jD/rqQNGhAbIkbosmXu4ZT1SQBXrOOTqsZ/
	HtXZ//ap9DCG7dFHNEQWPP/pWnCzSAOZBEzda/5rDKiRKMWdOTFfOdj0cOcrpFka
	NAkdRz6KrHBSHDX7qp20YIRBndfW26sXn/UDNRKi9/DSxK7167UZafQpRwn9Qs4R
	ChQzcNpJ/zi55ma9Ge3gDehoji/23ZGtUX8Aewo4Fmj/mCIeN1YTMY7TjF7G0TkC
	ycZNcw2FTURyY5rMQVLx+QFjIST1BECeDGaC1BrA7cbBYgSNPFkfd1KshysIJGDl
	1RzcF5qjZVpGkhkT4p1sk4F/Q55dg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms720p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631AVJY7021722;
	Wed, 1 Apr 2026 11:21:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasnf4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:21:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631BLEja28770698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 11:21:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3950D20043;
	Wed,  1 Apr 2026 11:21:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62A1420040;
	Wed,  1 Apr 2026 11:21:12 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 11:21:12 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 0/4] powerpc/bpf: Add support for instruction array and indirect jump
Date: Wed,  1 Apr 2026 11:21:29 -0400
Message-ID: <20260401152133.42544-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ccffaf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PrvU3QX_WBFfOzZGQxIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwMyBTYWx0ZWRfX/ntHbDZBQBhA
 i5ej0Jt/i49kLDa4gK4o61hNUOn5w0Zc+iXv7PcMaSh+U/Xtu2Nkc1EQcn/sFsFP75g+3u+yIx2
 uokNVwO63p8bCRT4FbqyBAeuuYAxSCFRyck23D1C6erz6q1Bbfc2ys3V+OmspmG4MIiOB9wtub0
 IBuzVpV5B9V1MFUd6NZv3IBD8RocDgt7FRV0nJ4SGOnOgAa3KTPwt9pKHYdujezthdh2eJvI1za
 ximTxgPx58WO03vJSFRXZkzdJG8ZBDtxnvW+1YxUTN6Avh8zD9lCXmCx7HrQc+X1FZ1bYYXC7NB
 hypOj0pIT9hiQYlwRCUxcfiOq3PEE3sbko5ym1MLZWNAu0joIQG6YVHELanSmuOJq7k+itqSLzR
 B9INGKGDHt9HiVNcVCsbb4nWGcikXxJTAm5Dp5w2FLTwLfx5K+tuC+SRhOgQkHSJ5tUoe/AXhyE
 chf+tV376sE033LT0kQ==
X-Proofpoint-GUID: IcPYZ5CPA12J2Lr2MlzngmgiRMKFO4P5
X-Proofpoint-ORIG-GUID: IcPYZ5CPA12J2Lr2MlzngmgiRMKFO4P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010103

From: Abhishek Dubey <adubey@linux.ibm.com>

The first 2 patch enable support for instruction array. Now, the
instruction offset map maintain the mapping:
original inst -> xlated inst -> jited inst

The last two patch enable support for indirect jump. Any eligile
register can store jump target address for control flow to jump.

The later features will be enabled on ppc32 in a separate series.

The patch series is rebased over:
https://lore.kernel.org/bpf/20260401141043.41513-1-adubey@linux.ibm.com

All selftest related to instruction array and indirect jump
are passing on ppc64.

# ./test_progs-cpuv4 -n 20
#20/1    bpf_gotox/one-switch:OK
#20/2    bpf_gotox/one-switch-non-zero-sec-offset:OK
#20/3    bpf_gotox/two-switches:OK
#20/4    bpf_gotox/big-jump-table:OK
#20/5    bpf_gotox/static-global:OK
#20/6    bpf_gotox/nonstatic-global:OK
#20/7    bpf_gotox/other-sec:OK
#20/8    bpf_gotox/static-global-other-sec:OK
#20/9    bpf_gotox/nonstatic-global-other-sec:OK
#20/10   bpf_gotox/one-jump-two-maps:OK
#20/11   bpf_gotox/one-map-two-jumps:OK
#20/12   bpf_gotox/check-ldimm64-off:OK
#20/13   bpf_gotox/check-ldimm64-off-gotox:OK
#20      bpf_gotox:OK
Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED

# ./test_progs-cpuv4 -n 21
#21/1    bpf_insn_array/one2one:OK
#21/2    bpf_insn_array/simple:OK
#21/3    bpf_insn_array/deletions:OK
#21/4    bpf_insn_array/deletions-with-functions:OK
#21/5    bpf_insn_array/blindness:OK
#21/6    bpf_insn_array/incorrect-index:OK
#21/7    bpf_insn_array/load-unfrozen-map:OK
#21/8    bpf_insn_array/no-map-reuse:OK
#21/9    bpf_insn_array/bpf-side-ops:OK
#21      bpf_insn_array:OK
Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

v2->v3:
  Address minor comments
  Collecting Tested-by and Acked-by tags
v1->v2:
  Handle image offset for ABIv1

[v2]: https://lore.kernel.org/bpf/20260227014315.39980-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260225010950.20218-1-adubey@linux.ibm.com

Abhishek Dubey (4):
  powerpc/bpf: Add support for instruction array
  selftest/bpf: Enable instruction array test for powerpc
  powerpc64/bpf: Add support for indirect jump
  selftest/bpf: Enable gotox tests for powerpc64

 arch/powerpc/net/bpf_jit_comp.c                         | 7 +++++++
 arch/powerpc/net/bpf_jit_comp64.c                       | 8 ++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c      | 4 ++--
 4 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.52.0

