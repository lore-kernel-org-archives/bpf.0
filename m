Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029B34DCC7;
	Fri, 22 May 2026 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444524; cv=none; b=Hz/JCfCvEI6+fr+o1D0cIeuwA1Pb8mcbvfGgxPIw+ZtjcsI8I0KZe0tI40KZ9XkpRoy7QAuyhpOf5FEbR4n/HOMLbJ85COZ3Y9CojIirv2Xe7KMFpf9taf8UB8Jc8BDBeV8ErEOm+ZyagOKMXapkD5+T2ZMab8g5eEfUdkNou8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444524; c=relaxed/simple;
	bh=dz0RZZVrtAkqZ+hPWHuN4Qwjz2ezdgYDfg7ggknwDHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyU/e3CyCVqSZHBCcFrpLy+65Z+XazXVdZudBAjCXXC7VyCaPfFCxgyL5MmJYciTGQ8uWObsbbJRUyxGDVct9Uhnly3pOe6sxGF9LvsZbikG1cHHcw26unqiwNs+lLVTDW3RcibhFQ2i4rfEsjnfxygIWCVuSuOZpajUKzUSuT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svdxWgyf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="svdxWgyf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LKwB9j2735197;
	Fri, 22 May 2026 10:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OzfPLZ
	yXy5M7HxqkXM5ndpIdesVEN2ohVm8EN4ovbzU=; b=svdxWgyfqNxedlmq3yrTkF
	rpiQZuZZWVWbakcrXE+jKg/uYND5RECJTsOWgqzCrBV0FHrZkwDy2JJtmb3BDEb3
	RY62A8jWVYP0/VW/qb3bZs+YwMSlbI4y9PaGn2EUA2P2PSv6MM+hy6qLzvgj1bYt
	d1px9YFwqrS7BUhKylZusfQ07tZ6Ge1FOsPztYDGm/Vmn6ha1Dx2+FzFHeJGyCo3
	wajVNYwYt15rugHPJC1aHBw7hOBN4U+v6421MDwHnXu2RpnpuVBi0ox3z9T2+Tub
	xzMnJUgQZT2VxcGgC8hjnd/iWZ+hJdX388bVyWp/LEWTFl95DJ5Il+qC5Vm2E3tg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88sxh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:08:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M9s7OT027046;
	Fri, 22 May 2026 10:08:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyg4sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:08:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MA8d5g37880180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 10:08:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B9EA2004F;
	Fri, 22 May 2026 10:08:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53E172004E;
	Fri, 22 May 2026 10:08:39 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 10:08:39 +0000 (GMT)
Message-ID: <30c236cf-3f10-4181-abfa-b6a474b573bf@linux.ibm.com>
Date: Fri, 22 May 2026 12:08:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/20] unwind_user/sframe: Add .sframe validation
 option
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260521142546.3908498-13-jremus@linux.ibm.com>
 <20260521150217.5B9991F00A3B@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521150217.5B9991F00A3B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EDP2QGGj_WKzOhi5QULQRnGGkt8dbgtC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMCBTYWx0ZWRfXzJrsDmPcglSk
 q6FmC8n3HZkwCFWD0EPo2zhS6jvP19bdFO2Z77Vq6Vd+5uB4eZZWVy9emYIpJDsl0aKKkewZpJP
 pVidcIP8L8LQe+4dBwKneShIQ9igmVCRGMr/elzZ6lWpkufRqPWbYTa0vI+s0gu/toSGtYzWLUn
 3YCBckXTPkb6jxmSZWHsofZu72ViftHvifOWU0M2yLqBq6/7ZWNzImzt/52xUEirvRE2RMBk6Kt
 BaFMZQeV+pm2ABSxCycZHdv8ptC0QwtPtHcZ9nbq1/WGHDv7vgxPFLiDpCMKwYTs/WDojO4qg5h
 ZCgiP8RA1uYIKLonGVL4S0T9xHjimx4OuB0A966PliHktTKxB4Mx6xtQhINDHWSop4rp4atX1FA
 D3q2GOF4h7A8bRJNDJPJhqgCHrO5gZN+WD/5aUtnAcnPn1AGyoH+JtlWW3tWNpLiCJ62ULB9s2E
 xsxg0jRwDCnkAvkarVQ==
X-Proofpoint-GUID: EDP2QGGj_WKzOhi5QULQRnGGkt8dbgtC
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a102b2a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220100

On 5/21/2026 5:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The `.sframe` validation loop in `sframe_validate_section` lacks `cond_resched()`, allowing maliciously large or crafted `.sframe` sections to cause CPU soft lockups.

cond_resched() is not required according to v14 review feedback from
Steven.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

