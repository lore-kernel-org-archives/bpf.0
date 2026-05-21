Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E39140E5F;
	Thu, 21 May 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363237; cv=none; b=c5zzSdVH1JUT347kyT7atMxYDWlzulR9RM2WqvN/LMJSObZWznn6+ja0lWmxntpBTU9gvjQB7hmspsD+dBSxnJQGpeq4uterv5EsnQF3Y1vlHFVuHX1UT+z+5viFbtXIyG4GnyCDAP9QZ9eOMWnq34ZNGa7Tv6vBn8r8BNA/e+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363237; c=relaxed/simple;
	bh=48JF2fZtX1JLHpCnnCYajcAB5bnNal9lyACIeZvE3Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLsz9QYFtZlsJa+70dkk/dPqkOl6Xc4nl+BQpLeUs2BgSSDlyCfXvGsq4SQ+G9yokHxxWz+n0/KLepfyZkMgSXvowBytECu9+Y5Wd/zj/rqSuXi41YQ/hRVfu6okuFgbuyj0cXO9RQRT0D6GriwsuCteZojpuCzJ7cN8injZtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JeOOeaWm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JeOOeaWm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L9Zfri3760653;
	Thu, 21 May 2026 11:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TVVKao
	RoJBgPObwfjapvq0qUVWZrGuMlrckqzLhj51o=; b=JeOOeaWmaO+WQaWJTtPV4K
	7KutqY/2QOMAyk5fmQz5+A1kABpyjN7AuGRsPCX9wnUvBpO5mFfTSUdO2NYIu+Ts
	+iGZBCXis7zzW1oQhPnaymy5bR/u/ij1XH11MMb9+Dcbh16YwdpL6HqXKq0wOQ5G
	xHj/tpvumefA3FgCFtAXFS1hgTcEHxBlDx8JLh0hyibW06BpY1F4H0fuQy9+EKxf
	9FsB8szW5oqOv6uHwZ9qIGAOvzbG2vHVnACj2VToSV16KwTEBHBxMVoTQf/71SV9
	m300gadtGrcqiE/fn/fTp4lLmbcUCR0J0nJ9SMXd+NkTFaJsfAfiBQmIPklfpNSQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h756jrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:33:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LBODIa024476;
	Thu, 21 May 2026 11:33:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqc22y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:33:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LBXoRp14614948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 11:33:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40A9220043;
	Thu, 21 May 2026 11:33:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C4EE20040;
	Thu, 21 May 2026 11:33:50 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 11:33:50 +0000 (GMT)
Message-ID: <841e2917-dc41-4397-8bc8-04468f7a06f5@linux.ibm.com>
Date: Thu, 21 May 2026 13:33:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 15/20] unwind_user: Flexible CFA recovery rules
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260520154004.3845823-16-jremus@linux.ibm.com>
 <20260520162249.1E65E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520162249.1E65E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0eeda0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MQy98QgSc5DZ9KYvRAz6DKXyHlLdYXGu
X-Proofpoint-GUID: MQy98QgSc5DZ9KYvRAz6DKXyHlLdYXGu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExMSBTYWx0ZWRfX1hPUIcBM0Bwa
 n9K74Zl+qixX7yfkKfGgQIFiBh1vKlJ1UtFd6N8aVeCM+7Q7WdGUzgv6g85b8mQVUbYmm/xJqoT
 AeFyiOmPYI2KkCt7Miwlryh0g04He16EQRSK0JZ8XWUPQH8WKoKYP4X+U6H1JinN6bdj8p94orQ
 kbjlwa9MSuuR1wBokVIc9rOex6jInJgK5Txo/z75lUzDhaUmj4h1Rf82KosnkoEHwv6nIsqh0rT
 WGtzSSic6JWkpZ1sDPqqLuA14rDawS3Uq9ucUX8SlNXAsfyzpKyOS7bXDuemuLA628+EExf0iIC
 4tz+swRU4H1S81kFWB9LD5Srt/ZlqITqMhZsbtJYqaoZz0yIiezU/qIcE37Giv9RjeXB1AOJ1sr
 KzfPhvGRRrwvjyR5WJs29PBG8lV1q5VliX/OwgiPtOM3LfO0rJ3p7ozr9Z7eyFxXBJiZAOzYJp2
 9jkajMiunp8EjJuy+rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210111

On 5/20/2026 6:22 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The size of an SFrame Frame Row Entry (FRE) is incorrectly calculated because the `dataword_count` variable is decremented to zero before the size calculation is performed.

Fixed in next version of "[PATCH v15 05/20] unwind_user/sframe: Add
support for reading .sframe contents".

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

