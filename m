Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0043B6CB;
	Tue,  1 Sep 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281957; cv=none; b=X5wzAEjvtlW0rPiLG4tHIkhfuaIp3BS/2KvguHwknZ+fBCIpzioGPWWf70DUOaS599lvjgwdcNCXAm8n/Lj3Sg6CYXizHSns2UsFwI+zfayp2rDLqyap0478P6Laceltue1+LexcNne8PtNlyQoctDSmLE5VIaxySS8yywo7DUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281957; c=relaxed/simple;
	bh=bi5CEZ/srn4dKkLlT5XXr0PT62CKZDZjEtxtBz7wUJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAy9GHEUmt9uvKspU0P5JJVw3vKhn1Y/KTI2RvM1JuuvQo1FpT5qNsvL/Ypt49FLlBJlozloyJklgOkUWZjwzFREjO8C7lvHJ6ujKtaN80u7Sao3RiOlQpmGnXSoRvQGgVEgnlp/eqXR+SA19EmUdW9aHpO9qpW6ssLxuvxSnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bD8gUoDL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bD8gUoDL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681ESKON4036407;
	Tue, 1 Sep 2026 16:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5SRYY
	Db+l6SiJ9V8FQflN8aqjJrf+dZt0yGl1mXPBp4=; b=bD8gUoDLzI42xgYFHI0/C
	kL4JyMm57lwgAsBmik6UNiB3+hoLVElGp8gi4x/kPXds4o2WZmRMkbx+o3IrilQo
	ehlLqqsE4MuSW1KMmA/oXvTWGq8ArQEKkLPAFCYJK/hBXkbGmmxJoRWZnbaSKWv+
	wcTsWouBBxfHLbfPrTsSYGpdyqqXas6oqQzo5HLwtGJz64NlpyvPEY3QcgU2q4wG
	89MaLBQnnyYA05aUKg9RG4Ap2pZrgnswMalWrFfkWk3tessRk5vp/6uksRdleLIl
	WwJwT7baMAUE1+Dc2UXnZV7XUDLNv7ssTi2oZXze9SiqQKrHWamvtm/hva2fCDU/
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xw56t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjWHa001976;
	Tue, 1 Sep 2026 16:58:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg95t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:49 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WH011129;
	Tue, 1 Sep 2026 16:58:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-14;
	Tue, 01 Sep 2026 16:58:48 +0000 (GMT)
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
Subject: [PATCH v2 bpf-next 13/18] kbuild: Add support for BTF inline information
Date: Tue,  1 Sep 2026 17:57:52 +0100
Message-ID: <20260901165757.801449-14-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: Q7MtCM_fztBGDtMKnQWl_hO1IsofzXVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX5szUimNUTtPQ
 ljpbnL41mZZSp3QDIYOvWlB540YxWyQ0tylzMRQ2u5L2J9G/WSZKCSiOwMdPwk4uo3NqVxSj6Rm
 Bvkx1u/nn4EKCFAeftOej6UcGVFgZqSnJ3wo8MF/cOKHKWlTZZer0xoPHDD2oxEn8D7luVf8CHo
 GHdo0UHJpXZpPRqHFim7/fw/CXPhtyHABMkzrjtZerMBOlzz7MXn/8cBSwj/NbuD+Lg+77S0N2Q
 hrybqtEH+Zff3MSbEJZn4qg7s0YF6ic6wdNQkjPnNlYvDmalXRaC902fq4qqbOWDIuO89bd2nwx
 fzWWGwNAytv9OakkDj3g9DZBQfleRfFoXC9bC4/ItpoiZtZ7MvMuWpMJ0wYOTlZXacF/gJBM5+A
 wslNbGrEfozUiHvDMT3eBLCIBO8Vdk7fxf78wCPRMtnOsk9gaT5c7Ods67Acq+Z/DM1peJKbvUK
 VTtgCLDpEVhnYGNEF17mOvG2NASiZ2znDS24a96I=
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a97044a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=NUpgqu5b-PR-DmDCbUEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: Q7MtCM_fztBGDtMKnQWl_hO1IsofzXVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXxp+NK1+4hEpp
 h6Vv5WEgYFiml9+en8vSQkFmH8HOMUaCvmGrItw0gkpSKsgDZf7yBDkbQe3tBMsjwwuRJnmOp0U
 yijCrbB5sjXJRQfyYDFhGgVHdo1L6Ks73ifx4HctcxxjaeJbZm5k

Add CONFIG_DEBUG_INFO_BTF_INLINE to generate BTF inline-location
information with pahole v1.31 and later.

Enable pahole's inline feature and pass --inline to resolve_btfids.
This extracts LOC_PARAM, LOC_PROTO, and LOCSEC types into a split BTF
blob named <output>.BTF.inline while the ordinary BTF remains in .BTF.

Embed the resulting blob in a .BTF.inline ELF section for vmlinux and
modules.  Add the vmlinux linker-script output section to avoid it
being treated as an orphan.

Use the inline pahole feature unconditionally for both in-tree and
external modules; the generated split BTF has the same format in both
cases.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 lib/Kconfig.debug                 | 17 +++++++++++++++++
 scripts/Makefile.btf              |  7 +++++++
 scripts/gen-btf.sh                | 17 +++++++++++++++--
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..a2e192854c47 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -675,12 +675,23 @@
 /*
  * .BTF
  */
+#ifdef CONFIG_DEBUG_INFO_BTF_INLINE
+#define BTF_INLINE							\
+	. = ALIGN(PAGE_SIZE);						\
+	.BTF.inline : AT(ADDR(.BTF.inline) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_BY(.BTF.inline, _BTF_inline)		\
+	}
+#else
+#define BTF_INLINE
+#endif
+
 #ifdef CONFIG_DEBUG_INFO_BTF
 #define BTF								\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
 		BOUNDED_SECTION_BY(.BTF, _BTF)				\
 	}								\
+	BTF_INLINE							\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF_ids : AT(ADDR(.BTF_ids) - LOAD_OFFSET) {			\
 		*(.BTF_ids)						\
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..dd1b2d9ebe99 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -425,6 +425,12 @@ config PAHOLE_HAS_LANG_EXCLUDE
 	  otherwise it would emit malformed kernel and module binaries when
 	  using DEBUG_INFO_BTF_MODULES.
 
+config PAHOLE_HAS_INLINE
+	def_bool PAHOLE_VERSION >= 131
+	help
+	  Support for the "inline" BTF feature is available. It encodes
+	  information about inline sites and how to retrieve their parameters.
+
 config DEBUG_INFO_BTF_MODULES
 	bool "Generate BTF type information for kernel modules"
 	default y
@@ -432,6 +438,17 @@ config DEBUG_INFO_BTF_MODULES
 	help
 	  Generate compact split BTF type information for kernel modules.
 
+config DEBUG_INFO_BTF_INLINE
+	bool "Provide information about inline sites in BTF"
+	default n
+	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS
+	help
+	  Generate information about inline sites in .BTF.inline sections.
+	  These sections contain split BTF relative to the kernel or module BTF
+	  and are made available in /sys/kernel/btf with a ".inline" suffix.
+	  The information describes inline locations and how to retrieve their
+	  associated parameters.
+
 config MODULE_ALLOW_BTF_MISMATCH
 	bool "Allow loading modules with non-matching BTF type info"
 	depends on DEBUG_INFO_BTF_MODULES
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index a1812985a61a..d42dbc8d7199 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -22,7 +22,14 @@ endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
+btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
+ifneq ($(btf-inline),)
+btf-inline-feat := inline
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=$(btf-inline-feat)
+endif
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
+export BTF_INLINE := $(btf-inline)
 
 resolve-btfids-flags-y :=
 resolve-btfids-flags-$(CONFIG_WERROR) += --fatal_warnings
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 8ca96eb10a69..a75f41878c32 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -76,6 +76,7 @@ gen_btf_data()
 
 	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_FLAGS}	\
 		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
+		${BTF_INLINE:+--inline}		\
 		--btf ${btf1} "${ELF_FILE}"
 }
 
@@ -83,14 +84,21 @@ gen_btf_o()
 {
 	btf_data=${ELF_FILE}.btf.o
 
-	# Create ${btf_data} which contains just .BTF section but no symbols. Add
+	# Create ${btf_data} which contains just BTF sections but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script.
 	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
 	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
 		--set-section-flags .BTF=alloc,readonly ${btf_data}
-	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
+	ONLY_SEC="--only-section=.BTF"
+	btf_inline=${ELF_FILE}.BTF.inline
+	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
+		${OBJCOPY} --add-section .BTF.inline=${btf_inline} \
+			--set-section-flags .BTF.inline=alloc,readonly ${btf_data}
+		ONLY_SEC="${ONLY_SEC} --only-section=.BTF.inline"
+	fi
+	${OBJCOPY} ${ONLY_SEC} --strip-all ${btf_data}
 
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
 	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
@@ -111,6 +119,10 @@ embed_btf_data()
 	if [ -f "${btf_base}" ]; then
 		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
 	fi
+	btf_inline=${ELF_FILE}.BTF.inline
+	if [ -n "${BTF_INLINE}" ] && [ -f "${btf_inline}" ]; then
+		${OBJCOPY} --add-section .BTF.inline=${btf_inline} ${ELF_FILE}
+	fi
 	btf_ids="${ELF_FILE}.BTF_ids"
 	if [ -f "${btf_ids}" ]; then
 		${RESOLVE_BTFIDS} --patch_btfids ${btf_ids} ${ELF_FILE}
@@ -121,6 +133,7 @@ cleanup()
 {
 	rm -f "${ELF_FILE}.BTF.1"
 	rm -f "${ELF_FILE}.BTF"
+	rm -f "${ELF_FILE}.BTF.inline"
 	if [ "${BTFGEN_MODE}" = "module" ]; then
 		rm -f "${ELF_FILE}.BTF.base"
 		rm -f "${ELF_FILE}.BTF_ids"
-- 
2.43.5

