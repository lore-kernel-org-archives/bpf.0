Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E753A6B8E;
	Thu, 21 May 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360377; cv=none; b=okLmEc1hfSBO/iJG78UcPt3ph6qh6SRqJSgQGHN3JCtoqll//yPItqGKjpUorWiKbEwamfTT8cc4zeOTez/2kMV3ImlkUX3vX1xe989Qoz65l2GUeFmbrxDhKwXq8NHjqq1sGZKtO9d53afHwIS885MRK5pn9HUNvGxUaUku520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360377; c=relaxed/simple;
	bh=Jol6SkszgopveJT8xKdEvohw9FxXXpGMVgLhDKDiDU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+klFF7MXay+JwLg+SvX8NeParsjZ4wTViAZBgjCrVX1RvgqTdGTob5CecIYkTTiCd2hFFEdTGBQueqoLzfq8aqHk0Y0bB1VKJhy1JeAhLLoV3oT09QyD8hiGwUF8WuEsM5hF+WBtBzQK7K9PM/d/a49RIubGKqnQeiPz1Nwze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Akt3wkmm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Akt3wkmm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LAiQhu2191659;
	Thu, 21 May 2026 10:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=73Vnp4
	CjyO2kdwy0oYu+vOPCdQO/VUUsOhRFrhgUIUw=; b=Akt3wkmmqkdxfsbujxZima
	0q7v3+dnZgya99v7whfjUuaSredrUUkoi3MpGLKn+ArrHfKIeoueCsqrykU9f1wi
	wwp+38GU62oPpM041TcrRe99yKaj4UI/HB/tVm8fj1zMUzwb/brLDfkikRsFWkRO
	JzCX4GZ/ZZKG0pygNzLPV+6QOthKtGxIZm/GkVYkW/uDFNy92w4NhyAQ5dQhxKc+
	mlO3VtlR7WUICzDGR5UEEqHXiCocS/DBC6QOoe+/4aAbujfIDYmFRGZ8tKdbE1UY
	7HxBIN8074cknS2VLdDOisZi6AlvUlvBhAlXR2bKj+tOlVIGGVXA2dG7s3zu51ng
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawd8p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:46:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LAd8Ym006888;
	Thu, 21 May 2026 10:46:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhukam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 10:46:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LAkAUV47382844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 10:46:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 660042004B;
	Thu, 21 May 2026 10:46:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3529820043;
	Thu, 21 May 2026 10:46:10 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 10:46:10 +0000 (GMT)
Message-ID: <1f34161a-51e7-4665-8eb6-1e03643c97cf@linux.ibm.com>
Date: Thu, 21 May 2026 12:46:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/20] unwind_user/sframe: Add support for outermost
 frame indication
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260520154004.3845823-10-jremus@linux.ibm.com>
 <20260520160159.744321F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520160159.744321F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNSBTYWx0ZWRfXwWV6nwMyOECE
 TD/wKU6lmYBmfTBq4OF3Y4aszkOf0TX4K10/YPTC4g+BmFMVPtLr9LnoX7ZM/Kk184fniyPxW2M
 uMLxPPdgBd2+A9EW8/ckqMIYnz7VnIY+hVfss4wXnK3uvLmu6N2e0fGKMFr2suMeNqKwOTEbAcT
 si/dbaF//aMDzNZ4mW/8rGUX5q2q7d4tUvCWD+tTZ6Pa3Qz/2Uw+1pwdKPAE+DoCYVBFG3AC7gm
 X3/bgEovzXtjy/RgL4Pbypu8sSBzPOc5sKD2aTaQ/rQCLDvevArz6MPZ+gZjAYzsjXpzrAzWe0D
 cpYZcpssjnF6OPFpiHCjcu8ruuNhpQVYuUf5EVujbblR6Fk1/NFvoXMTrdcFti3hlzHoV+oMjXk
 o49NsIZ3piFZNFNLrSPsmzHudtfoq3EE2lYC8FKEErgfaeOSRiOLdyf9jEIKRfPTd65qkYift84
 QRE0+gN44jRgI1EfqRA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0ee275 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eL-AIAZEMyyGKKnMquFSgUOiChm_SexO
X-Proofpoint-GUID: eL-AIAZEMyyGKKnMquFSgUOiChm_SexO
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
> 
> Pre-existing issues:
> - [High] The size calculation for SFrame FRE evaluates to just the header size, incorrectly omitting the size of the datawords because it uses the mutated `dataword_count` variable.

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

