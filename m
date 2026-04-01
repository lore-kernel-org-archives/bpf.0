Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3F390C81;
	Wed,  1 Apr 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038313; cv=none; b=pWl+8OEdyL8oww8ZFv8iV2C0foh/OgKMagr9Az1lOK46q2MODktOTnOJzhqXPGnpUorSjZuIRPJ2MU5oZqOrIU4vHQFQiG5jinzzcsSqZCC+G/5rWES6UJ4OhoMt0jWpEkbxkfR2fk+RIGS3xtZ1dbMTPaJ1PZ34UmvRQedtJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038313; c=relaxed/simple;
	bh=QoNHwq0EQ8cn8fL+vLm0RdDjqbQR3SmipezZ17mZ9Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAvLG8PQ3NXXUBMcejwiKkFcKv6DUpQrVJ1RVwgrV7VwIApEHKKQtPhY3Hd9SdiEwlQ4UugZX7BMOs7tcKHw/RV+puAL/B3tEoh1N1LqBJwKF8XQBjTgPCsJRd7cQAH6hLd/Wq25KNcPspkLxpbuJohBmXvMnl1VUF2l5SVi03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+axV1XT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+axV1XT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63199kHn3622719;
	Wed, 1 Apr 2026 10:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CGX2BxravPhjNaKGi
	BnooGVgZkanfY7myAbh6oOEX7c=; b=L+axV1XTOhvisjXF1RJUQLvT/45v9OPqT
	2lmjCOU+ZLLK4nBgcsfIdm+fDPLYHyqzRVN00QvsdcwWH03U5aW+Eg2c7Vj9WYf8
	rIh/vmeda+TADAIBA4gEVL2TIhpIcKMY0UzlVvnUG9hwNj/ZRaRUexQnZksYMvWf
	SERDAPlils+PnSbRl+hU/RSADAaki4eqzIcEOQtaB3wo7hh9qxSOZ7Ec6Qc+Ax/5
	oacdZ3eLuFoBHZ+B72DVOghBM5c2tsaZqd3C8fJKeJCv572ccqEOKeF9G8R3omYH
	12Gdk5RHvydFIU5SCnuD5wmE8pp6R3ZbdJZEBXTLa6nCJV7WvSn/Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgq1ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:11:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6317QFx5013898;
	Wed, 1 Apr 2026 10:11:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkmyrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 10:11:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631ABSsY17105322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 10:11:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A942E2004D;
	Wed,  1 Apr 2026 10:11:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C33142004E;
	Wed,  1 Apr 2026 10:11:26 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 10:11:26 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 2/2] powerpc32/bpf: Add fsession support
Date: Wed,  1 Apr 2026 10:10:43 -0400
Message-ID: <20260401141043.41513-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401141043.41513-1-adubey@linux.ibm.com>
References: <20260401141043.41513-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA4OSBTYWx0ZWRfXwmv2NinnLIS4
 5xgR9JLv3ty7l7Me4MlNvw5IxzykXtiIKbflMMJ3AF2fam6tExWd8hRyxjB4VcN+SJWV6Uxu69k
 4+B/0Nck0f+NAvNkV/WKj9NQqqEOg87Y1r2UIZc70g28qwm1k4WcFP01qDmomk4vP3aAVpLgRuK
 j0b3XFWwvcZPQ7oIqzegWVp25+Gki55jwxEsW4OL2NBmqfe/0r4oiNxqyTFWQaNLEuGyQTrdL21
 sV1qdF0ZoXsdnVpO5Ojpe/DK40yjEIFbAVbKcnuzXrLd94EigAysqkDlhfRbjVcjb7BGkN8/MzU
 bWYwCVWOCA4TU9iyn3jqh41kPsJyiHZI9yb7+VYlneDIvZbkUggaNrw4MOMenTE1PQLNXx7qtE9
 CuxS+iC2RDtxNeBiOX9uw6QSTHskDQR5J0Yw/LzdO6XB3Pr1Ssq9IRSurMuoXASt4fsnzsxrXa6
 u4kIyCH46W3iHXy5eVQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ccef57 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ySWqCA71J16aY6q5SMA:9
X-Proofpoint-GUID: AncCNW5FQ9CtCYx1hm_5Pg2ARS8W0nvG
X-Proofpoint-ORIG-GUID: AncCNW5FQ9CtCYx1hm_5Pg2ARS8W0nvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010089

From: Abhishek Dubey <adubey@linux.ibm.com>

Extend JIT support of fsession in powerpc64 trampoline, since
ppc64 and ppc32 shares common trampoline implementation.
Arch specific helpers handle 64-bit data copy using 32 bit regs.

Need to validate fsession support along with trampoline support.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---

v2->v3:
  Address comments around PPC_LI32
v1->v2:
  No change since v1
    
[v2]: https://lore.kernel.org/bpf/20260226041217.18059-1-adubey@linux.ibm.com
[v1]: https://lore.kernel.org/bpf/20260216155310.38457-1-adubey@linux.ibm.com

 arch/powerpc/net/bpf_jit_comp.c   |  8 ++++++-
 arch/powerpc/net/bpf_jit_comp32.c | 35 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 16d15ff3145a..b2fdf8ff9c60 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -542,7 +542,13 @@ bool bpf_jit_supports_private_stack(void)
 
 bool bpf_jit_supports_fsession(void)
 {
-	return IS_ENABLED(CONFIG_PPC64);
+	/*
+	 * TODO: Remove after validating support
+	 * for fsession and trampoline on ppc32.
+	 */
+	if (IS_ENABLED(CONFIG_PPC32))
+		return -EOPNOTSUPP;
+	return true;
 }
 
 bool bpf_jit_supports_arena(void)
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 3087e744fb25..f3ae89e1d1d0 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -123,6 +123,41 @@ void bpf_jit_realloc_regs(struct codegen_context *ctx)
 	}
 }
 
+void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
+						int cookie_off, int retval_off)
+{
+	/*
+	 * Set session cookies value
+	 * Clear cookies field on stack
+	 * Ensure retval to be cleared on fentry
+	 */
+	EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG), 0));
+
+	for (int i = 0; i < cookie_cnt; i++) {
+		EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, cookie_off + 4 * i));
+		EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, cookie_off + 4 * i + 4));
+	}
+
+	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, retval_off));
+	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, retval_off + 4));
+}
+
+void store_func_meta(u32 *image, struct codegen_context *ctx,
+					u64 func_meta, int func_meta_off)
+{
+	/*
+	 * Store func_meta to stack: [R1 + func_meta_off] = func_meta
+	 * func_meta := argument count in first byte + cookie value
+	 */
+	/* Store lower word */
+	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)func_meta));
+	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off));
+
+	/* Store upper word */
+	EMIT(PPC_RAW_LI32(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32)));
+	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off + 4));
+}
+
 void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 {
 	int i;
-- 
2.52.0

