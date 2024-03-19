Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4A50249
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835628; cv=none; b=TZirG3jS9RZaBiJMIFUSVdj5oHc4TF4imD6BT3lKPrT2+ZZnQfUsHCDhkb/EcsIjDPvQMldwOHlxuYP9Dl6bJHEMw0+6+TwaJQgzL7WG/SLPQkc+jFVpc0xYAlNihfL8a4rVZedRLktytc2k/l7qPp9doW/32JjVgeO792uxNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835628; c=relaxed/simple;
	bh=TE5bJWRL6XC5awzqR2rJ4F/GGAzGb1VfzPLHmIbgYBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+83//+P1e/n/8GR+leKIR4YPrpcCcZ+1JQWRbyYkkG3QzmDoWnR944ulssCZo5jI8o4vWeLUhVEjCYGkzJ9JCjKmQPdJ+V7VzKIvS0k3uSWrfeT5+Gz0Zi/TDNNdTYSw/TaJySFhZak1P8oeYLdUfSsWIxSLkfdqz0YaQ+n//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K4TObAsR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K4TObAsR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J7bw7R024307;
	Tue, 19 Mar 2024 08:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=meKbA1jIgVYCDn8xMsDHn/LQNKxG9n2izLoUIEjV78E=;
 b=K4TObAsRyrsEhn3oCt9VgRg4Lwu1MnfknlHv13k82hmX4DdjqI1RcSbgUc32/iExZ//M
 tNhEAnLa6wAJpPFpxO0hEtxiQGiXtumFIVU1mdAAZwCbs7Oj3QL6sr3JJ4Z16Gcybf53
 Xf9B/hgWiScqdoDmRrfGb8Cx1/YvrB5TM+AqiP2hRzcNY1XsYyAE8WHxgyWMx65NR3Qd
 yqAeky2LapEz+NQM/2WNcKUfyng851R5poYeUupWDWW1Vor4Y/z7B5ggMK3Yij72fAt6
 UZaMwJxdCKsMVLHWQUhZS+ka350JNT7TqRP94tiZNUwOZckFAoZMciygzThNruKJidz1 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy6frg5v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:06:45 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42J82ouv010374;
	Tue, 19 Mar 2024 08:06:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy6frg5v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:06:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J6NEup019843;
	Tue, 19 Mar 2024 08:06:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykds7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 08:06:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42J86dsU49676742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 08:06:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E477C2004D;
	Tue, 19 Mar 2024 08:06:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C282004B;
	Tue, 19 Mar 2024 08:06:37 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 08:06:37 +0000 (GMT)
Message-ID: <47d1307a-807d-4824-8409-6c9ae30805d1@linux.ibm.com>
Date: Tue, 19 Mar 2024 13:36:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <6a1d94f7-b4bf-4315-b862-4e278abbaa73@linux.ibm.com>
 <4bcdd9cc-6149-490e-b3df-a39346e5035b@linux.dev>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <4bcdd9cc-6149-490e-b3df-a39346e5035b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DypgUhsNYXygQKlVs9k9Id1mRpPBoRFx
X-Proofpoint-ORIG-GUID: 2oIpGcS0zhF_VPRk3IXaQlAhqTSyO1OO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190062



On 18/03/24 9:43 pm, Yonghong Song wrote:
> 
> On 3/17/24 11:52 PM, Hari Bathini wrote:
>> Just checking on whether this will go via bpf or mm tree?
> 
> Sending to bpf-next should be okay.
> Could you resubmit the patch as CONFIG_CRASH_DUMP probably not
> available to bpf-next when you initially submitted the patch.

OK. Sent V2 with tags added and changelog updated:

 
https://lore.kernel.org/all/20240319080152.36987-1-hbathini@linux.ibm.com/

> 
>>
>> On 09/02/24 6:05 pm, Hari Bathini wrote:
>>> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
>>> to the below warning:
>>>
>>>    "WARN: resolve_btfids: unresolved symbol crash_kexec"
>>>
>>> Fix it by using the appropriate #ifdef.
>>>
>>> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> ---
>>>   kernel/bpf/helpers.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 4db1c658254c..e408d1115e26 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2545,7 +2545,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>>>   __bpf_kfunc_end_defs();
>>>     BTF_KFUNCS_START(generic_btf_ids)
>>> -#ifdef CONFIG_KEXEC_CORE
>>> +#ifdef CONFIG_CRASH_DUMP
>>>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>>>   #endif
>>>   BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>>
