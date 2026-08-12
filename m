Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7F40DB35
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527675; cv=none; b=JqiNsAgx7aTBed9Q4CH9ZfwH9E9dpGBq18vy52U1kBoqqbDJeEF6ZcnOYi2oSW34pxJtPfaKQd4Y7jZLruHsvu0zyWC8FWRZj1CFgcMSk3Gi82q2HA5tabBj/GarVFaC2WO7TeVrcZJM8R5uKxCgrd3mLrYCeZ0K8tOTLNehpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527675; c=relaxed/simple;
	bh=Yug+O3PA14V/eCqYuc8hQ56NC5LryuHPn7OZO95GTYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlboHPOxibv9+zRHLJudLu48mqOwYJBKg/2H8x9dUyQSfvbT5dJiMae5smE65eb3HiSJO1wsM+2o5dWqTt/Wsb+nP+Dhw6TUYO4XVi4x+bJGICXXmFNSUTSOLvxWJsIWHZ6hYO6wJLtZlMsu9uwYIW5tM8qpYWfeQ8xLW6d+7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I1TbKzq/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I1TbKzq/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C633682708293;
	Wed, 12 Aug 2026 09:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M/Md3q
	fHy7zbzjO2unapyVLKswD7p7e8F9yCBRdaO08=; b=I1TbKzq/nfUhMhcp0+VfQf
	YDpJnM2iUahMW7Xu6rvfRrxgV09NNIkrLZX1A5uNk2jfZmwKIgHxTnaoM9i6dXyx
	QCTIGdFRlFjOpN5qUICBm0nGrlTU0IdBMP6fXeGCQ4fQppUwsv7NUQcH9trdvBOM
	vufTkF7Fk5BIMdhiHxj/E5iMHTVcqD9U/OCqZvkY3Iyut27rquFKHaUZ6yqnmkq+
	IUYnDtIwvjG/1qU86k7Q4nNtlF5M44Ev7kRZ3OMPlc3eB0CSMd/QxmYfHsr5Ybi1
	oedCk3rI5ScIXOjRuabHvfAgQtIb4sIYYxZdp/lGJTv6h8DtQ5Eb5zhlRC3SuroQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw90m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:40:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C9QG9Z011438;
	Wed, 12 Aug 2026 09:40:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy575f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:40:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C9ep6m32375154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 09:40:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97EF2004B;
	Wed, 12 Aug 2026 09:40:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9548820043;
	Wed, 12 Aug 2026 09:40:51 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.53.227])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 09:40:51 +0000 (GMT)
Message-ID: <fe79c96e-7fee-4d00-a696-7119df789acf@linux.ibm.com>
Date: Wed, 12 Aug 2026 11:40:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 5/6] bpf, s390: Clear fetch destination on
 faulting arena atomic
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: eddyz87@gmail.com, puranjay@kernel.org, bpf@vger.kernel.org
References: <20260811131600.506721-1-daniel@iogearbox.net>
 <20260811131600.506721-5-daniel@iogearbox.net>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260811131600.506721-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c3fa6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=hWMQpYRtAAAA:8
 a=VnNF1IyMAAAA:8 a=A3LaVL0a1cGBXct1hZYA:9 a=QEXdDO2ut3YA:10
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-GUID: zTjtQo5tZIBYbIKyHEPOMLENHEmid2Zq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfX79eXsRCQZL2a
 OSmXM8Z9p8WP2fadElV7seFDz325GuDEfzk0Q3NsjiJypOyJ+SiEqJ9I4/NGh6Iz9xRbqvKBB8o
 wDNnSzGp3Xv2MCG7C0IpRPO8xkQwq1pxA1MERUDzGd2nM+15/6F8WBPByEVgWxzRSoSHcWBRX45
 8Eb+81PfiKW2rJmPLSPAbOWGnzpkkO1nzxeqVJmq9BuGYhT7UKTW6ZxNs/8JLIcGgp8qlbrEMzo
 HAxb9tXWA0iI+1mlt5FPTviipDgtkNRtFBGW32V2RcogUjDVBdu2YLNPl915Npwbp7swJwhNc5t
 lpj1N4xeiEq48REVF0LHX2lcXO0fL9TpekyZZtD8roAHbkoiKTznxAZete7V/gW996AZokjfGEO
 NNkCK+S4Dqbm1kMZLicy9tA2uc0Ty1KNjWbo0GECHykSwBKCihB/4PFUfjYL3+MgJEGyDX2LrIs
 V/mQgGdDdkZsfMeQB8A==
X-Proofpoint-ORIG-GUID: k8wGKye-FNYs7KEHbBHOEQpWGAWBc-8q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfX95P4/hF0IEQy
 HGojgd/i2VzHkIdJH0w+aH6CmkMD6VFU7eC2VgRcXVDB2y79CaPjxq14rikXS4w8+mEyZmKPCLE
 e1HRliCrRfNcP7GaYLhUYcyc0QCCokg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120076



On 8/11/26 15:15, Daniel Borkmann wrote:
> Same missing register clear as on riscv64. A RMW atomic on an arena pointer
> is converted to BPF_PROBE_ATOMIC and gets an exception table entry, but
> bpf_jit_probe_atomic_pre() only fills in the arena base and the probe
> offset, leaving probe->reg at the -1 that bpf_jit_probe_init() set, which
> bpf_jit_probe_post() writes into the entry and ex_handler_bpf() then reads
> back as "there is nothing to clear".
> 
> That is right for a plain BPF_{ADD,AND,OR,XOR}, which only writes memory,
> but an RMW carrying BPF_FETCH also reads the old value into a register:
> src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and r0 for
> BPF_CMPXCHG. So on a fault over an unmapped arena page the program resumes
> at the landing pad with whatever that register held before the atomic
> instead of the 0 that every other BPF_PROBE_* access delivers.
> 
> Fill probe->reg in from bpf_atomic_load_reg(). Unlike x86-64 and arm64,
> s390x does not report arena violations from its exception handler, so there
> is no access direction to correct here, only the missing register clear.
> 
> Fixes: 2f9469484a3b ("s390/bpf: Support arena atomics")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   arch/s390/net/bpf_jit_comp.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Looks reasonable, thanks!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

