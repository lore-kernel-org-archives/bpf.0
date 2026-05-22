Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF3F3C4572;
	Fri, 22 May 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443932; cv=none; b=NFuXkX75UlETRxA12uXX1FmKw08LEq3cMyRkg0LIW5VABz6fS73lbUicTMHLbVRGlsJtJjA70zwsfly2/15NzZxdau1AEi0BGRmx7xHyvWtMnA8n9iKPAHNFnaIqccbOKEvfgbXoImPyhnBAlsfMdGeOHqnCNp8d9Cfmf4wU0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443932; c=relaxed/simple;
	bh=iLcTfo+0P+pqNpkFhMTeYkRe4bYcc9JG+2/4bFmrJwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnhdShbSscY9PPkV/Nkx20k/VYzDwUzsLKba9XtrUCVidE2dee6xKxNZWsP5TR7nEqxqcRHnYmL6dlL+2OsfDpRg9kp7tw+a4WhsS4TL2VnmuhkkUi25Cef0/lqhtZHiip3aEbx4ZPJrbLzpueUVSNV2m/UFDgtDVmPD2BPRKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YD8v0YS+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YD8v0YS+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M49qO92151966;
	Fri, 22 May 2026 09:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dd4VCK
	diNiOyuljBgGGsksXEXNsYlwho+WM2/XguiL4=; b=YD8v0YS+0+peA+tgKEil9F
	RsaoOuzqQLgxnykQ0wl4hlIcWeyaFCKEtQqWInC384JgW06KXi1BMH8qEgAgKL8g
	F9lhlVQYmRhNBEj0Yc1tlnN6jg2LM2Z2c+uLUGD9P+W3oc/eQNi59DPJhOspw5lo
	SjtSwKCxUOo7UWGBIRzUkG9TPME7D4k5dMHJ8BCigupr4IdmgDeKf/JJ0Dk9oo7w
	G/VZK6IY5RHtC0aLUeTKRcth/AXuqh3Ew0mPEddgh5Y/D7i/9AuKOs1YCkT6pH6b
	Ezs/K5NMdTIq8ezO3aZPJlkHu1XJ61nNLdmgXhlXpXd+TjbOLE3S7miynI7eSiNw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ybfr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:58:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M9s8AG018694;
	Fri, 22 May 2026 09:58:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w8g7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 09:58:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M9wj5p50725314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 09:58:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE60820043;
	Fri, 22 May 2026 09:58:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55DF220040;
	Fri, 22 May 2026 09:58:45 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 09:58:45 +0000 (GMT)
Message-ID: <a8728c77-489b-4bf5-b0c7-3e25400d2330@linux.ibm.com>
Date: Fri, 22 May 2026 11:58:44 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/20] unwind_user/sframe: Show file name in debug
 output
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Steven Rostedt <rostedt@kernel.org>
References: <20260521142546.3908498-12-jremus@linux.ibm.com>
 <20260521150507.1088A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521150507.1088A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NSBTYWx0ZWRfX1/mg8WCnM5Ye
 3plejYBYhDpshRaAY0pTAAZrQX0v9D7PQeIWTvuKA+7/feLokxvWQ7Bo+UjwsauPRcpvpm6sSwO
 B8HXUZkY6ecDwRp/DnDRmEKb4nMdUKbhjueSNsk903g/3aiWGJZtBm0soG1S0/Ndq6Jtlmi3zEp
 9QTJeN35TUygqxbEDMIfHTpHX2o+eVy0RsRa+Dq+cvPFnE1NE3pSallvcWKBUn4uUMoBeAzriSk
 UynXY59b/svffEOzKrzPDqLWMnRWMBHN/qm5CsUKxo+aVhbtXHJtJGD+AYbWzOA6xt6wvj1jw0g
 nyeCAdqoaajosE4Y19GZmCiiIbr1eWTsnmgO3pMoUa6WFw0kIsp9zKiV1aSyqm3PWm+xgBLnpS7
 B0pwz3mZR3H88O1okPv1Ch8TxMf6GYEYkTYyaEjaZaoYV4IGuCm1gPVLtZuBR8ImzgsWfK7Z6cT
 4xZvrfZTy3vOXm2dQ8w==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a1028d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0h1wXm3nhgBnVC1u87MAK4afafSpfZ9m
X-Proofpoint-GUID: 0h1wXm3nhgBnVC1u87MAK4afafSpfZ9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220095

On 5/21/2026 5:05 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Low] VMA Classification Bug in `dbg_init()`

Will be addressed in next version as suggested by Steven during v15
review:

https://lore.kernel.org/all/20260521122033.4648359e@gandalf.local.home/

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

