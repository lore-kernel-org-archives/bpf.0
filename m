Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342314D2ED1
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815648; cv=none; b=ZWaw0iVa8PNajliAHtpGHEP4ZwdTx6kzi/R90RUznpCb/hlrAqwTuiuN4Vc/ewnMQTCX4i4oki6FwM5QP4yR9ibJ7DByi4ZoPUrn2TFZpLW9FhceyNe2kEpTiWmvAt9Y3JvTEgvnASQL2/kxpOUYRE8ND0JZDe9Y9KzUjogMrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815648; c=relaxed/simple;
	bh=ep7pbzrOMcXC6hC4p/1WHJuHiZCUS1t9hy1PkLYN3+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC0cb9YY2pWk+T0jScLk7Quryyxyk4N/TSvVilVfjFqNYiikpyLml30Qf+Y6jl8ZMJ9F/zkXq1VLzVUgqCpgW3qu4Wjl2tkrfOutaW693VYoBbHdF/5zJifSxbO68kfpFSnqGYG74L6JRyM3k76wMJIGpDA5l2yeUbyLOCJ8JFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sITgB91R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sITgB91R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC2AB3015582;
	Thu, 23 Jul 2026 14:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=U+TBdRWSYgZR4iLr/
	tbgexPeCqqbPtlgbKfdAB68Cd0=; b=sITgB91RX1XSzB3JsEXKP8rFHCEIlgQdk
	AMxXaImokMFsxFRKCaAKg7+pxDuesKTcq4Dbfp+cWdywRP8PYB3cgYtK0qV1k1TY
	yi0cc//YqkGxDg/IxoEo8PZCjtBnvuJ5JlAuAW3xgckiehfh4eX4mAN6JrwwilGf
	C2L6fZ4RlHw5tOBbQbLAnm8i4GRSVVrQOzf0BW1GBC7OLxi9/m81zv7I97CeGFH2
	2PULZX3ccWvs38pkHs8tz+zNcJ/o2RO509SwRpgE3flexf5QesAn2Je5KZeiNSyP
	Dr8fTqy4yghp9HTac+FAjL/4JpeQYRs1NgxuQjIeAbcy/OWiU8Fnw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kfbna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4aV3025094;
	Thu, 23 Jul 2026 14:07:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcepb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NE72AJ66716004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:07:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCFA05803F;
	Thu, 23 Jul 2026 14:07:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E172B5804E;
	Thu, 23 Jul 2026 14:07:00 +0000 (GMT)
Received: from thinkpad-p1.ehn-de.ibm.com (unknown [9.224.75.254])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:07:00 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] s390/bpf: Add emit_ldx and emit_stx functions
Date: Thu, 23 Jul 2026 16:03:49 +0200
Message-ID: <20260723140648.583055-6-max@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a622008 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=M92wkxmD5TlqJV64HIMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXx+f+OKN1RIk2
 phOIoiioUEweITFWBRa7C0ILcc4MndVUW4IYFt+RU1wIMWnVCeatv/dWxsdUxXbO75g2OJhwTX3
 AEN7Ab2uHJMbOHuSMu9RtCxq6YFcpTKXoqQKnqB7t+EwzG6/uLHfoVZfGCqTqnnb0rKCkm5oAPi
 XbItiI9WnBjXQzZc9oqIL+fuDsEGYN5T/z1Q+/kP5J1JYTjKcEe3juZOUui+94ZXNv104MZr2Zr
 7j75TiF5QuVP9o82vbOIEwI2W5BWalRWARgGIAZUDyHTo1ColtobyI9qn/0KqaoIyEthv329Y4e
 LChAqW3GW6OjN/dTbtLuKzPdTe8ulpTFzsaYJUnNCgWnWpK33nywvDBGhx3Vrt9UBPr+ocYAE3N
 ZF2ojULcpOvKIQ0g08Kslj0FbGlBCXJajhy/gkwPNvdDJ72Kj4elJ69LGNapPALgPFZxyg587di
 TPiRpz9D1HNOlLfFPUw==
X-Proofpoint-ORIG-GUID: OkFGzKc3KKluxrcFrpKu0K0P5Mmq9JhR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXwT05HBLr6+rD
 jA54UWczetH28W796qEK5QYkq5xvKtRVNqr3vULj+cuHlQQA9/GCUMipb3gwsn/a8RDvM/LuIfA
 T+5Ah+HkrDGGmVGuC0/DjWX/B8qGuJA=
X-Proofpoint-GUID: OkFGzKc3KKluxrcFrpKu0K0P5Mmq9JhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230135

Add new functions for load and store to reuse
them in the load-acquire and store-release logic.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 167 +++++++++++++++++------------------
 1 file changed, 82 insertions(+), 85 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 31749c0362ca..e3dc0df551a7 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -830,6 +830,72 @@ static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 	return 0;
 }
 
+static int emit_ldx(struct bpf_jit *jit, struct bpf_prog *fp, struct bpf_insn *insn)
+{
+	struct bpf_jit_probe probe;
+
+	bpf_jit_probe_init(&probe);
+	bpf_jit_probe_load_pre(jit, insn, &probe);
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B: /* dst = *(u8 *)(ul) (src + off) */
+		/* llgc %dst,off(%src,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0090, insn->dst_reg, insn->src_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	case BPF_H: /* dst = *(u16 *)(ul) (src + off) */
+		/* llgh %dst,off(%src,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0091, insn->dst_reg, insn->src_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	case BPF_W: /* dst = *(u32 *)(ul) (src + off) */
+		/* llgf %dst,off(%src,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0016, insn->dst_reg, insn->src_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	case BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
+		/* lg %dst,off(%src,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0004, insn->dst_reg, insn->src_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	}
+
+	return bpf_jit_probe_post(jit, fp, &probe);
+}
+
+static int emit_stx(struct bpf_jit *jit, struct bpf_prog *fp, struct bpf_insn *insn)
+{
+	struct bpf_jit_probe probe;
+
+	bpf_jit_probe_init(&probe);
+	bpf_jit_probe_store_pre(jit, insn, &probe);
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B: /* *(u8 *)(dst + off) = src_reg */
+		/* stcy %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0072, insn->src_reg, insn->dst_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	case BPF_H: /* (u16 *)(dst + off) = src */
+		/* sthy %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0070, insn->src_reg, insn->dst_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	case BPF_W: /* *(u32 *)(dst + off) = src */
+		/* sty %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0050, insn->src_reg, insn->dst_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	case BPF_DW: /* (u64 *)(dst + off) = src */
+		/* stg %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, insn->src_reg, insn->dst_reg,
+			      probe.arena_reg, insn->off);
+		break;
+	}
+
+	return bpf_jit_probe_post(jit, fp, &probe);
+}
+
 /*
  * Sign- or zero-extend the register if necessary
  */
@@ -1477,44 +1543,13 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 */
 	case BPF_STX | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = src_reg */
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
-		bpf_jit_probe_store_pre(jit, insn, &probe);
-		/* stcy %src,off(%dst,%arena) */
-		EMIT6_DISP_LH(0xe3000000, 0x0072, src_reg, dst_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
-		if (err < 0)
-			return err;
-		jit->seen |= SEEN_MEM;
-		break;
 	case BPF_STX | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = src */
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
-		bpf_jit_probe_store_pre(jit, insn, &probe);
-		/* sthy %src,off(%dst,%arena) */
-		EMIT6_DISP_LH(0xe3000000, 0x0070, src_reg, dst_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
-		if (err < 0)
-			return err;
-		jit->seen |= SEEN_MEM;
-		break;
 	case BPF_STX | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = src */
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
-		bpf_jit_probe_store_pre(jit, insn, &probe);
-		/* sty %src,off(%dst,%arena) */
-		EMIT6_DISP_LH(0xe3000000, 0x0050, src_reg, dst_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
-		if (err < 0)
-			return err;
-		jit->seen |= SEEN_MEM;
-		break;
 	case BPF_STX | BPF_MEM | BPF_DW: /* (u64 *)(dst + off) = src */
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
-		bpf_jit_probe_store_pre(jit, insn, &probe);
-		/* stg %src,off(%dst,%arena) */
-		EMIT6_DISP_LH(0xe3000000, 0x0024, src_reg, dst_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
+		err = emit_stx(jit, fp, insn);
 		if (err < 0)
 			return err;
 		jit->seen |= SEEN_MEM;
@@ -1574,8 +1609,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_ATOMIC
 	 */
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
 	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 	{
@@ -1687,15 +1726,20 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
-		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* llgc %dst,off(%src,%arena) */
-		EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
+	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
+	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+		err = emit_ldx(jit, fp, insn);
 		if (err < 0)
 			return err;
 		jit->seen |= SEEN_MEM;
-		if (insn_is_zext(&insn[1]))
+		if (BPF_SIZE(insn->code) != BPF_DW && insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEMSX | BPF_B: /* dst = *(s8 *)(ul) (src + off) */
@@ -1708,20 +1752,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			return err;
 		jit->seen |= SEEN_MEM;
 		break;
-	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
-	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
-	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
-		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* llgh %dst,off(%src,%arena) */
-		EMIT6_DISP_LH(0xe3000000, 0x0091, dst_reg, src_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
-		if (err < 0)
-			return err;
-		jit->seen |= SEEN_MEM;
-		if (insn_is_zext(&insn[1]))
-			insn_count = 2;
-		break;
 	case BPF_LDX | BPF_MEMSX | BPF_H: /* dst = *(s16 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
@@ -1732,20 +1762,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			return err;
 		jit->seen |= SEEN_MEM;
 		break;
-	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
-	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
-	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
-		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* llgf %dst,off(%src) */
-		jit->seen |= SEEN_MEM;
-		EMIT6_DISP_LH(0xe3000000, 0x0016, dst_reg, src_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
-		if (err < 0)
-			return err;
-		if (insn_is_zext(&insn[1]))
-			insn_count = 2;
-		break;
 	case BPF_LDX | BPF_MEMSX | BPF_W: /* dst = *(s32 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
@@ -1756,18 +1772,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		if (err < 0)
 			return err;
 		break;
-	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
-	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
-	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
-		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* lg %dst,off(%src,%arena) */
-		jit->seen |= SEEN_MEM;
-		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, src_reg,
-			      probe.arena_reg, off);
-		err = bpf_jit_probe_post(jit, fp, &probe);
-		if (err < 0)
-			return err;
-		break;
 	/*
 	 * BPF_JMP / CALL
 	 */
@@ -3028,13 +3032,6 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	if (!in_arena)
 		return true;
 	switch (insn->code) {
-	case BPF_STX | BPF_ATOMIC | BPF_B:
-	case BPF_STX | BPF_ATOMIC | BPF_H:
-	case BPF_STX | BPF_ATOMIC | BPF_W:
-	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (bpf_atomic_is_load_store(insn))
-			return false;
-		break;
 	case BPF_LDX | BPF_MEMSX | BPF_B:
 	case BPF_LDX | BPF_MEMSX | BPF_H:
 	case BPF_LDX | BPF_MEMSX | BPF_W:
-- 
2.55.0

