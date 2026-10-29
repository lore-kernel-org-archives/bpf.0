Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313247;
	b=0uJZ/ACcw/OwAcUSsvY+WUcSiWsTNqAs4url1eIJM79w9QAMhddmuXxeuYyWckp5KIwi
	 RI2+LuaPWkWS1yni3wo1Cmqy/S/A2+PdDO/Yjcax48CoPDRF/9sYn64rqovT1rQFynKdv
	 +3dQEjVAJo4sdBgBMkA0Y80nef/q4R3FllwnvJQu1yXFp6B9BCYdicFhCTrZojYy8wDeT
	 873vnzvYADUeCjWpoUnpVxRl/ZDZ494GeGoheitN+QSl+p+ETECWDlnI1LIcG6RLfryii
	 VfBU9y9A86qDqQHMBxiMgahYT5FhsQbpiGGkyUDJSClDzORLj6xaqvm06x7t9JCsoyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pFADpNAPF57qBIxeYQqTLTBEZleizS8q3+CpT7ihrcE=;
	b=kMH3+yMpX2owdyhk4vtdswRjWxQHHiaoLZxh5tNzvpydKT8ZsB5qOk3LnAAjgaKy+T7P
	 b3TGT9EPSnlrc481vFQTsN9GDXdAik7XOGBptpNK0wvPja1IVfD3fTdOtn97NnEJyu+gU
	 UgOv6I+iZCshJl3J/70VCK4GsLoxJGj40gC7H4/k1jNFe5Dl5XwOLqFoXrI96gsq7YDBE
	 OTVgri7uPIwdfq9xVE7UyZ9IfxzZomEyASsjOKMKN8HFNbVNCgae5SGZlcouoPLrmC7Zv
	 HZoW4hKqDj3roh01ZdbOJ0o2LtU0YRdqME+4TuBNpAaZnlsJfVCEibxRmNccSMPVViw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=UrQz8NDk;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A0606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C42A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=UrQz8NDk
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TLXeLs2716451;
	Thu, 29 Oct 2026 22:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=pFADpNAPF57qB
	IxeYQqTLTBEZleizS8q3+CpT7ihrcE=; b=UrQz8NDkWp6HsXSoj3PwUlRxJvQu9
	FscfVFIW1h9nKvIBzPJwPbMkF5TafSKenifpN5E8FwQ63vb7SJByyGbzuA5jWiMz
	83d/jWgivbV7wY/LunHrQx8cgGeE8RhXz4wjE5OdqN2yymmA1bkd/UrtxrvvKXJU
	ZLfC5hHpD0sZ8Z84WenktszDP1TsNUW4W2qbUKLyaCban+NmAPqpSyNeR53IgHMm
	9KaPB2j4LMO/FPvyiRea0jwV13fS2lDkFd+9i4/k54f6XiSODa3C5DDqxx3CJAR2
	VDx8COO+gs8GKaXFs7PJ9wz7mj3njH52+1UqdN6LjmqnhapmpOvrjob3A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hme5n85h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 22:33:51 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 29 Oct 2026 22:33:49 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v9 0/7] libbpf: BPF program manual loading
Date: Thu, 29 Oct 2026 18:33:41 -0400
Message-ID: <20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: rWougUN96ceDEfV-_cy-Q7lS4SJfZSTR
X-Authority-Analysis: v=2.4 cv=F4zC5ahN c=1 sm=1 tr=0 ts=6ae3c9cf cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=s6zH5JT6vp80PSxX8m4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX7W/1FPg3xcic
 LAEOPriqxqrFzn1TPO6CItWSdLk35RSXLvjS+LbIv/ofheQrTxK12bQLtpFrtOWZYOjpC6A3mnJ
 8P3ChkH+SomS66FY1GZSJtldnRuduNjTGPmiqACkZMfAr5qhAQB2cdoos23aWaxmBrJo34zEZKe
 5DLleqdx0bKbl9UNYTHigjTj8VHMs/mzCAZusi5qYDEb7ZlEAoWb/71EdvL8OE4mmD/O1CRcyEA
 /Sh00maMQxAAVHNLHMMpHrSYpvzKMAjQ0MPWcAXnXojguFUYgE3zIBU8a7a76cPO3lKVlAuQ6hM
 F3YPA8/CLERK8kcss7tZPHa+lcsu/9V5RyMCLw9CB9wMaMHyz9V5EETcSpOGL0SumsA0GQFTU8w
 5q9V7fJCBTSxKNHSU496EitgfxN12ADrVCEjFOwmflcy9jVO4x6pPRBQNYX9ZU3n1GwRZ0FnVOP
 1e7EUcMkPOXEkLgQK9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OCBTYWx0ZWRfX7GsTdgXpq7mF
 brisRHFj7pcnMHY46zQxZ/qH0lw0HwJI2RsZIuKMq1a0zv83N5KLJlmkmZ/nCLmlzbPlQrpR8VX
 10XrLNNSArLXVGCDYnRTvJtOzbjE/ohbGHGJxMNs+mJvVdtQUD58
X-Proofpoint-ORIG-GUID: rWougUN96ceDEfV-_cy-Q7lS4SJfZSTR
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290088

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/manual)
to let large BPF applications load a subset of their programs lazily,
independent of the initial bpf_object load.

Motivation:

Security tools built on top of libbpf commonly ship as a single large
BPF object containing many programs, only a subset of which are needed
on any given system -- the rest are gated on optional features or on
kernel/runtime capabilities that vary across deployments. For this class
of application, per-program manual loading helps in two ways:

  - it shortens the initial load, since only the programs actually
    needed for the running configuration are loaded and attached up
    front instead of the whole object; and
  - it lets a single failing program be unloaded and possibly reloaded
    (or a feature toggled at runtime) without tearing down and reloading
    the entire bpf_object.

Both reduce the time window during which the tool is partially loaded or
inactive -- for a security tool specifically, that is also the time
window during which the system it protects is left vulnerable.

We have been running this with our internal fork of libbpf in production
for about a year. Depending on kernel and configuration support, around
250 of our programs are potentially loadable on any given system; with
manual loading, only around 90 of those are actually loaded by default,
growing to the full 250 only when every optional feature is enabled.
Cutting the default set of loaded programs from 250 down to 90 measurably
reduces load time (we observed ~60% reduction in our own measurements),
and since unload time scales with the number of loaded programs, it
correspondingly shortens unload time as well -- which matters, since
slow unload can delay system shutdown.

We believe this functionality would benefit other libbpf consumers with
similarly large, modular BPF applications.

Changes since v8 [2]:
  - New Patch 2: free func_info, line_info and subprogs in
    bpf_program__exit(), so bpf_program__unload() only closes the fd
    for any program (Alexei).
  - Patch 4: keep the reloc_desc of MANUAL programs when the bulk load frees
    relocation descriptors, so the verifier log of a later
    bpf_program__load() still gets the CO-RE relocation fixup (Alexei,
    Sashiko)
  - Patch 4: comment the force argument of bpf_object_post_load_cleanup()
    at the bpf_object__close() call (Andrii)
  - Patch 6: merge the load strategy transitions test into the manual load
    test as a subtest instead of a standalone load_type test, dropping
    the part of it that duplicated the manual load cycle (Sashiko)
  - Drop Assisted-by tags from commits, it was recently removed from documentation
    in mainline.
    
Development was assisted by LLM.

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (4):
  libbpf: Reject gen_loader set after PREPARE step.
  libbpf: Free func_info, line_info and subprogs in bpf_program__exit()
  libbpf: Support declarative manual load via SEC("!...") prefix
  selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL

Slava Imameev (3):
  libbpf: BPF program load strategy enum
  libbpf: BPF programs manual loading and attaching
  selftests/bpf: Cover BPF program load strategies and manual loading

 tools/lib/bpf/libbpf.c                        | 261 +++++++--
 tools/lib/bpf/libbpf.h                        |  84 +++
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/manual_load.c    | 507 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  32 ++
 .../bpf/prog_tests/test_struct_ops_arena.c    |  48 +-
 .../selftests/bpf/progs/test_manual_load.c    |  70 +++
 tools/testing/selftests/bpf/veristat.c        |  20 +-
 8 files changed, 968 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/manual_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_manual_load.c

base-commit: d80373a8e70d3193151232c3062abbbe367ff5ad
-- 
2.34.1

