Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D21205E26
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371282; cv=none; b=JSljGoVAgElRCalhCpJRqdON3PK2OsMmt65JgR5zwwFQ/qiAOGuuSUn+RTIqIqnD8CDEMcICBudEqhKkUFXkaqEZZPgO6esvhKoRJQ4K9FREEu5BN3nF6ZESKHcyKsWxc9rTyjCpOm9VPN1rOeBigmnQdRX6dX7VV6ZsSiV1+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371282; c=relaxed/simple;
	bh=CcS/kxsfajUasC+xWKvnCzA00pnD+22nBT7gj0Ko1js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0+BOgmU8a15CcBsI/QGe6mUiHtYQ+uFr1jxiqTN4NS7k9wpoOJa3UXeG/o69GBRaaOymGw4LnaKFl6pZxdibvODhNuD2SueD2qarnWS9XM0QDxEdy9PxfT6xduqg4n2bytoHIgTBSI0gjn2+a3yOf2Hjg/9FPUjm/X9iKfe/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZIq6LsEU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZIq6LsEU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HJ0FRR3501462;
	Tue, 17 Feb 2026 23:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PZAVOf
	FK5Emb48FAREiQ1gk/JpwXIXoPKzfBXir/I68=; b=ZIq6LsEU2zQTgyBA6/PEkM
	O36EXwbn10UTSfAcokEbqV3j80403/3jf/dc3Tl8fm+KtuGZzujnyA3MVCSpTf7X
	tuseg/871EZpWZj3MnJ1BXxMAojqnpWpWc/fvAv8CqjMcY0Oy5O2VsQwbdwFLN0S
	oLa6XJQ2vAVMnC9aX271QBJmDIB5wc9E6frWmaGZI87yh5Rkbo1b3SBumzHypXce
	yTdnnUPBfk1X690iq6/BkrBzScWvm9C6oUChGaPQ7TwSZYf/gOJYTT86EI0U2skN
	CuBodnzUVjpKqM+w+vTVvzovvOuRsH83laZwh8oD/RKuZf4foTxfmQkZEgiyvs1w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6461qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 23:34:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HLL4Tq017804;
	Tue, 17 Feb 2026 23:34:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28dpwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 23:34:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HNYMj735979614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 23:34:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135DC20040;
	Tue, 17 Feb 2026 23:34:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 830E120043;
	Tue, 17 Feb 2026 23:34:21 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.89.76])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 23:34:21 +0000 (GMT)
Message-ID: <b8b35dd7-fd17-4145-b81d-b58b466d9174@linux.ibm.com>
Date: Wed, 18 Feb 2026 00:34:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf/s390: Implement get_preempt_count()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260217160813.100855-1-iii@linux.ibm.com>
 <your-ad-here.call-01771350933-ext-9929@work.hours>
 <CAADnVQ+TB09AU3VTmjZ97xNFPG=3eOpoHut-dsnPSsJRLPPStg@mail.gmail.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <CAADnVQ+TB09AU3VTmjZ97xNFPG=3eOpoHut-dsnPSsJRLPPStg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jdKHfFpfE_V2Tg9KkgCMGeepwXhfDdoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE5MiBTYWx0ZWRfX9apv6G0NG9j7
 PNc+Ki6OyEakII3bD1XG/rHggsbmJpape5bQ1qxr75Qj9Dic4kgtVKNE93McKNlZyThPqKd8SwI
 pqDVIgUxT4G4Xqyi6EWkujG1Owbjh/u9Z396jQUQ/m6hS/vttk6lYxYVA6MIs9ljTZoPX7zAQ5L
 0+lJNmijZxoYoTBZetQMUlx5xPo32xvJQ/NgxQ7hdpDbsmvDI59LecERYrFLUVF/xeq2vpkTSif
 JGDr/7Vwg35j5+Xf3uEL8b9FMLcJTTa5D8+LQT2CG76Z5BgodH//UP0BxIp7ATUcEvYaEdF6RM4
 jN8OUvGPbjvLsOYIV3X6vpeE3IPXCnq7V/tWXUIUiKk8OiYhvH898cNoJewYWFH0DHmoN/QB2q7
 HhWvZNdPdmB5RzOv4DmSE0ggjG1r1R6ERSsW2b/sTKYJMqsha5r90MuktOr8+a7of+IcnnGswKg
 LaQaQdieKrTrwqAHg5g==
X-Proofpoint-GUID: kKFFhEJ6kYfQVlOg4-eFWAtd5g2OhPTE
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6994fb03 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=0cfurAl689Pog5GcEVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170192


On 2/17/26 20:32, Alexei Starovoitov wrote:
> On Tue, Feb 17, 2026 at 9:55 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>> On Tue, Feb 17, 2026 at 05:05:07PM +0100, Ilya Leoshkevich wrote:
>>> Hi,
>>>
>>> This series adds get_preempt_count() BPF implementation for s390.
>>> On s390 preempt_count lives in lowcore: a per-cpu data structure
>>> mapped at virtual address 0 or 0x70000 depending on the kernel
>>> command line.
>>>
>>> Patch 1 adds a kfunc to obtain lowcore address.
>>> Patch 2 is the implementation that delegates to it.
>> Hi Ilya,
>>
>> do we really want to expose bpf_get_lowcore() (full lowcore) to BPF just
>> to implement get_preempt_count()?
> I think there are no other options. For this and other cases.
> Like to inline bpf_get_smp_processor_id(), current_task, etc.
>
> arch/s390/kernel/bpf.c is a good place for such arch specific kfunc.
>
> I cannot really tell by looking at the implementation of get_lowcore(),
> but can this kfunc be marked as KF_FASTCALL to further improve performance?


I think so.

KF_FASTCALL will require inlining in the JIT, right?

Then bpf_get_preempt_count() might be a little bit better, because 
inlined bpf_get_lowcore() followed by preempt_count access will look 
like this:

     LGFI %r2,0x70000

     LY %r2,preempt_count(%r2)

and inlined bpf_s390_get_preempt_count() will be one instruction shorter:

     LY %r2,0x70000+preempt_count

Do you think it is worth the while pursuing this?

If yes, would it make sense to add an implementation delegating to 
preempt_count() to BPF common code and use it only for s390 for now?

