Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672086FD5
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086958; cv=none; b=QLJQJAv+myfHXbIIHNAHDKC9oPtbeEiDQOhRdLaJ/XqQAbVnEWZZzCIFhRZDwLhLDgvH+gs4hR6s7O+YsxKVrfz4a+ozlfSWdlRctUVjTjhBy+cglNL354ja8vNJFy9ZZBlYkIKEc1rbV7nKEHFTyHgasW8SqXgV3zj0uzkwXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086958; c=relaxed/simple;
	bh=qf53pXD0KpG/wg/qQ/+FcTLdi7YtNPSrLvhDVnk5nZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LqJn+4UnCnIUzRiHuulhYLs+hDPeRXsKXEmPllhBb1+S32mCdn09VzPYwW5VrPpbFBhl2NDkP/6ehGsaIJN+x+rAaF4Uak6TEARE+6T/HywVK3XVJBjWVJTi785tyg8sPTNBOfev9/hAM3rkmePxb7+6lQBPAkYZAS7kbQZvZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F4Ti+nPU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F4Ti+nPU"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M5pu4e024428;
	Fri, 22 Mar 2024 05:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ReCW8+iSGf3YF5JGZFslmCoaNb4aP0BjDwNpsh0Hbko=;
 b=F4Ti+nPUFa28wGRrXd7VsXSLZ2OKqbVNwFL5ao07brExrqbQ01hQAXqKRhChFgR37OsT
 YucrazRYsJuYuGo+UUWjWBSD27JhgOsmmQkEO4snWXfM9bKxdGQmfqSWUO268ASqTu0B
 FgnbZ6ahzwJcdJ3Z57DGK+HPNAD4eMNiJm6HSjaJ3AmI90/trJaD2GRKqbQvWPSQBZH9
 q1NnYxtKMMDRL0IDc9e3onqpdTKGhXt/Z6JSzUT1DXwN6wG8qFzItWyRgTnwm81M2trV
 yO20W4lzI9RopArCdW2rSzMZ/HYX0/L7mlC1j7HQAuKxf2EPLUOYTcI4tkea2KIu8x+y Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x11090c36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:55:29 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42M5tSvQ030311;
	Fri, 22 Mar 2024 05:55:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x11090c31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:55:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M5XbpT032065;
	Fri, 22 Mar 2024 05:55:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x16htuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:55:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42M5tNJw49283404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 05:55:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C64062004F;
	Fri, 22 Mar 2024 05:55:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 992B720043;
	Fri, 22 Mar 2024 05:55:21 +0000 (GMT)
Received: from [9.203.115.195] (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 05:55:21 +0000 (GMT)
Message-ID: <93119eb9-b96c-4da4-b504-5b6834de5698@linux.ibm.com>
Date: Fri, 22 Mar 2024 11:25:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>, Stanislav Fomichev <sdf@google.com>
References: <20240319080152.36987-1-hbathini@linux.ibm.com>
 <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 15KYviigpzAtUP-hxIyU0a7xMWulDpsh
X-Proofpoint-ORIG-GUID: lNZQ6tDaNd1qZ1G0YV3Fb8kGA2bx9wDM
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
 definitions=2024-03-22_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220038



On 20/03/24 4:26 am, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 1:02 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>> With [1], crash dump specific code is moved out of CONFIG_KEXEC_CORE
>> and placed under CONFIG_CRASH_DUMP, where it is more appropriate.
>> And since CONFIG_KEXEC & !CONFIG_CRASH_DUMP build option is supported
>> with that, it led to the below warning:
>>
>>    "WARN: resolve_btfids: unresolved symbol crash_kexec"
>>
>> Fix it by using the appropriate #ifdef.
>>
>> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
>>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")
> 
> I don't think either bpf or bpf-next have this commit just yet, so
> landing it in the bpf/bpf-next tree doesn't make much sense. It
> probably would be best to land it through the tree which does the
> CONFIG_KEXEC_CORE -> CONFIG_CRASH_DUMP change in kernel/Makefile.

Yeah, [1] patches were still not in bpf-next when I sent this v2.
Andrew, can you please consider pulling this via -mm tree if that
sounds more appropriate?

Thanks
Hari


> pw-bot: cr
> 
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> Changes in v2:
>> * Updated changelog.
>> * Added Fixes and Acked-by tags.
>>
>>
>>   kernel/bpf/helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index a89587859571..449b9a5d3fe3 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2548,7 +2548,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> -#ifdef CONFIG_KEXEC_CORE
>> +#ifdef CONFIG_CRASH_DUMP
>>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>>   #endif
>>   BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>> --
>> 2.44.0
>>
