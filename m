Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC24119EA;
	Wed, 29 Jul 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341072; cv=none; b=dlpk3L2XkU5j/qxtyvJ1NG5HNlUGuAK2p5MG9wAOwaJPGyeDvZXJOYhxuwD4bC8w8qDYuwuz0Vb1el+UJVuWBLEWrRVoBvTbLBZcw5i7CuMjrBHmh7CPffNjqM5OVf/ztSM1WrNY7TRqMOFeuic5YlAIr9RdOy6a4KhuSxYEvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341072; c=relaxed/simple;
	bh=a6v3wEAMw7SbC9dYh3pykwkWrJjUsPJ5+3xeIfByJEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmEZGYVYcJ/yRZmihBS0QbiZC9lTB+lOS3WZF2p1fbFpCIxRf22qXHgUQ2H9JgZoBrXLBP82EYAtpP+Pkr62eQP1g4L+k3tu5RhSPVS4Q4iALj5simegnpsbJAg7fD+PQ41QrU9vSO+7bih3CnCx8JlVZyQ1W2L4q+hK3uFkS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QUYNu5zp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QUYNu5zp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHjiL278592;
	Wed, 29 Jul 2026 16:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5b8JNaBuKbt2ObAGBsa6xLbzhMT8FxebnmoXKTqGI
	fE=; b=QUYNu5zpe3Zd34kOicOgjfalykSxk4QSxfS05U51UsPycPAYDLirvDu1h
	SuPvaHivuXg2z7wN8fIczq9QlFFDna5CYHpm93BndMwb2fdz17O6n/Qrjf9Di9To
	d5l23uG82yqXu/qrzEZHENbTsjN1gf3765Y05nghlWFjYwF1EDKaUJYpT6X83rCh
	X5/QRNMNC2PESFOOGdtpVWPxAwcIVwfcR1H3q8aFLpL4Qa2LIrfYY3lh1zqpu4j2
	uPm1JHCKY0MAqCnqAFGFdTccVzPLJVNl2e1kUVUZsOlXI6i3cV7Ry8++Q6DpuJYO
	aQYOlInLDgCaozjyr925BQ1GUqwlA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjar8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:04:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFuNND031383;
	Wed, 29 Jul 2026 16:03:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhfa4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:03:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TG3tY130146930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:03:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DED12004B;
	Wed, 29 Jul 2026 16:03:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 589E820040;
	Wed, 29 Jul 2026 16:03:51 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.22.107])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 16:03:51 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH 0/2] powerpc64/bpf: Fix PCREL build breaks
Date: Wed, 29 Jul 2026 21:33:48 +0530
Message-ID: <cover.1785339155.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfXwK8vh4bFkf/V
 lxEsJhMFzXQWuCVQXyqwEZY356lckummUJ4Y4PrGqbJnuABzEUFtvty/kUYcUPFuo8LovTnFyzo
 t1NVFMVzS5pbOoi/nP2vBAMHTBOzWD0=
X-Proofpoint-GUID: GblyN_BnGJO498Az21cJ_tydLi02Vvod
X-Proofpoint-ORIG-GUID: yWN0ZcMvnXd32UR99hM0DQ4ZTeKE-Kqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfXyrHZaDobh3Ye
 FHiYlgykWtico/c6+0SpODiKqA2YLyloWTKf83+szUG7kNZnBCNQenEJdaxiVyx3bTLo/3Wz3Z8
 i3rrOTV2Qe6Vz+uLtkaBscPRBuMc+qT8Oz8GsjY/9WRO83aDg95Vx1ENUN+E5OzhG1tNOzjmJ9Q
 QQayUl7kR2oLR/V6S9aTmdEIPZeHX1qE8yTGvuPPUs02UmFlJCj6si5pImVhewBSdZnWpos123r
 dPTn9TnbGgLeF+h0D8mE7XtdL3a7PynnYqguymg9qFdHMaHW91kNBYqZjvz/jeZtJj9FU1opID/
 CUe2n+w5XMuo4LuNb0MF1szbVwupgKtDoXZ4+9jeNiERPa2+CPD0Q3rpdyd2LSdQtk+C35xu9oE
 XS5aPfjtvCLovMosJ35cpSs762orXu4zX5y22TMuLWGqWzTewgRMN+3pK404xI5LK89BEgGNVdY
 CGw73N5l4cJ72xHfWow==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a2470 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=V9aS72HiZkO_OSrc0EwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290126

This series fixes two build failures that occur when
CONFIG_PPC_KERNEL_PCREL is enabled on powerpc64.

Patch 1 fixes an unused variable warning in bpf_jit_emit_func_call_rel()
by marking the variable as __maybe_unused, since it's only used in the
non-PCREL code path.

Patch 2 fixes a linker error in arch_bpf_timed_may_goto() by using the
CFUNC() macro for external C function calls. The macro properly handles
the @notoc annotation required for PCREL builds, informing the linker
that TOC restoration is not needed.

Both issues were introduced by commit b55b6b9ad76c ("powerpc64/bpf: Add
powerpc64 JIT support for timed may_goto").

Madhavan Srinivasan (1):
  powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()

Saket Kumar Bhaskar (1):
  powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto

 arch/powerpc/net/bpf_jit_comp64.c     | 2 +-
 arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.54.0

