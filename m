Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1723A6400;
	Thu, 21 May 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360247; cv=none; b=lhVd0R0OKfTcJlGRqSPeEXwTj0X34/CX4VAdRHABUcHjG5IMayyz5aoG2ltX/p5ODK3PPpaoCQKeUbwmpt4z/g4/4bSqf0dguNfLKymOxvfadZ511yFDR3lo9pNo73RwwOpjRYYPvcXUlJWd5GHgi8IhYkftbVWYqUaRhIE1QHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360247; c=relaxed/simple;
	bh=RqNDtK2HZUbaVX0H9gAZGEMe8F1uRt7cXQW3woaDx7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKeGZNyF1agupDGwhAl5LkwKVLJuj9BDJmhj1MWqEiuLsW+I7sjV18Mu87vX+YV6P9Ez36npKVDudhOOV4gE7WCUnFTZZ/UssId1PrCdTS516JFLd4UGxKt5AQ6b3AoPBSBiRMLKyauAg1P9Tig0C85v4hDKG1CVVBV8w94I8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zl105t8f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zl105t8f"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L5oYe33690499;
	Thu, 21 May 2026 10:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gQKAQo
	vVj5KvebYkeyee2JaZmc1n25RbL8Ihz6ExJ1s=; b=Zl105t8fUfpJWPgPuqT5jv
	sAxQ+WPTV1uUx8x1nZEp7llcHOlxjZsjCYPlmpN0JTI0kRs0ffiUy2y3/C3Xqfp1
	a5JW3U33VbywZ8vC4wAcC4XUPWePi1s64hDAIMYlxz4Bu4Zscedenk25dS9u9zKY
	QpmdGQFeqnePfjo9Ak3ouXFJcPAOuT/OeMSV3cIbTJQRS6Gr+KTntxz6hgLnyfDB
	YhndmEmP7UMhKuVYuh/soApcxg1k7SLyp9xiexxNfV0nOnjQ5RSsuih55xCpjWHW
	8Hr8q0EZyZWZ+nUTfKtvp1RI2d/W3itw7FyGfbDF3XoU1eANFFzD6bMIh9+qQIIg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawd8ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:44:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LAdBvx012570;
	Thu, 21 May 2026 10:44:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kybcht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:44:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LAi1h914025166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 10:44:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE83220043;
	Thu, 21 May 2026 10:44:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B12120040;
	Thu, 21 May 2026 10:44:01 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 10:44:01 +0000 (GMT)
Message-ID: <cab20a39-6102-4e4d-b9d8-2daa79740f4c@linux.ibm.com>
Date: Thu, 21 May 2026 12:44:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/20] unwind_user/sframe: Wire up unwind_user to
 sframe
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260520154004.3845823-8-jremus@linux.ibm.com>
 <20260520162345.F13D61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520162345.F13D61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNSBTYWx0ZWRfX0jRx3K49UQ5+
 4fH21LO94AxV3oqjL06bU41zaPOkaXI16aJ4mq6iNYmwe3DOZOIvNMKCq5jdYI2ogdBExvRiMQC
 /Inea1zPnKGuLMCXFxK2DBr1fZYsuF3DCyz9OtzWaZ+LrGbnBMiMtRMZb3Kp3N5BqGon4MpH6Zp
 Dv/smxc0n53yI0/2alkeRIPqMyBBtgsoYAdWmL3MVxxNOmmj11hv947TcFQml/xG2vPBOQ1uiFI
 IOVpPLnTjQ/fg/mmVPjuOCFA4ISgYVLGp74f2rvRHEm7UZNOPLSNrnEunvA/XAQEOPXO67e/JM8
 yjv9VLkNSC5k5ZKUUQNzFcpuz2s3b0d6L2GlsAdWZ5KlyOfRtzS/z2laUjk44iVCRccXfHfZArS
 4yvV1Kt0/2sB5WeFUxlTbG6ahpNFsA5D8kFpN87KKbTdSJ07Vwjxw4471iQ+HHk9y7r5dXoYKty
 Xw3fJU3idxS4j2+XUvA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ee1f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qs5oOQeeBM0gd5hmpCAwXu4HbvN_lzLs
X-Proofpoint-GUID: qs5oOQeeBM0gd5hmpCAwXu4HbvN_lzLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210105

On 5/20/2026 6:23 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incorrect FRE size calculation completely breaks SFrame parsing for functions with multiple FREs.

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

