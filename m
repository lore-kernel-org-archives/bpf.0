Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7F33032B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963811; cv=none; b=pl/Njc2DO/DtSYzrNJrTbgE3KJhy7HOvhveboOxqstLjDte3I/khpZQtYdBT4SxSfAFmHZPH3p21HcVCJvRCEThpwGasak4j9RjOmiu0RwBLQLyXeoG50HQ43NhO7KkHyTiBa2KpPaLYYYlzb2nBO3sv3uDASuiYE/01hGtOPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963811; c=relaxed/simple;
	bh=n4JA1WkEWb295DjXf9YL10EJg1nekHY8fbFlQsNA29I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMrVRiYSK9Nu32PVXCM21Cff+hsT5BI7DU8bFkZFl7qZVcC/k2+yTTMYwy3GZ8UbwiHg+tXt80zomLPKyf1dbgyAUJpv8uObG0Yz3IX+TlUNGw7oNCRCsyZWmcWziFIJqDKT25xTQziERvzgGp1vp+ctve/cPBRaPaXESk7C1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HEworAZq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HEworAZq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OEMe6K327440;
	Tue, 24 Feb 2026 20:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=62cf8BdE7tqhziY156GWJ+4twaLE
	iemM+AhXMVEXK7k=; b=HEworAZq/IZpEBwiGGjnqw/WJZQ09OftyX/3AmlUrm9X
	hub0pdv/Bw5CtQG9IPyGcscuU+fMTXtb/6sDAM46b+HWfYMLy+/XbXp6wXtW/5vu
	XTcXIP7k/SP2Z9fPsClQgEowQrqlOKwPPcy8lbinnH7fHVDtvBhGza8YaDvStiSq
	00FbLb0mdSb8BhfEGbeUIPy8NwfAHk3cf7nYnuwxIA0m6eA6d5c7tybvyHcsIZ9u
	LO2gEwVKgj9MEF+3CYM63F9+2ksWZxZFffiXJDsKSaPOFEpc98xK+keSyAvNhOd6
	mcWZC19hIUoCGxsm8TvY4nCVJw0Us627eb07nQSOfA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c4t6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:09:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61OH5CUm001631;
	Tue, 24 Feb 2026 20:09:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n2fum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:09:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61OK9lxS49545560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 20:09:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC7D22004B;
	Tue, 24 Feb 2026 20:09:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B30620043;
	Tue, 24 Feb 2026 20:09:45 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 20:09:45 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org, hbathini@linux.ibm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, maddy@linux.ibm.com,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 0/4] powerpc64/bpf: Add support for instruction array and indirect jump
Date: Tue, 24 Feb 2026 20:09:28 -0500
Message-ID: <20260225010950.20218-1-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX+UFLxuhYOBOy
 1rrdHQNAFXpUFDJc6MMS1N1vfeRU0x/Lu9k+qEbD4lBCzu77D+V0MhUW4Pi/CXYa/oBLR4J0VG4
 20LuCLABMhLwpaklFMfv+QWmyuRsHqavTvtw/IS8nTBSkjcRCRqXHmCFOJRrdTBdi01H/tf+I8S
 Z3MyUeS0ap8tORbq3ETus7hiFwvBKJrRE1kIYpcYMYrEqQNLmq25U7ooi+z/KiLrALgYQ646IbR
 q3NE3gV43fbpOTG4LCURuRoTQF0SZE4GpuC3K5Qa71P+YjpfBepPMRTVnF9wZq2pmV0x5afxZKz
 l/b0bvZ6ipew8orFrGsW3RZT3e64Yea/f11XBnDALQlm5XlegQ23ZpK8kwSjHd80bmms9Ri923Q
 EWNzfzQZB1fqCcCOsoCGzgRh3B3tgIuxpENi+7USe1F36cRUeT95OkH4ayD+nPukYSc4/aYroVu
 mYSP4ECjYvvCTztfG5g==
X-Proofpoint-ORIG-GUID: cgqE8olK2WkmaJQvaM3tpNxMOfjz9Ozn
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699e058f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=qf4gfuq51q0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=L4-lWHaHw3GvA7f3vB0A:9 a=3ZKOabzyN94A:10 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: cgqE8olK2WkmaJQvaM3tpNxMOfjz9Ozn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602240173

From: Abhishek Dubey <adubey@linux.ibm.com>

The first 2 patch enable support for instruction array. Now, the 
instruction offset map maintain the mapping:
original inst -> xlated inst -> jited inst

The last two patch enable support for indirect jump. Any eligile
register can store jump target address for control flow to jump.

The features will be enabled on ppc32 in a separate series.

All selftest related to instruction array and indirect jump
are passing.

./test_progs-cpuv4 -n 20
#21/1    bpf_insn_array/one2one:OK
#21/2    bpf_insn_array/simple:OK
#21/3    bpf_insn_array/deletions:OK
#21/4    bpf_insn_array/deletions-with-functions:OK
#21/5    bpf_insn_array/blindness:OK
#21/6    bpf_insn_array/incorrect-index:OK
#21/7    bpf_insn_array/load-unfrozen-map:OK
#21/8    bpf_insn_array/no-map-reuse:OK
#21/9    bpf_insn_array/bpf-side-ops:OK
#21      bpf_insn_array:OK
Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED

./test_progs-cpuv4 -n 21 
#20/1    bpf_gotox/one-switch:OK
#20/2    bpf_gotox/one-switch-non-zero-sec-offset:OK
#20/3    bpf_gotox/two-switches:OK
#20/4    bpf_gotox/big-jump-table:OK
#20/5    bpf_gotox/static-global:OK
#20/6    bpf_gotox/nonstatic-global:OK
#20/7    bpf_gotox/other-sec:OK
#20/8    bpf_gotox/static-global-other-sec:OK
#20/9    bpf_gotox/nonstatic-global-other-sec:OK
#20/10   bpf_gotox/one-jump-two-maps:OK
#20/11   bpf_gotox/one-map-two-jumps:OK
#20      bpf_gotox:OK
Summary: 1/11 PASSED, 0 SKIPPED, 0 FAILED

Abhishek Dubey (4):
  powerpc64/bpf: Add support for instruction array
  selftest/bpf: Enable instruction array test for powerpc64
  powerpc64/bpf: Add support for indirect jump
  selftest/bpf: Enable gotox tests for powerpc64

 arch/powerpc/net/bpf_jit_comp.c                         | 6 ++++++
 arch/powerpc/net/bpf_jit_comp64.c                       | 8 ++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_gotox.c      | 2 +-
 4 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.52.0

