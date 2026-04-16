Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB73BA248
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350401; cv=none; b=u7+u/odWJirHzl9zZ144eqbYybXqd8t7+t5vjuaZBin3D1CjxKxh3KbXeFmfn/UJ1EnbjJjiBYpSz88wG6JcB1N+W3exprm0gcVY53xgU3hIaoP0idiEt3YKFhShQABLcMFSDYyLMq1UxPf09La9fOgBGNelQHd6Vqbv6JxV4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350401; c=relaxed/simple;
	bh=5kgAcle2cbqJqhOeUNUte0rjJ0zeVoj9pMOyRzTXdPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axeyvvLqGk5XpynlAtutGrm6Is6IV4KTNe/QmKSCgwU/TifglB3ivyV6NWP8crO5XLW6tfA5Q3o1pGrL8QD+Mu7VyQM9V3EiczQ280VQfEVd+5P84Pw+sIlWszI27sYQq14At3hMqX9jEem4sPKuBIAP9UGrl5WE3F82ArbUxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p6SzWz3B; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p6SzWz3B"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G6g92u1959564;
	Thu, 16 Apr 2026 14:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HirveHK+aJmsMfQCK0N7FD3qDOBDI
	lXVPDl7RilSU5A=; b=p6SzWz3BeZj3gw0X1tTMylnyVWpyoT/shth9Z5Cqt8nF4
	0eBSvava9ZJ+4FIO/ihKG9uhE6n0a+RtIfXQ52AZ6nbG+P7HZd8iRG26uiAPeVia
	+TBV1eBj+pxdiOs3Ds1ZcCTc4sdBlmMqqFPPGZQxCdVCFL1triwNUl9ggNO5wU8Z
	uUulqh+W7geqk+UbuaaDLj0taXJxTqWc6bvli8hFKCWg/SPTdmPSlMObH5Ag21Ss
	ETEi6LE0HUGvuwOwRCowEx8xsH93Md/irsoDp5k6Nxad2BInJxWdPi/pA+Cejm9c
	0FdIjyXePcHG6Fgg3WcUIUmE4jK7i3VfAtT5bYdNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85jqn9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63GEdRuH017726;
	Thu, 16 Apr 2026 14:39:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nqkmcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 14:39:35 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63GEdXaT018534;
	Thu, 16 Apr 2026 14:39:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-74.vpn.oracle.com [10.154.52.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nqkm1k-1;
	Thu, 16 Apr 2026 14:39:32 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/8] bpf: Extend BTF UAPI vlen, kinds to use unused bits
Date: Thu, 16 Apr 2026 15:38:56 +0100
Message-ID: <20260416143904.1220662-1-alan.maguire@oracle.com>
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
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604160141
X-Proofpoint-ORIG-GUID: cM13LTzf5lxFQrIUx6aDRGp1KIrN20uO
X-Proofpoint-GUID: cM13LTzf5lxFQrIUx6aDRGp1KIrN20uO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0MCBTYWx0ZWRfX5cG+gt01vMJ3
 7BrxqlI4xk858mnJLWwgRpjm9wqawDFJ+mIQYZtYDHrRh7dZSofOyANS4A2QVPOVnlC4PJO9ybu
 EzrTGrCjTIPtYiTJVSCSPSPUBRFqergGcV1sFkFSjuFVMGNsqzLzeQQ3tuo8A2huGBl6Bc2AcrZ
 rhWw0XBFya/rZgh7F2FmUpjOEkwy1BBpgeG8r7xX5ta9FF/wlmn0uY2JHCQs97+sEygp1r5g8RA
 VNtQT0pPnQjQI9LPmMnMbQPvRNH1YiT5CX7dAM6WC3I78c2lAOVF/BD+j/k2VQ2r7UHM7vFm7lj
 +4mN5WSxqlBaAGF39EXzPz5x8fQNTFVDtl78/+23gxQi7MgrCsW42NxWg54k+Fv3X3oRnHbiR4w
 MORiWz2JIh8lp+p6NClHT+SUGMaPrWprrVdSH0jJUoJ15+T9pkWOvEucQoPIoNRnSlaRIi+3IfS
 UwuY6x5h6cXt6FncIj+fVJ4GVmfYDmbGJgokGk1g=
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=69e0f4a8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-XFqwly0Y5zvRpRwvA8A:9 cc=ntf awl=host:13825

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
loading BTF with a vlen > 65535 which will fail if the kernel
does not support extended vlen.

Patch 4 cleans up __u16 vlen usage in bpftool.

Patch 5 tests the BTF extended vlen/kind feature check.

Patch 6 fixes up a test that relies on BTF info overflowing
maximum kind value; fix up the expected error to be an
invalid kind rather than (now impossible) invalid btf_info.

Changes since v1 [1]:

- added redundant macros to UAPI in case enum switch for BTF_MAX*
  values causes problems (sashiko, patch 1)
- updated feature test to use BTF loading rather than vmlinux BTF
  lookup, in line with other BTF feature tests (sashiko, patch 3)
- fixed up a few more kernel, libbpf, bpftool instances of __u16 usage
  (bpf bot, sashiko, patches 1, 2, 4)
- fixed up sanitize selftest cleanup (Mykyta, patch 5)
- used unlikely-to-be-used kind (sashiko, patch 6)
- fixed a few lingering selftests uses of __u16 for kind (patch 7)
- update btf.rst with new vlen, kind sizes (patch 8)

[1] https://lore.kernel.org/bpf/20260414195019.684531-1-alan.maguire@oracle.com/

Alan Maguire (8):
  bpf: Extend BTF UAPI vlen, kinds to use unused bits
  libbpf: Adjust btf_vlen() to return a __u32
  libbpf: Add feature for kernel extended vlen/kind support
  bpftool: Support 24-bit vlen
  selftests/bpf: Test BTF sanitization rejection for invalid vlen
  selftests/bpf: Fix up btf/invalid test for extended kind
  selftests/bpf: Fix up __u16 vlen assumptions
  Documentation/bpf: Update btf doc with updated vlen, kind sizes

 Documentation/bpf/btf.rst                     |  6 +-
 include/linux/btf.h                           |  4 +-
 include/uapi/linux/btf.h                      | 34 +++++----
 kernel/bpf/btf.c                              | 27 +++----
 tools/bpf/bpftool/btf.c                       | 17 ++---
 tools/bpf/bpftool/btf_dumper.c                |  4 +-
 tools/bpf/bpftool/gen.c                       | 16 +++--
 tools/include/uapi/linux/btf.h                | 34 +++++----
 tools/lib/bpf/btf.c                           | 47 ++++++++-----
 tools/lib/bpf/btf.h                           |  2 +-
 tools/lib/bpf/btf_dump.c                      | 24 +++----
 tools/lib/bpf/features.c                      | 43 ++++++++++++
 tools/lib/bpf/libbpf.c                        | 17 ++++-
 tools/lib/bpf/libbpf_internal.h               |  2 +
 tools/lib/bpf/relo_core.c                     | 16 ++---
 tools/testing/selftests/bpf/prog_tests/btf.c  |  8 +--
 .../bpf/prog_tests/btf_dedup_split.c          |  2 +-
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 70 ++++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.c      |  2 +-
 19 files changed, 261 insertions(+), 114 deletions(-)

-- 
2.39.3

