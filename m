Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37893A254A;
	Fri, 19 Jun 2026 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781906447; cv=none; b=CmTd7R2ZVWTcp+mKQ5U9oZrpzVL9R/Xs8RNukYWf9ELNbzvpvp+AMSrJauOATx4spxv/ckEUQ5v3/HXGM92HUPgnQP9vW3DzEb5ttslL0NKt+XLzzSIcDQJiylmsXrjG6kqGv/nFo48Cz4tzPG2yq3YD4b6z1O5YYYCz5pKSS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781906447; c=relaxed/simple;
	bh=44uvSkPkVoNYeeKcnQWciWBaxhuwZXrWi0K76fEo2gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtL4tw/OhC1gmFSerdZRnzHDXUABQ4kt5CbRTblc1/ywVtBGaWn7qn9ttx3+I3U1sPTaCMFJiHZ/OQSebYg3UmsYlFIRMkVyuhJ6poylf7Pc8aTJIbg0ywuTEQxmT+Pwu7+IPUGIldGyfnATg3XF04M10eLFNv3x061lkxV8JfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fGdEuEIJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fGdEuEIJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmB6I3445089;
	Fri, 19 Jun 2026 22:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ht6JIO
	sKw7Uy93wE1dtWt8hxgethA5gLawPgNtN8nkw=; b=fGdEuEIJ3uAyaQuJZ/ZSde
	LGM98MUMLUSvYp9bqIK6/+HMMfcBryGQh2QCBWB2OdprcRG+4WdoIYGLMSAQlS+y
	akisNfKjglxdGMgONwViqFrviV2xjtj7YeGF6UA1U63Cn4DQ60qdl6iMo6MIF4w2
	WKGTsUPx8SqTDzA3zLA0236bTsAnI3ZhU7XJZDPh3qSRIrfc7hQ0sxB8U+0fVW6J
	XQv0HlUt/05vLkuM3ptoQ2qng7+aSu+r/D6NeT6r42LNc1fvKchotjYHwzpkYdn3
	CC1ZeCPCnWVYFzHVf2AJ2aivx0u0gZ+utoqnR65emCu3wvlBLkUOs5YV0QINMPVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw7rvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnp7j014097;
	Fri, 19 Jun 2026 22:00:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0G3K50069912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAAC020040;
	Fri, 19 Jun 2026 22:00:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB532004E;
	Fri, 19 Jun 2026 22:00:11 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        chleroy@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3] powerpc64/bpf: Add powerpc64 JIT support for timed may_goto
Date: Sat, 20 Jun 2026 03:29:52 +0530
Message-ID: <178190618787.653308.8944417251993496249.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260403105016.74775-1-skb99@linux.ibm.com>
References: <20260403105016.74775-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX6pm6MLiMiXth
 F9MJBBjkgMZPm1E3VDVKzVvdlOCgoK/7LqNiAkguLvKqZwiWkFTYxKi5Gc0PyU7ajkAzmBTRRJA
 F53+ZtzG9YrvKDFC+B64LypSLUVUEng=
X-Proofpoint-GUID: QnzBP-CKFwzx4-ZDOKoScJQDS6xC6vN8
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a35bbf5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=wfb-qDaINPFKIjLEY4oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4pYGxRfDI7dfBn_bQLyDjXW6yPNzbEKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX6yMMTmPobo5q
 F/0sklDVI+q3cHKan5JPo2JPhXh2bZmLNlhvA6n73mzfLkYt5KQhJ688BjIbhNgcNfD+syhmgF9
 RD3AZKCfRlwoG0pf+M3zxANkkuP14Rk9XoXp1VY25PWKxyOgC/6Hoc42uDTup3hXaBSpZi0BQha
 dDNRqwbYVxvZGYsqHVNvr+l27Au4p/iMP23KV40jtr5Z/JMUG5hwNWh5Lt6cQdLUIjxUYDCV6B6
 llN69vM0Oq6NcbIdzDRkuizOvBP09PfLVWOPNC2o/bSzM94/XMNEjpIMnirkT32g4tVYQcpiiYu
 KDe1D+duM/dAuJQTHiVHhZR1wCQkemsJJ0/MHIlp60YMYfUGIHH88sKvQhZYPjDzdvW+LhccQYc
 XZb4YceHLGbyqd0z/UiBTiJJ1nwfkizODeu16Pf+pixsithO8Q/iQpdKN/0vKzv8gyw6PqEyKjQ
 7ATli5rBrg21IGRqNVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Fri, 03 Apr 2026 16:20:16 +0530, Saket Kumar Bhaskar wrote:
> When verifier sees a timed may_goto instruction, it emits a call to
> arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX
> (powerpc64 R12) and expects the refreshed count value to be returned
> in the same register. The verifier doesn't save or restore any registers
> before emitting this call.
> 
> arch_bpf_timed_may_goto() should act as a trampoline to call
> bpf_check_timed_may_goto() with powerpc64 ELF ABI calling convention.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc64/bpf: Add powerpc64 JIT support for timed may_goto
      https://git.kernel.org/powerpc/c/b55b6b9ad76cdb82123c62a15c6a4ebe4abb8bfa

cheers
