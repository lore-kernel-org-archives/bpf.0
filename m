Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D63AD50F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248542; cv=none; b=BdRmJqIphGboDhHzgFaE2im1/M5Htw6GeFzJ7k0ATaVUm3aLPlfPwYf2vNO7UDzhG7X04KpehMarAI4J+i+kpENa7bdhp92D1d6t9UVsre2keaHgLSLt7BcqZh5elZddx3REOtSdEK7aBQrk7gpT7NRz9Oa7Aa1aAZEfy/HVuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248542; c=relaxed/simple;
	bh=0jM5guvuEaIv/Ao4DriO+wIor7j+q+L8gc2OEYUV/LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMhCOuAmc4y/QceKT03Yo3jL6xWXivEsjJegPpgl7wXZ1GxaZm7SMWYjWUpnfm4RPIuUCtC+E59U3GM9qud106oyMNJQngdpL8WNLko+T3dXnkqHcNlqbs0bLZ84d6+x//S9kLXcA0pjnwQbfsWQbwkl7fEa7hC5FuriWG1Q0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QpR6fhnR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QpR6fhnR"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6Dbo53901246;
	Thu, 24 Sep 2026 11:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=RJRsf
	/2o5SC1+zanyjjkIxTSh/P2UVPVnUtRAJnSOEA=; b=QpR6fhnRMFzjEkR0AXt2y
	to1heIN0pXfK/pP5A15peFX3dlVd/kVvDqSsrJYfUqwmKAn9vfwQitWfirXPncsZ
	bEaV1Jm3A6Z2AUM4JrQg79KGH8lpoji8fLoVoHY/ZGsGKZZbmlzTlYNiXafEECxE
	gNcHl412660T1T1TuDO8xZzxzArv15/iRQFoVEu2ou0M7kUxmRSRHYwoFQjb30qI
	JA6oHErH1q+CYadC9fiA2l2vm3ernNpJAKewaIit+MEBE9x7h9oQGgb+5Vp62GPH
	dDj5LLVlmnTKlqQx8yrazRZPs0baotvRr986WPVR/RvmcU1rwK8nYDrwD2ItCT9/
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk217aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5W18013049;
	Thu, 24 Sep 2026 11:15:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119mqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:15:11 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVuR002821;
	Thu, 24 Sep 2026 11:15:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-12;
	Thu, 24 Sep 2026 11:15:10 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 11/11] Documentation/bpf: Describe new location-related BTF kinds
Date: Thu, 24 Sep 2026 12:14:28 +0100
Message-ID: <20260924111428.75957-12-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260924111428.75957-1-alan.maguire@oracle.com>
References: <20260924111428.75957-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab50641 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=73AEzqow_fZ0RHA0zHsA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX4nGCso7uY7BI
 6nQSIMfYdotAWhi2ChzCaUIObZXseUi3IqCTxCCGJJFQc46kLlo8jU4suy395NQ8bO6kZYFbsPq
 BsEdlwp0f96OQ9FuvGaXSjvBXdzG3OIaUmUr+iRd63jn4zDBGRry
X-Proofpoint-ORIG-GUID: znLtZGUlDCrqM-p5HMaxGaLjfEFxEFiU
X-Proofpoint-GUID: znLtZGUlDCrqM-p5HMaxGaLjfEFxEFiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfXzzCi9jZIiMBX
 qsJChpcDPREE3R8KM3ybrgqSsyq7JT0uOvn/4+9/hi5MEUlaqMNSrw9El5xoxcw/gpIqQmd6w9Y
 7ooOgiSAtLi9B/gEHw3xe3/rCjUS28HlkYwfMMMHu9IXFbVv85sCbKsWzvzct2IjXIxoDDTKvzj
 zVPg/q/qOy7tkppduD04mRqMQadvHVL5M6gbACtYuDZa0wShlycnkHYByL4prV8xo3EwoX9ua1d
 ajZAC2hBeJgBaTbdEV0AKIIQ+nQZ6KDmMhpLN47fiB6KjWbJZ8CSBNtT6z/vBKAC19nzlABgp+X
 5E8rct4fTxvMWBPst8laALXrli7E77Uf9iGtJdbWDCFOeL0pNCBouXk0z0M9q3bd6PbM6wKH8hk
 YJwSPkbQHduOJS3i1Ghwar3+p08kZBFl/hN6R5fHr/sR5N40HNeE4+Tkfcsz8n1vvdhsucrmSvQ
 095fYp3Wqb+r8N5bK6w4CbasyaFzGsdjqOku7zEs=

Update BTF specification to describe encoding schemes for
BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/bpf/btf.rst | 83 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 004aa1058d85..29de1222c3e7 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -88,6 +88,9 @@ sequentially and type id is assigned to each recognized type starting from id
     #define BTF_KIND_DECL_TAG       17      /* Decl Tag     */
     #define BTF_KIND_TYPE_TAG       18      /* Type Tag     */
     #define BTF_KIND_ENUM64         19      /* Enumeration up to 64-bit values */
+    #define BTF_KIND_LOC_PARAM      20      /* Location description (register, const etc) */
+    #define BTF_KIND_LOC_PROTO      21      /* Set of location parameters for site */
+    #define BTF_KIND_LOCSEC         22      /* Section with site descriptions */
 
 Note that the type section encodes debug info, not just pure types.
 ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
@@ -104,11 +107,13 @@ Each type contains the following common data::
          *             decl_tag and type_tag
          */
         __u32 info;
-        /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
+        /* "size" is used by INT, ENUM, STRUCT, UNION, ENUM64 and
+         * LOC_PARAM.
          * "size" tells the size of the type it is describing.
          *
          * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
-         * FUNC, FUNC_PROTO, DECL_TAG and TYPE_TAG.
+         * FUNC, FUNC_PROTO, DECL_TAG and TYPE_TAG. It is unused by
+         * LOC_PROTO and LOCSEC.
          * "type" is a type_id referring to another type.
          */
         union {
@@ -563,6 +568,80 @@ The ``btf_enum64`` encoding:
 If the original enum value is signed and the size is less than 8,
 that value will be sign extended into 8 bytes.
 
+2.2.20 BTF_KIND_LOC_PARAM
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+  * ``name_off``: 0
+  * ``info.kind_flag``: 0
+  * ``info.kind``: BTF_KIND_LOC_PARAM
+  * ``info.vlen``: number of 32-bit location value words
+  * ``size``: size in bytes of the represented parameter: 1 through 16
+
+``btf_type`` is followed by a ``struct btf_loc_param`` and ``info.vlen``
+number of 32-bit value words.::
+
+    struct btf_loc_param {
+        __u32 flags;
+        __u32 values[];
+    };
+
+The ``flags`` field describes how to interpret ``values``:
+
+  * ``BTF_LOC_PARAM_CONST`` describes a constant; the value is stored in
+    low-word, high-word order when it requires 64 bits.
+  * ``BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_CONST`` describes an address offset
+    relative to the runtime base address of the kernel or module image.
+  * ``BTF_LOC_PARAM_REG`` with one word describes a register number; with two
+    words it describes a multi-register parameter.
+  * ``BTF_LOC_PARAM_REG | BTF_LOC_PARAM_OFFSET`` describes an address held in
+    a register plus an offset. Adding ``BTF_LOC_PARAM_DEREF`` dereferences
+    that address. ``BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF`` with one word
+    dereferences the value held in the register.
+  * ``BTF_LOC_PARAM_SIGNED`` makes a constant or offset signed. A constant's
+    signed width is ``size``. For a register-relative offset, its signed
+    width is the number of offset value words times 32 bits.
+
+2.2.21 BTF_KIND_LOC_PROTO
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+  * ``name_off``: 0
+  * ``info.kind_flag``: 0
+  * ``info.kind``: BTF_KIND_LOC_PROTO
+  * ``info.vlen``: number of function parameter locations
+  * ``type``: 0
+
+``btf_type`` is followed by ``info.vlen`` number of ``__u32`` BTF type IDs.
+Each entry corresponds to a function parameter at an inline site. An entry is
+either 0, meaning that no location information is available, or the type ID
+of a ``BTF_KIND_LOC_PARAM``.
+
+2.2.22 BTF_KIND_LOCSEC
+~~~~~~~~~~~~~~~~~~~~~~
+
+``struct btf_type`` encoding requirement:
+  * ``name_off``: offset to a valid ELF section name
+  * ``info.kind_flag``: 0
+  * ``info.kind``: BTF_KIND_LOCSEC
+  * ``info.vlen``: number of inline sites in the section
+  * ``type``: 0
+
+``btf_type`` is followed by ``info.vlen`` number of ``struct btf_loc``.::
+
+    struct btf_loc {
+        __u32 func;
+        __u32 loc_proto;
+        __u32 offset;
+    };
+
+The ``func`` field is the non-zero type ID of the ``BTF_KIND_FUNC`` being
+described. ``loc_proto`` is the non-zero type ID of the associated
+``BTF_KIND_LOC_PROTO``. ``offset`` is the location address offset relative to
+the runtime base address of the ELF section associated with the LOCSEC.
+For example, a LOCSEC named ``inline.text`` contains records for ``.text``
+whose offsets are relative to the runtime base of that section.
+
 2.3 Constant Values
 -------------------
 
-- 
2.43.5

