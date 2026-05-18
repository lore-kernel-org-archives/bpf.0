Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AD303CAE;
	Mon, 18 May 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117725; cv=none; b=KoTJkUI6QiG6erpYrusd17Z3w0Zq+QHHVuGDXcn1RcMftFZ6olMxq2sas3MdXGUfUy6u6ErHmxtBxyZBf3Yy/M9FiSwEnBlKdoNgDNxmfQCjSPdED5ezQlpgudvIbVMSl2zk8kPET9MaSd0S3+EyDYHt2r/ragp4AGDWblxF6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117725; c=relaxed/simple;
	bh=Bx/RqOuSExXx/+Nptr2e3aCphKTqL0knskqPy6v1UHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgcEW5HtLY7Qm77XbcR/fgW31xRcQZOZZGSpTBh7qPzmMhviQlZj5m/kMXnMvkDV6U5yGHfWn7hRSZQgGYlu6XqKiLkTMFSztZOgJ6CE0AKSeSUrW5gCV2OBgt+/InqwBfbWaR837KA/Kbpk1IxooAfsZsVNc0/GQYGJ1fi4kwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/PNmw8k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/PNmw8k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I9x9aC271835;
	Mon, 18 May 2026 15:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0dPt8a
	R10ao2ScNFB9ch8xlT0dn3qbG6bqX4wZjmiyU=; b=R/PNmw8kTxzt4FR7RLFG3B
	vIIToeKcBUO5xGiCoqvCMxveNY3n04DVEQD/tvzCs3/zpleXQKlCgh32EhU9hBRB
	MROMjXPb5jvpAgmBARvnG+8QcYPTg1Vb0QfdqjqZ7Q+KwHMoMjq4/ePgXg3tF+Tu
	KOoDlUkrQQpBVWRTNMqPMTMtus3A2JTGw3B15dSz3QGVILmYxNxQx/ZTxeppvSFh
	gUU2F14bkorTmivH62CqNLZxA+/AWPuCyawdJ9XMm9ntLInTx+ZJaph3lpmvMxVO
	IUnNtyCkQzr+S4tE5KY1BzBHTw2g2Fais1snRPk3jph2Zmt6n1uI7A7L94JFCCWg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74rskx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:22:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IF98E7014398;
	Mon, 18 May 2026 15:22:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjxg67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:21:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IFLwEL36897216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:21:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EED922004B;
	Mon, 18 May 2026 15:21:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AEF320040;
	Mon, 18 May 2026 15:21:57 +0000 (GMT)
Received: from [9.111.207.149] (unknown [9.111.207.149])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 15:21:57 +0000 (GMT)
Message-ID: <468c9a62-f5a5-4411-846a-15d595f25bf5@linux.ibm.com>
Date: Mon, 18 May 2026 17:22:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] unwind_user/sframe: Store .sframe section data
 in per-mm maple tree
To: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Indu Bhagat <ibhagatgnu@gmail.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20260505121718.3572346-4-jremus@linux.ibm.com>
 <20260505185158.39F35C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260505185158.39F35C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0b2e99 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=xPhrWWXr5758mneMkFAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: feB9fiDNIv659jX89xIsCz5pH1VuUxt_
X-Proofpoint-GUID: XyV20r5v1sdjme-XpmxV7O50Hz03irhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0OCBTYWx0ZWRfX0PXQfQNSGJJe
 Q3D3BSVuFTs7Aa6imwH1bqsndLHjyCboJf8zt4lRPf7ObTAVlIY3w14XdNyoPCoJrsKWDqrOQwj
 R706gp5WjvgS+Yn0KgyaivFBHnJXFGFc/a527i36R1zVWalLqS6N+WSLzJxqntzjICtr09+8UMn
 aWZEyCYEVSQZdvOWz4wAgCo7sKDO2CjQZuWtNXAVH5D0pDT2XG3aDHuUdgyUQ3o7zDw6hcd7ekK
 9yVElH48e9k6tRnmXOr8JywrBy6toVOPqPbs675MPFdOmYvKFfWtixHIbkGuk8j/jp03YRAt8IZ
 OCxfPKcmLxqgk4ZzjlK8cK0KuipV9SsxoP8XjZTTWyqkxEURy10lMkeUCN5szf75UhByj/UaBDe
 LQamEv6luBBKBzZpW+LHq9ytfLr/cSPHOELNq0OgonSgHfjuzaB0XIoOoosp9DMh+NupyA/0sfD
 WrIgKWu6twg4SUUMXHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180148

On 5/5/2026 8:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:

> - [High] Unbounded memory leak of sframe_section allocations leading to Denial of Service (OOM)

> --
> 
> commit 3b41045a6b38a262cb32acf9ed118e4d667448dd
> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> unwind_user/sframe: Store .sframe section data in per-mm maple tree
> 
> Associate an .sframe section with its mm by adding it to a per-mm maple
> tree which is indexed by the corresponding text address range. A single
> .sframe section can be associated with multiple text ranges.
> 

>> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
>> index c128c1eeaca20..fdb2a49085638 100644
>> --- a/kernel/unwind/sframe.c
>> +++ b/kernel/unwind/sframe.c
> [ ... ]
>> @@ -81,6 +81,7 @@ static int sframe_read_header(struct sframe_section *sec)
>>  int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>>  		       unsigned long text_start, unsigned long text_end)
>>  {

> [ ... ]
>>  		}
>>  	}
>>  
>>  	sec = kzalloc(sizeof(*sec), GFP_KERNEL);

Replace with the following to resolve below issue:

	sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);

> 
> This allocates the section with GFP_KERNEL instead of GFP_KERNEL_ACCOUNT,
> which bypasses memory cgroup limits.

Documentation/core-api/memory-allocation.rst states:

* Untrusted allocations triggered from userspace should be a subject
  of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
  is the handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``
  allocations that should be accounted.

Additionally I verified that a user space program can register a forged
.sframe section for every byte of a mmap'ed area to trigger the OOM
killer.  Using cgroup memory and swap limits I can see a difference in
behavior between GFP_KERNEL and GFP_KERNEL_ACCOUNT on my s390 test
system:

# cgcreate -g "memory:test_group" -t root:root
# cgset -r memory.max=1G "test_group"
# cgset -r memory.swap.max=3G "test_group"


Kernel with unwind user sframe using GFP_KERNEL:

# time cgexec -g "memory:test_group" ~/test/malicious-sframe/sframe_test 1000000
...
Killed                     cgexec -g "memory:test_group" ~/test/malicious-sframe/sframe_test 1000000

real    0m21.106s
user    0m0.700s
sys     0m20.305s


Kernel with unwind user sframe using GFP_KERNEL_ACCOUNT:

# time cgexec -g "memory:test_group" ~/test/malicious-sframe/sframe_test 1000000
...
Killed                     cgexec -g "memory:test_group" ~/test/malicious-sframe/sframe_test 1000000

real    0m3.566s
user    0m0.295s
sys     0m3.248s


Running the following in parallel to monitor the cgroup memory usage:
# watch -n1 cat /sys/fs/cgroup/test_group/memory.stat
shows that in case of GFP_KERNEL the value for "kernel" bumps to a high
value and stays there whereas in case of GFP_KERNEL_ACCOUNT it continues
to increase.

> 
> Furthermore, is there a mechanism to clean up these allocated sections when
> the corresponding VMA is torn down (e.g., via munmap)? Without cleanup hooks
> in the VMA teardown paths, it looks like an application could repeatedly mmap
> an executable region, register it here, and munmap it, leaking kernel memory
> and maple tree nodes indefinitely.

IIUC this is already being taken care of the change in __mmdrop() to
call sframe_free_mm(mm), which is part of this patch.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

