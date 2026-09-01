Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF634489861;
	Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281946; cv=none; b=XDKYAJb2MJ2TRxiuxivA0T2YmbJxrIzcJUNqbUtnS/oqTeBRPYlMDuzz8WMwuld/fkpS2/S1Sjm9Kf8AecRbeAKC48oQmCVN9SpiTmu2S6lY7bMx25B94BQ5BQiky45BIV9XHUVt8TuzocojVMRoYUPd9Pm/JlHdgBkciGibqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281946; c=relaxed/simple;
	bh=TSMxYIGOu211X9IBnh3C4TTNy0qfjYukc9e+p/jZoMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6AA30JUnbIV5q6W2ed6y+WMqw3HbH/wL2RhYLuo4uYDyfsoc2k3Eoa4CLyITpzC9MTXkkAaEPYLyluxbyApYNrdN29ggW/Y1JJKvJolCIUAM/7lXU0eyprozNZKzr/Wml9B2J6H+9+/NEnGJI4m2vThVb7tHrVi0nd/fCKjArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DdpgXEnh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DdpgXEnh"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQZZt3963481;
	Tue, 1 Sep 2026 16:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kMlHp
	wgWgq0Ykve9d9wdVb1jleZsoT8XUptlbtk5ecQ=; b=DdpgXEnhmEL3gRI+4yA2U
	iWKD2Jx+YxGn38mDmb2peOddzvl32QkOMaf69ujduvFcoFgLmcCxz553wBXLa44T
	51Mn70V+KKyuDulac8lEeo4osxXSX/mqq/z4j6AvQOk9VmwCOYWRgDnt+NGOMxW9
	MoyChLqsK3F65vxtLiwt33G58RtUZ6hMCZuRJXaW3djT6VOzRUQ3evTK1cZRnlcT
	N/IPoVk1vnB50TzCouWfRhGoAlGzlOnUiFKSa8Fh1J2hZdFItx8J7aX5UK9MHB/p
	RJ1jJy9JwlFdsiKy6DVjSbTbn+shxUUaWmhszq3OnaJxOzZDdtLlqABV6IuT0nGP
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrw3tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjVYM001920;
	Tue, 1 Sep 2026 16:58:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg90t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:38 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WB011129;
	Tue, 1 Sep 2026 16:58:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-11;
	Tue, 01 Sep 2026 16:58:37 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 10/18] bpftool: Document support for multi-split BTF
Date: Tue,  1 Sep 2026 17:57:49 +0100
Message-ID: <20260901165757.801449-11-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX3ZEOC7BqbcqR
 JD4xE1WasChI1c4bXh0dzuV8FkJtXUQN8Pf+joqNOSgis2tTgJZbW8g2k0/rpRzLdEKx0cyjS3T
 yIahI85/71H2SAjSkWsHSjdGayLgUqdoxsN1vJVaxZEIGfAn/e/egThVDSYPhP6wpOP/onJH7ij
 9M7H6/pNbVOUOs39nCwY/ISugQHlkAsJYYV9kCX3j2wEr78IjOoK8ORFMRJSi9A1w5N7L1Ph/FM
 6bsL2bT/7QXHJ6Ui8fekbTETPq3y1CGZyvC1fjPhO3bDmhnZyhj2aHrJMvodqV3CrIqpMpU2JNv
 6BU7Lm7q/sIxHpCVjaD6IpKFNfnmWBmOWOV77psDdCs6JyoXkxrGGJGtr0FTA4P4qBUcUJLb/7x
 NYYgIx6fesDs7m0IffH88McTIh5Y2MoC2LUbBFWS2kR6eoX4PlhJAGYYdjH0mVguedOEu5jkOtB
 GqkcWdlsOusLEt9kYIjrXFeESDgI6SJVXTxGx0Sg=
X-Proofpoint-ORIG-GUID: ISqxgf5CbrY1g5xXKOPcWBNPcjnF9E2r
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a97043f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=R5OYlE61gfEZyGkII2oA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: ISqxgf5CbrY1g5xXKOPcWBNPcjnF9E2r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX/fzKuG7akJj4
 xuOhapcXfNGJhSHL1UFHpr1Lt0zZgfsa5OxtlpGFQrIUKYOayOnL4RcfaX7g2dfa4soxzwe4Z7y
 eDp09zw1Q3vAzRDSg/sEZtIbpZ/CbJopdMJpNSwOu0QIxMdoGzrv

Document the ability to pass multiple levels of split BTF, using
"-B base_btf" options.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/Documentation/bpftool-btf.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
index cf75a7fa2d6b..60c46748b866 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 
 **bpftool** [*OPTIONS*] **btf** *COMMAND*
 
-*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
+*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** [ **-B** | **--base-btf** ] } }
 
 *COMMANDS* := { **dump** | **help** }
 
@@ -87,7 +87,10 @@ OPTIONS
     objects for kernel modules. To avoid duplicating all kernel symbols
     required by modules, BTF objects for modules are "split", they are
     built incrementally on top of the kernel (vmlinux) BTF object. So the
-    base BTF reference should usually point to the kernel BTF.
+    base BTF reference should usually point to the kernel BTF.  Multiple
+    base BTF objects can be passed, where the first is assumed to be the
+    root BTF, followed by split BTF based upon it, followed by split
+    BTF based upon the first split BTF and so on.
 
     When the main BTF object to process (for example, the module BTF to
     dump) is passed as a *FILE*, bpftool attempts to autodetect the path
-- 
2.43.5

