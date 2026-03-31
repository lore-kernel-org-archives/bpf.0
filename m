Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC05386551
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938195; cv=none; b=uq9U5HHNGxFQzocl0MRJJxeoYMKs2TRPyIBnyQ7Pu8vr/X0a3ASzEo7UGES3EQArvDLpI5SGU+YUz00BA3hH0rrhUtbCofg87dIUChFYX89D7IDQ3CUjPr81t6IzVriuzPH8xMjfeOcaHOl5hozU1ETxrAqjAta3Fcj/2tiABeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938195; c=relaxed/simple;
	bh=GQbosHDksI5IPO87T0vmE2fasMVfw07q3KLjq2Dfvxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP7EVWC91cYfGtxncR2znRXPLdE27YtzpEphmqjh067kCIvkvniEEdERyglTOSa2cwGeRMQpKxzZy24ZroKh3GIFkHVf+ESqDV/e0rK9dWLh7R1l9FMmZj3jWfKa4Vc/0Tkl6AI/27s663GsyRaDfjBoqEvuxnJOq8iFGjgwRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MZ9OCDka; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MZ9OCDka"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5xfrv4172385;
	Tue, 31 Mar 2026 06:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nVcJcr
	b9QAvHNHgWCJBPCQFKpe9Pljvg/E/JpzuID4Y=; b=MZ9OCDkaB5sWQJYSHjqA71
	JxjD2QmyTW0QBz8cWbBglpVqMiw5D1e3Hu5xVsA56JTsN+8X+lSLgbZPRnJ5Umv/
	LmzfyZc1xqfmYCxzY7LZyI9YA20f6Wcfkr5Ev9tC5A32MraZY/cHUi/f3YcD/UHg
	aeKrVezkOSTqQb4fk6L88M5tUJBcsCjRSlSTaIkTa+bF7LdkxlmXvkanjMlBZFdM
	v+CEIoiJuYEKdYTmcjeTCk/kE1SgMB6CHciTHRCQYbuodj197D/AJq+DD7/w6Jyk
	Ek3rRTHjH+YZgKaQrZJ+0R+VtupWrfX2xIVz37PLGvpInygLRgsQIAgKk4WwIDng
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc9hte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:22:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V2nv9X008698;
	Tue, 31 Mar 2026 06:22:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11fm0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:22:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V6MuiC19202584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 06:22:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B99995805A;
	Tue, 31 Mar 2026 06:22:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DF2158054;
	Tue, 31 Mar 2026 06:22:53 +0000 (GMT)
Received: from [9.123.12.79] (unknown [9.123.12.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 06:22:52 +0000 (GMT)
Message-ID: <da6749c5-f757-48ae-bdb7-3dc880bc189a@linux.ibm.com>
Date: Tue, 31 Mar 2026 11:52:51 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Fix block device hooks names
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <20260330210344.3073712-1-jolsa@kernel.org>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260330210344.3073712-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cb6842 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tQTjhWU2mxejCs3gip8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vOvA5gdKgZdX2NhqICi2U6J3rdN9x54P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA1OCBTYWx0ZWRfX+r2Mb54IYwGZ
 TTEGSvzwXlb+Mp7AEf0ZvVfmAsDTmJCUkBZnqjDcAskTGB9Zc76UmnBv2su0+NR2Taio2Sthtru
 UEnDozuJ+cd8I3IhPVdVvnmvBzrxCRlC4XNEYeNjeWR1bRy4KRpIQB/aTAd7xuhSrMU1ev9R6T7
 N+ic1i4af8PTEbsLnCHKTi3cOcfSQYgHbcIbpq0AvAihu8/v6S92PLZls6+dbExMFT3B82AM7NH
 x5HXctQEwLthMSv1kGH16ciXsb3IvrVnE7v7+BnBVE26+EnPuukt5lbxB024Ft6EPUrZCd57cUz
 4AZVB3EO1HAQhv4/dCvchiawboMglnJiA33gNc9bsnQMG282yijjAzphUWc8AzkswdYqH8qHDFw
 IXS7AArAnaot68uHlZWJcnzOMjGL0IyDXOiryXnFXwjaf1/u/3anGdJpzWw1mkWm5mdhPXSSIE5
 jtDx287/ZRKPm7gHtyA==
X-Proofpoint-ORIG-GUID: tTXOq9tLC41FH-Tj4D4QFp-B301O29Oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310058


On 31/03/26 2:33 am, Jiri Olsa wrote:
> Use proper names for block device hooks names.
>
> Cc: Christian Brauner <brauner@kernel.org>
> Fixes: 46df585fcff7 ("bpf: classify block device hooks appropriately")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/bpf/acrVKUy_EPiFFmV9@krava/T/#m7c7906a1ff4029e29185aec3266dbf5c8996dbf7
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

>   kernel/bpf/bpf_lsm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 119e3942cf5a..0e74325d96a6 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -383,7 +383,7 @@ BTF_ID(func, bpf_lsm_task_prctl)
>   BTF_ID(func, bpf_lsm_task_setscheduler)
>   BTF_ID(func, bpf_lsm_task_to_inode)
>   BTF_ID(func, bpf_lsm_userns_create)
> -BTF_ID(func, bpf_lsm_bdev_alloc)
> +BTF_ID(func, bpf_lsm_bdev_alloc_security)
>   BTF_ID(func, bpf_lsm_bdev_setintegrity)
>   BTF_SET_END(sleepable_lsm_hooks)
>   
> @@ -397,8 +397,8 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
>   BTF_ID(func, bpf_lsm_sk_free_security)
>   #endif /* CONFIG_SECURITY_NETWORK */
>   BTF_ID(func, bpf_lsm_task_free)
> -BTF_ID(func, bpf_lsm_bdev_alloc)
> -BTF_ID(func, bpf_lsm_bdev_free)
> +BTF_ID(func, bpf_lsm_bdev_alloc_security)
> +BTF_ID(func, bpf_lsm_bdev_free_security)
>   BTF_SET_END(untrusted_lsm_hooks)
>   
>   bool bpf_lsm_is_sleepable_hook(u32 btf_id)
