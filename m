Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360B224CC
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710744769; cv=none; b=Wf+EOKi59rX1xf/vXdjLbguATsv+Av5HCy3x2Tq41NU4d1GaCPuHvIwC+vih8ENfYXnl8qIJ1ss2Ih8If5SmsQjcZO3tZ2Q7xT2cRepa4OFN9npkJnioO89wck/TGQq2ZzslVvC+bxyXQcLfSoOzNbSchjbObBJSzTfP6DmblBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710744769; c=relaxed/simple;
	bh=yxdZBur3RXI1tHCehG9yTM3UeiZQAxiXHkS9S9Ypyks=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQYrlFKDUH0YoFpjgc7J0Cyjt565rJ4lvzrwd0rovqNqSo+JjR4FCzvmZRW2QNaVdkWJC17OZnUswVSGPOPXUB/v2/+8UhWiJ2nHTO6ngBmmB/5Y+XsYerOIitscMuZQgHzigmBljPqAP2mdtcUU//r0GR9HDHI0l+Ax9YYP0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qU8TM/3w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qU8TM/3w"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42HHOPf5031422;
	Mon, 18 Mar 2024 06:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g3c0T6LTqQBYqI6X/TVyNEpofD8ODNwV/F0V9+oQF8c=;
 b=qU8TM/3wiKS0qBIq12A8t6gUZZgZQCu9fNaijHQfNtLHl7QCHhJ3CAyC7RudmCfl2Ove
 mo51NGPBgYChHvzlcZ89QzbDHjRp+/e9Mv3p9V5Wztc10HojaR85+lC/HqAiqPu8WtUE
 t5PM1uRyReJ2NEZLgB+97dfTDT5yIzl+qlANcFUxCzw5oajDespouHWIOAOT/T7XTPDW
 s2f4ut1f9tfZ5obzduthdUoiYL5eSjPaVoKbICYWaJMo5QpU56OuXl7sQHVhO3te1p7E
 STITVGfqQ0u7stLm2su/jnNF2Uj+fHDwciwxD1KHhI0vBAgOKHyULEGEiLIl054cFfka /w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ww5pngrh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 06:52:21 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42I6pWiD006696;
	Mon, 18 Mar 2024 06:52:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ww5pngrgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 06:52:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42I66pNO022186;
	Mon, 18 Mar 2024 06:52:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwprnq5vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 06:52:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42I6qFmF47514006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 06:52:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D54E02004B;
	Mon, 18 Mar 2024 06:52:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 474CA20043;
	Mon, 18 Mar 2024 06:52:14 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 06:52:13 +0000 (GMT)
Message-ID: <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
Date: Mon, 18 Mar 2024 12:22:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240209123520.778599-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DdRDyGsOzuXYcWyKrr6fhFgjNClhB0VL
X-Proofpoint-GUID: hyGP314cwRBepY81eig7QTqFsyOXuCbr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180050

Just checking on whether this will go via bpf or mm tree?

On 09/02/24 6:05 pm, Hari Bathini wrote:
> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> to the below warning:
> 
>    "WARN: resolve_btfids: unresolved symbol crash_kexec"
> 
> Fix it by using the appropriate #ifdef.
> 
> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>   kernel/bpf/helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4db1c658254c..e408d1115e26 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2545,7 +2545,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(generic_btf_ids)
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>   #endif
>   BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
