Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A1328B4B;
	Thu, 21 May 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350295; cv=none; b=aLHRsxmH2rP/ZnFNJU032V4eyowNMJrEY2gM6Ia3jACeS+M7DRby8wYE2S8/LMhfyQM0CnGIA3g8XVj+bW1lZSsijD6rndzVoeshBHSTGjBVEkQQ+vMqS8fTcmpdMG3tfOl/1jH5hI77GLEV8aFnHqwCNLHqJsTsz+7QSu7MIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350295; c=relaxed/simple;
	bh=Ov6jxIKewKd1ARWTUVnl8Cw1QCOSgHih4O4Lmu+c84Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7mMpVF6O74eVmlAKdbPEo/1hRN4pTS9TKSsZgRBYRyuvKbIknQcZYPL1HnDG0K383oUvi0+FL2yIPFmyagvORKU3FwIhBRS6F9KHGERJ5km45uSdOEaoIUo2MAAHC2lGV9BPyWVrXdTXDSEVPaUXD+Q3QdqSzrxgMuc6wYC5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r3meDvHM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r3meDvHM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L4higT4142334;
	Thu, 21 May 2026 07:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bKA3Kc
	mR/JR0FYYPWUumU6DSfuPXtBJ9xCavUXYBK/w=; b=r3meDvHM0a/tkLzh9FR+yT
	XtQuPG1GC13h1Pl9o1dAR/R12fCSPPo+qby6X5tV8tXOcqJTUIxdkiQNlPGsF4IL
	cZ7gtqRxk7FY3gWDr75V6qymwXXXLUCxgB6MlYkmijER7gLfANjq7D8BZRBZZHW+
	0SmQjEX3l8+6V1FmA9wfQ3HHSIXCSu+hheDVBSshSrcRP1ZkmyGGjrACB5YcdfLk
	m+9hCbu/G2/ciqwlFKmuWjeo5HU+nOlSoLvKAqOKxFQtUJSr+MYjmRSErn8b8PC2
	yxZHlMK8TbWNUZF8TYXTRW3bojJFjKuCVBK+HzS1Zs89UgYHSWVPTpBbkgz7WAmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8mkxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 07:58:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L7sSkZ004569;
	Thu, 21 May 2026 07:58:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkb2v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 07:58:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L7w9Z817760720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 07:58:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE7DA2004B;
	Thu, 21 May 2026 07:58:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E2B20043;
	Thu, 21 May 2026 07:58:09 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 07:58:09 +0000 (GMT)
Message-ID: <23bd6a43-47c9-469f-92e7-2ecec47de428@linux.ibm.com>
Date: Thu, 21 May 2026 09:58:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/20] unwind_user/sframe: Add support for reading
 .sframe headers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260520154004.3845823-3-jremus@linux.ibm.com>
 <20260520160253.C01E91F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260520160253.C01E91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA3MyBTYWx0ZWRfX2LFp9HXb06Al
 pSMlBNB1DQFukqgh4Vhxzywt4N671/c6VDZkzJCX/DAQDsBUBNuDMqmrN5qd0QHa4UOIDtwUy1U
 NZ4dbxEC2VzZJmRPH86JVN+BOqmX+qiVrusgosfWmFWX7RnLUfbsG+IMb73nVFBgbOdz8oP62oR
 zuumc99/Axr2XbfpvyucbxePJiTK1lbfrLsXsrOMa3z7QftNepn2JAqOIGD7oPcw00k/IGDCblv
 Zi9W/LwxsoosxOS8Q9NnpI3iR7UnEIdEkaq2+3DlN2szmca+EjVvA8JgQPeReClxpc7jTzoyieZ
 am9JAYKDHO3x45Nt7Y0lnlfMoXUDv7I0W1RutMU7rzMkaQS7a4kffMcEnX9txbP7e3Xr1v/0Om3
 u3kLsPgaHhsFDvE+2L/YD1KgdQbJAQIVJd0BVpBIQ7aqf0J9odu6fjevHOzNWlT6Y4R5K2jQp8O
 VGQr4DKiJqZ0MWLPD8g==
X-Proofpoint-GUID: VbffM5TLOyH9juS58VqyvfcdV_m7q2rR
X-Proofpoint-ORIG-GUID: VbffM5TLOyH9juS58VqyvfcdV_m7q2rR
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ebb15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Zg_fgM-7fzLk7_7bOdYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210073

On 5/20/2026 6:02 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Integer overflow in SFrame section offset and size calculations allows malformed headers to bypass bounds checks on 32-bit architectures.
Can be ignored.  SFrame only supports 64-bit architectures.  "[PATCH v15
05/20] unwind_user/sframe: Add support for reading .sframe contents"
therefore adds the following safeguard:

	BUILD_BUG_ON(!IS_ENABLED(CONFIG_64BIT));

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

