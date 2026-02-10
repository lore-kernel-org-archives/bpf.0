Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169B3328E1
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758666; cv=none; b=cEHxMKjMksztzc1y/x0HRrHDAA+0VUaVm9Xid9HU8XWwYS0xWKzeZqa2VDnQpubdB3s64Q6cAhoYcCpNWs3X/feyk2zHOsT1UhgwUiLaOrTyE+ecw8yKEG+VQ/UQQqB40BppNyjdnHZbnDLp3C5QLAkfhu+NvVncDcK4tVqLmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758666; c=relaxed/simple;
	bh=7E1B3JTzSlLDzTk96oLtHyqAOUZtpHG8qb0g0JmsMuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PP8Pd1p/9bBqPQ1xYWU0LxpznyPdx/t+yMyEjkOg2whPylx70chxKfJ51DSlXBhhbNQ4szbxFDBlFH+DlTbDAbSXytzdu1NcZ+Jk4kv/Ca+VE3Ep217Od7ftE0L+Kpbs0Y5SClZDxvjsHBp946CZrPdr4IhyESd4bp9MJyG/O6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MqHgmj7e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MqHgmj7e"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ACSZqw565607;
	Tue, 10 Feb 2026 21:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TYPnpv
	GxuYId0M4VsaM74R0G0ctCSUqDuqP/upMsptc=; b=MqHgmj7e1AjzAAtQfRN/P1
	stmeOB3roqzggM6jCpHmBvBKKsqFmM++GgG5dK6wjdoBf6es4QvU2l28OhZrWlTD
	zZYXIGUEgaDw82SbbcurN8FL8nbimov4fafAwJx1BI5lJqWQU9Is2Ic13WEkdWMD
	fjv21nAo2P7PuoFZ2vwaNfmozko8/HyMb/h2nplaE7uc7oQRQri/+Q41a1jATJNB
	pzF/0fCPCHEJRupUycphHAnNBAGCOG30X+3o9LP4GC30RAwa3tFRLG3aBlxcpTSM
	NTEhPtx7ACAnN+xmn7HQ4WsxYZ5e/Mz1+walJYVepJ3JpqbraUXsmEQ9Ix+xkMeg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wv633-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 21:23:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AJ5WSN019221;
	Tue, 10 Feb 2026 21:23:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk318w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 21:23:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61ALNt6936241880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 21:23:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71F4820043;
	Tue, 10 Feb 2026 21:23:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F2720040;
	Tue, 10 Feb 2026 21:23:55 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.60.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 21:23:54 +0000 (GMT)
Message-ID: <3748538c-9624-47eb-a060-9d35508c4f93@linux.ibm.com>
Date: Tue, 10 Feb 2026 22:23:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BPF CI] OOMs on s390x runners
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <8553c4ab-9b42-46a8-9187-38ba4f63fff0@linux.dev>
 <62cab7f1-06ea-434b-99e5-ba8b1a7d7eb5@linux.ibm.com>
 <019b0f02-d177-457f-89e2-96727ee48cff@linux.dev>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <019b0f02-d177-457f-89e2-96727ee48cff@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698ba1ed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=msg3acWZ7gUUhz7JZMcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hv-BuzbSdGqLHAsoSSyho9C-Ae7evN6l
X-Proofpoint-ORIG-GUID: hv-BuzbSdGqLHAsoSSyho9C-Ae7evN6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE3NiBTYWx0ZWRfXx6nYsZHiUNNs
 KOL/9P8iHweigPf2cRzoCIEwNLvxSkftL1b8w7YEmWwZzPjOOJAFsQPT1LuLooGmi694dCakzwg
 ZWh94fuAQjzm4Vo6Ba7YPeFXIfN1w80Zv7sWkIVFQuDcv5cyLfBUqO2uT4X1TWtHhZSZSZlOjs3
 8pme71tImZArN4EbXaVsshxZ0VTn6kDtn9+W/XFj/jkTTJT40FI4H/dnMkK5ilXsvSNnGGEvocO
 iqiX5bUm6BsWLvWWpGDib7nL7PevYfK+khk0Das0aouF3SEpvCdW/vKD5xkvql/d86VAGlT2Gj/
 AfaYFVUm4RA5FnZ96AXd1snozMupbJD4FD/YrL/gL/2uCzPeRKxs1QC0i+1IPjfjPGVEjIm4z4m
 Jn3gxyjPtrowXWl3xXupYUz3NCqGcy1FgJGjTAVTAkNK+Uvqol6C1u0Cngk8t4472Cr6KPrMTgF
 4UEMRaFk7Tx1ZKQcCkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100176


On 2/6/26 00:50, Ihor Solodrai wrote:
> On 1/21/26 2:56 PM, Ilya Leoshkevich wrote:
>> On 1/20/26 18:59, Ihor Solodrai wrote:
>>> Hi Ilya,
>>>
>>> The BPF selftests regularly fail on s390x runners with OOMs.
>>>
>>> The s390x hosts that I've been maintaining have 16G of memory, hosting
>>> 2 runners each. VMs (qemu instances) running the tests currently get
>>> 5G of memory each.
>>>
>>> I noticed that the s390x runners didn't have swap set up, so I added
>>> an ansible config to set up a swapfile. This seems to have helped with
>>> OOM failures.
>>>
>>> https://github.com/libbpf/ci/commit/8767dc05ab84c88da198af3c651511e731ddbac7
>>>
>>> I spot checked a couple of recent failures, and all of them happened
>>> on the "ebpf1-worker-*" runners that you've been maintaining IIRC.
>>> Here is a couple of examples:
>>>     - https://github.com/kernel-patches/bpf/actions/runs/21178791628/job/60916006746
>>>     - https://github.com/kernel-patches/bpf/actions/runs/21163448380/job/60863171062
>>>     - https://github.com/kernel-patches/bpf/actions/runs/21157785072/job/60846570064
>>>
>>> Could you please re-provision the hosts with the swap setup?
>>> Let's see if that helps.
>>>
>>> Thanks!
>> Hi Ihor,
>>
>>
>> Thanks for the scripts!
>>
>> I reprovisioned all 5 builders, everything looks healthy.
>>
>> I will check on them again tomorrow morning.
> Hi Ilya.
>
> We ended up disabling KASAN for s390x and that helped with OOMs.
>
> I noticed a couple "no space left on device" errors on your runners
> today, could you please take a look? Example:
>
> https://github.com/kernel-patches/bpf/actions/runs/21732338737/job/62690585484
>
> Thanks!
>
>>
>> Best regards,
>>
>> Ilya
>>

Hi Ihor,


Thanks for letting me know.

I deleted the unused volumes: actions-runner-kernel-patches-worker-02 
and actions-runner-kernel-patches-worker-03 from all builders.

Now there should be enough space on all of them.


Best regards,

Ilya

