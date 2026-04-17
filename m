Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C093B4EB4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436256; cv=none; b=QNK4rC8YsffLBfD2eFJRENxgjnAssjUNeDXUwpkPhCsJ1ffXibEYHZndj95kzG/iNqhhFXf9VaFji1bwJFXFJk/rW+hnnBw9rWDs4xdKEd3Mt8Pj07VnqeJJTu47prlvLCzLpRg3gmDGcUZwy3n5KttTNBIWxdQ3cCA8PPYmpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436256; c=relaxed/simple;
	bh=dn8nQ7nm30f+gBTd73TRwy9R3dZ3uywk8nXW1p6EkWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JktteAb1Hwi8n2Iz8y25XyNpzMKt7VOJJOa9fVy6+raLHrCWHDcgGvGpOIplnXC1iRlL1wKLueTNwF5udp2qDTMXg3s50NXqssmvCnicW2enwL6s1vsoEqFnylQTEVuYRKRTb8mywvxQcRElGaCyAjCeQf/A+OvXSaGcLteboWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fe7zsIcB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fe7zsIcB"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HEEw3G3412536;
	Fri, 17 Apr 2026 14:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=+l2O7FfdrWOtcQlw8aRdABJDPqu7q
	SGoH9Cn3YpyAEQ=; b=fe7zsIcB75K69Lle481o6hZBYl6nfrdTeR2f7YBlryTVx
	rOIkBobgF+RXjR1WAtTs0xL01EJTzFnZ05Dxx8tlGVsFa2GIxVYAJqdCwNA6+tBR
	2Cdewn551PluNgg+RWW83kM1xqMWAtoJ8HsR4v2D2jNz9vH/3L6lzgYHDi7bhl4g
	uQyiKUslQXJRwO87xRxHeV8qcDBp72LAI1/Y0zYO4c3+CjPCD3+F2uhdYauz0NKw
	XAqHtrCwFt48JLAC+mEYzR++J1VT7F5ufDYfvOUBh7eTYTV0rf0T9FtGgXTZwuXB
	EbcLz++0cnSR515QrC8XJPqz31sGvNYkiXBx2MBGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh87mj04s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63HETQLX027263;
	Fri, 17 Apr 2026 14:30:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nrw8j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 14:30:28 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63HEUSst033610;
	Fri, 17 Apr 2026 14:30:28 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-148.vpn.oracle.com [10.154.53.148])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nrw8f6-1;
	Fri, 17 Apr 2026 14:30:28 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
        mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/6] bpf: Extend BTF UAPI vlen, kinds to use unused bits
Date: Fri, 17 Apr 2026 15:30:17 +0100
Message-ID: <20260417143023.1551481-1-alan.maguire@oracle.com>
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
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604070000
 definitions=main-2604170146
X-Authority-Analysis: v=2.4 cv=JKYLdcKb c=1 sm=1 tr=0 ts=69e24406 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-XFqwly0Y5zvRpRwvA8A:9 cc=ntf awl=host:13825
X-Proofpoint-ORIG-GUID: hmoF3LPCBZIzLVBXD5NuYH6fp4c6ZlmT
X-Proofpoint-GUID: hmoF3LPCBZIzLVBXD5NuYH6fp4c6ZlmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NSBTYWx0ZWRfXwLnQ+XAq7lNe
 9fLkeLyVoHcFK3mA1Vd3Qx0hkBbbJuO1hKRt+3/Yj+FGPWpKV8fxiQ9qN6pMU6HXyT/zmV3wBMW
 7PhP78ZsymmPFRjT9mepA62o9AE/lnypdafoIYT3sxHyFJ+0ms4aTXAVn1p/4ZjE9Li8IPJ6WAg
 stA7xSGUO4j5fHc8bAf4TfHa9EKjRELcZ5AF5R+frfJCdSD7pVf2siik9SHJaPODUM/eK+hA9o6
 X4QTm3kitXTE0KMAmorBChNTwRAXesv+deOFstfZmVYO80ZzocW4DU6xR73AlK6zci0heGkUKlP
 8WFqRbYlamy4P+wPtm4vEkNjm1Qk4C5VMnr2RmQvn+iVfVEkF5TW9gYaOaeMr1H+0HAqKVIwF8Q
 fSYQsIwapiwEfXIHAL2cZLCJ3I8DeBP9tyNcptCYjHZcO+nbd7Tf2LtlC8jx29/o7Jm6kkY2dOa
 f+4DdrIlM8OTIGTWJDdFdrWf4FRMGrgKKMLYjsN8=

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
currently we use 20 kinds, but BTF location information will
take another 3, and conceivably providing better support for Rust
types in BTF (now that modules can be built using Rust) could
push us close to the max of 31.  Use 2 unused bits to provide
a max possible kind of 127.

Patch 1 handles UAPI and kernel-related changes.

Patch 2 updates libbpf to have btf_vlen() return a __u32 instead
of __u16 and updates consumers in libbpf accordingly.  Also adds
bounds checking for max vlen.

Patch 3 cleans up __u16 vlen usage in bpftool.

Patch 4 fixes up a test that relies on BTF info overflowing
maximum kind value; fix up the expected error to be an
invalid kind rather than (now impossible) invalid btf_info.

Patch 5 fixes up __u16 vlen usage in selftests/bpf.

Patch 6 syncs BTF documentation with UAPI changes.

Changes since v2 [1]:

- dropped backwards-compatibility macros (Alexei, patch 1)
- added additional vlen bounds check in btf__add_field()
  (sashiko, bpf bot, patch 2)
- dropped sanitization check in libbpf as older kernels will
  reject BTF with extended vlen/kinds using BTF info mask
  (Alexei)
- fix more vlen assumptions in prog_test/ctx_rewrite.c
  (sashiko, patch 5)

Changes since v1 [2]:

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

[1] https://lore.kernel.org/bpf/20260416143904.1220662-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20260414195019.684531-1-alan.maguire@oracle.com/

Alan Maguire (6):
  bpf: Extend BTF UAPI vlen, kinds to use unused bits
  libbpf: Adjust btf_vlen() to return a __u32
  bpftool: Support 24-bit vlen
  selftests/bpf: Fix up btf/invalid test for extended kind
  selftests/bpf: Fix up __u16 vlen assumptions
  Documentation/bpf: Update btf doc with updated vlen, kind sizes

 Documentation/bpf/btf.rst                     |  6 +--
 include/linux/btf.h                           |  4 +-
 include/uapi/linux/btf.h                      | 26 +++++-----
 kernel/bpf/btf.c                              | 27 ++++------
 tools/bpf/bpftool/btf.c                       | 17 +++----
 tools/bpf/bpftool/btf_dumper.c                |  4 +-
 tools/bpf/bpftool/gen.c                       | 16 +++---
 tools/include/uapi/linux/btf.h                | 26 +++++-----
 tools/lib/bpf/btf.c                           | 50 ++++++++++++-------
 tools/lib/bpf/btf.h                           |  2 +-
 tools/lib/bpf/btf_dump.c                      | 24 ++++-----
 tools/lib/bpf/relo_core.c                     | 16 +++---
 tools/testing/selftests/bpf/prog_tests/btf.c  |  8 +--
 .../bpf/prog_tests/btf_dedup_split.c          |  3 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  3 +-
 tools/testing/selftests/bpf/test_progs.c      |  2 +-
 16 files changed, 119 insertions(+), 115 deletions(-)

-- 
2.39.3

