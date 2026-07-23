Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF334F255
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815647; cv=none; b=TuxItKDBHYuOO/Tu/PHyaGxUmWms5oXOsYsOVQSbft49CYPvkhDC1TW4k4oLwHCCC1yatQZoQABvaAv4WhwPZ+1uFvBoYDqHV/lqPgSLrR7VLplRisVBni+6XEYosDhgMjYe0MbbyyBGqAP0F83NTi75dIOuMPoUK+urZUkantM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815647; c=relaxed/simple;
	bh=dBOE7mmawyOSBXl4N5rIJbqK74h3RC32WuMaXDVdmtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=expInmcHGWSaCOfq4Ae37lNphNMjlKHSKfsFtzopbMYFMMSTB7z+EQ2T5qLBa06VmRsEfXMHYbmlvxfjBuqv+bUboqkxpZzEp68TomG7jII22MYoHVRx6+0VUu+LYKAy4Q4qQrY2/BVgcMYtsKqK6PoPa39I0j2r1gF5rQVCjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V8NtdmAa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V8NtdmAa"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBcU23106067;
	Thu, 23 Jul 2026 14:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L4f0GaVOUSAqoKhTQ
	3D9tNhDGD0WFf0GsoGVPy+7MvY=; b=V8NtdmAaRfotVGD9n7uX2Nx1wZfs2zxB7
	wCDzLH7c8wyPlgNTDOA2zKVy7JyzWVVNyRfOcBh/RxhIMchdMfEXHI4JYTGUEWdQ
	YoTPcVnYpvigMvxvlcoEAcD1fdosinW3UcUxkRVGpaGQam7uEmAylD3x9gafNrr+
	maVXf1kzpuNrQUPn4+TunkQCeSY9GG45VRoMIQHIOZLgcVd08PPYRhnrl0Tx4IoZ
	pANJ3tl85gZa2x4CJhGnRHwGIv1R5eMLGkaLd1M6VcwRGSb7/TfgmWofpkC4J+rj
	kSlg8zolu1PI9rMZ6g4i0VbRXS36PvqnmKu+VIvzllAdFD3KStpUA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7917wyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4cwp029918;
	Thu, 23 Jul 2026 14:07:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4gfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NE75Dm41484978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:07:05 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BEF058055;
	Thu, 23 Jul 2026 14:07:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F78658054;
	Thu, 23 Jul 2026 14:07:03 +0000 (GMT)
Received: from thinkpad-p1.ehn-de.ibm.com (unknown [9.224.75.254])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:07:02 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] s390/bpf: Support load-acquire and store-release instructions
Date: Thu, 23 Jul 2026 16:03:50 +0200
Message-ID: <20260723140648.583055-7-max@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723140648.583055-5-max@linux.ibm.com>
References: <20260723140648.583055-5-max@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HV0VoslfAmL-kAZWf-pejC-5ADY3b7Jz
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a62200b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=mDkE8aj-y5FAbMWvahcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX5atXbGIqgwlu
 oJg16icPXJc98r1MSnKxCbHormGlXJhYE+bh0ITOXWzeL98sMrP6zunciLA0FQEU/95kmCzIIvh
 j6QVqZbWooXH1ykASaKvoLpTO7/Q4/8=
X-Proofpoint-GUID: HV0VoslfAmL-kAZWf-pejC-5ADY3b7Jz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX1PcXH3x4+ub/
 bvjyHAomlGiCZrMiyS4RkVuF0EsBjJJEdPawq19UiBGWMU4+Wq0BuBYy85ZVvogFr7cxIyEVoYl
 O7NaeBYC++fk5y8SeBf5+2+aZE3swCUfvvCRAh8dQnESXDIDvvyBU3JXLfiv5LuYUd4xx6ABw6C
 laIFftl3i83j1IHc3xaCGOSlmlZ5p08yk5Ojq14QjEka5wdbWiq7D/1BMLk6scluXhjk3+Br7BL
 i+M47Wg8TRu5U/ilLjkCEhczNvbMov4j+b9pP94vxzVmZXuVnSlg0Vje710CoyhzpOzvwvj+cfp
 YKGNfJJxJo7/UxySywusmweMslpv0Q5v8xa3NeWLKWRigC4aUyF0srUbnxhFgW8sc1yv8Xi/rb9
 i5cZARrmKJldY54P+GwnXx2lkfCxPBCJ6w8DTr2Uj9gvMsf2dRXuOK6ONNwVtgT2/gXqMKGlBhE
 vaCWfvceXxTi52k9MBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

Support load-acquire (BPF_LOAD_ACQ) and store-release (BPF_STORE_REL)
instructions. Since s390 has strong memory model, implement
them as regular BPF_LDX/BPF_STX instructions.

Tested with:

./test_progs -t verifier_load_acquire,verifier_store_release,atomics

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index e3dc0df551a7..c98ab2eece57 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -743,10 +743,12 @@ static void bpf_jit_probe_load_pre(struct bpf_jit *jit, struct bpf_insn *insn,
 {
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return;
 
-	if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+	if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+	    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
 		/* lgrl %r1,kern_arena */
 		EMIT6_PCREL_RILB(0xc4080000, REG_W1, jit->kern_arena);
 		probe->arena_reg = REG_W1;
@@ -758,7 +760,8 @@ static void bpf_jit_probe_load_pre(struct bpf_jit *jit, struct bpf_insn *insn,
 static void bpf_jit_probe_store_pre(struct bpf_jit *jit, struct bpf_insn *insn,
 				    struct bpf_jit_probe *probe)
 {
-	if (BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return;
 
 	/* lgrl %r1,kern_arena */
@@ -1621,11 +1624,11 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		bool is32 = BPF_SIZE(insn->code) == BPF_W;
 
 		/*
-		 * Unlike loads and stores, atomics have only a base register,
-		 * but no index register. For the non-arena case, simply use
-		 * %dst as a base. For the arena case, use the work register
-		 * %r1: first, load the arena base into it, and then add %dst
-		 * to it.
+		 * Unlike loads and stores, s390 atomics have only a base
+		 * register, but no index register. For the non-arena case,
+		 * simply use %dst as a base. For the arena case, use the
+		 * work register %r1: first, load the arena base into it,
+		 * and then add %dst to it.
 		 */
 		probe.arena_reg = dst_reg;
 
@@ -1712,6 +1715,18 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			if (err < 0)
 				return err;
 			break;
+		case BPF_LOAD_ACQ:
+			/* s390 has strong ordering, just use load */
+			err = emit_ldx(jit, fp, insn);
+			if (err < 0)
+				return err;
+			break;
+		case BPF_STORE_REL:
+			/* s390 has strong ordering, just use store */
+			err = emit_stx(jit, fp, insn);
+			if (err < 0)
+				return err;
+			break;
 		default:
 			pr_err("Unknown atomic operation %02x\n", insn->imm);
 			return -1;
-- 
2.55.0

