Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9003A7584;
	Thu, 21 May 2026 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360346; cv=none; b=uabwqr6wRcOrnD9gKJJXQBdDBMvRAFrGP9RoZ7fSofqGUsSIRZWiaHD6Qgu8S1So9qjCnW9CEZ+df+oP2xDGZoFu+84jCV8uwzpcgIaMhyzQnD2+2YJBhEaR3SmV10qtNwiw4muJbTd0KlN+zP3t5ECtDDwjQZJqxun+QDiCbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360346; c=relaxed/simple;
	bh=Q8G8DI6143Luf0imVDwf3SQJyA1UuS8ZoQgWCbWjRIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBGl74udRJtIZocI1/ARS0D8ErSZuRj21AChGHO1O2spt5NM+vX10W5kuaX067oYiNa+jAVSHRmBObVqJRgbAT5tEAAYQ18mXAxRTKaHmrqCI3bMde+QI4IkkBUp/HOI/T+O2xgRN2r8nu/jDV4+oblN82AVkRUADFWTH0LmX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RJGm5b0i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RJGm5b0i"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8Oko2730699;
	Thu, 21 May 2026 10:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pSVLP1
	4wLc7Xz1agCkKTocO3bld7ZTBoYIDr2Qbe0Js=; b=RJGm5b0iNKbdPfV/QGOHAu
	Rz8y4y2W98AtQBvwCz1zjG0uOE2UBu4shDXcxTCtPOLHpr52tPX3RqzPubyFEEci
	SmvCQ/DDpJ9nGSjebnhX0Vp8imF8v9tk9HuyXQXh57gl6ab2GNvijNDO+RoVLJIK
	RHkj3oRP5quWFzf6o7NFE9Of25qsXguKJRd+iJlZt3F81qoFhEZW0VQEI+irnwOr
	AUWy/UhFcm771tpEoqaaJ/T9FU8CXK8m6NDvZ0xu0anyiMxGEvnpKyqXdRlbv+VP
	nsuUjIr5O0v6edNqRBNw1jGqZYLGrZWc94aCRuyEOiwKUnLNrZdVkcM+CuyHltbA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawd8mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:45:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LAd9i1006391;
	Thu, 21 May 2026 10:45:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gkeb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:45:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LAjd0F13566370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 10:45:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94BF32004B;
	Thu, 21 May 2026 10:45:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80AE920043;
	Thu, 21 May 2026 10:45:39 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 10:45:39 +0000 (GMT)
Message-ID: <2095d154-6d33-4766-8130-b9a244a97397@linux.ibm.com>
Date: Thu, 21 May 2026 12:45:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 08/20] unwind_user: Stop when reaching an outermost
 frame
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260520154004.3845823-9-jremus@linux.ibm.com>
 <20260520160140.8B7FB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520160140.8B7FB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNSBTYWx0ZWRfX4fe0mCnVtcOK
 68YuX8BrxQ3qZEMTtxsJ0D22Jm5bCLXcG7DTKLFunKYSPzp6+YSrw8ihisWujldWrMvspQTsInb
 oyMTAYWV7evaA3FygHHXLQ6gz7e6McyWfEZO2XJarnHIGN0D79sLUHv7a1cv/zKkrQkX2hWVJC7
 j82pW+XBUMssynviHlhwpYqgwO9GPXFLlsuC/CEO0l8HdF3NmBAyGccZJTXLwtuZdpLexwDX+pw
 +Ve9pyM6N8Bto0E2BVSwM/n1DDOV3CMji4b9h1Flq7/ChHqjCW9Gc6V0SrD3ywoYGzTh9PKTnS3
 oxyN2zE/BUMGTv6ZjnBMPpFmGOFB3hV2cH5AA9/uPUi8uS+m/igZe1vpFJFRjjHTUsrMYfBACnM
 yQP7bImnqwRJKumFG26/xRdtPysDQu7EQbdODBHGawE44JEe/fQsyKjptFv+8OcFC+tYjZhEbx6
 Fa48vN723bd39K6ua1g==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ee256 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AwaxKkzXaP3Ykms5gJZBuGE4eg_Olyrg
X-Proofpoint-GUID: AwaxKkzXaP3Ykms5gJZBuGE4eg_Olyrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210105

On 5/20/2026 6:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Uninitialized stack variable read of `outermost` field causes premature termination of user space stack unwinding.

Ignore, as discussed in v14 review, as subsequent "[PATCH v15 09/20]
unwind_user/sframe: Add support for outermost frame indication" resolves
the issue.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

