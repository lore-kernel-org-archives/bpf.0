Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0361DFDE
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569040; cv=none; b=gTYkwAcZYigTes69OUqxsqKn0YJec534a8SUtruG7P+kLinnX6Gc2uCsHUzCL/j2onHvxwWax6W1NPbxgPZKkNUjpJWf5lbfJKkocMKlyNl0qYMnqjtSKEkguqrR7bFeK8q2DlhMrrJ9rtVBbSbvQKGailINMnsG+7LxEVsh4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569040; c=relaxed/simple;
	bh=EPEC98gaTi+Cyd9gSEbNg4Y5LklLbgcQo+ZhwImm4GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCDNb8/teIWMfQDMjO545UAbpiA6YImv2GfYqCZnkKvMr54PR4Cmm2gGNneSSU+NdNNiirFXJEg/lK2WzsrTJ0to8RT113tOM6c1p/wV9xxY9NcXFUiUSdYFdLvyu80H2tiBqzhQlXw0ecqZp4hxlt89tK0vNVKuI8ZxrF/Qtas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nM/pWltB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nM/pWltB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JKmUTW1370978;
	Fri, 20 Feb 2026 06:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UdULi9WQN2topT/t/
	azH8//zbQzYWFyXhCnXwhZVvwU=; b=nM/pWltBf4U/3sgZbCdYARM9G8KxIbzAc
	FFW2RhJjPqFE+dge4ggqzQgpP9FKwq5qMFEtMLtGLaqMuh9wZeAYcU8C+J5nzEqJ
	eGj5iB7ORIFagThY0T7PT/4hEVMwx0sMi0ppaLBcY5RsaJePI9imS8+wVqJBW4gQ
	3aH0rE+1pYp1gl6I5w9BklU0Mw1OfrSvoKl7qes+dn+6ple0DV/kvXMxUMK2KM+K
	zzaMBW1Qsh/gq6ihX4ry0E6n/llIONddxST9OLK0LbAMczb6VJZgpRfLNey8Lfm+
	TtWQZLUJZGVZNxsnl/vUBEJHfKN7JLy1bCwqIL9HOsjCxA4J2QJeQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjrbnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:30:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K4KEcL015715;
	Fri, 20 Feb 2026 06:30:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fbac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:30:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6U5BL21889356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:30:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EADF2005A;
	Fri, 20 Feb 2026 06:30:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F94C2004B;
	Fri, 20 Feb 2026 06:30:03 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.64.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:30:03 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 2/2] bpf: zero extend function arguments while calling kernel function
Date: Fri, 20 Feb 2026 11:59:59 +0530
Message-ID: <20260220062959.195101-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220062959.195101-1-hbathini@linux.ibm.com>
References: <20260220062959.195101-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VYcjtd-ReJwxiJG4OqtgowGY7YRYoCPz
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6997ff72 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=9PpIX1C3ICF4FF4KcOUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfX6DbC9leiDOW1
 P37J7DDFZxYhNE2ESnn+NXHu19FyfcGN2/3hbdWEUiMwRmgj90xIZnjIjMB6QtgdvWCmq3SwikU
 MiZvoRr74m2TbQuR61/OksmKF+Y8hEPKSKgH2XJDilosN2qBeV90cp5YD66Mk+5rOVBbCFkLJuJ
 32i2agvkznkNMajWD8FMX9Z2enDC5nGciX3RV/lfkYvqSbt3c2IuPJ4lEfbJecgwGWMZnBgAim8
 +p7V6JahPKZf/7pEYl4qTGoFnW9Wq/q7NlyFf5/IrLXHrvZh426oOdClvTfDqAV4aAQOlobJX8F
 FEfuyzG240YEmc96pWi5LlIawC+3L68sAhGa0xs90hGPoJt7iypNRKbaRamp3GxEj+jFxthro9R
 q3oQjrvzstUsbxmS6pgT+p4sSUAskEM5GdCUI7+oY26VYftZPrZ5uRqAzFRbCjzQ/t79kp2OOMn
 o5l2jQ/Kn8WjLqgxoYg==
X-Proofpoint-GUID: VYcjtd-ReJwxiJG4OqtgowGY7YRYoCPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200052

For kernel functions, even if a function parameter is not of u64 size,
it may still be cast to a data type of u64 size. In fact, page_cnt, a
u32 argument in bpf_arena_reserve_pages() kfunc is implicitly getting
typecasted to long. Without zero extension for that argument, the
verifier_arena/reserve_invalid_region selftest fails on ppc64le. So,
be more conservative and do zero extension for all arguments. JIT
compile code can eliminate unnecessary zero extension code-gen.

Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")
Reported-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..3f6e0e1c71e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12018,8 +12018,11 @@ static void __mark_btf_func_reg_size(struct bpf_verifier_env *env, struct bpf_re
 		/* Function return value */
 		reg->subreg_def = reg_size == sizeof(u64) ?
 			DEF_NOT_SUBREG : env->insn_idx + 1;
-	} else if (reg_size == sizeof(u64)) {
-		/* Function argument */
+	} else {
+		/*
+		 * Be more conservative and do zero extension for all arguments,
+		 * as how these arguments get used in kernel is anybody's guess.
+		 */
 		mark_insn_zext(env, reg);
 	}
 }
-- 
2.53.0

