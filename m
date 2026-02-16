Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED87301718
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239210; cv=none; b=T/0NL4AELtyHKS5Vn9YTvT/ODAkfX89i1cVX8AP2IH7FAOjlF7vMgthXCe+d7cinVNmZD73ead+/TXVVvHOhwYxx8W0r1NTmx5UnvafF6xdfG0iKhfkz/L6s1q+tg7bpaeY3cCSGHx9EJo+KGUBtxXS4N8Mb27BjvfWNprmQ2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239210; c=relaxed/simple;
	bh=f5XfQom7kF/AwU7ZaxbtyitI5x0/gWjzB7wliqjW3c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjIIk0ipQAvil/bYjtpoV/EronVvlG78iLT4eMfjc2IzzYY4//vp58svBTftANmNrSJSpj0oVvtGvRh18nPX3P88HMvjozIcSjEAP18CGrx9HEtsbiEnuuVwip02qUuZwnQvTxJ/50BD5tXsrIr8Xi6v4BgkQnnOd6Jip7zS9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LQdmL+d8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LQdmL+d8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G5PNbY1448294;
	Mon, 16 Feb 2026 10:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OmqFTgRqOq9or6wZK
	ZbPjcu17SMCURtdsaFIELB0ln8=; b=LQdmL+d8tMJYv8WJ//pCA+zIbN+Gq0c2v
	OB/FLOYb+YExEP66hTkvaGYnis7O7uz5hAnvvQYlXExGO6TQN2CXAqUuJAGEZcJv
	yGhhuyR8c4qmlBtvytkdHfA+MWK7RtNJjb3tPid4fwnlLLZreQg0eaSfe7j9k2kU
	Sp4xRKXnyQutuA5oF1/U55kJ/3dQ7ENRwXod9m2brmCUlBYc8pmHqlgu5RVp2fUr
	5iukjXHGTATHqNUWddSjI4kt1NbPbRH7QxLg6l6SJbPjyrjUp3OhcErXpc1iauU4
	rxHP7gpYZxFqLDj225nBcLz7kxFNvyNJwWVEtgnIN+O5xdGfCxXFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj63xu9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:53:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G6LTwF025053;
	Mon, 16 Feb 2026 10:53:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb3rxn5jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:53:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GAr0Gt37814606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:53:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D34D2004D;
	Mon, 16 Feb 2026 10:53:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00AB220043;
	Mon, 16 Feb 2026 10:52:58 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 10:52:57 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
        ihor.solodrai@linux.dev, chleroy@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 3/3] powerpc32/bpf: Add fsession support
Date: Mon, 16 Feb 2026 10:53:10 -0500
Message-ID: <20260216155310.38457-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216155310.38457-1-adubey@linux.ibm.com>
References: <20260216155310.38457-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nEgH6frHMIvewrpChD0Hisy_VMYOOLqL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5MCBTYWx0ZWRfX2vpzY9BZK9Vx
 QgCB/BmVb0/Qi+OM7/ZO4m6CLAor/N8rIuNmGJsVKJ426mWWPwBl/rEKIUoMFFsJMaI2GmJl6iQ
 Dm2e6yHcmGswDNDG0v3Yi32JlC86MBTRwCOec11hA8oRK/CnsyDB6vdImwQfhMy+YJiIQDqnJnw
 +OPjJFVwwIN8nEbqVCzNOs277ynKE+5gI/Kilu7+wkE6NA5YeTG/eFGH9fFzmbsQVit8pMejOA7
 KCf/DIyPl3FkNzIF1/4GmuDg7XFs8y5tCp1jkz+OYdwM3mbCM7GCINJQqp7v5peJmHe6TF80GC5
 CxvGGhwesrz9MmPnqmnQpfbqAvxq6wdj7xsWP6qtBa8ezY1iLul+ngMG90KYs0gW5+9fZ3Iffet
 hIAj3Blx2O83Ac5ejfZIVQ20pOMbwhjWUQeYcSyTU6CNwcPW+lLGl9fQpfFWXROHo3jJc+xRIeR
 UbE/WkMbrMJ3+IIowrw==
X-Proofpoint-GUID: vcHD1HVWe-I1JxvKtHROaS96omExZ4Ve
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6992f711 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=_ySWqCA71J16aY6q5SMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160090

From: Abhishek Dubey <adubey@linux.ibm.com>

Extend JIT support of fsession in powerpc64 trampoline, since
ppc64 and ppc32 shares common trampoline implementation.
Arch specific helpers handle 64-bit data copy using 32 bit regs.

Need to validate fsession support along with trampoline support.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   |  8 ++++++-
 arch/powerpc/net/bpf_jit_comp32.c | 35 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 65e091064fe4..31896ed34129 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -529,7 +529,13 @@ bool bpf_jit_supports_private_stack(void)
 
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
index 3087e744fb25..72dc2a55d66c 100644
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
+	EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG), (u32)func_meta));
+	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off));
+
+	/* Store upper word */
+	EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG), (u32)(func_meta >> 32)));
+	EMIT(PPC_RAW_STW(bpf_to_ppc(TMP_REG), _R1, func_meta_off + 4));
+}
+
 void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 {
 	int i;
-- 
2.52.0

