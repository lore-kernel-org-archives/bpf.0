Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295313C5528;
	Fri, 22 May 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444677; cv=none; b=FNegMg4OhHkyjJoBcFsk2Ck5lErmNILdqrcjB26737cFA5/7TK/57XpBLMmHJMNxgQyyko5XMsajrmRLFlrUFMTT8/2X2+C0iWPNfOvYlfPJwJxsN0snmbroGlA9ipf11R0RBEOI5/wHS6Jc8ZSWeJDo6ue/RqIZMwbh6sln3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444677; c=relaxed/simple;
	bh=j0hJXg76RgnFzS295NKKvmDQm0+mL1uMk7/0c/shEIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifogB4IHP8XS0Dgqv9tpplGskXxfu+H/nu1vQQ97ff5i1ZQNumMWjvz8C38VnwZ7sYypcgDyDKakGzrAdfTESPX6sZbV+14mBwBI6Vi/zQ8a1TKWXsNq2LNx8Tfk2BM1+/M/yQYb1B7QzP9CwZIgHwQCB/LrVPVJsoLvJhCBOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RhhyWIZx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RhhyWIZx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LNFqXI825954;
	Fri, 22 May 2026 10:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fwqjrO
	QPV5NPSnJ8c1U8hOZyyX3DlJK24dxredZvZ0A=; b=RhhyWIZx8xP9HA/CWsLxXE
	auwjCkkxDkPCeXpL8+FJ5XzWSBBHw6WAoJYukPgq7DmnJvnvkd7xulegh/UqCY8P
	AxK0p6+dDnfSLIV93WC3WjInpU1enIc1XXatnSrjjrjFvBV0ljJ3c/xDO1iQ3b99
	S8PpyEGERzYDUTjugU1f+iedOKdZGFDjnbll1jl/Q6GRRJ1iHHD9aQCkkiYjeZH4
	Y0txu5/mk4HRuRjD3uU6bLqYKB0SI7by3jjna+XKkh/4fPvZlQNi8bLN/0fQhyR5
	VGfnD+iFdC0jCP/LyKLGT1biGG3Bj+uWNJFUT+bPEBDJ+4GNrjXqnbZnwhGi+TfQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75bd46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:11:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MA98Bk009360;
	Fri, 22 May 2026 10:11:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gr6rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:11:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MABCqd21103326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 10:11:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92CEF2004F;
	Fri, 22 May 2026 10:11:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5982004E;
	Fri, 22 May 2026 10:11:12 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 10:11:12 +0000 (GMT)
Message-ID: <de1a1783-2ead-4871-ac1e-1ad3ff80ed0f@linux.ibm.com>
Date: Fri, 22 May 2026 12:11:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/20] unwind_user/sframe: Add support for reading
 .sframe headers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260521142546.3908498-3-jremus@linux.ibm.com>
 <20260521145139.C85421F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521145139.C85421F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a102bc3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=xKMzfXZoI0ci_Dp4yuEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r-9_9Gu4e2u5RYFHgKsdQQJkYhBCbj6_
X-Proofpoint-GUID: r-9_9Gu4e2u5RYFHgKsdQQJkYhBCbj6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMCBTYWx0ZWRfX388ImntGyNBd
 Iqq4r64VwW079hUQ3BjILFO3/Gw+RqEi8KS6cC0K0YoBeXInPYQ4Lro9A3i+k9/juCRS++s4U4z
 e5Oxihtf+UbDVVg2MOnHilMWRuYiJb3d5tPxHRaPUbRYHEOz0GN/yPJ2WzoGKzq2eWdLi0BoFZy
 KgHsvsBOTsT5n5Caf8ugjHxHI+klOEaQCmHGXbrqNnGuap/D1yfYh+0cmvQEMAGBQA4U1uw4zTr
 gydDQ7gLvHgg/eJ+2Vs0JMwN00Z8xdQgAKFfHqQmb+zb/l2JqHoporvVI0pkNeVFgOl7nbvU1E8
 GeZ3zVGUyeJsWf16MSjW+w+Ojvvh6+nXJHnoCiwy1OcgDVcJSDi6nNgOx8Kgo9YHi1FiAubGbR5
 EFQX0z5PW4O+2ZyDEB/Y1PIO6WdeXHJyyU3YfBCVPabKb84ktLs83aO3wfiUCeDlcxQzDOAkQKz
 L20Xt5OLqDB+h2YpyKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220100

On 5/21/2026 4:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Calculations for sframe section boundaries lack overflow checks, allowing malformed headers to bypass bounds validation on 32-bit architectures.

SFrame only supports 64-bit architectures.  A BUILD_BUG_ON() is
introduced in "[PATCH v16 05/20] unwind_user/sframe: Add support
for reading .sframe contents".

I might move that to this patch in the next version to silence
this.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

