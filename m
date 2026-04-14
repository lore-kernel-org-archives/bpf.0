Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC653128CC
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196249; cv=none; b=qtw/k/N29CaA5JyfLs3HoCc6HwUZSuQoaQEoNJu3avx7/0/tEgYtX47jYwDZLNQwjfbAbyJ7x2Nr6kTfYL5LEDPRVWGJPya8jSWDrfIoxVFFQ8ZAFrallhB30at0qSqJhhaqdG4ypGPs61jG14Xzyv8vE2V+hfg/ducge5iDFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196249; c=relaxed/simple;
	bh=HnOW8eRPBOqd+45JUpSjb5Qg22T7FLK9AfU2oH+vzRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfH2H4TpGNUftwUbi9Sg1GGCr7+sFvcNm5rquM5PsMjPRHBu4nET6UJyEMLot4AJT1t69NRuUXqtwm83JT0kjetdnaruqdEvcCckCJkPIY0uvLaDZIPX9zT279kTPNI2g9Q2bJZpHJtKxAqH5vgxMjbgZ8Yr89obDyuKYZ+xupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iUT9xUhK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iUT9xUhK"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EFgLQn1233252;
	Tue, 14 Apr 2026 19:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=psTyTl5Knp4wvwJPCaGVzPWzY5ZTy
	eLmt5BMJN1wV4E=; b=iUT9xUhKZkDT+d/pAkLjB/XmYrhJtyGuOmYMaokRjQu5o
	WrM64rEBnX8Lm+rzLu5HZ3tr26RICISpXbjF29nE9Pso2FxeZqcfxdS95HWuUvuU
	RUwIBe+r23uq9CVcZd4Riw3FKqLv1cK/F+Oc/iTUfZ2Z1ov7vtUBa8FWk2ZqFIdq
	CzQxYwqpbI9P3GDScYeR5F+IW0ozWisLdJulk/HoGA/ELxhs/qqPmi/EtJzUhmdB
	mMH94OZqh1mxT6/0RA9eeYDmE10XDxuIWmToYO5M18P046uiQ2YKj6yNAGYbt2Fx
	yzEeeznhxK5m6teQklsP/DZwKLvaArBzoqwRQ/YmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85jkmp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63EJnOdv025407;
	Tue, 14 Apr 2026 19:50:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nkpg7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 19:50:25 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63EJoP5N030710;
	Tue, 14 Apr 2026 19:50:25 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-225.vpn.oracle.com [10.154.50.225])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nkpg37-1;
	Tue, 14 Apr 2026 19:50:24 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/6] btf: Extend vlen, kind in struct btf_type
Date: Tue, 14 Apr 2026 20:50:13 +0100
Message-ID: <20260414195019.684531-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604140185
X-Proofpoint-ORIG-GUID: 46mzi_zCOAjnZhlMXasngqJzQgyLcj2c
X-Proofpoint-GUID: 46mzi_zCOAjnZhlMXasngqJzQgyLcj2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4NSBTYWx0ZWRfX1i5ZQxyZieXO
 cMJfrtbyeLBTXVEhnKtV1JfM/H4sfJg94PxQFiN02GtuvPCNRytlywkYIgoRRy9GaN9mrq3j10Y
 /lJNTzeqfrRPjdZkJinnmscvrLT7JmELcnTFhCt/SfE2vw3eB4ragwwlxrf1otlY8Y3i+IJQXuV
 LbOtjvB1KcJ31ZpG543QxwlxjjSr9EAgWKwgTtfmh12blgw5Jdw+aa2dB+Tfpzk/huDv7y2FgT6
 2U7tCDevyX2Mzwxxlff/GwzuTwuX+Fd52GwcS3dYJx+L4yt4COJaR1xphNB4ZknS1ivjMTcl/3g
 JLiK0R7/JErEVix/u6I8WHvW+J2v6gyqEqxH/EJ+4YtpKUnHJWfIhqW2DuWYBKRLom/9w6zfUB0
 EaILaafurjXExUTxIjCs/ScvAcuuo5IVCgZzWzxvLNk1252zhrJPACeIQleCJpWilPE01hOVoji
 0BIjbMB17BCwQYQhFew==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=69de9a82 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=cGtFDt98NMqH_S1CzCgA:9

Currently BTF types can have a maximum of 65535 vlen-specified
objects.  While this limit has not yet been surpassed for existing
cases (struct/union fields, enum values, function arguments and
datasec), upcoming BTF location information - specifically inline
sites - will hit that limit.  Utilize unused BTF info bits in
struct btf_type to increase limit to 24-bits (over 16 million).
This is more than an order of magnitude greater than inline
site counts for the kernel (~400,000) so should be enough for
the near future at least.

Similarly, struct btf_type uses 5 bits for BTF kind values;
currently we use 20, but BTF location information will consume
another 3, and conceivably providing better support for Rust
types in BTF (now that modules can be built using Rust) could
push us close to the max of 31.  Use 2 unused bits to provide
a max possible kind of 127.

Patch 1 handles UAPI and kernel-related changes.

Patch 2 updates libbpf to have btf_vlen() return a __u32 instead
of __u16 and updates consumers in libbpf accordingly.

Patch 3 adds a BTF feature check for extended vlen/kind support;
loading BPF program BTF that supports extended vlen/kinds should
fail if the kernel does not support them.

Patch 4 cleans up __u16 vlen usage in bpftool.

Patch 5 tests the BTF extended vlen/kind feature check.

Patch 6 fixes up a test that relies on BTF info overflowing
maximum kind value; fix up the expected error to be an
invalid kind rather than (now impossible) invalid btf_info.

Alan Maguire (6):
  bpf: Extend BTF UAPI vlen, kinds to use unused bits
  libbpf: Adjust btf_vlen() to return a __u32
  libbpf: Add feature for kernel extended vlen/kind support
  bpftool: Support 24-bit vlen
  selftests/bpf: Test BTF sanitization rejection for invalid vlen
  selftests/bpf: Fix up btf/invalid test for extended kind

 include/linux/btf.h                           |  4 +-
 include/uapi/linux/btf.h                      | 26 ++++----
 kernel/bpf/btf.c                              | 25 +++-----
 tools/bpf/bpftool/btf.c                       | 17 ++---
 tools/bpf/bpftool/gen.c                       | 16 +++--
 tools/include/uapi/linux/btf.h                | 26 ++++----
 tools/lib/bpf/btf.c                           | 26 ++++----
 tools/lib/bpf/btf.h                           |  2 +-
 tools/lib/bpf/btf_dump.c                      | 24 +++----
 tools/lib/bpf/features.c                      | 39 +++++++++++
 tools/lib/bpf/libbpf.c                        | 17 ++++-
 tools/lib/bpf/libbpf_internal.h               |  2 +
 tools/lib/bpf/relo_core.c                     | 16 ++---
 tools/testing/selftests/bpf/prog_tests/btf.c  |  4 +-
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 64 ++++++++++++++++++-
 15 files changed, 210 insertions(+), 98 deletions(-)

-- 
2.39.3

