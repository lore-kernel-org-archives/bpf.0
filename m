Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA2445ACE
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544558; cv=none; b=IR9dbdcaMc5SIGxmM/wHKH8Y2VIZMQA7xpKOpQCvj16XRIyIlBWQlCtKu08rJKDtU/LAymB00R1pTZgURT6L32rSZ2PTlFnkFretIJwBgnuK4ac/k3nLxwombbmbxr6rNccR0R+ieql6iCMpMy/GjhqvWgBUv/rr/LJDbpRXPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544558; c=relaxed/simple;
	bh=cDgvQlANIsmFon3JCITw3brd1rx6GuZNw9Lzji6emEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdmirKxZuPqbIet77zGyJPYrCEoxQuNmdW9fZhS4zuTPjHADKtogj8j+82Acm5HV6p/mejIbp4Z87HhIn3l4TeW4eoQnfAVHX7+dbn2icqZP8/0eaYrWBfD55UuyWzfLYhXKQGPuEIwsKrBHAag43Y8qPqbtTJE2IfJdMMOjdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d5un39Rf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d5un39Rf"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLWVnt554469;
	Wed, 16 Sep 2026 07:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/ah6z
	u+jWEpgbLtL8+9RUjrih3FHovsjdTWotEcQwh4=; b=d5un39Rf6DOEE4NIFIssH
	VeqLHGUXencO2RdBqakKY7d6p1eFzQSW7MxiG/okUM9hVehd+R0uAOC09DgisCDb
	0FQEz9uplD9NHymC3cqnjYKHAu0vzraGywigHvcGtsQxGtiXWCkPwEh0GW/yWaFe
	EcatLTv0V/lz7kEED0VKctzCHIbIphmdZXfjWg+NPqRaLb3JsEOoyWs81C0pIFDU
	npRmPP9WBK3UgMeBxOKjew5y+oX/0OtJi6WIy2SXaVcS8kkH9IZDxaDwoet1l8vN
	Sf+UEYD9ehpQoKxgzacJPOJnwvUai/djnYF7B4IVtHom02OjhtqrgUJC2Vwzn78N
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmw5b53xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:42:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e2HD014739;
	Wed, 16 Sep 2026 07:42:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au594-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:42:04 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exQ3020284;
	Wed, 16 Sep 2026 07:42:03 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-12;
	Wed, 16 Sep 2026 07:42:03 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 11/11] Documentation/bpf: Describe new location-related BTF kinds
Date: Wed, 16 Sep 2026 08:41:18 +0100
Message-ID: <20260916074118.1007116-12-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260916074118.1007116-1-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-ORIG-GUID: kjFau2-7A-FepPphoF_ABesLQk97YLpT
X-Authority-Analysis: v=2.4 cv=Ev9HPicA c=1 sm=1 tr=0 ts=6aaa484d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=ftV6jY_2pGarI4CLVJwA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OSBTYWx0ZWRfX7Bq/44HhICWf
 yOYsyPLK4hF/mtCGfJFogw6Q1F2shNWRWQEta5mvWEz57SxdC6X2DIdryJW+1XCU+Jdxp7/qVOM
 3f97fdFe1BShSxFhE+D62WpfnNGSthMVJSOh4mt2jr2XjjHj0sM6
X-Proofpoint-GUID: kjFau2-7A-FepPphoF_ABesLQk97YLpT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OSBTYWx0ZWRfX8iToAMvty5j3
 eJ/hx52WbeZnJ/gC6IgHf+ZJEGWOQfLPwArd4nIUA6HsmMQBcVc7E2EDVL0vwPjKbRn/K2k46Zq
 AFtGK5dd+xU2NDqmj8uGmaHCLqDcUuN7GODmvJEceM7+icuELp2ZU72ezu8OSGf3wlIpLWm4y+b
 uTF85aDUGYQzDnjro0EcVEyazWQt2EZwt8keMf05NpENAf59tVAdWZbP04+N2RWyta1vwi4NVkI
 9rwhuXbgeYwfyLoq/9NvD6x0OjZwy2xnJEdsFYYVC6PgpTYxinMNghHb0JuZ2MaVInxAJzsaxuz
 72IbVVMtPNftcmlUDbC9B/yqtp3uIbjXQ26vTzfb7vajor14NuPLHcGofx22hoer9uGlz8azoD9
 nIgph717HhufhxaE6KIlkz8q/V3xCe4+NOs2Gnw5wxeBJgSP93IIT0QizjJXe8LVGNk4BvdDpsm
 r1hH//9tecTdFo0bGUA==

Update BTF specification to describe encoding schemes for
BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 Documentation/bpf/btf.rst | 80 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 004aa1058d85..70ab6ad608ae 100644
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
@@ -563,6 +568,77 @@ The ``btf_enum64`` encoding:
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
+  * ``size``: size in bytes of the represented parameter: 1, 2, 4, 8 or 16
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
+  * ``BTF_LOC_PARAM_ADDR | BTF_LOC_PARAM_CONST`` describes an address to be
+    normalized relative to the kernel or module base address.
+  * ``BTF_LOC_PARAM_REG`` with one word describes a register number; with two
+    words it describes a multi-register parameter.
+  * ``BTF_LOC_PARAM_REG | BTF_LOC_PARAM_OFFSET`` describes an address held in
+    a register plus an offset. Adding ``BTF_LOC_PARAM_DEREF`` dereferences
+    that address. ``BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF`` with one word
+    dereferences the value held in the register.
+  * ``BTF_LOC_PARAM_SIGNED`` makes a constant or offset signed.
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
+the kernel or module base address. A LOCSEC named ``inline.text``, for example,
+contains inline-site records for the ``.text`` section.
+
 2.3 Constant Values
 -------------------
 
-- 
2.43.5

